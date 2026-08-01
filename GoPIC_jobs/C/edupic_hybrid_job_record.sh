#!/bin/bash -l

#SBATCH --job-name=edupic_hybrid_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=2            # Liczba procesów MPI
#SBATCH --cpus-per-task=2      # Liczba wątków OpenMP na proces MPI
#SBATCH --time=00:30:00        # Skrócony czas (profilowanie 20 cykli trwa ok. 1-2 min)

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

# Konfiguracja środowiska hybrydowego
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Liczba cykli symulacji dla perf record (20 cykli daje pełen, reprezentatywny profil przy plikach ~15-30 MB per rank)
N_CYCLES_RECORD="${N_CYCLES_RECORD:-20}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_HYBRID_RECORD"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING HYBRID RECORD JOB WITH MPI TASKS: ${SLURM_NTASKS} AND OMP THREADS: ${OMP_NUM_THREADS}"
echo " CYCLES TO RECORD: ${N_CYCLES_RECORD}"
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
    echo "Liczba cykli dla perf record: ${N_CYCLES_RECORD}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

module purge
module load openmpi

echo ">> Kompiluję świeży hybrydowy kod MPI+OpenMP (wersja Standard)..."
mpicxx -O3 -fno-omit-frame-pointer -march=native -fopenmp "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_hybrid_std_${SLURM_JOB_ID}"
mv "${BUILD_DIR}/edupic_tmp_hybrid_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_hybrid_c_std"

echo ">> Kompiluję świeży hybrydowy kod MPI+OpenMP (wersja Null-Collision)..."
mpicxx -O3 -fno-omit-frame-pointer -march=native -fopenmp -DUSE_NULL_COLLISION "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_hybrid_nc_${SLURM_JOB_ID}"
mv "${BUILD_DIR}/edupic_tmp_hybrid_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_hybrid_c_nc"

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

SCRATCH_BASE="${SCRATCH:-${DATA_DIR}}"

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) dla ${N_CYCLES_RECORD} cykli osobno dla każdej rangi MPI..."
mpirun -np "${SLURM_NTASKS}" bash -c "perf record --max-size=100M -F 49 -g -o ${SCRATCH_BASE}/perf_${SLURM_JOB_ID}_rank_\${OMPI_COMM_WORLD_RANK}.data -- ${BINARY} ${N_CYCLES_RECORD} m"

# Generowanie raportów per-rank
for r in $(seq 0 $((SLURM_NTASKS - 1))); do
    echo ">> Generuję raporty tekstowe dla rangi MPI ${r}..."
    PERF_RANK_FILE="${SCRATCH_BASE}/perf_${SLURM_JOB_ID}_rank_${r}.data"
    perf report -i "${PERF_RANK_FILE}" --stdio > "${DATA_DIR}/perf_report_rank_${r}.txt"
    perf report -i "${PERF_RANK_FILE}" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_rank_${r}_per_cpu.txt"
    perf report -i "${PERF_RANK_FILE}" --stdio --per-thread > "${DATA_DIR}/perf_report_rank_${r}_per_thread.txt"
    
    echo "========================================================"
    echo " TOP 25 HOTSPOTS (Ranga MPI ${r}):"
    echo "========================================================"
    perf report -i "${PERF_RANK_FILE}" --stdio --no-children --sort=comm,dso,symbol | head -n 35 || true
done

echo ">> Zadanie HYBRID RECORD zakończone. Wyniki w: ${DATA_DIR}"
