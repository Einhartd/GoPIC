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

### 2.1. Zestawienie Czasów Wykonania Symulacji (100 Cykli RF na klastrze HPC Lem)

| Implementacja / Wersja | 1 Rdzeń | 2 Rdzenie | 4 Rdzenie | 8 Rdzeni (1 CCX) | 16 Rdzeni | 32 Rdzenie | 64 Rdzenie |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **C++ Sequential Baseline** | **142.42 s** | — | — | — | — | — | — |
| **C++ OpenMP (zoptymalizowany)** | **142.42 s** (IPC 3.69) | **77.70 s** (IPC 3.49) | **40.83 s** (IPC 3.24) | **23.11 s** (IPC 2.87) | **16.60 s** (IPC 1.98) | **14.30 s** (IPC 1.45) | **19.85 s** (IPC 0.82) |
| **Go Sekwencyjny 1 (Baseline $T_0$)** | **1500.39 s** (IPC 2.58) | — | — | — | — | — | — |
| **Go Sekwencyjny 2 (Algorithmic Port)** | **298.25 s** (IPC 4.12, **5.03x**) | — | — | — | — | — | — |
| **Go Sekwencyjny 3 (Zero-Allocation)** | **272.69 s** (IPC 4.27, **5.50x**) | — | — | — | — | — | — |
| **Go Sekwencyjny 4 (BCE & Unrolling)** | **249.95 s** (IPC 4.27, **6.00x**) | — | — | — | — | — | — |
| **Go Równoległy 1 (Channels)** | **224.75 s** (IPC 4.07) | **198.70 s** (IPC 3.72) | **214.14 s** (IPC 2.80) | **103.29 s** (IPC 3.48) | — | — | — |
| **Go Równoległy 2 (Chunking + L1d)** | **208.97 s** (IPC 4.41) | **161.11 s** (IPC 3.64) | **173.88 s** (IPC 3.12) | **168.93 s** (IPC 1.92) | — | — | — |
| **Go Równoległy 3 (StarBarrier)** | — | **122.41 s** (IPC 3.83) | **73.95 s** (IPC 3.18) | **54.52 s** (IPC 2.44) | — | — | — |
| **Go Równoległy 4 (Fused Move&Detect)**| — | **125.92 s** (IPC 3.43) | **60.35 s** (IPC 3.65) | **44.32 s** (IPC 2.53) | — | — | — |
| **Go Równoległy 5 (Optimized Final)** | **199.20 s** (IPC 4.50) | **107.90 s** (IPC 4.20) | **57.49 s** (IPC 3.90) | **47.48 s** (IPC 2.46) | **31.49 s** (IPC 1.82) | **21.89 s** (IPC 1.26) | **39.29 s** (IPC 0.43) |

---

### 2.2. Zestawienie Liczników Sprzętowych `perf stat` (dla 8 Rdzeni CCX)

| Metryka Sprzętowa | Go Parallel 1 (Channels) | Go Parallel 2 (Chunking) | Go Parallel 3 (StarBarrier) | Go Parallel 4 (Fused) | Go Parallel 5 (Optimized) | C++ OpenMP |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Czas 100 cykli [s]** | **103.29 s** | **168.93 s** | **54.52 s** *(min 42.26 s)* | **44.32 s** *(min 38.49 s)* | **47.48 s** *(min 40.55 s)* | **23.11 s** |
| **Przyspieszenie vs Krok 1** | **1.00x** | **0.61x** *(spadek)* | **1.89x (2.44x)** | **2.33x (2.68x)** | **2.18x (2.55x)** | **4.47x** |
| **Instrukcje (`instructions`)** | 3 325 652 445 279 | 3 464 181 253 719 | 3 416 744 741 587 | **3 192 604 162 329** | 3 128 906 788 198 | **~890 000 000 000** |
| **Wskaźnik IPC** | **3.48** | **1.92** *(załamanie)* | **2.44** | **2.53** | **2.46** | **2.87** |
| **Chybienia L1d Miss %** | **4.82%** | **4.75%** | **2.84%** | **1.98%** *(minimum)* | **2.01%** | **1.25%** |
| **Narzut granic (Step 5)** | w `startWorker` | **8.82% CPU** | **11.92% CPU** | **< 0.05% CPU** | **< 0.05% CPU** | **< 0.1% CPU** |
| **Prymityw synchronizacji** | kanały Go (`chan`) | `sync.WaitGroup` | `StarBarrier` (PAUSE) | `StarBarrier` (PAUSE) | `StarBarrier` (PAUSE) | `#pragma omp barrier` |
| **Narzut synchronizacji** | muteks `hchan.lock` | kernel `SYS_futex` | `procyield` (32.7% CPU) | `procyield` (22.4% CPU) | `procyield` (~20% CPU) | libgomp spin-wait |
