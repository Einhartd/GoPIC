#!/bin/bash
set -e

CYCLES="${1:-1}"
MEASURE_FLAG="${2:-}"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "=== 1. Budowanie programu eduPIC z symbolami do profilowania ==="
g++ -std=c++17 -O3 -Wall -fno-math-errno -fno-omit-frame-pointer -g eduPIC.cc -o eduPIC -lm

echo "=== 2. Przygotowanie stanu Golden Record ==="
cp ../../golden_record/picdata.bin ./picdata.bin

OUTPUT_DIR="./perf_results_$(date +%Y%m%d_%H%M%S)"
mkdir -p "${OUTPUT_DIR}"

echo "=== 3. Profilowanie sprzetowe (perf stat) na ${CYCLES} cyklach ==="
perf stat -o "${OUTPUT_DIR}/perf_stat.txt" \
    -e cycles,instructions,branches,branch-misses,task-clock \
    ./eduPIC "${CYCLES}" ${MEASURE_FLAG}

echo "=== 4. Profilowanie funkcji i stosu wywolan (perf record) ==="
cp ../../golden_record/picdata.bin ./picdata.bin
perf record -F 99 -g -o "${OUTPUT_DIR}/perf.data" -- ./eduPIC "${CYCLES}" ${MEASURE_FLAG}

echo "=== 5. Generowanie raportu tekstowego (perf report) ==="
perf report -i "${OUTPUT_DIR}/perf.data" --stdio > "${OUTPUT_DIR}/perf_report.txt"

echo "================================================================="
echo ">> Profilowanie zakonczone sukcesem!"
echo ">> Wyniki zapisano w katalogu: ${OUTPUT_DIR}"
echo ">> Podsumowanie perf stat (IPC i cykle):"
cat "${OUTPUT_DIR}/perf_stat.txt"
echo "-----------------------------------------------------------------"
echo ">> Top 15 najbardziej obciazajacych funkcji (Hotspots):"
grep -A 18 "# Overhead" "${OUTPUT_DIR}/perf_report.txt" | head -n 18 || true
echo "================================================================="
