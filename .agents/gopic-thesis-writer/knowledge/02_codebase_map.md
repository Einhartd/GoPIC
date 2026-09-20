# Mapa Architektury Repozytorium GoPIC

Niniejszy dokument stanowi kompletny przewodnik po strukturze repozytorium GoPIC dla asystenta pracy magisterskiej.

---

## 1. Lokalizacja Główna Repozytorium ($GOPIC_ROOT)
- **Lokalizacja na maszynie deweloperskiej:** `$GOPIC_ROOT` (domyślnie podawana przez użytkownika lub dynamicznie wykrywana).
- **Lokalizacja na klastrze HPC (WCSS Bem / Lem):** `$HOME/GoPIC`

---

## 2. Implementacje Referencyjne i Eksperymentalne w C++

### 2.1. Kod Referencyjny (Ground Truth)
- [`eduPIC/C/eduPIC.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/eduPIC/C/eduPIC.cc)  
  Oryginalny, akademicki kod sekwencyjny prof. Donkó i współpracowników. Służy jako niepodważalny punkt odniesienia poprawności fizycznej (**Ground Truth**).
- [`golden_record/picdata.bin`](file:///C:/Users/E14/Documents/GitHub/GoPIC/golden_record/picdata.bin)  
  Zapis binarnego stanu symulacji po $100$ cyklach RF, używany przez testy regresyjne do weryfikacji tożsamości fizycznej zoptymalizowanych kodów.

### 2.2. Ścieżka Optymalizacji C++
- [`C/experimental/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/experimental)  
  Katalog zawierający ewolucję optymalizacyjną w języku C++:
  - Wdrożenie metody zderzeń zerowych (Null-Collision).
  - Wektoryzacja SIMD (AVX2, AVX-512) z flagami `-O3 -march=native -ffast-math`.
  - Wersja wielowątkowa OpenMP (`#pragma omp parallel for`) z powiązaniem do modułów CCX procesorów AMD Zen.
  - Skrypt weryfikacji lokalnej: [`C/experimental/run_local_perf.sh`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/experimental/run_local_perf.sh).

---

## 3. Ścieżka Optymalizacji w Języku Go: Wersje Sekwencyjne (1-4)

W katalogu `Go/` znajdują się ściśle wyodrębnione, samodzielne etapy optymalizacji sekwencyjnej:

1. [`Go/1.experiment-baseline/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/1.experiment-baseline)  
   - Czysty, bezpośredni port kodu C++ bez zmian algorytmicznych (Direct MCC).
   - Punkt odniesienia czasu wykonania ($T_0^{\text{Go}}$).
2. [`Go/2.algorithmic-port/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/2.algorithmic-port)  
   - Wdrożenie Null-Collision, aproksymacji de Moivre'a-Laplace'a, kątów Eulera i prekomputacji Thomasa.
   - Celowe pozostawienie alokacji sterty `make([]int, n)` w procedurze losowania kandydatów do zderzeń (`randomSample`), demonstrujące narzut alokatora Go.
3. [`Go/3.zero-allocation/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/3.zero-allocation)  
   - Ponowne wykorzystanie prealokowanego bufora `sim.SamplePool[:n]` (dokładnie 0 B/op, 0 allocs/op).
   - Wyciszenie odśmiecacza pamięci (`debug.SetGCPercent(-1)`).
4. [`Go/4.bce-loop-unrolling/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/4.bce-loop-unrolling)  
   - Eliminacja sprawdzania granic tablic (Bounds Check Elimination — BCE) za pomocą strażników `_ = xe[end-1]`.
   - 4-krotne rozwinięcie pętli (4-way loop unrolling) w integratorze Leap-Frog w celu zwiększenia równoległości na poziomie instrukcji (ILP).
   - Flaga kompilacji architektury AMD Zen 4: `GOAMD64=v4`.

---

## 4. Ścieżka Optymalizacji w Języku Go: Wersje Równoległe (1-5)

Pełna ewolucja zrównoleglenia silnika wielowątkowego:

1. [`Go/parallel-1-channels/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel-1-channels)  
   - Model CSP (Communicating Sequential Processes) oparty na kanałach Go (`reqCh` i `respCh`).
   - Wąskie gardło: blokady `hchan.lock` i narzut przełączania kontekstu gorutyn.
2. [`Go/parallel-2-buffers-chunking/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel-2-buffers-chunking)  
   - Dekompozycja domenowa cząstek na ciągłe chunki, eliminacja kanałów na rzecz współdzielenia pamięci.
   - Prywatne bufory gęstości ładunku w pamięci podręcznej L1d (`WorkerEDensity`), eliminujące False Sharing.
   - Synchronizacja za pomocą standardowego prymitywu `sync.WaitGroup` (narzut `SYS_futex`).
3. [`Go/parallel-3-star-barrier/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel-3-star-barrier)  
   - Dedykowana bezblokadowa bariera w architekturze gwiazdy (`StarBarrier`) z instrukcją `PAUSE` (`procyield(30)`).
   - Trwałe gorutyny workerów w tle, koordynator wykonujący zadanie workera 0.
   - Osobne fazy Leap-Frog i sprawdzania granic (izolujące czysty zysk barierowy).
4. [`Go/parallel-4-boundary-compaction/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel-4-boundary-compaction)  
   - Fuzja pętli Leap-Frog z detekcją granic (**Fused Move & Detect**), sprawdzanie $x < 0 \lor x > L$ bezpośrednio w rejestrach CPU.
   - Eliminacja 2 barier na krok czasowy ($8000$ barier mniej na cykl RF) i oszczędność $4.8\text{ GB}$ transferu pamięci RAM.
   - Zero-barierowa seryjna kompaktacja $O(\text{dead})$ in-place metodą `swap-with-last`.
5. [`Go/parallel-5-optimized-final/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel-5-optimized-final)  
   - Ostateczny silnik równoległy Go: fuzja pętli + BCE + 4-way loop unrolling + `GOAMD64=v4`.

---

## 5. Dedykowane Mikrobenchmarki w `experiments/`

Katalogi z izolowanymi, powtarzalnymi testami zjawisk sprzętowych:
- [`experiments/Go-sequential/3-zero-allocation/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-sequential/3-zero-allocation/bench)  
  Pomiary alokacji sterty (4.5–4.8 GB/cykl), 1317 cykli GC i przyspieszenia 4.66x.
- [`experiments/Go-parallel/1-channels/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-parallel/1-channels/bench)  
  Pomiary narzutu $20\,000$ barier: Go Channels vs `sync.WaitGroup` vs `StarBarrier` (7.59x przyspieszenie StarBarrier na 8 wątkach).
- [`experiments/Go-parallel/2-buffers-false-sharing/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-parallel/2-buffers-false-sharing/bench)  
  Pomiary zjawiska False Sharing i Cache Line Bouncing (38x–105x przyspieszenie prywatnych buforów L1d).
- [`experiments/Go-parallel/4-boundary-compaction/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-parallel/4-boundary-compaction/bench)  
  Pomiary przepustowości pamięci: Two-Pass vs Fused Move & Detect (oszczędność 4.8 GB RAM na cykl, przyspieszenie 1.41x).

---

## 6. Zadania Slurm na Klastrze HPC: `GoPIC_jobs/`

- [`GoPIC_jobs/README.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/GoPIC_jobs/README.md) — Kompletny podręcznik uruchamiania zadań Slurm.
- [`GoPIC_jobs/Go/gopic_parallel_exp_job_stat.sh`](file:///C:/Users/E14/Documents/GitHub/GoPIC/GoPIC_jobs/Go/gopic_parallel_exp_job_stat.sh) — Uniwersalny skrypt zlecający pomiary `perf stat` dla kroków równoległych 1–5 (`PARALLEL_STEP=1..5`).
- [`GoPIC_jobs/Go/gopic_parallel_exp_job_record.sh`](file:///C:/Users/E14/Documents/GitHub/GoPIC/GoPIC_jobs/Go/gopic_parallel_exp_job_record.sh) — Skrypt profilujący `perf record` z automatycznym generowaniem wykresów płomieniowych (Flame Graphs).
- [`GoPIC_jobs/C/edupic_omp_job_stat.sh`](file:///C:/Users/E14/Documents/GitHub/GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh) — Skrypt pomiarowy C++ OpenMP z powiązaniem do modułów CCX.
