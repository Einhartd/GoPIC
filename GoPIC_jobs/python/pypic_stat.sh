#!/bin/bash -l

#SBATCH --job-name=edupic_py_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6:30:00

set -e

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_python/logs_job_${SLURM_JOB_ID}_STAT"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1




#   WSKAZANIE WERSJI PYTHONA DO URUCHOMIENIA
PYTHON_VERSION_DIR="${WORK_DIR}/GoPIC/python/native_version"

# PYTHON_VERSION_DIR="${WORK_DIR}/GoPIC/python/numba_version"

#PYTHON_VERSION_DIR="${WORK_DIR}/GoPIC/python/numpy_version"







DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"

if [ -f "${WORK_DIR}/GoPIC_jobs/python/pypic.profile" ]; then
    echo ">> Wczytuję profil środowiska GoPIC..."
    source "${WORK_DIR}/GoPIC_jobs/python/pypic.profile"
else
    echo ">> Błąd: plik GoPIC_jobs/python/pypic.profile nie został znaleziony!"
    exit 1
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision] Wybrano wersję zoptymalizowaną (USE_NULL_COLLISION=true)"
    export USE_NULL_COLLISION="true"
else
    echo ">> [Standard] Wybrano wersję klasyczną (USE_NULL_COLLISION=false)"
    export USE_NULL_COLLISION="false"
fi

# Ustawienie PYTHONPATH, aby Python mógł importować moduły bez ich kopiowania
export PYTHONPATH="${PYTHON_VERSION_DIR}:${PYTHONPATH}"

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"
{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${DATA_DIR}"

echo ">> Uruchamiam fazę inicjalizacji..."
python3 "${PYTHON_VERSION_DIR}/main.py" 0

echo ">> Uruchamianie pomiaru liczników sprzętowych (perf stat)..."
perf stat \
    -e cycles,instructions \
    -e L1-dcache-loads,L1-dcache-load-misses \
    -e LLC-loads,LLC-load-misses \
    -e branch-loads,branch-misses \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    python3 "${PYTHON_VERSION_DIR}/main.py" 1000 m

echo ">> Zadanie Python STAT zakończone. Wyniki w: ${DATA_DIR}"
