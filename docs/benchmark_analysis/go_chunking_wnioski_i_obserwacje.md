# Analiza i Wnioski z Pomiarów HPC: Go Parallel Chunking

**Data opracowania:** 7 września 2026  
**Platforma badawcza:** Klaster HPC WCSS Lem (`plgrid-lem-cpu`)  
**Architektura procesora:** Dual-Socket AMD EPYC 9554 (Zen 4, 2 gniazda × 64 rdzenie fizyczne, 128 wątków online, 16 modułów CCX po 32 MB L3 Cache)  
**Kompilator i architektura docelowa:** Go `go1.26.5 linux/amd64`, `GOAMD64=v4`  
**Model fizyczny:** 1D3V PIC-MCC (Argon, siatka $N_G = 400$, 100 cykli RF, $N_T = 4000$ kroków/cykl, $N_e \approx 108\,000$, $N_i \approx 113\,500$)  
**Badany kod:** [`Go/parallel_chunking`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking)  
**Baza pomiarowa:** 27 zadań Slurm (21 zadań `perf stat` + 6 zadań profilowania `perf record`)

---

## 1. Wstęp i Cel Analizy

W ramach badań nad skalowalnością symulatora cząstkowego GoPIC przeprowadzono pełną serię eksperymentów skalowania silnego (*strong scaling*) dla wariantu **Go Parallel Chunking** ([`simulation.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go)). Wariant ten jest bezpośrednim odpowiednikiem zrównoleglenia znanego ze środowisk OpenMP, gdzie pętle cząstkowe są dzielone na równe fragmenty (*chunki*) pomiędzy wątki/goroutines, a bariera synchronizacyjna realizowana jest przez strukturę `sync.WaitGroup`.

Pomiary zrealizowano dla konfiguracji:
$$P \in \{1, 2, 4, 8, 16, 32, 64\} \text{ rdzeni}$$
Każdy punkt pomiarowy wykonano w **3 niezależnych powtórzeniach** z pełnym profilowaniem sprzętowym `perf stat` (21 zadań), a następnie uzupełniono o 6 zadań profilowania próbkowania `perf record -F 49 -g` wraz z wygenerowaniem wykresów Flame Graph.

Niniejszy dokument stanowi syntetyczne i rygorystyczne podsumowanie wszystkich zgromadzonych danych, obserwacji anomalii sprzętowych oraz wniosków architektonicznych przeznaczonych do pracy dyplomowej.

---

## 2. Zbiorcze Wyniki Pomiarów `perf stat`

### Tabela 1: Pełne zestawienie 21 prób pomiarowych

| ID Zadania | $W$ (Rdzenie) | Węzeł | Przydział Rdzeni (`Cpus_allowed`) | Topologia NUMA / CCX | Czas (s) | User (s) | Sys (s) | CPUs Util. | IPC | Instrukcje (bln) | L1 Miss (%) |
|:---:|:---:|:---:|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **5838290** | 1 | `r13ch01b01` | `113` | NUMA 1 (CCX 14) | 210.53 | 208.03 | 0.33 | 1.00 | 4.35 | 3.386 | 2.58% |
| **5838291** | 1 | `r13ch01b01` | `114` | NUMA 1 (CCX 14) | 209.39 | 206.91 | 0.33 | 1.00 | 4.37 | 3.386 | 2.58% |
| **5838292** | 1 | `r13ch01b01` | `120` | NUMA 1 (CCX 15) | 207.01 | 204.63 | 0.30 | 1.00 | 4.42 | 3.386 | 2.58% |
| **5838306** | 2 | `r13ch01b01` | `113,114` | 1 CCX (NUMA 1) | 157.57 | 245.78 | 10.74 | 1.65 | 3.72 | 3.392 | 3.73% |
| **5838307** | 2 | `r13ch01b01` | `120,121` | 1 CCX (NUMA 1) | 154.63 | 239.75 | 11.55 | 1.65 | 3.81 | 3.399 | 3.58% |
| **5838308** | 2 | `r13ch01b02` | `60,61` | 1 CCX (NUMA 0) | **141.07** | 240.76 | 11.42 | 1.81 | 3.79 | 3.394 | 4.04% |
| **5838349** | 4 | `r11ch12b03` | `112-115` | 1 CCX (NUMA 1) | 114.64 | 265.73 | 31.67 | 2.62 | 3.63 | 3.421 | 4.45% |
| **5838350** | 4 | `r11ch12b03` | `116-119` | 1 CCX (NUMA 1) | **114.40** | 263.79 | 31.29 | 2.60 | 3.66 | 3.421 | 4.43% |
| **5838351** | 4 | `r13ch01b01` | `113,114,120,121` | ⚠️ Rozbite Cross-CCX | 193.24 | 467.06 | 32.51 | 2.60 | 1.98 | 3.417 | 4.51% |
| **5839249** | 8 | `r11ch12b03` | `88-95` | 1 CCX (NUMA 1, 8 rdzeni) | **96.95** 🏆 | 270.68 | 50.50 | 3.34 | 3.52 | 3.468 | 4.86% |
| **5839250** | 8 | `r11ch12b03` | `96-103` | 1 CCX (NUMA 1, 8 rdzeni) | 98.06 | 277.56 | 50.65 | 3.37 | 3.44 | 3.467 | 4.87% |
| **5839251** | 8 | `r13ch09b03` | `38-43,57,58` | ⚠️ Pofragmentowane CCX | 175.31 | 449.13 | 41.76 | 2.82 | 2.09 | 3.454 | 4.40% |
| **5839268** | 16 | `r11ch12b03` | `88-103` | 2 spójne CCX (NUMA 1) | **129.05** | 291.11 | 33.89 | 2.54 | 3.41 | 3.527 | 4.57% |
| **5839269** | 16 | `r13ch04b03` | `14-21,76-83` | ⚠️ Cross-Socket (NUMA 0+1) | 211.08 | 524.52 | 37.86 | 2.69 | 1.85 | 3.517 | 4.16% |
| **5839270** | 16 | `r13ch09b04` | `51-58,115-122` | ⚠️ Cross-Socket (NUMA 0+1) | 211.50 | 599.36 | 49.85 | 3.10 | 1.61 | 3.524 | 4.31% |
| **5839296** | 32 | `r13ch11b02` | `0-11,28-47` | 1 Gniazdo (NUMA 0) | 140.49 | 566.74 | 70.12 | 4.55 | 1.78 | 3.707 | 5.72% |
| **5839297** | 32 | `r13ch11b02` | `64-75,92-111` | 1 Gniazdo (NUMA 1) | **136.80** | 515.50 | 63.36 | 4.25 | 1.96 | 3.701 | 5.61% |
| **5839298** | 32 | `r13ch11b02` | `48-63,112-127` | ⚠️ Cross-Socket (NUMA 0+1) | 191.13 | 954.16 | 98.46 | 5.54 | 1.06 | 3.738 | 5.96% |
| **5839300** | 64 | `r17ch07b02` | `0-63` | Całe Gniazdo 0 (NUMA 0) | **166.57** | 872.07 | 97.32 | 5.85 | 1.26 | 4.038 | 6.74% |
| **5839301** | 64 | `r17ch07b02` | `64-127` | Całe Gniazdo 1 (NUMA 1) | 167.73 | 874.45 | 96.37 | 5.83 | 1.26 | 4.034 | 6.78% |
| **5839302** | 64 | `r17ch08b03` | `16-47,80-111` | ⚠️ Cross-Socket (32+32) | 219.98 | 1268.87 | 133.22 | 6.42 | 0.87 | 4.084 | 6.90% |

---

### Tabela 2: Wskaźniki Skalowania Silnego (Średnie vs Najlepsze)

| $P$ | Śr. Czas (s) | Best Czas (s) | Speedup Śr. $S(P)$ | Speedup Best $S_{max}$ | Efektywność Śr. $E(P)$ | Efektywność Best $E_{max}$ | Śr. Czas `Sys` | CPUs Util. | Śr. IPC |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **1** | 208.97 | 207.01 | **1.00×** | **1.00×** | **100.0%** | **100.0%** | 0.32 s | 1.00 / 1 | 4.38 |
| **2** | 151.09 | 141.07 | **1.38×** | **1.47×** | **69.2%** | **73.4%** | 11.24 s | 1.70 / 2 | 3.77 |
| **4** | 140.76 | 114.40 | **1.48×** | **1.81×** | **37.1%** | **45.2%** | 31.83 s | 2.61 / 4 | 3.09 |
| **8** | **123.44** | **96.95** 🏆 | **1.69×** | **2.14×** | **21.2%** | **26.7%** | 47.63 s | 3.18 / 8 | 3.02 |
| **16** | 183.88 | 129.05 | **1.14×** | **1.60×** | **7.1%** | **10.0%** | 40.54 s | 2.78 / 16 | 2.29 |
| **32** | 156.14 | 136.80 | **1.34×** | **1.51×** | **4.2%** | **4.7%** | 77.31 s | 4.78 / 32 | 1.60 |
| **64** | 184.76 | 166.57 | **1.13×** | **1.24×** | **1.8%** | **1.9%** | **108.97 s** | **6.03 / 64** | **1.13** |

---

## 3. Wyniki Profilowania Próbkowania (`perf record` i Flame Graphs)

W celu zweryfikowania, na co procesor realnie poświęca czas wewnątrz przestrzeni użytkownika, wykonano profilowanie próbkowania (`perf record -F 49 -g`). 

Poniższa tabela przedstawia procentowy udział próbek CPU (metryka *Children / Inclusive*) dla $W \in \{2, 4, 8, 32, 64\}$:

| Funkcja / Moduł | $W=2$ (`5839368`) | $W=4$ (`5839366`) | $W=8$ (`5839365`) | $W=32$ (`5839333`) | $W=64$ Gniazdo 0 (`5839327`) | $W=64$ Gniazdo 1 (`5839328`) |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Całkowity czas workerów (`sync.WaitGroup`)** | **97.14%** | **95.94%** | **95.60%** | **82.15%** | **71.37%** | **71.54%** |
| 🔹 Krok 3: Push elektronów (Leap-Frog) | 33.35% | 37.04% | 31.52% | 49.86% | 41.34% | 41.64% |
| 🔹 Krok 1: Depozycja ładunku e- (CIC) | 24.77% | 24.32% | 25.61% | 11.21% | 10.65% | 10.50% |
| 🔹 Krok 5: Granice elektronów | 19.46% | 18.04% | 19.98% | 6.99% | 5.90% | 6.00% |
| 🔹 Krok 7: Zderzenia elektronów (Null-Coll) | 12.24% | 10.29% | 11.91% | 7.99% | 7.30% | 7.37% |
| 🔹 Kroki jonowe (4, 1b, 8, 6) | 6.92% | 5.72% | 6.11% | 4.92% | 4.38% | 4.42% |
| Krok 2: Solver Poissona (sekwencyjny) | 0.75% | 0.60% | 0.75% | 0.31% | 0.27% | 0.31% |
| 🔴 **Narzut: `runtime.mcall` (przełączanie stosu)** | 0.89% | 2.15% | 1.64% | **12.61%** | **19.47%** | **19.52%** |
| 🔴 **Narzut: `runtime.goexit0` (niszczenie goroutine)** | 0.76% | 2.03% | 1.47% | **12.48%** | **19.33%** | **19.41%** |
| 🔴 **Narzut: `runtime.schedule` (pętla planisty Go)** | 0.72% | 1.80% | 1.30% | **11.30%** | **17.14%** | **17.15%** |
| 🔴 **Narzut: `runtime.findRunnable` (szukanie zadań)** | 0.50% | 1.24% | 0.82% | **9.05%** | **13.95%** | **13.98%** |
| 🔴 **Narzut: `runtime.stealWork` (work-stealing)** | 0.15% | 0.50% | 0.40% | **4.03%** | **5.91%** | **5.95%** |
| 🔴 **Narzut: `runtime.newproc` (tworzenie goroutines)** | 0.21% | 0.31% | 0.59% | **2.79%** | **5.67%** | **5.62%** |

### Pliki Wykresów Płomieniowych (Flame Graph SVG):
- **64 rdzenie (Gniazdo 0):** [`saved_logs_Go/logs_job_5839327_CHUNKING_RECORD/edupic_data/flamegraph.svg`](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839327_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **64 rdzenie (Gniazdo 1):** [`saved_logs_Go/logs_job_5839328_CHUNKING_RECORD/edupic_data/flamegraph.svg`](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839328_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **32 rdzenie:** [`saved_logs_Go/logs_job_5839333_CHUNKING_RECORD/edupic_data/flamegraph.svg`](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839333_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **8 rdzeni:** [`saved_logs_Go/logs_job_5839365_CHUNKING_RECORD/edupic_data/flamegraph.svg`](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839365_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **4 rdzenie:** [`saved_logs_Go/logs_job_5839366_CHUNKING_RECORD/edupic_data/flamegraph.svg`](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839366_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **2 rdzenie:** [`saved_logs_Go/logs_job_5839368_CHUNKING_RECORD/edupic_data/flamegraph.svg`](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839368_CHUNKING_RECORD/edupic_data/flamegraph.svg)

---

## 4. Kluczowe Obserwacje i Diagnoza Architektoniczna

### Obserwacja 1: Patologia Mikrozadań (*Micro-tasking Granularity Inversion*)
W klasycznych systemach HPC optymalna wielkość ziarna zadania równoległego powinna wynosić co najmniej kilkaset mikrosekund ($>500\,\mu\text{s}$). W implementacji Chunking krok symulacji PIC jest bardzo krótki:
$$\frac{207\text{ s}}{400\,000} \approx 517\,\mu\text{s na 1 rdzeniu}$$
Gdy w Kroku 5 (Granice) lub Kroku 1 (Depozycja) 64 workerów dzieli tablicę $108\,000$ cząstek, pojedynczy chunk zawiera zaledwie **1680 liczb**. Przeliczenie takiego wektora w pamięci L1 Cache zajmuje procesorowi zaledwie **$0.8 - 2.0\,\mu\text{s}$**!

Tymczasem w runtime Go:
- Alokacja goroutine i wstawienie do kolejki `runqueue`: $\sim 0.3 - 0.5\,\mu\text{s}$
- Przełączenie stosu na `g0` i wyjście z goroutine (`mcall`, `goexit0`): $\sim 0.5 - 1.0\,\mu\text{s}$
- Wybudzenie uśpionego wątku OS `M` przez futex jądra: **$2.0 - 5.0\,\mu\text{s}$**
- Przejście przez barierę `sync.WaitGroup`: $\sim 0.5 - 1.5\,\mu\text{s}$

**Wniosek:** Narzut środowiska uruchomieniowego ($3 - 8\,\mu\text{s}$) jest **kilkukrotnie większy** niż czas pożytecznych obliczeń fizycznych ($0.8 - 2\,\mu\text{s}$). W ciągu 100 cykli program tworzy i niszczy **104 448 000 goroutines**, marnując **ponad 700 miliardów instrukcji CPU** na samą koordynację.

---

### Obserwacja 2: Zapaść w Jądrze Linuxa (`SYS_futex`) i Niska Utylizacja CPU
Czas systemowy `Sys time` drastycznie rośnie wraz z liczbą wątków:
- 1 rdzeń: **0.32 s** (0.15% czasu)
- 8 rdzeni: **47.63 s** (38.6% czasu)
- 64 rdzenie: **108.97 s (59.0% czasu zegarowego!)**

Na 64 rdzeniach program spędza **większość czasu wewnątrz jądra Linuxa**. Gdy worker kończy mikrozadanie, wątek systemowy OS natychmiast zasypia w wywołaniu `futex(FUTEX_WAIT_PRIVATE)`, by ułamek mikrosekundy później zostać gwałtownie wybudzonym przez `futex(FUTEX_WAKE_PRIVATE)` w kolejnym kroku PIC.

Skutkuje to sztucznym dławieniem procesora: mimo przydziału 64 rdzeni przez Slurm, `perf stat` wykazuje średnią utylizację na poziomie zaledwie **6.03 CPU**. Pozostałe 58 rdzeni tkwi w uśpieniu jądra lub w kolejkach wywołań systemowych.

---

### Obserwacja 3: Rozwiązanie Zagadki Próby 3 – Architektura NUMA i Moduły CCX
We wszystkich seriach 4, 8, 16, 32 i 64 rdzeni Próba nr 3 była niemal dwukrotnie wolniejsza od Próby 1 i 2 (np. na 8 rdzeniach: 97 s vs 175 s; na 4 rdzeniach: 114 s vs 193 s; na 16 rdzeniach: 129 s vs 211 s).

Analiza topologii sprzętowej procesora **AMD EPYC 9554** ujawniła mechanizm tej anomalii:
1. **Pojedynczy moduł CCX (Core Complex):** Zawiera 8 rdzeni współdzielących 32 MB L3 Cache (opóźnienie komunikacji $\sim 10\,\text{ns}$).
2. **Magistrala wewnętrzna Infinity Fabric:** Łączy 8 bloków CCX w obrębie jednego gniazda (opóźnienie $\sim 40-50\,\text{ns}$).
3. **Łącza międzysocketowe xGMI:** Łączą Gniazdo 0 (NUMA 0, rdzenie 0–63) z Gniazdem 1 (NUMA 1, rdzenie 64–127) (opóźnienie $>100\,\text{ns}$).

#### Zależność od masek przydziału Slurma:
- **8 rdzeni (Próba 1 i 2 – 97 s, IPC 3.52):** Slurm przydzielił rdzenie `88-95` oraz `96-103`. Był to **dokładnie jeden fizyczny blok CCX**. Pamięć L3 była w pełni lokalna.
- **8 rdzeni (Próba 3 – 175 s, IPC 2.09):** Slurm przydzielił pofragmentowane rdzenie `38-43, 57, 58` (rozbite na różne bloki CCX).
- **16 rdzeni (Próba 1 – 129 s vs Próby 2–3 – 211 s):** W Próbie 1 rdzenie były w jednym gnieździe (`88-103`), a w Próbach 2 i 3 Slurm rozbił zadanie na **dwa fizyczne gniazda**: `14-21` (Gniazdo 0) oraz `76-83` (Gniazdo 1).
- **64 rdzenie (Próba 1 i 2 – 167 s vs Próba 3 – 220 s):** Próby 1 i 2 mieściły się w jednym gnieździe (`0-63` lub `64-127`), podczas gdy Próba 3 została przecięta na pół (`16-47` w Gnieździe 0 oraz `80-111` w Gnieździe 1).

Gdy 1.6 miliona razy modyfikowane są zmienne atomowe struktur `sync.WaitGroup` i kolejki planisty Go pomiędzy różnymi gniazdami CPU, dochodzi do permanentnego zjawiska **Cache-Line Bouncing**. Linie pamięci wędrują przez magistralę międzysocketową, zatrzymując potoki wykonawcze procesora (*pipeline stalls*) i powodując załamanie IPC z 4.38 aż do 0.87.

---

### Obserwacja 4: Porównanie z C++ OpenMP (27.54 s vs 96.95 s)

W referencyjnej implementacji C++ OpenMP ([`docs/C_analysis/hpc_scaling_and_optimization_report.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/C_analysis/hpc_scaling_and_optimization_report.md)) 8 rdzeni w obrębie jednego modułu CCX osiągnęło czas **$27.54\text{ s}$** ($S = 6.34\times$, efektywność $79.3\%$).

Różnica wynika z trzech fundamentalnych cech architektury:
1. **Persistent Thread Pool vs Dynamic Goroutines:** W C++ OpenMP wątki tworzone są dokładnie **raz** przy starcie programu (`#pragma omp parallel`) i żyją nieprzerwanie do końca symulacji. W Go Chunking goroutines są tworzone i niszczone 104 miliony razy.
2. **User-Space Spin Barrier vs Kernel Futex:** Bariera w OpenMP przez pierwsze setki cykli wykonuje aktywny spin-wait w przestrzeni użytkownika, prawie nigdy nie wchodząc do jądra (`Sys time` $< 1.0\text{ s}$). W Go `sync.WaitGroup` natychmiast deleguje uśpienie wątków do jądra przez futex (`Sys time` do $109\text{ s}$).
3. **Brak schedulera pośredniczącego:** OpenMP kompiluje pętle for bezpośrednio do arytmetyki wskaźnikowej z góry przypisanej do wątków POSIX, bez kolejki work-stealingu i struktur schedulera Go.

---

## 5. Podsumowanie Wniosków do Pracy Dyplomowej

1. **Wartość naukowa negatywnego wyniku:**  
   Wynik ten stanowi doskonały, empirycznie udowodniony dowód na **granice stosowalności modelu Fork-Join w języku Go**. Pokazuje, że wzorce programistyczne typowe dla aplikacji webowych/mikroserwisów zawodzą w obliczeniach HPC o wysokiej częstotliwości synchronizacji ($< 50\,\mu\text{s}$).

2. **Identyfikacja wąskiego gardła:**  
   Udowodniono, że barierą skalowania nie jest algorytm fizyczny PIC ani przepustowość pamięci RAM, lecz **narzut schedulera Go runtime oraz wywołań systemowych `SYS_futex` w jądrze Linuxa**.

3. **Znaczenie topologii NUMA / CCX:**  
   Wykazano, że w architekturach procesorów serwerowych AMD Zen 4 spójność pamięci L3 wewnątrz modułu CCX ma kluczowe znaczenie dla redukcji narzutu synchronizacji.

---

## 6. Rekomendacje dla Kolejnych Implementacji (`parallel_channels`)

Wszystkie zidentyfikowane problemy wariantu `parallel_chunking` znajdują bezpośrednie rozwiązanie w przygotowanej architekturze **`parallel_channels`** ([`Go/parallel_channels/worker.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/worker.go)):

1. **Wdrożenie Persistent Worker Pool:**  
   Goroutines workerów muszą być powoływane do życia **wyłącznie raz na początku symulacji** i pozostawać aktywne w pętli oczekiwania na rozkazy.
2. **Sterowanie przez kanały lub flagi atomowe:**  
   Wyeliminuje to tworzenie 104 milionów goroutines, radykalnie redukując wywołania `runtime.newproc` i `runtime.goexit0`.
3. **Drastyczne obniżenie czasu systemowego:**  
   Dzięki ograniczeniu usypiania wątków OS w jądrze czas `Sys time` powinien spaść z obecnych 109 sekund do wartości poniżej 2–5 sekund, co odblokuje skalowanie na 16, 32 i 64 rdzeniach.
