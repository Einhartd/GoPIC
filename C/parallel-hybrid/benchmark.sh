#!/bin/bash
# ============================================================================
# Benchmark: Hybrid MPI+OMP — Detailed Profiling
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

N_CYCLES="${1:-10}"
MPI_RANKS="${MPI_RANKS:-2}"
OMP_THREADS="${OMP_NUM_THREADS:-2}"
CHECKPOINT="${2:-$PROJECT_ROOT/plots/hpc_logs/null-collision/saved_logs_C/logs_job_5498699_STAT/edupic_data/picdata.bin}"

HYBRID_DIR="$PROJECT_ROOT/C/parallel-hybrid"
BUILD_DIR="$SCRIPT_DIR/bench_build"
WORK_DIR="$SCRIPT_DIR/bench_work"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  eduPIC Benchmark: Hybrid MPI+OMP${NC}"
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
echo -e "${YELLOW}MPI Ranks:${NC} $MPI_RANKS"
echo -e "${YELLOW}OMP_NUM_THREADS:${NC} $OMP_THREADS"
echo ""

echo -e "${BOLD}[1/3] Budowanie...${NC}"
mkdir -p "$BUILD_DIR"

echo -n "  Hybrid MPI+OMP (null-collision)... "
mpicxx -std=c++17 -O2 -Wall -fopenmp -DUSE_NULL_COLLISION \
    -I"$HYBRID_DIR" "$HYBRID_DIR/eduPIC.cc" -o "$BUILD_DIR/edupic_hybrid_nc" -lm 2>/dev/null
echo -e "${GREEN}OK${NC}"
echo ""

echo -e "${BOLD}[2/3] Przygotowanie środowiska...${NC}"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"
cp "$CHECKPOINT" "$WORK_DIR/picdata.bin"
touch "$WORK_DIR/conv.dat"
echo -e "  ${GREEN}Gotowe${NC}"
echo ""

echo -e "${BOLD}[3/3] Profilowanie: Hybrid MPI+OMP (mpirun -np $MPI_RANKS, OMP_NUM_THREADS=$OMP_THREADS)${NC}"
echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}"
export OMP_NUM_THREADS="$OMP_THREADS"
(cd "$WORK_DIR" && /usr/bin/time -v mpirun -np "$MPI_RANKS" "$BUILD_DIR/edupic_hybrid_nc" "$N_CYCLES")
echo ""

echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}"

rm -rf "$WORK_DIR"
