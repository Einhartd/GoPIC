#!/bin/bash
# ============================================================================
# Benchmark: Sequential vs OMP — Detailed Profiling
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

N_CYCLES="${1:-10}"
CHECKPOINT="${2:-$PROJECT_ROOT/plots/hpc_logs/null-collision/saved_logs_C/logs_job_5498699_STAT/edupic_data/picdata.bin}"

SEQ_DIR="$PROJECT_ROOT/C/sequential"
OMP_DIR="$PROJECT_ROOT/C/parallel-only-omp"
BUILD_DIR="$SCRIPT_DIR/bench_build"
WORK_DIR="$SCRIPT_DIR/bench_work"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  eduPIC Detailed Profiling Benchmark: Sequential vs OMP${NC}"
echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"
echo ""

if [ ! -f "$CHECKPOINT" ]; then
    echo "BŁĄD: Nie znaleziono checkpointu: $CHECKPOINT"
    exit 1
fi

echo -e "${YELLOW}Checkpoint:${NC} $CHECKPOINT"
python3 -c "
import struct
with open('$CHECKPOINT', 'rb') as fp:
    time = struct.unpack('d', fp.read(8))[0]
    cycles = int(struct.unpack('d', fp.read(8))[0])
    n_e = int(struct.unpack('d', fp.read(8))[0])
    fp.seek(8 * n_e * 4, 1)
    n_i = int(struct.unpack('d', fp.read(8))[0])
    print(f'  Cykle: {cycles}, Elektrony: {n_e:,}, Jony: {n_i:,}')
"
echo -e "${YELLOW}Cykli do benchmarku:${NC} $N_CYCLES"
echo -e "${YELLOW}OMP_NUM_THREADS:${NC} ${OMP_NUM_THREADS:-$(nproc)}"
echo ""

echo -e "${BOLD}[1/4] Budowanie...${NC}"
mkdir -p "$BUILD_DIR"

echo -n "  Sequential (null-collision)... "
g++ -std=c++17 -O2 -Wall -DUSE_NULL_COLLISION \
    -I"$SEQ_DIR" "$SEQ_DIR/eduPIC.cc" -o "$BUILD_DIR/edupic_seq_nc" -lm 2>/dev/null
echo -e "${GREEN}OK${NC}"

echo -n "  OMP (null-collision)... "
g++ -std=c++17 -O2 -Wall -fopenmp -DUSE_NULL_COLLISION \
    -I"$OMP_DIR" "$OMP_DIR/eduPIC.cc" -o "$BUILD_DIR/edupic_omp_nc" -lm 2>/dev/null
echo -e "${GREEN}OK${NC}"
echo ""

echo -e "${BOLD}[2/4] Przygotowanie środowisk...${NC}"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR/seq" "$WORK_DIR/omp"
cp "$CHECKPOINT" "$WORK_DIR/seq/picdata.bin"
cp "$CHECKPOINT" "$WORK_DIR/omp/picdata.bin"
touch "$WORK_DIR/seq/conv.dat" "$WORK_DIR/omp/conv.dat"
echo -e "  ${GREEN}Gotowe${NC}"
echo ""

echo -e "${BOLD}[3/4] Profilowanie: Sequential ($N_CYCLES cykli)${NC}"
echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}"
(cd "$WORK_DIR/seq" && /usr/bin/time -v "$BUILD_DIR/edupic_seq_nc" "$N_CYCLES")
echo ""

echo -e "${BOLD}[4/4] Profilowanie: OMP ($N_CYCLES cykli, ${OMP_NUM_THREADS:-$(nproc)} wątków)${NC}"
echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}"
(cd "$WORK_DIR/omp" && /usr/bin/time -v "$BUILD_DIR/edupic_omp_nc" "$N_CYCLES")
echo ""

echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"

rm -rf "$WORK_DIR"
