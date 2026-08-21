#!/bin/bash -l
#SBATCH --job-name=edupic_hyb_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:30:00

set -euo pipefail

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
N_CYCLES="${N_CYCLES:-100}"
USE_NC="${USE_NULL_COLLISION:-0}"

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/C/parallel-hybrid"
BUILD_DIR="$HOME/GoPIC_build/C"
LOG_DIR="$(pwd)/saved_logs_C/logs_job_${SLURM_JOB_ID}_HYBRID_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [C++ Hybrid STAT] Job: ${SLURM_JOB_ID} | MPI Tasks: ${SLURM_NTASKS} | OMP Threads: ${OMP_NUM_THREADS} | Cycles: ${N_CYCLES} ==="
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

echo ">> Uruchamianie pomiaru perf stat..."
perf stat \
    -e cycles:u,instructions:u \
    -e L1-dcache-loads:u,L1-dcache-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    mpirun --bind-to none -np "${SLURM_NTASKS}" "${BINARY}" "${N_CYCLES}"

rm -f "${BINARY}"
echo ">> Zakończono pomyślnie. Wyniki w: ${DATA_DIR}"
