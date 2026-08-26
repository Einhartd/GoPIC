## Analiza plików `constants.h` oraz `state.h` w OpenMP PIC

Poniżej znajduje się szczegółowa analiza dwóch nagłówków C++ zawierających stałe i stan globalny symulatora eduPIC w wersji zrównoleglonej przez OpenMP.

### 1. Struktura kodu i porównanie z wersją seryjną
Wersja seryjna (`eduPIC.cc`) mieszała definicje stałych (`const double`), typów (`typedef`) oraz deklaracje zmiennych globalnych (np. `particle_vector x_e;`). 
W zrównoleglonej wersji kod został modułowo podzielony:
- **`constants.h`**: Zawiera tylko parametry symulacji, stałe fizyczne oraz definicje typów i rozmiarów tablic (`N_G`, `N_T`, `MAX_N_P`). Zachowano wierność względem oryginału, co ułatwia zarządzanie konfiguracją.
- **`state.h`**: Odpowiada za przechowywanie całego dynamicznego stanu symulacji (położenia cząstek, pola, diagnostykę). Wykorzystano tu słowo kluczowe `inline` (standard C++17), dzięki czemu zmienne globalne mogą być bezpiecznie dołączane w wielu jednostkach kompilacji (uniknięcie wielokrotnych definicji – ODR). 

### 2. Optymalizacje pamięciowe (SoA, Padding, Alignment)

#### Układ pamięci SoA (Structure of Arrays)
Stan cząstek przechowywany jest jako niezależne tablice: `x_e, vx_e, vy_e, vz_e` w przeciwieństwie do tablicy struktur cząstek (AoS). Jest to **układ Cache-Friendly (SoA)**. Kiedy pętla obliczeniowa aktualizuje tylko położenia `x` na podstawie prędkości `vx`, procesor pobiera z pamięci do cache'u ciągłe bloki użytecznych danych. Przy układzie AoS pobierane byłyby również nieużywane w danej chwili składowe `vy` i `vz`, marnując przepustowość pamięci.
- **Źródło**: [Intel - Memory Layout Transformations (SoA vs AoS)](https://www.intel.com/content/www/us/en/developer/articles/technical/memory-layout-transformations.html)

#### Zapobieganie False Sharing (Padding i Alignment)
W pliku `state.h` zdefiniowano strukturę `AlignedThreadCounters` używającą specyfikatora `alignas(64)`. Każdy wątek OpenMP zapisuje lokalne liczniki zderzeń i uderzeń w elektrody. Bez wyrównania, liczniki różnych wątków trafiłyby do tej samej 64-bajtowej linii pamięci podręcznej (cache line) procesora. Modyfikacja zmiennej przez jeden wątek unieważniałaby (invalidate) linię w L1 cache innych rdzeni, co drastycznie spowolniłoby działanie (tzw. zjawisko *False Sharing*). Wymuszenie `alignas(64)` gwarantuje, że dane każdego wątku leżą w osobnej linii cache, całkowicie eliminując rywalizację pamięciową.
- **Źródło**: [Intel - Avoiding and Identifying False Sharing Among Threads](https://www.intel.com/content/www/us/en/developer/articles/technical/avoiding-and-identifying-false-sharing-among-threads.html)

### 3. Wsparcie dla OpenMP (Zero-allocation i RNG)

#### Zarządzanie buforami wątków (`WorkerBuffers`)
Zdefiniowano strukturę `WorkerBuffers`, w której przed uruchomieniem głównej pętli symulacji (metoda `init_buffers(num_threads)`) dokonywana jest prealokacja wektorów z danymi diagnostycznymi (np. `e_density`, `counter_e`) oraz buforami tymczasowymi (`temp_x`, `thread_local_indices`) w rozmiarze dopasowanym do liczby wątków. Dzięki temu:
- Wątki posiadają całkowicie prywatne bufory robocze, do których piszą bez blokad (locks/atomic).
- Unika się jakiejkolwiek dynamicznej alokacji w głównej pętli symulacyjnej. Lokatory pamięci (jak `malloc`/`new`) zawierają w sobie globalne mechanizmy synchronizujące i stanowią wąskie gardło w zrównoleglonym kodzie.
- **Źródło**: [OpenMP API Specification (Private clauses and reduction strategies)](https://www.openmp.org/spec-html/5.0/openmpsu107.html)

#### Thread-Local Random Number Generators (RNG)
Losowanie liczb (np. Monte Carlo Collisions) wykorzystuje generatory z modyfikatorem `thread_local` (np. `thread_local std::mt19937 MTgen(rd())`). Używanie globalnego generatora wymagałoby krytycznych sekcji, co zabiłoby zrównoleglenie. Rozwiązanie to gwarantuje pełną asynchroniczność wątków, unikając wyścigów (race conditions).
- **Źródło**: [C++ Reference - thread_local specifier](https://en.cppreference.com/w/cpp/keyword/thread_local) oraz [Intel - Efficient Random Number Generation in C++](https://www.intel.com/content/www/us/en/developer/articles/technical/efficient-random-number-generation-in-c.html)

### 4. Optymalizacje algorytmiczne (Null-Collision)
W `state.h` dodano globalne parametry prekomputowane: `nu_star_e`, `P_star_e`. Służą one zoptymalizowanej metodzie **Null-Collision (zderzeń zerowych)**. Zamiast weryfikować prawdopodobieństwo zderzenia dla każdej cząstki osobno na podstawie skomplikowanych przekrojów czynnych, wylicza się maksymalną częstość zderzeń w systemie, następnie wybiera określoną liczbę próbnych cząstek ("kandydatów"), znacznie redukując ilość kosztownych rozgałęzień (branching) i operacji odczytów z tablic (lookup tables) w procesorze (algorytm pozbawiony wielu skoków - branchless design).
- **Źródło**: [Vahedi & Surendra - A Monte Carlo collision model for the particle-in-cell method (1995)](https://doi.org/10.1016/0010-4655(94)00171-W)

### 5. Identyfikacja wąskich gardeł (Bottlenecks)
- **Operacje Redukcji (Memory Bandwidth):** Pomimo bezkolizyjnego zapisu lokalnego wewnątrz wątków (struktura `WorkerBuffers`), stan lokalny musi zostać zredukowany pod koniec cyklu z `N` tablic do tablic globalnych. To redukowanie i sumowanie dużych danych siatkowych w pamięci RAM w 100% obciąża przepustowość magistrali (Memory Bandwidth limit), powodując spadek skalowania równoległego na maszynach o wielu rdzeniach a małej liczbie kanałów pamięci.
- **Kompaktowanie List Zderzeń (Stream Compaction):** Istnienie tablic `thread_local_indices` i `thread_counts` jest wyraźnym znakiem kompaktowania potoków (stream compaction). To bardzo popularny punkt serializacji i wąskie gardło z powodu ograniczonej efektywności cache'u podczas nieciągłych zapisów pamięci układu cząstek po zderzeniach lub opuszczeniu symulacji. Zazwyczaj przyspiesza to narzuty w dalszej pętli (odrzucenie pustych elementów cząstek), ale w środowisku CPU, przy ograniczonym wektoryzowaniu operacji scatter/gather, stanowi poważny wydatek zasobów.
