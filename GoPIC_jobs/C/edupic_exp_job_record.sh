#!/bin/bash -l
#SBATCH --job-name=edupic_exp_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

set -euo pipefail

N_CYCLES="${N_CYCLES:-100}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="$HOME/GoPIC"

# ==============================================================================
# WYBÓR EKSPERYMENTU I FLAG KOMPILATORA
# ==============================================================================
# --- Opcja 1: EKSPERYMENT 1 (Baseline - Direct MCC, czysty punkt odniesienia T0) ---
SRC_DIR="${REPO_DIR}/C/1.experiment-baseline"
CXX_FLAGS="-std=c++17 -O3 -Wall -fno-math-errno -fno-omit-frame-pointer -g -DPROFILE_RECORD -fno-inline -fno-optimize-sibling-calls"

# --- Opcja 2: EKSPERYMENT 7 (Optymalizacje strukturalne: pusher fast-path, linear boundary compaction) ---
# SRC_DIR="${REPO_DIR}/C/7.experiment-pusher-boundaries"
# CXX_FLAGS="-std=c++17 -O3 -Wall -fno-math-errno -fno-omit-frame-pointer -g -DPROFILE_RECORD -fno-inline -ffast-math"

# --- Opcja 3: EKSPERYMENT 8 (Wektoryzacja SIMD AVX-512, alignas(64), unrolling, Zen 4 tuning) ---
# SRC_DIR="${REPO_DIR}/C/8.experiment-simd"
# CXX_FLAGS="-std=c++17 -O3 -Wall -fno-math-errno -fno-omit-frame-pointer -g -march=znver4 -mtune=znver4 -mprefer-vector-width=512 -funroll-loops -DPROFILE_RECORD -fno-inline -ffast-math -fopt-info-vec-optimized"
# ==============================================================================

BUILD_DIR="$HOME/GoPIC_build/C"
LOG_DIR="$(pwd)/saved_logs_C/logs_job_${SLURM_JOB_ID}_EXP_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"
FLAME_DIR="${REPO_DIR}/plots/FlameGraph"
[ ! -d "${FLAME_DIR}" ] && FLAME_DIR="$HOME/FlameGraph"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [C++ Exp RECORD] Job: ${SLURM_JOB_ID} | (Allocated Cores: ${SLURM_CPUS_PER_TASK}) | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
echo ">> Źródła: ${SRC_DIR}"
echo ">> Flagi CXX: ${CXX_FLAGS}"
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module purge && module load gcc
echo ">> Wersja kompilatora C++: $(g++ --version | head -n 1)"

BINARY="${BUILD_DIR}/edupic_exp_${SLURM_JOB_ID}"
rm -f "${BINARY}"

echo ">> Kompilacja: C++ experiment:"
g++ ${CXX_FLAGS} "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm


if [ ! -f "${BINARY}" ]; then
    echo ">> BŁĄD: Kompilacja nie powiodła się, brak pliku ${BINARY}!"
    exit 1
fi

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Profilowanie wywołań (perf record z DWARF call-graph)..."
perf record --max-size=1000M -F 99 --call-graph dwarf,8192 -o "${PERF_DATA}" -- "${BINARY}" "${N_CYCLES}" ${MEASURE_ARG}

echo ">> Generowanie raportów tekstowych perf..."
perf report -i "${PERF_DATA}" --stdio > "${DATA_DIR}/perf_report.txt"
perf report -i "${PERF_DATA}" --stdio --no-children --sort=dso,symbol > "${DATA_DIR}/perf_report_flat.txt"
perf report -i "${PERF_DATA}" --stdio --hierarchy > "${DATA_DIR}/perf_report_hierarchy.txt"

if [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ] && [ -f "${FLAME_DIR}/flamegraph.pl" ]; then
    echo ">> Generowanie Flame Graph (SVG)..."
    perf script -i "${PERF_DATA}" | perl "${FLAME_DIR}/stackcollapse-perf.pl" > "${DATA_DIR}/perf.folded" 2>/dev/null || true
    perl "${FLAME_DIR}/flamegraph.pl" --title "C++ experiment (Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
fi

echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
