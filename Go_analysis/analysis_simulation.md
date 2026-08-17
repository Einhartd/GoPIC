# Analiza implementacji równoległej GoPIC (Strategia Chunking)

Niniejszy dokument przedstawia wyczerpującą analizę implementacji zrównoleglonego, jednowymiarowego kodu Particle-in-Cell (PIC) z metodą Monte Carlo Collisions (MCC), napisanego w języku Go. Analiza skupia się na plikach z katalogu `parallel_chunking`: `simulation.go`, `simulation_null.go` oraz `simulation_standard.go`, a także odnosi się do oryginalnej, seryjnej wersji w C++ oraz zrównoleglonej wersji w OpenMP.

---

## 1. Architektura i Pętla Główna (DoOneCycle)

W pliku `simulation.go` funkcja `DoOneCycle` definiuje główną pętlę symulacji dla jednego pełnego cyklu RF (Radio Frequency), podzielonego na `N_T` kroków czasowych.

W C/OpenMP (z użyciem `#pragma omp parallel` dookoła całej pętli czasowej) tworzono tzw. *persistent thread pool*, a kolejne kroki były synchronizowane za pomocą `#pragma omp barrier`.
W podejściu Go (`parallel_chunking`), pętla główna działa **sekwencyjnie** w głównym wątku, ale na każdym kroku tworzona jest nowa grupa goroutin (współprogramów) poprzez `sync.WaitGroup`. 

### Mechanizm synchronizacji:
- Wersja Go **nie używa** kanałów (`channels`) do przekazywania cząstek ani blokad typu `sync.Mutex` w gorących ścieżkach. 
- Rozdzielanie pracy bazuje na podziale tablic globalnych (`sim.X_e`, `sim.Vx_e`, itd.) i powoływaniu `numWorkers` (ilość rdzeni wg `runtime.GOMAXPROCS(0)`) goroutin w pętli `for`.
- Główny wątek czeka na zakończenie fazy (np. liczenie gęstości) wywołując `wg.Wait()`. Gwarantuje to absolutną spójność danych przed przejściem do kolejnego kroku (co emuluje zachowanie niejawnej bariery na końcu `#pragma omp for`).

## 2. Strategia Chunking (Podział Pracy)

Podział cząstek między wątki odbywa się poprzez strategię blokową (chunking). Dla każdej operacji bazującej na liczbie cząstek ($N_e$ lub $N_i$):
```go
chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
start := w * chunkSize
end := (w + 1) * chunkSize
if end > sim.N_e { end = sim.N_e }
```
- **Równomierność (Load Balancing)**: Każdy worker dostaje paczkę równej wielkości (ew. ostatni worker dostaje mniejszą resztę).
- **Zabezpieczenie granic**: Instrukcja `if end > sim.N_e` zapobiega wyjściu poza zakres tablicy (Index Out Of Bounds), co w kodach na dużych, zmiennych tablicach (cząstki są usuwane i dodawane na bieżąco) jest krytyczne.
- **Bezpieczeństwo domknięć (Closures)**: Zmienne takie jak `w`, `start`, `end` przypisywane są do lokalnych zmiennych wewnątrz pętli: `workerID, s, e := w, start, end`, co pozwala uniknąć błędów związanych z modyfikacją zmiennej iteracyjnej w asynchronicznie odpalanych goroutinach.

## 3. Analiza Kroków Symulacji (Step-by-Step)

### Step 1: Compute Electron / Ion Density (Scatter-Add)
- **Co tu się dzieje:** Rozkład cząstek na siatkę (PIC Deposition). 
- **Zrównoleglenie:** Goroutiny pętlą po przypisanych im cząstkach i wykonują operację przypisania do siatki. Ponieważ wiele cząstek może trafić w ten sam węzeł siatki (data races), **nie można** pisać bezpośrednio do globalnej `sim.E_density`.
- **Redukcja (Thread-Local Storage):** Zamiast globalnego muteksu czy atomików (które zniszczyłyby wydajność), każda goroutina pisze do własnego wycinka 2D: `sim.WorkerEDensity[workerID][p]`. Po `wg.Wait()`, główny wątek sekwencyjnie spłaszcza tablicę 2D sumując po workerach. Tak samo realizowano to w C/OMP (`worker_buffers.e_density[tid][p]`).

### Step 2: Solve Poisson (1D Field Solver)
- **Sekwencyjny:** Zarówno w Go jak i w OMP ten krok jest sekwencyjny (algorytm Thomasa dla macierzy trójprzekątniowej). Skoro wymiar $N_G$ (liczba punktów siatki) jest mały, zrównoleglenie tego narzuciłoby komunikacyjny overhead przewyższający złożoność operacji ($O(N_G)$).

### Step 3 i 4: Move Electrons / Ions (Gather, Push & Accumulate Diagnostics)
- **Zrównoleglenie (Embarrassingly parallel):** Każda cząstka czyta globalne pole `sim.Efield` (Gather) i aktualizuje swoje parametry kinematyczne (Push).
- **Brak blokad:** Ponieważ w `Step2` policzono spójne `Efield`, faza odczytu nie wymaga synchronizacji (read-only). Zapis następuje w odrębnych fragmentach pamięci (podział przez chunking).
- **Diagnostyka:** Zbieranie danych (np. EEPF, statystyki `meanee`) następuje poprzez struktury diagnostyczne per-worker (`sim.WorkerEDiag[workerID]`), następnie redukowane sekwencyjnie po `wg.Wait()`.

### Step 5 i 6: Check Boundaries (Filtrowanie i Compaction)
- **Równoległe oznaczanie:** Zamiast usuwać zaabsorbowane na elektrodach cząstki w locie, co spowodowałoby modyfikację globalnej długości $N_e$ i rozsynchronizowanie (gigantyczny wyścig pamięci), pracownicy jedynie **oznaczają** je, wpisując flagę do tablicy `sim.AbsorbedE[k] = 1 | 2`.
- **Sekwencyjne scalanie (Compaction):** Następnie sekwencyjna pętla w `while(k < sim.N_e)` używa techniki szybkiej zamiany (Fast-Swap Deletion) z końcem wektora, po czym dekrementuje $N_e$.

### Step 7 i 8: Collisions (Zderzenia)
- Równoległe rozpatrywanie prawdopodobieństw i modyfikowanie pędów cząstek, wraz ze zwiększaniem ilości jonów/elektronów dla nowych (WorkerNewElectrons), z późniejszym sekwencyjnym scaleniem (Flush). Więcej w kolejnej sekcji.

### Step 9: Collect XT Data
- Operacja całkowicie sekwencyjna (główny wątek sumuje rozkłady), operuje wyłącznie na $N_G$ elementach, narzut rzędu nanosekund.

---

## 4. Null Collision (simulation_null.go) vs Standard (simulation_standard.go)

### Standardowy MCC (`simulation_standard.go`)
- **Algorytm:** Dla **KAŻDEJ** cząstki liczona jest energia, prędkość i prawdopodobieństwo zderzenia: $p_{coll} = 1 - \exp(-\nu \Delta t)$. Następnie sprawdzany jest warunek z liczbą pseudolosową.
- **Problem:** Koszt ewaluacji pierwiastków kwadratowych, mnożeń zmiennoprzecinkowych i niezwykle drogiej sprzętowo funkcji `exp()` dla np. $10^6$ cząstek na każdy krok czasowy, podczas gdy kolizje zachodzą rzadko (np. dla $\approx 0.1\%$ cząstek). Strata ogromnej ilości cykli procesora.

### Metoda Null Collision (`simulation_null.go`)
- **Algorytm:** Symulacja z góry wie, jaka jest **maksymalna możliwa** częstotliwość zderzeń: $\nu^* = \max(\nu(x,v))$. Globalna szansa wynosi $P^* = 1 - \exp(-\nu^* \Delta t)$.
- Używając aproksymacji rozkładu dwumianowego losowana jest całkowita liczba potencjalnych kandydatów (zderzeń i pseudo-zderzeń). Wybierany jest podzbiór cząstek za pomocą losowania bez zwracania (`randomSample`).
- Jedynie na **wylosowanych cząstkach** obliczany jest rzeczywisty przekrój i z prawdopodobieństwem $\nu/\nu^*$ odrzuca się tzw. zderzenie puste (Null Collision).
- Skutkuje to drastycznym (np. stokrotnym) zredukowaniem matematyki trygonometrycznej i wykładniczej, co bezpośrednio przekłada się na wielokrotny spadek czasu wykonania. Co ważne - sami wylosowani kandydaci i tak podlegają *chunkowaniu* między goroutiny.

---

## 5. Zależności danych między krokami

Cała natura cyklu PIC narzuca bariery synchronizacyjne:
- `Density` -> **MUSI BYĆ GOTOWE** do kroku `SolvePoisson`. Rozwiązanie równania Poissona jest wysoce zależne od dokładnej gęstości ładunku (macierz RHS).
- `Poisson (Efield)` -> **MUSI BYĆ GOTOWY** do kroku `Move`. Pola `Efield` wpływają na każdy wektor trajektorii.
- `Move` -> **MUSI BYĆ SKOŃCZONY**, by współrzędne zaktualizowanych cząstek były stabilne dla `CheckBoundaries`.
Z tego powodu podejście z pełnymi barierami barierami Fork-Join (`wg.Wait()`) po każdym etapie jest 100% poprawne i zapobiega jakimkolwiek data race'om.

---

## 6. Bottlenecki i Ograniczenia Skalowalności

1. **Narzut synchronizacji (Fork-Join Overhead):** Wymagane częste tworzenie goroutin (i alokacja obudów funkcji do WorkGroup). W OMP `parallel` jest aktywne przez cały czas, a kolejne kroki to jedynie lekkie bariery rzędu kilkuset cykli CPU. W Go, narzut scheduler'a będzie lekko widoczny przy bardzo wysokim `GOMAXPROCS`.
2. **Kroki Sekwencyjne (Amdahl's Law):** Kompaktowanie tablic (`Fast-Swap`), redukcje wektorów z wątków roboczych i główny Poisson Solver, choć szybkie, zajmują pewien procent czasu wykonania. Prawo Amdahla jest nieubłagane – to one blokują liniowe skalowanie algorytmu w miarę dodawania kolejnych rdzeni.
3. **Fałszywe współdzielenie (False Sharing):** Z racji braku jawnego dopełniania (`padding` w strukturach) dla per-worker tablic takich jak np. `diag.counter_i[p]`, wycinki przypisane bliskim sobie w pamięci wątkom mogą rezydować w tej samej linii Cache L1 (zazwyczaj 64 bajty). Modyfikacja swojej połówki przez wątek A, inwaliduje połówkę wątku B, prowadząc do zatorów pamięciowych (Cache Thrashing).

---

## 7. Szczegółowe opisy wdrożonych optymalizacji

### 1. Loop Strip Mining / Chunking
* **CO to jest:** Podział wektorów danych z pamięci głównej w spójne fragmenty (chunks).
* **GDZIE:** W większości funkcji kroków (`start := w * chunkSize; end := ...`).
* **JAK:** Pojedyncza goroutina działa na indeksach wektora leżących fizycznie obok siebie w układzie pamięci DRAM.
* **DLACZEGO:** Optymalizuje tzw. Spatial Locality. Prefechtery sprzętowe procesora wiedzą, by zgarniać kolejne klastry danych, redukując opóźnienia i zapobiegając wzajemnemu nadpisywaniu stanów pomiędzy workerami.
* **LINK:** [Intel - Loop Strip Mining](https://software.intel.com/content/www/us/en/develop/articles/loop-strip-mining.html) (lub zasada klauzuli OMP `schedule(static)`).

### 2. Thread-Local Storage (Pamięć Per-Worker dla Redukcji)
* **CO to jest:** Lokalne bufory dla każdego workera używane w zastępstwie centralnej tablicy, do unikania zjawisk ryglowania.
* **GDZIE:** Zapis gęstości w `WorkerEDensity[workerID][p]` (`Step1`).
* **JAK:** Redukcja końcowa dokonywana jest asymetrycznie – po zamknięciu fazy generowania, wątek nadzorujący scala je w `E_density`.
* **DLACZEGO:** Zapis do jednego węzła z wielu goroutin stanowi klasyczny *Data Race*. Użycie sprzętowych instrukcji CAS (Compare-and-Swap / atomics) dławiłoby potok ze względu na ciągłe wyłączenia cache na szynie. Pamięć na własny bufor to koszt ułamków KB, a wydajność rośnie niewyobrażalnie.
* **LINK:** [Wikipedia - Thread-local storage](https://en.wikipedia.org/wiki/Thread-local_storage).

### 3. Null-Collision Method
* **CO to jest:** Inteligentny schemat oparty o metodę akceptacji/odrzucenia z symulacji Monte Carlo.
* **GDZIE:** `simulation_null.go`, implementacje kolizji dla elektronów i jonów.
* **JAK:** Określa prawdopodobieństwo maksymalne dla całej dziedziny. Losuje liczbę ofiar przy użyciu modelu statystycznego. Ewaluacja funkcji trygonometrycznych występuje wyłącznie dla cząstek, dla których zjawisko kolizji i tak zaszło jako zdarzenie faworyzowane.
* **DLACZEGO:** Pomija absurdalne ilości niekorzystnych probabilistycznie przeliczeń z algorytmu klasycznego. Znacząco potęguje szybkość kodu plazmowego PIC z elementami zderzeń z gazem tła.
* **LINK:** [Vahedi & Surendra (1995) - A Monte Carlo collision model for the particle-in-cell method](https://doi.org/10.1016/0010-4655(94)00171-W).

### 4. Normal Approximation of Binomial Distribution (Aproksymacja De Moivre'a-Laplace'a)
* **CO to jest:** Przybliżenie uciążliwego próbkowania losowego przy użyciu dystrybucji znormalizowanej Gaussa.
* **GDZIE:** Funkcja `sampleBinomial` w `simulation_null.go`.
* **JAK:** Skoro cząstek jest dużo (wielkie populacje $N$), można zastąpić $N$ wywołań instrukcji Bernoulliego (`if rnd < p`) - jednym generowaniem normalnym wokół centrum zmienności: $\mu = n \cdot p$, a odchylenie $\sigma = \sqrt{n \cdot p \cdot (1-p)}$. Zwraca od razu ilość "trafionych" przypadków!
* **DLACZEGO:** Optymalizacja pętli losowania złożoności rzędu $O(N)$ do zaledwie pojedynczej funkcji matematycznej i funkcji losowej rzędu $O(1)$. Błędy graniczne w dużych symulacjach plazmy są pomijalne fizycznie.
* **LINK:** [Wikipedia - De Moivre-Laplace theorem](https://en.wikipedia.org/wiki/De_Moivre%E2%80%93Laplace_theorem).

### 5. Fast-Swap Vector Deletion (Szybka Kasacja)
* **CO to jest:** Metoda omijania tzw. przesunięć blokowych podczas redukcji rozrzuconych, zaabsorbowanych elementów ze strumieni symulacji.
* **GDZIE:** Koniec `Step5CheckBoundariesElectrons`, `while (k < sim.N_e)`.
* **JAK:** Gdy napotyka martwą cząstkę (flagowaną jako 1 lub 2), bierze żywą cząstkę z indeksu krańcowego `N_e - 1`, przekleja na jej miejsce i zmniejsza globalną liczbę cząstek, unikając wywoływania procedur rzędu "memmove()".
* **DLACZEGO:** Zmienia asymptotykę usuwania cząstek z $O(N^2)$ (dla usuwania z początku w pętli liniowej) na potężnie zrównoleglenie asynchroniczne i usunięcie z pamięci w rygorystycznym czasie $O(1)$ na cząstkę.
* **LINK:** [Game Programming Patterns - Data Locality / Quick Deletion](https://gameprogrammingpatterns.com/data-locality.html).
