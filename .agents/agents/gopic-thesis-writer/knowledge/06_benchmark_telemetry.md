# Telemetria, Wyniki Pomiarów i Baza Danych Wydajnościowych

Niniejszy dokument zawiera twarde dane empiryczne, wyniki mikrobenchmarków oraz szablony tabel dla wyników klastrowych, które zostaną uzupełnione po zakończeniu pomiarów na klastrze HPC WCSS.

---

## 1. Zmierzone Mikrobenchmarki Sprzętowe (Pomiary Potwierdzone)

### 1.1. Koszt Barier Synchronizacyjnych ($20\,000$ barier = 1 pełny cykl RF)
Pomiary wykonane narzędziem [`experiments/Go-parallel/1-channels/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-parallel/1-channels/bench) na procesorze AMD Ryzen (12 wątków logicznych):

| Liczba Wątków $P$ | Go Channels (CSP) | sync.WaitGroup (futex) | StarBarrier (PAUSE) | Przyspieszenie StarBarrier vs Channels |
| :---: | :---: | :---: | :---: | :---: |
| **2** | 32 ms (1598.8 ns/op) | 35 ms (1744.7 ns/op) | **15 ms (749.5 ns/op)** | **2.13x** |
| **4** | 71 ms (3549.9 ns/op) | 44 ms (2175.8 ns/op) | **14 ms (704.3 ns/op)** | **5.04x** |
| **8** | 128 ms (6395.9 ns/op) | 69 ms (3466.1 ns/op) | **17 ms (842.2 ns/op)** | **7.59x** |
| **12** | 168 ms (8391.9 ns/op) | 92 ms (4604.1 ns/op) | **69 ms (3447.6 ns/op)** | **2.43x** |

**Wniosek:** Dla $P=8$ (odpowiednik modułu CCX) StarBarrier redukuje koszt pojedynczej bariery z $6.4\text{ µs}$ do **$842\text{ ns}$**, przyspieszając synchronizację aż **7.59-krotnie**.

---

### 1.2. Koszt Fałszywego Współdzielenia (False Sharing) i Zysk z Prywatnych Buforów L1d
Pomiary wykonane narzędziem [`experiments/Go-parallel/2-buffers-false-sharing/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-parallel/2-buffers-false-sharing/bench) ($5\,000\,000$ operacji zapisu na wątek):

| Liczba Wątków $P$ | Unaligned (False Sharing) | Padded (Wyrównanie 64B) | Private L1d Buffer | Przyspieszenie Bufora L1d vs Unaligned |
| :---: | :---: | :---: | :---: | :---: |
| **2** | 94 ms (18.71 ns/op) | 11 ms (2.22 ns/op) | **3 ms (0.69 ns/op)** | **27.31x** |
| **4** | 251 ms (50.29 ns/op) | 11 ms (2.28 ns/op) | **5 ms (1.05 ns/op)** | **47.69x** |
| **8** | 521 ms (104.11 ns/op) | 14 ms (2.71 ns/op) | **5 ms (0.99 ns/op)** | **105.43x** |
| **12** | 543 ms (108.58 ns/op) | 15 ms (3.04 ns/op) | **8 ms (1.52 ns/op)** | **71.65x** |

**Wniosek:** Konflikty w 64-bajtowej linii cache degradują czas zapisu z $18.7\text{ ns}$ do aż $104.1\text{ ns}$. Izolacja pamięci w prywatnym buforze L1d sprowadza czas do **$0.99\text{ ns}$**, dając **ponad 105-krotne przyspieszenie**.

---

### 1.3. Fuzja Pętli Integratora z Detekcją Granic (Fused Move & Detect)
Pomiary wykonane narzędziem [`experiments/Go-parallel/4-boundary-compaction/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-parallel/4-boundary-compaction/bench) (4000 kroków, $N = 150\,000$ cząstek):

| Wariant Integratora i Granic | Czas Wykonania (4000 kroków) | Ruch na Magistrali RAM/L3 | Liczba Usuniętych Cząstek | Przyspieszenie |
| :--- | :---: | :---: | :---: | :---: |
| **Two-Pass (Osobne pętle: Leap-Frog + Krok 5)** | 2.972 s | 14.40 GB | 144 514 | 1.00x (ref) |
| **Fused Move & Detect + $O(\text{dead})$** | **2.111 s** | **9.60 GB** | 144 514 | **1.41x** |

**Wniosek:** Fuzja eliminuje konieczność powtórnego czytania $1.2\text{ MB}$ współrzędnych z RAM w każdym kroku, oszczędzając **$4.80\text{ GB}$ transferu pamięci na cykl RF** i przyspieszając fazę o **28.9% (1.41x)**.

---

### 1.4. Eliminacja Alokacji Sterty i Odśmiecacza Pamięci (Zero-Allocation)
Pomiary wykonane narzędziem [`experiments/Go-sequential/3-zero-allocation/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-sequential/3-zero-allocation/bench) (4000 kroków, procedura `randomSample`):

| Wariant Implementacji | Czas 1 Cyklu (4000 kroków) | Alokacja Całkowita | Alokacja / Krok | Cykle GC (`NumGC`) | Łączny Czas Pauz STW | Przyspieszenie |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Naiwny port (Krok 2: `make([]int, n)`)** | 883 ms | **4.49 GB** | 1176.0 KB | **1317** | **131.1 ms** | 1.00x (ref) |
| **Zero-Allocation (Krok 3: `sim.SamplePool`)** | **189 ms** | **0 B** | **0.0 KB** | **0** | **0.0 ms** | **4.66x** |

---

## 2. Szablony Tabel dla Wyników Klastrowych (WCSS / Slurm)
*(Do uzupełnienia po spłynięciu wyników z klastra Lem/Bem)*

### 2.1. Zestawienie Czasów Wykonania Symulacji (100 Cykli RF, tryb bez pomiarów)

| Implementacja / Wersja | 1 Rdzeń (HPC WCSS Lem) | 2 Rdzenie | 4 Rdzenie | 8 Rdzeni (1 CCX) | 16 Rdzeni | 32 Rdzenie | 64 Rdzenie |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **C++ Sequential Baseline** | *[T_c_seq]* | — | — | — | — | — | — |
| **C++ OpenMP (zoptymalizowany)** | *[T_c_1]* | *[T_c_2]* | *[T_c_4]* | *[T_c_8]* | *[T_c_16]* | *[T_c_32]* | *[T_c_64]* |
| **Go Sekwencyjny 1 (Baseline $T_0$)** | **1500.39 s** (IPC 2.58) | — | — | — | — | — | — |
| **Go Sekwencyjny 2 (Algorithmic Port)** | **298.25 s** (IPC 4.12, **5.03x**) | — | — | — | — | — | — |
| **Go Sekwencyjny 3 (Zero-Allocation)** | **272.69 s** (IPC 4.27, **5.50x**) | — | — | — | — | — | — |
| **Go Sekwencyjny 4 (BCE & Unrolling)** | *[T_go_s4]* | — | — | — | — | — | — |
| **Go Równoległy 1 (Channels)** | — | *[T_p1_2]* | *[T_p1_4]* | *[T_p1_8]* | *[T_p1_16]* | *[T_p1_32]* | *[T_p1_64]* |
| **Go Równoległy 2 (Chunking + L1d)** | — | *[T_p2_2]* | *[T_p2_4]* | *[T_p2_8]* | *[T_p2_16]* | *[T_p2_32]* | *[T_p2_64]* |
| **Go Równoległy 3 (StarBarrier)** | — | *[T_p3_2]* | *[T_p3_4]* | *[T_p3_8]* | *[T_p3_16]* | *[T_p3_32]* | *[T_p3_64]* |
| **Go Równoległy 4 (Fused Move&Detect)** | — | *[T_p4_2]* | *[T_p4_4]* | *[T_p4_8]* | *[T_p4_16]* | *[T_p4_32]* | *[T_p4_64]* |
| **Go Równoległy 5 (Optimized Final)** | — | *[T_p5_2]* | *[T_p5_4]* | *[T_p5_8]* | *[T_p5_16]* | *[T_p5_32]* | *[T_p5_64]* |

---

### 2.2. Zestawienie Liczników Sprzętowych `perf stat` (dla 8 Rdzeni CCX)

| Metryka Sprzętowa | Go Parallel 1 (Channels) | Go Parallel 2 (Chunking) | Go Parallel 3 (StarBarrier) | Go Parallel 4 (Fused) | Go Parallel 5 (Optimized) | C++ OpenMP |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Instrukcje (`instructions`)** | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* |
| **Cykle procesora (`cycles`)** | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* |
| **Wskaźnik IPC (`IPC`)** | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* |
| **Chybienia L1d (`L1-dcache-load-misses`)** | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* |
| **Chybienia L3 LLC (`LLC-load-misses`)** | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* |
| **Przełączenia kontekstu (`context-switches`)** | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* |
| **Błędne skoki (`branch-misses`)** | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* | *[dane]* |
