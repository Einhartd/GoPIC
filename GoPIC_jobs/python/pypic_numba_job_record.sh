#!/bin/bash -l

#SBATCH --job-name=pypic_numba_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12   # Zmień tę wartość, aby zmienić liczbę rdzeni przydzielonych do Numba
#SBATCH --time=00:30:00     # Skrócony czas (profilowanie 20 cykli trwa ok. 1-2 min)

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

# Pobranie liczby rdzeni z konfiguracji Slurma dla Numba
export NUMBA_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=1

# Liczba cykli symulacji dla perf record (20 cykli daje reprezentatywny profil przy pliku ~15-30 MB)
N_CYCLES_RECORD="${N_CYCLES_RECORD:-20}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_python/logs_job_${SLURM_JOB_ID}_NUMBA_RECORD"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING NUMBA PARALLEL RECORD JOB WITH THREADS: ${NUMBA_NUM_THREADS}"
echo " CYCLES TO RECORD: ${N_CYCLES_RECORD}"
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

# Wsparcie profilera perf dla funkcji Pythona i JIT Numba
export PYTHONPERFSUPPORT=1

export PYTHONPATH="${PYTHON_VERSION_DIR}:${PYTHONPATH}"

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"
{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba wątków Numba: ${NUMBA_NUM_THREADS}"
    echo "Liczba cykli dla perf record: ${N_CYCLES_RECORD}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${DATA_DIR}"

echo ">> Uruchamiam fazę inicjalizacji (krok 0)..."
python3 "${PYTHON_VERSION_DIR}/main.py" 0

PERF_DATA_FILE="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) dla ${N_CYCLES_RECORD} cykli z ${NUMBA_NUM_THREADS} wątkami..."
echo ">> Plik surowego nagrania: ${PERF_DATA_FILE}"

perf record --max-size=100M -F 49 -g -o "${PERF_DATA_FILE}" -- python3 "${PYTHON_VERSION_DIR}/main.py" "${N_CYCLES_RECORD}" m

echo ">> Konwertuję logi perf record do formatu tekstowego (raport ogólny)..."
perf report -i "${PERF_DATA_FILE}" --stdio > "${DATA_DIR}/perf_report.txt"

echo ">> Generowanie raportu w podziale na rdzenie CPU..."
perf report -i "${PERF_DATA_FILE}" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_per_cpu.txt"

echo ">> Generowanie raportu w podziale na wątki (threads)..."
perf report -i "${PERF_DATA_FILE}" --stdio --per-thread > "${DATA_DIR}/perf_report_per_thread.txt"

echo "========================================================"
echo " TOP 25 HOTSPOTS (Podsumowanie profilera):"
echo "========================================================"
perf report -i "${PERF_DATA_FILE}" --stdio --no-children --sort=comm,dso,symbol | head -n 35 || true

echo ">> Zadanie Numba RECORD zakończone sukcesem. Raporty w: ${DATA_DIR}"
