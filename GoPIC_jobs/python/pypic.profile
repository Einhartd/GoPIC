module purge

module load GCC/14.3.0
module load OpenMPI/5.0.8-GCC-14.3.0 2>/dev/null || module load OpenMPI 2>/dev/null || true
module load Python 2>/dev/null || true

source $HOME/pypic-venv/bin/activate
export PYTHONUNBUFFERED=1



