#!/bin/bash -l

#SBATCH --job-name=edupic_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00     # Skrócony czas (profilowanie 20 cykli trwa ok. 1-2 min)

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

# Liczba cykli symulacji dla perf record (20 cykli daje pełen, reprezentatywny profil przy pliku ~15 MB)
N_CYCLES_RECORD="${N_CYCLES_RECORD:-20}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_RECORD"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

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
    echo "Liczba cykli dla perf record: ${N_CYCLES_RECORD}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1


module purge
module load gcc

echo ">> Kompiluję świeży kod C++ (wersja Standard)..."
g++ -O3 -fno-omit-frame-pointer -march=native "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_std_${SLURM_JOB_ID}"
mv "${BUILD_DIR}/edupic_tmp_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_c_std"

echo ">> Kompiluję świeży kod C++ (wersja Null-Collision)..."
g++ -O3 -fno-omit-frame-pointer -march=native -DUSE_NULL_COLLISION "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_nc_${SLURM_JOB_ID}"
mv "${BUILD_DIR}/edupic_tmp_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_c_nc"

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

echo ">> Kopiuję stan początkowy (picdata.bin) z golden_record..."
cp "$HOME/GoPIC/golden_record/picdata.bin" ./picdata.bin

PERF_DATA_FILE="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) dla ${N_CYCLES_RECORD} cykli..."
perf record --max-size=100M -F 49 -g -o "${PERF_DATA_FILE}" -- "${BINARY}" "${N_CYCLES_RECORD}" m

echo ">> Konwertuję logi perf record do formatu tekstowego..."
perf report -i "${PERF_DATA_FILE}" --stdio > "${DATA_DIR}/perf_report.txt"

echo "========================================================"
echo " TOP 25 HOTSPOTS (Podsumowanie profilera):"
echo "========================================================"
perf report -i "${PERF_DATA_FILE}" --stdio --no-children --sort=comm,dso,symbol | head -n 35 || true

echo ">> Zadanie RECORD zakończone. Wyniki w: ${DATA_DIR}"
