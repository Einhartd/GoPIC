#!/bin/bash -l
#SBATCH --job-name=gopic_par_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:15:00

set -euo pipefail

export GOMAXPROCS=${GOMAXPROCS:-${SLURM_CPUS_PER_TASK}}
NUM_WORKERS="${NUM_WORKERS:-$GOMAXPROCS}"
export GOAMD64="${GOAMD64:-v4}"

PARALLEL_STEP="${PARALLEL_STEP:-5}"
REPO_DIR="${REPO_DIR:-$HOME/GoPIC}"

case "${PARALLEL_STEP}" in
    1)
        STEP_NAME="parallel-1-channels"
        TARGET_BIN="edupic_channels"
        ;;
    2)
        STEP_NAME="parallel-2-buffers-chunking"
        TARGET_BIN="edupic_chunking"
        ;;
    3)
        STEP_NAME="parallel-3-star-barrier"
        TARGET_BIN="edupic_starbarrier"
        ;;
    4)
        STEP_NAME="parallel-4-boundary-compaction"
        TARGET_BIN="edupic_compaction"
        ;;
    5|*)
        STEP_NAME="parallel-5-optimized-final"
        TARGET_BIN="edupic_optimized"
        ;;
esac

SRC_DIR="${REPO_DIR}/Go/${STEP_NAME}"
BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go/logs_job_${SLURM_JOB_ID}_PARALLEL_STEP${PARALLEL_STEP}_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"
FLAME_DIR="${REPO_DIR}/plots/FlameGraph"
[ ! -d "${FLAME_DIR}" ] && FLAME_DIR="$HOME/FlameGraph"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

N_CYCLES="${N_CYCLES_RECORD:-20}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

echo "=== [Go Parallel RECORD] Job: ${SLURM_JOB_ID} | Step: ${PARALLEL_STEP} (${STEP_NAME}) | Threads: ${GOMAXPROCS} | Workers: ${NUM_WORKERS} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
echo ">> Katalog źródeł: ${SRC_DIR}"

AFFINITY_MASK=$(taskset -cp $$ 2>/dev/null | awk -F': ' '{print $2}' || grep -m1 Cpus_allowed_list /proc/self/status 2>/dev/null | awk '{print $2}' || echo "N/A")
echo ">> Przydział Slurm: ${SLURM_CPUS_PER_TASK:-1} rdzeni"
echo ">> Powinowactwo CPU: ${AFFINITY_MASK}"
if command -v numactl >/dev/null 2>&1; then
    NUMA_BIND=$(numactl --show 2>/dev/null | grep -E 'physcpubind|cpubind' | tr '\n' ' ' || true)
    [ -n "${NUMA_BIND}" ] && echo ">> Powiązanie NUMA: ${NUMA_BIND}"
fi

lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module load go || true
echo ">> Wersja kompilatora Go: $(go version 2>&1 || echo 'Brak go w module/PATH')"

BINARY="${BUILD_DIR}/${TARGET_BIN}_rec_${SLURM_JOB_ID}"
rm -f "${BINARY}"

cd "${SRC_DIR}"
echo ">> Kompilacja etapu ${PARALLEL_STEP} (z zachowaniem symboli debugowania dla perf)..."
go build -o "${BINARY}" ./cmd/pic

if [ ! -f "${BINARY}" ]; then
    echo ">> BŁĄD: Kompilacja nie powiodła się!"
    exit 1
fi

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

CMD_ARGS=("${N_CYCLES}")
if [ -n "${MEASURE_ARG}" ]; then
    CMD_ARGS+=("${MEASURE_ARG}")
fi
CMD_ARGS+=("--workers=${NUM_WORKERS}")

echo ">> Start profilera perf record (częstotliwość 997 Hz, call-graph dwarf)..."
perf record -F 997 --call-graph dwarf -o "${PERF_DATA}" -- \
    "${BINARY}" "${CMD_ARGS[@]}"

echo ">> Generowanie raportu tekstowego perf report..."
perf report -i "${PERF_DATA}" --stdio --no-children > "${LOG_DIR}/perf_report.txt" 2>&1 || true

if [ -d "${FLAME_DIR}" ] && [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ]; then
    echo ">> Generowanie Flame Graph..."
    perf script -i "${PERF_DATA}" | "${FLAME_DIR}/stackcollapse-perf.pl" > "${LOG_DIR}/out.folded" 2>/dev/null || true
    "${FLAME_DIR}/flamegraph.pl" "${LOG_DIR}/out.folded" > "${LOG_DIR}/flamegraph_${SLURM_JOB_ID}.svg" 2>/dev/null || true
    cp -f "${LOG_DIR}/flamegraph_${SLURM_JOB_ID}.svg" "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
fi

rm -f "${PERF_DATA}" "${BINARY}"
echo ">> Zakończono pomyślnie profilowanie zadania ${SLURM_JOB_ID}!"
