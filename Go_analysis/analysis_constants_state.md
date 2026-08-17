# Analiza plików constants.go i state.go (GoPIC - Parallel Chunking)

## 1. Wstęp
Niniejszy dokument przedstawia szczegółową analizę implementacji stanu symulacji i stałych w projekcie GoPIC dla wariantu `parallel_chunking`. Porównano go ze źródłowym kodem C++ (eduPIC), jednowątkową implementacją w Go oraz zrównolegloną wersją C/OpenMP.

## 2. Organizacja stałych i stanu symulacji w Go
- W pliku `constants.go` stałe fizyczne i parametry symulacji są zdefiniowane jako stałe w czasie kompilacji (słowo kluczowe `const`). Typy takie jak `CrossSection`, `ParticleVector`, `Xvector`, `EepfVector` i `XtDistr` to nazwane typy tablicowe o stałym rozmiarze (np. `[N_G]float64`).
- W pliku `state.go` zdefiniowano strukturę `SimulationState`, która stanowi kontener na cały stan symulacji. W przeciwieństwie do oryginalnego C++ i C/OMP, w których stan trzymany jest w zmiennych globalnych, Go kapsułkuje go w jednej instancji. Zapewnia to lepszą testowalność i unika problemów z ukrytym stanem globalnym.

## 3. Strategia chunkingu
Praca (obliczanie ruchu cząstek, zderzeń, akumulacja gęstości) jest dzielona między pulę workerów (goroutines). Zamiast przetwarzać cząstki pojedynczo z użyciem kanałów, cząstki (elektrony i jony) dzielone są na **chunki** (pakiety). 
Każda goroutina (worker) iteruje po swoim przypisanym podzbiorze głównych tablic `X_e, Vx_e...` i zapisuje lokalne wyniki (np. gęstość) do swoich własnych, wyizolowanych buforów (`WorkerEDensity`, `WorkerIDensity`, `WorkerEDiag`). Po zakończeniu fazy obliczeniowej przez workery, wątek główny scala te lokalne bufory. Zmniejsza to do zera potrzebę używania muteksów (locków) w trakcie intensywnych obliczeń.

## 4. Pre-alokacja buforów workerów
Aby zminimalizować presję na Garbage Collector, `state.go` pre-alokuje wszystkie potrzebne bufory i wskaźniki przy tworzeniu stanu w funkcji `NewSimulationState()`. 
Przykłady to:
- `WorkerEDensity []Xvector`, `WorkerIDensity []Xvector` - alokowane per-worker.
- `WorkerNewElectrons [][]CreatedParticle` - bufory dla nowych cząstek powstających z jonizacji.
- `CandidatePool []int` - gigantyczny pool indeksów przygotowany do metody Monte Carlo Null-Collision, unikający tworzenia nowych wycinków (slices) w locie.

## 5. Cache-friendly layout (SoA vs AoS)
W kodzie zastosowano wyrafinowane podejście hybrydowe do organizacji pamięci:
- **SoA (Structure of Arrays)**: Główne bufory symulacji to oddzielne tablice (np. `X_e, Vx_e, Vy_e, Vz_e` typu `ParticleVector`). Zwiększa to wydajność obliczeń, ponieważ iteracje aktualizujące jedną składową mogą korzystać z wektoryzacji i przewidywania skoków sprzętowego prefetchera (dane w jednym wierszu pamięci podręcznej są jednorodne).
- **AoS (Array of Structures)**: Nowo tworzone cząstki (np. z jonizacji) są formowane przy użyciu struktury `CreatedParticle { X, Vx, Vy, Vz float64 }` w `WorkerNewElectrons`. W komentarzach kodu podano uzasadnienie: jedna cząstka ma dokładnie 32 bajty (4 x 8 bajtów), co mieści się idealnie w jednej linii L1 cache (64 bajty). Zmniejsza to liczbę operacji wstawiania i obniża narzut na alokację.

## 6. Specyfika Go: escape analysis, GC pressure, slice headers
- **GC pressure**: Pre-alokacja wewnątrz struktury (zamiast wewnątrz lokalnej pętli) pozwala uniknąć ciągłej alokacji na stercie (heap) i wyzwalania Garbage Collectora. 
- **Escape Analysis**: Umieszczenie `SimulationState` za wskaźnikiem powoduje jego ucieczkę na stertę. Dzięki temu referencje mogą być bezpiecznie przekazywane do workerów. Obiekty alokowane lokalnie w workerach (jeśli są krótkoterminowe i nie "uciekają" z zasięgu) mogłyby alokować się na stosie (stack), co jest darmowe, jednak preferuje się stałe slice'y `[][]` by całkowicie zniwelować dynamiczną alokację.
- **Slice headers**: Przechowując pule obiektów AoS zamiast wielu plasterków SoA dla nowo tworzonych elementów, system redukuje narzut (1 slice header = 24 bajty) w zamian zachowując lepszą czytelność, jak wspomniano w komentarzu w `state.go`.

## 7. RNG per-goroutine (Thread-safety)
Generatory liczb pseudolosowych w Go (`math/rand`) korzystają z globalnego źródła, które domyślnie posiada globalnego locka (muteksa), by unikać data race. Zastosowanie locka w symulacji PIC przy każdym wywołaniu zablokowałoby całe zrównoleglenie. 
- W `state.go` przygotowano tablicę `RngWorkers []*rand.Rand`.
- W czasie `NewSimulationState()`, generowana jest odpowiednia instancja generatora oparta na szybkim silniku Mersenne Twister `mt19937` *oddzielnie dla każdej goroutiny* (zasiewana unikalnym seedem). 
- Dzięki temu worker wywołuje własny `sim.WorkerR01(workerID)` kompletnie asynchronicznie bez lockowania.

## 8. Porównanie z C/OMP
- W C/OMP (plik `state.h`) używa się modyfikatorów `alignas(64)` i wypełniania, by oddzielić struktury, co zapobiega zjawisku **False Sharing**, gdy kilka rdzeni pisze do różnych zmiennych znajdujących się w tej samej linii cache. W Go brakuje wbudowanego `alignas`, więc rozdzielanie stanów w tablice obiektów o rozmiarze zależnym od struktury diagnozy (np. `electronWorkerDiagnostics`) samo w sobie jest strategią. Trzeba zwracać uwagę by sąsiadujące workery nie współdzieliły linii cache, choć struktura potrafi urosnąć.
- **Wątki lokalne**: W C/OMP stan jest deklarowany jako `thread_local`. W Go nie ma bezpośredniego odpowiednika Thread Local Storage (TLS). Zamiast tego przekazuje się jawnie indeks (np. `workerID`) lub obiekt stanu do funkcji danej goroutiny, które następnie operuje na `SimulationState.WorkerEDiag[workerID]`.

## 9. Porównanie z seryjnym Go
- Jednowątkowy kod Go (`Go/native_version/state.go`) posiada tylko jedną instancję buforów na całą symulację. 
- Nie ma potrzeby scalania z pod-stanów, RNG jest pojedynczą niestrzeżoną muteksem instancją dla całego cyklu wykonania, brak tu buforów `WorkerIDensity`, nie ma prealokowanego `CandidatePool`. Tablice dla nowo formowanych elektronów i jonów w wersji serialnej prawdopodobnie ewoluują dynamicznie na końcu każdego cyklu bez separacji dla uniknięcia warunków wyścigu (race conditions). Wersja równoległa dziedziczy podstawową matematykę z wariantu serialnego, ale mocno zmienia jej rusztowanie.

## 10. Wąskie gardła
- Faza redukcji (scalania) stanów z workerów do buforów globalnych następuje w głównym wątku i musi odbyć się synchronicznie przed kolejnym cyklem. Zależnie od ilości cząstek i workerów ogranicza ona maksymalne przyspieszenie zgodnie z Prawem Amdahla.
- Pamięć (Memory Bandwidth) pozostaje głównym wąskim gardłem. Iterowanie milionów cząstek powoduje ciągłe wymiatanie (eviction) danych z podręcznej pamięci procesora.
- W przeciwieństwie do rozwiązań np. kanałowych, memory footprint jest większy na skutek duplikacji buforów (np. `WorkerEDensity` to `N_G` elementów mnożone przez ilość rdzeni logicznych), jednak dla relatywnie małych buforów gridów jest to całkowicie pomijalne.

## 11. Zidentyfikowane Optymalizacje (Mechanika działania)

### A. Pre-alokacja i re-używanie (Slice reuse)
- **Czym to jest:** Przydzielanie całej pojemności pamięci z wyprzedzeniem (`make`) zamiast powiększania dynamicznie kolekcji w pętlach (`append`).
- **Gdzie w kodzie:** `state.go` -> `NewSimulationState` (np. `CandidatePool: make([]int, MAX_N_P)`).
- **Jak działa:** Alokacja z góry oznacza, że tablica wycinka (slice) nie ulega przeniesieniom podczas intensywnych symulacji.
- **Dlaczego to pomaga:** Omija presję na menedżera pamięci i Garbage Collector, eliminując przerwy na sprzątanie sterty (GC pauses).
- **Źródło:** [Memory Management in Go](https://dave.cheney.net/high-performance-go-workshop/dot-paris-2015.html#memory_management)

### B. Struktura Tablic (SoA) vs Tablica Struktur (AoS)
- **Czym to jest:** Strategia reprezentacji obiektów w pamięci. SoA dzieli parametry do płaskich tablic. AoS grupuje je w struktury.
- **Gdzie w kodzie:** SoA dla `ParticleVector`, a AoS dla `CreatedParticle` w `WorkerNewElectrons`.
- **Jak działa:** Dla SoA wektory położeń ładują do cache kolejne pozycje pod rząd, co ułatwia wektoryzację. AoS grupuje `(X, Vx, Vy, Vz)` do małego, 32-bajtowego bloku na jedną partycję podczas dodawania nowej cząstki.
- **Dlaczego to pomaga:** Zwiększa współczynnik trafień Cache (Cache Hit Ratio).
- **Źródło:** [AoS and SoA - Wikipedia](https://en.wikipedia.org/wiki/AOS_and_SOA)

### C. Niezależne, wyizolowane Generatory Liczb Pseudolosowych (PRNG)
- **Czym to jest:** Inicjalizowanie niezależnych instancji `rand.Rand` dla każdego wątku przetwarzającego.
- **Gdzie w kodzie:** `SimulationState.RngWorkers`.
- **Jak działa:** Brak globalnego mutexu omija operację Lock/Unlock podczas sięgania po losowe liczby.
- **Dlaczego to pomaga:** W bardzo wąskich pętlach numerycznych (metoda Monte Carlo) zatrzaski Mutexu spowodowałyby katastrofalne zgłodnienie współbieżne (Contention).
- **Źródło:** [Math/Rand Go Documentation](https://pkg.go.dev/math/rand)

### D. Rozdzielenie Stanu Zapisów Wątków (Zapobieganie False Sharing)
- **Czym to jest:** Posiadanie oddzielnych i nie nakładających się logicznie przestrzeni do zapisu specjalnie na wątek logiki (Worker).
- **Gdzie w kodzie:** `WorkerEDensity` lub `WorkerEDiag`. Wątek 1 edytuje `WorkerEDensity[1]`, a 2 wpisuje do `WorkerEDensity[2]`.
- **Jak działa:** Gdyby wątek 1 i 2 modyfikowały tą samą sieć gęstości, cache procesorowy musiałby co chwila unieważniać lokalną kopię Cache (Cache Bouncing).
- **Dlaczego to pomaga:** Minimalizuje Cache Miss i gwarantuje prawie liniowe skalowanie przy wstawianiu danych na wielu rdzeniach.
- **Źródło:** [False Sharing - Wikipedia](https://en.wikipedia.org/wiki/False_sharing)
