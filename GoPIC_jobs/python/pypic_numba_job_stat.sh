#!/bin/bash -l
#SBATCH --job-name=pypic_numba_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00

set -euo pipefail

export NUMBA_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OPENBLAS_NUM_THREADS=1
N_CYCLES="${N_CYCLES:-100}"
USE_NC="${USE_NULL_COLLISION:-0}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/python/numba_parallel"
LOG_DIR="$(pwd)/saved_logs_python/logs_job_${SLURM_JOB_ID}_NUMBA_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Python Numba STAT] Job: ${SLURM_JOB_ID} | Threads: ${NUMBA_NUM_THREADS} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

source "${REPO_DIR}/GoPIC_jobs/python/pypic.profile"

if [ "${USE_NC}" = "1" ] || [ "${USE_NC}" = "true" ]; then
    export USE_NULL_COLLISION="true"
else
    export USE_NULL_COLLISION="false"
fi

export PYTHONPATH="${SRC_DIR}:${PYTHONPATH:-}"

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Uruchamianie pomiaru perf stat..."
perf stat \
    -e cycles:u,instructions:u \
    -e L1-dcache-loads:u,L1-dcache-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    python3 "${SRC_DIR}/main.py" "${N_CYCLES}" ${MEASURE_ARG}

echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
