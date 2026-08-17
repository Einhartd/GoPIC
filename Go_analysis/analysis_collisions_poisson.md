# Analiza plików `collisions.go`, `cross_sections.go`, `poisson.go` w silniku GoPIC

Analiza opiera się na kodzie źródłowym implementacji PIC/MCC (Particle-In-Cell / Monte Carlo Collisions) równoleglonym za pomocą gorutyn w języku Go, w porównaniu z oryginalnym kodem sekwencyjnym C++ oraz wersją C/OMP.

## 1. `collisions.go` - Kolizje Monte Carlo (MCC)

Plik ten implementuje zderzenia elektronów i jonów z neutralnym gazem tła (argonem) za pomocą algorytmu Monte Carlo. W fizyce plazmy (np. wyładowaniach CCP) używa się metody *Null Collision*, która pozwala na stały krok czasowy mimo zmiennych przekrojów czynnych. Plik ten zawiera logikę dla zderzeń, gdy te już nastąpią.

### Architektura i zrównoleglenie w Go
- **Brak jawnych dyrektyw synchronizacyjnych (`sync.Mutex`)**: Funkcje `CollisionElectron` i `CollisionIon` są wywoływane wewnątrz pętli po cząstkach dla konkretnego chunku (kawałka danych).
- **Zarządzanie stanem i uniknięcie *Lock Contention***: Podczas zderzeń jonizujących (`E_ION`) powstają nowe cząstki (elektrony i jony). W oryginalnym C++ ze współdzieloną pamięcią (lub OpenMP z dyrektywami `#pragma omp critical`) dodawanie elementów do jednego wektora powoduje gigantyczne wąskie gardło z powodu blokad (mutex).
W Go rozwiązano to alokując oddzielne bufory per worker:
```go
sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{...})
```
Dzięki `workerID` każda gorutyna zapisuje do własnej slice, co eliminuje wyścigi (*race conditions*) i konieczność używania muteksów.

- **Niezależne generatory liczb losowych (RNG)**:
Użycie `sim.WorkerR01(workerID)` dowodzi, że każdy worker posiada swój instancjonowany generator. W Go domyślny `math/rand` współdzieli stan globalnie używając ukrytego muteksa, co w pętlach o dużej częstotliwości losowania niszczy skalowalność.

> [!TIP]
> **Thread-local PRNG (Pseudo-Random Number Generator)**  
> **CO**: Użycie oddzielnego stanu PRNG dla każdego workera.  
> **GDZIE**: `sim.WorkerR01(workerID)` w `collisions.go`  
> **JAK**: Każdy worker (gorutyna obsługująca chunk) ma swój własny obiekt RNG zainicjowany własnym ziarnem.  
> **DLACZEGO**: Unika się operacji zablokowania globalnego stanu (mutex) podczas generowania liczb. W kodzie z dużą liczbą losowań jest to absolutnie krytyczne.  
> **LINK**: [Go math/rand scalability issue](https://github.com/golang/go/issues/3611)

### Porównanie z C/OMP
W pliku C/OMP `null_collision.h` widnieje konstrukcja:
```cpp
static std::vector<int> pool;
```
Jest to rozwiązanie potencjalnie bardzo niebezpieczne bez `thread_local` lub `#pragma omp threadprivate`, mogące prowadzić do *data races* w środowisku wielowątkowym, bądź wymuszające wolną synchronizację. Wersja w Go unika globalnych/statycznych współdzielonych buforów na korzyść jawnych danych per worker (chunking). Z kolei `collisions.h` w C/OMP używa `NewParticles& new_e`, które musi być lokalne dla wątku OpenMP (np. tablice prywatne wewnątrz pętli).

---

## 2. `cross_sections.go` - Przekroje czynne

Moduł ten wylicza prawdopodobieństwa zderzeń (przekroje czynne) w zależności od energii elektronów/jonów w plazmie, bazując na pracach A. V. Phelpsa. Funkcje te operują na zjawiskach izotropowych, elastycznych, wzbudzeniach oraz jonizacji.

### Architektura i Optymalizacje Algorytmiczne
Plik ten to doskonały przykład **Look-Up Tables (LUT)** i **Pre-computacji**.
- **Tablicowanie**: Zamiast w każdym kroku czasowym dla milionów cząstek wyliczać skomplikowane funkcje matematyczne `math.Pow`, `math.Exp` czy ułamki, system na starcie przelicza je i zapisuje w gęstej tablicy `sim.Sigma` z odpowiednią rozdzielczością (`DE_CS`).
- Złożoność jest redukowana z drogich funkcji transcendentalnych na szybki odczyt wprost z pamięci podręcznej L1 procesora: `t0 = sim.Sigma[E_ELA][eindex]`.

> [!TIP]
> **Lookup Tables / Pre-computation**  
> **CO**: Wyliczenie wartości analitycznych przed główną pętlą symulacyjną (pre-computation) i zastąpienie ich tablicą wartości indeksowanych energią.  
> **GDZIE**: `SetElectronCrossSectionsAr`, tablice `sim.Sigma`.  
> **JAK**: Indeks tablicy (`eindex`) jest zmapowany do dyskretnych wartości energii kinetycznej. W zderzeniu po prostu używa się `sim.Sigma[typ][eindex]`.  
> **DLACZEGO**: Funkcje `math.Exp` i `math.Pow` pochłaniają dziesiątki do setek cykli procesora. Dostęp do pamięci podręcznej to rzędu kilku cykli.  
> **LINK**: [Lookup Tables in High-Performance Computing](https://en.wikipedia.org/wiki/Lookup_table)

### Pamięć i układ Danych
W Go alokacja `sim.Sigma` na poziomie struktury symulacji (`SimulationState`) jako ciągłych tablic wielowymiarowych sprzyja pobieraniu danych (*hardware prefetching*). Tablice zajmują niewiele pamięci, więc lądują w cache L1. Brak wskaźników zapobiega *pointer chasing*.

---

## 3. `poisson.go` - Równanie Poissona

Zadaniem modułu jest wyliczenie potencjału pola elektrycznego w oparciu o gęstość ładunków wyliczoną na siatce (grid).

### Architektura
W `poisson.go` zaimplementowano **Algorytm Thomasa** (TDMA).
```go
for i := 2; i <= N_G-2; i++ {
	w[i] = C / (B - A*w[i-1])
	g[i] = (f[i] - A*g[i-1]) / (B - A*w[i-1])
}
// (...)
for i := N_G - 3; i > 0; i-- {
	sim.Pot[i] = g[i] - w[i]*sim.Pot[i+1]
}
```

### Bottlenecki i Brak Równoległości
Zauważ, że w tym module *brak jest gorutyn*. Powodem tego jest silna, dwukierunkowa zależność danych (*data dependency*):
- Eliminacja w przód: `w[i]` zależy od `w[i-1]`.
- Podstawienie wsteczne: `sim.Pot[i]` zależy od `sim.Pot[i+1]`.

Taka struktura uniemożliwia proste rozbicie pętli na wątki (gorutyny).

> [!WARNING]
> W środowiskach wielu rdzeni CPU, **Prawo Amdahla** sprawi, że sekwencyjny czas wykonania `SolvePoisson` stanie się głównym limitem w skalowalności całego programu, nieważne jak szybko liczona jest mechanika cząstek.

> [!NOTE]
> Algorytm Thomasa to ekstremalnie szybka wariacja eliminacji Gaussa dla macierzy trójprzekątniowych. Zamiast złożoności $\mathcal{O}(N^3)$, ma $\mathcal{O}(N)$, więc przy niedużej jednowymiarowej siatce (N_G=500) sekwencyjność ta jest zazwyczaj opłacalnym kompromisem względem nakładów na równoległe solvery.
> **LINK**: [Tridiagonal matrix algorithm](https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm)

---

## Podsumowanie Skalowalności

1. **Zastosowanie wzorców Gorutyn/Chunking**: Kod Go przetwarza cząstki dzieląc je na chunki przypisane niezależnym gorutynom. Scalenie (Reduce) cząstek z buforów następuje po zsynchronizowaniu za pomocą np. `sync.WaitGroup`, co daje model typu *Fork-Join* o małym narzucie.
2. **Koszty GC w Go (Garbage Collector)**: Częste dopisywanie (`append`) elementów do plastrów wewnątrz funkcji `CollisionElectron` przy jonizacji może wywoływać re-alokacje pamięci i drastycznie zwiększyć nacisk na Garbage Collector (GC pressure), ograniczając wydajność. Optymalizacja wymaga prealokacji (`make` z dużą wartością `capacity`) lub wykorzystania `sync.Pool`.
3. **Zarządzanie stanem i uniknięcie *Lock Contention***: Odseparowanie instancji generatora RNG (każdy workerID ma swój pseudolosowy strumień) uwalnia pętle wewnętrzne z obciążeń związanych z synchronizacją muteksów występującą m.in. w domyślnych pakietach standardowych (jak współdzielony seed w `math/rand` oraz współdzielone tablice/wektory z C/OMP `null_collision.h`).
