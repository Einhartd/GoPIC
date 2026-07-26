#!/bin/bash
# ============================================================================
# Benchmark: Go Sequential vs Parallel Chunking (Worker Pool)
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

N_CYCLES="${1:-5}"

NATIVE_DIR="$SCRIPT_DIR/native_version"
PARALLEL_DIR="$SCRIPT_DIR/parallel_chunking"
BUILD_DIR="$SCRIPT_DIR/bench_build"
WORK_DIR="$SCRIPT_DIR/bench_work"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}═════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  GoPIC Benchmarking: Sequential vs Parallel Chunking${NC}"
echo -e "${BOLD}═════════════════════════════════════════════════════════════${NC}"
echo ""

NUM_CORES=$(nproc)
echo -e "${YELLOW}Dostępne rdzenie CPU (nproc):${NC} $NUM_CORES"
echo -e "${YELLOW}Cykli symulacji do uruchomienia:${NC} $N_CYCLES"
echo ""

echo -e "${BOLD}[1/4] Budowanie binariów Go...${NC}"
mkdir -p "$BUILD_DIR"

echo -n "  Budowanie Sequential (native_version)... "
(cd "$NATIVE_DIR" && go build -o "$BUILD_DIR/edupic_go_seq" ./cmd/pic)
echo -e "${GREEN}OK${NC}"

echo -n "  Budowanie Parallel Chunking (parallel_chunking)... "
(cd "$PARALLEL_DIR" && go build -o "$BUILD_DIR/edupic_go_par" ./cmd/pic)
echo -e "${GREEN}OK${NC}"
echo ""

echo -e "${BOLD}[2/4] Inicjalizacja stanu symulacji (Krok 0)...${NC}"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR/init"
(cd "$WORK_DIR/init" && "$BUILD_DIR/edupic_go_seq" 0 > /dev/null)
CHECKPOINT="$WORK_DIR/init/picdata.bin"

if [ ! -f "$CHECKPOINT" ]; then
    echo "BŁĄD: Nie wygenerowano pliku picdata.bin"
    exit 1
fi
echo -e "  ${GREEN}Wycinek stanu picdata.bin utworzony pomyślnie${NC}"
echo ""

run_bench() {
    local name="$1"
    local bin="$2"
    local workers="$3"
    local dir="$WORK_DIR/$name"

    mkdir -p "$dir"
    cp "$CHECKPOINT" "$dir/picdata.bin"
    touch "$dir/conv.dat"

    echo -e "${BOLD}► Test: $name (GOMAXPROCS=$workers, $N_CYCLES cykli)${NC}"
    echo -e "${BOLD}───────────────────────────────────────────────────────────${NC}"
    (cd "$dir" && GOMAXPROCS="$workers" /usr/bin/time -v "$bin" "$N_CYCLES")
    echo ""
}

echo -e "${BOLD}[3/4] Uruchamianie serii benchmarków...${NC}"
run_bench "Sequential_Native" "$BUILD_DIR/edupic_go_seq" 1
run_bench "Parallel_Chunking_1W" "$BUILD_DIR/edupic_go_par" 1

if [ "$NUM_CORES" -ge 2 ]; then
    run_bench "Parallel_Chunking_2W" "$BUILD_DIR/edupic_go_par" 2
fi

if [ "$NUM_CORES" -ge 4 ]; then
    run_bench "Parallel_Chunking_4W" "$BUILD_DIR/edupic_go_par" 4
fi

if [ "$NUM_CORES" -ge 8 ]; then
    run_bench "Parallel_Chunking_8W" "$BUILD_DIR/edupic_go_par" 8
fi

if [ "$NUM_CORES" -ne 1 ] && [ "$NUM_CORES" -ne 2 ] && [ "$NUM_CORES" -ne 4 ] && [ "$NUM_CORES" -ne 8 ]; then
    run_bench "Parallel_Chunking_${NUM_CORES}W" "$BUILD_DIR/edupic_go_par" "$NUM_CORES"
fi

echo -e "${BOLD}[4/4] Czyszczenie katalogów roboczych...${NC}"
rm -rf "$WORK_DIR"
echo -e "  ${GREEN}Zakończono.${NC}"
