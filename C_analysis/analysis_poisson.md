# Analiza optymalizacji i zrównoleglenia w `poisson.h`

Plik `poisson.h` ([`/home/oliwier/Dev/GoPIC/C/parallel-only-omp/poisson.h`](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/poisson.h)) implementuje funkcję `solve_Poisson`, odpowiadającą za rozwiązywanie jednowymiarowego równania Poissona dla potencjału elektrycznego oraz obliczanie pola elektrycznego w symulacji 1D3V PIC/MCC. 

## 1. Struktura Kodu i Porównanie z Oryginałem
W porównaniu z oryginalnym kodem sekwencyjnym (`eduPIC.cc`), implementacja zachowuje identyczną logikę matematyczną, jednak wprowadza dwie istotne różnice strukturalne wspierające wydajność:
- **Zastosowanie modyfikatora `inline`**: Funkcja została zadeklarowana jako wstawkowa (`inline`). 
- **Globalizacja stałych w czasie kompilacji**: Lokalne stałe, takie jak `A`, `B`, `C`, `S`, `ALPHA`, które w `eduPIC.cc` były inicjalizowane wewnątrz funkcji na stosie, zostały wyniesione na zewnątrz (najprawdopodobniej do nagłówka `constants.h` poprzez włączenie `#include "constants.h"`). 

## 2. Zrównoleglenie OpenMP (Algorytm Thomasa)
**W pliku `poisson.h` nie ma żadnych dyrektyw `#pragma omp`.** 

Powodem tego jest fakt, że funkcja wykorzystuje **Algorytm Thomasa** (TDMA - Tridiagonal Matrix Algorithm) zoptymalizowany do złożoności $\mathcal{O}(N)$. Algorytm ten jest inherentnie (z natury) sekwencyjny. Wynika to z silnych zależności danych (data dependencies):
- **Eliminacja w przód (Forward sweep)**: `w[i]` zależy od wartości `w[i-1]`, a `g[i]` zależy od `g[i-1]` i `w[i-1]`.
- **Podstawienie wsteczne (Backward substitution)**: Wartość potencjału `pot[i]` w danym kroku pętli zależy od `pot[i+1]` wyliczonego w poprzedniej iteracji.

Wprawdzie istnieją równoległe warianty dla rozwiązywania układów trójdiagonalnych (takie jak [Cyclic Reduction](https://en.wikipedia.org/wiki/Cyclic_reduction) lub [Parallel Prefix Sum](https://en.wikipedia.org/wiki/Prefix_sum)), ich zastosowanie nie byłoby tutaj korzystne. Rozmiar siatki przestrzennej $N_G$ w symulacjach 1D plazmy rzadko przekracza 100-1000 węzłów. Dla tak krótkich pętli, **narzut na utworzenie i synchronizację wątków (fork-join overhead)** wprowadzany przez OpenMP przewyższyłby zyski czasowe ze zrównoleglenia (false scaling). Funkcja realizowana jest więc przez jeden główny wątek (lub wewnątrz pojedynczego zadania sekwencyjnego).

## 3. Obliczanie pola elektrycznego
Podobnie jak rozwiązanie równania Poissona, obliczanie pola elektrycznego (`efield`) nie zostało zrównoleglone za pomocą dyrektyw OpenMP:
```cpp
for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;
```
Pętla ta jest wolna od przenoszenia zależności (loop-carried dependencies), więc *mogłaby* zostać łatwo rozdzielona między wątki (np. `#pragma omp for`). Zrezygnowano z tego z uwagi na identyczny problem narzutu wielowątkowego (overhead) dla bardzo małej liczby iteracji w stosunku do szybkiej operacji wektorowej. 

## 4. Optymalizacje Pamięciowe, Numeryczne i Sprzętowe

- **Funkcje Inlinowane (Inlining)**: Zadeklarowanie funkcji `inline void solve_Poisson` sprawia, że kompilator wklei kod źródłowy funkcji bezpośrednio w główną pętlę symulacji PIC, eliminując konieczność tworzenia ramki stosu (stack frame) oraz skoków instrukcji (branch instructions). Jest to tzw. *Function Inlining*.
- **Wektoryzacja SIMD (Auto-vectorization)**: Z uwagi na brak zrównoleglenia wielowątkowego, kod polega w głównej mierze na równoległości poziomu instrukcji. Pętla przypisująca prawą stronę równania (`f[i] = ALPHA * rho1[i]`) oraz obliczająca pole elektryczne podlegają automatycznej wektoryzacji sprzętowej przez kompilator (Auto-vectorization). Kompilator konwertuje skalarne działania zmiennoprzecinkowe w wektorowe instrukcje AVX/SSE.
- **Stałe ewaluowane w czasie kompilacji (Constant Propagation/Folding)**: Przeniesienie stałych z funkcji do środowiska globalnego (nagłówki) wspiera stałe propagacje (Constant folding), odciążając cache i pozwalając kompilatorowi wpleść wartości skalarne prosto w instrukcje maszynowe, zamiast tracić cykle na przydzielanie ich za każdym wywołaniem w głównej pętli.
- **Warunki brzegowe jako stałe (Branchless)**: Warunki brzegowe uziemione i zasilane (Grounded and Powered electrodes) nie używają w bloku wewnętrznym wyrażeń warunkowych (if-statements), lecz są liczone poza głównymi pętlami (tzw. loop peeling / loop unrolling dla brzegów). Unika się w ten sposób kosztownego niepowodzenia predyktora skoków w procesorze (branch misprediction), co znacząco poprawia przepustowość.

## 5. Bottleneck (Wąskie Gardło PIC)
Z powodu niemożności efektywnego użycia zrównoleglenia, funkcja `solve_Poisson` jawi się jako klasyczny przykład **ograniczenia z Prawa Amdahla** w masowo równoległym programowaniu (Serial Bottleneck). Złożoność algorytmu to $\mathcal{O}(N_G)$, co stanowi zaledwie ułamek czasu dla kroku aktualizacji cząstek $\mathcal{O}(N_P)$ (gdzie typowo $N_P \gg N_G$). Choć na kilku-kilkunastu wątkach CPU wpływ ten jest niezauważalny, w miarę wzrostu liczby rdzeni to ten sekwencyjny odcinek powstrzyma aplikację przed osiągnięciem idealnego przyspieszenia (tzw. limit strong-scalingu). 

## 6. Źródła zastosowanych optymalizacji

- **Algorytm Thomasa i brak paralelizmu**: Zrozumienie natury trójdiagonalnej macierzy z perspektywy obliczeń wysokiej wydajności: [Tridiagonal Matrix Algorithm (Wikipedia - Computing)](https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm)
- **Narzut dyrektyw (OpenMP Fork-Join Overhead)**: Ograniczenia wynikające ze zrównoleglania zbyt małych pętli: [LLNL OpenMP Tutorial - Overheads](https://hpc-tutorials.llnl.gov/openmp/#Overhead)
- **Optymalizacja przez Inlining**: Znaczenie słowa kluczowego `inline` w ograniczaniu obciążeń (overhead) wywołań w C++: [GCC Compiler Documentation: Inlining](https://gcc.gnu.org/onlinedocs/gcc/Inline.html)
- **Optymalizacja instrukcji warunkowych (Branch Misprediction Penalty)**: Powód dla którego warunki brzegowe definiuje się poza pętlą dla uniknięcia wstrzymań potoku (pipeline stalls): [Intel® 64 and IA-32 Architectures Optimization Reference Manual (Branch Prediction)](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- **Automatyczna wektoryzacja SIMD**: Techniki autowektoryzacji pętli matematycznych przez kompilatory HPC: [Intel C++ Compiler Auto-Vectorization Guide](https://www.intel.com/content/www/us/en/docs/dpcpp-cpp-compiler/developer-guide-reference/2024-1/auto-vectorization.html)
- **Serial Bottleneck (Prawo Amdahla)**: Teoretyczne ograniczenie maksymalnego przyśpieszenia kodu równoległego przez sekwencyjny segment: [Amdahl's Law and Multicore Processors (Intel)](https://www.intel.com/content/www/us/en/developer/articles/technical/amdahls-law-and-multicore.html)
