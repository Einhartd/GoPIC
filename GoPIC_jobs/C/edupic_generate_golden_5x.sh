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

module purge && module load gcc
echo ">> Wersja kompilatora C++: $(g++ --version | head -n 1)"

BINARY="${BUILD_DIR}/edupic_omp_golden_${SLURM_JOB_ID}"
rm -f "${BINARY}"

g++ -std=c++17 -O3 -fno-omit-frame-pointer \
 -march=znver4 -mtune=znver4 \
 -ffast-math -funroll-loops \
 -mprefer-vector-width=512 \
 -fopenmp -fopenmp-simd \
 -fno-math-errno \
 -fopt-info-vec-optimized \
 "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm

if [ ! -f "${BINARY}" ]; then
    exit 1
fi

cd "${WORK_DIR}"

# -----------------------------------------------------------------------------
# KROK 1: Inicjalizacja cząstek (cykl 0)
# -----------------------------------------------------------------------------
cp "${OUTPUT_DIR}/picdata.bin" ./picdata.bin
cp "${OUTPUT_DIR}/conv.dat" ./conv.dat

# -----------------------------------------------------------------------------
# KROK 2: Osiąganie stanu ustalonego
# -----------------------------------------------------------------------------
"${BINARY}" 500


# -----------------------------------------------------------------------------
# KROK 3: Weryfikacja i zapis wyników jako golden_record_5x
# -----------------------------------------------------------------------------
cp picdata.bin "${OUTPUT_DIR}/picdata.bin"
cp conv.dat "${OUTPUT_DIR}/conv.dat"

ls -lh "${OUTPUT_DIR}"

rm -f "${BINARY}"
