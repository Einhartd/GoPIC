#!/bin/bash -l
#SBATCH --job-name=gopic_exp_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

set -euo pipefail

export GOMAXPROCS=1

# ==============================================================================
# WYBÓR EKSPERYMENTU I FLAG KOMPILATORA GO
# ==============================================================================
# Domyślnie: EKSPERYMENT 1 (Czysty Baseline Direct MCC bez specjalistycznych flag)
# W wersji RECORD zachowujemy symbole debugowania (brak -ldflags="-s -w")
REPO_DIR="${REPO_DIR:-$HOME/GoPIC}"
SRC_DIR="${REPO_DIR}/Go/1.experiment-baseline"
GO_BUILD_FLAGS=""

# --- Opcja: EKSPERYMENT 2 (Algorithmic Port) ---
# SRC_DIR="${REPO_DIR}/Go/2.algorithmic-port"
# GO_BUILD_FLAGS=""

# --- Opcja: EKSPERYMENT 3 (Zero-Allocation) ---
# SRC_DIR="${REPO_DIR}/Go/3.zero-allocation"
# GO_BUILD_FLAGS=""

# --- Opcja: EKSPERYMENT 4 (BCE & Loop Unrolling + Strojenie architektury GOAMD64=v4) ---
# SRC_DIR="${REPO_DIR}/Go/4.bce-loop-unrolling"
# export GOAMD64=v4
# GO_BUILD_FLAGS=""
# ==============================================================================

N_CYCLES="${N_CYCLES_RECORD:-100}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go/logs_job_${SLURM_JOB_ID}_EXP_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"
FLAME_DIR="${REPO_DIR}/plots/FlameGraph"
[ ! -d "${FLAME_DIR}" ] && FLAME_DIR="$HOME/FlameGraph"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Go Exp RECORD] Job: ${SLURM_JOB_ID} | Threads: 1 (Allocated Cores: ${SLURM_CPUS_PER_TASK:-1}) | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
echo ">> Źródła: ${SRC_DIR}"
echo ">> Flagi budowania Go: ${GO_BUILD_FLAGS:-<domyślne>}"
echo ">> Architektura docelowa: GOAMD64=${GOAMD64:-<domyślna v1>}"

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

BINARY="${BUILD_DIR}/edupic_go_exp_${SLURM_JOB_ID}"
rm -f "${BINARY}"

cd "${SRC_DIR}"
echo ">> Kompilacja: Go experiment (${SRC_DIR}, debug symbols zachowane dla perf)..."
go build ${GO_BUILD_FLAGS} -o "${BINARY}" ./cmd/pic

if [ ! -f "${BINARY}" ]; then
    echo ">> BŁĄD: Kompilacja nie powiodła się, brak pliku ${BINARY}!"
    exit 1
fi

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Profilowanie wywołań (perf record)..."
perf record --max-size=100M -F 49 -g -o "${PERF_DATA}" -- "${BINARY}" "${N_CYCLES}" ${MEASURE_ARG}

echo ">> Generowanie raportu tekstowego perf report..."
perf report --stdio --no-children -i "${PERF_DATA}" > "${DATA_DIR}/perf_report.txt" 2>&1 || true

if [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ] && [ -f "${FLAME_DIR}/flamegraph.pl" ]; then
    echo ">> Generowanie wykresu Flame Graph..."
    perf script -i "${PERF_DATA}" 2>/dev/null | perl "${FLAME_DIR}/stackcollapse-perf.pl" > "${DATA_DIR}/perf.folded" 2>/dev/null || true
    perl "${FLAME_DIR}/flamegraph.pl" --title "Go Sequential Experiment (Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
    rm -f "${DATA_DIR}/perf.folded"
fi

rm -f "${PERF_DATA}" "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
