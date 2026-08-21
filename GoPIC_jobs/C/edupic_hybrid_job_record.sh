#!/bin/bash -l
#SBATCH --job-name=edupic_hyb_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:10:00

set -euo pipefail

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
N_CYCLES="${N_CYCLES_RECORD:-20}"
USE_NC="${USE_NULL_COLLISION:-0}"

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/C/parallel-hybrid"
BUILD_DIR="$HOME/GoPIC_build/C"
LOG_DIR="$(pwd)/saved_logs_C/logs_job_${SLURM_JOB_ID}_HYBRID_RECORD"
DATA_DIR="${LOG_DIR}/edupic_data"
PERF_DATA="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [C++ Hybrid RECORD] Job: ${SLURM_JOB_ID} | MPI Tasks: ${SLURM_NTASKS} | OMP Threads: ${OMP_NUM_THREADS} | Cycles: ${N_CYCLES} ==="
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module purge && module load openmpi

BINARY="${BUILD_DIR}/edupic_hyb_${SLURM_JOB_ID}"
if [ "${USE_NC}" = "1" ] || [ "${USE_NC}" = "true" ]; then
    echo ">> Kompilacja: C++ Hybrid (Null-Collision)..."
    mpicxx -O3 -fno-omit-frame-pointer -march=native -fopenmp -DUSE_NULL_COLLISION "${SRC_DIR}/eduPIC.cc" -o "${BINARY}"
else
    echo ">> Kompilacja: C++ Hybrid (Standard MCC)..."
    mpicxx -O3 -fno-omit-frame-pointer -march=native -fopenmp "${SRC_DIR}/eduPIC.cc" -o "${BINARY}"
fi

cd "${DATA_DIR}"
cp "${REPO_DIR}/golden_record/picdata.bin" ./picdata.bin

echo ">> Profilowanie wywołań (perf record)..."
mpirun --bind-to none -np "${SLURM_NTASKS}" perf record --max-size=100M -F 49 -g -o "${PERF_DATA}" -- "${BINARY}" "${N_CYCLES}"

echo ">> Generowanie raportów tekstowych perf..."
perf report -i "${PERF_DATA}" --stdio > "${DATA_DIR}/perf_report.txt"

FLAME_DIR="${REPO_DIR}/plots/FlameGraph"
[ ! -d "${FLAME_DIR}" ] && FLAME_DIR="$HOME/FlameGraph"

if [ -f "${FLAME_DIR}/stackcollapse-perf.pl" ] && [ -f "${FLAME_DIR}/flamegraph.pl" ]; then
    echo ">> Generowanie Flame Graph (SVG)..."
    perf script -i "${PERF_DATA}" | perl "${FLAME_DIR}/stackcollapse-perf.pl" > "${DATA_DIR}/perf.folded" 2>/dev/null || true
    perl "${FLAME_DIR}/flamegraph.pl" --title "C++ Hybrid (Job ${SLURM_JOB_ID})" "${DATA_DIR}/perf.folded" > "${DATA_DIR}/flamegraph.svg" 2>/dev/null || true
fi

echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
