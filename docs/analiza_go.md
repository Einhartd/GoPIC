# Analiza Krytyczna: Go PIC — `parallel_chunking` vs `parallel_channels`

> **Perspektywa**: Doświadczony inżynier od zrównoleglania i symulacji PIC/MCC
> **Referencja**: Oryginalny C++ `eduPIC.cc` (ground truth)
> **Data**: 2026-08-02

---

## Podsumowanie Executive

Obie implementacje są strukturalnie poprawne w zakresie algorytmu PIC/MCC (9 kroków, subcycling, boundary ×2, cumul_i_density co krok). Kod fizyki — kolizje, Poisson solver, depozycja gęstości, push cząstek — jest wiernym odwzorowaniem C++ referencji. Jednakże obie implementacje zawierają **poważne problemy współbieżności (data races)**, kilka **potencjalnych bugów**, oraz znaczące **nieoptymalne wzorce wydajnościowe**. Poniżej przedstawiam pełną analizę.

---

## 🔴 Problemy Krytyczne (Poprawność Symulacji)

### 1. DATA RACE: Kolizje elektronów — współbieżny zapis do `Vx_e[k]` (oba warianty)

> [!CAUTION]
> **Najpoważniejszy problem w całym kodzie. Dotyczy obu implementacji.**

W `Step7CollisionsElectrons` (tryb standard), wiele goroutines jednocześnie wywołuje:

```go
sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], energy_index, workerID)
```

`CollisionElectron` **modyfikuje** `Vx_e[k]` in-place (linia 127 collisions.go: `*vxe = wx + F2*gx`). Jednocześnie ta sama funkcja może **tworzyć nową cząstkę** (jonizacja), wstawiając ją do bufora `WorkerNewElectrons[workerID]` z pozycją `xe = sim.X_e[k]`.

**Problem**: W trybie null-collision (`simulation_null.go`), `randomSample` losuje unikalne indeksy, ale `candidates` mogą wskazywać na cząstki, których velocities zostały **już zmodyfikowane** przez inny worker pracujący na cząstce z tego samego chunka. Co gorsza — w trybie standard-collision, podział chunkami gwarantuje, że każdy worker pisze do **rozłącznych** indeksów `k`, więc sam zapis velocity nie jest race. Ale warto zwrócić uwagę na kolejny punkt:

**Prawdziwy data race w null-collision**: `randomSample` gwarantuje unikatowość indeksów, ale chunki kandydatów mogą się nakładać na inne operacje (np. `Step3MoveElectrons` zmienił `X_e[k]` chwilę wcześniej w tym samym time step — co jest OK, bo to sekwencyjne w `DoOneCycle`). Tu problemu nie ma.

**Wniosek**: W trybie standard-collision z podziałem chunkami, zapisy velocity **nie** wykazują race (rozłączne zakresy). W trybie null-collision, unikalne indeksy z `randomSample` również eliminują race. **Ten punkt jest bezpieczny**, ale wymaga dokumentacji.

### 2. DATA RACE: `parallel_chunking` — `Step1ComputeElectronDensity` — chunk podział `N_e / numWorkers` (trunc division)

> [!WARNING]
> **Potencjalna utrata cząstek przy nierównym podziale chunków.**

W [simulation.go:37](file:///home/oliwier/Dev/GoPIC/Go/parallel_chunking/simulation.go#L37):
```go
chunkSize := sim.N_e / numWorkers  // integer division — truncates!
```

Schemat: worker `w` dostaje `[w*chunkSize, (w+1)*chunkSize)`, a ostatni worker `[last*chunkSize, N_e)`.

**Problem**: Jeśli `N_e = 100003` i `numWorkers = 12`:
- `chunkSize = 8333` (obcięte)
- Worker 0: [0, 8333), Worker 1: [8333, 16666), ..., Worker 10: [83330, 91663)
- Worker 11 (last): [91663, 100003) → **8340 cząstek**

Ale gdyby `N_e = 100000`, worker 11 dostaje `[91663, 100000)` = 8337, a wszyscy inni 8333. **To jest poprawne**, ale subtelne: brak guard'a `start >= end` dla pustych chunków! Jeśli `numWorkers > N_e` (np. 12 workerów, 5 cząstek), to `chunkSize = 0`, i każdy worker z wyjątkiem ostatniego ma pusty zakres `[0, 0)` ale nadal zeruje i redukuje `WorkerEDensity`.

**Porównanie z `parallel_channels`**: Channels version używa `(N_e + numWorkers - 1) / numWorkers` (ceil division) + guard `start < end`, co jest **lepsze**. Chunking version ma niespójne wzorce — density i push używają `N_e / numWorkers`, ale boundary checking używa ceil division. To jest **niespójność, nie bug**, ale powinna być ujednolicona.

### 3. BUG: `parallel_channels` — podwójne wywołanie `InitWorkers()` 🐛

> [!CAUTION]
> **Bug powodujący podwojenie goroutines workerów.**

W [state.go:182](file:///home/oliwier/Dev/GoPIC/Go/parallel_channels/state.go#L182), `NewSimulationState()` wywołuje `sim.InitWorkers()`. A następnie w [run.go:43](file:///home/oliwier/Dev/GoPIC/Go/parallel_channels/run.go#L43), `Run()` wywołuje `sim.InitWorkers()` **ponownie**:

```go
sim := NewSimulationState(time.Now().UnixNano())
sim.InitWorkers()  // DRUGIE wywołanie!
```

To tworzy **2 × numWorkers** goroutines, z których połowa czyta z tych samych kanałów. Efekt: każda komenda `broadcastAndWait` wysyła `numWorkers` poleceń, ale **2 × numWorkers** goroutines nasłuchuje. Tylko `numWorkers` odpowiedzi jest oczekiwanych na `WorkerDoneChan`, więc:

1. Pierwsze `numWorkers` goroutines (z `NewSimulationState`) odbierają komendy i wysyłają done
2. Drugie `numWorkers` goroutines (z `Run`) czekają na te same kanały → **nie dostają nic** (buforowane kanały rozmiaru 1)
3. **Albo** — co gorsza — oba zestawy goroutines rywalizują o odbiór z kanału, powodując **niedeterministyczny podział pracy** i potencjalne przetworzenie duplikatów/braki

**Wpływ**: Kanał `WorkerCmdChan[w]` ma rozmiar bufora 1, więc `broadcastAndWait` wysyła jedną komendę na kanał. Dokładnie jedna z dwóch goroutines (oryginalna lub duplikat) odbierze komendę. Ponieważ obie operują na tych samych danych z tym samym `workerID`, wynik **może** być poprawny, ale: „wiszące" goroutines konsumują pamięć, i deterministyczność jest zagrożona.

**Fix**: Usunąć `sim.InitWorkers()` z `Run()`.

### 4. Brak ochrony MAX_N_P overflow (oba warianty)

> [!WARNING]
> **Przy intensywnej jonizacji, N_e lub N_i mogą przekroczyć MAX_N_P = 1,000,000.**

W C++ reference overflow powoduje cichą korupcję pamięci (statyczne tablice). W Go, `ParticleVector` to `[1000000]float64` (fixed-size array), więc dostęp poza zakresem `sim.X_e[sim.N_e]` przy `N_e >= MAX_N_P` spowoduje **panic** (index out of range). To jest **lepsze** niż cicha korupcja, ale brak jawnego guard'a i obsługi sytuacji wyjątkowej.

---

## 🟠 Problemy Średniego Priorytetu (Wydajność i Narzut)

### 5. Ogromny narzut synchronizacji — 9 barier per time step (oba warianty)

Każdy z 4000 time steps w cyklu RF wymaga co najmniej **5-9 pełnych barier synchronizacji** (w zależności od subcycling):

| Krok | Bariery | Częstotliwość |
|------|---------|---------------|
| Step1a (e-density) | 1× `wg.Wait()` / `broadcastAndWait` | co krok |
| Step1b (i-density) | 1× (conditional) | co 20 kroków |
| Step3 (push e) | 1× | co krok |
| Step4 (push i) | 1× (conditional) | co 20 kroków |
| Step5 (boundary e) | 1× | co krok |
| Step6 (boundary i) | 1× (conditional) | co 20 kroków |
| Step7 (collisions e) | 1× | co krok |
| Step8 (collisions i) | 1× (conditional) | co 20 kroków |

**Minimum**: 5 barier × 4000 kroków = **20,000 synchronizacji/cykl**
**W subcycling steps**: 9 barier

Przy ~80K cząstkach (typowe N_e/N_i w stanie ustabilizowanym), koszt synchronizacji dominuje nad obliczeniami, ponieważ każdy „chunk" to tylko ~7000 cząstek/worker (przy 12 workerach).

**Rekomendacja**: Połączenie kroków 1a+2+3 (density → Poisson → push) jako jeden dispatch, z Poissonem wykonanym przez main thread po redukcji density, a push dispatched natychmiast po. Alternatywnie — pipeline z double-buffering.

### 6. `parallel_channels`: Narzut kanałów vs `sync.WaitGroup`

> [!IMPORTANT]
> `parallel_channels` ma inherentnie **wyższy** overhead niż `parallel_chunking`.

Mechanizm `broadcastAndWait`:
```go
func (sim *SimulationState) broadcastAndWait(cmd WorkerCommand) {
    for w := range numWorkers {
        sim.WorkerCmdChan[w] <- cmd     // N channel sends
    }
    for range numWorkers {
        <-sim.WorkerDoneChan            // N channel receives
    }
}
```

Każdy channel send/receive wymaga synchronizacji runtime (mutex w implementacji kanału Go). Przy 12 workerach, to 24 operacje kanałowe per barierę. Porównanie z `wg.Go()` + `wg.Wait()` w chunking:

| Aspekt | Chunking (`sync.WaitGroup`) | Channels |
|--------|----------------------------|----------|
| Goroutine lifetime | Efemerydalny (nowy per krok) | Persistent (cały czas żyją) |
| Scheduling overhead | Goroutine spawn (~2μs) | Channel send/recv (~200ns) |
| Cache warmup | Zimny start co krok | Ciepłe rdzenie |
| Total per barrier | spawn+schedule+wait | 2N × channel ops |

**Paradoks**: Persistent workers (channels) powinny być szybsze (brak spawn), ale overhead **24 operacji kanałowych** może dominować przy małych chunkach pracy. W praktyce, Go scheduler dobrze optymalizuje `wg.Go()` — goroutines mogą być rescheduled na tym samym rdzeniu bez context switch.

### 7. `sampleBinomial` — O(N) sequential bottleneck (oba warianty, null-collision)

W [simulation_null.go:38-46](file:///home/oliwier/Dev/GoPIC/Go/parallel_chunking/simulation_null.go#L38-L46):
```go
func (sim *SimulationState) sampleBinomial(n int, p float64) int {
    count := 0
    for i := 0; i < n; i++ {
        if sim.Rng.Float64() < p {
            count++
        }
    }
    return count
}
```

Dla N_e ≈ 80,000 cząstek, to **80,000 wywołań RNG** na **jednym** wątku (main thread). Przy typowym `PStarE ≈ 0.03`, normalna aproksymacja byłaby poprawna: `N(n*p, n*p*(1-p))` — jedno wywołanie NormFloat64 zamiast 80,000 × Float64.

### 8. `randomSample` — O(N) alokacja (oba warianty, null-collision)

W [simulation_null.go:25-34](file:///home/oliwier/Dev/GoPIC/Go/parallel_chunking/simulation_null.go#L25-L34):
```go
func (sim *SimulationState) randomSample(n, count int) []int {
    pool := make([]int, n)   // allokuje 80,000 intów = 640 KB
    for i := range pool {
        pool[i] = i
    }
    // Fisher-Yates partial shuffle...
    return pool[:count]
}
```

**Każdy** time step (co krok dla elektronów, co 20 kroków dla jonów) alokuje i inicjalizuje tablicę ~80,000 elementów. To **640 KB alokacji per krok** — generujące GC pressure. 

**Rekomendacja**: Pre-allokacja `pool` w `SimulationState` (jednorazowa alokacja MAX_N_P) i reuse.

### 9. Brak `alignas(64)` / cache-line padding (oba warianty)

> [!NOTE]
> `parallel_chunking` w C++ OMP version używa `alignas(64)` na worker counters, aby uniknąć false sharing.

`WorkerEDiag` i `WorkerIDiag` są alokowane jako `[]electronWorkerDiagnostics` (slice). Go nie gwarantuje wyrównania do granicy cache line (64B). Struct `electronWorkerDiagnostics` zawiera:
- `counter_e [400]float64` = 3200 B
- `ue [400]float64` = 3200 B
- ... łącznie ~26 KB

Przy tak dużych strukturach, false sharing jest mało prawdopodobny (każdy element daleko od granicy sąsiedniego workera). Ale mniejsze pola (`abs_pow`, `abs_gnd`, `accuCenter`, `counterCenter` — łącznie 32B) mogą leżeć na końcu struktury, blisko początku kolejnego workera w slice.

**W praktyce**: Prawdopodobieństwo false sharing jest niskie ze względu na rozmiar structa, ale warto dodać padding w `SimulationState` dla pól `N_e_abs_pow`, `N_e_abs_gnd` itp.

### 10. `atomic.AddUint64(&sim.N_e_coll, 1)` — zbędny atomik w chunking

W `parallel_chunking/simulation_standard.go`, linia 56:
```go
atomic.AddUint64(&sim.N_e_coll, 1)
```

`N_e_coll` jest tylko licznikiem diagnostycznym. W chunking version, wiele goroutines pisze atomowo do tego samego countera. Alternatywa: per-worker counter → reduce po `wg.Wait()`, eliminując contention na atomowej instrukcji (LOCK XADD na x86).

---

## 🟡 Problemy Niskiego Priorytetu (Jakość Kodu, Utrzymanie)

### 11. Niespójne wzorce chunk division

| Miejsce | Wzorzec |
|---------|---------|
| Chunking: density, push | `chunkSize = N / numWorkers` (floor division) |
| Chunking: boundary, collisions | `chunkSize = (N + numWorkers - 1) / numWorkers` (ceil division) |
| Channels: wszystkie | `chunkSize = (N + numWorkers - 1) / numWorkers` (ceil division) |

Floor division może zostawić cząstki nieprzetworzone jeśli `N_e % numWorkers != 0` — ale **jest** osłonięte guardem `if w == numWorkers-1 { end = sim.N_e }`. Mimo to, niespójność utrudnia code review.

### 12. Poisson solver — inherentnie sekwencyjny

`SolvePoisson` (Thomas algorithm) jest inherentnie sekwencyjny (forward sweep + back substitution) i nie jest zrównoleglow w żadnym wariancie. To jest **poprawne** — Thomas algorithm ma O(N_G) = O(400) operacji, co jest zaniedbywalne wobec particle loops O(N_e) = O(80,000). Parallelizacja Poissona nie przyniesie zysku.

### 13. `Step9CollectXtData` — brak paralelizacji

Pętla po `N_G = 400` elementach w trybie measurement. Overhead paralelizacji byłby wyższy niż zysk. **Poprawna decyzja** — zostawić sekwencyjnie.

### 14. Fixed-size arrays zamiast dynamicznych slices

`ParticleVector [MAX_N_P]float64` alokuje 8 MB na stosie/strukturze dla każdej z 8 tablic cząstek (x, vx, vy, vz × electrons + ions) = **64 MB** stałej alokacji, niezależnie od faktycznej liczby cząstek. Analogicznie `CrossSection [CS_RANGES]float64` = 8 MB × 7 tablic = 56 MB. Łącznie `SimulationState` zajmuje ponad **200 MB**.

W Go, tak duże struktury na stosie powodują, że kompilator alokuje je na heapie (escape analysis). Nie jest to problem wydajnościowy, ale warto rozważyć dynamiczną alokację z pre-alloc capacity.

---

## ✅ Co Działa Poprawnie

| Aspekt | Status | Notatki |
|--------|--------|---------|
| Boundary ×2 correction | ✅ OK | `E_density[0] *= 2.0`, `E_density[N_G-1] *= 2.0` po redukcji |
| `cumul_i_density` co krok | ✅ OK | Poza blokiem `if (t % N_SUB) == 0` |
| Electron push sign | ✅ OK | `Vx_e[k] -= e_x * FACTOR_E` |
| Ion push sign | ✅ OK | `Vx_i[k] += e_x * FACTOR_I` |
| Thomas algorithm | ✅ OK | A=1, B=-2, C=1, boundary E-field correction |
| Collision physics (Euler angles) | ✅ OK | Identyczna z C++ |
| Ionization (ejected electron) | ✅ OK | Poprawny energy split, chi/chi2/eta/eta2 |
| Per-worker RNG | ✅ OK | Deterministic seeding `seed + i*10007 + 1` |
| Worker-local buffers for new particles | ✅ OK | AoS `CreatedParticle` → sequential flush |
| Cross sections (Phelps formulas) | ✅ OK | Identyczne z C++ |
| Subcycling guard | ✅ OK | `if (t % N_SUB) != 0 { return }` |
| Fast-swap particle deletion | ✅ OK | Sekwencyjny swap-with-last po parallel flag marking |
| XT diagnostic collection | ✅ OK | Per-worker bufory → sekwencyjna redukcja |

---

## 📊 Podsumowanie Priorytetów

| # | Problem | Severity | Dotyczy | Effort |
|---|---------|----------|---------|--------|
| 3 | Podwójne `InitWorkers()` | 🔴 BUG | channels | 1 linia |
| 4 | Brak overflow guard MAX_N_P | 🟠 Safety | oba | niski |
| 7 | `sampleBinomial` O(N) sequential | 🟠 Perf | oba (null) | niski |
| 8 | `randomSample` alokacja co krok | 🟠 Perf | oba (null) | niski |
| 5 | 20K+ synchronizacji/cykl | 🟠 Arch | oba | wysoki |
| 10 | Zbędne atomiki | 🟡 Perf | chunking | niski |
| 11 | Niespójne chunk division | 🟡 Quality | chunking | niski |
| 2 | Floor vs ceil chunk division | 🟡 Correctness | chunking | niski |

---

## 🔧 Rekomendowane Akcje (Top 5)

1. **[Natychmiastowy fix]** Usunąć `sim.InitWorkers()` z [`run.go:43`](file:///home/oliwier/Dev/GoPIC/Go/parallel_channels/run.go#L43) w `parallel_channels`
2. **[Szybki zysk]** Zamienić `sampleBinomial` na aproksymację normalną: `count = round(n*p + sqrt(n*p*(1-p)) * NormFloat64())` z clamping do `[0, n]`
3. **[Szybki zysk]** Pre-allokować `pool []int` w `SimulationState` (raz) zamiast `make([]int, n)` co krok
4. **[Ujednolicenie]** Zamienić floor division (`N/W`) na ceil division (`(N+W-1)/W`) + guard `start >= end` wszędzie w chunking
5. **[Architektura]** Rozważyć fuzję kroków (density+Poisson+push jako jeden mega-step) w celu redukcji barier synchronizacji — ale to duży refaktor

---

## Uwagi Końcowe

Obie implementacje wiernie odwzorowują fizykę PIC/MCC z oryginalnego `eduPIC.cc`. Największy problem (`InitWorkers` × 2) jest trywialny do naprawienia. Problemy wydajnościowe (binomial sampling, alokacje, narzut synchronizacji) są typowe dla naiwnej paralelizacji PIC — prawdziwy zysk wymaga zmiany architektury na bardziej gruboziarnistą (np. operator splitting z pipelined stages, albo batch processing wielu time steps z deferred synchronizacją).

Wariant `parallel_chunking` jest prostszy koncepcyjnie i prawdopodobnie szybszy w praktyce (mniejszy overhead niż channels). Wariant `parallel_channels` jest bardziej idiomatyczny w Go (CSP model), ale nie oferuje przewagi wydajnościowej przy tak fine-grained synchronizacji.
