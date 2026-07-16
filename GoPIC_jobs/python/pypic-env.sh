#!/bin/bash
# Skrypt do tworzenia środowiska wirtualnego dla GoPIC (eduPIC) na HPC

module purge
module load GCC/13.3.0 Python/3.12.3-GCCcore-13.3.0

python3 -m venv $HOME/pypic-venv
source $HOME/pypic-venv/bin/activate

echo ">> Instalowanie zależności (pip, numpy, scipy, matplotlib)..."
pip install --upgrade pip
pip install numpy scipy matplotlib numba

