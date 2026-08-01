#!/bin/bash -l

#SBATCH --job-name=edupic_chunk_go_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12   # Zmień tę wartość, aby zmienić liczbę rdzeni GOMAXPROCS
#SBATCH --time=03:30:00

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

export GOMAXPROCS=$SLURM_CPUS_PER_TASK

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_Go/logs_job_${SLURM_JOB_ID}_CHUNKING_STAT"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING GO CHUNKING PARALLEL STAT JOB WITH CORES: ${GOMAXPROCS}"
echo "========================================================"

SOURCE_DIR="$HOME/GoPIC/Go/parallel_chunking"
BUILD_DIR="$HOME/GoPIC_build/Go"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"
mkdir -p "${BUILD_DIR}"

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "ERROR: Katalog ${SOURCE_DIR} nie istnieje!"
    exit 1
fi

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"
{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba przydzielonych rdzeni (GOMAXPROCS): ${GOMAXPROCS}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${SOURCE_DIR}"
module load go || true

echo ">> Kompiluję świeży kod Go Chunking Parallel (wersja Standard)..."
go build -o "${BUILD_DIR}/edupic_tmp_chunk_std_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_chunk_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_chunk_std"

echo ">> Kompiluję świeży kod Go Chunking Parallel (wersja Null-Collision)..."
go build -tags nullcollision -o "${BUILD_DIR}/edupic_tmp_chunk_nc_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_chunk_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_chunk_nc"

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision Chunking] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_go_chunk_nc"
else
    echo ">> [Standard Chunking] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_go_chunk_std"
fi

cd "${DATA_DIR}"
chmod +x "${BINARY}"

echo ">> Uruchamiam fazę inicjalizacji (krok 0)..."
"${BINARY}" 0

echo ">> Uruchamianie pomiaru liczników sprzętowych (perf stat) dla ${GOMAXPROCS} rdzeni..."
perf stat \
    -e cycles:u,instructions:u \
    -e L1-dcache-loads:u,L1-dcache-load-misses:u \
    -e branch-loads:u,branch-misses:u \
    -o "${DATA_DIR}/perf_cpu_stats.txt" \
    "${BINARY}" 1000 m

echo ">> Zadanie Go Chunking STAT zakończone. Wyniki w: ${DATA_DIR}"
