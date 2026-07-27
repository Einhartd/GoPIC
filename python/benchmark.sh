#!/bin/bash
# ============================================================================
# Benchmark: Python Implementations (Native vs NumPy vs Numba Sequential vs Numba Parallel)
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

N_CYCLES="${1:-1}"
CHECKPOINT="${2:-}"

NATIVE_DIR="$SCRIPT_DIR/native_version"
NUMPY_DIR="$SCRIPT_DIR/numpy_version"
NUMBA_SEQ_DIR="$SCRIPT_DIR/numba_version"
NUMBA_PAR_DIR="$SCRIPT_DIR/numba_parallel"

WORK_DIR="$SCRIPT_DIR/bench_work"

PYTHON_BIN="$NUMBA_PAR_DIR/.venv/bin/python"
if [ ! -x "$PYTHON_BIN" ]; then
    PYTHON_BIN="python3"
fi

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  eduPIC Python Benchmark: Native vs NumPy vs Numba (Seq/Par)${NC}"
echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"
echo ""

if [ -n "$CHECKPOINT" ] && [ -f "$CHECKPOINT" ]; then
    echo -e "${YELLOW}Checkpoint:${NC} $CHECKPOINT"
    "$PYTHON_BIN" -c "
import struct
with open('$CHECKPOINT', 'rb') as fp:
    time = struct.unpack('d', fp.read(8))[0]
    cycles = int(struct.unpack('d', fp.read(8))[0])
    n_e = int(struct.unpack('d', fp.read(8))[0])
    fp.seek(8 * n_e * 4, 1)
    n_i = int(struct.unpack('d', fp.read(8))[0])
    print(f'  Cykle: {cycles}, Elektrony: {n_e:,}, Jony: {n_i:,}')
"
else
    echo -e "${YELLOW}Tryb:${NC} Nowa symulacja (startowe cząstki N_INIT)"
fi

echo -e "${YELLOW}Cykli do benchmarku:${NC} $N_CYCLES"
echo -e "${YELLOW}NUMBA_NUM_THREADS:${NC} ${NUMBA_NUM_THREADS:-8}"
echo ""

echo -e "${BOLD}[1/5] Przygotowanie środowiska benchmarkowego...${NC}"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR/native" "$WORK_DIR/numpy" "$WORK_DIR/numba_seq" "$WORK_DIR/numba_par"

cp -r "$NATIVE_DIR"/* "$WORK_DIR/native/"
cp -r "$NUMPY_DIR"/* "$WORK_DIR/numpy/"
cp -r "$NUMBA_SEQ_DIR"/* "$WORK_DIR/numba_seq/"
cp -r "$NUMBA_PAR_DIR"/* "$WORK_DIR/numba_par/"

if [ -n "$CHECKPOINT" ] && [ -f "$CHECKPOINT" ]; then
    cp "$CHECKPOINT" "$WORK_DIR/native/picdata.bin"
    cp "$CHECKPOINT" "$WORK_DIR/numpy/picdata.bin"
    cp "$CHECKPOINT" "$WORK_DIR/numba_seq/picdata.bin"
    cp "$CHECKPOINT" "$WORK_DIR/numba_par/picdata.bin"
else
    echo "  Generowanie początkowej konfiguracji cząstek (init run)..."
    (cd "$WORK_DIR/native" && "$PYTHON_BIN" main.py 0 >/dev/null 2>&1)
    cp "$WORK_DIR/native/picdata.bin" "$WORK_DIR/numpy/picdata.bin"
    cp "$WORK_DIR/native/picdata.bin" "$WORK_DIR/numba_seq/picdata.bin"
    cp "$WORK_DIR/native/picdata.bin" "$WORK_DIR/numba_par/picdata.bin"
fi

echo -e "  ${GREEN}Gotowe${NC}"
echo ""

run_profiling() {
    local name="$1"
    local dir="$2"
    local env_vars="$3"

    echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}"
    echo -e "${BOLD}Profilowanie: $name ($N_CYCLES cykli)${NC}"
    echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}"
    
    (
        cd "$dir"
        eval "$env_vars /usr/bin/time -v \"$PYTHON_BIN\" main.py \"$N_CYCLES\""
    )
    echo ""
}

# [2/5] Native Python
run_profiling "Native Python" "$WORK_DIR/native" ""

# [3/5] NumPy Version
run_profiling "NumPy Vectorized" "$WORK_DIR/numpy" ""

# [4/5] Numba Sequential
run_profiling "Numba Sequential" "$WORK_DIR/numba_seq" "NUMBA_NUM_THREADS=1"

# [5/5] Numba Parallel
run_profiling "Numba Parallel (${NUMBA_NUM_THREADS:-8} threads)" "$WORK_DIR/numba_par" "NUMBA_NUM_THREADS=${NUMBA_NUM_THREADS:-8}"

echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Benchmark zakończony pomyślnie.${NC}"
echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"

rm -rf "$WORK_DIR"
