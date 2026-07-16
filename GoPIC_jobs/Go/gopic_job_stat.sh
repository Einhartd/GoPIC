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
LOG_DIR="${WORK_DIR}/saved_logs_Go/logs_job_${SLURM_JOB_ID}_STAT"
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

if [ ! -f "${BUILD_DIR}/edupic_go" ]; then
    echo ">> Kompiluję kod Go z ${SOURCE_DIR}..."
    cd "${SOURCE_DIR}"
    
    # 1. Automatyczna inicjalizacja modułu Go (tworzy plik go.mod)
    if [ ! -f "go.mod" ]; then
        echo ">> Brak pliku go.mod. Inicjalizuję nowy moduł Go..."
        go mod init edupic
    fi

    echo ">> Pobieram brakujące biblioteki (go mod tidy)..."
    go get github.com/seehuhn/mt19937
    go mod tidy
    
    # # Super-wskazówka dla AMD EPYC (Zen 4):
    # export GOAMD64=v4 
    
    # 2. POPRAWKA: Zmiana nazwy pliku wyjściowego z 'main' na 'edupic_go'
    go build -o "${BUILD_DIR}/edupic_go" .
    echo ">> Kompilacja Go zakończona."
fi

# Przejście do folderu roboczego
cd "${DATA_DIR}"

# -------------------------------------------------------------------
# INICJALIZACJA
# -------------------------------------------------------------------
if [ ! -f "picdata.bin" ]; then
    echo ">> Brak pliku picdata.bin. Uruchamiam fazę inicjalizacji..."
    "${BUILD_DIR}/edupic_go" 0
    echo ">> Inicjalizacja zakończona."
else
    echo ">> Znaleziono picdata.bin. Pomijam inicjalizację."
fi


perf stat \
    -e cycles,instructions \
    -e L1-dcache-loads,L1-dcache-load-misses \
    -e LLC-loads,LLC-load-misses \
    -e branch-loads,branch-misses \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    "${BUILD_DIR}/edupic_go" 1000 m

echo ">> Zadanie zakończone. Wszystkie dane i logi w: ${DATA_DIR}"