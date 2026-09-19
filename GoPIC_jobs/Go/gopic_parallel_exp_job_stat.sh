#!/bin/bash -l
#SBATCH --job-name=gopic_par_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:20:00

set -euo pipefail

# -----------------------------------------------------------------------------
# Konfiguracja Go (GOMAXPROCS), liczby workerów i architektury mikroprocesora
# -----------------------------------------------------------------------------
export GOMAXPROCS=${GOMAXPROCS:-${SLURM_CPUS_PER_TASK}}
NUM_WORKERS="${NUM_WORKERS:-$GOMAXPROCS}"
export GOAMD64="${GOAMD64:-v4}"

# ==============================================================================
# WYBÓR ETAPU ZRÓWNOLEGLENIA (PARALLEL_STEP = 1 .. 5)
# ==============================================================================
# PARALLEL_STEP=1 -> parallel-1-channels (Model CSP / kanały Go)
# PARALLEL_STEP=2 -> parallel-2-buffers-chunking (Współdzielenie pamięci, bufory L1d, sync.WaitGroup)
# PARALLEL_STEP=3 -> parallel-3-star-barrier (StarBarrier PAUSE spin, osobne fazy pchnięcia i granic)
# PARALLEL_STEP=4 -> parallel-4-boundary-compaction (Fuzja pętli Leap-Frog i granic, zero-barrier O(dead))
# PARALLEL_STEP=5 -> parallel-5-optimized-final (Pełna optymalizacja: 4-way unrolling, BCE, AVX-512)
# ==============================================================================
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
LOG_DIR="$(pwd)/saved_logs_Go/logs_job_${SLURM_JOB_ID}_PARALLEL_STEP${PARALLEL_STEP}_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

N_CYCLES="${N_CYCLES:-100}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

echo "=== [Go Parallel STAT] Job: ${SLURM_JOB_ID} | Step: ${PARALLEL_STEP} (${STEP_NAME}) | Threads: ${GOMAXPROCS} | Workers: ${NUM_WORKERS} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
echo ">> Katalog źródeł: ${SRC_DIR}"

AFFINITY_MASK=$(taskset -cp $$ 2>/dev/null | awk -F': ' '{print $2}' || grep -m1 Cpus_allowed_list /proc/self/status 2>/dev/null | awk '{print $2}' || echo "N/A")
echo ">> Przydział Slurm (Allocated Cores): ${SLURM_CPUS_PER_TASK:-1} rdzeni"
echo ">> Powinowactwo CPU zadania (Taskset / Cpus_allowed): ${AFFINITY_MASK}"
if command -v numactl >/dev/null 2>&1; then
    NUMA_BIND=$(numactl --show 2>/dev/null | grep -E 'physcpubind|cpubind' | tr '\n' ' ' || true)
    [ -n "${NUMA_BIND}" ] && echo ">> Powiązanie NUMA (numactl): ${NUMA_BIND}"
fi

lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module load go || true
echo ">> Wersja kompilatora Go: $(go version 2>&1 || echo 'Brak go w module/PATH')"
echo ">> Docelowa architektura: GOAMD64=${GOAMD64}"

BINARY="${BUILD_DIR}/${TARGET_BIN}_${SLURM_JOB_ID}"
rm -f "${BINARY}"

cd "${SRC_DIR}"
echo ">> Kompilacja etapu ${PARALLEL_STEP}..."
go build -ldflags="-s -w" -o "${BINARY}" ./cmd/pic

if [ ! -f "${BINARY}" ]; then
    echo ">> BŁĄD: Kompilacja nie powiodła się, brak pliku ${BINARY}!"
    exit 1
fi

cd "${DATA_DIR}"

# Zestaw liczników sprzętowych (IPC, L1d/L3 cache miss, migracje, branch miss, context switches)
PERF_EVENTS="task-clock,cycles,instructions,branches,branch-misses,L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses,context-switches,cpu-migrations"

echo ">> Start pomiarów: perf stat..."
CMD_ARGS=("${N_CYCLES}")
if [ -n "${MEASURE_ARG}" ]; then
    CMD_ARGS+=("${MEASURE_ARG}")
fi
CMD_ARGS+=("${NUM_WORKERS}")

perf stat -e "${PERF_EVENTS}" -r 3 \
    -o "${LOG_DIR}/perf_stat.log" -- \
    "${BINARY}" "${CMD_ARGS[@]}"

echo ">> Zakończono pomyślnie zadanie Slurm: ${SLURM_JOB_ID} (Etap ${PARALLEL_STEP}: ${STEP_NAME})"
