# GoPIC

Badania nad zrównolegloną implementacją symulacji plazmy metodą **Particle-in-Cell / Monte Carlo Collisions (1D3V PIC/MCC)** w języku **Go (Golang)** oraz analiza porównawcza z referencyjną implementacją w **C++ (OpenMP + SIMD)** na podstawie kodu [eduPIC](https://doi.org/10.1088/1361-6595/ac0b55).

---

## Struktura repozytorium

```text
GoPIC/
├── C/
│   ├── sequential/       # Referencyjna jednowątkowa implementacja C++17 (eduPIC + opcjonalne Null-Collision)
│   └── final/            # Zoptymalizowana i zrównoleglona implementacja C++17 (OpenMP, SIMD AVX-512, SoA)
├── Go/
│   ├── sequential/       # Referencyjny jednowątkowy port w języku Go (Standard MCC oraz Null-Collision)
│   └── final/            # Zoptymalizowana równoległa implementacja Go (StarBarrier, Loop Fusion, 4-way unrolling)
├── GoPIC_jobs/
│   ├── C/                # Skrypty zadań SLURM (perf stat / perf record) dla wariantów C++
│   └── Go/               # Skrypty zadań SLURM (perf stat / perf record) dla wariantów Go
├── golden_record/        # Wzorcowy stan stacjonarny plazmy 1x (picdata.bin, conv.dat)
├── golden_record_5x/     # Wzorcowy stan stacjonarny plazmy 5x (picdata.bin, conv.dat)
└── plots/                # Notebooki Jupyter z analizą poprawności fizycznej i skalowalności HPC
```

---

## Warianty symulacji

| Wariant | Katalog | Opis architektury |
| :--- | :--- | :--- |
| **C++ Sequential** | [`C/sequential`](C/sequential) | Oryginalny algorytm `eduPIC` (1D3V RF wyładowanie pojemnościowe w argonie). Obsługuje klasyczne MCC oraz metodę Null-Collision (`-DUSE_NULL_COLLISION`). |
| **C++ Final** | [`C/final`](C/final) | Wersja wielowątkowa OpenMP z trwałym zespołem wątków, prywatnymi buforami wyrównanymi do 64 B (`alignas(64)`), prekomputowanym solverem Thomasa, wektorową geometrią zderzeń i rozwinięciem pętli pod wektoryzację AVX-512. |
| **Go Sequential** | [`Go/sequential`](Go/sequential) | Wierny port sekwencyjny w Go z generatorem Mersenne Twister (`mt19937`). Przełączanie na metodę Null-Collision odbywa się przez znacznik kompilacji `-tags nullcollision`. |
| **Go Final** | [`Go/final`](Go/final) | Wysokowydajna wersja równoległa w Go: autorska bezblokadowa bariera [`StarBarrier`](Go/final/barrier.go) oparta na instrukcjach atomowych i asemblerowym `PAUSE` (`procyield`), fuzja kroków ruchu i detekcji granic, kompaktacja `O(dead)` bez barier oraz rozwinięcie pętli 4-way z eliminacją sprawdzania granic tablic (BCE). |

---

## Kompilacja i uruchomienie

### 1. C++ (`C/sequential` oraz `C/final`)

```bash
# Wersja sekwencyjna (Standard MCC)
g++ -std=c++17 -O3 -march=native -fno-math-errno C/sequential/eduPIC.cc -o edupic_seq -lm

# Wersja sekwencyjna (Null-Collision MCC)
g++ -std=c++17 -O3 -march=native -fno-math-errno -DUSE_NULL_COLLISION C/sequential/eduPIC.cc -o edupic_seq_nc -lm

# Wersja finalna równoległa (OpenMP + SIMD)
g++ -std=c++17 -O3 -march=native -ffast-math -funroll-loops -fopenmp -fopenmp-simd -fno-math-errno C/final/eduPIC.cc -o edupic_final -lm
```

### 2. Go (`Go/sequential` oraz `Go/final`)

```bash
# Wersja sekwencyjna (Standard MCC)
cd Go/sequential && go build -ldflags="-s -w" -o ../../gopic_seq ./cmd/pic

# Wersja sekwencyjna (Null-Collision MCC)
cd Go/sequential && go build -ldflags="-s -w" -tags nullcollision -o ../../gopic_seq_nc ./cmd/pic

# Wersja finalna równoległa (StarBarrier)
cd Go/final && GOAMD64=v4 go build -ldflags="-s -w" -o ../../gopic_final ./cmd/pic
```

### 3. Argumenty wiersza poleceń

Wszystkie pliki wykonywalne przyjmują spójny interfejs wiersza poleceń:

```bash
# Inicjalizacja nowej symulacji od zera (1 cykl inicjalizacyjny, tworzy picdata.bin oraz conv.dat)
./gopic_final 0

# Kontynuacja symulacji przez N cykli RF (np. z pliku golden_record/picdata.bin)
./gopic_final 100

# Kontynuacja z włączonym trybem pomiarowym ("m") — generuje pełne diagnostyki (density.dat, eepf.dat, ifed.dat, *_xt.dat, info.txt)
./gopic_final 100 m

# Wybór liczby workerów / wątków OS w wersji Go Final
./gopic_final --workers=8 --threads=8 100 m
```
