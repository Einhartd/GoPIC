#!/bin/bash -l

#SBATCH --job-name=edupic_hybrid_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=2            # Liczba procesów MPI
#SBATCH --cpus-per-task=2      # Liczba wątków OpenMP na proces MPI
#SBATCH --time=3:30:00

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

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

echo ">> Kopiuję stan początkowy (picdata.bin) z golden_record..."
cp "$HOME/GoPIC/golden_record/picdata.bin" ./picdata.bin

echo ">> Uruchamianie pomiaru liczników sprzętowych (perf stat) dla każdej rangi MPI z OMP_NUM_THREADS=${OMP_NUM_THREADS}..."
perf stat \
    -e cycles:u,instructions:u \
    -e L1-dcache-loads:u,L1-dcache-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    mpirun -np "${SLURM_NTASKS}" "${BINARY}" 100 m

echo ">> Zadanie HYBRID STAT zakończone. Wyniki w: ${DATA_DIR}"
