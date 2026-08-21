#!/bin/bash -l
#SBATCH --job-name=gopic_seq_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

set -euo pipefail

export GOMAXPROCS=1
N_CYCLES="${N_CYCLES:-100}"
USE_NC="${USE_NULL_COLLISION:-0}"

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/Go/sequential"
BUILD_DIR="$HOME/GoPIC_build/Go"
LOG_DIR="$(pwd)/saved_logs_Go/logs_job_${SLURM_JOB_ID}_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [Go Sequential STAT] Job: ${SLURM_JOB_ID} | Cycles: ${N_CYCLES} | Node: ${SLURM_JOB_NODELIST} ==="
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module load go || true

BINARY="${BUILD_DIR}/edupic_seq_${SLURM_JOB_ID}"
cd "${SRC_DIR}"
if [ "${USE_NC}" = "1" ] || [ "${USE_NC}" = "true" ]; then
    echo ">> Kompilacja: Go Sequential (Null-Collision)..."
    go build -tags nullcollision -o "${BINARY}" ./cmd/pic
else
    echo ">> Kompilacja: Go Sequential (Standard MCC)..."
    go build -o "${BINARY}" ./cmd/pic
fi

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Uruchamianie pomiaru perf stat..."
perf stat \
    -e cycles:u,instructions:u \
    -e L1-dcache-loads:u,L1-dcache-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    "${BINARY}" "${N_CYCLES}"

rm -f "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
