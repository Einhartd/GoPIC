#!/bin/bash -l
#SBATCH --job-name=gopic_final_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00

set -euo pipefail

export GOMAXPROCS=${GOMAXPROCS:-${SLURM_CPUS_PER_TASK}}
NUM_WORKERS="${NUM_WORKERS:-$GOMAXPROCS}"
export GOAMD64="${GOAMD64:-v4}"

N_CYCLES="${N_CYCLES_RECORD:-100}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="${REPO_DIR:-$HOME/GoPIC}"
SRC_DIR="${REPO_DIR}/Go/final"
BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go_opt/logs_job_${SLURM_JOB_ID}_FINAL_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"
FLAME_DIR="${REPO_DIR}/plots/FlameGraph"
[ ! -d "${FLAME_DIR}" ] && FLAME_DIR="$HOME/FlameGraph"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Go Final RECORD] Job: ${SLURM_JOB_ID} | Threads: ${GOMAXPROCS} (Allocated Cores: ${SLURM_CPUS_PER_TASK:-1}) | Workers: ${NUM_WORKERS} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"

lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module load go || true
echo ">> Wersja kompilatora Go: $(go version 2>&1 || echo 'Brak go w module/PATH')"
echo ">> Docelowa architektura: GOAMD64=${GOAMD64}"

BINARY="${BUILD_DIR}/gopic_final_${SLURM_JOB_ID}"
rm -f "${BINARY}"

cd "${SRC_DIR}"
echo ">> Kompilacja: Go Final (StarBarrier, Loop Fusion, GOAMD64=${GOAMD64}, debug symbols zachowane dla perf)..."
go build -o "${BINARY}" ./cmd/pic

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Profilowanie wywołań (perf record)..."
perf record --max-size=100M -F 49 -g -o "${PERF_DATA}" -- "${BINARY}" --workers="${NUM_WORKERS}" "${N_CYCLES}" ${MEASURE_ARG}

perf report --stdio --no-children -i "${PERF_DATA}" > "${DATA_DIR}/perf_report.txt" 2>&1 || true

if [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ] && [ -f "${FLAME_DIR}/flamegraph.pl" ]; then
    perf script -i "${PERF_DATA}" 2>/dev/null | perl "${FLAME_DIR}/stackcollapse-perf.pl" > "${DATA_DIR}/perf.folded" 2>/dev/null || true
    perl "${FLAME_DIR}/flamegraph.pl" --title "Go Final (Workers ${NUM_WORKERS}, Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
    rm -f "${DATA_DIR}/perf.folded"
fi

rm -f "${PERF_DATA}" "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
