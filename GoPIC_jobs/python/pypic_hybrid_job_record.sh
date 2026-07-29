#!/bin/bash -l

#SBATCH --job-name=pypic_hybrid_rec
#SBATCH --partition=plgrid-lem-cpu
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=2            # Liczba procesów MPI
#SBATCH --cpus-per-task=2      # Liczba wątków Numba na proces MPI
#SBATCH --time=00:30:00        # Skrócony czas (profilowanie 20 cykli trwa ok. 1-2 min)

set -e

# Konfiguracja środowiska hybrydowego MPI + Numba
export NUMBA_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=1

# Liczba cykli symulacji dla perf record (20 cykli daje reprezentatywny profil przy plikach ~15-30 MB per rank)
N_CYCLES_RECORD="${N_CYCLES_RECORD:-20}"

WORK_DIR=$(pwd)
LOG_DIR="${WORK_DIR}/saved_logs_python/logs_job_${SLURM_JOB_ID}_HYBRID_RECORD"
mkdir -p "${LOG_DIR}"

exec > "${LOG_DIR}/job_output.log" 2>&1

echo "========================================================"
echo " RUNNING HYBRID MPI+NUMBA RECORD JOB WITH MPI TASKS: ${SLURM_NTASKS} AND NUMBA THREADS: ${NUMBA_NUM_THREADS}"
echo " CYCLES TO RECORD: ${N_CYCLES_RECORD}"
echo "========================================================"

PYTHON_VERSION_DIR="$HOME/GoPIC/python/hybrid_parallel"
DATA_DIR="${LOG_DIR}/edupic_data"

mkdir -p "${DATA_DIR}"

if [ -f "$HOME/GoPIC/GoPIC_jobs/python/pypic.profile" ]; then
    echo ">> Wczytuję profil środowiska GoPIC..."
    source "$HOME/GoPIC/GoPIC_jobs/python/pypic.profile"
    module load openmpi || true
else
    echo ">> Błąd: plik pypic.profile nie został znaleziony!"
    exit 1
fi

if [ "${USE_NULL_COLLISION}" = "true" ] || [ "${USE_NULL_COLLISION}" = "1" ]; then
    echo ">> [Null-Collision Hybrid] Wybrano wersję zoptymalizowaną (USE_NULL_COLLISION=true)"
    export USE_NULL_COLLISION="true"
else
    echo ">> [Standard Hybrid] Wybrano wersję klasyczną (USE_NULL_COLLISION=false)"
    export USE_NULL_COLLISION="false"
fi

# Wsparcie profilera perf dla funkcji Pythona i JIT Numba
export PYTHONPERFSUPPORT=1

export PYTHONPATH="${PYTHON_VERSION_DIR}:${PYTHONPATH}"

NODE_INFO_FILE="${LOG_DIR}/hardware_topology.txt"
{
    echo "========================================================"
    echo " HARDWARE & TOPOLOGY INFO — $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================================"
    echo "Węzeł obliczeniowy: ${SLURM_JOB_NODELIST}"
    echo "Liczba procesów MPI (ntasks): ${SLURM_NTASKS}"
    echo "Liczba wątków Numba na proces (cpus-per-task): ${NUMBA_NUM_THREADS}"
    echo "Liczba cykli dla perf record: ${N_CYCLES_RECORD}"
    echo "--- CPU topology (lscpu) ---"
    lscpu
} > "${NODE_INFO_FILE}" 2>&1

cd "${DATA_DIR}"

echo ">> Uruchamiam fazę inicjalizacji (krok 0)..."
mpirun -np "${SLURM_NTASKS}" python3 "${PYTHON_VERSION_DIR}/main.py" 0

SCRATCH_BASE="${SCRATCH:-${DATA_DIR}}"

echo ">> Uruchamianie pomiaru drzewa wywołań (perf record) dla ${N_CYCLES_RECORD} cykli osobiście dla każdej rangi MPI..."
mpirun -np "${SLURM_NTASKS}" bash -c "perf record --max-size=100M -F 49 -g -o ${SCRATCH_BASE}/perf_${SLURM_JOB_ID}_rank_\${OMPI_COMM_WORLD_RANK}.data -- python3 ${PYTHON_VERSION_DIR}/main.py ${N_CYCLES_RECORD} m"

# Generowanie raportów per-rank
for r in $(seq 0 $((SLURM_NTASKS - 1))); do
    echo ">> Generuję raporty tekstowe dla rangi MPI ${r}..."
    PERF_RANK_FILE="${SCRATCH_BASE}/perf_${SLURM_JOB_ID}_rank_${r}.data"
    perf report -i "${PERF_RANK_FILE}" --stdio > "${DATA_DIR}/perf_report_rank_${r}.txt"
    perf report -i "${PERF_RANK_FILE}" --stdio --sort=cpu,symbol > "${DATA_DIR}/perf_report_rank_${r}_per_cpu.txt"
    perf report -i "${PERF_RANK_FILE}" --stdio --per-thread > "${DATA_DIR}/perf_report_rank_${r}_per_thread.txt"
    
    echo "========================================================"
    echo " TOP 25 HOTSPOTS (Ranga MPI ${r}):"
    echo "========================================================"
    perf report -i "${PERF_RANK_FILE}" --stdio --no-children --sort=comm,dso,symbol | head -n 35 || true
done

echo ">> Zadanie Python HYBRID RECORD zakończone. Wyniki w: ${DATA_DIR}"
