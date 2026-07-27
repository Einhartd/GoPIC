# Plan i Mapa Drogowa Zrównoleglenia w Języku Go (GoPIC - Worker Pool)

Niniejszy dokument przedstawia szczegółową mapę drogową (*roadmap*) zrównoleglenia symulacji **GoPIC** w języku Go przy użyciu wariantu **Opcja 1: Chunking & Worker Pool** (pamięć współdzielona ze stałą pulą gorutyn).

---

## 1. Wyzwanie Wątkowego Bezpieczeństwa Generatora RNG

W sekwencyjnej wersji symulacji używana jest pojedyncza instancja generatora `sim.Rng` (`*rand.Rand` z podkładem MT19937).

### Problem:
- Instancja `math/rand.Rand` w Go **NIE JEST bezpieczna wątkowo** dla równoległych wywołań.
- Wywoływanie `sim.R01()` lub `sim.RMB()` z wielu gorutyn jednocześnie (w pętlach zderzeń oraz losowaniach energetycznych) powoduje wyścig o dane (*data race*) na wewnętrznych rejestrach MT19937, niszcząc stan generatora i determinizm symulacji.

### Rozwiązanie:
- Tworzymy dedykowany bufor instancji generatorów dla każdego workera w `SimulationState`:
  `WorkerRNGs []*rand.Rand`
- Każdy worker $w \in [0, \text{numWorkers})$ otrzymuje swój unikalny seed (`baseSeed + int64(w)`).
- Gorutyny w pętlach zderzeń i przemieszczeń używają wyłącznie przypisanego generatora `WorkerRNGs[workerID]`.

---

## 2. Mapa Drogowa Zrównoleglenia dla 9 Kroków PIC/MCC

### 🟢 Krok 3: Ruch Elektronów (`Step3MoveElectrons`) — [ZAIMPLEMENTOWANO & ZWERYFIKOWANO]
- **Mechanizm**: Podział tablicy $N_e$ elektronów na $W = \text{GOMAXPROCS}$ równych paczek (*chunks*) przydzielanych do gorutyn za pomocą `sync.WaitGroup`.
- **Diagnostyka**: Idiomatyczne zliczanie diagnostyk w strukturze `electronWorkerDiagnostics` przypisanej do workera. Brak operacji atomowych wewnątrz pętli cząstek. Po `wg.Wait()` następuje sekwencyjna redukcja danych diagnostycznych do tablicy głównej `sim`.
- **Status**: 100% zbieżności numerycznej i bitowej (potwierdzone testami jednostkowymi i regresyjnymi).

---

### 🟡 Krok 1: Depozycja Gęstości (`Step1ComputeElectronDensity` oraz `Step1ComputeIonDensity`)
- **Problem**: Wyścig o dane przy jednoczesnym zapisie ładunku z różnych cząstek do tych samych węzłów siatki `sim.E_density[p]`.
- **Rozwiązanie**: Redukcja tablicowa (*Array Reduction*).
  - Każdy worker $w$ akumuluje depozycję w lokalnej tablicy gęstości `localDensity[N_G]`.
  - Po zakończeniu gorutyn (`wg.Wait()`), wątek główny sumuje lokalne tablice gęstości do `sim.E_density` i nakłada poprawkę brzegową $\times 2$ dla `[0]` i `[N_G-1]`.

---

### 🟡 Krok 4: Ruch Jonów (`Step4MoveIons`)
- **Mechanizm**: Analogiczny do Kroku 3 – podział wycinków cząstek jonów między $W$ workerów z uwzględnieniem subcyclingu (`t % N_SUB == 0`).
- **Diagnostyka**: Redukcja per-worker dla tablic diagnostycznych jonów XT (`Counter_i_xt`, `Ui_xt`, `Meanei_xt`).

---

### 🔴 Kroki 5 & 6: Absorpcja na Granicach (`Step5CheckBoundariesElectrons` i `Step6CheckBoundariesIons`)
- **Problem**: Sekwencyjny algorytm podmienia cząstkę usuwaną z ostatnią w tablicy (`sim.X_e[k] = sim.X_e[N_e-1]; sim.N_e--`). Wykonanie tego współbieżnie z wielu gorutyn niszczy spójność tablicy cząstek.
- **Rozwiązanie**: Algorytm **Stream Compaction**.
  1. *Faza Znakowania*: Każdy worker wybiera ocalałe cząstki ze swojej paczki do lokalnego buforu.
  2. *Suma Prefiksowa*: Wątek główny wylicza przesunięcia startowe dla każdego workera.
  3. *Relokacja*: Gorutyny równolegle zapisują ocalałe cząstki na właściwe pozycje docelowe.
  4. Dla jonów: energia kinetyczna uderzających jonów jest bezpiecznie akumulowana w histogramach IFED (`Ifed_pow`, `Ifed_gnd`).

---

### 🔴 Kroki 7 & 8: Zderzenia Monte Carlo (`Step7CollisionsElectrons` i `Step8CollisionIons`)
- **Problem**:
  1. Użycie generatorów liczb losowych dla losowań kaskadowych (elastyczne, wzbudzenie, jonizacja).
  2. W procesie jonizacji powstają nowe pary elektron-jon, modyfikujące liczniki `N_e` i `N_i`.
- **Rozwiązanie**:
  1. Użycie niezależnego generatora `WorkerRNGs[workerID]` dla każdego workera.
  2. Nowo powstałe cząstki z jonizacji są buforowane w lokalnych wycinkach gorutyny (`newElectrons`, `newIons`).
  3. Po zakończeniu pętli kolizyjnej, nowe cząstki są sekwencyjnie dopisywane do globalnych tablic `X_e`, `X_i`, zapobiegając wyścigom o dane na `N_e` i `N_i`.

---

### ⚪ Kroki Sekwencyjne (Bez zmian):
- **Krok 2: Solver Poissona (`Step2SolvePoisson`)**: Algorytm Thomasa dla $N_G = 400$ punktów siatki wywołuje się sekwencyjnie w wątku głównym (stanowi $<0.1\%$ czasu CPU).
- **Krok 9: Zbiorcza Diagnostyka XT (`Step9CollectXtData`)**: Pętla po $N_G = 400$ węzłach wykonywana jest sekwencyjnie po scaleniu wyników.
