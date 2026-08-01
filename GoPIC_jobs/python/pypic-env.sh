#!/bin/bash
# Skrypt do tworzenia/aktualizacji środowiska wirtualnego dla GoPIC (eduPIC) na HPC

set -e

echo ">> Ładowanie modułów GCC, Python i OpenMPI..."
module purge
module load GCC/13.3.0 Python/3.12.3-GCCcore-13.3.0
module load OpenMPI || true

VENV_DIR="$HOME/pypic-venv"

if [ ! -d "$VENV_DIR" ]; then
    echo ">> Tworzenie środowiska wirtualnego w $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
else
    echo ">> Znaleziono istniejące środowisko $VENV_DIR. Aktualizuję..."
fi

source "$VENV_DIR/bin/activate"

echo ">> Instalowanie/Aktualizowanie zależności (pip, numpy, scipy, matplotlib, numba, mpi4py)..."
pip install --upgrade pip
pip install --upgrade numpy scipy matplotlib numba mpi4py

echo ">> Weryfikacja zainstalowanych pakietów..."
python3 -c "
pkgs = ['numpy', 'numba', 'mpi4py', 'scipy', 'matplotlib']
for pkg in pkgs:
    m = __import__(pkg)
    ver = getattr(m, '__version__', 'zainstalowano')
    print(f'  [OK] {pkg:<12} v{ver}')
"
echo ">> Środowisko pypic-venv jest gotowe!"

