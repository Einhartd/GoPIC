#!/bin/bash -l
#SBATCH --job-name=gopic_opt_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

set -euo pipefail

# -----------------------------------------------------------------------------
# Konfiguracja Go (GOMAXPROCS), liczby workerów i architektury mikroprocesora
# -----------------------------------------------------------------------------
export GOMAXPROCS=${GOMAXPROCS:-${SLURM_CPUS_PER_TASK}}
NUM_WORKERS="${NUM_WORKERS:-$GOMAXPROCS}"
export GOAMD64="${GOAMD64:-v4}"
# -----------------------------------------------------------------------------
N_CYCLES="${N_CYCLES:-100}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/Go/parallel_optimized"
BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go_opt/logs_job_${SLURM_JOB_ID}_OPTIMIZED_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Go Optimized STAT] Job: ${SLURM_JOB_ID} | Threads: ${GOMAXPROCS} (Allocated Cores: ${SLURM_CPUS_PER_TASK:-1}) | Workers: ${NUM_WORKERS} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"

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

BINARY="${BUILD_DIR}/edupic_opt_${SLURM_JOB_ID}"
rm -f "${BINARY}"

cd "${SRC_DIR}"
echo ">> Kompilacja: Go Optimized (StarBarrier, Loop Fusion, GOAMD64=${GOAMD64})..."
go build -ldflags="-s -w" -o "${BINARY}" ./cmd/pic

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
    "${BINARY}" --workers="${NUM_WORKERS}" "${N_CYCLES}" ${MEASURE_ARG}

rm -f "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
