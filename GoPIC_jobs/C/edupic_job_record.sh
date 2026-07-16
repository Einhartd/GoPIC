#!/bin/bash -l

#SBATCH --job-name=edupic_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3:30:00

set -e

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_RECORD"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

# SOURCE_DIR="$HOME/GoPIC/eduPIC/C"
SOURCE_DIR="$HOME/GoPIC/C"
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


module load gcc
if [ ! -f "${BUILD_DIR}/edupic_c" ]; then
    echo ">> Kompiluję kod C++..."
    g++ -O3 -fno-omit-frame-pointer -march=native "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_c"
fi

cd "${DATA_DIR}"

echo ">> Uruchamiam fazę inicjalizacji..."
"${BUILD_DIR}/edupic_c" 0

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record)..."
#perf record -g -o "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" -- "${BUILD_DIR}/edupic_c" 1000 m
perf record -F 99 -g -o "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" -- "${BUILD_DIR}/edupic_c" 1000 m

echo ">> Konwertuję logi perf record do formatu tekstowego..."
perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" --stdio > "${DATA_DIR}/perf_report.txt"

echo ">> Zadanie RECORD zakończone. Wyniki w: ${DATA_DIR}"