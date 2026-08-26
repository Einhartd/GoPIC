# Przewodnik uruchamiania zadań HPC (Slurm Job Commands)

Ten dokument zawiera komendy do zlecania zadań Slurm (`sbatch`) dla wszystkich implementacji symulacji **GoPIC** (Go, C++, Python), z podziałem na pomiary liczników sprzętowych (`perf stat`) oraz profilowanie (`perf record`).

> [!NOTE]
> **Liczbę rdzeni CPU** ustawia się bezpośrednio w nagłówku danego skryptu: `#SBATCH --cpus-per-task=...`.
> Poniższe komendy skupiają się na wyborze wersji (**Null-Collision** vs **Standard**), liczbie gorutyn (**NUM_WORKERS**) oraz włączeniu trybu pomiarowego (**MEASUREMENT=m**).

---

## Spis treści
1. [Szybka ściągawka (Cheat Sheet)](#1-szybka-ściągawka-cheat-sheet)
2. [Go — Zadania równoległe i sekwencyjne](#2-go)
   - [Go Chunking](#21-go-chunking)
   - [Go Channels](#22-go-channels)
   - [Go Sequential](#23-go-sequential)
3. [C++ — Zadania OpenMP, MPI i sekwencyjne](#3-c)
   - [C++ OpenMP](#31-c-openmp)
   - [C++ Hybrid (MPI + OpenMP)](#32-c-hybrid-mpi--openmp)
   - [C++ Sequential](#33-c-sequential)
4. [Python — Zadania sekwencyjne, Numba i hybrydowe](#4-python)
5. [Zarządzanie zadaniami Slurm](#5-zarządzanie-zadaniami-slurm)

---

## 1. Szybka ściągawka (Cheat Sheet)

```bash
# Go Chunking (Null-Collision, gorutyny = rdzenie ze skryptu):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Go Chunking (Null-Collision, z pełnymi pomiarami fizycznymi / measurement mode):
sbatch --export=ALL,USE_NULL_COLLISION=1,MEASUREMENT=m GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# C++ OpenMP (tryb pomiarowy / measurement mode):
sbatch --export=ALL,MEASUREMENT=m GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# C++ OpenMP (domyślny zoptymalizowany pomiar stat):
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh
```

---

## Dostępne flagi środowiskowe (`--export=ALL,...`)

- `USE_NULL_COLLISION=1` — wybór wersji zoptymalizowanej Null-Collision (brak flagi = Standard MCC).
- `MEASUREMENT=m` (lub `MEASUREMENT_MODE=1`) — uruchomienie w trybie pomiarowym (`measurement_mode`), zbieranie diagnostyk $XT$, IFED, EEPF oraz generowanie raportu `info.txt`.
- `NUM_WORKERS=K` (dla Go) — liczba gorutyn workerów (domyślnie równa liczbie rdzeni ze skryptu `$SLURM_CPUS_PER_TASK`).
- `N_CYCLES=N` — liczba cykli RF do wykonania (domyślnie 100 dla stat, 20 dla record).

### 2.1. Go Chunking

#### Pomiary liczników sprzętowych (`perf stat` — 100 cykli):
```bash
# Wersja Null-Collision (liczba gorutyn = liczba rdzeni ze skryptu):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Wersja Null-Collision z oversubscription (np. 16, 32, 64 gorutyny):
sbatch --export=ALL,USE_NULL_COLLISION=1,NUM_WORKERS=16 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh
sbatch --export=ALL,USE_NULL_COLLISION=1,NUM_WORKERS=32 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh
sbatch --export=ALL,USE_NULL_COLLISION=1,NUM_WORKERS=64 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Wersja Standard MCC (domyślna liczba gorutyn):
sbatch GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh

# Wersja Standard MCC ze zdefiniowaną liczbą gorutyn:
sbatch --export=ALL,NUM_WORKERS=16 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_stat.sh
```

#### Profilowanie drzewa wywołań (`perf record` — 20 cykli):
```bash
# Wersja Null-Collision:
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_record.sh

# Wersja Null-Collision ze zdefiniowaną liczbą gorutyn:
sbatch --export=ALL,USE_NULL_COLLISION=1,NUM_WORKERS=16 GoPIC/GoPIC_jobs/Go/gopic_chunking_job_record.sh

# Wersja Standard MCC:
sbatch GoPIC/GoPIC_jobs/Go/gopic_chunking_job_record.sh
```

---

### 2.2. Go Channels

#### Pomiary liczników sprzętowych (`perf stat`):
```bash
# Wersja Null-Collision (gorutyny = rdzenie ze skryptu):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_channels_job_stat.sh

# Wersja Null-Collision ze zdefiniowaną liczbą gorutyn:
sbatch --export=ALL,USE_NULL_COLLISION=1,NUM_WORKERS=16 GoPIC/GoPIC_jobs/Go/gopic_channels_job_stat.sh

# Wersja Standard MCC:
sbatch GoPIC/GoPIC_jobs/Go/gopic_channels_job_stat.sh
```

#### Profilowanie (`perf record`):
```bash
# Wersja Null-Collision:
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/Go/gopic_channels_job_record.sh

# Wersja Standard MCC:
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
*(Implementacja OpenMP wykorzystuje zoptymalizowany, natywny silnik Null-Collision)*

#### Pomiary liczników sprzętowych (`perf stat` — 100 cykli):
```bash
# Standardowy pomiar stat:
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh

# Z pełnymi diagnostykami czasoprzestrzennymi (measurement mode):
sbatch --export=ALL,MEASUREMENT=m GoPIC/GoPIC_jobs/C/edupic_omp_job_stat.sh
```

#### Profilowanie (`perf record` — 20 cykli):
```bash
# Profilowanie wywołań i generowanie Flame Graph:
sbatch GoPIC/GoPIC_jobs/C/edupic_omp_job_record.sh
```

---

### 3.2. C++ Hybrid (MPI + OpenMP)

```bash
# Stat (Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/C/edupic_hybrid_job_stat.sh

# Stat (Standard MCC):
sbatch GoPIC/GoPIC_jobs/C/edupic_hybrid_job_stat.sh

# Record (Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/C/edupic_hybrid_job_record.sh
```

---

### 3.3. C++ Sequential

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

# Python Hybrid MPI (Stat, Null-Collision):
sbatch --export=ALL,USE_NULL_COLLISION=1 GoPIC/GoPIC_jobs/python/pypic_hybrid_job_stat.sh
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
