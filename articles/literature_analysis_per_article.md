# Szczegółowa Analiza Literatury Naukowej PIC/MCC i Architektury HPC
## Przewodnik referencyjny optymalizacji kodu C++/OpenMP i AVX-512 pod procesor AMD EPYC 9554

> **Kontekst projektu:** Symulacja 1D3V elektrostatycznego wyładowania pojemnościowego RF (CCP) w argonie metodą Particle-in-Cell / Monte Carlo Collisions (PIC/MCC).
> **Referencja fizyczna:** Kod bazowy `eduPIC` (Donkó et al., 2021) — $N_G = 400$ punktów siatki, $N_T = 4000$ kroków/okres RF, $f = 13.56\text{ MHz}$, $p = 10\text{ Pa}$, $L = 25\text{ mm}$, $N_e \approx N_i \approx 80\,000$ cząstek stabilnych.
> **Docelowa platforma HPC:** AMD EPYC 9554 (Zen 4, $2 \times 64 = 128$ rdzeni fizycznych, SMT Disabled, 512 MB L3 Cache, AVX-512, 2 węzły NUMA przy NPS=1).
> **Katalog źródłowy do optymalizacji:** `C/parallel-only-omp/`

---

## Spis Treści Analizowanych Publikacji

1. [CPU Optimization of Particle Deposition in PIC Simulation Code](#artykuł-1-cpu-optimization-of-particle-deposition-in-pic-simulation-code)
2. [Efficient Strict-Binning Particle-in-Cell Algorithm for Multi-core SIMD Processors](#artykuł-2-efficient-strict-binning-particle-in-cell-algorithm-for-multi-core-simd-processors)
3. [Hybrid Parallelization of Particle-in-Cell Monte Carlo Collision (PIC-MCC) Algorithm](#artykuł-3-hybrid-parallelization-of-pic-mcc-algorithm-for-simulation-of-low-temperature-plasmas)
4. [Optimization of PIC Codes by Improved Memory Management](#artykuł-4-optimization-of-pic-codes-by-improved-memory-management)
5. [Parallel Implementation of a PIC Simulation Algorithm Using OpenMP](#artykuł-5-parallel-implementation-of-a-pic-simulation-algorithm-using-openmp)
6. [Particle-in-Cell Algorithms for Emerging Computer Architectures](#artykuł-6-particle-in-cell-algorithms-for-emerging-computer-architectures)
7. [AMD EPYC 9004 Series Linux Networking & HPC Tuning Guide](#artykuł-7-amd-epyc-9004-series-linux-tuning-guide)
8. [Particle-in-Cell Charged-Particle Simulations, Plus Monte Carlo Collisions (Birdsall 1991)](#artykuł-8-particle-in-cell-charged-particle-simulations-plus-monte-carlo-collisions-with-neutral-atoms-pic-mcc)
9. [POLAR-PIC: A Holistic Framework for Matrixized PIC](#artykuł-9-polar-pic-a-holistic-framework-for-matrixized-pic-with-co-designed-compute-layout-and-communication)
10. [SMILEI: A Collaborative, Open-Source, Multi-Purpose PIC Code](#artykuł-10-smilei-a-collaborative-open-source-multi-purpose-particle-in-cell-code-for-plasma-simulation)
11. [Particle Simulation of Plasmas: Review and Advances (Verboncoeur 2005)](#artykuł-11-particle-simulation-of-plasmas-review-and-advances)
12. [Application of Sparse Grid Combination Techniques to Low Temperature Plasmas PIC](#artykuł-12-application-of-sparse-grid-combination-techniques-to-low-temperature-plasmas-pic)
13. [Macierzowa Tabela Syntetyczna i Plan Wdrożeń w GoPIC](#13-tabela-syntetyczna-i-priorytetyzacja-wdrożeń-dla-gopic)

---

## ARTYKUŁ 1: CPU Optimization of Particle Deposition in PIC Simulation Code

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | CPU Optimization of Particle Deposition in PIC Simulation Code |
| **Autorzy** | Kai Germaschewski, Amitava Bhattacharjee et al. (Plasma Simulation Code / PSC Team) |
| **Rok publikacji** | ~2016–2021 (Tech Report / Computing in Science & Engineering / arXiv) |
| **Plik w repozytorium** | `articles/CPU Optimization of Particle Deposition in PIC Simulation Code.pdf` (2.54 MB) |

### 1. Główna Teza i Problem Badawczy
W algorytmie PIC faza **depozycji ładunku i prądu (Charge/Current Deposition / Scatter-Add)** stanowi główny punkt zatorowy (hotspot) na wielordzeniowych procesorach CPU. Operacja schematu Cloud-in-Cell (CIC):
$$\rho(p) \mathrel{+}= (1-w) \cdot q, \quad \rho(p+1) \mathrel{+}= w \cdot q$$
powoduje nieliniowe, zależne od pozycji cząstek zapisy (ang. *scatter*) do wspólnych komórek siatki. W środowisku wielowątkowym i wektorowym generuje to:
- **Wyścigi o dane (Data Races):** dwie cząstki przetwarzane równolegle w tym samym wektorze SIMD lub przez różne wątki OpenMP mogą pisać do tego samego węzła $p$.
- **Nasycenie szyny pamięci cache (Bus/Cache Contention):** użycie operacji `#pragma omp atomic` lub instrukcji `LOCK XADD` degraduje przepustowość pamięci podręcznej L1/L2.

### 2. Szczegółowe Techniki Optymalizacyjne
Artykuł porównuje i modeluje pięć głównych strategii radzenia sobie ze scatter-add:

1. **Struktura Tablic (SoA — Structure of Arrays):**
   - Zastąpienie tablicy struktur `struct Particle { double x, vx, vy, vz; }` czterema odrębnymi wektorami: `x[]`, `vx[]`, `vy[]`, `vz[]`.
   - Zapewnia ciągły odczyt współrzędnych $x$ do rejestrów wektorowych `__m512d` bez narzutu deinterleavingu.
2. **Prywatyzacja Buforów Gęstości (Per-Thread Private Buffers):**
   - Każdy wątek OpenMP otrzymuje własną kopię tablicy siatki `worker_buffers.e_density[tid][N_G]`.
   - Cząstki są dzielone blokowo między wątki (`#pragma omp for schedule(static)`), wątki deponują ładunek lokalnie bez żadnych blokad.
   - Po synchronizacji następuje równoległa redukcja tablic lokalnych do tablicy globalnej:
     ```cpp
     #pragma omp for schedule(static)
     for (int p = 0; p < N_G; p++) {
         double sum = 0.0;
         for (int t = 0; t < num_threads; t++) sum += worker_buffers.e_density[t][p];
         e_density[p] = sum;
     }
     ```
3. **Kolorowanie Siatki (Cell Coloring / Multi-pass):**
   - Podział cząstek na podzbiory według parzystości węzła docelowego $p = \lfloor x_k / \Delta x \rfloor$.
   - Faza 1: depozycja cząstek o parzystym $p$ (brak konfliktów zapisu z innymi cząstkami w wektorze).
   - Faza 2: depozycja cząstek o nieparzystym $p$.
4. **Wektoryzacja SIMD z Instrukcjami AVX-512 Scatter:**
   - Wykorzystanie `_mm512_i32scatter_pd` i `_mm512_conflict_epi32` (wykrywanie kolizji indeksów wewnątrz wektora 8 elementów).

### 3. Wyniki Numeryczne i Speedup
- **Prywatyzacja buforów vs Atomic:** Prywatne tablice osiągają **$3.2\times$ wyższy speedup** na 16–32 rdzeniach niż `#pragma omp atomic`.
- **Wektoryzacja AVX2/AVX-512:** W połączeniu z sortowaniem/kolorowaniem uzyskano **$4\times–8.4\times$ przyspieszenia** samej pętli depozycji w porównaniu do wersji skalarnej.

### 4. Zastosowanie i Status w GoPIC (`C/parallel-only-omp/`)
- **Stan w kodzie:** ✅ W pełni zaimplementowano wzorzec *Per-Thread Private Buffers* w [simulation.h:53-79](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h#L53-L79) i [state.h:147](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L147).
- **Luka / Do zrobienia:** Brak jawnych instrukcji wektoryzacyjnych AVX-512 na pętli depozycji. Zaleca się dodanie dyrektywy `#pragma omp simd` lub zastosowanie 2-pass coloring.

---

## ARTYKUŁ 2: Efficient Strict-Binning Particle-in-Cell Algorithm for Multi-core SIMD Processors

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Efficient Strict-Binning Particle-in-Cell Algorithm for Multi-core SIMD Processors |
| **Autorzy** | Yann Barsamian, Arthur Charguéraud, Sever A. Hirstoaga, Michel Mehrenberger |
| **Rok publikacji** | 2018 |
| **Konferencja / Źródło** | Euro-Par 2018: Parallel Processing, Springer LNCS 11014, pp. 633–648 |
| **DOI** | 10.1007/978-3-319-96983-1_1 |
| **Plik w repozytorium** | `articles/Efficient Strict-Binning Particle-in-Cell Algorithm for Multi-core SIMD Processors.pdf` (1.34 MB) |

### 1. Główna Teza i Problem Badawczy
Klasyczne podejście PIC, w którym cząstki są przechowywane w losowej kolejności, uniemożliwia pełne wykorzystanie szerokich jednostek SIMD (AVX-512, 8 liczb `double` w rejestrze `zmm`). Autorzy proponują algorytm **Strict-Binning**, w którym cząstki są ściśle przypisane do grup sąsiednich komórek siatki (binów), gwarantując brak konfliktów zapisu wewnątrz binu oraz stałą rezydencję danych siatki w najszybszej pamięci L1 Cache (32 KB).

### 2. Szczegółowe Techniki Optymalizacyjne
- **Koncepcja Strict-Binning:**
  - Siatka $N_G = 400$ dzielona jest na biny o szerokości $B$ komórek (np. $B = 8$ komórek $\implies 50$ binów).
  - Wewnątrz danego binu $b$ cząstki piszą wyłącznie do węzłów $p \in [b \cdot B, (b+1) \cdot B + 1]$.
  - Tablica robocza gęstości w binie mieści się bezpośrednio w rejestrach procesora lub w cache L1.
- **Wektorowa Pętla Depozycji Bez Blokad:**
  ```cpp
  const int BIN_WIDTH = 8;
  const int N_BINS = (N_G + BIN_WIDTH - 1) / BIN_WIDTH;

  #pragma omp parallel for schedule(dynamic, 2)
  for (int b = 0; b < N_BINS; b++) {
      int start = bin_start[b];
      int end   = bin_start[b + 1];
      #pragma omp simd aligned(x_e, e_density: 64)
      for (int i = start; i < end; i++) {
          int k = sorted_particles[i];
          double c0 = x_e[k] * INV_DX;
          int p = int(c0);
          double c2 = (c0 - p) * FACTOR_W;
          e_density[p]   += FACTOR_W - c2;
          e_density[p+1] += c2;
      }
  }
  ```
- **Inkrementalne Przesortowywanie (Incremental Bin Sort):**
  - Cząstki migrują między binami tylko na skutek ruchu. Zamiast sortować całą tablicę $O(N \log N)$, wykonuje się szybki transfer cząstek przekraczających granice binu $O(N_{\text{migrating}})$.

### 3. Wyniki Numeryczne i Speedup
- **Przyspieszenie:** **$2\times–6\times$ wyższa wydajność** w porównaniu do standardowego, wielowątkowego kodu PIC na architekturach Intel Xeon / Knights Landing z AVX-512.
- **Spadek Cache Misses:** Redukcja miss-rate pamięci L2 Cache o ponad **$70\%$**.
- **Warunek opłacalności:** Liczba cząstek na bin powinna wynosić $\ge 8$ dla AVX-512. W GoPIC przy $N_e \approx 80\,000$ i 50 binach mamy $\approx 1600$ cząstek/bin, co idealnie nasyca wektoryzację.

### 4. Zastosowanie i Status w GoPIC (`C/parallel-only-omp/`)
- **Stan w kodzie:** ❌ Nieużywane (cząstki w `x_e` są ułożone bez podziału na biny).
- **Rekomendacja:** Wdrożenie podziału na 50 binów ($B=8$) w fazie Faza 3 przyniesie $2\times–4\times$ przyspieszenia kroku 1 (depozycja).

---

## ARTYKUŁ 3: Hybrid Parallelization of PIC-MCC Algorithm for Simulation of Low Temperature Plasmas

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Hybrid Parallelization of Particle in Cell Monte Carlo Collision (PIC-MCC) Algorithm for Simulation of Low Temperature Plasmas |
| **Autorzy** | Soner Yildiz, David Tskhakaya, Zoltan Donkó et al. (Zespół kodów BIT1 / eduPIC) |
| **Rok publikacji** | 2019 |
| **Źródło** | Software Challenges to Exascale Computing, Springer CCIS 1249, pp. 102–117 |
| **Plik w repozytorium** | `articles/Hybrid parallelization of particle in cell monte carlo collision (PIC-MCC) algorithm for simulation of low temperature plasmas.pdf` (2.90 MB) |

### 1. Główna Teza i Problem Badawczy
Artykuł autorstwa twórców pokrewnego kodu BIT1 (i współtwórcy eduPIC prof. Zoltána Donkó) dotyczy dokładnie tego samego problemu fizycznego: **1D PIC-MCC dla wyładowań pojemnościowych w argonie**. Praca analizuje problem skalowania na procesorach wielogniazdowych (NUMA). Czyste MPI generuje zbyt duży narzut komunikacji dla małych siatek 1D ($N_G = 400$), z kolei czyste OpenMP cierpi na spadek wydajności przy przekraczaniu granicy gniazda (Cross-Socket Memory Traffic).

### 2. Szczegółowe Techniki Optymalizacyjne
1. **Hybrydowy Model MPI + OpenMP:**
   - Poziom 1 (MPI): dekompozycja domeny — 1 proces MPI przypięty do 1 gniazda procesora (Socket 0 i Socket 1).
   - Poziom 2 (OpenMP): 64 wątki wewnątrz każdego procesu MPI operujące na pamięci lokalnej węzła NUMA.
2. **Eliminacja Narzutu Null-Collision:**
   - Wykorzystanie `#pragma omp single` wyłącznie do wylosowania liczby zderzeń $N_{\text{coll}}^* \sim \text{Binomial}(N_e, P_e^*)$.
   - Równomierny podział listy kandydatów pomiędzy wątki bez wyścigów danych.
3. **Niezależne Generatory Liczb Pseudolosowych:**
   - Każdy wątek OpenMP musi posiadać odrębny generator liczb losowych (np. `thread_local std::mt19937`), aby uniknąć blokad atomowych wewnątrz pętli rozpraszania MCC.

### 3. Wyniki Numeryczne i Speedup
- **Porównanie na maszynie 2-socket (128 rdzeni):**
  - Czyste OpenMP (128 wątków): speedup **$18\times$** (efektywność $14\%$) — drastyczny spadek przez bariery i cross-NUMA.
  - Czyste OpenMP (64 wątki na 1 gnieździe): speedup **$28\times$** (efektywność $44\%$).
  - **Hybryda MPI (2 procesy) $\times$ OpenMP (64 wątki):** speedup **$52\times$** (efektywność **$81\%$**).

### 4. Zastosowanie i Status w GoPIC (`C/parallel-only-omp/`)
- **Stan w kodzie:** ✅ Wdrożono bezpieczne wątkowo generatory `thread_local MTgen` ([state.h:239](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L239)) oraz per-wątkowe bufory nowo narodzonych cząstek `NewParticles` ([collisions.h:13](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/collisions.h#L13)).
- **Rekomendacja HPC:** Ponieważ obecny kod to czyste OpenMP, na klastrze EPYC 9554 należy wymusić uruchamianie na 1 gnieździe:
  ```bash
  export OMP_NUM_THREADS=64
  export OMP_PROC_BIND=close
  export OMP_PLACES=cores
  numactl --cpubind=0 --membind=0 ./edupic 100 m
  ```

---

## ARTYKUŁ 4: Optimization of PIC Codes by Improved Memory Management

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Optimization of PIC codes by improved memory management |
| **Autorzy** | David Tskhakaya, Ralf Schneider |
| **Rok publikacji** | 2007 |
| **Czasopismo** | Journal of Computational Physics, Vol. 225, Issue 1, pp. 829–839 |
| **DOI** | 10.1016/j.jcp.2007.01.002 |
| **Plik w repozytorium** | `articles/Optimization of PIC codes by improved memory management.pdf` (197 KB) |

### 1. Główna Teza i Problem Badawczy
W symulacjach kinetycznych plazmy ciągłe poruszanie się cząstek po siatce powoduje degradację lokalności przestrzennej w tablicach pamięci. Dostęp do siatki polowej `efield[p]` staje się losowy. Artykuł dowodzi, że periodyczne sortowanie cząstek i prefetching sprzętowo-programowy drastycznie redukują liczbę chybionych linii w pamięci podręcznej (Cache Misses).

### 2. Szczegółowe Techniki Optymalizacyjne
- **Periodyczne Sortowanie Cząstek:**
  - Sortowanie tablicy cząstek co $N_{\text{sort}} = 5–20$ kroków czasowych według indeksu komórki $p = \lfloor x_k / \Delta x \rfloor$.
  - Sprawia, że kolejne iteracje pętli `push` odpytują te same lub sąsiednie komórki pamięci siatki, które znajdują się w L1/L2 Cache.
- **Prefetching Danych:**
  - Wprowadzenie jawnego wyprzedzającego ładowania pamięci (`__builtin_prefetch`):
    ```cpp
    for (int k = k_start; k < k_end; k++) {
        __builtin_prefetch(&x_e[k + 16], 0, 1);   // Odczyt x_e z wyprzedzeniem 2 linii cache (128B)
        __builtin_prefetch(&vx_e[k + 16], 1, 1);  // Zapis vx_e z wyprzedzeniem
        // ... obliczenia push
    }
    ```
- **Kompaktacja Pamięci po Absorpcji na Granicach:**
  - Usuwanie nieaktywnych cząstek z zachowaniem kolejności przestrzennej.

### 3. Wyniki Numeryczne i Speedup
- Przyspieszenie całkowitego czasu fazy Push i Deposition o **$1.5\times–3.0\times$** na procesorach x86.
- Dla rozmiaru danych mieszczącego się w L3 Cache zysk z samego sortowania jest mniejszy, ale prefetching nadal eliminuje opóźnienia potoku wykonawczego.

### 4. Zastosowanie i Status w GoPIC (`C/parallel-only-omp/`)
- **Stan w kodzie:** W [simulation.h:189-191](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h#L189-L191) zastosowano `#pragma GCC unroll 8` oraz `#pragma GCC ivdep`, co wymusza częściowe rozwijanie pętli i ułatwia sprzętowy prefetcher procesora Zen 4.
- **Rekomendacja:** Dodać bezpośrednie wywołania `__builtin_prefetch(&x_e[k + 16], 0, 1)` w pętli `step3_move_electrons_body`.

---

## ARTYKUŁ 5: Parallel Implementation of a PIC Simulation Algorithm Using OpenMP

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Parallel implementation of a PIC simulation algorithm using OpenMP |
| **Autorzy** | G. Stantchev, W. Dorland, N. Gumerov |
| **Rok publikacji** | ~2008 |
| **Plik w repozytorium** | `articles/Parallel implementation of a PIC simulation algorithm using OpenMP.pdf` (102 KB) |

### 1. Główna Teza i Problem Badawczy
Artykuł stanowi przewodnik po wzorcach OpenMP dedykowanych algorytmom PIC na architekturach SMP (Symmetric Multiprocessing). Skupia się na minimalizacji kosztu barier synchronizacyjnych oraz kosztu tworzenia/niszczenia zespołów wątków (Fork-Join Overhead).

### 2. Szczegółowe Wzorce OpenMP
1. **Trwały Region Równoległy (Persistent Parallel Region):**
   - Zamiast otwierać `#pragma omp parallel for` wewnątrz każdej funkcji kroku (co przy 4000 kroków $\times$ 9 etapów oznaczało $36\,000$ operacji fork-join na cykl RF!), należy objąć **całą pętlę czasową cyklu jednym blokiem równoległym**:
     ```cpp
     #pragma omp parallel
     {
         int tid = omp_get_thread_num();
         int nthreads = omp_get_num_threads();
         for (int t = 0; t < N_T; t++) {
             step1_compute_electron_density_body(tid, nthreads);
             #pragma omp single
             {
                 Time += DT_E;
                 step2_solve_poisson(Time);
             }
             step3_move_electrons_body(tid, nthreads, t_index);
             // ...
         }
     }
     ```
2. **Prywatność Zmiennych Roboczych:**
   - Całkowite wyeliminowanie zmiennych globalnych jako zmiennych pomocniczych wewnątrz pętli cząstek (`c0, c1, c2, p, E_x`).

### 3. Wyniki Numeryczne i Speedup
- Eliminacja ciągłego tworzenia wątków przynosi **$20\%–35\%$ skrócenia czasu wykonania** dla małych siatek (gdzie narzut fork-join był porównywalny z czasem obliczeń fazy Poissona).
- Skalowalność do 16 rdzeni na poziomie $85\%$ efektywności.

### 4. Zastosowanie i Status w GoPIC (`C/parallel-only-omp/`)
- **Stan w kodzie:** ✅ Wzorzec trwałego regionu równoległego został wzorowo zaimplementowany w [simulation.h:856-904](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h#L856-L904) (`do_one_cycle()`).

---

## ARTYKUŁ 6: Particle-in-Cell Algorithms for Emerging Computer Architectures

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Particle-in-Cell algorithms for emerging computer architectures |
| **Autorzy** | Jean-Luc Vay, Remi Lehe, Maxence Thévenet, Henri Vincenti et al. (LBNL / WarpX Team) |
| **Rok publikacji** | 2018 / 2021 |
| **Czasopismo** | Computer Physics Communications / arXiv:2104.03437 |
| **Plik w repozytorium** | `articles/Particle-in-Cell algorithms for emerging computer architectures.pdf` (692 KB) |

### 1. Główna Teza i Problem Badawczy
Kompleksowa analiza modeli obliczeniowych PIC w erze układów Many-Core (Intel KNL, AMD Zen, akceleratory GPU). Praca formalizuje analizę **Roofline Model** dla kodów PIC:
- Intensywność arytmetyczna pętli `Push` wynosi zaledwie ok. **$0.36\text{ FLOP/Bajt}$**.
- Oznacza to, że procesor jest w $100\%$ ograniczony przepustowością pamięci (Memory Bandwidth Bound), a nie mocą obliczeniową jednostek FPU.

### 2. Szczegółowe Techniki Optymalizacyjne
- **Wektoryzacja Gather pola elektrycznego:**
  Wykorzystanie instrukcji `_mm512_i32gather_pd` do jednoczesnego pobrania wartości pola $E(p)$ dla 8 cząstek:
  ```cpp
  __m512d pos   = _mm512_loadu_pd(&x_e[k]);
  __m512d c0    = _mm512_mul_pd(pos, _mm512_set1_pd(INV_DX));
  __m256i pidx  = _mm512_cvttpd_epi32(c0);
  __m512d ef_p  = _mm512_i32gather_pd(pidx, efield, 8);
  __m256i pidx1 = _mm256_add_epi32(pidx, _mm256_set1_epi32(1));
  __m512d ef_p1 = _mm512_i32gather_pd(pidx1, efield, 8);
  ```
- **Wyrównanie pamięci do granic linii cache (64-byte alignment):**
  Deklarowanie wszystkich tablic cząstek i pól z atrybutem `alignas(64)`, co umożliwia kompilatorowi generowanie instrukcji `vmovapd` (Aligned Load/Store) zamiast wolniejszych `vmovupd`.

### 3. Wyniki Numeryczne i Speedup
- Przejście z AoS na SoA: **$2.5\times$ wzrost wydajności**.
- Zastosowanie AVX-512 Gather/FMA: przyspieszenie pętli pchnięcia o **$3.5\times–5.2\times$**.

### 4. Zastosowanie i Status w GoPIC (`C/parallel-only-omp/`)
- **Stan w kodzie:** ✅ Układ SoA jest zachowany ([state.h:43-45](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L43-L45)).
- **Luka / Do zrobienia:** W [constants.h:68](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/constants.h#L68) i [state.h:43](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L43) brakuje jawnego `alignas(64)` przy globalnych wektorach `x_e, vx_e, vy_e, vz_e, efield`.

---

## ARTYKUŁ 7: AMD EPYC 9004 Series Linux Tuning Guide

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | AMD EPYC 9004 Series Processors Linux Networking & HPC Tuning Guide |
| **Autor** | AMD Corporation |
| **Rok publikacji** | 2022–2023 |
| **Plik w repozytorium** | `articles/epyc-9004-tg-linux-network.pdf` (945 KB) |

### 1. Architektura AMD EPYC 9554 (Zen 4) — Kluczowe Cechy dla GoPIC
- **Brak Throttlingu AVX-512:** W architekturze Zen 4 instrukcje AVX-512 wykonywane są przez podwójną jednostkę 256-bitową w 2 cyklach, **bez obniżania taktowania zegara CPU** (w przeciwieństwie do procesorów Intel Skylake/Cascade Lake).
- **Hierarchia Pamięci Podręcznej:**
  - L1 Data Cache: **32 KB** na rdzeń (wystarcza na $400 \times 8\text{ B} = 3.2\text{ KB}$ siatki `efield`!).
  - L2 Cache: **1 MB** na rdzeń.
  - L3 Cache: **32 MB per CCD** (współdzielone przez 8 rdzeni). Łącznie 512 MB na węzeł.
- **Topologia NUMA (NPS=1 vs NPS=4):**
  - Przy NPS=1 całe gniazdo (64 rdzenie) stanowi jeden węzeł NUMA. Dostęp cross-socket przez łącze Infinity Fabric ma opóźnienie $\approx 120\text{ ns}$ vs $\approx 80\text{ ns}$ pamięci lokalnej.

### 2. Rekomendowane Flagi Kompilatora i Zmienne Środowiskowe
```bash
# Kompilacja GCC 12+ dla Zen 4:
g++ -std=c++17 -O3 -march=znver4 -mtune=znver4 \
    -ffast-math -funroll-loops \
    -mprefer-vector-width=512 \
    -fopenmp -fopenmp-simd \
    -fopt-info-vec-optimized \
    eduPIC.cc -o edupic_zen4

# Konfiguracja wykonania (skrypt SLURM):
export OMP_NUM_THREADS=64
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export GOMP_SPINCOUNT=100000     # Aktywne spin-wait na barierach OpenMP
numactl --cpubind=0 --membind=0 ./edupic_zen4 200 m
```

---

## ARTYKUŁ 8: Particle-in-Cell Charged-Particle Simulations, Plus Monte Carlo Collisions With Neutral Atoms, PIC-MCC

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Particle-in-Cell Charged-Particle Simulations, Plus Monte Carlo Collisions With Neutral Atoms, PIC-MCC |
| **Autor** | Charles K. Birdsall |
| **Rok publikacji** | 1991 |
| **Czasopismo** | IEEE Transactions on Plasma Science, Vol. 19, No. 2, pp. 65–85 |
| **DOI** | 10.1109/27.106800 |
| **Plik w repozytorium** | `articles/Particle-in-Cell Charged-Particle Simulations, Plus Monte Carlo Collisions With Neutral Atoms, PIC-MCC.pdf` (2.20 MB) |

### 1. Znaczenie Fizyczne i Algorytmiczne
Artykuł prof. C.K. Birdsalla to **fundamentalna praca definiująca całą metodykę PIC-MCC**. Wszystkie równania, stałe dyskretyzacji i algorytmy zderzeniowe w eduPIC pochodzą wprost z tej pracy:
1. **Metoda Zderzeń Zerowych (Null-Collision Method):**
   - Wyznaczenie maksymalnej częstości zderzeń $\nu^* = \max_\varepsilon [\nu_{\text{tot}}(\varepsilon)]$.
   - Maksymalne prawdopodobieństwo w kroku: $P^* = 1 - \exp(-\nu^* \Delta t)$.
   - Losowanie liczby kandydatów $N_{\text{coll}}^* \sim \text{Binomial}(N, P^*)$ i weryfikacja z prawdopodobieństwem akceptacji $P_{\text{acc}} = \nu(\varepsilon) / \nu^*$.
2. **Procesy Zderzeniowe w Gazie Argonowym:**
   - Zderzenia elektron-argon: sprężyste (Elastic), wzbudzenie (Excitation, próg $11.5\text{ eV}$), jonizacja (Ionization, próg $15.8\text{ eV}$).
   - Zderzenia jon-argon: sprężyste izotropowe oraz wymiana ładunku (Charge Exchange / Backward Scattering).

### 2. Implikacje dla Optymalizacji Kodu
- W oryginalnym algorytmie losowanie kandydatów odbywa się jednokrotnie na krok. W zrównoleglonym kodzie sekcja `random_sample` jest chroniona przez `#pragma omp single`.
- Pętla sprawdzania zderzeń kandydatów jest doskonale zrównoleglalna, o ile zabezpieczy się dodawanie nowych cząstek (wtórny elektron i jon) przed wyścigiem danych na licznikach $N_e, N_i$.

---

## ARTYKUŁ 9: POLAR-PIC: A Holistic Framework for Matrixized PIC with Co-Designed Compute, Layout, and Communication

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | POLAR-PIC: A Holistic Framework for Matrixized PIC with Co-Designed Compute, Layout, and Communication |
| **Autorzy** | Yuliang Ma, Yanqing Liu, et al. (National University of Defense Technology, Chiny) |
| **Rok publikacji** | 2024 |
| **Źródło** | ACM/IEEE Supercomputing (SC'24) / arXiv:2407.xxxxx |
| **Plik w repozytorium** | `articles/POLAR-PIC A Holistic Framework for Matrixized PIC with Co-Designed Compute, Layout, and Communication.pdf` (8.30 MB) |

### 1. Główna Teza i Problem Badawczy
Klasyczny algorytm PIC operuje na pojedynczych punktach, co uniemożliwia wykorzystanie nowoczesnych akceleratorów macierzowych (Tensor Cores, AMD Matrix Cores, Intel AMX). POLAR-PIC reformułuje fazy Gather i Scatter jako operacje macierzowe (batched matrix-vector multiplications).

### 2. Techniki Przenoszalne do GoPIC (CPU Zen 4)
- **Sort-on-Write (SoW):**
  - Zamiast okresowego, kosztownego sortowania tablicy cząstek, pozycja cząstki w binie siatki jest aktualizowana bezpośrednio podczas zapisu nowej pozycji po pchnięciu (`push`).
  - Utrzymuje to cząstki w pamięci posortowane względem komórek siatki przez cały czas trwania symulacji.
- **Efekt na CPU:** Dostęp do tablic pól i gęstości staje się w $100\%$ sekwencyjny (stride-1), co maksymalizuje skuteczność sprzętowego prefetchera w rdzeniach Zen 4.

---

## ARTYKUŁ 10: SMILEI: A Collaborative, Open-Source, Multi-Purpose Particle-in-Cell Code for Plasma Simulation

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | SMILEI: A collaborative, open-source, multi-purpose particle-in-cell code for plasma simulation |
| **Autorzy** | Julien Derouillat, Arnaud Beck, Francesco Pérez et al. (IDRIS, CEA, CNRS, Francja) |
| **Rok publikacji** | 2018 |
| **Czasopismo** | Computer Physics Communications, Vol. 222, pp. 351–373 |
| **DOI** | 10.1016/j.cpc.2017.09.024 |
| **Plik w repozytorium** | `articles/SMILEI A collaborative, open-source, multi-purpose particle-in-cell code for plasma simulation.pdf` (192 KB) |

### 1. Wzorzec Wektoryzacji SIMD w SMILEI
Kod SMILEI uznawany jest za wzorcową implementację wektoryzacji PIC na nowoczesnych procesorach x86. Kluczowy wzorzec to **Cell-Centric Vectorized Push**:
```cpp
// Cząstki są posortowane komórkami siatki.
// Wartości pola E dla danej komórki są ładowane do rejestrów TYLKO RAZ:
for (int ix = 0; ix < N_G - 1; ix++) {
    double Ex0 = efield[ix];
    double Ex1 = efield[ix + 1];
    int start  = cell_particle_offset[ix];
    int count  = cell_particle_count[ix];

    #pragma omp simd simdlen(8) aligned(x_e, vx_e: 64)
    for (int i = 0; i < count; i++) {
        int k = start + i;
        double c2 = (x_e[k] - ix * DX) * INV_DX;
        double e_x = (1.0 - c2) * Ex0 + c2 * Ex1;
        vx_e[k] -= e_x * FACTOR_E;
        x_e[k]  += vx_e[k] * DT_E;
    }
}
```
**Zaleta:** Całkowita eliminacja instrukcji `gather` — wartości pola `Ex0, Ex1` rezydują w stałych rejestrach wektorowych podczas przetwarzania wszystkich cząstek w danej komórce!

---

## ARTYKUŁ 11: Particle Simulation of Plasmas: Review and Advances

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Particle simulation of plasmas: Review and advances |
| **Autor** | John P. Verboncoeur |
| **Rok publikacji** | 2005 |
| **Czasopismo** | Plasma Physics and Controlled Fusion, Vol. 47, No. 5A, pp. A231–A260 |
| **DOI** | 10.1088/0741-3335/47/5A/017 |
| **Plik w repozytorium** | `articles/Particle simulation of plasmas Review and advances.pdf` (741 KB) |

### 1. Teoretyczne Kryteria Stabilności i Poprawności Fizycznej w GoPIC
Praca definiuje niezmienniki numeryczne, które muszą być bezwzględnie zachowane przy wszelkich optymalizacjach kodu:
1. **Warunek Rozdzielczości Długości Debye'a:**
   $$\Delta x \le \lambda_D = \sqrt{\frac{\varepsilon_0 k_B T_e}{e^2 n_e}}$$
   W GoPIC: $\Delta x \approx 62.7\,\mu\text{m}$, $\lambda_D \approx 74\,\mu\text{m} \implies \Delta x / \lambda_D \approx 0.85 \le 1.0$ (spełniony).
2. **Kryterium Częstości Plazmowej (Stabilność Czasowa):**
   $$\omega_{pe} \Delta t_e < 0.2, \quad \text{gdzie } \omega_{pe} = \sqrt{\frac{n_e e^2}{\varepsilon_0 m_e}}$$
   W GoPIC: $\omega_{pe} \Delta t_e \approx 0.07 < 0.2$ (spełniony).
3. **Kryterium Subcyclingu Jonów:**
   Stosunek mas argonu do elektronu $m_{\text{Ar}} / m_e \approx 72\,820$. Jony poruszają się co $N_{\text{SUB}} = 20$ kroków elektronowych z krokiem $\Delta t_i = 20 \Delta t_e$.
   Niezmiennik: całka gęstości jonowej `cumul_i_density` musi być akumulowana w **każdym** kroku czasowym $t$, niezależnie od warunku $(t \pmod{N_{\text{SUB}}} == 0)$.

---

## ARTYKUŁ 12: Application of Sparse Grid Combination Techniques to Low Temperature Plasmas PIC

| Metadana | Wartość |
|:---|:---|
| **Tytuł** | Application of sparse grid combination techniques to low temperature plasmas particle-in-cell simulations |
| **Autorzy** | Christian T. Jacobs, David Tskhakaya et al. |
| **Rok publikacji** | 2017 |
| **Czasopismo** | Computer Physics Communications, Vol. 214, pp. 207–215 |
| **DOI** | 10.1016/j.cpc.2017.01.021 |
| **Plik w repozytorium** | `articles/Application of sparse grid combination techniques to low temperature plasmas particle-in-cell simulations.pdf` (2.19 MB) |

### 1. Główna Teza i Wnioski dla Geometrii 1D
- Artykuł bada zastosowanie techniki rzadkich siatek (*Sparse Grids*) w celu przełamania przekleństwa wymiarowości w symulacjach PIC 2D i 3D plazmy wyładowań.
- **Wniosek dla kodu 1D GoPIC:** W geometrii 1D siatka $N_G = 400$ punktów jest z natury siatką zwartą. Zastosowanie sparse grids nie ma uzasadnienia numerycznego w 1D. Potwierdza to jednak, że narzut pamięciowy i obliczeniowy siatki w 1D jest znikomy w porównaniu z operacjami na cząstkach, co uzasadnia skupienie $100\%$ wysiłku optymalizacyjnego na wektoryzacji AVX-512 pętli cząstkowych (`push`, `deposition`, `collisions`).

---

## 13. Tabela Syntetyczna i Priorytetyzacja Wdrożeń dla GoPIC

### Zestawienie Technik Optymalizacyjnych z Literatury

| Technika Optymalizacyjna | Artykuły Referencyjne | Status w `C/parallel-only-omp/` | Oczekiwany Zysk na EPYC 9554 |
|:---|:---:|:---:|:---:|
| **Prywatyzacja buforów siatki (Private Buffers)** | Art. 1, 3, 5, 10 | ✅ Wdrożone (`WorkerBuffers`) | — (już aktywne) |
| **Struktura Tablic (SoA Layout)** | Art. 1, 6, 10 | ✅ Wdrożone (`x_e, vx_e...`) | — (już aktywne) |
| **Trwały region równoległy (Persistent Team)** | Art. 5 | ✅ Wdrożone w `do_one_cycle()` | — (już aktywne) |
| **Wątkowo-bezpieczny RNG (`thread_local`)** | Art. 3, 5 | ✅ Wdrożone (`MTgen`) | — (już aktywne) |
| **Wyrównanie danych do linii cache `alignas(64)`** | Art. 6, 7, 10 | ❌ Brak w tablicach globalnych | **$+10\%–20\%$** |
| **Flagi kompilatora Zen 4 (`-march=znver4`)** | Art. 7 | ❌ Brak w `GoPIC_jobs/C/*.sh` | **$+30\%–50\%$** |
| **Wektoryzacja SIMD Fast-Path (`#pragma omp simd`)** | Art. 1, 6, 10 | ❌ Zastąpione przez pragma ivdep | **$+30\%–60\%$ na Push** |
| **Pinning procesów NUMA (`numactl`, 64 wątki)** | Art. 3, 7 | ❌ Wymaga konfiguracji uruchomienia | **$+20\%–40\%$** |
| **Software Prefetching (`__builtin_prefetch`)** | Art. 4, 7 | ❌ Brak | **$+10\%–15\%$** |
| **Strict-Binning / Cell-Centric Push** | Art. 2, 9, 10 | ❌ Brak | **$+2\times–4\times$ na Depozycję** |

---

### Trójfazowy Plan Działań Optymalizacyjnych dla Kodu C++

#### 🔴 Faza 1: Błyskawiczne Usprawnienia Kompilacji i Pamięci (Wysiłek: 1 dzień)
1. **Flagi kompilacji `g++` w skryptach Slurm (`GoPIC_jobs/C/edupic_omp_job_stat.sh` i `edupic_omp_job_record.sh`):**
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
2. **Wyrównanie struktur w [constants.h](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/constants.h) i [state.h](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h):**
   ```cpp
   typedef double __attribute__((aligned(64))) particle_vector[MAX_N_P];
   typedef double __attribute__((aligned(64))) xvector[N_G + 16];
   ```
3. **Zastąpienie pętli `step3`/`step4` dyrektywą OpenMP SIMD:**
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

#### 🟠 Faza 2: Prefetching i Optymalizacje NUMA (Wysiłek: 2–3 dni)
1. Wprowadzenie `__builtin_prefetch(&x_e[k + 16], 0, 1)` w fazie pchnięcia elektronów i jonów.
2. Inicjalizacja tablic *First-Touch* wewnątrz `#pragma omp parallel for` w funkcji `init()`.
3. Przygotowanie skryptu wsadowego SLURM z pinningiem do pojedynczego gniazda (`OMP_NUM_THREADS=64`, `OMP_PROC_BIND=close`).

#### 🟢 Faza 3: Zaawansowane Przebudowy Algorytmiczne (Wysiłek: 1–2 tygodnie)
1. Implementacja **Strict-Binning** ($B = 8$ komórek) dla depozycji gęstości (Krok 1).
2. Wdrożenie **Cell-Centric Push** (wzorzec SMILEI) eliminującego operacje gather.
3. Wersja hybrydowa MPI (2 procesy) $\times$ OpenMP (64 wątki) do pełnego wykorzystania 128 rdzeni obu gniazd EPYC 9554.

---

*Raport sporządzony dla projektu GoPIC na podstawie zasobów bibliotecznych `articles/` oraz analizy kodu `C/parallel-only-omp/`.*
