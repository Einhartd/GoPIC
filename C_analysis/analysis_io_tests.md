# Analiza modułu I/O oraz testów dla eduPIC (OpenMP)

Poniżej znajduje się szczegółowa analiza pliku zarządzającego operacjami wejścia/wyjścia (`io_manager.h`) oraz zestawu testów jednostkowych i integracyjnych (katalog `tests/`). 

## 1. Moduł I/O (`io_manager.h`)

### Organizacja zapisu/odczytu i format danych
Plik zawiera zbiór funkcji narzędziowych (`save_particle_data`, `load_particle_data`, `save_density`, `save_eepf` itp.) odpowiedzialnych za persystencję stanu symulacji. Wykorzystuje standardowe biblioteki C (`<cstdio>`, `<cstdlib>`). 

Dane cząstek zapisywane są w formacie **binarnym** (`picdata.bin`), podczas gdy wyniki diagnostyczne w **tekstowym** (`.dat`, `.txt`).
Wykorzystywane są blokowe operacje I/O (ang. *block I/O*). Zamiast iterować po każdej cząstce i zapisywać ją oddzielnie, wywoływane jest np. `fwrite(x_e, sizeof(double), N_e, f)`. Jest to kluczowa optymalizacja unikająca narzutu na formatowanie i wywołania systemowe (zmniejszenie liczby przejść przez *kernel space*).
- **Źródło:** [Intel - Optimizing File I/O in C/C++](https://www.intel.com/content/www/us/en/developer/articles/technical/optimize-application-performance-with-intel-fortran-compiler.html)

### Brak zrównoleglenia I/O
Wszystkie operacje I/O w tym pliku są **sekwencyjne** (brak dyrektyw `#pragma omp`). Jest to zgodne z dobrymi praktykami w kodach MPI/OpenMP, gdy nie używamy wyspecjalizowanych bibliotek takich jak HDF5 czy MPI-IO. Równoległy zapis do jednego pliku za pomocą standardowych funkcji `stdio` (takich jak `fprintf` czy `fwrite`) doprowadziłby do *race conditions* i uszkodzenia pliku, chyba że wprowadzono by rygorystyczne blokady (co zabiłoby wydajność). W symulacjach PIC, gdzie I/O następuje zazwyczaj okresowo lub po zakończeniu głównej pętli, proces ten rzadko bywa krytycznym wąskim gardłem.
- **Źródło:** [OpenMP Specification 5.0 - Thread Safety for I/O](https://www.openmp.org/spec-html/5.0/openmpsu107.html)

### Normalizacja danych diagnostycznych (XT, EEPF, IFED)
Przed zapisem danych przestrzenno-czasowych (XT - np. prądy, moce, rozkład potencjału), wywoływana jest funkcja `norm_all_xt()`. Oblicza ona wartości średnie na podstawie odpowiednich liczników zdarzeń w komórkach (np. `counter_e_xt`, które w równoległym kodzie głównym muszą być aktualizowane za pomocą dyrektyw *atomic*). Zabezpiecza to przed problemem dzielenia przez zero. 

### Porównanie z oryginałem
Implementacja I/O pozostaje nietknięta w stosunku do seryjnego kodu `eduPIC.cc`. Ze względu na prawo Amdahla, pozostawienie I/O sekwencyjnym jest optymalną drogą przy równoległym zoptymalizowaniu głównej pętli czasowej cząstek.

---

## 2. Testy (katalog `tests/`)

Zestaw testów oparty o framework Google Test (`gtest`) weryfikuje zrównolegloną implementację, stosując technikę *differential testing* (testy różnicowe). Porównują one wykonanie danego etapu na jednym wątku ze stanem po wykonaniu współbieżnym z 4 wątkami.

### `test_boundaries.cc`
- **Co testuje:** Zachowanie warunków brzegowych przy krawędziach symulacji.
- **Weryfikacja równoległa:** Inicjalizuje stan cząstek, wykonuje jeden krok z 1 wątkiem, zapisuje referencyjny stan, po czym resetuje model i powtarza operację z 4 wątkami.
- **Determinizm i Race Conditions:** Test rozwiązuje kluczowy problem równoległego zarządzania listami: równoległy algorytm usuwania uciekających cząstek (tzw. *swap-with-last*) psuje pierwotną kolejność cząstek w tablicy (jest niedeterministyczny w kwestii układu). Aby to zignorować, test **sortuje** ocalałe cząstki po ich pozycji (współrzędnej `x`), a dopiero następnie iteruje przy użyciu `EXPECT_DOUBLE_EQ`. To wzorowa praktyka eliminująca wady weryfikacji bitowej.
- **Źródło koncepcji:** [Particle-in-Cell Simulations on Multicore Architectures](https://arxiv.org/pdf/1302.3683.pdf) (rozdziały na temat aktualizacji i śledzenia list cząstek).

### `test_collisions.cc`
- **Co testuje:** Równoległą mechanikę zderzeń Monte Carlo. W tym testy Null-Collision Method (jeśli aktywowano makro).
- **Zarządzanie pamięcią (bufory lokalne):** W trakcie symulacji kolizji jonizujących (tworzących nowe pary elektron-jon), niemożliwe jest globalne używanie `push_back()` ze względu na współdzielenie pamięci. Test weryfikuje poprawne wstawianie do tymczasowych struktur (`NewParticles` / thread-local bufory), co chroni przed race conditions.

### `test_density.cc` & `test_push.cc`
- **Co testuje:** Nakładanie ładunku (Scatter/Gather) na siatkę gęstości oraz integrację ruchu (Push/Move).
- **Redukcje i brak asocjatywności zmiennoprzecinkowej:** Testowanie sum cząstkowych i ładunków rozrzuconych na siatkę. Wykorzystywana jest tu funkcja `EXPECT_NEAR(..., 1e-5)` – ponieważ równoległe sumowanie floatów zmienia kolejność działań w stosunku do kodu sekwencyjnego, co wywołuje inne błędy zaokrągleń i wyklucza testowanie co do bitu.
- **Zliczenia atomowe:** Weryfikowane są zliczenia do zmiennych diagnostycznych (`counter_e_xt` i średnia energia). Prawdopodobnie chronione poprzez pragmy `atomic`.
- **Źródło:** [Intel - Consistency of Floating-Point Results](https://www.intel.com/content/www/us/en/developer/articles/technical/consistency-of-floating-point-results-using-the-intel-compiler.html)

### `test_rng.cc`
- **Co testuje:** Zachowanie niezależnych generatorów pseudolosowych (Mersenne Twister `MTgen`).
- **Optymalizacja False Sharing & Skalowalność:** Przypisanie dedykowanego, lokalnego dla wątku (thread-local) RNG z różnymi ziarnami (inicjowanymi za pomocą `MTgen.seed(12345 + tid)`). Unika to drastycznych opóźnień powodowanych blokadami na pojedynczym wskaźniku czy tzw. zjawiskiem *false sharing* podczas uderzania w wspólną strukturę pamięci.
- **Źródło:** [Intel - Efficient Parallel Random Number Generation](https://www.intel.com/content/www/us/en/developer/articles/technical/efficient-parallel-random-number-generation.html)

### `Makefile`
- Poprawna kompilacja wspierająca C++17 z użyciem flagi optymalizacyjnej `-O2` oraz włączoną wielowątkowością dzięki dyrektywie kompilatora `-fopenmp`. Łączenie z biblioteką `libgtest`. Brak dodatkowego narzutu; idealne dla HPC.
