#!/bin/bash -l
#SBATCH --job-name=edupic_golden_5x
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00

set -euo pipefail

# -----------------------------------------------------------------------------
# Konfiguracja OpenMP i przypięcia rdzeni (Affinity)
# -----------------------------------------------------------------------------
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_WAIT_POLICY=ACTIVE

export OMP_DISPLAY_AFFINITY=true
export OMP_AFFINITY_FORMAT=">> OpenMP Thread %0.2t/%0.2N -> Core: %A (Host: %H)"
# -----------------------------------------------------------------------------

REPO_DIR="$HOME/GoPIC"
SRC_DIR="${REPO_DIR}/C/parallel-only-omp"
BUILD_DIR="$HOME/GoPIC_build/C"
WORK_DIR="$HOME/GoPIC_work/golden_5x_${SLURM_JOB_ID}"
OUTPUT_DIR="${REPO_DIR}/golden_record_5x"

mkdir -p "${BUILD_DIR}" "${WORK_DIR}" "${OUTPUT_DIR}"
exec > "${WORK_DIR}/golden_gen_${SLURM_JOB_ID}.log" 2>&1

echo "=== [C++ OpenMP Golden Record 5x Generation] Job: ${SLURM_JOB_ID} | Cores: ${SLURM_CPUS_PER_TASK} | Node: ${SLURM_JOB_NODELIST} ==="
echo ">> Ścieżka repo: ${REPO_DIR} | Commit: $(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
echo ">> Data rozpoczęcia: $(date)"

module purge && module load gcc
echo ">> Wersja kompilatora C++: $(g++ --version | head -n 1)"

BINARY="${BUILD_DIR}/edupic_omp_golden_${SLURM_JOB_ID}"
rm -f "${BINARY}"

echo ">> Kompilacja: C++ OpenMP pod architekturę AMD Zen 4 (AVX-512)..."
g++ -std=c++17 -O3 -fno-omit-frame-pointer \
 -march=znver4 -mtune=znver4 \
 -ffast-math -funroll-loops \
 -mprefer-vector-width=512 \
 -fopenmp -fopenmp-simd \
 -fno-math-errno \
 -fopt-info-vec-optimized \
 "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm

if [ ! -f "${BINARY}" ]; then
    echo ">> BŁĄD: Kompilacja nie powiodła się, brak pliku ${BINARY}!"
    exit 1
fi

cd "${WORK_DIR}"
rm -f picdata.bin conv.dat density.dat info.txt

# -----------------------------------------------------------------------------
# KROK 1: Inicjalizacja cząstek (cykl 0)
# -----------------------------------------------------------------------------
echo ">> KROK 1: Uruchamianie cyklu inicjalizacyjnego (./eduPIC 0)..."
START_INIT=$(date +%s)
"${BINARY}" 0
END_INIT=$(date +%s)
echo ">> Cykl 0 zakończony w $((END_INIT - START_INIT)) s."

if [ ! -f "picdata.bin" ]; then
    echo ">> BŁĄD: Plik picdata.bin nie został utworzony po cyklu 0!"
    exit 1
fi

# -----------------------------------------------------------------------------
# KROK 2: Osiąganie stanu ustalonego (2000 cykli RF)
# -----------------------------------------------------------------------------
echo ">> KROK 2: Uruchamianie 2000 cykli do stanu ustalonego (./eduPIC 2000)..."
START_SIM=$(date +%s)
"${BINARY}" 2000
END_SIM=$(date +%s)
TOTAL_SIM_TIME=$((END_SIM - START_SIM))
echo ">> Symulacja 2000 cykli zakończona w ${TOTAL_SIM_TIME} s (~$((TOTAL_SIM_TIME / 60)) min $((TOTAL_SIM_TIME % 60)) s)."

# -----------------------------------------------------------------------------
# KROK 3: Weryfikacja i zapis wyników jako golden_record_5x
# -----------------------------------------------------------------------------
echo ">> Ostatnie 10 linii pliku conv.dat (stan zbieżności):"
tail -n 10 conv.dat

echo ">> Kopiowanie plików do repozytorium: ${OUTPUT_DIR}..."
cp picdata.bin "${OUTPUT_DIR}/picdata.bin"
cp conv.dat "${OUTPUT_DIR}/conv.dat"

ls -lh "${OUTPUT_DIR}"

rm -f "${BINARY}"
echo ">> Zadanie zakończone pomyślnie o $(date)!"
