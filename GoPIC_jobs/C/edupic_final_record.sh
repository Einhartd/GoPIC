#!/bin/bash -l
#SBATCH --job-name=edupic_final_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

set -euo pipefail

export OMP_NUM_THREADS=${OMP_THREADS:-${SLURM_CPUS_PER_TASK}}
export OMP_WAIT_POLICY=ACTIVE
export OMP_DISPLAY_AFFINITY=true
export OMP_AFFINITY_FORMAT=">> OpenMP Thread %0.2t/%0.2N -> Core: %A (Host: %H)"

N_CYCLES="${N_CYCLES_RECORD:-10}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="${REPO_DIR:-$HOME/GoPIC}"
SRC_DIR="${REPO_DIR}/C/final"
BUILD_DIR="$HOME/GoPIC_build/C"
LOG_DIR="$(pwd)/saved_logs_C/logs_job_${SLURM_JOB_ID}_FINAL_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"
FLAME_DIR="${REPO_DIR}/plots/FlameGraph"
[ ! -d "${FLAME_DIR}" ] && FLAME_DIR="$HOME/FlameGraph"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [C++ Final OpenMP RECORD] Job: ${SLURM_JOB_ID} | Threads: ${OMP_NUM_THREADS} (Allocated Cores: ${SLURM_CPUS_PER_TASK}) | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module purge && module load gcc
echo ">> Wersja kompilatora C++: $(g++ --version | head -n 1)"

BINARY="${BUILD_DIR}/edupic_final_${SLURM_JOB_ID}"
rm -f "${BINARY}"

g++ -std=c++17 -O3 -fno-omit-frame-pointer \
    -march=znver4 -mtune=znver4 \
    -ffast-math -funroll-loops \
    -mprefer-vector-width=512 \
    -fopenmp -fopenmp-simd \
    -fno-math-errno \
    -fopt-info-vec-optimized \
    -DPROFILE_RECORD \
    "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

perf record --max-size=100M -F 49 -g -o "${PERF_DATA}" -- "${BINARY}" "${N_CYCLES}" ${MEASURE_ARG}

perf report -i "${PERF_DATA}" --stdio > "${DATA_DIR}/perf_report.txt"
perf report -i "${PERF_DATA}" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_per_cpu.txt"

if [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ] && [ -f "${FLAME_DIR}/flamegraph.pl" ]; then
    perf script -i "${PERF_DATA}" | perl "${FLAME_DIR}/stackcollapse-perf.pl" > "${DATA_DIR}/perf.folded" 2>/dev/null || true
    perl "${FLAME_DIR}/flamegraph.pl" --title "C++ Final OpenMP (Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
    rm -f "${DATA_DIR}/perf.folded"
fi

rm -f "${PERF_DATA}" "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
