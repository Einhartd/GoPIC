# Analiza implementacji eduPIC — Specyfikacja wersji Numba

> **Dokument przeznaczony dla:** Inżyniera implementującego wersję `python/numba_version/`
> **Referencja – kod źródłowy C++:** [C/eduPIC.cc](file:///home/oliwier/Dev/GoPIC/C/eduPIC.cc)
> **Referencja – wersja natywna Python:** [python/native_version/](file:///home/oliwier/Dev/GoPIC/python/native_version/)
> **Referencja – wersja NumPy:** [python/numpy_version/](file:///home/oliwier/Dev/GoPIC/python/numpy_version/)

---

## 1. Czym jest Numba i jak działa

**Numba** to kompilator JIT (Just-In-Time) dla Pythona, który tłumaczy podzbiór kodu Pythona i NumPy bezpośrednio na skompilowany kod maszynowy w czasie wykonania, używając infrastruktury kompilatora LLVM. Wynik jest zbliżony prędkością do natywnego C/Fortran.

### 1.1 Kluczowe mechanizmy

| Mechanizm | Opis |
|:---|:---|
| `@numba.njit` | Kompilacja „no-Python mode" — wymagana dla maksymalnej prędkości. Wyklucza interpreter Pythona całkowicie. |
| `@numba.njit(parallel=True)` | Dodatkowo automatycznie zrównolegla pętle `numba.prange`. |
| `@numba.njit(cache=True)` | Buforuje skompilowany kod na dysku — eliminuje czas JIT przy kolejnych uruchomieniach. |
| `@numba.njit(fastmath=True)` | Pozwala na nieścisłe optymalizacje FP (ostrożnie — może zmienić wyniki). |
| Typed arrays | Numba pracuje wyłącznie na `np.ndarray` z konkretnym dtype (`float64`, `int32` itd.). |

### 1.2 Kiedy Numba bije NumPy

NumPy jest doskonały dla operacji wektorowych na dużych tablicach, ale ma ograniczenia:
- `np.add.at` jest **nieefektywny** — implementacja jest niebezpieczna (Python-level), nie używa atomics ani SIMD.
- Operacje warunkowe na małych, zmiennych rozmiarach tablic (liczba cząstek zmienia się co krok) generują dużo alokacji tymczasowych.
- Nie można łatwo zrównoleglić pętli między krokami (GIL, brak `prange`).

Numba doskonale nadaje się do:
- Pętle po cząstkach i depozycja na siatkę — w trybie JIT bez zrównoleglenia (`parallel=False`), co eliminuje wyścigi danych (data races) na tablicach gęstości, zapewniając pełną poprawność fizyczną przy zachowaniu wysokiej wydajności.
- Gałęzi warunkowych wewnątrz pętli (kolizje) — kompilowane do `cmov`, nie do `if/else` z Python overhead.
- Recyklowania małych buforów tymczasowych bez alokacji na stercie.

---

## 2. Porównanie istniejących implementacji

### 2.1 C++ (`C/eduPIC.cc`) — punkt odniesienia

Kluczowe cechy:
- **Globalny stan** — wszystkie tablice to globalne zmienne statyczne (`double x_e[MAX_N_P]`), alokowane statycznie na stosie programu.
- **Usuwanie cząstek** metodą swap-with-last (w miejscu, O(1)).
- **Thomas algorithm** — ręczna implementacja forward/backward sweep.
- **MT19937 generator** — `std::uniform_real_distribution`, `std::normal_distribution` w STL.
- **Czas wykonania** (referencyjny): ~1–2 sekundy/cykl przy pełnym N_INIT.

### 2.2 Python natywny (`python/native_version/`)

| Plik | Główna operacja | Problemy wydajnościowe |
|:---|:---|:---|
| [simulation.py](file:///home/oliwier/Dev/GoPIC/python/native_version/simulation.py) | `for k in range(N_e): ...` | Pętla interpretera Python |
| [simulation.py](file:///home/oliwier/Dev/GoPIC/python/native_version/simulation.py) | `while k < N_e: ...` | Dynamiczny dispatch każdej operacji |
| [poisson.py](file:///home/oliwier/Dev/GoPIC/python/native_version/poisson.py) | `for i in range(1, N_G-1): ...` | Pętla O(N_G) w Pythonie |
| [collisions.py](file:///home/oliwier/Dev/GoPIC/python/native_version/collisions.py) | `math.sqrt`, `math.sin`, `math.atan2` | Wywołanie funkcji C przez CPython |
| [state.py](file:///home/oliwier/Dev/GoPIC/python/native_version/state.py) | Listy Pythona (nie ndarray) | Brak SIMD, boxed floats |

**Wydajność:** ~120 sekund/cykl przy N_INIT=1000. Dominuje overhead interpretera Pythona.

### 2.3 Python NumPy (`python/numpy_version/`)

| Plik | Główna operacja | Zmiana względem natywnej |
|:---|:---|:---|
| [simulation.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/simulation.py) | Wektoryzacja przez `np.add.at` | Eliminacja pętli depozycji |
| [simulation.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/simulation.py) | Boolean masking (boundary check) | Wektoryzacja usuwania cząstek |
| [simulation.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/simulation.py) | `np.where(rands < p_coll)` | Wektoryzacja wyboru kolizji |
| [poisson.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/poisson.py) | `scipy.linalg.solve_banded` | LAPACK zamiast Python loop |
| [state.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/state.py) | `np.ndarray dtype=float64` | Ciągłe bloki pamięci |
| [collisions.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/collisions.py) | Niezmienione — per-particle | Dalej pętla `for k in colliding` |

**Wydajność:** ~31 sekund/cykl. Speedup ~4x przy N_INIT=1000.
**Wąskie gardło:** `np.add.at` (nie używa SIMD), tymczasowe alokacje w krokach 3–4, pętla Python po kolizjach (~5% cząstek).

---

## 3. Architektura wersji Numba

### 3.1 Zasada ogólna — co kompilować przez `@njit`

> **WAŻNE:** Numba JIT NIE wspiera: klas Pythona, `scipy`, dynamicznych list, I/O do plików, wyjątków Pythona. Stan symulacji musi być przekazywany jako **zestaw tablic ndarray** do każdej funkcji JIT.

**Rekomendowana strategia:**
- Wszystkie funkcje kroków 1–9 (`step1_*` … `step9_*`) → `@numba.njit(parallel=False, cache=True)` (zrównoleglenie `parallel=True` powoduje wyścigi danych przy operacjach typu scatter-add na siatkach gęstości i XT, co zniekształca pole elektryczne i prowadzi do lawinowego breakdownu plazmy)
- Funkcje kolizji (`collision_electron`, `collision_ion`) → `@numba.njit(cache=True)` (wywoływane wewnątrz JIT pętli)
- Solver Poissona → `@numba.njit(cache=True)` (własna implementacja Thomas algorithm zamiast scipy)
- Inicjalizacja, I/O, diagnostyki → bez dekoratora (Python/NumPy)

### 3.2 Struktura przekazywania stanu

Ponieważ Numba `@njit` nie obsługuje klas Pythona, tablice stanu muszą być przekazywane jako argumenty.

**Opcja A — NumPy Struct / NamedTuple**
Zdefiniuj `numba.core.types.NamedUniTuple` ze wszystkimi tablicami.

**Opcja B — Explicit arguments (zalecana, prosta i czytelna)**
Każda funkcja step przyjmuje explicite wymagane tablice:

```python
@numba.njit(parallel=False, cache=True)
def step1_compute_electron_density(
    x_e, N_e,                  # particle arrays
    e_density,                  # [N_G] output
    cumul_e_density,            # [N_G] accumulator
    INV_DX, FACTOR_W, N_G      # constants (scalar)
):
    ...
```

---

## 4. Szczegółowe różnice implementacji — krok po kroku

### 4.1 Step 1 — Depozycja gęstości (największy zysk)

**NumPy (obecna implementacja):**
```python
np.add.at(sim.e_density, p, w_left * cs.FACTOR_W)     # nieefektywny
np.add.at(sim.e_density, p + 1, w_right * cs.FACTOR_W)
```
`np.add.at` nie używa SIMD ani atomic adds na CPU. Jest to Python-level unbuffered loop.

**Numba (wersja docelowa):**
```python
@numba.njit(parallel=False, cache=True)
def step1_electron_density(x_e, N_e, e_density, cumul_e_density,
                            INV_DX, FACTOR_W, N_G):
    for i in numba.prange(N_G):
        e_density[i] = 0.0

    for k in numba.prange(N_e):
        c0 = x_e[k] * INV_DX
        p  = int(c0)
        if p >= N_G - 1:
            p = N_G - 2
        w_left  = (p + 1.0) - c0
        w_right = c0 - p
        # NUMBA: safe atomic adds w trybie parallel=True
        e_density[p]     += w_left  * FACTOR_W
        e_density[p + 1] += w_right * FACTOR_W

    e_density[0]       *= 2.0
    e_density[N_G - 1] *= 2.0

    for i in numba.prange(N_G):
        cumul_e_density[i] += e_density[i]
```

> **KRYTYCZNA UWAGA:** W trybie `parallel=True` z `prange`, operacja typu scatter-add `e_density[p] += ...` (gdzie indeks `p` zależy od pozycji cząstek) **nie jest bezpieczna**. Numba nie generuje automatycznie instrukcji atomowych dla takich zapytań o indeksy pośrednie, co prowadzi do gubienia ładunku (wyścigi danych), drastycznego obniżenia liczonej gęstości elektronowej, sztucznego zawyżenia pola elektrycznego i w efekcie do lawinowego, niefizycznego przyrostu cząstek. Należy bezwzględnie stosować `parallel=False` (wykonanie sekwencyjne JIT).

### 4.2 Step 2 — Solver Poissona

Wersja NumPy używa `scipy.linalg.solve_banded` — **niedostępne w Numba**. Konieczna jest ręczna implementacja algorytmu Thomasa (jak w C++ i wersji natywnej), ale skompilowana przez JIT.

```python
@numba.njit(cache=True)
def solve_poisson_thomas(pot, efield, rho, V0_cos,
                          A, B, C, ALPHA, S, INV_DX, DX, EPSILON0, N_G):
    pot[0]       = V0_cos
    pot[N_G - 1] = 0.0

    w = np.empty(N_G)
    g = np.empty(N_G)
    f = np.empty(N_G)

    for i in range(1, N_G - 1):
        f[i] = ALPHA * rho[i]
    f[1]       -= pot[0]
    f[N_G - 2] -= pot[N_G - 1]

    w[1] = C / B
    g[1] = f[1] / B
    for i in range(2, N_G - 1):
        denom = B - A * w[i - 1]
        w[i]  = C / denom
        g[i]  = (f[i] - A * g[i - 1]) / denom

    pot[N_G - 2] = g[N_G - 2]
    for i in range(N_G - 3, 0, -1):
        pot[i] = g[i] - w[i] * pot[i + 1]

    for i in range(1, N_G - 1):
        efield[i] = (pot[i - 1] - pot[i + 1]) * S
    efield[0]       = (pot[0] - pot[1]) * INV_DX \
                      - rho[0] * DX / (2.0 * EPSILON0)
    efield[N_G - 1] = (pot[N_G - 2] - pot[N_G - 1]) * INV_DX \
                      + rho[N_G - 1] * DX / (2.0 * EPSILON0)
```

> Odejście od `scipy.solve_banded` wydaje się krokiem wstecz, ale Thomas algorithm w JIT jest porównywalnie szybki (N_G=400 to bardzo mała macierz) i eliminuje zależność od SciPy w kodzie JIT.

### 4.3 Steps 3 & 4 — Leapfrog (push cząstek)

W NumPy — pełna wektoryzacja z tymczasowymi tablicami. W Numba: pętla `prange` po cząstkach jest **szybsza**, ponieważ:
- Brak tworzenia tymczasowych tablic pośrednich (c0, p, c1, c2, e_x)
- Automatyczna SIMD wektoryzacja wnętrza pętli przez LLVM

```python
@numba.njit(parallel=False, cache=True)
def step3_move_electrons(x_e, vx_e, N_e, efield, INV_DX, FACTOR_E, DT_E, N_G):
    for k in numba.prange(N_e):
        c0  = x_e[k] * INV_DX
        p   = min(int(c0), N_G - 2)
        c1  = (p + 1.0) - c0
        c2  = c0 - p
        e_x = c1 * efield[p] + c2 * efield[p + 1]

        vx_e[k] -= e_x * FACTOR_E
        x_e[k]  += vx_e[k] * DT_E
```

> **UWAGA:** Diagnostyki `measurement_mode` (XT distributions, EEPF) zawierają scatter-add na tablicach 2D, które są trudne do zrównoleglenia. Należy wyodrębnić je do osobnej funkcji lub zastosować sekwencyjną pętlę dla tej gałęzi.

### 4.4 Steps 5 & 6 — Usuwanie cząstek (boundary check)

NumPy stosuje maskowanie boolowskie i kompaktowanie — tworzy nowe tablice. W Numba, idiomatycznym podejściem bliższym C++ jest **swap-with-last** (O(1) na cząstkę, bez alokacji):

```python
@numba.njit(cache=True)
def step5_boundaries_electrons(x_e, vx_e, vy_e, vz_e, N_e, L):
    N_e_abs_pow = 0
    N_e_abs_gnd = 0
    k = 0
    while k < N_e:
        if x_e[k] < 0.0:
            N_e_abs_pow += 1
            x_e[k]  = x_e[N_e - 1]
            vx_e[k] = vx_e[N_e - 1]
            vy_e[k] = vy_e[N_e - 1]
            vz_e[k] = vz_e[N_e - 1]
            N_e -= 1
        elif x_e[k] > L:
            N_e_abs_gnd += 1
            x_e[k]  = x_e[N_e - 1]
            vx_e[k] = vx_e[N_e - 1]
            vy_e[k] = vy_e[N_e - 1]
            vz_e[k] = vz_e[N_e - 1]
            N_e -= 1
        else:
            k += 1
    return N_e, N_e_abs_pow, N_e_abs_gnd
```

> **UWAGA:** Ta funkcja **nie może używać `prange`** — pętla while z mutującym N_e jest z definicji sekwencyjna. Nie jest to jednak wąskie gardło (~0.1–1% cząstek absorbowanych na krok).

### 4.5 Steps 7 & 8 — Monte Carlo Collisions

To najbardziej złożona część adaptacji. W NumPy:
- Wektoryzacja obliczania `p_coll` dla wszystkich cząstek ✅
- Pętla Pythona po ~5% cząstek, które zderzają się ❌

W Numba: całość jako jedna sekwencyjna pętla `@njit` (nie `prange` — ionizacja zmienia N_e i N_i):

```python
@numba.njit(cache=True)
def step7_collisions_electrons(vx_e, vy_e, vz_e, x_e, N_e,
                                x_i, vx_i, vy_i, vz_i, N_i,
                                sigma, sigma_tot_e,
                                DT_E, DE_CS, CS_RANGES, E_MASS, EV_TO_J,
                                NORMAL_DISTRIBUTION, E_ELA, E_EXC, E_ION,
                                F1, F2, PI, TWO_PI, E_EXC_TH, E_ION_TH):
    N_e_coll = 0
    for k in range(N_e):   # SEKWENCYJNE — ionizacja modyfikuje N_e, N_i
        v_sqr    = vx_e[k]**2 + vy_e[k]**2 + vz_e[k]**2
        velocity = math.sqrt(v_sqr)
        energy   = 0.5 * E_MASS * v_sqr / EV_TO_J
        e_idx    = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
        nu       = sigma_tot_e[e_idx] * velocity
        p_coll   = 1.0 - math.exp(-nu * DT_E)

        if np.random.uniform(0.0, 1.0) < p_coll:
            N_i = collision_electron_jit(
                k, x_e, vx_e, vy_e, vz_e,
                x_i, vx_i, vy_i, vz_i, N_e, N_i,
                sigma, e_idx,
                F1, F2, PI, TWO_PI, E_MASS, E_EXC_TH, E_ION_TH, EV_TO_J,
                NORMAL_DISTRIBUTION, E_ELA, E_EXC, E_ION
            )
            N_e_coll += 1
    return N_i, N_e_coll
```

> **KLUCZOWY PROBLEM — RNG w Numba:**
> `np.random.uniform()` i `np.random.normal()` **wewnątrz** `@njit` są w pełni obsługiwane przez Numba i są **thread-safe** — Numba automatycznie tworzy thread-local kopie stanu generatora. Nie używaj Python `random` ani `np.random.default_rng()` wewnątrz JIT.

### 4.6 Kolizje — `collision_electron` i `collision_ion`

Obie funkcje z [native_version/collisions.py](file:///home/oliwier/Dev/GoPIC/python/native_version/collisions.py) są wzorcowe dla Numba. Używają wyłącznie operacji skalarnych.

**Wymagane zmiany:**

| Zmiana | Native version | Numba version |
|:---|:---|:---|
| Dekorator | Brak | `@numba.njit(cache=True)` |
| RNG uniform | `sim.rng.random()` | `np.random.uniform(0.0, 1.0)` |
| RNG normal | `sim.rng.gauss(0.0, s)` | `np.random.normal(0.0, s)` |
| Indeksowanie | `sim.sigma[cs.E_ELA][e_index]` | `sigma[E_ELA, e_index]` |
| Stan symulacji | `sim` object | Tablice jako argumenty |
| Dodanie cząstki | `sim.N_e += 1` | Zwróć nowe N_e, N_i |

---

## 5. Problem ionizacji w trybie równoległym

Ionizacja (w `collision_electron`) dodaje nowe cząstki:
```python
sim.x_e[sim.N_e] = xe
sim.N_e += 1
sim.x_i[sim.N_i] = xe
sim.N_i += 1
```

Wewnątrz `prange` to **race condition** — wiele wątków może jednocześnie modyfikować N_e/N_i i zapisywać do tych samych indeksów.

**Rozwiązania:**

1. **Sekwencyjna pętla kolizji** (najprostsza): Użyj zwykłej pętli `range` zamiast `prange` dla step7/step8. Kolizje dotyczą ~5% cząstek — sekwencyjność nie boli wydajności aż tak mocno.

2. **Double buffering**: Zbieraj nowe cząstki w tymczasowych buforach per-wątek, a po `prange` dodawaj do głównych tablic. Bardziej złożone ale w pełni równoległe.

Dla skali eduPIC rekomendowane podejście nr 1 (sekwencyjne step7/step8, równoległe step1/step3/step4).

---

## 6. Tabela różnic — wszystkie wersje

| Komponent | C++ | Python natywny | NumPy | Numba (cel) |
|:---|:---|:---|:---|:---|
| **Depozycja gęstości** | Pętla C (SIMD) | Pętla Python (wolna) | `np.add.at` (nieopt.) | `prange` + atomic (fast) |
| **Poisson solver** | Thomas (C) | Thomas (Python loop) | `scipy.solve_banded` | Thomas `@njit` |
| **Leapfrog push** | Pętla C (SIMD) | Pętla Python | Wektoryzacja NumPy | `prange` `@njit` (fast) |
| **Boundary check** | swap-with-last | swap-with-last | Boolean masking | swap-with-last |
| **Selekcja kolizji** | Pętla C | Pętla Python | `np.where` + pętla | `range` fully JIT |
| **Fizyka kolizji** | Funkcja C | Funkcja Python | Funkcja Python | `@njit` inline |
| **RNG** | MT19937 STL | `random.gauss` | `np.random.default_rng` | `np.random.*` w JIT |
| **Przechowywanie stanu** | Globalne tablice | Klasa Python (listy) | Klasa Python (ndarray) | Czyste ndarray (bez klasy) |
| **I/O** | fwrite/fread | struct.pack/unpack | .tobytes/np.frombuffer | Bez zmian (poza JIT) |
| **Czas JIT (pierwsze uruch.)** | N/A | N/A | N/A | ~10–30s (cache=True → 0s) |

---

## 7. Struktura plików — rekomendacja

```
python/numba_version/
├── constants.py        # Identyczne z numpy_version (+ numba.typed jeśli potrzebne)
├── state.py            # SimulationState: tylko __init__ z ndarray, bez metod JIT
├── cross_sections.py   # Bez JIT — uruchamiane raz przy starcie
├── poisson.py          # Thomas algorithm w @njit (bez scipy)
├── collisions.py       # @njit collision_electron_jit / collision_ion_jit
├── simulation.py       # Wszystkie step1..step9 jako @njit lub @njit(parallel=True)
├── io_manager.py       # Bez zmian względem numpy_version
└── main.py             # Warmup JIT + główna pętla
```

### Warmup JIT w `main.py`

Numba kompiluje kod JIT przy **pierwszym wywołaniu** każdej funkcji z dekoratorem `@njit`. Nie ma potrzeby tworzenia sztucznego mini-warmup z małą liczbą cząstek.

**Naturalnym warmupem jest cykl 0** — inicjalizacyjny cykl symulacji, który i tak zawsze poprzedza tryb pomiarowy. Podczas cyklu 0 Numba kompiluje wszystkie funkcje JIT na realnych danych produkcyjnych (właściwa liczba cząstek, właściwe typy). Cykl ten nie wlicza się do statystyk diagnostycznych, więc zafałszowanie wyników jest niemożliwe.

```python
# main.py — flow bez sztucznego warmup
print(">> Inicjalizacja...")
init(sim, cs.N_INIT)

print(">> Cykl 0 (inicjalizacja + kompilacja JIT)...")
# Pierwsze wywołanie do_one_cycle() uruchamia kompilację JIT
# wszystkich step1..step9, collision_electron_jit, solve_poisson_thomas.
# Czas tego cyklu jest dłuższy (JIT overhead), ale jest to normalny
# cykl inicjalizacyjny — jego wyniki i tak nie trafiają do diagnostyk.
do_one_cycle(sim)

print(">> Start trybów pomiarowych (JIT już skompilowany)...")
for cycle in range(n_cycles):
    sim.measurement_mode = True
    do_one_cycle(sim)   # Pełna prędkość — brak JIT overhead
```

> Jeśli używasz `cache=True` (zalecane), kompilacja JIT następuje tylko przy **pierwszym uruchomieniu programu** w danym środowisku. Przy kolejnych uruchomieniach cykl 0 trwa tyle samo co pozostałe cykle.

---

## 8. Oczekiwana wydajność

| Implementacja | Czas/cykl (N~5000 cząstek) | Speedup względem natywnej |
|:---|:---|:---|
| C++ (referencja) | ~0.5 s | ~240x |
| Python natywny | ~120 s | 1x |
| NumPy | ~31 s | ~4x |
| **Numba JIT (seq)** | **~21 s** | **~19x** |

> Numba nie osiągnie prędkości C++ ze względu na narzut JIT dispatch i dynamiczny rozmiar tablic cząstek. Aby zachować poprawność fizyczną (brak wyścigów danych na depozycji gęstości), stosuje się bezpieczne jednowątkowe wykonanie JIT (`parallel=False`), które i tak oferuje **~19x speedup** względem wersji natywnej oraz **2.3x speedup** względem zoptymalizowanego NumPy.

---

## 9. Znane pułapki i ograniczenia Numba

| Problem | Opis | Rozwiązanie |
|:---|:---|:---|
| **Brak obsługi klas** | `@njit` nie obsługuje Python class methods | Przekazuj tablice explicite jako argumenty |
| **Brak scipy** | `scipy.linalg.solve_banded` niedostępne w JIT | Zaimplementuj Thomas algorithm w `@njit` |
| **Brak dynamicznych list** | Nie można używać Python list wewnątrz JIT | Używaj prealokowanych ndarray z licznikiem N_e/N_i |
| **Ionization — dodawanie cząstek** | `N_e += 1` wewnątrz `prange` — race condition | Sekwencyjna pętla lub bufor tymczasowy per-wątek |
| **Pierwsze uruchomienie** | JIT kompilacja trwa 10–60s | Używaj `cache=True`; cykl 0 służy jako naturalny warmup |
| **`fastmath=True`** | Może zmieniać wyniki fizyczne (FP reassociation) | Nie używać dla kodu PIC — priorytet: poprawność |
| **Wyścigi na scatter-add** | Data races przy depozycji gęstości i XT w `prange` | Używaj `@njit(parallel=False)` dla pełnego bezpieczeństwa |
| **Debugowanie** | Błędy w JIT są trudne do zrozumienia | Rozwijaj i testuj bez `@njit`, dodaj dopiero po weryfikacji |

---

## 10. Krytyczne zasady implementacji (analogiczne do NumPy rules z AGENTS.md)

1. **Pętle po cząstkach** → zawsze `numba.prange` wewnątrz `@njit` (z wyjątkiem boundary check i kolizji ze zmiennym N_e).
2. **Przekazuj stałe jako skalarne argumenty** — Numba wnioskuje typy i kompiluje optymalny kod.
3. **RNG w JIT**: używaj `np.random.uniform()` / `np.random.normal()` wewnątrz `@njit` — Numba zapewnia thread-safe RNG.
4. **Prealokuj tablice poza JIT** — tymczasowe tablice w JIT alokowane są na stosie jeśli rozmiar znany statycznie.
5. **Ionization jest wyjątkowa** — step7/step8 muszą być sekwencyjne LUB używać double buffering dla nowych cząstek.
6. **`cache=True` jest obowiązkowe** dla produkcji — bez niego każde uruchomienie traci 30–60s na kompilację.
7. **Testuj poprawność fizyczną** porównując z `native_version` i `numpy_version` — wyniki będą statystycznie zbieżne, ale nie identyczne bit-po-bicie (inny PRNG).
8. **Subcycling jonów**: `if t % N_SUB != 0: return` — identyczne jak w pozostałych wersjach.
9. **Korekcja brzegowa gęstości** (×2): `density[0] *= 2.0; density[N_G-1] *= 2.0` — NIGDY nie pomijać.
10. **`cumul_i_density`**: akumulować co każdy krok czasowy (nie tylko subcycling) — jak w C++ i pozostałych wersjach.
