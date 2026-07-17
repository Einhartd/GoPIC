#!/bin/bash
set -e

# Skrypt uruchamiany z katalogu C/tests/
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

g++ -std=c++17 -O2 -o eduPIC_reg test_regression_runner.cc

# Czyszczenie starych plików tymczasowych
rm -f picdata.bin rng_state.bin conv.dat density.dat eepf.dat infed.dat info.txt

# Uruchomienie inicjalizacji (1 cykl)
./eduPIC_reg 0
# Kontynuacja (5 cykli)
./eduPIC_reg 5
# Pomiar (kolejne 5 cykli w measurement mode)
./eduPIC_reg 5 m

# Jeśli katalog golden lub pliki w nim nie istnieją, stwórz je z bieżącego uruchomienia
if [ ! -d "golden" ] || [ ! -f "golden/density_golden.dat" ]; then
    echo "Brak plików wzorcowych (golden)! Tworzenie bazy golden z bieżącego przebiegu..."
    mkdir -p golden
    cp density.dat golden/density_golden.dat
    cp conv.dat golden/conv_golden.dat
    cp eepf.dat golden/eepf_golden.dat
    echo "Utworzono pliki wzorcowe w C/tests/golden/."
    echo "Uruchom skrypt ponownie, aby przetestować symulację."
    exit 0
fi

diff density.dat golden/density_golden.dat \
    || { echo "FAIL: density.dat różni się od wzorca"; exit 1; }
    
diff conv.dat golden/conv_golden.dat \
    || { echo "FAIL: conv.dat różni się od wzorca"; exit 1; }

python3 compare_numeric.py eepf.dat golden/eepf_golden.dat 1e-6

echo "=== OK: wszystkie testy regresyjne przeszły pomyślnie! ==="
