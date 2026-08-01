#!/bin/bash -l

#SBATCH --job-name=edupic_hybrid_opt
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=2            # Liczba procesów MPI
#SBATCH --cpus-per-task=16     # Liczba wątków OpenMP na proces MPI
#SBATCH --time=01:00:00

set -e

# 1. Lokalny katalog tymczasowy (brak opóźnień sieciowych z Lustre)
export TMPDIR=/tmp
export OMPI_MCA_prte_silence_shared_fs=1

# 2. Liczba wątków OpenMP na proces MPI
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# 3. Odblokowanie przypisywania rdzeni OpenMPI (zapobiega ściskaniu wątków OMP na 1 rdzeniu)
export OMPI_MCA_hwloc_base_binding_policy=none

# Liczba cykli symulacji (domyślnie 1000 cykli RF)
N_CYCLES="${N_CYCLES:-1000}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_C/logs_job_${SLURM_JOB_ID}_HYBRID_OPT"
mkdir -p "${LOG_DIR}"
exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING OPTIMIZED HYBRID JOB WITH MPI TASKS: ${SLURM_NTASKS} AND OMP THREADS: ${OMP_NUM_THREADS}"
echo " CYCLES TO SIMULATE: ${N_CYCLES}"
echo "========================================================"

SOURCE_DIR="$HOME/GoPIC/C/parallel-hybrid"
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
    echo "Liczba procesów MPI (ntasks): ${SLURM_NTASKS}"
    echo "Liczba wątków OpenMP na proces (cpus-per-task): ${OMP_NUM_THREADS}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

module purge
module load openmpi

echo ">> Kompiluję zoptymalizowany hybrydowy kod C++ (MPI+OpenMP + Null-Collision)..."
mpicxx -O3 -fno-omit-frame-pointer -march=native -fopenmp -DUSE_NULL_COLLISION "${SOURCE_DIR}/eduPIC.cc" -o "${BUILD_DIR}/edupic_tmp_hybrid_opt_${SLURM_JOB_ID}"
mv "${BUILD_DIR}/edupic_tmp_hybrid_opt_${SLURM_JOB_ID}" "${BUILD_DIR}/edupic_hybrid_c_opt"

BINARY="${BUILD_DIR}/edupic_hybrid_c_opt"

cd "${DATA_DIR}"
chmod +x "${BINARY}"

echo ">> Uruchamiam fazę inicjalizacji (cykl 0)..."
mpirun --bind-to none -np "${SLURM_NTASKS}" "${BINARY}" 0

echo ">> Uruchamiam pełną symulację hybrydową (${N_CYCLES} cykli w trybie pomiarowym 'm')..."
echo ">> [MPI Bind-to: NONE, OMP Threads: ${OMP_NUM_THREADS}]"

/usr/bin/time -v mpirun --bind-to none -np "${SLURM_NTASKS}" "${BINARY}" "${N_CYCLES}" m

echo "========================================================"
echo " Zadanie HYBRID OPTIMIZED zakończone sukcesem!"
echo " Wyniki i logi w: ${DATA_DIR}"
echo "========================================================"
