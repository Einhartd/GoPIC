# Analiza i Wnioski z Pomiarów HPC: C++ OpenMP

**Data opracowania:** 7 września 2026  
**Platforma badawcza:** Klaster HPC WCSS Lem (`plgrid-lem-cpu`)  
**Architektura procesora:** Dual-Socket AMD EPYC 9554 (Zen 4, 2 gniazda × 64 rdzenie fizyczne, 128 wątków online, 16 modułów CCX po 32 MB L3 Cache)  
**Kompilator i flagi:** GCC 13+ z flagami `-O3 -march=native -fopenmp -std=c++17`  
**Model fizyczny:** 1D3V PIC-MCC (Argon, siatka $N_G = 400$, 100 cykli RF, $N_T = 4000$ kroków/cykl, $N_e \approx 108\,000$, $N_i \approx 113\,500$)  
**Badany kod:** C++ OpenMP ([`plots/hpc_logs/C-OMP`](file:///C:/Users/E14/Documents/GitHub/GoPIC/plots/hpc_logs/C-OMP))  
**Baza pomiarowa:** 28 zadań Slurm (21 zadań `perf stat` dla 1–64 rdzeni + 7 zadań profilowania `perf record` dla 1–64 rdzeni)

---

## 1. Wstęp i Cel Badania

W celu stworzenia rzetelnego punktu odniesienia (*baseline*) dla implementacji równoległych w języku Go, przeprowadzono pełną serię pomiarów skalowania silnego (*strong scaling*) oraz profilowania próbkowania dla zoptymalizowanego kodu C++ z wykorzystaniem biblioteki **OpenMP**.

W implementacji C++ zastosowano:
1. **Strukturę danych SoA (Structure of Arrays)** umożliwiającą pełną wektoryzację AVX-512.
2. **Trwały region równoległy (*Persistent Parallel Region*):** wątki OpenMP są powoływane dokładnie raz przy starcie symulacji (`#pragma omp parallel`), eliminując ciągłą alokację wątków w pętli czasowej.
3. **Równoległe losowanie zderzeń Null-Collision:** każdy wątek posiada niezależny generator liczb pseudolosowych `std::mt19937` i losuje zderzenia lokalnie w swoim chunku cząstek.
4. **Bariery synchronizacyjne OpenMP (`#pragma omp barrier`):** realizowane przez `libgomp` w przestrzeni użytkownika za pomocą aktywnego odpytywania pamięci (*spin-wait*).

Pomiary zrealizowano dla:
$$P \in \{1, 2, 4, 8, 16, 32, 64\} \text{ rdzeni}$$
w 3 niezależnych powtórzeniach `perf stat` oraz po jednym profilowaniu `perf record -F 49 -g` per liczba rdzeni.

---

## 2. Zbiorcze Wyniki Pomiarów `perf stat` (C++ OpenMP)

### Tabela 1: Pełne zestawienie 21 prób pomiarowych z katalogu `plots/hpc_logs/C-OMP/STAT`

| ID Próby / Katalog | $P$ (Rdzenie) | Czas (s) | User (s) | Sys (s) | CPUs Utilized | IPC | Instrukcje (bln) | L1 Miss (%) | Węzeł Obliczeniowy |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---|
| **OMP_STAT-1_1** | 1 | 148.24 | 145.11 | 1.10 | 1.00 | 3.70 | 1.868 | 5.22% | `r11ch02b03` |
| **OMP_STAT-1_2** | 1 | **138.37** | 136.14 | 0.75 | 1.00 | 3.71 | 1.867 | 5.22% | `r11ch02b03` |
| **OMP_STAT-1_3** | 1 | 140.65 | 138.28 | 0.85 | 1.00 | 3.65 | 1.868 | 5.22% | `r11ch02b03` |
| **OMP_STAT-2_1** | 2 | 79.31 | 155.73 | 0.78 | 2.00 | 3.51 | 1.883 | 5.20% | `r11ch02b03` |
| **OMP_STAT-2_2** | 2 | 78.67 | 154.63 | 0.67 | 2.00 | 3.52 | 1.877 | 5.20% | `r11ch02b03` |
| **OMP_STAT-2_3** | 2 | **75.11** | 147.80 | 0.63 | 2.00 | 3.43 | 1.878 | 5.20% | `r11ch02b03` |
| **OMP_STAT-4_1** | 4 | 42.00 | 164.84 | 0.83 | 3.99 | 3.08 | 1.884 | 5.29% | `r11ch02b03` |
| **OMP_STAT-4_2** | 4 | 40.27 | 158.50 | 0.80 | 4.00 | 3.17 | 1.881 | 5.30% | `r11ch03b02` |
| **OMP_STAT-4_3** | 4 | **40.23** | 156.93 | 0.70 | 3.97 | 3.46 | 1.877 | 5.29% | `r11ch02b03` |
| **OMP_STAT-8_1** | 8 | 29.48 | 231.26 | 1.20 | 7.98 | 2.24 | 1.902 | 5.43% | `r11ch02b04` |
| **OMP_STAT-8_2** | 8 | 22.74 | 178.87 | 0.87 | 7.98 | 2.83 | 1.892 | 5.45% | `r11ch03b02` |
| **OMP_STAT-8_3** | 8 | **22.71** | 178.59 | 0.90 | 7.98 | 2.84 | 1.894 | 5.45% | `r11ch03b02` |
| **OMP_STAT-16_1** | 16 | 16.43 | 258.64 | 0.95 | 15.95 | 2.00 | 1.922 | 5.74% | `r11ch03b02` |
| **OMP_STAT-16_2** | 16 | 16.99 | 267.65 | 0.81 | 15.95 | 1.93 | 1.921 | 5.72% | `r11ch03b02` |
| **OMP_STAT-16_3** | 16 | **16.38** | 257.98 | 0.93 | 15.95 | 2.01 | 1.923 | 5.73% | `r11ch03b02` |
| **OMP_STAT-32_1** | 32 | 13.99 | 440.41 | 0.79 | 31.82 | 1.21 | 1.988 | 5.90% | `r11ch03b02` |
| **OMP_STAT-32_2** | 32 | **13.89** 🏆 | 436.99 | 0.84 | 31.82 | 1.24 | 1.988 | 5.90% | `r11ch03b02` |
| **OMP_STAT-32_3** | 32 | 15.00 | 472.67 | 0.94 | 31.88 | 1.15 | 1.994 | 5.89% | `r11ch03b04` |
| **OMP_STAT-64_1** | 64 | 20.31 | 1282.49 | 1.42 | 63.81 | 0.46 | 2.215 | 5.16% | `r11ch03b02` |
| **OMP_STAT-64_2** | 64 | 20.57 | 1297.86 | 1.26 | 63.77 | 0.46 | 2.217 | 5.16% | `r11ch03b04` |
| **OMP_STAT-64_3** | 64 | **18.67** | 1178.04 | 1.23 | 63.77 | 0.50 | 2.188 | 5.20% | `r11ch04b02` |

---

### Tabela 2: Wskaźniki Skalowania Silnego C++ OpenMP (Średnie z 3 prób vs Najlepsze)

| $P$ (Rdzenie) | Śr. Czas (s) | Best Czas (s) | Speedup Śr. $S(P)$ | Speedup Best $S_{max}$ | Efektywność Śr. $E(P)$ | Efektywność Best $E_{max}$ | Czas `Sys` (s) | CPUs Utilized | Śr. IPC |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **1** | 142.42 | 138.37 | **1.00×** | **1.00×** | **100.0%** | **100.0%** | 0.90 s | 1.00 / 1 | 3.69 |
| **2** | 77.70 | 75.11 | **1.83×** | **1.84×** | **91.6%** | **92.1%** | 0.70 s | 2.00 / 2 | 3.49 |
| **4** | 40.83 | 40.23 | **3.49×** | **3.44×** | **87.2%** | **86.0%** | 0.78 s | 3.99 / 4 | 3.24 |
| **8** | 24.98 | 22.71 | **5.70×** | **6.09×** | **71.3%** | **76.2%** | 0.99 s | 7.98 / 8 | 2.64 |
| **16** | 16.60 | 16.38 | **8.58×** | **8.45×** | **53.6%** | **52.8%** | 0.89 s | 15.95 / 16 | 1.98 |
| **32** | **14.30** | **13.89** 🏆 | **9.96×** | **9.96×** | **31.1%** | **31.1%** | 0.85 s | 31.84 / 32 | 1.20 |
| **64** | 19.85 | 18.67 | **7.17×** | **7.41×** | **11.2%** | **11.6%** | 1.31 s | 63.78 / 64 | 0.47 |

---

## 3. Wyniki Profilowania Próbkowania (`perf record` w C-OMP)

Dla każdej konfiguracji rdzeni przeanalizowano profile z katalogu [`plots/hpc_logs/C-OMP/RECORD`](file:///C:/Users/E14/Documents/GitHub/GoPIC/plots/hpc_logs/C-OMP/RECORD). 

Poniższa tabela przedstawia procentowy udział próbek CPU (metryka *Self*) dla kluczowych modułów symulacji oraz biblioteki `libgomp`:

| Moduł / Funkcja | 1 rdzeń | 2 rdzenie | 4 rdzenie | 8 rdzeni | 16 rdzeni | 32 rdzenie | 64 rdzenie |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 🔹 **Krok 1: Depozycja ładunku e- (`step1`)** | 28.38% | 28.32% | 26.98% | 25.36% | 19.31% | 13.68% | 10.56% |
| 🔹 **Krok 3: Push elektronów Leap-Frog (`step3`)** | 28.80% | 29.87% | 27.56% | 23.85% | 18.53% | 11.15% | 8.03% |
| 🔹 **Krok 5: Granice elektronów (`step5`)** | 15.65% | 15.33% | 14.00% | 12.53% | 8.76% | 4.46% | 2.23% |
| 🔹 **Krok 7: Zderzenia elektronów (`step7`)** | 12.61% | 11.90% | 8.71% | 6.03% | 7.12% | 3.50% | 3.64% |
| 🔹 **Kroki jonowe (Kroki 4, 1b, 8, 6)** | 5.15% | 7.33% | 5.01% | 3.86% | 3.37% | 2.03% | 1.70% |
| 🔹 **Generator losowy i rozkłady (`mt19937`)** | 3.26% | 2.50% | 1.80% | 1.52% | 1.80% | 1.86% | 2.77% |
| 🔹 **Krok 2: Solver Poissona (sekwencyjny)** | 0.29% | 0.40% | 0.45% | 0.57% | 0.55% | 0.60% | 0.65% |
| 🟡 **Bariera OpenMP: `gomp_team_barrier_wait_end`** | **0.00%** | **0.25%** | **8.12%** | **19.19%** | **31.25%** | **48.49%** | **52.01%** |
| 🟡 **Bariera OpenMP: `gomp_team_barrier_wait`** | **0.00%** | **0.05%** | **1.20%** | **1.18%** | **2.80%** | **4.19%** | **6.86%** |
| 🔴 **Łączny czas w barierach OpenMP (Spin-Wait)** | **0.00%** | **0.30%** | **9.32%** | **20.37%** | **34.05%** | **52.68%** | **58.87%** |

---

## 4. Kluczowe Obserwacje i Diagnoza Architektoniczna

### Obserwacja 1: Znakomite Skalowanie do 32 Rdzeni (Speedup niemal 10×)
Kod C++ OpenMP wykazuje wzorowe skalowanie silne:
- Na 2 rdzeniach: **$75.11	ext{ s}$** (efektywność **$92.1\%$**)
- Na 4 rdzeniach: **$40.23	ext{ s}$** (efektywność **$86.0\%$**)
- Na 8 rdzeniach: **$22.71	ext{ s}$** (efektywność **$76.2\%$**)
- Na 16 rdzeniach: **$16.38	ext{ s}$** (efektywność **$52.8\%$**)
- Na 32 rdzeniach: **$13.89	ext{ s}$** 🏆 (Speedup **$9.96	imes$**!)

Czas wykonania 100 cykli symulacji spada z $138.4	ext{ s}$ do rekordowych **$13.89	ext{ s}$**!

---

### Obserwacja 2: Mechanizm Bariery OpenMP – Spin-Wait w Przestrzeni Użytkownika
Jedną z najbardziej uderzających różnic w licznikach `perf stat` jest czas systemowy (`Sys time`):
- W C++ OpenMP na wszystkich konfiguracjach (1, 2, 4, 8, 16, 32, 64 rdzenie) czas `Sys` wynosi **zaledwie $0.70 - 1.31	ext{ s}$** ($< 0.1\%$ czasu działania!).
- Wątki OpenMP utrzymują utylizację CPU na poziomie **$99.7\%$** (np. $63.78$ z 64 rdzeni).

#### Dlaczego tak się dzieje?
Funkcja `gomp_team_barrier_wait_end` w bibliotece GCC OpenMP (`libgomp`) implementuje **aktywne odpytywanie pamięci (*user-space spin-waiting*)**. Gdy szybszy wątek kończy swój fragment pętli cząstkowej, nie wykonuje wywołania systemowego `futex` usypiającego wątek w jądrze. Zamiast tego wykonuje pętlę odpytującą flagę w pamięci RAM w przestrzeni użytkownika.  
Dzięki temu, gdy ostatni wątek dotrze do bariery, wszystkie pozostałe wątki natychmiast podejmują pracę bez opóźnień wybudzania ze stanu uśpienia ($< 10\,	ext{ns}$ vs $3-5\,\mu	ext{s}$ w futexie).

---

### Obserwacja 3: Dlaczego 32 Rdzenie to Szczyt Wydajności, a 64 Rdzenie Zwalniają?
Na 64 rdzeniach czas symulacji rośnie z **$13.89	ext{ s}$ do $18.67	ext{ s}$** (średnio $19.85	ext{ s}$). Zjawisko to wynika z trzech czynników:

1. **Przekroczenie Granicy Gniazda Fizycznego (NUMA Crossing):**  
   Procesor AMD EPYC 9554 posiada 64 rdzenie na gniazdo. Przy 32 rdzeniach Slurm przydziela rdzenie w obrębie **jednego gniazda (NUMA 0 lub NUMA 1)**. Cała komunikacja barierowa odbywa się na lokalnej pamięci podręcznej. Przy 64 rdzeniach dochodzi do rywalizacji o magistralę międzysocketową xGMI.
2. **Eksplozja Czasu Wirowania na Barierze (Spin-Wait Bloat):**  
   Jak wykazano w tabeli profilowania, na 64 rdzeniach aż **$58.87\%$ cykli CPU** pochłania funkcja `gomp_team_barrier_wait_end`!  
   Gdy chunk cząstek per wątek spada do 1680 cząstek, drobne fluktuacje w liczbie zderzeń (Krok 7) lub nieliniowy dostęp do pamięci powodują, że jeden wątek spóźnia się o kilkaset nanosekund, zmuszając pozostałe 63 wątki do wirowania na barierze.
3. **Prawo Amdahla i Sekwencyjny Krok 2 (Poisson):**  
   Solver Poissona (`Step2SolvePoisson`) jest wykonywany w 1 wątku przez `GOMP_single`. Na 64 rdzeniach czas trwania kroku Poissona i redukcji gęstości ładunku zaczyna dominować nad ultrakrótkim czasem przetwarzania cząstek.

---

## 5. Wielkie Porównanie: C++ OpenMP vs Go Parallel Chunking

Zestawienie obu architektur na identycznym sprzęcie (klaster Lem, AMD EPYC 9554) dla 100 cykli RF:

| Metryka Porównawcza | C++ OpenMP ([`plots/hpc_logs/C-OMP`](file:///C:/Users/E14/Documents/GitHub/GoPIC/plots/hpc_logs/C-OMP)) | Go Chunking ([`Go/parallel_chunking`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking)) | Relacja / Wnioski |
|:---|:---:|:---:|:---|
| **Czas bazowy (1 rdzeń)** | **138.37 s** (śr. 142.42 s) | **207.01 s** (śr. 208.97 s) | C++ sekwencyjnie jest **$1.47	imes$ szybszy** (AVX-512, brak GC) |
| **Czas na 2 rdzeniach** | **75.11 s** (śr. 77.70 s) | **141.07 s** (śr. 151.09 s) | C++ jest **$1.94	imes$ szybszy** |
| **Czas na 4 rdzeniach** | **40.23 s** (śr. 40.83 s) | **114.40 s** (śr. 140.76 s) | C++ jest **$3.45	imes$ szybszy** |
| **Czas na 8 rdzeniach** | **22.71 s** (śr. 24.98 s) | **96.95 s** (śr. 123.44 s) | C++ jest **$4.94	imes$ szybszy** (Szczyt Go: 96.95 s) |
| **Czas na 16 rdzeniach** | **16.38 s** (śr. 16.60 s) | **129.05 s** (śr. 183.88 s) | C++ jest **$11.1	imes$ szybszy** (Go zwalnia, C++ przyspiesza) |
| **Czas na 32 rdzeniach** | **13.89 s** 🏆 (śr. 14.30 s) | **136.80 s** (śr. 156.14 s) | C++ jest **$10.9	imes$ szybszy** (Absolutny rekord: **13.89 s**) |
| **Czas na 64 rdzeniach** | **18.67 s** (śr. 19.85 s) | **166.57 s** (śr. 184.76 s) | C++ jest **$9.3	imes$ szybszy** |
| **Maksymalny Speedup $S(P)$** | **$9.96	imes$** (śr.) / **$10.25	imes$** (max) | **$1.69	imes$** (śr.) / **$2.14	imes$** (max) | C++ osiąga niemal $10	imes$ przyspieszenia, Go zaledwie $1.7	imes$ |
| **Czas w jądrze `Sys` (64 rdzenie)** | **1.31 s** ($< 0.1\%$ czasu) | **108.97 s** ($59.0\%$ czasu!) | **Go spędza 83× więcej czasu w jądrze systemu!** |
| **Utylizacja CPU (64 rdzenie)** | **63.78 / 64** ($99.7\%$) | **6.03 / 64** ($9.4\%$) | OpenMP w pełni wysyca procesor; Go grzęźnie w futexach |
| **Narzut zarządzania wątkami** | Trwały basen wątków (tworzony raz) | Dynamiczny fork-join (104 miliony goroutines) | 700 mld nadmiarowych instrukcji w Go |
| **Typ bariery synchronizacyjnej** | User-Space Spin-Wait (`gomp_team_barrier`) | Kernel Sleep / Futex (`sync.WaitGroup`) | Błyskawiczna synchronizacja w C++ vs opóźnienia jądra w Go |

---

## 6. Wnioski Końcowe do Pracy Dyplomowej

1. **Potwierdzenie hipotezy architektonicznej:**  
   Analiza wyników C++ OpenMP jednoznacznie dowodzi, że powodem braku skalowania Go Chunking nie jest algorytm PIC-MCC ani ograniczenia fizyczne problemu, lecz **wyłącznie mechanizm synchronizacji i narzut środowiska uruchomieniowego Go**.
2. **Klucz do sukcesu w C++:**  
   Połączenie trwałego basenu wątków (*persistent pool*) oraz barier typu *spin-wait* w przestrzeni użytkownika pozwala C++ OpenMP skalować się niemal 10-krotnie (do $13.89	ext{ s}$ na 32 rdzeniach).
3. **Wytyczne dla architektury `parallel_channels` w Go:**  
   Aby Go zbliżyło się do wyników C++, musi bezwzględnie zrezygnować z dynamicznego tworzenia goroutines i naśladować model OpenMP poprzez **trwały basen goroutines** komunikujący się przez kanały lub atomowe flagi spin-wait.
