# Plan Implementacji — eduPIC NumPy Version

> **Rola**: Architekt kodu / Planer implementacji  
> **Data**: 25 Czerwca 2026  
> **Cel**: Reimplementacja natywnej wersji Python (`native_version/`) przy użyciu biblioteki **NumPy** w celu uzyskania istotnego przyspieszenia obliczeniowego.

---

## 1. Diagnoza Problemu Wydajnościowego w Wersji Natywnej

Obecna natywna implementacja Pythona odwzorowuje pętle C++ jeden-do-jednego, ale Python jest językiem interpretowanym z dużym narzutem na każdą operację w pętli. Kluczowe "gorące" miejsca kodu (`hot paths`) to:

| Krok | Operacja | Bottleneck |
|:-----|:---------|:-----------|
| **Step 1** | Depozycja gęstości (pętla po $N_e$, $N_i$ cząstkach) | Pętla Python po ~10k-100k cząstek, każda iteracja = wysoki overhead |
| **Step 2** | Solver Poissona (Thomas algorithm, pętla po $N_G=400$ punktach) | Pętla Python po 400 elementach (2× na krok) |
| **Step 3/4** | Push cząstek (pętla po $N_e$, $N_i$) + interpolacja pola | Identyczny bottleneck jak Step 1 |
| **Step 5/6** | Sprawdzanie granic | Pętla `while k < N_e` — bardzo wolna w Python |
| **Step 7/8** | Kolizje MCC (pętla po $N_e$, $N_i$) | Losowanie + `math.exp()` per cząstka |
| **Step 9** | Zbieranie danych XT (pętla po $N_G$) | Pętla w trybie pomiarowym |

### Szacunkowe możliwe przyspieszenie

Pętle po cząstkach ($N_e$, $N_i$ — typowo 20k–100k elementów) w czystym Pythonie są **100–1000× wolniejsze** niż ekwiwalentny kod C lub NumPy. Przejście na NumPy może dać **20–100× przyspieszenie** dla tej klasy obliczeń.

---

## 2. Kluczowa Zmiana Architektury: "Structure of Arrays" (SoA)

### 2a. Natywna wersja (obecna)
Cząstki są przechowywane w 4 oddzielnych listach Python (`list[float]`) z preallokowanym rozmiarem `MAX_N_P = 1_000_000`:
```python
self.x_e  = [0.0] * MAX_N_P   # 1M elementów Python float
self.vx_e = [0.0] * MAX_N_P
self.vy_e = [0.0] * MAX_N_P
self.vz_e = [0.0] * MAX_N_P
```
Dostęp indeksem i pętle `for k in range(N_e)` są powolne.

### 2b. Wersja NumPy (planowana)
Cząstki przechowywane w ciągłych tablicach `np.ndarray` dtype=`float64`. **Kluczowa różnica**: zamiast preallokować pełny milion elementów, używamy tylko aktywnego slices `[:N_e]`:
```python
self.x_e  = np.empty(MAX_N_P, dtype=np.float64)
self.vx_e = np.empty(MAX_N_P, dtype=np.float64)
self.vy_e = np.empty(MAX_N_P, dtype=np.float64)
self.vz_e = np.empty(MAX_N_P, dtype=np.float64)
```

**Wszystkie operacje wykonywane na widokach `[:N_e]`** — NumPy wektoryzuje je w skompilowanym C.

---

## 3. Plan Pliku po Pliku

### 3.1. `constants.py` (bez zmian, kopiuj z native)

Stałe fizyczne i parametry symulacji pozostają identyczne. Dodać tylko importy NumPy i zmienić type aliases:

```python
import numpy as np
# Zamiast type aliases dla list:
particle_dtype = np.float64
grid_dtype     = np.float64
```

---

### 3.2. `state.py` — Zamiana list → `np.ndarray`

**Cel**: Wszystkie tablice cząstek i siatki stają się tablicami NumPy.

#### Zmiana 1: Cząstki

| Przed (native) | Po (numpy) | Uzasadnienie |
|:---|:---|:---|
| `[0.0] * MAX_N_P` | `np.empty(MAX_N_P, dtype=np.float64)` | `np.empty` jest szybsze (brak inicjalizacji), dane są zawsze nadpisywane przy dodawaniu cząstek |
| `list[float]` | `np.ndarray` | Dostęp do slices i wektoryzacja |

#### Zmiana 2: Siatka

| Przed | Po |
|:---|:---|
| `[0.0] * N_G` | `np.zeros(N_G, dtype=np.float64)` |
| `[[0.0]*N_XT for _ in range(N_G)]` | `np.zeros((N_G, N_XT), dtype=np.float64)` |

**Zysk wydajnościowy**: Samo przejście na NumPy ndarray zamiast list przyspiesza operacje elementarne ~5–10×, bo eliminuje boxing/unboxing Python floats.

---

### 3.3. `step1_compute_densities.py` — Wektoryzacja depozycji ładunku

To **najbardziej krytyczny** krok do wektoryzacji.

#### Obecny kod (native):
```python
for k in range(sim.N_e):       # pętla Python po cząstkach!
    c0 = sim.x_e[k] * INV_DX
    p  = int(c0)
    sim.e_density[p]   += (p + 1.0 - c0) * FACTOR_W
    sim.e_density[p+1] += (c0 - p) * FACTOR_W
```

#### Planowany kod (numpy):
```python
def step1_compute_electron_density(sim):
    x = sim.x_e[:sim.N_e]             # widok aktywnych cząstek
    c0 = x * INV_DX                   # (N_e,) vectorized
    p  = c0.astype(np.int32)          # indeksy lewych węzłów
    w_left  = p + 1.0 - c0            # waga na węzeł lewy
    w_right = c0 - p                  # waga na węzeł prawy

    # np.add.at to scatter-add — poprawna suma gdy wiele cząstek trafia na ten sam węzeł
    sim.e_density[:] = 0.0
    np.add.at(sim.e_density, p,     w_left  * FACTOR_W)
    np.add.at(sim.e_density, p + 1, w_right * FACTOR_W)

    sim.e_density[0]     *= 2.0       # korekcja granic
    sim.e_density[N_G-1] *= 2.0
    sim.cumul_e_density  += sim.e_density
```

> **Dlaczego `np.add.at`?** Zwykłe `sim.e_density[p] += ...` nie działa poprawnie gdy wiele cząstek wskazuje na ten sam indeks (problem z duplikatami). `np.add.at` jest bezpieczną scatter-add operacją. Dla dużych $N_e$ (>50k) warto rozważyć `np.bincount` jako alternatywę — jest często 2–5× szybsze niż `np.add.at`.

**⚡ Szacowane przyspieszenie**: **20–50×** dla tego kroku.

---

### 3.4. `poisson.py` — Solver Thomasa z `scipy.linalg.solve_banded`

#### Obecny kod: ręczna pętla
```python
for i in range(2, N_G - 1):
    w[i] = C / (B - A * w[i-1])
    g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1])
```

#### Planowana zmiana: `scipy.linalg.solve_banded`

```python
from scipy.linalg import solve_banded

# Tridiagonalna macierz (stała — obliczana raz przy inicjalizacji!)
# Format banded: (n_subdiag, n_superdiag)
# Macierz układu jest stała, więc można przechować faktoryzację LU raz.

def build_thomas_matrix():
    # Stała macierz trójdiagonalna N_G-2 x N_G-2
    ab = np.zeros((3, N_G - 2), dtype=np.float64)
    ab[0, 1:] = A   # superdiagonala
    ab[1, :]  = B   # diagonala główna
    ab[2, :-1] = C  # subdiagonala
    return ab

# W solve_poisson:
def step2_solve_poisson(sim, rho, tt):
    sim.pot[0]    = VOLTAGE * np.cos(OMEGA * tt)
    sim.pot[N_G-1] = 0.0
    f = ALPHA * rho[1:-1]
    f[0]  -= sim.pot[0]
    f[-1] -= sim.pot[-1]
    sim.pot[1:-1] = solve_banded((1, 1), sim._thomas_ab, f)
    # pole elektryczne wektorowo:
    sim.efield[1:-1] = (sim.pot[:-2] - sim.pot[2:]) * S
    sim.efield[0]    = (sim.pot[0] - sim.pot[1]) * INV_DX - rho[0] * DX / (2.0 * EPSILON0)
    sim.efield[-1]   = (sim.pot[-2] - sim.pot[-1]) * INV_DX + rho[-1] * DX / (2.0 * EPSILON0)
```

**Zyski**:
- Solver `solve_banded` jest zaimplementowany w C (LAPACK) — znacząco szybszy niż pętla Python.
- Obliczanie pola elektrycznego `efield[1:-1]` jedną linią NumPy zamiast pętli po 400 elementach.

**⚡ Szacowane przyspieszenie**: **5–15×** dla tego kroku.

---

### 3.5. `step3_step4_move_particles.py` — Wektoryzowany push cząstek

#### Push elektronów (wektoryzacja):
```python
def step3_move_electrons(sim, t_index):
    x  = sim.x_e[:sim.N_e]
    vx = sim.vx_e[:sim.N_e]
    vy = sim.vy_e[:sim.N_e]
    vz = sim.vz_e[:sim.N_e]

    c0 = x * INV_DX
    p  = c0.astype(np.int32)
    c1 = p + 1.0 - c0
    c2 = c0 - p.astype(np.float64)

    # Interpolacja pola na pozycje cząstek — w pełni wektoryzowana
    e_x = c1 * sim.efield[p] + c2 * sim.efield[p + 1]

    # Aktualizacja prędkości i pozycji
    vx -= e_x * FACTOR_E
    x  += vx  * DT_E
```

Pomiary diagnostyczne (`ue_xt`, `counter_e_xt` itp.) w trybie `measurement_mode` muszą używać `np.add.at` tak samo jak krok depozycji.

**⚡ Szacowane przyspieszenie**: **30–80×** dla ruchu cząstek.

---

### 3.6. `step5_step6_boundaries.py` — Wektoryzowane warunki brzegowe

To najtrudniejszy krok do wektoryzacji ze względu na dynamiczne usuwanie cząstek.

#### Strategia: Boolean masking zamiast pętli `while`

```python
def step5_check_boundaries_electrons(sim):
    x  = sim.x_e[:sim.N_e]

    # Maski cząstek poza siatką
    mask_pow = x < 0
    mask_gnd = x > L
    mask_out = mask_pow | mask_gnd

    # Aktualizacja liczników
    sim.N_e_abs_pow += int(np.sum(mask_pow))
    sim.N_e_abs_gnd += int(np.sum(mask_gnd))

    # Usunięcie cząstek: zachowaj tylko te z mask_out == False
    mask_keep = ~mask_out
    n_keep = int(np.sum(mask_keep))

    sim.x_e[:n_keep]  = sim.x_e[:sim.N_e][mask_keep]
    sim.vx_e[:n_keep] = sim.vx_e[:sim.N_e][mask_keep]
    sim.vy_e[:n_keep] = sim.vy_e[:sim.N_e][mask_keep]
    sim.vz_e[:n_keep] = sim.vz_e[:sim.N_e][mask_keep]
    sim.N_e = n_keep
```

> **Uwaga**: Ta metoda kopiuje dane cząstek (nie modyfikuje ich w miejscu jak C++). Jest to akceptowalne dla NumPy, gdzie operacje wektorowe na tablicach są szybkie. Dla jonów dodatkowe zbieranie IFED energii robimy przez `np.bincount`.

**⚡ Szacowane przyspieszenie**: **50–100×** dla eliminacji pętli `while`.

---

### 3.7. `step7_step8_collisions.py` — Częściowa wektoryzacja MCC

Kolizje są najtrudniejsze do wektoryzacji ze względu na:
- Losowe decyzje per cząstka (różne gałęzie: elastic/excitation/ionization).
- Dynamiczne dodawanie nowych cząstek (jonizacja).

#### Strategia: "Batch null-collision" + per-particle handling tylko dla kolizji

**Faza 1 — Wektoryzacja selekcji cząstek zderzających się:**
```python
def step7_collisions_electrons(sim):
    x  = sim.x_e[:sim.N_e]
    vx = sim.vx_e[:sim.N_e]
    vy = sim.vy_e[:sim.N_e]
    vz = sim.vz_e[:sim.N_e]

    v_sqr    = vx**2 + vy**2 + vz**2            # (N_e,) vectorized
    velocity = np.sqrt(v_sqr)                    # (N_e,)
    energy   = 0.5 * E_MASS * v_sqr / EV_TO_J   # (N_e,)

    e_idx = np.minimum(
        (energy / DE_CS + 0.5).astype(np.int32),
        CS_RANGES - 1
    )

    nu     = sim.sigma_tot_e[e_idx] * velocity  # fancy indexing — (N_e,)
    p_coll = 1.0 - np.exp(-nu * DT_E)           # (N_e,)

    rands = np.random.random(sim.N_e)
    colliding = np.where(rands < p_coll)[0]     # indeksy cząstek, które kolidują
```

**Faza 2 — Pętla Python tylko po cząstkach, które kolidują:**
```python
    # Typowo <5% cząstek kolizjonuje w jednym kroku — ta pętla jest krótka!
    for k in colliding:
        collision_electron(sim, k, int(e_idx[k]))
```

> **Kluczowa obserwacja**: Przy prawdopodobieństwie kolizji $P_{coll} < 0.05$ (warunek stabilności!), co najwyżej 5% cząstek kolizjonuje. Pętla Python dotyczy zatem tylko ~5% $N_e$ cząstek zamiast 100% — to **20×** redukcja kosztów pętlowania.

**⚡ Szacowane przyspieszenie**: **15–30×** dla całego kroku.

---

### 3.8. `step9_collect_xt_data.py` — Wektoryzowane zbieranie diagnostyk

```python
def step9_collect_xt_data(sim, t_index):
    if not sim.measurement_mode:
        return
    sim.pot_xt[:, t_index]    += sim.pot
    sim.efield_xt[:, t_index] += sim.efield
    sim.ne_xt[:, t_index]     += sim.e_density
    sim.ni_xt[:, t_index]     += sim.i_density
```

To zastępuje pętlę `for p in range(N_G)` — prosta operacja kolumnowa na tablicy 2D.

**⚡ Szacowane przyspieszenie**: **10–20×** dla trybu pomiarowego.

---

## 4. Proponowana Struktura Plików `numpy_version/`

```
python/numpy_version/
├── constants.py          # Identyczne ze stałymi native, + import numpy as np
├── state.py              # SimulationState z np.ndarray zamiast list
├── cross_sections.py     # Zbieranie przekrojów — wektoryzacja generowania tablic
├── poisson.py            # solve_banded + wektoryzowane E-field
├── simulation.py         # do_one_cycle + step1..step9 (wektoryzowane)
├── collisions.py         # collision_electron/ion — pozostają skalarne (single particle)
├── io_manager.py         # Kopiuj z native (bez zmian)
├── main.py               # Kopiuj z native (bez zmian)
└── IMPLEMENTATION_PLAN.md  # Ten dokument
```

> **Uwaga**: `collisions.py` (funkcje `collision_electron` i `collision_ion`) pozostają w formie skalarnej. Są wywoływane tylko dla cząstek, które kolidują (~5%), więc ich wektoryzacja nie jest priorytetem.

---

## 5. Podsumowanie Spodziewanego Przyspieszenia

| Krok | Metoda wektoryzacji | Spodziewane przyspieszenie |
|:-----|:--------------------|:---------------------------|
| **Step 1** — Depozycja gęstości | `np.add.at` / `np.bincount` | **20–50×** |
| **Step 2** — Solver Poissona | `scipy.linalg.solve_banded` | **5–15×** |
| **Step 3/4** — Push cząstek | Operacje tablicowe NumPy | **30–80×** |
| **Step 5/6** — Granice | Boolean masking | **50–100×** |
| **Step 7/8** — Kolizje MCC | Wektoryzowana selekcja + pętla po ~5% | **15–30×** |
| **Step 9** — Diagnostyki XT | Operacje kolumnowe na 2D ndarray | **10–20×** |
| **Overall** | Ważona średnia po czasie CPU | **~20–60×** |

---

## 6. Kolejność Implementacji (Priorytetyzacja)

1. **`state.py`** — zmiana na `np.ndarray` (fundament wszystkiego, bez tego nic nie działa)
2. **`step1` (depozycja)** — największy zysk, stosunkowo prosta wektoryzacja
3. **`step3/4` (push cząstek)** — drugi co do ważności bottleneck
4. **`step5/6` (granice)** — prosta koncepcja, boolean masking
5. **`poisson.py`** — integracja `solve_banded`
6. **`step7/8` (kolizje)** — najtrudniejszy krok, na końcu
7. **`step9` (diagnostyki)** — proste, na końcu

---

## 7. Ważne Ostrzeżenia Fizyczne

> [!CAUTION]
> `np.add.at` jest poprawne ale wolniejsze niż `np.bincount` dla gęstych przypadków. Sprawdź, która metoda jest szybsza dla typowych rozmiarów cząstek w tej symulacji (~ 10k–100k).

> [!WARNING]
> Zmiana kolejności operacji w `step5` (kopiowanie całych tablic zamiast in-place swap) może zwiększyć zużycie pamięci przy dużych populacjach cząstek. Monitoruj peak memory.

> [!IMPORTANT]
> Wyniki fizyczne (energie, gęstości, EEPF) NumPy version i native version **muszą być identyczne** dla tego samego seedu RNG. Zaimplementuj testy porównawcze zanim uznasz implementację za poprawną.
