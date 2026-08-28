# Przewodnik uruchamiania zadań HPC (Slurm Job Commands)

Ten dokument zawiera komendy do zlecania zadań Slurm (`sbatch`) dla wszystkich implementacji symulacji **GoPIC** (Go, C++, Python), z podziałem na pomiary liczników sprzętowych (`perf stat`) oraz profilowanie (`perf record`).

> [!IMPORTANT]
> **Architektura procesorów AMD EPYC i powiązanie rdzeni (Affinity):**
> Na procesorach AMD EPYC (architektura Zen/CCX) alokacja pofragmentowanych pojedynczych rdzeni prowadzi do drastycznego spadku wydajności z powodu opóźnień magistrali *Infinity Fabric*.
> Z tego powodu domyślna jednostka alokacji w skryptach równoległych wynosi **`#SBATCH --cpus-per-task=8`** (1 pełny moduł CCX ze wspólnym 32 MB L3 Cache).
> 
> Aby przetestować skalowanie (np. na 1, 2, 4 lub 8 wątkach), **nie zmieniaj nagłówka Slurma**, lecz przekaż zmienną środowiskową:
> - Dla **C++ OpenMP**: `OMP_THREADS=K` (np. `OMP_THREADS=2`)
> - Dla **Go**: `GOMAXPROCS=K,NUM_WORKERS=K` (np. `GOMAXPROCS=2,NUM_WORKERS=2`)

---

## Spis treści
1. [Szybka ściągawka (Cheat Sheet)](#1-szybka-ściągawka-cheat-sheet)
2. [Dostępne flagi środowiskowe](#dostępne-flagi-środowiskowe---exportall)
3. [Go — Zadania równoległe i sekwencyjne](#2-go)
   - [Go Chunking](#21-go-chunking)
   - [Go Channels](#22-go-channels)
   - [Go Sequential](#23-go-sequential)
4. [C++ — Zadania OpenMP i sekwencyjne](#3-c)
   - [C++ OpenMP](#31-c-openmp)
   - [C++ Sequential](#32-c-sequential)
5. [Python — Zadania sekwencyjne i Numba](#4-python)
6. [Zarządzanie zadaniami Slurm](#5-zarządzanie-zadaniami-slurm)
7. [Automatyczne generowanie Flame Graphs](#6-automatyczne-generowanie-flame-graphs-na-klastrze)

---

## 1. Szybka ściągawka (Cheat Sheet)

```bash
# C++ OpenMP na 2 wątkach (w zwartym bloku 8 rdzeni CCX):
sbatch --export=ALL,OMP_THREADS=2 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# C++ OpenMP na pełnym bloku 8 rdzeni CCX:
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# Go Chunking (Null-Collision, 2 wątki / 2 workerów):
sbatch --export=ALL,USE_NULL_COLLISION=1,GOMAXPROCS=2,NUM_WORKERS=2 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Go Chunking (Null-Collision, pełne 8 rdzeni CCX):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh
```

---

## Dostępne flagi środowiskowe (`--export=ALL,...`)

- `OMP_THREADS=K` (C++) — liczba wątków OpenMP (domyślnie równa przydzielonym rdzeniom `$SLURM_CPUS_PER_TASK`).
- `GOMAXPROCS=K` (Go) — liczba wątków systemowych runtime Go.
- `NUM_WORKERS=K` (Go) — liczba gorutyn workerów symulacji (domyślnie równa `$GOMAXPROCS`).
- `USE_NULL_COLLISION=1` — wybór wersji zoptymalizowanej Null-Collision (brak flagi = Standard MCC dla Go/Python).
- `MEASUREMENT=m` (lub `MEASUREMENT_MODE=1`) — uruchomienie w trybie pomiarowym (`measurement_mode`), zbieranie diagnostyk $XT$, IFED, EEPF oraz generowanie raportu `info.txt`.
- `N_CYCLES=N` — liczba cykli RF do wykonania (domyślnie 100 dla stat, 20/100 dla record).

---

## 2. Go

### 2.1. Go Chunking

#### Pomiary liczników sprzętowych (`perf stat` — 100 cykli):
```bash
# Null-Collision na 2 rdzeniach / 2 workerach:
sbatch --export=ALL,USE_NULL_COLLISION=1,GOMAXPROCS=2,NUM_WORKERS=2 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Null-Collision na 8 rdzeniach / 8 workerach (pełny CCX):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Null-Collision z oversubscription (np. 16 lub 32 gorutyny na 8 rdzeniach):
sbatch --export=ALL,USE_NULL_COLLISION=1,NUM_WORKERS=16 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Standard MCC:
sbatch GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh
```

#### Profilowanie drzewa wywołań (`perf record`):
```bash
# Null-Collision:
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_record.sh

# Standard MCC:
sbatch GoPIC/GoPIC_jobs/Go/gopic_chunking_job_record.sh
```

---

### 2.2. Go Channels

#### Pomiary liczników sprzętowych (`perf stat`):
```bash
# Null-Collision na 2 workerach:
sbatch --export=ALL,USE_NULL_COLLISION=1,GOMAXPROCS=2,NUM_WORKERS=2 GoPIC/GoPIC_jobs/Go/gopic_channels_job_stat.sh

# Null-Collision na 8 workerach:
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_channels_job_stat.sh

# Standard MCC:
sbatch GoPIC/GoPIC_jobs/Go/gopic_channels_job_stat.sh
```

#### Profilowanie (`perf record`):
```bash
# Null-Collision:
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_channels_job_record.sh

# Standard MCC:
sbatch GoPIC/GoPIC_jobs/Go/gopic_channels_job_record.sh
```

---

### 2.3. Go Sequential

```bash
# Stat (Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_job_stat.sh

# Stat (Standard MCC):
sbatch GoPIC/GoPIC_jobs/Go/gopic_job_stat.sh

# Record (Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_job_record.sh

# Record (Standard MCC):
sbatch GoPIC/GoPIC_jobs/Go/gopic_job_record.sh
```

---

## 3. C++

### 3.1. C++ OpenMP
*(Implementacja OpenMP wykorzystuje zoptymalizowany, natywny silnik Null-Collision oraz powiązanie wątków w module CCX)*

#### Pomiary liczników sprzętowych (`perf stat` — 100 cykli):
```bash
# Uruchomienie na 2 wątkach (w zwartym bloku CCX):
sbatch --export=ALL,OMP_THREADS=2 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# Uruchomienie na 4 wątkach:
sbatch --export=ALL,OMP_THREADS=4 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# Uruchomienie na pełnym bloku 8 wątków:
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# Z pełnymi diagnostykami fizycznymi (measurement mode):
sbatch --export=ALL,MEASUREMENT=m,OMP_THREADS=2 GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh
```

#### Profilowanie (`perf record`):
```bash
# Profilowanie wywołań i generowanie Flame Graph (2 wątki):
sbatch --export=ALL,OMP_THREADS=2 GoPIC/GoPIC_jobs/C/edupic_omp_job_record.sh

# Profilowanie na 8 wątkach:
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_record.sh
```

---

### 3.2. C++ Sequential

```bash
# Stat (Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/C/edupic_job_stat.sh

# Stat (Standard MCC):
sbatch GoPIC/GoPIC_jobs/C/edupic_job_stat.sh

# Record (Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/C/edupic_job_record.sh
```

---

## 4. Python

```bash
# Python Sequential (Stat, Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/python/pypic_stat.sh

# Python Sequential (Stat, Standard MCC):
sbatch GoPIC/GoPIC_jobs/python/pypic_stat.sh

# Python Numba (Stat, Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/python/pypic_numba_job_stat.sh

# Python Numba (Record, Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/python/pypic_numba_job_record.sh
```

---

## 5. Zarządzanie zadaniami Slurm

```bash
# Sprawdzenie kolejki zadań użytkownika:
squeue -u $USER

# Podgląd szczegółów konkretnego joba:
scontrol show job <JOB_ID>

# Anulowanie zadania:
scancel <JOB_ID>

# Anulowanie wszystkich swoich zadań:
scancel -u $USER

# Podgląd logu działającego zadania na żywo:
tail -f saved_logs_Go/logs_job_<JOB_ID>_*/job_output.log
tail -f saved_logs_C/logs_job_<JOB_ID>_*/job_output.log
tail -f saved_logs_python/logs_job_<JOB_ID>_*/job_output.log
```

---

## 6. Automatyczne generowanie Flame Graphs na klastrze

Wszystkie skrypty `*_record.sh` automatycznie generują pliki **`perf.folded`** oraz wektorowy wykres **`flamegraph.svg`** bezpośrednio na węźle obliczeniowym (zaraz po zakończeniu `perf record`).

Aby to działało, wystarczy jednorazowo sklonować narzędzie [FlameGraph](https://github.com/brendangregg/FlameGraph) w katalogu domowym na węźle logowania klastra:
```bash
git clone --depth 1 https://github.com/brendangregg/FlameGraph.git $HOME/FlameGraph
```
*Skrypty sprawdzają katalogi `$HOME/FlameGraph` oraz `$HOME/GoPIC/plots/FlameGraph`.*
Po zakończeniu zadania plik `flamegraph.svg` znajduje się w katalogu `edupic_data/` danego joba i jest gotowy do otwarcia w dowolnej przeglądarce lub w notatniku `plots/flamegraphs.ipynb`.
