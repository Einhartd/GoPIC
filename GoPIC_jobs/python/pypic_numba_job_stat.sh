#!/bin/bash -l

#SBATCH --job-name=pypic_numba_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12   # Zmień tę wartość, aby zmienić liczbę rdzeni przydzielonych do Numba
#SBATCH --time=04:00:00

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

# Pobranie liczby rdzeni z konfiguracji Slurma dla Numba
export NUMBA_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=1

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_python/logs_job_${SLURM_JOB_ID}_NUMBA_STAT"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING NUMBA PARALLEL STAT JOB WITH THREADS: ${NUMBA_NUM_THREADS}"
echo "========================================================"

PYTHON_VERSION_DIR="$HOME/GoPIC/python/numba_parallel"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"

if [ -f "$HOME/GoPIC/GoPIC_jobs/python/pypic.profile" ]; then
    echo ">> Wczytuję profil środowiska GoPIC..."
    source "$HOME/GoPIC/GoPIC_jobs/python/pypic.profile"
else
    echo ">> Błąd: plik pypic.profile nie został znaleziony!"
    exit 1
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision Numba] Wybrano wersję zoptymalizowaną (USE_NULL_COLLISION=true)"
    export USE_NULL_COLLISION="true"
else
    echo ">> [Standard Numba] Wybrano wersję klasyczną (USE_NULL_COLLISION=false)"
    export USE_NULL_COLLISION="false"
fi

export PYTHONPATH="${PYTHON_VERSION_DIR}:${PYTHONPATH}"

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"
{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba wątków Numba: ${NUMBA_NUM_THREADS}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${DATA_DIR}"

echo ">> Kopiuję stan początkowy (picdata.bin) z golden_record..."
cp "$HOME/GoPIC/golden_record/picdata.bin" ./picdata.bin

echo ">> Uruchamianie pomiaru liczników sprzętowych (perf stat) dla ${NUMBA_NUM_THREADS} wątków..."
perf stat \
    -e cycles:u,instructions:u \
    -e L1-dcache-loads:u,L1-dcache-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    python3 "${PYTHON_VERSION_DIR}/main.py" 100 m

echo ">> Zadanie Numba STAT zakończone. Wyniki w: ${DATA_DIR}"
