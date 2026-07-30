# GoPIC — Pełny Przegląd Projektu

> **Praca magisterska**: *"Research on parallelized implementation of PIC in Golang programming language"*
>
> Reimplementacja symulacji PIC/MCC **eduPIC** (1D3V CCP w Argonie) w **Go, Python i C++** z wieloma wariantami równoległymi.

---

## 📁 Struktura repozytorium

```
GoPIC/
├── eduPIC/C/                  ← oryginalny kod referencyjny (1100 linii, NIE modyfikować)
│   ├── eduPIC.cc              ← ground truth
│   ├── README.md
│   ├── eduPIC_manual.pdf
│   └── ReferenceCase_RawData/ ← 15 plików .dat z referencyjnymi wynikami
│
├── edupic-article.pdf         ← artykuł naukowy o eduPIC
│
├── C/                         ← implementacje C++ (refaktoryzowane, modularne)
│   ├── sequential/            ← baseline + null-collision + testy GoogleTest
│   ├── parallel-only-omp/     ← OpenMP (persistent parallel region)
│   ├── parallel-hybrid/       ← MPI + OpenMP
│   └── benchmark.sh           ← porównanie seq vs OMP
│
├── Go/                        ← implementacje Go (3 warianty)
│   ├── native_version/        ← single-threaded baseline
│   ├── parallel_chunking/     ← Worker Pool + sync.WaitGroup
│   ├── parallel_channels/     ← CSP (goroutine channels)
│   └── benchmark.sh
│
├── python/                    ← implementacje Python (5 wariantów)
│   ├── native_version/        ← czysty Python
│   ├── numpy_version/         ← NumPy + SciPy
│   ├── numba_version/         ← Numba JIT (single-thread)
│   ├── numba_parallel/        ← Numba @njit(parallel=True) + prange
│   ├── hybrid_parallel/       ← MPI + Numba
│   ├── tests/                 ← pytest
│   └── benchmark.sh / benchmark_numba.py
│
├── GoPIC_jobs/                ← skrypty SLURM (PLGrid, partycja plgrid-lem-cpu)
│   ├── C/                     ← 6 skryptów (seq/omp/hybrid × record/stat)
│   ├── Go/                    ← 6 skryptów (seq/channels/chunking × record/stat)
│   └── python/                ← 8 skryptów + env setup
│
├── plots/                     ← wizualizacja i analiza
│   ├── measurements.ipynb     ← główny notebook (fizyka + benchmarki)
│   ├── hpc_logs/              ← surowe logi z klastra
│   └── pic_plots/
│
└── docs/                      ← obszerna dokumentacja
    ├── go_parallel/           ← analiza 3 modeli równoległości Go
    ├── numpy_version/         ← spec wektoryzacji NumPy
    ├── numba_version/         ← spec Numba JIT
    ├── null-collision/        ← null-collision MCC we wszystkich językach
    ├── parallel/              ← complexity, Amdahl's Law, porównania
    ├── testowanie/            ← plany testów, cross-language validation
    └── hpc_info/              ← AMD EPYC 9554, NUMA analysis
```

---

## 🔬 Fizyka symulacji

| Parametr | Wartość |
|:---------|:--------|
| Geometria | CCP, dwie równoległe elektrody, L = 25 mm |
| Gaz | Argon, 10 Pa, 350 K, n_g ≈ 2.07×10²¹ m⁻³ |
| Siatka | N_G = 400 punktów, Δx ≈ 62.7 μm |
| RF | 13.56 MHz, V₀ = 250 V, N_T = 4000 kroków/cykl |
| Subcycling | N_SUB = 20 (Δt_i = 20 × Δt_e ≈ 0.37 ns) |
| Supercząstka | W = 7×10⁴ |

### 9-krokowy algorytm PIC/MCC

| Krok | Opis | Częstotliwość |
|:-----|:-----|:-------------|
| 1a | Depozycja gęstości e⁻ (linear weighting + boundary ×2) | co krok |
| 1b | Depozycja gęstości Ar⁺ | co N_SUB |
| 2 | Poisson solver (Thomas algorithm, tridiag A=1,B=-2,C=1) | co krok |
| 3 | Push e⁻ (leapfrog, v -= FACTOR_E × E) | co krok |
| 4 | Push Ar⁺ (leapfrog, v += FACTOR_I × E) | co N_SUB |
| 5 | Absorpcja e⁻ + EEPF (center 0.45L–0.55L) | co krok |
| 6 | Absorpcja Ar⁺ + IFED | co N_SUB |
| 7 | MCC e⁻ (elastic/excitation 11.5eV/ionization 15.8eV) | co krok |
| 8 | MCC Ar⁺ (isotropic + backward w COM frame) | co N_SUB |
| 9 | Akumulacja XT diagnostics (measurement mode) | co krok |

---

## ⚡ Warianty C++ (zrefaktoryzowane, modularne headery)

Każdy wariant ma: `eduPIC.cc` + headery (`constants.h`, `state.h`, `simulation.h`, `poisson.h`, `collisions.h`, `cross_sections.h`, `io_manager.h`, `null_collision.h`) + testy GoogleTest.

| Cecha | Sequential | OpenMP | Hybrid (MPI+OMP) |
|:------|:-----------|:-------|:------------------|
| Równoległość | brak | persistent `#pragma omp parallel` | MPI ranks + OpenMP wątki |
| RNG | `std::mt19937` | `thread_local` | `thread_local` + per-rank |
| Gęstość | direct write | `WorkerBuffers` + reduce | local buffers → `MPI_Allreduce` |
| Poisson | serial | `#pragma omp single` | każdy rank rozwiązuje lokalnie |
| False-sharing | — | `alignas(64)` counters | `alignas(64)` + MPI |
| Null-collision | `-DUSE_NULL_COLLISION` | `-DUSE_NULL_COLLISION` | `-DUSE_NULL_COLLISION` |
| Kompilacja | `g++ -O2 -std=c++17` | + `-fopenmp` | `mpicxx -fopenmp` |

> [!IMPORTANT]
> C++ jest **zrefaktoryzowane** vs. oryginał — modularne headery, opcjonalny null-collision (rejection sampling), testy jednostkowe.

---

## 🐹 Warianty Go (3 modele współbieżności)

| Cecha | native_version | parallel_chunking | parallel_channels |
|:------|:---------------|:------------------|:------------------|
| Model | single-threaded | Worker Pool + WaitGroup | CSP (goroutine channels) |
| Gęstość | direct | lokalne tablice → reduce | bufory → channel → Coordinator |
| Synchronizacja | — | `sync.WaitGroup` | `WorkerCmdChan` / `WorkerDoneChan` |
| GOMAXPROCS | 1 | N cores | N cores |
| Null-collision | `-tags nullcollision` | `-tags nullcollision` | `-tags nullcollision` |

---

## 🐍 Warianty Python (5 modeli)

| Cecha | native | numpy | numba | numba_parallel | hybrid |
|:------|:-------|:------|:------|:---------------|:-------|
| Zależności | stdlib | numpy, scipy | numba | numba | mpi4py, numba |
| Hot loops | Python loops | wektoryzacja | `@njit` JIT | `@njit(parallel=True)` + `prange` | MPI + Numba |
| Gęstość | pętla | `np.add.at()` | JIT loop | JIT parallel | MPI reduce + JIT |
| Poisson | ręczny Thomas | `solve_banded` | JIT Thomas | JIT Thomas | JIT Thomas |

---

## 🖥️ HPC — Profilowanie na PLGrid (SLURM)

### Dwa tryby profilowania per wariant:

| Tryb | Cykle | Czas | Narzędzie | Cel |
|:-----|:------|:-----|:----------|:----|
| **RECORD** | 20 | 30 min | `perf record -F 49 -g` | Flamegraph, call tree, hotspoty |
| **STAT** | 1000 | 3.5–6.5 h | `perf stat` | IPC, L1 cache miss, branch miss |

### Zasoby per wariant:

| Wariant | Nodes | Tasks | CPUs/task | RAM/CPU |
|:--------|:------|:------|:----------|:--------|
| C seq | 1 | 1 | 1 | 4 GB |
| C OMP | 1 | 1 | 2+ | 4 GB |
| C hybrid | 1 | 2 | 2 | 4 GB |
| Go seq | 1 | 1 | 1 | 4 GB |
| Go channels/chunking | 1 | 1 | 12 | 4 GB |
| Python seq/numpy | 1 | 1 | 1 | 4 GB |
| Python numba parallel | 1 | 1 | 12 | 4 GB |
| Python hybrid | 1 | 2 | 2 | 4 GB |

> [!NOTE]
> Partycja: `plgrid-lem-cpu` (AMD EPYC 9554). Każdy skrypt zbiera `lscpu` → `hardware_topology.txt`.

### Artefakty profilowania:
- `perf_report.txt` — ogólny raport
- `perf_report_per_cpu.txt` — rozkład per CPU
- `perf_report_per_thread.txt` — rozkład per wątek
- `perf_cpu_stats.txt` — raw hardware counters
- Hybrid MPI: osobny `perf record` per rank

---

## 🧪 Testowanie

- **C++**: GoogleTest (`tests/` w każdym wariancie) — Poisson, density, push, boundaries, cross-sections
- **Go**: testy w `tests/` dirs + regression suite (`cmd/regression`)
- **Python**: pytest (`python/tests/`)
- **Cross-language validation**: `docs/testowanie/cross_language_validation.md`

---

## 📊 Narzędzia analityczne

| Plik | Funkcja |
|:-----|:--------|
| `plots/measurements.ipynb` | **Główny notebook**: fizyka + benchmarki porównawcze |
| `plots/hpc_logs/` | Surowe logi z klastra (null-collision, default) |
| `python/benchmark.sh` | Automatyczne benchmarki Python |
| `C/benchmark.sh` | Porównanie seq vs OMP |
| `Go/benchmark.sh` | Benchmarki wariantów Go |

---

## 🔑 Null-Collision Method

Alternatywna metoda MCC (rejection sampling zamiast testowania każdej cząstki):
- Losuje liczbę kolizji z rozkładu dwumianowego
- Implementacja we **wszystkich** językach/wariantach
- Toggle: `-DUSE_NULL_COLLISION` (C++), `-tags nullcollision` (Go), `USE_NULL_COLLISION=true` (Python)
- Szczegóły: [docs/null-collision/](file:///home/oliwier/Dev/GoPIC/docs/null-collision/)

---

## ⚠️ Kluczowe zasady implementacyjne

1. **Boundary ×2**: `density[0] *= 2`, `density[N_G-1] *= 2` po depozycji
2. **cumul_i_density**: akumulowane **każdy** timestep (nie tylko subcycling)
3. **Electron push**: `v -= FACTOR_E × E` (ujemny ładunek)
4. **Ion push**: `v += FACTOR_I × E` (dodatni ładunek)
5. **NumPy**: zawsze `np.add.at()` dla scatter-add
6. **Oryginał** `eduPIC/C/eduPIC.cc` — **NIE modyfikować**
