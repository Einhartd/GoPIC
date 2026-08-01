#!/bin/bash -l

#SBATCH --job-name=edupic_seq_go_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00     # Skrócony czas (profilowanie 20 cykli trwa ok. 1-2 min)

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

N_CYCLES_RECORD="${N_CYCLES_RECORD:-20}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_Go/logs_job_${SLURM_JOB_ID}_SEQ_RECORD"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

SOURCE_DIR="$HOME/GoPIC/Go/native_version"
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
    echo "Liczba cykli dla perf record: ${N_CYCLES_RECORD}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${SOURCE_DIR}"
module load go || true

echo ">> Kompiluję świeży kod Go Sequential (wersja Standard)..."
go build -o "${BUILD_DIR}/edupic_tmp_seq_std_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_seq_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_seq_std"

echo ">> Kompiluję świeży kod Go Sequential (wersja Null-Collision)..."
go build -tags nullcollision -o "${BUILD_DIR}/edupic_tmp_seq_nc_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_seq_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_seq_nc"

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_go_seq_nc"
else
    echo ">> [Standard] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_go_seq_std"
fi

cd "${DATA_DIR}"
chmod +x "${BINARY}"

echo ">> Uruchamiam fazę inicjalizacji (krok 0)..."
"${BINARY}" 0

PERF_DATA_FILE="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) dla ${N_CYCLES_RECORD} cykli..."
echo ">> Plik surowego nagrania: ${PERF_DATA_FILE}"

perf record --max-size=100M -F 49 -g -o "${PERF_DATA_FILE}" -- "${BINARY}" "${N_CYCLES_RECORD}" m

echo ">> Konwertuję logi perf record do formatu tekstowego..."
perf report -i "${PERF_DATA_FILE}" --stdio > "${DATA_DIR}/perf_report.txt"

echo "========================================================"
echo " TOP 25 HOTSPOTS (Podsumowanie profilera):"
echo "========================================================"
perf report -i "${PERF_DATA_FILE}" --stdio --no-children --sort=comm,dso,symbol | head -n 35 || true

echo ">> Zadanie Go Sequential RECORD zakończone sukcesem. Wyniki w: ${DATA_DIR}"