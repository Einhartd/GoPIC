#!/bin/bash -l
#SBATCH --job-name=pypic_seq_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:20:00

set -euo pipefail

N_CYCLES="${N_CYCLES_RECORD:-20}"
USE_NC="${USE_NULL_COLLISION:-0}"

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/python/native_version"
LOG_DIR="$(pwd)/saved_logs_python/logs_job_${SLURM_JOB_ID}_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"

mkdir -p "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Python Sequential RECORD] Job: ${SLURM_JOB_ID} | Cycles: ${N_CYCLES} | Node: ${SLURM_JOB_NODELIST} ==="
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

echo ">> Profilowanie wywołań (perf record)..."
perf record --max-size=100M -F 49 -g -o "${PERF_DATA}" -- python3 "${SRC_DIR}/main.py" "${N_CYCLES}" m

echo ">> Generowanie raportów tekstowych perf..."
perf report -i "${PERF_DATA}" --stdio > "${DATA_DIR}/perf_report.txt"

FLAME_DIR="${REPO_DIR}/plots/FlameGraph"
[ ! -d "${FLAME_DIR}" ] && FLAME_DIR="$HOME/FlameGraph"

if [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ] && [ -f "${FLAME_DIR}/flamegraph.pl" ]; then
    echo ">> Generowanie Flame Graph (SVG)..."
    perf script -i "${PERF_DATA}" | perl "${FLAME_DIR}/stackcollapse-perf.pl" > "${DATA_DIR}/perf.folded" 2>/dev/null || true
    perl "${FLAME_DIR}/flamegraph.pl" --title "Python Sequential (Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
fi

echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
