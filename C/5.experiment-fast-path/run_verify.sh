#!/bin/bash
set -e

echo "=== 1. Budowanie projektu ==="
make clean && make

echo "=== 2. Przygotowanie Golden Record ==="
rm -f picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *.xt
cp ../../golden_record/picdata.bin ./picdata.bin

echo "=== 3. Uruchomienie 5 cykli w trybie pomiarowym ==="
./eduPIC 5 m

echo "=== 4. Weryfikacja wygenerowanych danych ==="
if [ -f "density.dat" ] && [ -f "info.txt" ]; then
    echo ">> OK: Symulacja wygenerowala komplet plikow diagnostycznych."
    echo ">> Podsumowanie parametrow plazmy (info.txt):"
    grep -E "Electron density|Electron collision frequency|Plasma frequency" info.txt || true
else
    echo ">> BLAD: Brak plikow diagnostycznych!"
    exit 1
fi

echo "=== Weryfikacja zakonczona pomyslnie! ==="
