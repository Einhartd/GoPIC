# Krytyczna Analiza Implementacji Równoległych PIC/MCC w Pythonie

> **Analizowane warianty:**
> - [`python/numba_parallel/`](file:///home/oliwier/Dev/GoPIC/python/numba_parallel) — Numba `@njit(parallel=True)` + `prange`
> - [`python/hybrid_parallel/`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel) — MPI (`mpi4py`) + Numba parallel threads
>
> **Porównanie z:**
> - [`python/numba_version/`](file:///home/oliwier/Dev/GoPIC/python/numba_version) — sekwencyjna Numba (ground truth Python)
> - [`eduPIC/C/eduPIC.cc`](file:///home/oliwier/Dev/GoPIC/eduPIC/C/eduPIC.cc) — oryginalny kod C++ (ground truth globalne)

---

## Podsumowanie Wykonawcze

Obie implementacje równoległe są **poprawne pod względem algorytmu symulacyjnego** — zachowują prawidłową kolejność 9 kroków PIC/MCC, stosują właściwe znaki w push (e⁻: `v -= FACTOR_E × E`, Ar⁺: `v += FACTOR_I × E`), poprawnie implementują korekcję brzegową `×2`, akumulację `cumul_i_density` na każdym kroku, oraz Thomas algorithm.

Zidentyfikowano jednak **istotne problemy** dotyczące poprawności zrównoleglenia i optymalizacji, które mogą wpłynąć na wyniki symulacji lub wydajność.

---

## 1. Poprawność Fizyczna Symulacji

### 1.1 Algorytm 9-krokowy

| Krok | C++ ref | numba_version (seq) | numba_parallel | hybrid_parallel | Status |
|:-----|:--------|:--------------------|:---------------|:----------------|:-------|
| 1a. Depo e⁻ + boundary ×2 | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 1b. Depo Ar⁺ (subcycling) | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 1c. cumul_i co krok | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 2. Poisson (Thomas) | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 3. Push e⁻ (`v -= F_E×E`) | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 4. Push Ar⁺ (`v += F_I×E`) | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 5. Absorpcja e⁻ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 6. Absorpcja Ar⁺ + IFED | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 7. MCC e⁻ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 8. MCC Ar⁺ | ✅ | ✅ | ✅ | ✅ | ✅ OK |
| 9. XT accumulation | ✅ | ✅ | ✅ | ✅ | ✅ OK |

### 1.2 Stałe fizyczne i wzory

Stałe fizyczne (`E_CHARGE`, `E_MASS`, `AR_MASS`, `EPSILON0`, itp.) są **identyczne** we wszystkich wariantach — plik [`constants.py`](file:///home/oliwier/Dev/GoPIC/python/numba_parallel/constants.py) jest współdzielony.

Wzory kolizji (`collision_electron`, `collision_ion`) — rotacja Eulera, typy zderzeń, progi energetyczne — są **identyczne** bajt po bajcie w obu implementacjach równoległych i zgodne z kodem sekwencyjnym oraz C++.

### 1.3 Korekcja brzegowa ×2

| Wariant | Elektron density `[0] *= 2` | Ion density `[0] *= 2` |
|:--------|:----------------------------|:-----------------------|
| C++ (ref) | L:527-528 ✅ | L:539-540 ✅ |
| numba_version | `step1_compute_electron_density` L:29-30 ✅ | `step1_compute_ion_density` L:60-61 ✅ |
| numba_parallel | `step1_compute_electron_density` L:40-41 ✅ | `step1_compute_ion_density` L:80-81 ✅ |
| hybrid_parallel | `step1_finish_electron_density` L:43-44 ✅ | `step1_finish_ion_density` L:79-80 ✅ |

> [!NOTE]
> Korekcja jest poprawna we wszystkich wariantach. W hybrid_parallel jest wykonana po `MPI_Allreduce`, co jest prawidłowe — gęstość jest najpierw sumowana globalnie, potem korygowana na brzegach.

### 1.4 Akumulacja cumul_i_density

W C++ (L:542): `cumul_i_density` jest akumulowane **co każdy krok czasowy**, nie tylko w krokach subcyclingu. Implementacje to respektują:

- **numba_parallel**: [`step1_compute_ion_density`](file:///home/oliwier/Dev/GoPIC/python/numba_parallel/simulation.py#L47-L84) — gdy `t % N_SUB != 0`, akumuluje ostatnią ważną `i_density` (L:52-53) ✅
- **hybrid_parallel**: [`step1_accumulate_ion_density`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel/simulation.py#L86-L89) — osobna funkcja w gałęzi `else` (L:664) ✅

---

## 2. Analiza Zrównoleglenia — numba_parallel

### 2.1 Architektura

Wariant `numba_parallel` używa `@njit(parallel=True)` z `numba.prange` dla wątków na jednym procesie. Cały cykl RF jest zamknięty w mega-kernelu [`_do_one_cycle_jit`](file:///home/oliwier/Dev/GoPIC/python/numba_parallel/simulation.py#L545-L668), co eliminuje 4000 powrotów do interpretera Pythona.

### 2.2 Unikanie Data Races w Depozycji Gęstości

```python
# numba_parallel/simulation.py L:18-38
for k in numba.prange(N_e):
    tid = numba.get_thread_id()
    ...
    local_e_density[tid, p]     += w_left  * FACTOR_W
    local_e_density[tid, p+1]   += w_right * FACTOR_W

for i in numba.prange(N_G):
    acc = 0.0
    for t in range(num_threads):
        acc += local_e_density[t, i]
    e_density[i] = acc
```

**Ocena**: ✅ **Poprawne**. Bufory per-wątek (`local_e_density[tid, ...]`) eliminują data races. Redukcja w oddzielnym `prange` jest bezpieczna.

### 2.3 Diagnostyki XT — Bufory Thread-Local

Pomiary XT (counter_e_xt, ue_xt, meanee_xt, ioniz_rate_xt, eepf) używają buforów per-wątek (`local_counter_e_xt[tid, ...]` etc.) z redukcją do globalnych tablic w oddzielnych pętlach.

**Ocena**: ✅ **Poprawne**. Identyczna strategia jak dla gęstości.

### 2.4 Kolizje — Dwufazowy Model Równoległy

```python
# Faza 1: Równoległa selekcja kolizji (prange)
_find_colliding_electrons_parallel(...)  # → thread_coll_indices, thread_coll_counts

# Faza 2: Sekwencyjna realizacja kolizji
for tid in range(num_threads):
    for c in range(thread_coll_counts[tid]):
        k = thread_coll_indices[tid, c]
        collision_electron(k, ...)
```

**Ocena**: ✅ **Poprawne pod względem poprawności** — kolizje jonizacyjne (tworzenie nowych cząstek) muszą być sekwencyjne, bo modyfikują `N_e`/`N_i`.

> [!WARNING]
> **Problem z fizyczną poprawnością (nie krytyczny):** W fazie 1 (równoległej), prędkości cząstek mogły się zmienić między fazą selekcji a fazą realizacji (gdyż faza 2 modyfikuje prędkości). W praktyce, między fazą 1 i 2 nie ma żadnych operacji pośrednich, więc problem dotyczy jedynie tego, że `energy_index` w fazie 2 jest **ponownie obliczany** z aktualnych prędkości (L:428-430), co jest poprawne. Jednak prędkość cząstki `k` może zostać zmodyfikowana przez wcześniejszą kolizję jonizacyjną innej cząstki (która stworzy nową cząstkę na pozycji `k`-tej cząstki), co jest nieosiągalne w oryginalnym sekwencyjnym algorytmie.
>
> **Skutek**: Zmiana kolejności kolizji (wątki nie gwarantują kolejności) + ponowne obliczanie `e_idx` sprawia, że wyniki nie są identyczne z wersją sekwencyjną, ale **statystycznie równoważne** — to standardowe podejście w równoległych kodach PIC.

### 2.5 Problem: Kolizje jonowe — odrzucone prędkości tła

```python
# numba_parallel/simulation.py L:339-367
# Faza 1 — prange: losowanie vx_a, vy_a, vz_a + obliczanie p_coll
for k in numba.prange(N_i):
    vx_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)  # ← wylosowane i odrzucone
    ...
    if np.random.uniform(0.0, 1.0) < p_coll:
        thread_coll_indices[tid, idx] = k

# Faza 2 — sekwencyjne: NOWE losowanie vx_a
for tid in range(num_threads):
    for c in range(count):
        k = thread_coll_indices[tid, c]
        vx_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)  # ← nowy target gas atom!
```

> [!CAUTION]
> **Błąd fizyczny (średni wpływ):** W oryginalnym C++ (L:686-699) i w wersji sekwencyjnej, prędkość atomu tła (`vx_a, vy_a, vz_a`) jest losowana **raz** i używana zarówno do:
> 1. Obliczenia `g` (prędkość względna) → `energy` → `p_coll`
> 2. Realizacji kolizji (`collision_ion`)
>
> W obu implementacjach równoległych, faza 1 losuje jeden zestaw `(vx_a, vy_a, vz_a)` do decyzji o kolizji, a faza 2 losuje **zupełnie nowy** zestaw do realizacji kolizji. To oznacza, że:
> - Prawdopodobieństwo kolizji obliczono dla jednego atomu tła
> - Kolizję zrealizowano z innym atomem tła o zupełnie innej prędkości
>
> **Skutek**: Korelacja między prawdopodobieństwem kolizji a jej kinematyką jest zaburzona. Statystycznie, dla dużej liczby cząstek i kolizji, efekt jest prawdopodobnie niewielki (rozkład Maxwellowski), ale nie jest to fizycznie poprawne.
>
> **Naprawa**: Należy zapisać prędkości atomu tła w fazie 1 i przekazać je do fazy 2 (np. w dodatkowym buforze `thread_coll_vx_a[tid, idx]`).

### 2.6 Poisson Solver — Brak Zrównoleglenia (Poprawne)

Thomas algorithm jest inherentnie sekwencyjny (forward sweep + back substitution). Solver [`_solve_poisson_jit`](file:///home/oliwier/Dev/GoPIC/python/numba_parallel/poisson.py#L8-L47) jest kompilowany jako `@njit(cache=True)` **bez** `parallel=True`, co jest poprawne.

### 2.7 Granice i absorpcja — Brak Zrównoleglenia (Poprawne)

`step5_check_boundaries_electrons` i `step6_check_boundaries_ions` są `@njit(cache=True)` bez `parallel=True`. Usuwanie cząstek (swap z ostatnią) jest inherentnie sekwencyjne — poprawna decyzja.

---

## 3. Analiza Zrównoleglenia — hybrid_parallel (MPI + Numba)

### 3.1 Architektura

Model hybrydowy: **MPI** (podział cząstek między procesy) + **Numba prange** (wątki wewnątrz procesu). Każdy rank MPI posiada podzbiór cząstek, ale rozwiązuje ten sam potencjał na tej samej globalnej siatce.

Kluczowy element: `MPI_Allreduce` gęstości lokalnych → globalna gęstość na każdym kroku.

### 3.2 Innowacja: ctypes MPI wewnątrz JIT

```python
# hybrid_parallel/simulation.py L:550-600
_lib_path = ctypes.util.find_library("mpi") or "libmpi.so.40"
_libmpi = ctypes.CDLL(_lib_path)
_MPI_Allreduce = _libmpi.MPI_Allreduce

@numba.njit
def _mpi_allreduce_double_sum(sendbuf, recvbuf, count, comm_ptr, op_ptr, type_ptr):
    _MPI_Allreduce(sendbuf.ctypes.data, recvbuf.ctypes.data, count,
                   type_ptr, op_ptr, comm_ptr)
```

**Ocena**: ✅ **Sprytna optymalizacja** — unika 8000 (4000 kroków × 2 wywołania e⁻/Ar⁺) powrotów do interpretera Pythona dla `comm.Allreduce()`. Cały mega-kernel zostaje w kodzie maszynowym.

> [!WARNING]
> **Ryzyko portabilności**: Bezpośrednie wywołanie C `MPI_Allreduce` przez `ctypes` jest niebezpieczne — wymaga, aby `MPI_Comm`, `MPI_Op`, `MPI_Datatype` były wskaźnikami (Open MPI), a nie integerami (MPICH). Na systemach z MPICH, `MPI._addressof()` może zwrócić integer, a nie pointer, co spowoduje SEGFAULT.

### 3.3 Poprawność Depozycji Gęstości z MPI

```python
# hybrid_parallel/simulation.py L:641-664
# Krok 1: Lokalna depozycja (Numba prange na wątkach)
step1_compute_local_electron_density(x_e, N_e, local_e_density, e_density, ...)

# Krok 2: MPI_Allreduce → global_e_density
_mpi_allreduce_double_sum(e_density, global_e_density, N_G, ...)

# Krok 3: Boundary ×2 + cumul na globalnej gęstości
step1_finish_electron_density(global_e_density, cumul_e_density, N_G)
```

**Ocena**: ✅ **Poprawne**. Przepływ danych:
1. Każdy rank oblicza gęstość ze swojego podzbioru cząstek → `e_density` (lokalna)
2. `Allreduce(SUM)` sumuje gęstości z wszystkich ranków → `global_e_density`
3. Korekcja ×2 i akumulacja cumul na globalnej gęstości

### 3.4 Problem: Poisson Solver — Każdy Rank Rozwiązuje Niezależnie

Każdy rank MPI rozwiązuje Poissona na tej samej globalnej gęstości (`global_e_density - global_i_density`). Ponieważ `Allreduce` gwarantuje identyczne dane na wszystkich rankach, każdy rank otrzyma identyczny `efield` i `pot`.

**Ocena**: ✅ **Poprawne, ale nieoptymalnie** — redundantne obliczenia Poissona na każdym ranku. Przy N_G=400 to ~400 operacji, marginalne.

### 3.5 Problem: Kolizje jonowe — ten sam błąd co numba_parallel

Faza 1 (`_find_colliding_ions_parallel`) losuje prędkości atomu tła, faza 2 losuje nowe. **Ten sam błąd co w §2.5.**

### 3.6 Problem: Step 9 XT — użycie global_e_density vs e_density

```python
# hybrid_parallel/simulation.py L:735-738
step9_collect_xt_data(
    pot, efield, global_e_density, global_i_density,  # ← globalne gęstości
    pot_xt, efield_xt, ne_xt, ni_xt, ...)
```

**Ocena**: ✅ **Poprawne**. Prawidłowo używa globalnych gęstości (po Allreduce) dla XT distributions, tak samo jak Poisson solver działa na globalnych gęstościach.

### 3.7 Diagnostyki XT i EEPF — Poprawna Redukcja MPI ✅

Diagnostyki XT (counter_e_xt, ue_xt, meanee_xt, eepf, itp.) są zbierane per-rank w trakcie symulacji, ale **są prawidłowo redukowane** przez funkcję [`reduce_diagnostics_mpi`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel/io_manager.py#L278-L316) przed zapisem.

Funkcja ta jest wywoływana na początku [`check_and_save_info`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel/io_manager.py#L325) i wykonuje `comm.Reduce(SUM)` na:
- Skalarach: `N_e_abs_pow/gnd`, `N_i_abs_pow/gnd`, `N_e_coll`, `N_i_coll`, `mean_energy_accu_center`, `mean_energy_counter_center`
- Tablicach: `eepf`, `counter_e_xt`, `counter_i_xt`, `ue_xt`, `ui_xt`, `meanee_xt`, `meanei_xt`, `ioniz_rate_xt`, `ne_xt`, `ni_xt`, `ifed_pow`, `ifed_gnd`
- Particle counts: `N_e`, `N_i` (sumowane globalnie)

> [!NOTE]
> Redukcja jest wykonywana na root=0, a po niej `check_and_save_info` kontynuuje tylko na rank 0 (`if sim.rank != 0: return`). Jest to poprawna strategia.

### 3.8 Absorption counters — per-rank, z redukcją przed zapisem ✅

```python
# hybrid_parallel/simulation.py L:700-701
N_e_abs_pow += abs_pow_e  # ← per-rank counter (w trakcie symulacji)
N_e_abs_gnd += abs_gnd_e
```

Countery absorpcji zliczają absorpcje per-rank w trakcie symulacji, ale są prawidłowo sumowane przez `reduce_diagnostics_mpi` (L:287-290) przed zapisem do `info.txt`.

### 3.9 EEPF i mean_energy — per-rank, z redukcją przed zapisem ✅

```python
# hybrid_parallel/simulation.py L:685-687
if measurement_mode:
    mean_energy_accu_center += accu     # ← per-rank (w trakcie symulacji)
    mean_energy_counter_center += counter # ← per-rank
```

Wartości te są prawidłowo sumowane w `reduce_diagnostics_mpi` (L:293-294) przed obliczeniami w `check_and_save_info()`.

### 3.10 Zapis conv.dat — poprawna redukcja

```python
# hybrid_parallel/simulation.py L:792-796
total_e = sim.comm.allreduce(sim.N_e, op=MPI.SUM)
total_i = sim.comm.allreduce(sim.N_i, op=MPI.SUM)
if sim.rank == 0:
    f.write(f"{sim.cycle:8d}  {total_e:8d}  {total_i:8d}\n")
```

**Ocena**: ✅ **Poprawne**. Globalny `N_e`/`N_i` jest zbierany przez `allreduce` i zapisywany tylko przez rank 0.

---

## 4. Analiza Optymalizacji

### 4.1 Zużycie Pamięci — Bufory Thread-Local

Obie implementacje alokują masywne bufory:

```python
# state.py — obie wersje
self.thread_coll_indices_e = np.zeros((num_threads, MAX_N_P), dtype=np.int64)  # num_threads × 1M × 8B
self.thread_coll_indices_i = np.zeros((num_threads, MAX_N_P), dtype=np.int64)  # num_threads × 1M × 8B
```

> [!WARNING]
> **Problem pamięci:** Przy `MAX_N_P = 1,000,000` i `num_threads = 12`:
> - `thread_coll_indices_e`: 12 × 1M × 8B = **96 MB**
> - `thread_coll_indices_i`: 12 × 1M × 8B = **96 MB**
> - **Łącznie: ~192 MB** tylko na bufory kolizyjne per proces
>
> W wersji hybrid z MPI (np. 4 ranki × 12 wątków): **768 MB** samych buforów kolizyjnych.
>
> **Naprawa**: Rozmiar bufora powinien być `MAX_N_P // num_threads` + margines, nie `MAX_N_P` per wątek. W typowej symulacji ~5% cząstek koliduje, więc realnie potrzeba `MAX_N_P * 0.05 / num_threads`.

### 4.2 Mega-kernel vs Python Loop

| Wariant | Pętla główna | Narzut interpretera |
|:--------|:-------------|:--------------------|
| numba_version (seq) | Python `for t in range(N_T)` | **4000 powrotów** do interpretera/cykl |
| numba_parallel | `@njit _do_one_cycle_jit` | **0 powrotów** ✅ |
| hybrid_parallel | `@njit _do_one_cycle_jit` | **0 powrotów** (+ ctypes MPI) ✅ |

**Ocena**: ✅ Mega-kernel w obu wariantach równoległych eliminuje overhead interpretera, co daje istotny zysk.

### 4.3 False Sharing w Buforach Thread-Local

Bufory `local_e_density[tid, :]` mają `N_G = 400` elementów × 8B = 3200B per wątek. Wiersze bufora sąsiednich wątków mogą dzielić cache line (64B), powodując false sharing.

**Ocena**: ⚠️ **Potencjalny problem wydajności**. Padding do 64B alignment mógłby poprawić wydajność na wielu rdzeniach. Jednak dla N_G=400 problem jest mniej istotny niż dla mniejszych siatek.

### 4.4 Null-collision — sekwencyjne w obu wariantach

Gdy `USE_NULL_COLLISION=true`, kolizje używają `sample_indices_inplace` (sekwencyjne) zamiast dwufazowego modelu równoległego.

**Ocena**: ✅ **Poprawna decyzja**. Null-collision i tak drastycznie redukuje liczbę testowanych cząstek, więc overhead równoległości prawdopodobnie przewyższałby zysk.

---

## 5. Porównanie z Implementacją Sekwencyjną

### 5.1 Różnice strukturalne

| Cecha | numba_version (seq) | numba_parallel | hybrid_parallel |
|:------|:--------------------|:---------------|:----------------|
| Pętla główna | Python loop | JIT mega-kernel | JIT mega-kernel + ctypes MPI |
| Density depo | Direct write (`parallel=False`) | Thread-local buffers + reduce | Thread-local + MPI Allreduce |
| XT measurement | Direct write | Thread-local + reduce | Thread-local + reduce (per-rank) |
| Collision selection | Sequential loop | 2-phase parallel | 2-phase parallel + MPI |
| Collision execution | Sequential | Sequential | Sequential |
| Poisson | `_solve_poisson_jit` | `_solve_poisson_jit` | `_solve_poisson_jit` (redundant) |
| Boundary check | Sequential swap | Sequential swap | Sequential swap |

### 5.2 Zachowanie deterministyczne

Ze względu na zrównoleglenie:
1. **Kolejność operacji arytmetycznych** w depozycji gęstości jest inna (reduce z buforów vs sekwencyjne dodawanie) — wyniki mogą się różnić o błąd zaokrąglenia
2. **Stan RNG** jest inny — `np.random` w `numba.prange` używa per-wątek RNG, co daje inne sekwencje losowe
3. **Kolejność kolizji** jest inna — dwufazowy model nie gwarantuje kolejności

**Skutek**: Wyniki nie są bit-identyczne z wersją sekwencyjną, ale powinny być **statystycznie równoważne** po dostatecznej liczbie cykli.

---

## 6. Tabela Podsumowująca Znalezionych Problemów

| # | Problem | Wariant | Wpływ | Kategoria |
|:--|:--------|:--------|:------|:----------|
| 1 | **Ion collision: podwójne losowanie prędkości tła** | oba | Średni — zaburza korelację fizyczną | Poprawność |
| 2 | **Pamięć: thread_coll_indices MAX_N_P per wątek** | oba | Średni — ~192+ MB zbędnej alokacji | Optymalizacja |
| 3 | **Portabilność ctypes MPI (MPICH vs OpenMPI)** | hybrid | Niski — SEGFAULT na MPICH | Portabilność |
| 4 | **False sharing w buforach thread-local** | oba | Niski — wpływ na wydajność wielowątkową | Optymalizacja |

---

## 7. Szczegółowa Analiza Kluczowych Błędów

### 7.1 Podwójne Losowanie Prędkości Atomów Tła (Problem #1)

**Lokalizacja:**
- [`numba_parallel/simulation.py`](file:///home/oliwier/Dev/GoPIC/python/numba_parallel/simulation.py#L339-L527) — `_find_colliding_ions_parallel` (L:347-350) + `step8_collisions_ions` (L:509-511)
- [`hybrid_parallel/simulation.py`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel/simulation.py#L344-L531) — analogiczne linie

**Oryginał C++ (L:686-699):**
```cpp
for (k=0; k<N_i; k++){
    vx_a = RMB(MTgen);  vy_a = RMB(MTgen);  vz_a = RMB(MTgen);
    gx = vx_i[k] - vx_a;  // ... oblicz g, energy, p_coll
    if (R01(MTgen) < p_coll) {
        collision_ion(&vx_i[k], &vy_i[k], &vz_i[k],
                      &vx_a, &vy_a, &vz_a, energy_index);  // ← ten sam vx_a!
    }
}
```

**Problem w implementacjach równoległych:**
```python
# Faza 1 (prange): losuj vx_a → oblicz p_coll → zapamiętaj k (ale nie vx_a!)
# Faza 2 (sekwencyjnie): losuj NOWY vx_a → oblicz g → collision_ion(nowy vx_a)
```

**Sugerowana naprawa:**
```python
# Dodaj bufory do zapisania prędkości atomu tła:
thread_coll_vxa[tid, idx] = vx_a
thread_coll_vya[tid, idx] = vy_a
thread_coll_vza[tid, idx] = vz_a
# W fazie 2: odczytaj zapamiętane prędkości zamiast losować nowe
```

### 7.2 MPI Redukcja Diagnostyk — Poprawna Implementacja ✅

Po szczegółowej weryfikacji [`hybrid_parallel/io_manager.py`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel/io_manager.py#L278-L316), stwierdzono, że implementacja **prawidłowo** redukuje dane diagnostyczne ze wszystkich procesów MPI przed zapisem.

Funkcja [`reduce_diagnostics_mpi`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel/io_manager.py#L278) jest wywoływana jako **pierwszy krok** [`check_and_save_info`](file:///home/oliwier/Dev/GoPIC/python/hybrid_parallel/io_manager.py#L325) i redukuje:

| Diagnostyka | Metoda redukcji | Status |
|:------------|:----------------|:-------|
| `density.dat` — `cumul_e/i_density` | Obliczone z global_density (po Allreduce w pętli głównej) | ✅ |
| `eepf.dat` — `eepf` | `comm.Reduce(SUM, root=0)` | ✅ |
| `ifed.dat` — `ifed_pow`, `ifed_gnd` | `comm.Reduce(SUM, root=0)` | ✅ |
| `info.txt` — `N_e_abs_pow/gnd`, `N_i_abs_pow/gnd` | `comm.reduce(SUM, root=0)` | ✅ |
| `info.txt` — `N_e_coll`, `N_i_coll` | `comm.reduce(SUM, root=0)` | ✅ |
| `info.txt` — `mean_energy_accu/counter_center` | `comm.reduce(SUM, root=0)` | ✅ |
| XT — `counter_e/i_xt`, `ue/ui_xt`, `meanee/ei_xt`, `ioniz_rate_xt`, `ne/ni_xt` | `comm.Reduce(SUM, root=0)` | ✅ |
| `N_e`, `N_i` (dla collision frequency) | `comm.reduce(SUM, root=0)` | ✅ |

> [!TIP]
> Jedyne dane, które **nie** są redukowane to `pot_xt` i `efield_xt` — ale te nie wymagają redukcji, ponieważ potencjał i pole elektryczne są identyczne na wszystkich rankach (obliczane z globalnych gęstości po Allreduce).

---

## 8. Wnioski

### Poprawność symulacyjna
Obie implementacje równoległe są **poprawne pod względem algorytmu PIC/MCC** — przebieg symulacji (depozycja → Poisson → push → boundary → kolizje → diagnostyki) jest zachowany, znaki fizyczne, korekcje brzegowe i subcycling są prawidłowe. Kolizje (rotacja Eulera, typy zderzeń) są identyczne z kodem referencyjnym.

### Poprawność zrównoleglenia
- **numba_parallel**: Poprawna strategia thread-local buffers eliminuje data races. Jedyny problem fizyczny to podwójne losowanie prędkości atomów tła w kolizjach jonowych.
- **hybrid_parallel**: Poprawna architektura MPI + Numba z innowacyjnym ctypes MPI w JIT. Diagnostyki w trybie measurement są prawidłowo redukowane przez `reduce_diagnostics_mpi()` — wszystkie countery, tablice EEPF/IFED/XT i skalary energetyczne są sumowane z wszystkich ranków MPI przed zapisem. Jedyny potencjalny problem to portabilność ctypes MPI (OpenMPI vs MPICH).

### Optymalizacja
Największy zysk to mega-kernel JIT (eliminacja 4000 powrotów do Pythona). Główne pole do poprawy to redukcja alokacji pamięci buforów kolizyjnych (z `num_threads × MAX_N_P` na `num_threads × (MAX_N_P * 0.1)`).

---

*Dokument wygenerowany: 2026-08-01*
*Referencje: eduPIC v1.0 (Donko et al., PSST 30, 095017, 2021)*
