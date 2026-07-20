#!/bin/bash -l

#SBATCH --job-name=edupic_omp_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4   # Zmień tę wartość, aby zmienić liczbę rdzeni przydzielonych do joba
#SBATCH --time=3:30:00

set -e

# Pobranie liczby rdzeni z konfiguracji Slurma
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_OMP_RECORD"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING OPENMP JOB WITH CORES: ${OMP_NUM_THREADS}"
echo "========================================================"

SOURCE_DIR="$HOME/GoPIC/C/parallel-only-omp"
BUILD_DIR="$HOME/GoPIC_build/C"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"
mkdir -p "${BUILD_DIR}"

if [ ! -f "${SOURCE_DIR}/eduPIC.cc" ]; then
    echo "ERROR: Plik ${SOURCE_DIR}/eduPIC.cc nie istnieje w ${SOURCE_DIR}!"
    exit 1
fi

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"

{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba przydzielonych rdzeni: ${OMP_NUM_THREADS}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

module load gcc

if [ ! -f "${BUILD_DIR}/edupic_omp_c_std" ]; then
    echo ">> Kompiluję kod OpenMP C++ (wersja Standard)..."
    g++ -O3 -fno-omit-frame-pointer -march=native -fopenmp "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_omp_std_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_omp_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_omp_c_std"
fi

if [ ! -f "${BUILD_DIR}/edupic_omp_c_nc" ]; then
    echo ">> Kompiluję kod OpenMP C++ (wersja Null-Collision)..."
    g++ -O3 -fno-omit-frame-pointer -march=native -fopenmp -DUSE_NULL_COLLISION "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_omp_nc_${SLURM_JOB_ID}"
    mv "${BUILD_DIR}/edupic_tmp_omp_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_omp_c_nc"
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision OpenMP] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_omp_c_nc"
else
    echo ">> [Standard OpenMP] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_omp_c_std"
fi

cd "${DATA_DIR}"

# Zapewnienie uprawnień wykonywalnych dla binarium
chmod +x "${BINARY}"

echo ">> Uruchamiam fazę inicjalizacji..."
"${BINARY}" 0

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) z OMP_NUM_THREADS=${OMP_NUM_THREADS}..."
perf record -F 99 -g -o "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" -- "${BINARY}" 1000 m

echo ">> Konwertuję logi perf record do formatu tekstowego (raport ogólny)..."
perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" --stdio > "${DATA_DIR}/perf_report.txt"

echo ">> Generowanie raportu w podziale na rdzenie CPU..."
perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_per_cpu.txt"

echo ">> Generowanie raportu w podziale na wątki (threads)..."
perf report -i "${DATA_DIR}/perf_${SLURM_JOB_ID}.data" --stdio --per-thread > "${DATA_DIR}/perf_report_per_thread.txt"

echo ">> Zadanie OMP RECORD zakończone. Wyniki w: ${DATA_DIR}"
