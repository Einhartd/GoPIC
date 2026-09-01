#!/bin/bash -l
#SBATCH --job-name=edupic_omp_stat
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:10:00

set -euo pipefail

# -----------------------------------------------------------------------------
# Konfiguracja OpenMP i przypięcia rdzeni (Affinity)
# -----------------------------------------------------------------------------
export OMP_NUM_THREADS=${OMP_THREADS:-${SLURM_CPUS_PER_TASK}}
export OMP_PROC_BIND=close
export OMP_PLACES=cores
export OMP_WAIT_POLICY=ACTIVE

export OMP_DISPLAY_AFFINITY=true
export OMP_AFFINITY_FORMAT=">> OpenMP Thread %0.2t/%0.2N -> Core: %A (Host: %H)"
# -----------------------------------------------------------------------------

N_CYCLES="${N_CYCLES:-100}"
USE_NC="${USE_NULL_COLLISION:-0}"
MEASURE_FLAG="${MEASUREMENT_MODE:-${MEASUREMENT:-0}}"
MEASURE_ARG=""
if [ "${MEASURE_FLAG}" = "1" ] || [ "${MEASURE_FLAG}" = "true" ] || [ "${MEASURE_FLAG}" = "m"] || [ "${MEASURE_FLAG}" = "M" ]; then
    MEASURE_ARG="m"
fi

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/C/parallel-only-omp"
BUILD_DIR="$HOME/GoPIC_build/C"
LOG_DIR="$(pwd)/saved_logs_C/logs_job_${SLURM_JOB_ID}_OMP_STAT"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${BUILD_DIR}" "${DATA_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "=== [C++ OpenMP STAT] Job: ${SLURM_JOB_ID} | Threads: ${OMP_NUM_THREADS} (Allocated Cores: ${SLURM_CPUS_PER_TASK}) | Cycles: ${N_CYCLES} | Measurement: ${MEASURE_ARG:-off} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
lscpu > "${LOG_DIR}/hardware_topology.txt" 2>&1

module purge && module load gcc

BINARY="${BUILD_DIR}/edupic_omp_${SLURM_JOB_ID}"
rm -f "${BINARY}"

echo ">> Kompilacja: C++ OpenMP (zoptymalizowany silnik Null-Collision)..."
g++ -std=c++17 -O3 -fno-omit-frame-pointer \
 -march=znver4 -mtune=znver4 \
 -ffast-math -funroll-loops \
 -mprefer-vector-width=512 \
 -fopenmp -fopenmp-simd \
 -fno-math-errno \
 -fopt-info-vec-optimized \
 "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm

# Znaczenie flag:
# -fno-omit-frame-pointer -> zachowuje wskaznik ramki stosu, zamiast uzywac go jako rejestru ogolnego przeznaczenia
#                            potrzebne do 'perf record'
# -march=znver4, -mtune=znver4 -> wymusza generowanie kodu maszynowego scisle pod architekture AMD Zen 4
# -mprefer-vector-width=512 -> Nakazuje kompilatorowi uzywanie pelnych 512-bitowych rejestrow wektorowych
# -ffast-math -> Zezwala na agresywne uproszczenia operacji zmiennoprzecinkowych
# -funroll-loops -> Automatycznie rozwija petle, ktorych liczbe iteracji kompilator jest w stanie oszacowac
# -fopenmp-simd -> Wlacza obsluge dyrektyw '#pragma omp simd' oraz '#pragma omp declare simd'
# -fno-math-errno -> Wylacza ustawianie globalnej zmiennej systemowej 'errno' po wywolaniach funkcji matematycznych
# -fopt-info-vec-optimized -> flaga diagnostyczna, podczas kompilacji wypisuje w logach zadania dokladne
#                             informacje o tym, ktore petle w ktorych liniach kodu zostaly pomyslnie
#                             zwektoryzowane do instrukcji SIMD

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
