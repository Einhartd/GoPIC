# Plan Wdrożenia Optymalizacji C++ OpenMP do Silnika GoPIC (Go)

Dokument stanowi kompletny, techniczny plan wdrożenia technik optymalizacyjnych z silnika referencyjnego **C++ OpenMP** (`C/parallel-only-omp`, rekordowy czas **$13.89\text{ s}$** na 32 rdzeniach AMD EPYC Zen 4) do implementacji w języku **Go** (`Go/parallel_chunking`, a następnie przeniesienie do `Go/parallel_channels`).

Plan bazuje bezpośrednio na przewodniku [`docs/c_omp_optimizations_guide_for_go.md`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/c_omp_optimizations_guide_for_go.md) oraz analizie kodu asemblera z [`docs/assembly_analysis/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/).

---

## 📊 Tabela Przeglądowa Optymalizacji

| Nr | Nazwa Optymalizacji | Docelowy Plik w Go | Główne Działanie | Szacowany Zysk |
|:--:|:---|:---|:---|:---:|
| **1** | **Fast-Path Wymiany Ładunku (`I_BACK`)** | `collisions.go` | Jon przejmuje prędkość atomu tła bez geometrii rozproszenia | **$+35\%$** w `CollisionIon` |
| **2** | **Multiplicative Selection MCC** | `collisions.go` | Zamiana dzieleń `r < s/tot` na mnożenia `r*tot < s` | **$4\times$ szybszy** wybór |
| **3** | **4-Way Unrolling (ILP)** | `simulation.go` | 4 cząstki na iterację w Leap-Frog (niezależne potoki FMA) | **$+30\%–50\%$** w Step3/4 |
| **4** | **Rozdział Fast-Path / Slow-Path** | `simulation.go` | Usunięcie gałęzi diagnostyk z wewnętrznych pętli push | Zmniejszenie branch misses |
| **5** | **Prekompilacja Odwrotności** | `constants.go` | Eliminacja `DIVSD` na rzecz stałych mnożników (`INV_DX`, `INV_DT`) | **$-15$ cykli** per operacja |
| **6** | **Płaskie Bufory SoA** | `state.go`, `simulation_null.go` | Wyeliminowanie struktur AoS w buforach nowych cząstek | Lepsza lokalność L1/L2 |
| **7** | **Bounds Check Elimination (BCE)** | `simulation.go`, `collisions.go` | Wskazówki `_ = x[end-1]` usuwające `CMPQ/JLS` | **$-32$ instrukcji** per 16 liczb |
| **8** | **Padding Cache-Line 64B (False Sharing)** | `state.go` | Izolacja buforów diagnostycznych workerów (`_ [8]uint64`) | Usunięcie narzutu 120 ns |
| **9** | **Zero-Allocation w Pętli Czasowej** | `simulation_null.go` | Prealokacja i zerowanie slice'ów `[:0]` z zachowaniem `cap` | **0 allocs/op**, brak GC |
| **10** | **Skalowanie NUMA / Worker Pinning** | `GoPIC_jobs/Go/` | Rekomendacja do 32 workerów w 1 gnieździe | Unikanie grain-size limit |
| **11** | **Flagi Kompilacji (`GOAMD64=v4`)** | `GoPIC_jobs/Go/` | Domyślne wymuszenie AVX-512 oraz striping `-ldflags="-s -w"` | Pełne SIMD na Zen 4 |

---

## 🛠️ Szczegółowy Plan Realizacji Krok po Kroku

---

### Faza 1: Prekompilacja Odwrotności i Stałych Matematycznych (Optymalizacja 5)
* **Plik:** [`Go/parallel_chunking/constants.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/constants.go)
* **Problem:** W gorących pętlach wielokrotnie powtarzają się dzielenia zmiennoprzecinkowe przez stałe parametry symulacji (`/ DX`, `/ DT_E`, `/ DT_I`, `/ (2 * EV_TO_J)`, itp.). Instrukcja `DIVSD` w architekturze AMD Zen 4 zajmuje 13–18 cykli zegara i ma niską przepustowość (0.5 ops/cykl), podczas gdy mnożenie `MULSD` zajmuje 3 cykle i ma przepustowość 2 ops/cykl.
* **Zadania do wykonania:**
  1. Dodać stałe odwrotności w `constants.go`:
     ```go
     const (
         INV_DX             = 1.0 / DX
         INV_DT_E           = 1.0 / DT_E
         INV_DT_I           = 1.0 / DT_I
         INV_TWO_E_MASS     = 1.0 / (2.0 * E_MASS)
         INV_TWO_I_MASS     = 1.0 / (2.0 * I_MASS)
         FACTOR_ENERGY_E    = 0.5 * E_MASS / EV_TO_J
         FACTOR_ENERGY_IFED = 0.5 * I_MASS / EV_TO_J
     )
     ```
  2. Zastąpić wszystkie wystąpienia dzieleń przez `DX` i `DT` mnożeniami przez prekompilowane odwrotności w całym pakiecie.
* **Kryterium akceptacji:** Brak operacji dzielenia przez stałe w gorących pętlach `Step1`, `Step3`, `Step4`, `Step6`.

---

### Faza 2: Optymalizacja Silnika Zderzeń Jonów i Elektronów (Optymalizacje 1 i 2)
* **Plik:** [`Go/parallel_chunking/collisions.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/collisions.go)
* **Problem 1 (Multiplicative Selection):** W pętlach wyboru typu zderzenia obliczane są ułamki `r < sigma[0] / sigma_tot`. Dzielenie przez `sigma_tot` powtarza się w każdym zagnieżdżonym warunku.
* **Problem 2 (Fast-Path Charge Exchange `I_BACK`):** W zderzeniach jon-atom zderzenie wymiany ładunku (Charge Exchange, `I_BACK`) stanowi **ponad 75% wszystkich zderzeń jonów**. Dotychczasowy kod wykonywał pełną geometrię rozproszenia: funkcje trygonometryczne `cos/sin`, losowanie kątów azymutalnych w układzie środka masy i transformacje prędkości. Zgodnie z fizyką zderzenia wymiany ładunku szybki jon po prostu przechwytuje elektron od powolnego atomu gazu tła. Nowy jon przejmuje więc dokładnie prędkość termiczną atomu tła wylosowaną z rozkładu Maxwella!
* **Zadania do wykonania:**
  1. Zastąpić dzielenia mnożeniem iloczynu skumulowanego:
     ```go
     // Zamiast: if r < sigma[0] / sigma_tot
     target := r * sigma_tot
     if target < sigma[0] { ... }
     ```
  2. Dodać ścieżkę **Fast-Path dla `I_BACK`** w `CollisionIon`:
     ```go
     if collisionType == I_BACK {
         // Fast-path: Jon przejmuje prędkość atomu tła Ar (brak trygonometrii i kątów)
         sim.Vx_i[k] = v_Ar_x
         sim.Vy_i[k] = v_Ar_y
         sim.Vz_i[k] = v_Ar_z
         return
     }
     // Slow-path (zderzenia sprężyste I_ELAS): pełna geometria
     ```
* **Kryterium akceptacji:** Skrócenie czasu zderzeń jonów o ~35% przy zachowaniu pełnej poprawności statystycznej.

---

### Faza 3: Eliminacja False Sharing i Płaskie Struktury SoA (Optymalizacje 6 i 8)
* **Plik:** [`Go/parallel_chunking/state.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/state.go) oraz [`simulation_null.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go)
* **Problem:** Struktury per-worker (np. `WorkerEDiag`, liczniki zderzeń, bufory absorpcji) są alokowane w tablicach indeksowanych identyfikatorem workera `[workerID]`. W architekturze wielordzeniowej elementy te lądują w tej samej 64-bajtowej linii pamięci podręcznej (*Cache Line*). Zapis z rdzenia A unieważnia linię w rdzeniu B (*False Sharing*), co na procesorze AMD EPYC z magistralą Infinity Fabric powoduje opóźnienia międzynode'owe rzędu **~120 ns**.
* **Zadania do wykonania:**
  1. Dodać 64-bajtowy padding w strukturach diagnostycznych i buforach workerów:
     ```go
     type WorkerDiagnostics struct {
         Count        uint64
         AbsPow       float64
         EkinAccu     float64
         _            [8]uint64 // 64-bajtowy padding chroniący przed False Sharing
     }
     ```
  2. Zweryfikować, że bufory `WorkerNewElectrons` i `WorkerNewIons` przechowują współrzędne w płaskich slice'ach `X, Vx, Vy, Vz` (Structure of Arrays) zamiast struktur `Particle` (AoS).
* **Kryterium akceptacji:** Brak invalidacji linii cache między wątkami podczas równoległego zbierania diagnostyk.

---

### Faza 4: 4-Krotne Rozwinięcie Pętli Leap-Frog i Bounds Check Elimination (Optymalizacje 3 i 7)
* **Plik:** [`Go/parallel_chunking/simulation.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go) (`Step3MoveElectrons` oraz `Step4MoveIons`)
* **Problem:** Kompilator Go wewnątrz pętli generuje instrukcje `CMPQ` i `JLS/JHI` (sprawdzanie granic slice'a) dla każdego odczytu `x[k]`, `vx[k]`. Ponadto przetwarzanie po 1 cząstce blokuje jednostki wykonawcze FMA z powodu zależności danych (RAW hazards).
* **Zadania do wykonania:**
  1. Dodać wskazówki BCE (*Bounds Check Elimination*) przed rozpoczęciem pętli:
     ```go
     if end > start {
         _ = sim.X_e[end-1]
         _ = sim.Vx_e[end-1]
         _ = sim.Vy_e[end-1]
         _ = sim.Vz_e[end-1]
     }
     ```
  2. Zaimplementować **4-way unrolling** w głównej pętli przesuwania cząstek:
     * Przetwarzać czwórkami: `k, k+1, k+2, k+3`
     * Obliczenia interpolacji pola $E$ i nowe prędkości dla 4 cząstek wykonywane niezależnie (umożliwia równoległe harmonogramowanie w jednostkach FPU Zen 4)
     * Dodać pętlę dopełniającą (*tail loop*) dla cząstek pozostałych z reszty z dzielenia przez 4.
  3. Sprawdzić asembler za pomocą `go build -gcflags="-d=ssa/check_bce"` i potwierdzić usunięcie sprawdzeń granic.
* **Kryterium akceptacji:** Wzrost IPC w pętli Leap-Frog i skrócenie czasu kroku czasowego o 30%–50%.

---

### Faza 5: Gwarancja Zero-Allocation w Pętli Czasowej (Optymalizacja 9)
* **Plik:** [`Go/parallel_chunking/simulation.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go) oraz [`simulation_null.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go)
* **Problem:** Tworzenie tymczasowych slice'ów lub obiektów w trakcie 4000 kroków/cykl wymusza pracę odśmiecacza pamięci (Garbage Collector), co powoduje mikroprzestoje *Stop-The-World*.
* **Zadania do wykonania:**
  1. Upewnić się, że resetowanie buforów cząstek i gęstości odbywa się wyłącznie za pomocą:
     ```go
     sim.WorkerNewElectrons[w].X = sim.WorkerNewElectrons[w].X[:0]
     ```
     z zachowaniem zaalokowanej pojemności (`cap`).
  2. Dodać test jednostkowy sprawdzający alokacje:
     ```go
     allocs := testing.AllocsPerRun(10, func() {
         sim.DoOneCycle()
     })
     // Asercja: allocs == 0
     ```
* **Kryterium akceptacji:** 0 alokacji sterty per krok w pętli czasowej symulacji.

---

### Faza 6: Przeniesienie Zoptymalizowanych Rozwiązań do `Go/parallel_channels`
* **Pliki:** [`Go/parallel_channels/worker.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/worker.go), `collisions.go`, `constants.go`, `state.go`
* **Zadania do wykonania:**
  1. Po przetestowaniu i zweryfikowaniu zmian w `parallel_chunking`, przenieść zaktualizowane pliki `constants.go` i `collisions.go` do `Go/parallel_channels`.
  2. Zaktualizować obsługę rozkazów `CmdMoveElectrons`, `CmdMoveIons` oraz `CmdComputeEDensity` w pętli `startWorker` o rozwinięcie 4-way unrolling i wskazówki BCE.
  3. Usunąć podział na `simulation_standard.go` w `parallel_channels` i pozostawić wyłącznie Null-Collision.

---

## 🚦 Kolejność Wdrażania i Punkty Kontrolne

1. **Krok 1:** `constants.go` (prekompilacja odwrotności) $\rightarrow$ uruchomienie testów (`go test ./tests`).
2. **Krok 2:** `collisions.go` (fast-path `I_BACK` + multiplicative selection) $\rightarrow$ uruchomienie testów zderzeń.
3. **Krok 3:** `state.go` (padding 64B przeciw False Sharing).
4. **Krok 4:** `simulation.go` (4-way unrolling + BCE w `Step3` i `Step4`) $\rightarrow$ weryfikacja poprawności fizycznej i testów regresyjnych.
5. **Krok 5:** Test wydajności i benchmarki porównawcze przed i po optymalizacji.
6. **Krok 6:** Adaptacja `Go/parallel_channels`.
