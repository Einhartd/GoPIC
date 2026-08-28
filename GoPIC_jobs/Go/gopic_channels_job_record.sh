#!/bin/bash -l
#SBATCH --job-name=gopic_chan_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:10:00

set -euo pipefail

# -----------------------------------------------------------------------------
# Konfiguracja Go (GOMAXPROCS) i liczby workerów
# -----------------------------------------------------------------------------
export GOMAXPROCS=${GOMAXPROCS:-${SLURM_CPUS_PER_TASK}}
NUM_WORKERS="${NUM_WORKERS:-$GOMAXPROCS}"
# -----------------------------------------------------------------------------
N_CYCLES="${N_CYCLES_RECORD:-100}"
USE_NC="${USE_NULL_COLLISION:-0}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/Go/parallel_channels"
BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go/logs_job_${SLURM_JOB_ID}_CHANNELS_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"
FLAME_DIR="$HOME/FlameGraph"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Go Channels RECORD] Job: ${SLURM_JOB_ID} | Cores: ${GOMAXPROCS} | Workers: ${NUM_WORKERS} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module load go || true

BINARY="${BUILD_DIR}/edupic_chan_${SLURM_JOB_ID}"
rm -f "${BINARY}"

cd "${SRC_DIR}"
if [ "${USE_NC}" = "1" ] || [ "${USE_NC}" = "true" ]; then
    echo ">> Kompilacja: Go Channels (Null-Collision)..."
    go build -tags nullcollision -o "${BINARY}" ./cmd/pic
else
    echo ">> Kompilacja: Go Channels (Standard MCC)..."
    go build -o "${BINARY}" ./cmd/pic
fi

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
    perl "${FLAME_DIR}/flamegraph.pl" --title "Go Channels (Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
fi

echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
