# Analiza Optymalizacji i Równoległości OpenMP w eduPIC

Niniejszy raport zawiera dogłębną analizę implementacji zrównoleglenia w plikach [`simulation.h`](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/simulation.h) oraz [`eduPIC.cc`](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/eduPIC.cc), porównując ją z oryginalną, sekwencyjną wersją z [`eduPIC/C/eduPIC.cc`](file:///home/oliwier/Dev/GoPIC/eduPIC/C/eduPIC.cc).

## 1. Architektura Kodu i Podział Pracy

*   **`eduPIC.cc`**: Ten plik pełni rolę sterującą. Obsługuje inicjalizację, ładowanie i zapis stanu do plików `.bin`, weryfikację warunku stabilności Couranta-Friedrichsa-Levy'ego (CFL) oraz komunikaty z danymi profilującymi. Ze względu na wrodzoną sekwencyjność I/O i niską złożoność obliczeniową funkcja `main` pozostawiona jest w głównym wątku.
*   **`simulation.h`**: Serce algorytmiczne (1D3V PIC/MCC). Definiuje kluczową procedurę `do_one_cycle`, operującą wewnętrznie na 9 krokach symulacyjnych dla każdej z `N_T` iteracji pętli czasu. Plik ten obciążony jest głównymi narzutami CPU, dlatego zoptymalizowano go na wskroś metodami równoległości współdzielonej OpenMP.

## 2. Główna pętla symulacji i wzorzec "Persistent Parallel Region"

W tradycyjnym, naiwnym podejściu do zrównoleglania (oraz w kodzie sekwencyjnym) dla powtarzających się algorytmów używano by pragmy `#pragma omp parallel for` w każdym małym kroku (od 1 do 8) oddzielnie w każdej z iteracji `t < N_T`. 

W zoptymalizowanej metodzie dyrektywę `#pragma omp parallel` otwiera się zaledwie *raz, poza* całą pętlą główną symulacji czasu.
```cpp
#pragma omp parallel
{
    int tid = omp_get_thread_num();
    int nthreads = omp_get_num_threads();
    for (int t = 0; t < N_T; t++) { 
        // wewnętrzne wywołania kroków step1_... do step9_... 
    }
}
```
**Optymalizacja algorytmiczna:** Technika tzw. *Persistent Parallel Region*. Wątki są rezerwowane (spawning) tylko raz, przed tysiącami iteracji czasowych `t`. Całkowicie likwiduje to skumulowany narzut *Fork-Join Overhead*, który byłby fatalny w małych kwantach czasu.
*Źródło:* [OpenMP Overhead and Persistent Threads - LLNL HPC Best Practices](https://hpc-tutorials.llnl.gov/openmp/performance/#omp_overhead)

---

## 3. Szczegółowa Analiza Kroków Symulacji (`simulation.h`)

### Zależności danych kroków symulacji (1 - 9)
Szkielet PIC wymusza silną zależność liniową: Cząstki formują rozkład ładunku (Krok 1) -> W oparciu o siatkę ładunku weryfikowane jest Równanie Poissona na węzłach (Krok 2) -> Nowe węzły siatki odświeżają pole elektryczne, co pozwala przesunąć cząstki (Krok 3 i 4) -> Następuje sprawdzenie fizycznych usunięć z domeny brzegowej (Krok 5 i 6) oraz obliczenia zderzeń i kreacji (Krok 7 i 8). Wymusza to bardzo świadome używanie synchronizacji barierowej miedzy tymi procedurami.

### Krok 1: Depozycja ładunku (Scatter-Add) i Bufory Lokalnie
Oryginalny kod: pętla iterująca po cząstkach sumująca udziały przestrzenne bez zabezpieczeń – czysty wyścig pamięci (*Data Race*).
Wersja równoległa:
*   Zamiast kosztownych blokad atomowych `#pragma omp atomic` (zabójczych dla wydajności przy powtarzającym się obciążeniu komórek siatki), wprowadzono **lokalne bufory wątków** (Thread-Local Arrays - `worker_buffers.e_density[tid]`). Każdy wątek depozytuje cząstki w przydzielonym, bezpiecznym sektorze bez wyścigów. 
*   `#pragma omp for nowait` przed pętlą cząstek – redukuje niejawną podwójną barierę dla pętli bez współzależności wektorowych.
*   Po jawnej synchronizacji (`#pragma omp barrier`) dokonuje się iteracja `#pragma omp for schedule(static)` by wszystkie wątki wykonały redukcję (zsumowanie) lokalnych wyników `N_G` węzłów do globalnej tablicy `e_density`. Podział obciążenia wymuszono jako *static*, co jest idealne dla siatki stałej wielkości o tym samym profilu operacji w każdym punkcie.
*   *Źródło:* [Intel - OpenMP Reductions & Thread-Local Storage](https://www.intel.com/content/www/us/en/developer/articles/technical/openmp-reductions.html)

### Krok 2: Poisson Solver
*   Rozwiązanie różniczkowego pola wykorzystuje w oryginalnym pliku sekwencyjny algorytm Thomasa. Ze względu na ścisłe uzależnienia rekurencyjne zmiennych w trójdiagonalnej macierzy algorytm ten jest zamknięty w klauzuli `#pragma omp single`.
*   Jest to kluczowy *Bottleneck (wąskie gardło) zgodny z prawem Amdahla*, jednak dla tak nielicznej siatki (na poziomie 1D i N_G rzędu dziesiątek-setek) rozdzielenie go nie przewyższyłoby narzutu na komunikację.
*   *Źródło:* [Amdahl's Law and Serial Bottlenecks - Wikipedia](https://en.wikipedia.org/wiki/Amdahl%27s_law)

### Kroki 3 i 4: Przesuwanie Cząstek (Particle Push)
*   Problem wysoce zrównoleglalny ("Embarrassingly Parallel"). Dzielony dyrektywą `#pragma omp for nowait`.
*   **Optymalizacja dostępu Pamięci**: Tablice symulacji korzystają z globalnego schematu bazującego na strukturze **SoA (Structure of Arrays)** – tablice `x_e`, `vx_e` są fizycznie odizolowane, w przeciwieństwie do tworzenia gigantycznych matryc struktur cząstek w oryginalnym, akademickim podejściu (Array of Structures - AoS). Taki wzorzec maksymalizuje Cache-Hit rate (L1/L2 Cache), pozwala na bezproblemowy sprzętowy *Hardware Prefetching* pamięci sekwencyjnej (bez skoków) w operacji pushu.
*   *Źródło:* [Memory Layout Transformations (SoA vs AoS) - Intel](https://www.intel.com/content/www/us/en/developer/articles/technical/memory-layout-transformations.html)

### Kroki 5 i 6: Kompresja graniczna cząstek (Boundary Checks)
Pochłanianie elektronu uderzającego o brzeg wymaga modyfikacji ogólnego licznika `N_e` i defragmentacji tablic za pomocą metody *Swap and Pop* (nadpisania usuniętej luki z tablicy cząstką z krańca `N_e-1`). Wersja sekwencyjna robi to na bieżąco, tu wprowadzono hybrydę:
*   Faza flagowania usunięć przebiega idealnie równolegle (`#pragma omp for`). Przypisanie maski (`absorbed[k] = 1`) dla każdej z cząstek zabezpiecza przed konfliktami zapisu.
*   Po wykonaniu i zsynchronizowaniu `#pragma omp barrier`, jedna instrukcja logiczna wewnątrz bloku `#pragma omp single` weryfikuje maskę liniowo w locie (`while(k < N_e) { if(absorbed[k]) {...} }`), skracając całą globalną tablicę. Chociaż to spowalnia kod, rozwiązuje to ogromny kryzys *False Sharing* w L1 Cache i zabezpiecza *Data Locality* przed rozszczepieniem na fragmenty u wszystkich wątków.
*   *Źródło:* [Data Locality / Swap and Pop Object Pools - Game Programming Patterns](https://gameprogrammingpatterns.com/data-locality.html)

### Kroki 7 i 8: Prawdopodobieństwa Kolizji
*   **Algorytmiczna metoda Null-Collision**: W wersji sekwencyjnej istniała stała walidacja prawodpodobieństwa `p_coll = 1 - exp(- nu * DT_E)` z gałęzią `if(R01(MTgen) < p_coll)` dla **KAŻDEJ** cząstki w zderzeniu, niszcząca gałęzie (Branch Predictors flush). Optymalizacja pod OpenMP korzysta ze zmodyfikowanej statystyki Null Collision (maksymalna zastępcza siatka kolizji), losując (`#pragma omp single`) tylko docelową pulę `N_coll_star` i rozdzielając na ułamek kandydatów `#pragma omp for`. To de facto optymalizacja typu Branchless redukująca złożoność pętli.
*   *Źródło:* [Vahedi & Surendra (1995) A Monte Carlo collision model - Elsevier](https://doi.org/10.1016/0010-4655(94)00171-W)
*   **Łagodzenie rywalizacji zasobów (Lock Contention)**: W przypadku konieczności wykonania kolizji w nowym wariancie, inkrementowany jest globalny licznik z użyciem `#pragma omp atomic` (`N_e_coll++`). Jako że atomowe odpytania powodują silną serializację pamięci, ich lokalizacja w rzadko wywoływanych węzłach brzegowych struktury po przefiltrowaniu Null Collision owocuje niemal zerową degradacją (Low Contention Rate). Utworzone cząstki znów ładowane są do Thread-Local buforów by następnie je dodać spójnie iteracją liniową po zakończeniu sekcji.
*   *Źródło:* [OpenMP Avoiding Lock Contention - Intel](https://www.intel.com/content/www/us/en/developer/articles/technical/performance-insights-to-openmp-applications.html)

---

## 4. Bottlenecki Skalowalności

Patrząc pod kątem zrównoleglenia w Prawie Amdahla i prawach narzutu, głównymi barierami przed nieskończonym przyspieszeniem silnika `eduPIC` w tej nowej strukturze stanowią wyłącznie:
1. **Solver Poissona (Krok 2)** – Ograniczona sekwencyjna metoda Thomasa, całkowicie seryjna w bloku `#pragma omp single`.
2. **Deflacje tablic brzegowych (Krok 5-6)** – Defragmentacje usuniętych i zaabsorbowanych jonów ze zderzeń sekwencyjnymi pętlami `while (k < N_e)`.
3. **Cykl Barierowy** – Znaczne użycie `#pragma omp barrier` między redukcjami wymusza, by najszybsze procesy (które przetworzyły lżejsze ilości lokalnych kolizji) oczekiwały regularnie mikrosekundy dla równego rozbioru kroku 9 i aktualizacji Czasu Globalnego.
