#!/bin/bash -l
#SBATCH --job-name=gopic_chunk_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:10:00

set -euo pipefail

# -----------------------------------------------------------------------------
# Konfiguracja Go (GOMAXPROCS), liczby workerów i architektury mikroprocesora
# -----------------------------------------------------------------------------
export GOMAXPROCS=${GOMAXPROCS:-${SLURM_CPUS_PER_TASK}}
NUM_WORKERS="${NUM_WORKERS:-$GOMAXPROCS}"
export GOAMD64="${GOAMD64:-v4}"
# -----------------------------------------------------------------------------
N_CYCLES="${N_CYCLES_RECORD:-100}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/Go/parallel_chunking"
BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go/logs_job_${SLURM_JOB_ID}_CHUNKING_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"
FLAME_DIR="$HOME/FlameGraph"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Go Chunking RECORD] Job: ${SLURM_JOB_ID} | Cores: ${GOMAXPROCS} | Workers: ${NUM_WORKERS} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module load go || true
echo ">> Wersja kompilatora Go: $(go version 2>&1 || echo 'Brak go w module/PATH')"
echo ">> Docelowa architektura: GOAMD64=${GOAMD64}"

BINARY="${BUILD_DIR}/edupic_chunk_${SLURM_JOB_ID}"
rm -f "${BINARY}"

cd "${SRC_DIR}"
echo ">> Kompilacja: Go Chunking (Null-Collision, GOAMD64=${GOAMD64}, debug symbols zachowane dla perf)..."
go build -o "${BINARY}" ./cmd/pic

if [ ! -f "${BINARY}" ]; then
    echo ">> BŁĄD: Kompilacja nie powiodła się, brak pliku ${BINARY}!"
    exit 1
fi

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Profilowanie wywołań (perf record)..."
perf record --max-size=100M -F 49 -g -o "${PERF_DATA}" -- "${BINARY}" --workers="${NUM_WORKERS}" "${N_CYCLES}" ${MEASURE_ARG}

echo ">> Generowanie raportów tekstowych perf..."
perf report -i "${PERF_DATA}" --stdio > "${DATA_DIR}/perf_report.txt"
perf report -i "${PERF_DATA}" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_per_cpu.txt"


if [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ] && [ -f "${FLAME_DIR}/flamegraph.pl" ]; then
    echo ">> Generowanie Flame Graph (SVG)..."
    perf script -i "${PERF_DATA}" | perl "${FLAME_DIR}/stackcollapse-perf.pl" > "${DATA_DIR}/perf.folded" 2>/dev/null || true
    perl "${FLAME_DIR}/flamegraph.pl" --title "Go Chunking (Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
fi

echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
