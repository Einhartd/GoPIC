# Porównanie optymalizacji implementacji równoległych GoPIC

> **Cel dokumentu**: upewnić się że C++ OMP, Go `parallel_chunking` i Go `parallel_channels`
> mają te same algorytmiczne optymalizacje wszędzie tam, gdzie nie wynika to ze specyfiki języka.
> Dzięki temu porównanie logów czasu wykonania odzwierciedla właściwości języków i modeli
> współbieżności, a nie różnice w jakości implementacji.

---

## Implementacje

| Symbol | Ścieżka | Model współbieżności |
|:---|:---|:---|
| **C++** | `C/parallel-only-omp/` | OpenMP — wątki OS, persistent parallel region per cykl |
| **Go-CK** | `Go/parallel_chunking/` | Goroutyny tworzone per krok, `sync.WaitGroup` |
| **Go-CH** | `Go/parallel_channels/` | Goroutyny persistent przez cały program, `chan WorkerCommand` |

---

## Legenda

| Symbol | Znaczenie |
|:---:|:---|
| ✅ | Parytet — wszystkie trzy implementacje mają identyczną optymalizację |
| ⚠️ | Trywialna różnica — wpływ poniżej mikrosekundy, nie zaburza porównania |
| 🔴 | Znacząca różnica — może zaburzyć porównanie |
| 🌐 | Różnica językowa — wynika ze specyfiki języka/kompilatora, nieportowalna |

---

## STEP 1 — Depozycja gęstości (scatter-add)

### Wzorzec: lokalne bufory + barrier + redukcja

| Aspekt | C++ | Go-CK | Go-CH | Status |
|:---|:---:|:---:|:---:|:---:|
| Każdy wątek/goroutyna ma własny bufor `[N_G]double` | ✅ | ✅ | ✅ | ✅ |
| Pętla po cząstkach rozdzielona między wątki | ✅ `#pragma omp for simd` | ✅ `wg.Go` + chunk | ✅ cmd → worker chunk | ✅ |
| Barrier przed redukcją | ✅ `#pragma omp barrier` | ✅ `wg.Wait()` | ✅ `<-WorkerDoneChan` × N | ✅ |
| Redukcja buforów do globalnej tablicy | ✅ równoległa po N_G | ⚠️ serial | ⚠️ serial | ⚠️ |
| Korekcja brzegowa `density[0] *= 2` | ✅ `omp single` | ✅ serial | ✅ serial | ✅ |
| Akumulacja `cumul_density` | ✅ równoległa `omp for` | ⚠️ serial | ⚠️ serial | ⚠️ |
| SIMD hint na depozycji | ✅ `#pragma omp for simd` | 🌐 brak | 🌐 brak | 🌐 |

> **Redukcja N_G=400 (⚠️)**: praca to `N_workers × 400` iteracji — przy 16 workerach
> to 6400 mnożeń. Seryjnie vs równolegle: różnica < 1 µs per krok. **Niewidoczne w profilu.**

---

## STEP 2 — Solver Poissona

| Aspekt | C++ | Go-CK | Go-CH | Status |
|:---|:---:|:---:|:---:|:---:|
| Wykonuje jeden wątek, reszta czeka | ✅ `omp single` | ✅ serial między `wg.Wait()` | ✅ serial między `broadcastAndWait` | ✅ |
| Algorytm Thomas (trójdiagonalny) | ✅ | ✅ | ✅ | ✅ |

---

## STEP 3/4 — Push elektronów i jonów

| Aspekt | C++ | Go-CK | Go-CH | Status |
|:---|:---:|:---:|:---:|:---:|
| Pętla po cząstkach równolegle | ✅ `omp for nowait` | ✅ `wg.Go` | ✅ cmd → worker | ✅ |
| Lokalne bufory diagnostyczne per wątek | ✅ `worker_buffers.counter_e[tid]` | ✅ `WorkerEDiag[w]` | ✅ `WorkerEDiag[w]` | ✅ |
| Barrier po pushu | ✅ `omp barrier` | ✅ `wg.Wait()` | ✅ `<-done` × N | ✅ |
| Redukcja diagnostyk XT (measurement_mode) | ✅ równoległa po N_G | ⚠️ serial | ⚠️ serial | ⚠️ |
| Redukcja EEPF (N_EEPF=2000 binów) | ✅ równoległa `omp for` | ⚠️ serial | ⚠️ serial | ⚠️ |
| Skalary energii (`accu_center`) | ✅ `omp single` pętla | ✅ serial | ✅ serial | ✅ |

> **Redukcja diagnostyk (⚠️)**: aktywna tylko w `measurement_mode` (ostatnie N cykli).
> N_G=400 lub N_EEPF=2000 iteracji × N_workers — przy 16 workerach max. 32 000 op.
> Różnica < 5 µs per krok przy measurement_mode. **Pomijalne.**

---

## STEP 5/6 — Boundary absorption

| Aspekt | C++ | Go-CK | Go-CH | Status |
|:---|:---:|:---:|:---:|:---:|
| Równoległe oznaczanie `absorbed[]` flag | ✅ `omp for` | ✅ `wg.Go` | ✅ cmd → worker | ✅ |
| Lokalne liczniki absorbowanych | ✅ `AlignedThreadCounters` | ✅ `WorkerEDiag.abs_pow` | ✅ `WorkerEDiag.abs_pow` | ✅ |
| `alignas(64)` false sharing prevention | ✅ | 🌐 Go GC | 🌐 Go GC | 🌐 |
| Seryjny fast-swap compaction po barrier | ✅ `omp single { while... }` | ✅ serial | ✅ serial | ✅ |
| Lokalne bufory IFED per wątek (jony) | ✅ `local_ifed_pow[tid]` | ✅ `WorkerIDiag.ifed_pow` | ✅ `WorkerIDiag.ifed_pow` | ✅ |
| Redukcja IFED | ✅ serial w `single` | ✅ serial | ✅ serial | ✅ |

---

## STEP 7/8 — Kolizje null-collision

| Aspekt | C++ | Go-CK | Go-CH | Status |
|:---|:---:|:---:|:---:|:---:|
| Losowanie `binom(N, P*)` — raz na krok | ✅ `omp single` | ✅ serial przed goroutynami | ✅ serial przed `broadcastAndWait` | ✅ |
| `random_sample` (Fisher-Yates) — raz na krok | ✅ `omp single` | ✅ serial | ✅ serial | ✅ |
| Podział listy kandydatów między wątki | ✅ ceiling-division chunking | ✅ ceiling-division chunking | ✅ ceiling-division chunking | ✅ |
| Worker-local RNG (brak race condition) | ✅ `thread_local mt19937` | ✅ `RngWorkers[workerID]` | ✅ `RngWorkers[workerID]` | ✅ |
| Lokalne bufory nowych cząstek | ✅ `new_electrons[tid]` | ✅ `WorkerNewElectrons[w]` | ✅ `WorkerNewElectrons[w]` | ✅ |
| Seryjny merge nowych cząstek | ✅ `omp single` | ✅ serial po `wg.Wait()` | ✅ serial po `broadcastAndWait` | ✅ |
| Licznik kolizji `N_e_coll` | ✅ local + `omp atomic` raz | ✅ local + `atomic.AddUint64` raz | ✅ local + `atomic.AddUint64` raz | ✅ |

> **Licznik kolizji (✅ naprawione)**: Go-CH używa teraz lokalnego `uint64` i woła `atomic.AddUint64` raz
> po zakończeniu chunka — identycznie jak Go-CK i C++ OMP. Go-CK używa lokalnego licznika
> `localColl` i dodaje raz po zakończeniu chunka — identycznie jak C++. Uprzednio przy ~5% kolizji
> i 50k cząstek były ~2500 atomics/krok w Go-CH — teraz wszystkie trzy mają ~N_workers atomics/krok.
> **Drobny narzut na Go-CH, nie zaburza głównego porównania.**

---

## Lifecycle goroutyn / wątków

| Aspekt | C++ | Go-CK | Go-CH |
|:---|:---|:---|:---|
| **Kiedy tworzone** | Raz per cykl RF (`#pragma omp parallel` w `do_one_cycle`) | Per krok PIC (`wg.Go` w każdym stepie) | Raz per program (`InitWorkers`) |
| **Kiedy kończą pracę** | Po 4000 krokach (koniec cyklu) | Po jednym kroku (po `wg.Wait()`) | Przy `StopWorkers()` (koniec programu) |
| **Co między krokami** | Nie istnieją (ale OMP thread pool je utrzymuje w hot standby) | Nie istnieją | Blokują na `for cmd := range chan` |
| **Prawdziwe wątki OS** | N wątków przez cały program (OMP thread pool) | `GOMAXPROCS` wątków przez cały program | `GOMAXPROCS` wątków przez cały program |
| **Koszt "uruchomienia" parallel** | Wakeup uśpionych wątków (~µs per cykl) | `wg.Go()` alokacja goroutyny (~100 ns × steps) | send na kanał (~50 ns × steps) |

---

## Podsumowanie parytetu

| Optymalizacja | Wpływ na czas | C++ | Go-CK | Go-CH |
|:---|:---:|:---:|:---:|:---:|
| Lokalne bufory depozycji | **Duży** | ✅ | ✅ | ✅ |
| Równoległy push cząstek | **Duży** | ✅ | ✅ | ✅ |
| Null-collision: single draw + chunking | **Duży** | ✅ | ✅ | ✅ |
| Worker-local RNG | Średni | ✅ | ✅ | ✅ |
| Seryjny Poisson | Strukturalny | ✅ | ✅ | ✅ |
| Seryjny compaction granic | Strukturalny | ✅ | ✅ | ✅ |
| Seryjny merge nowych cząstek | Mały | ✅ | ✅ | ✅ |
| Redukcja N_G=400 (równoległa vs serial) | **Pomijalny** | ✅ równ. | ⚠️ serial | ⚠️ serial |
| `atomic` per kolizję vs per chunk | Mały | ✅ | ✅ | ✅ |
| `#pragma omp simd` | Językowy | ✅ | 🌐 | 🌐 |
| `alignas(64)` false sharing | Językowy | ✅ | 🌐 | 🌐 |

---

## Schemat przepływu (identyczny we wszystkich trzech)

```
┌─ krok t ──────────────────────────────────────────────────────────────┐
│                                                                        │
│  C++:    [N wątków OMP równolegle]      ← barrier →  [omp single]    │
│  Go-CK:  [N goroutyn wg.Go równolegle] ← wg.Wait() → [main goroutyna]│
│  Go-CH:  [N workerów cmd→done równol.] ← done×N →   [main goroutyna]│
│                                                                        │
│  ┌─ RÓWNOLEGLE ──────────────────┐   ┌─ SERIAL ─────────────────────┐│
│  │ Depozycja do lokalnych buforów│   │ Redukcja buforów → grid      ││
│  │ Push cząstek + diag lokalne   │   │ Korekcja brzegowa *=2        ││
│  │ Oznacz absorbed[] flags       │   │ Poisson solver               ││
│  │ Null-coll: chunk kandydatów   │   │ Fast-swap compaction         ││
│  └───────────────────────────────┘   │ Merge nowych cząstek         ││
│                                       │ XT diagnostics               ││
│                                       └──────────────────────────────┘│
└────────────────────────────────────────────────────────────────────────┘
```

---

## Co będzie widoczne w porównaniu logów

Przy jednakowej liczbie goroutyn/wątków (`GOMAXPROCS = OMP_NUM_THREADS = N`),
różnice w czasie wykonania będą odzwierciedlać:

| Źródło różnicy | Kto wygrywa | Dlaczego |
|:---|:---|:---|
| Auto-vectorization (SIMD) | C++ | GCC `-O3` agresywniej wektoryzuje niż Go compiler |
| Overhead tworzenia goroutyn per krok (Go-CK) | C++ ≈ Go-CH > Go-CK | `wg.Go` ~100 ns × ~3.2M per 100 cykli ≈ 320 ms overhead |
| Overhead kanałów (Go-CH) | C++ ≈ Go-CK > Go-CH | send+recv ~100 ns × ~3.2M per 100 cykli ≈ podobnie |
| Garbage Collector pauzy | C++ | Go GC może powodować STW pauzy między cyklami |
| `atomic` per kolizję | C++ ≈ Go-CK ≈ Go-CH | Wszystkie używają lokalnego licznika + jeden atomic per chunk |
| Cache efektywność | C++ | `alignas(64)` eliminuje false sharing explicite |
| Scheduler M:N (goroutines > GOMAXPROCS) | Go > C++ | Go scheduler lepiej radzi przy oversubscription |
