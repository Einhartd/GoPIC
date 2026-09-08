# Analiza i Wnioski z Pomiarów Wydajnościowych HPC

Ten katalog gromadzi zbiorcze analizy wydajnościowe, profile skalowania silnego (*strong scaling*), badania liczników sprzętowych (`perf stat`), profile próbkowania (`perf record` / Flame Graphs) oraz wnioski architektoniczne dla poszczególnych wariantów implementacji symulatora GoPIC na klastrze HPC.

## Dostępne Opracowania:

1. 📄 **[`c_omp_wnioski_i_obserwacje.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/benchmark_analysis/c_omp_wnioski_i_obserwacje.md)**  
   Kompleksowa analiza 28 zadań obliczeniowych (1–64 rdzeni) implementacji **C++ OpenMP** z katalogu `plots/hpc_logs/C-OMP`. Rekordowy czas **13.89 s** (speedup niemal 10×), analiza barier spin-wait w `libgomp` oraz wielkie zestawienie porównawcze z kodem Go.

2. 📄 **[`go_chunking_wnioski_i_obserwacje.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/benchmark_analysis/go_chunking_wnioski_i_obserwacje.md)**  
   Kompleksowa analiza 27 zadań obliczeniowych (1–64 rdzeni) implementacji **Go Parallel Chunking** (`sync.WaitGroup` + dynamiczny fork-join). Wyjaśnienie patologii mikrozadań, eksplozji wywołań `SYS_futex`, wpływu topologii AMD Zen 4 NUMA/CCX oraz przyczyn załamania skalowania powyżej 8 rdzeni.

3. 📄 **[`go_optimized_wnioski_i_obserwacje.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/benchmark_analysis/go_optimized_wnioski_i_obserwacje.md)**  
   Kompleksowa analiza 20 zadań obliczeniowych (1–64 rdzeni) implementacji **Go Parallel Optimized** (`StarBarrier` + asemblerowy `PAUSE` + fuzja pętli). Rekordowy czas **20.72 s** (speedup 9.57×), redukcja narzutu jądra o 99%, brak załamania skalowania i zbliżenie się do C++ OpenMP na odległość 1.49×.

4. 📄 **[`go_parallel_optimized_architektura.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/benchmark_analysis/go_parallel_optimized_architektura.md)**  
   Kompleksowy opis techniczny wariantu `Go/parallel_optimized`, uzasadnienie teoretyczne i literatura do pracy dyplomowej, wyniki mikrotestów bariery `StarBarrier` oraz pomiary przyspieszenia (1.81x).
