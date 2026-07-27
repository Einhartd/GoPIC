#!/bin/bash -l

#SBATCH --job-name=edupic_hybrid_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=2            # Liczba procesów MPI
#SBATCH --cpus-per-task=2      # Liczba wątków OpenMP na proces MPI
#SBATCH --time=3:30:00

set -e

# Konfiguracja środowiska hybrydowego
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_HYBRID_RECORD"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING HYBRID JOB WITH MPI TASKS: ${SLURM_NTASKS} AND OMP THREADS: ${OMP_NUM_THREADS}"
echo "========================================================"

SOURCE_DIR="$HOME/GoPIC/C/parallel-hybrid"
BUILD_DIR="$HOME/GoPIC_build/C"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"
mkdir -p "${BUILD_DIR}"

if [ ! -f "${SOURCE_DIR}/eduPIC.cc" ]; then
    echo "ERROR: Plik ${SOURCE_DIR}/eduPIC.cc nie istnieje w ${SOURCE_DIR}!"
    exit 1
fi

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"

{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba procesów MPI (ntasks): ${SLURM_NTASKS}"
    echo "Liczba wątków OpenMP na proces (cpus-per-task): ${OMP_NUM_THREADS}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

module load gcc openmpi

if [ ! -f "${BUILD_DIR}/edupic_hybrid_c_std" ]; then
    echo ">> Kompiluję hybrydowy kod MPI+OpenMP (wersja Standard)..."
    mpicxx -O3 -fno-omit-frame-pointer -march=native -fopenmp "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_hybrid_std_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_hybrid_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_hybrid_c_std"
fi

if [ ! -f "${BUILD_DIR}/edupic_hybrid_c_nc" ]; then
    echo ">> Kompiluję hybrydowy kod MPI+OpenMP (wersja Null-Collision)..."
    mpicxx -O3 -fno-omit-frame-pointer -march=native -fopenmp -DUSE_NULL_COLLISION "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_hybrid_nc_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_hybrid_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_hybrid_c_nc"
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision Hybrid] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_hybrid_c_nc"
else
    echo ">> [Standard Hybrid] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_hybrid_c_std"
fi

cd "${DATA_DIR}"

# Zapewnienie uprawnień wykonywalnych dla binarium
chmod +x "${BINARY}"

echo ">> Uruchamiam fazę inicjalizacji..."
mpirun -np "${SLURM_NTASKS}" "${BINARY}" 0

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) osobno dla każdej rangi MPI..."
mpirun -np "${SLURM_NTASKS}" bash -c "perf record -F 99 -g -o ${DATA_DIR}/perf_${SLURM_JOB_ID}_rank_\${OMPI_COMM_WORLD_RANK}.data -- ${BINARY} 1000 m"

# Generowanie raportów per-rank
for r in $(seq 0 $((SLURM_NTASKS - 1))); do
    echo ">> Generuję raporty tekstowe dla rangi MPI ${r}..."
    perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}_rank_${r}.data" --stdio > "${DATA_DIR}/perf_report_rank_${r}.txt"
    perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}_rank_${r}.data" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_rank_${r}_per_cpu.txt"
    perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}_rank_${r}.data" --stdio --per-thread > "${DATA_DIR}/perf_report_rank_${r}_per_thread.txt"
done

echo ">> Zadanie HYBRID RECORD zakończone. Wyniki w: ${DATA_DIR}"
