#!/bin/bash
# Skrypt do tworzenia/aktualizacji środowiska wirtualnego dla GoPIC (eduPIC) na HPC

set -e

echo ">> Ładowanie modułów GCC/14.3.0, OpenMPI i Python..."
module purge
module load GCC/14.3.0
module load OpenMPI/5.0.8-GCC-14.3.0 2>/dev/null || module load OpenMPI 2>/dev/null || true
module load Python 2>/dev/null || true

VENV_DIR="$HOME/pypic-venv"

if [ ! -d "$VENV_DIR" ]; then
    echo ">> Tworzenie środowiska wirtualnego w $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
else
    echo ">> Znaleziono istniejące środowisko $VENV_DIR. Rekompiluję pakiety dla GCC 14.3.0..."
fi

source "$VENV_DIR/bin/activate"

echo ">> Reinstalacja/Aktualizacja zależności (pip, numpy, scipy, matplotlib, numba, mpi4py)..."
pip install --upgrade pip
pip install --upgrade --force-reinstall mpi4py
pip install --upgrade numpy scipy matplotlib numba


echo ">> Weryfikacja zainstalowanych pakietów..."
python3 -c "
pkgs = ['numpy', 'numba', 'mpi4py', 'scipy', 'matplotlib']
for pkg in pkgs:
    m = __import__(pkg)
    ver = getattr(m, '__version__', 'zainstalowano')
    print(f'  [OK] {pkg:<12} v{ver}')
"
echo ">> Środowisko pypic-venv jest gotowe!"

