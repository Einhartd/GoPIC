#!/bin/bash -l

#SBATCH --job-name=edupic_hybrid_stat
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
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_HYBRID_STAT"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING HYBRID STAT JOB WITH MPI TASKS: ${SLURM_NTASKS} AND OMP THREADS: ${OMP_NUM_THREADS}"
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

echo ">> Uruchamianie pomiaru liczników sprzętowych (perf stat) dla każdego wątku na poszczególnych procesach MPI..."
mpirun -np "${SLURM_NTASKS}" bash -c "perf stat --per-thread \
    -e cycles,instructions \
    -e L1-dcache-loads,L1-dcache-load-misses \
    -e LLC-loads,LLC-load-misses \
    -e branch-loads,branch-misses \
    -o ${DATA_DIR}/perf_cpu_stats_rank_\${OMPI_COMM_WORLD_RANK}.txt \
    ${BINARY} 1000 m"

echo ">> Zadanie HYBRID STAT zakończone. Wyniki w: ${DATA_DIR}"
