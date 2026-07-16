#!/bin/bash -l

#SBATCH --job-name=edupic_seq_go
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6:00:00

set -e

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_Go/logs_job_${SLURM_JOB_ID}_RECORD"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

SOURCE_DIR="$HOME/GoPIC/Go"
BUILD_DIR="$HOME/GoPIC_build/Go"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"
mkdir -p "${BUILD_DIR}"

# Weryfikacja czy katalog źródłowy istnieje
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
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

# -------------------------------------------------------------------
# KOMPILACJA GO
# -------------------------------------------------------------------

cd "${SOURCE_DIR}"
if [ ! -f "go.mod" ]; then
    echo ">> Brak pliku go.mod. Inicjalizuję nowy moduł Go..."
    go mod init edupic
fi

echo ">> Pobieram brakujące biblioteki (go mod tidy)..."
go get github.com/seehuhn/mt19937
go mod tidy

export GOAMD64=v4 

if [ ! -f "${BUILD_DIR}/edupic_go_std" ]; then
    echo ">> Kompiluję kod Go (wersja Standard)..."
    go build -o "${BUILD_DIR}/edupic_go_std" .
fi

if [ ! -f "${BUILD_DIR}/edupic_go_nc" ]; then
    echo ">> Kompiluję kod Go (wersja Null-Collision)..."
    go build -tags nullcollision -o "${BUILD_DIR}/edupic_go_nc" .
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_go_nc"
else
    echo ">> [Standard] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_go_std"
fi

cd "${DATA_DIR}"

if [ ! -f "picdata.bin" ]; then
    echo ">> Brak pliku picdata.bin. Uruchamiam fazę inicjalizacji..."
    "${BINARY}" 0
    echo ">> Inicjalizacja zakończona."
else
    echo ">> Znaleziono picdata.bin. Pomijam inicjalizację."
fi

# -------------------------------------------------------------------
# WŁAŚCIWE SYMULACJE I PROFILOWANIE
# -------------------------------------------------------------------

perf record -F 99 -g -o "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" -- "${BINARY}" 1000 m

echo ">> Konwertuję logi perf record do formatu tekstowego..."
perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" --stdio > "${DATA_DIR}/perf_report.txt"

echo ">> Zadanie zakończone. Wszystkie dane i logi w: ${DATA_DIR}"