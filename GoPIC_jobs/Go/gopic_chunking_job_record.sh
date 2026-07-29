#!/bin/bash -l

#SBATCH --job-name=edupic_chunk_go_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12   # Zmień tę wartość, aby zmienić liczbę rdzeni GOMAXPROCS
#SBATCH --time=00:30:00     # Skrócony czas (profilowanie 20 cykli trwa ok. 1-2 min)

set -e

export GOMAXPROCS=$SLURM_CPUS_PER_TASK

# Liczba cykli symulacji dla perf record (20 cykli daje reprezentatywny profil przy pliku ~15-30 MB)
N_CYCLES_RECORD="${N_CYCLES_RECORD:-20}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_Go/logs_job_${SLURM_JOB_ID}_CHUNKING_RECORD"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING GO CHUNKING PARALLEL RECORD JOB WITH CORES: ${GOMAXPROCS}"
echo " CYCLES TO RECORD: ${N_CYCLES_RECORD}"
echo "========================================================"

SOURCE_DIR="$HOME/GoPIC/Go/parallel_chunking"
BUILD_DIR="$HOME/GoPIC_build/Go"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"
mkdir -p "${BUILD_DIR}"

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "ERROR: Katalog ${SOURCE_DIR} nie istnieje!"
    exit 1
fi

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"
{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba przydzielonych rdzeni (GOMAXPROCS): ${GOMAXPROCS}"
    echo "Liczba cykli dla perf record: ${N_CYCLES_RECORD}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${SOURCE_DIR}"
module load go || true

echo ">> Kompiluję świeży kod Go Chunking Parallel (wersja Standard)..."
go build -o "${BUILD_DIR}/edupic_tmp_chunk_std_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_chunk_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_chunk_std"

echo ">> Kompiluję świeży kod Go Chunking Parallel (wersja Null-Collision)..."
go build -tags nullcollision -o "${BUILD_DIR}/edupic_tmp_chunk_nc_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_chunk_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_chunk_nc"

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision Chunking] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_go_chunk_nc"
else
    echo ">> [Standard Chunking] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_go_chunk_std"
fi

cd "${DATA_DIR}"
chmod +x "${BINARY}"

echo ">> Uruchamiam fazę inicjalizacji (krok 0)..."
"${BINARY}" 0

PERF_DATA_FILE="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) dla ${N_CYCLES_RECORD} cykli z GOMAXPROCS=${GOMAXPROCS}..."
echo ">> Plik surowego nagrania: ${PERF_DATA_FILE}"

perf record --max-size=100M -F 49 -g -o "${PERF_DATA_FILE}" -- "${BINARY}" "${N_CYCLES_RECORD}" m

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

echo ">> Zadanie Go Chunking RECORD zakończone sukcesem. Wyniki w: ${DATA_DIR}"
