module purge

module load GCC/13.3.0
module load Python/3.12.3-GCCcore-13.3.0
module load OpenMPI || true

source $HOME/pypic-venv/bin/activate
export PYTHONUNBUFFERED=1

