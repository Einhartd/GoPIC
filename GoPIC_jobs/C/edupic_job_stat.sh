#!/bin/bash -l

#SBATCH --job-name=edupic_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3:30:00
set -e

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_STAT"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

SOURCE_DIR="$HOME/GoPIC/eduPIC/C"
BUILD_DIR="$HOME/GoPIC_build/C"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"
mkdir -p "${BUILD_DIR}"

if [ ! -f "${SOURCE_DIR}/eduPIC.cc" ]; then
    echo "ERROR: Plik ${SOURCE_DIR}/eduPIC.cc nie istnieje!"
    exit 1
fi

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"

{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1


# Bezpieczna kompilacja (chroni przed kolizją, gdy 2 joby startują w tej samej sekundzie)
module load gcc
if [ ! -f "${BUILD_DIR}/edupic_c" ]; then
    echo ">> Kompiluję kod C++..."
    g++ -O3 -fno-omit-frame-pointer -march=native "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_c"
fi

cd "${DATA_DIR}"

echo ">> Uruchamiam fazę inicjalizacji..."
"${BUILD_DIR}/edupic_c" 0

echo ">> Uruchamianie pomiaru liczników sprzętowych (perf stat)..."
perf stat \
    -e cycles,instructions \
    -e L1-dcache-loads,L1-dcache-load-misses \
    -e LLC-loads,LLC-load-misses \
    -e branch-loads,branch-misses \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    "${BUILD_DIR}/edupic_c" 1000 m

echo ">> Zadanie STAT zakończone. Wyniki w: ${DATA_DIR}"