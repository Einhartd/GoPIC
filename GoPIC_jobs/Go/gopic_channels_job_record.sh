#!/bin/bash -l

#SBATCH --job-name=edupic_chan_go_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12   # Zmień tę wartość, aby zmienić liczbę rdzeni GOMAXPROCS
#SBATCH --time=00:30:00     # Skrócony czas (profilowanie 20 cykli trwa ok. 1-2 min)

set -e

# Ustawienie lokalnego katalogu tymczasowego dla OpenMPI / PRTE
export TMPDIR=/tmp

export GOMAXPROCS=$SLURM_CPUS_PER_TASK

# Liczba cykli symulacji dla perf record (20 cykli daje reprezentatywny profil przy pliku ~15-30 MB)
N_CYCLES_RECORD="${N_CYCLES_RECORD:-20}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_Go/logs_job_${SLURM_JOB_ID}_CHANNELS_RECORD"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING GO CHANNELS PARALLEL RECORD JOB WITH CORES: ${GOMAXPROCS}"
echo " CYCLES TO RECORD: ${N_CYCLES_RECORD}"
echo "========================================================"

SOURCE_DIR="$HOME/GoPIC/Go/parallel_channels"
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
    echo "Liczba cykli dla perf record: ${N_CYCLES_RECORD}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${SOURCE_DIR}"
module load go || true

echo ">> Kompiluję świeży kod Go Channels Parallel (wersja Standard)..."
go build -o "${BUILD_DIR}/edupic_tmp_chan_std_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_chan_std_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_chan_std"

echo ">> Kompiluję świeży kod Go Channels Parallel (wersja Null-Collision)..."
go build -tags nullcollision -o "${BUILD_DIR}/edupic_tmp_chan_nc_${SLURM_JOB_ID}" ./cmd/pic
mv "${BUILD_DIR}/edupic_tmp_chan_nc_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_go_chan_nc"

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision Channels] Wybrano wersję zoptymalizowaną"
    BINARY="${BUILD_DIR}/edupic_go_chan_nc"
else
    echo ">> [Standard Channels] Wybrano wersję klasyczną"
    BINARY="${BUILD_DIR}/edupic_go_chan_std"
fi

cd "${DATA_DIR}"
chmod +x "${BINARY}"

echo ">> Kopiuję stan początkowy (picdata.bin) z golden_record..."
cp "$HOME/GoPIC/golden_record/picdata.bin" ./picdata.bin

PERF_DATA_FILE="${SCRATCH:-${DATA_DIR}}/perf_${SLURM_JOB_ID}.data"

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) dla ${N_CYCLES_RECORD} cykli z GOMAXPROCS=${GOMAXPROCS}..."
echo ">> Plik surowego nagrania: ${PERF_DATA_FILE}"

perf record --max-size=100M -F 49 -g -o "${PERF_DATA_FILE}" -- "${BINARY}" "${N_CYCLES_RECORD}" m

echo ">> Konwertuję logi perf record do formatu tekstowego (raport ogólny)..."
perf report -i "${PERF_DATA_FILE}" --stdio > "${DATA_DIR}/perf_report.txt"

echo ">> Generowanie raportu w podziale na rdzenie CPU..."
perf report -i "${PERF_DATA_FILE}" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_per_cpu.txt"

echo ">> Generowanie raportu w podziale na wątki (threads)..."
perf report -i "${PERF_DATA_FILE}" --stdio --per-thread > "${DATA_DIR}/perf_report_per_thread.txt"

echo "========================================================"
echo " TOP 25 HOTSPOTS (Podsumowanie profilera):"
echo "========================================================"
perf report -i "${PERF_DATA_FILE}" --stdio --no-children --sort=comm,dso,symbol | head -n 35 || true

echo ">> Zadanie Go Channels RECORD zakończone sukcesem. Wyniki w: ${DATA_DIR}"
