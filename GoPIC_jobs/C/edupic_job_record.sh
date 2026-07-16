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
if [ ! -f "${BUILD_DIR}/edupic_c_std" ]; then
    echo ">> Kompiluję kod C++ (wersja Standard)..."
    g++ -O3 -fno-omit-frame-pointer -march=native "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_std_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_c_std"
fi

if [ ! -f "${BUILD_DIR}/edupic_c_nc" ]; then
    echo ">> Kompiluję kod C++ (wersja Null-Collision)..."
    g++ -O3 -fno-omit-frame-pointer -march=native -DUSE_NULL_COLLISION "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_nc_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_c_nc"
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_c_nc"
else
    echo ">> [Standard] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_c_std"
fi

cd "${DATA_DIR}"

# Zapewnienie uprawnień wykonywalnych dla binarium
chmod +x "${BINARY}"

echo ">> Uruchamiam fazę inicjalizacji..."
"${BINARY}" 0

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record)..."
perf record -F 99 -g -o "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" -- "${BINARY}" 1000 m

echo ">> Konwertuję logi perf record do formatu tekstowego..."
perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" --stdio > "${DATA_DIR}/perf_report.txt"

echo ">> Zadanie RECORD zakończone. Wyniki w: ${DATA_DIR}"