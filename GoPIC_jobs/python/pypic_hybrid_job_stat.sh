#!/bin/bash -l

#SBATCH --job-name=pypic_hybrid_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=2            # Liczba procesów MPI
#SBATCH --cpus-per-task=2      # Liczba wątków Numba na proces MPI
#SBATCH --time=04:00:00

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

# Konfiguracja środowiska hybrydowego MPI + Numba
export NUMBA_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=1

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_python/logs_job_${SLURM_JOB_ID}_HYBRID_STAT"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING HYBRID MPI+NUMBA STAT JOB WITH MPI TASKS: ${SLURM_NTASKS} AND NUMBA THREADS: ${NUMBA_NUM_THREADS}"
echo "========================================================"

PYTHON_VERSION_DIR="$HOME/GoPIC/python/hybrid_parallel"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"

if [ -f "$HOME/GoPIC/GoPIC_jobs/python/pypic.profile" ]; then
    echo ">> Wczytuję profil środowiska GoPIC..."
    source "$HOME/GoPIC/GoPIC_jobs/python/pypic.profile"
    module load openmpi || true
else
    echo ">> Błąd: plik pypic.profile nie został znaleziony!"
    exit 1
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision Hybrid] Wybrano wersję zoptymalizowaną (USE_NULL_COLLISION=true)"
    export USE_NULL_COLLISION="true"
else
    echo ">> [Standard Hybrid] Wybrano wersję klasyczną (USE_NULL_COLLISION=false)"
    export USE_NULL_COLLISION="false"
fi

export PYTHONPATH="${PYTHON_VERSION_DIR}:${PYTHONPATH}"

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"
{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba procesów MPI (ntasks): ${SLURM_NTASKS}"
    echo "Liczba wątków Numba na proces (cpus-per-task): ${NUMBA_NUM_THREADS}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${DATA_DIR}"

echo ">> Uruchamiam fazę inicjalizacji (krok 0)..."
mpirun -np "${SLURM_NTASKS}" python3 "${PYTHON_VERSION_DIR}/main.py" 0

echo ">> Uruchamianie pomiaru liczników sprzętowych (perf stat)..."
perf stat \
    -e cycles,instructions \
    -e L1-dcache-loads,L1-dcache-load-misses \
    -e branch-loads,branch-misses \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    mpirun -np "${SLURM_NTASKS}" python3 "${PYTHON_VERSION_DIR}/main.py" 1000 m

echo ">> Zadanie Python HYBRID STAT zakończone. Wyniki w: ${DATA_DIR}"
