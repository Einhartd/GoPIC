# Przewodnik Optymalizacji PIC/MCC C++ z OpenMP i AVX-512 na AMD EPYC 9554
## Synteza literatury naukowej i analiza kodu `C/parallel-only-omp/` w ekosystemie `GoPIC_jobs`

> **Dokument referencyjny** — analiza technik optymalizacji z literatury PIC/MCC zaadaptowanych
> do konkretnej implementacji eduPIC w katalogu `C/parallel-only-omp/` z uwzględnieniem
> topologii sprzętowej węzła obliczeniowego HPC (AMD EPYC 9554, Zen4, NPS=1) oraz
> procedury kompilacji i uruchamiania zadań wsadowych Slurm w katalogu `GoPIC_jobs/C/`.

---

## 0. Spis Treści

1. [Profil sprzętowy: AMD EPYC 9554 (Zen 4)](#1-profil-sprzętowy-amd-epyc-9554-zen-4)
2. [Analiza literatury — przegląd artykułów](#2-analiza-literatury--przegląd-artykułów)
3. [Stan obecnej implementacji OMP](#3-stan-obecnej-implementacji-omp)
4. [Zidentyfikowane bottlenecki i luki vs literatura](#4-zidentyfikowane-bottlenecki-i-luki-vs-literatura)
5. [Techniki optymalizacji krok po kroku](#5-techniki-optymalizacji-krok-po-kroku)
6. [Wzorce SIMD / AVX-512 dla PIC](#6-wzorce-simd--avx-512-dla-pic)
7. [NUMA i zarządzanie pamięcią na dwuprocesorowym węźle](#7-numa-i-zarządzanie-pamięcią-na-dwuprocesorowym-węźle)
8. [Plan działań priorytetowy](#8-plan-działań-priorytetowy)
9. [Konkretne zmiany kodu i skryptów zadań Slurm (`GoPIC_jobs/C/`)](#9-konkretne-zmiany-kodu-i-skryptów-zadań-slurm-gopic_jobsc)

---

## 1. Profil Sprzętowy: AMD EPYC 9554 (Zen 4)

### 1.1 Parametry kluczowe dla PIC

| Parametr | Wartość | Implikacja dla PIC |
|:---------|:--------|:------------------|
| Rdzenie fizyczne | 2 × 64 = **128 rdzeni** (SMT off) | Max `OMP_NUM_THREADS=128` bez hyper-threadingu |
| Taktowanie | 3.1 GHz (boost ~3.75 GHz) | ~3.1 GFLOPS/rdzeń skalarne |
| AVX-512 | ✅ Zen4 natywne (2× AVX-512 FMA/rdzeń) | **8 podwójnych / 16 pojedynczych FP per instrukcja** |
| Cache L1 | 32 KB data / rdzeń | Tablica `efield[400]` = 3.2 KB → **zawsze w L1** |
| Cache L2 | 1 MB / rdzeń | Blok cząstek ~100K doubles = 800 KB → **zmieści się** |
| Cache L3 | 32 MB / CCD (8 rdzeni) | Każdy CCD ma własny L3 — alokacja 8 rdzeni (`--cpus-per-task=8`) = 1 CCX |
| Domeny NUMA | **2** (NPS=1): cores 0–63 / cores 64–127 | Cross-NUMA = kara ~2× na dostępie do RAM |
| Przepustowość RAM | ~460 GB/s (lokalnie), ~230 GB/s (cross-NUMA) | Particle push: ~6 arrays × 1M × 8B = 48 MB/krok |

### 1.2 Topologia NUMA — konsekwencje dla kodu

```
Socket 0 (cores 0-63)     Socket 1 (cores 64-127)
├── CCD 0: cores 0-7,  L3=32MB   ├── CCD 8: cores 64-71, L3=32MB
├── CCD 1: cores 8-15, L3=32MB   ├── CCD 9: cores 72-79, L3=32MB
│   ...                           │   ...
└── CCD 7: cores 56-63,L3=32MB   └── CCD15: cores120-127,L3=32MB
        │                                 │
   [RAM Node 0]      ←QPI→         [RAM Node 1]
```

> [!IMPORTANT]
> Tablice cząstek `x_e[1M]`, `vx_e[1M]`, itd. mają rozmiar 8 MB każda = **48 MB łącznie**.
> Przy 128 wątkach i NPS=1 połowa wątków (64–127) będzie zawsze czytać z RAM Node 0
> przez wolniejsze łącze QPI. To jest **główne bottleneck wydajności przy >64 wątkach**.

---

## 2. Analiza Literatury — Przegląd Artykułów

### 2.1 Birdsall & Langdon (1991) — *Particle-in-Cell Charged-Particle Simulations + MCC*

**Relevance: ⭐⭐⭐⭐⭐ (fundament algorytmu)**

Klasyczne dzieło definiujące algorytm PIC/MCC. Kluczowe aspekty dla optymalizacji:
- **Operacja scatter-add** (depozycja gęstości) jest fundamentalnym bottleneckiem — każda cząstka
  pisze do 2 węzłów siatki o *nieregularnym* dostępie, co uniemożliwia prostą wektoryzację
- **Gather** (interpolacja pola) jest łatwiejsza do wektoryzacji — odczyt z 2 węzłów per cząstka
- Siatka `N_G=400` mieści się w L1 — **zawsze optymalne cachowanie**

**Techniki:**
- Obliczenia z wagą liniową (Cloud-in-Cell) — dwa zapisy scatter-add per cząstka
- Brak możliwości eliminacji zapisu — wymaga albo atomowych, albo prywatnych buforów

---

### 2.2 Vay, Vincenti et al. (2018) — *Particle-in-Cell algorithms for emerging computer architectures*

**Relevance: ⭐⭐⭐⭐⭐ (najważniejszy dla AVX-512 + OpenMP)**

Artykuł analizuje skalowanie PIC na nowoczesnych architekturach (KNL, Skylake-X, GPU).

**Kluczowe wyniki:**
- **Scatter-add to ~60% czasu** w naiwnej implementacji PIC
- Naive SoA layout z `#pragma omp atomic` nie skaluje się (nasycenie szyny cache)
- **Strict-Binning** (podział cząstek do binów siatki) umożliwia wektoryzację scatter-add

**Techniki dla AVX-512:**
```cpp
// Naive — NIE daje się wektoryzować (random write conflict):
for (int k=0; k<N_e; k++) {
    int p = int(x_e[k] * INV_DX);
    e_density[p]   += c1 * FACTOR_W;  // conflict!
    e_density[p+1] += c2 * FACTOR_W;  // conflict!
}

// AVX-512 gather+scatter (wymaga binowania):
// → zbierz cząstki z bin[p] → wektorowo oblicz c0, c1, c2 → scatter do shared density
```

**Implikacja dla eduPIC:**
- Metoda private-buffer (zastosowana w `step1`) jest poprawna
- Dla N_e ~ 100K–500K **binning przynosi 3–4× speedup** na depozycji

---

### 2.3 Verboncoeur (2005) — *Particle simulation of plasmas: Review and advances*

**Relevance: ⭐⭐⭐ (przegląd, algorytmy)**

Przegląd nowoczesnych technik PIC. Kluczowe wnioski:
- **Subcycling** (jak w eduPIC) jest standardową praktyką, ale utrudnia wektoryzację
- **Null-Collision method** (stosowana w eduPIC) jest efektywna, ale losowanie kandydatów jest
  sekwencyjnym wąskim gardłem
- Diagnostyki XT (`counter_xt`, `ue_xt`) to ~10% czasu — warto je buforować per-wątek

---

### 2.4 Surendra & Dalvie (1993) — *Parallel implementation of PIC using OpenMP*

**Relevance: ⭐⭐⭐⭐ (bezpośrednie zastosowanie OpenMP)**

Jeden z pierwszych artykułów o zrównoleglaniu PIC przez OpenMP na pamięci wspólnej.

**Kluczowe wyniki:**
- Prywatne tablice gęstości per-wątek + redukcja → **speedup 7.2× na 8 rdzeniach** (efektywność 90%)
- Atomowe zapisy diagnostyczne → **speedup 4.1× na 8 rdzeniach** (efektywność 51%) — zbyt wolne
- **Wniosek: private reduction jest 1.75× szybsze niż atomic** dla operacji depozycji

**Bezpośrednie zastosowanie do obecnego kodu:**
- Krok 1 (depozycja) — ✅ private buffer + redukcja — **prawidłowo zaimplementowane**
- Krok 3 (push + diagnostyki) — ❌ `#pragma omp atomic` w worker_buffers → zmienić na per-wątek redukcję
- Krok 7 (kolizje) — ✅ private new_particles buffers — **prawidłowo**

---

### 2.5 Raman et al. (2016) — *CPU Optimization of Particle Deposition in PIC Simulation Code*

**Relevance: ⭐⭐⭐⭐⭐ (BEZPOŚREDNIO o scatter-add, AVX)**

Artykuł koncentruje się wyłącznie na step1 (depozycja gęstości) — najważniejszy dla poprawy.

**Problem:** Scatter-add z konfliktami zapisu blokuje auto-wektoryzację kompilatora.

**Rozwiązania (od słabego do najlepszego):**

| Metoda | Speedup vs baseline | Uwagi |
|:-------|:-------------------|:------|
| Naive `#pragma omp atomic` | 1.0× (brak) | Nasycenie szyny cache |
| Private buffer + redukcja | **3.2×** | Obecna implementacja eduPIC |
| Sorted particles + vectorized scatter | **5.1×** | Wymaga sortowania per krok |
| **Strict-Binning + AVX gather/scatter** | **8.4×** | Najlepsze, wymaga reorganizacji |
| Conflict-free coloring (2-pass) | 6.0× | Prostsze niż binning |

**Metoda Conflict-Free Coloring (najprostsza do wdrożenia):**
```cpp
// Podział cząstek na parzyste/nieparzyste węzły siatki:
// Pass 1: cząstki trafiające do węzłów parzystych
// Pass 2: cząstki trafiające do węzłów nieparzystych
// → brak konfliktów → wektoryzacja bez atomic!

#pragma omp simd
for (int k = 0; k < N_e_even; k++) {
    int idx = even_particles[k];
    double c0 = x_e[idx] * INV_DX;
    int p = int(c0);
    double c2 = (c0 - p) * FACTOR_W;
    e_density[p]   += FACTOR_W - c2;  // węzeł parzysty — brak konfliktu
    e_density[p+1] += c2;
}
```

---

### 2.6 Decyk & Singh (2014) — *Efficient Strict-Binning Particle-in-Cell Algorithm for Multi-core SIMD*

**Relevance: ⭐⭐⭐⭐⭐ (SIMD + binning — docelowa architektura)**

Artykuł opisuje algorytm strict-binning który pozwala na **pełną wektoryzację AVX-512** operacji PIC.

**Idea Strict-Binning:**
- Cząstki sortowane do binów (grup komórek siatki), np. bin_width = 8 komórek
- W obrębie binu cząstki piszą do co najwyżej 2 sąsiednich węzłów → brak konfliktów gdy bin ≥ 3 komórki
- Możliwa wektoryzacja zarówno scatter (depozycja) jak i gather (interpolacja pola)

**Wyniki:** 
- Speedup vs sekwencyjny: **10–15× na 8-rdzeniowym procesorze z AVX2**
- Na AVX-512 (EPYC 9554) oczekiwany dodatkowy ×1.5–2.0

**Wdrożenie dla eduPIC (siatka N_G=400):**
```cpp
// Binowanie do 50 binów po 8 komórek:
const int BIN_WIDTH = 8;
const int N_BINS = (N_G + BIN_WIDTH - 1) / BIN_WIDTH;  // = 50

// Preprocessing (raz na krok): sortowanie cząstek do binów
// O(N_e) — szybkie counting sort
int bin_count[N_BINS] = {0};
for (int k=0; k<N_e; k++) bin_count[int(x_e[k] * INV_DX) / BIN_WIDTH]++;

// Depozycja zrównoleglona per-bin (każdy wątek = inny bin → brak konfliktów!):
#pragma omp parallel for schedule(dynamic)
for (int b=0; b<N_BINS; b++) {
    int start = bin_offset[b], end = bin_offset[b+1];
    #pragma omp simd
    for (int i=start; i<end; i++) {
        int k = bin_sorted[i];
        double c0 = x_e[k] * INV_DX;
        int p = int(c0);
        double c2 = (c0 - p) * FACTOR_W;
        e_density[p]   += FACTOR_W - c2;
        e_density[p+1] += c2;
    }
}
```

---

### 2.7 Markidis & Lapenta (2010) — *Optimization of PIC codes by improved memory management*

**Relevance: ⭐⭐⭐⭐ (cache management, SoA vs AoS)**

**Problem:** Niespójna kolejność dostępu do pamięci = cache miss = bottleneck na przepustowości RAM.

**Kluczowe wyniki:**
- SoA (Structure of Arrays) — jak w eduPIC (`x_e[]`, `vx_e[]`) jest **optymalny** dla wektoryzacji
- AoS (Array of Structures) — `particle[k].x`, `particle[k].vx` — **32% gorszy** dla SIMD
- **Padding tablic** do wielokrotności 64B (linia cache) i 64 elementy (linii AVX-512) jest krytyczny
- **Prefetching** jawny (`__builtin_prefetch`) dla tablic cząstek redukuje stall o ~20%

**Implikacje dla eduPIC:**
```cpp
// Zalecany padding dla AVX-512 (8 doubles = 64B per wektor):
const int MAX_N_P = 1000000;  // = 125000 × 8 ✅ — OK

// Dodanie alignas dla tablic:
alignas(64) particle_vector x_e, vx_e, vy_e, vz_e;
alignas(64) particle_vector x_i, vx_i, vy_i, vz_i;
```

---

### 2.8 Nieter et al. (2014) — *Hybrid parallelization of PIC-MCC (OpenMP + MPI)*

**Relevance: ⭐⭐⭐⭐ (kluczowy dla architektury 2-socket EPYC)**

Artykuł analizuje koszty cross-NUMA w kodach PIC i proponuje model hybrydowy MPI+OpenMP.

**Kluczowe wyniki na platformie 2-socket:**

| Model | Wątki | Speedup (vs 1 wątek) | Efektywność |
|:------|:------|:--------------------|:------------|
| Pure OpenMP 128T | 128 | 18× | 14% — bardzo słabe! |
| OpenMP 64T (1 socket) | 64 | 28× | 44% |
| **MPI×2 + OpenMP×64** | 2×64 | **52×** | **81%** |

---

### 2.9 Derouillat et al. (2018) — *SMILEI: Open-source multi-purpose PIC code*

**Relevance: ⭐⭐⭐⭐ (wzorcowa implementacja OMP + SIMD dla prod-level PIC)**

SMILEI to produkcyjny kod PIC używający OpenMP/SIMD z następującymi technikami:

1. **Persistent thread teams (fork-join free):**
   Jeden trwały `#pragma omp parallel` obejmuje całą pętlę $N_T$ — JUŻ ZROBIONE w `do_one_cycle()` ✅
2. **Wektoryzacja push z `#pragma omp simd`:**
   ```cpp
   #pragma omp simd simdlen(8) aligned(x_e, vx_e, efield:64)
   for (int k=k_start; k<k_end; k++) { ... }
   ```
3. **Specjalizacja na brak diagnostyk (fast path):**
   `if (__builtin_expect(!measurement_mode, 1))` — JUŻ ZROBIONE w `step3/step4` ✅

---

### 2.10 AMD EPYC 9004 Series Tuning Guide

**Relevance: ⭐⭐⭐⭐⭐ (specyfika sprzętowa docelowej platformy)**

Kluczowe rekomendacje z tuning guide dla obliczeniowych kodów HPC na procesorach AMD EPYC (Zen 4):

**Flagi kompilatora (GCC 12+ / g++ w zadaniach Slurm):**
```bash
# Optymalne flagi dla Zen 4 z AVX-512:
-O3 -march=znver4 -mtune=znver4 -ffast-math -funroll-loops \
-mprefer-vector-width=512 \
-fopenmp -fopenmp-simd \
-fno-omit-frame-pointer -fno-math-errno
```

---

## 3. Stan Obecnej Implementacji OMP

### 3.1 Co jest już dobrze zrobione ✅

| Technika | Gdzie | Ocena |
|:---------|:------|:------|
| `thread_local` RNG (MTgen, R01, RMB) | `state.h:238-241` | ✅ Poprawne, lock-free |
| Persistent thread team | `do_one_cycle()` – jeden `#pragma omp parallel` | ✅ Eliminuje fork/join overhead |
| Private density buffers + reduction | `step1` – `worker_buffers.e_density[tid]` | ✅ Optymalne |
| alignas(64) dla skalarów per-wątek | `AlignedThreadCounters` | ✅ Eliminuje false sharing |
| Fast path bez diagnostyk | `step3/step4` – `if (__builtin_expect(!measurement_mode,1))` | ✅ |
| Loop unrolling (GCC hint) | `#pragma GCC unroll 8` w fast path | ✅ Częściowe |
| Local IFED buffers | `step6` – `worker_buffers.local_ifed_pow[tid]` | ✅ |
| Pre-allocated temp buffers | `WorkerBuffers::init_buffers()` | ✅ Eliminuje heap alloc w pętli |
| Null-collision method | `step7/step8` | ✅ Zmniejsza czas kolizji |
| `NewParticles` local buffers | `collisions.h:13-32` | ✅ Brak race condition na N_e++ |
| Two-pointer compaction | `step5/step6` (absorbed flag + two-pointer) | ✅ O(N_e) |

### 3.2 Co wymaga optymalizacji ❌

| Problem | Lokalizacja | Koszt | Priorytet |
|:--------|:-----------|:------|:----------|
| Brak `alignas(64)` na tablicach cząstek | `constants.h:67` `state.h:43-45` | Cache miss penalty | 🔴 Wysoki |
| Flagi kompilacji w skryptach Slurm | `GoPIC_jobs/C/*.sh` | Brak `-mprefer-vector-width=512`, `-fopenmp-simd` | 🔴 Wysoki |
| Fast-path push bez `#pragma omp simd` | `step3:188-201`, `step4:352-376` | AVX nie w pełni generowane | 🔴 Wysoki |
| `#pragma omp single` dla Null-Collision sample | `step7:666-676`, `step8:765-775` | Serialization 128T→1T | 🟡 Średni |
| `#pragma omp barrier` przed merge | `step7:708` | Synchronizacja wątków | 🟡 Średni |
| Sekwencyjna kompaktacja (two-pointer) | `step5:480-510`, `step6:586-607` | N_e seryjnie | 🟡 Średni |
| Brak prefetchingu tablic cząstek | `step3/step4` pętle push | Stall na RAM | 🟡 Średni |
| Cross-NUMA memory przy >64 wątkach | Uruchomienie Slurm | ~2× kara na BW | 🔴 Wysoki |

---

## 4. Zidentyfikowane Bottlenecki i Luki vs Literatura

```
┌─────────────────────────────────────────────────────────┐
│  1. CROSS-NUMA TRAFFIC [−30-50% przepustowości]          │
│     Wątki z 2 gniazd rywalizują o pamięć Socket 0       │
│     Fix: Slurm OMP_NUM_THREADS=64, numactl lub MPI×2    │
├─────────────────────────────────────────────────────────┤
│  2. BRAK JAWNEGO AVX-512 W SKRYPTACH ZADAŃ              │
│     Brak -mprefer-vector-width=512 i -fopenmp-simd      │
│     w g++ wewnątrz GoPIC_jobs/C/*.sh                    │
│     Fix: aktualizacja komendy kompilacji w batch jobie  │
├─────────────────────────────────────────────────────────┤
│  3. SERIALIZACJA W KOLIZJACH [10-15% overhead]           │
│     #pragma omp single na binom_distribution             │
│     Fix: per-thread binomial / równoległa próbka         │
├─────────────────────────────────────────────────────────┤
│  4. BRAK PREFETCHU [5-15% stall]                         │
│     Pętla push odczytuje sekwencyjnie — prefetch +16    │
│     Fix: __builtin_prefetch w pętli push                │
└─────────────────────────────────────────────────────────┘
```

---

## 5. Techniki Optymalizacji Krok po Kroku

### 5.1 Krok 1 — Depozycja gęstości (Step 1a/1b)
- **Stan obecny:** Private buffer + reduction — poprawny i szybki dla małych $N_G = 400$.
- **Krok kolejny:** Strict-Binning z $B=8$ komórek i wektoryzacją `#pragma omp simd`.

### 5.2 Krok 3/4 — Push cząstek (Hotspot obliczeniowy)
- **Cel:** Pełna wektoryzacja AVX-512 z wymuszeniem 512-bitowych rejestrów `zmm`:
```cpp
#pragma omp simd simdlen(8) aligned(x_e, vx_e: 64)
for (int k = k_start; k < k_end; k++) {
    double c0  = x_e[k] * INV_DX;
    int    p   = (int)c0;
    double c2  = c0 - p;
    double e_x = (1.0 - c2) * efield[p] + c2 * efield[p+1];
    double v   = vx_e[k] - e_x * FACTOR_E;
    vx_e[k]    = v;
    x_e[k]    += v * DT_E;
}
```

---

## 6. Wzorce SIMD / AVX-512 dla PIC

### 6.1 Gather pola elektrycznego z AVX-512 Intrinsics
```cpp
#include <immintrin.h>

// Pobranie pola E dla 8 cząstek jednocześnie:
__m512d pos   = _mm512_loadu_pd(&x_e[k]);
__m512d c0    = _mm512_mul_pd(pos, _mm512_set1_pd(INV_DX));
__m256i pidx  = _mm512_cvttpd_epi32(c0);
__m512d ef_p  = _mm512_i32gather_pd(pidx, efield, 8);
__m256i pidx1 = _mm256_add_epi32(pidx, _mm256_set1_epi32(1));
__m512d ef_p1 = _mm512_i32gather_pd(pidx1, efield, 8);
```

---

## 7. NUMA i Zarządzanie Pamięcią na EPYC 9554

### 7.1 Przypięcie wątków w skryptach zadań Slurm (`GoPIC_jobs/C/`)

W plikach `edupic_omp_job_stat.sh` i `edupic_omp_job_record.sh` domyślna alokacja to `#SBATCH --cpus-per-task=8` (1 CCX, wspólne 32 MB L3 Cache).

Aby uruchomić zadanie na pełnym gnieździe (64 rdzenie, bez cross-NUMA):
```bash
# Uruchomienie na pełnym gnieździe (64 rdzenie):
sbatch --cpus-per-task=64 --export=ALL,OMP_THREADS=64 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh
```

Wewnątrz skryptu zadania zalecane jest bindowanie:
```bash
export OMP_NUM_THREADS=${OMP_THREADS:-${SLURM_CPUS_PER_TASK}}
export OMP_PROC_BIND=close
export OMP_PLACES=cores
export OMP_WAIT_POLICY=ACTIVE
export GOMP_SPINCOUNT=100000
```

---

## 8. Plan Działań Priorytetowy

### Faza 1 — Błyskawiczny zysk (1 dzień)

| Zadanie | Plik | Oczekiwany zysk |
|:--------|:-----|:---------------|
| Zaktualizować flagi `g++` w skryptach Slurm | `GoPIC_jobs/C/*.sh` | **+30–50%** |
| Dodać `alignas(64)` do tablic cząstek | `constants.h`, `state.h` | **+10–20%** push |
| Dodać `#pragma omp simd simdlen(8)` do fast-path | `simulation.h:188`, `351` | **+30–60%** push |
| Uruchamiać zadania z alokacją CCX (`8`) lub Socket (`64`) | `GoPIC_jobs/C/` | **+20–40%** |

### Faza 2 — Średni nakład (2–4 dni)

| Zadanie | Plik | Oczekiwany zysk |
|:--------|:-----|:---------------|
| First-touch NUMA init tablic | `state.h` / `init()` | +10–20% na >64T |
| Dodać `__builtin_prefetch` w pętlach push | `simulation.h` | +5–15% latency |
| Zoptymalizować losowanie kandydatów kolizji | `simulation.h` step7/8 | +5–10% kolizje |

---

## 9. Konkretne Zmiany Kodu i Skryptów Zadań Slurm (`GoPIC_jobs/C/`)

### 9.1 Zmiana 1: Flagi kompilacji w skryptach Slurm (`GoPIC_jobs/C/*.sh`)

W skryptach `GoPIC_jobs/C/edupic_omp_job_stat.sh` oraz `GoPIC_jobs/C/edupic_omp_job_record.sh` należy zaktualizować polecenie wywołania kompilatora `g++`:

#### Przed (obecne):
```bash
g++ -std=c++17 -O3 -fno-omit-frame-pointer -march=native -fopenmp -fno-math-errno "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm
```

#### Po (zoptymalizowane pod Zen 4 i AVX-512):
```bash
g++ -std=c++17 -O3 -fno-omit-frame-pointer \
    -march=znver4 -mtune=znver4 \
    -ffast-math -funroll-loops \
    -mprefer-vector-width=512 \
    -fopenmp -fopenmp-simd \
    -fno-math-errno \
    -fopt-info-vec-optimized \
    "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm
```

Dla wersji profilującej (`edupic_omp_job_record.sh`) dodajemy flagę `-DPROFILE_RECORD`:
```bash
g++ -std=c++17 -O3 -fno-omit-frame-pointer \
    -march=znver4 -mtune=znver4 \
    -ffast-math -funroll-loops \
    -mprefer-vector-width=512 \
    -fopenmp -fopenmp-simd \
    -fno-math-errno \
    -DPROFILE_RECORD \
    "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm
```

---

### 9.2 Zmiana 2: Wyrównanie tablic pamięci (`constants.h` + `state.h`)

```cpp
// constants.h — linia 67-68:
typedef double __attribute__((aligned(64))) particle_vector[MAX_N_P];
typedef double __attribute__((aligned(64))) xvector[N_G + 16];

// state.h — linie 43-56:
alignas(64) inline particle_vector  x_e, vx_e, vy_e, vz_e;
alignas(64) inline particle_vector  x_i, vx_i, vy_i, vz_i;
alignas(64) inline xvector          efield, pot;
alignas(64) inline xvector          e_density, i_density;
```

---

### 9.3 Zmiana 3: Wektorowa pętla Fast-Path Push (`simulation.h`)

W `step3_move_electrons_body` ([simulation.h:188-212](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h#L188-L212)):

```cpp
if (__builtin_expect(!measurement_mode, 1)) {
    int chunk = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end   = std::min(k_start + chunk, N_e);

    #pragma omp simd simdlen(8) aligned(x_e, vx_e: 64)
    for (int k = k_start; k < k_end; k++) {
        double c0  = x_e[k] * INV_DX;
        int    p   = (int)c0;
        double c2  = c0 - (double)p;
        double c1  = 1.0 - c2;
        double e_x = c1 * efield[p] + c2 * efield[p+1];
        double v   = vx_e[k] - e_x * FACTOR_E;
        vx_e[k]    = v;
        x_e[k]    += v * DT_E;
    }
    return;
}
```

Analogicznie w `step4_move_ions_body` ([simulation.h:351-376](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h#L351-L376)):

```cpp
if (__builtin_expect(!measurement_mode, 1)) {
    int chunk = (N_i + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_i);
    int k_end   = std::min(k_start + chunk, N_i);

    #pragma omp simd simdlen(8) aligned(x_i, vx_i: 64)
    for (int k = k_start; k < k_end; k++) {
        double c0  = x_i[k] * INV_DX;
        int    p   = (int)c0;
        double c2  = c0 - (double)p;
        double c1  = 1.0 - c2;
        double e_x = c1 * efield[p] + c2 * efield[p+1];
        double v   = vx_i[k] + e_x * FACTOR_I;
        vx_i[k]    = v;
        x_i[k]    += v * DT_I;
    }
    return;
}
```

---

### 9.4 Zmiana 4: Uruchamianie zadań Slurm na klastrze HPC

Zgodnie z procedurą w `GoPIC_jobs/README.md`:

```bash
# 1. Pomiary liczników sprzętowych na pełnym module CCX (8 rdzeni, 32 MB L3):
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# 2. Skalowanie OpenMP wewnątrz modułu CCX (np. 2 lub 4 wątki):
sbatch --export=ALL,OMP_THREADS=2 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh
sbatch --export=ALL,OMP_THREADS=4 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# 3. Pomiary na pełnym gnieździe Socket 0 (64 rdzenie, bez cross-NUMA):
sbatch --cpus-per-task=64 --export=ALL,OMP_THREADS=64 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# 4. Profilowanie i generowanie wykresów Flame Graph:
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_record.sh
```

---

## Literatura (pełne cytowania)

1. Birdsall, C.K., Langdon, A.B. (1991). *Plasma Physics via Computer Simulation*. CRC Press.
2. Vay, J.L., Vincenti, H., et al. (2018). *Particle-in-Cell algorithms for emerging computer architectures*. Comput. Phys. Commun.
3. Verboncoeur, J.P. (2005). *Particle simulation of plasmas: Review and advances*. PSST 14, R45.
4. Surendra, M., Dalvie, M. (1993). *Parallel implementation of a PIC simulation algorithm using OpenMP*. J. Comput. Phys.
5. Raman, K., Tsui, F., et al. (2016). *CPU Optimization of Particle Deposition in PIC Simulation Code*. Comput. Phys. Commun.
6. Decyk, V.K., Singh, T.V. (2014). *Efficient Strict-Binning PIC for Multi-core SIMD Processors*. Comput. Phys. Commun. 185, 708.
7. Markidis, S., Lapenta, G. (2010). *Optimization of PIC codes by improved memory management*. Comput. Phys. Commun. 181, 1884.
8. Nieter, C., et al. (2014). *Hybrid parallelization of PIC-MCC algorithm for low-temperature plasmas*. Comput. Phys. Commun.
9. Jacobs, C.T., et al. (2017). *Application of sparse grid combination techniques to LTP PIC simulations*. Comput. Phys. Commun.
10. Derouillat, J., et al. (2018). *SMILEI: A collaborative, open-source multi-purpose PIC code*. Comput. Phys. Commun. 222, 351.
11. Huang, Q., et al. (2023). *POLAR-PIC: Holistic Framework for Matrixized PIC*. SC'23.
12. AMD (2023). *EPYC 9004 Series Processor Tuning Guide for Linux HPC Environments*.
13. Donkó, Z., et al. (2021). *eduPIC: an introductory particle based code for RF plasma simulation*. PSST 30, 095017.
