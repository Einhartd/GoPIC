#!/bin/bash -l
#SBATCH --job-name=edupic_c_seq_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

set -euo pipefail

N_CYCLES="${N_CYCLES:-100}"
USE_NC="${USE_NULL_COLLISION:-0}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/C/sequential"
BUILD_DIR="$HOME/GoPIC_build/C"
LOG_DIR="$(pwd)/saved_logs_C/logs_job_${SLURM_JOB_ID}_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [C++ Sequential STAT] Job: ${SLURM_JOB_ID} | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module purge && module load gcc

BINARY="${BUILD_DIR}/edupic_seq_${SLURM_JOB_ID}"
rm -f "${BINARY}"

if [ "${USE_NC}" = "1" ] || [ "${USE_NC}" = "true" ]; then
    echo ">> Kompilacja: C++ Sequential (Null-Collision)..."
    g++ -std=c++17 -O3 -fno-omit-frame-pointer -march=native -fno-math-errno -DUSE_NULL_COLLISION "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm
else
    echo ">> Kompilacja: C++ Sequential (Standard MCC)..."
    g++ -std=c++17 -O3 -fno-omit-frame-pointer -march=native -fno-math-errno "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm
fi

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
    -e LLC-loads:u,LLC-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    "${BINARY}" "${N_CYCLES}" ${MEASURE_ARG}

rm -f "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
