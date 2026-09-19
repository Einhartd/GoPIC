#!/bin/bash -l
#SBATCH --job-name=gopic_exp_stat
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
# Brak GOAMD64=v4 (standardowy baseline x86-64), brak -ldflags="-s -w" (domyślny build)
REPO_DIR="${REPO_DIR:-$HOME/GoPIC}"
SRC_DIR="${REPO_DIR}/Go/1.experiment-baseline"
GO_BUILD_FLAGS=""

# --- Opcja: EKSPERYMENT 2 (Algorithmic Port: Null-Collision + zoptymalizowana matematyka) ---
# SRC_DIR="${REPO_DIR}/Go/2.algorithmic-port"
# GO_BUILD_FLAGS=""

# --- Opcja: EKSPERYMENT 3 (Zero-Allocation: eliminacja alokacji sterty w pętli) ---
# SRC_DIR="${REPO_DIR}/Go/3.zero-allocation"
# GO_BUILD_FLAGS=""

# --- Opcja: EKSPERYMENT 4 (BCE & Loop Unrolling + Strojenie architektury GOAMD64=v4) ---
# SRC_DIR="${REPO_DIR}/Go/4.bce-loop-unrolling"
# export GOAMD64=v4
# GO_BUILD_FLAGS="-ldflags=\"-s -w\""
# ==============================================================================

N_CYCLES="${N_CYCLES:-100}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go/logs_job_${SLURM_JOB_ID}_EXP_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Go Exp STAT] Job: ${SLURM_JOB_ID} | Threads: 1 (Allocated Cores: ${SLURM_CPUS_PER_TASK:-1}) | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
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
echo ">> Kompilacja: Go experiment (${SRC_DIR})..."
go build ${GO_BUILD_FLAGS} -o "${BINARY}" ./cmd/pic

if [ ! -f "${BINARY}" ]; then
    echo ">> BŁĄD: Kompilacja nie powiodła się, brak pliku ${BINARY}!"
    exit 1
fi

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Uruchamianie pomiaru perf stat..."
perf stat \
    -e task-clock,context-switches,cpu-migrations \
    -e cycles:u,instructions:u \
    -e L1-dcache-loads:u,L1-dcache-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    "${BINARY}" "${N_CYCLES}" ${MEASURE_ARG}

rm -f "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
