# Lekcja 8: Krok 9 — Diagnostyki XT: slicowanie 2D macierzy i big picture

> **Poprzednia lekcja:** [Lekcja 7 — Zderzenia Monte Carlo](lekcja_07.md)
> **To jest ostatnia lekcja kursu.**

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Jak tablice 2D kształtu `(N_G, N_XT)` są aktualizowane przez slice kolumnowy
- Jak `sim.pot_xt[:, t_index] += sim.pot` działa i co oznacza `[:, t_index]`
- Jak `sim.sigma[cs.E_ION, e_idx]` indeksuje tablicę 2D
- Jak wektoryzacja `max_electron_coll_freq` działa w `collisions.py`
- Jak wygląda pełna pętla `do_one_cycle` i co jest wektorowe a co nie

---

## 1. Krok 9 — zbieranie diagnostyk XT

```python
# numpy_version/simulation.py — step9_collect_xt_data

def step9_collect_xt_data(sim: SimulationState, t_index: int):
    if not sim.measurement_mode:
        return

    sim.pot_xt[:, t_index]    += sim.pot       # (1)
    sim.efield_xt[:, t_index] += sim.efield    # (2)
    sim.ne_xt[:, t_index]     += sim.e_density # (3)
    sim.ni_xt[:, t_index]     += sim.i_density # (4)
```

### Co to jest `[:, t_index]`?

`sim.pot_xt` ma kształt `(N_G, N_XT) = (400, 200)`.

```
pot_xt[wiersz, kolumna]
       ↑        ↑
       p      t_index
   (węzeł    (chwila
   siatki)    czasu)
```

`sim.pot_xt[:, t_index]`:
- `:` = "wszystkie wiersze" (0 do N_G-1 = 399)
- `t_index` = konkretna kolumna

Wynik: **wektor kolumnowy** kształtu `(N_G,) = (400,)` — gęstość/potencjał w jednej
chwili czasu dla wszystkich punktów siatki.

```python
sim.pot_xt[:, t_index] += sim.pot
```

Dodajemy wektor `sim.pot` (shape `(400,)`) do kolumny `t_index` tablicy 2D.
To jest **400 dodań** w C, zamiast pętli:

```python
# Native:
for p in range(cs.N_G):
    sim.pot_xt[p][t_index] += sim.pot[p]  # 400 iteracji Pythona

# NumPy:
sim.pot_xt[:, t_index] += sim.pot         # 1 operacja C
```

---

## 2. Indeksowanie 2D tablicy sigma: `sigma[typ, e_idx]`

W step3 (krok 3) widzieliśmy:

```python
rate = sim.sigma[cs.E_ION, e_idx] * np.sqrt(v_sqr) * cs.DT_E * cs.GAS_DENSITY
```

`sim.sigma` ma kształt `(N_CS, CS_RANGES) = (5, 1_000_000)`.

`sim.sigma[cs.E_ION, e_idx]`:
- `cs.E_ION = 2` → stały indeks wiersza (typ przekroju: jonizacja)
- `e_idx` → **tablica** indeksów kolumn shape `(N_e,)`

To jest **2D fancy indexing**: wybieramy wiersz 2 i kolumny podane przez `e_idx`.
Wynik: shape `(N_e,)` — przekrój czynny jonizacji dla każdego elektronu.

```python
# Odpowiednik pętli:
for k in range(N_e):
    sigma_k = sim.sigma[E_ION][energy_index[k]]

# NumPy:
sigma_all = sim.sigma[cs.E_ION, e_idx]   # to samo, ale wektorowo
```

---

## 3. Wektoryzacja w `collisions.py` — `max_electron_coll_freq`

```python
# collisions.py

def max_electron_coll_freq(sim: SimulationState) -> float:
    e = np.arange(cs.CS_RANGES, dtype=np.float64) * cs.DE_CS  # (A)
    v = np.sqrt(2.0 * e * cs.EV_TO_J / cs.E_MASS)             # (B)
    nu = v * sim.sigma_tot_e                                    # (C)
    return float(np.max(nu))                                    # (D)
```

### (A) Tablica energii

```python
e = np.arange(cs.CS_RANGES, dtype=np.float64) * cs.DE_CS
```

`np.arange(N)` → `[0, 1, 2, ..., N-1]` shape `(N,)`.
`* cs.DE_CS` → `[0, DE_CS, 2*DE_CS, ...]` — energii w eV dla każdego binu.

Native odpowiednik:
```python
e = [i * DE_CS for i in range(CS_RANGES)]  # lista, wolna
```

### (B) Prędkość dla każdej energii

```python
v = np.sqrt(2.0 * e * cs.EV_TO_J / cs.E_MASS)
```

`e` → `(CS_RANGES,)`, wynik `v` → `(CS_RANGES,)`. Wektorowe sqrt.

### (C) Częstość zderzeń

```python
nu = v * sim.sigma_tot_e
```

Obie tablice shape `(CS_RANGES,)` — mnożenie element po elemencie.

### (D) Maximum

```python
return float(np.max(nu))
```

`np.max(arr)` → skalar: maksimum ze wszystkich elementów.
`float(...)` → konwersja na Python float.

---

## 4. Pełna pętla `do_one_cycle` — co jest co

```python
# numpy_version/simulation.py — do_one_cycle

def do_one_cycle(sim: SimulationState, datafile_path: str = "conv.dat"):
    for t in range(cs.N_T):     # ← JEDYNA pętla Pythona (4000 iteracji)
        sim.Time += cs.DT_E
        t_index = t // cs.N_BIN

        step1_compute_electron_density(sim)      # WEKTOROWE
        step1_compute_ion_density(sim, t)        # WEKTOROWE (częściowo)
        step2_solve_poisson(sim)                  # WEKTOROWE + LAPACK
        step3_move_electrons(sim, t_index)       # WEKTOROWE
        step4_move_ions(sim, t_index, t)         # WEKTOROWE
        step5_check_boundaries_electrons(sim)    # WEKTOROWE
        step6_check_boundaries_ions(sim, t)      # WEKTOROWE
        step7_collisions_electrons(sim)          # HYBRYDA: wektor + ~5% skalar
        step8_collisions_ions(sim, t)            # HYBRYDA: wektor + ~5% skalar
        step9_collect_xt_data(sim, t_index)      # WEKTOROWE

        if (t % 1000) == 0:
            print(f" c = {sim.cycle}  ...")

    with open(datafile_path, "a") as f:
        f.write(f"{sim.cycle}  {sim.N_e}  {sim.N_i}\n")
```

Zewnętrzna pętla `for t in range(N_T)` — 4000 iteracji Pythona — jest nieunikniona,
bo kolejność kroków musi być zachowana (depozycja → Poisson → ruch → zderzenia → ...).

Ale **wewnątrz** każdego kroku: zero pętli Pythona (lub tylko ~5% cząstek).

### Co jest skalarne a co wektorowe?

```
Krok  1: WEKTOROWE  — depozycja (np.add.at)
Krok  2: WEKTOROWE  — Poisson (solve_banded) + E-field (slicowanie offsetowe)
Krok  3: WEKTOROWE  — ruch e⁻ (fancy indexing + widoki)
Krok  4: WEKTOROWE  — ruch Ar⁺ (co 20 kroków)
Krok  5: WEKTOROWE  — granice e⁻ (boolean masking)
Krok  6: WEKTOROWE  — granice Ar⁺ (boolean masking + IFED vectorized)
Krok  7: HYBRYDA    — selekcja zderzających się: wektorowe (np.where)
                       zderzenia: skalarne (collision_electron)
Krok  8: HYBRYDA    — selekcja: wektorowe; zderzenia: skalarne (collision_ion)
Krok  9: WEKTOROWE  — diagnostyki XT (slice 2D)
```

---

## 5. Zestawienie: native vs NumPy — cała symulacja

| Krok | Native | NumPy | Przyspieszenie |
|:-----|:-------|:------|:--------------|
| Depozycja e⁻ | Pętla N_e itr. Pythona | np.add.at | ~10–50× |
| Depozycja Ar⁺ | Pętla N_i itr. Pythona | np.add.at (co 20 kroków) | ~10–50× |
| rho = e(n_i-n_e) | Pętla N_G itr. | Wektorowe odejmowanie | ~400× |
| Solver Poissona | 3 pętle Pythona | solve_banded (LAPACK) | ~100× |
| Pole E | Pętla N_G itr. | Slicowanie offsetowe | ~400× |
| Ruch e⁻ | Pętla N_e itr. | Fancy indexing + widoki | ~10–50× |
| Ruch Ar⁺ | Pętla N_i itr. | Fancy indexing + widoki | ~10–50× |
| Granice e⁻ | While + swap | Boolean masking + filter | ~10–50× |
| Granice Ar⁺ | While + swap | Boolean masking + filter | ~10–50× |
| p_coll dla zderzenia | 1 exp w pętli | np.exp na (N_e,) | ~10–50× |
| Selekcja zderzających | Każdy: `if rnd < p_coll` | np.where | ~50× |
| Zderzenie per-cząstka | Pętla, ~5% cząstek | Pętla, ~5% (brak optym.) | 1× |
| Diagnostyki XT | Pętla N_G itr. | `+=` slice kolumnowy | ~400× |

---

## 6. Kiedy NumPy NIE jest szybsze?

Paradoksalnie, dla **małych tablic** NumPy może być wolniejszy niż czysty Python:

```python
# Dla N = 5 elementów:
a = [1.0, 2.0, 3.0, 4.0, 5.0]
b = [x * 2 for x in a]        # szybkie dla N=5

a = np.array([1., 2., 3., 4., 5.])
b = a * 2                      # overhead wywołania NumPy może dominować dla N=5
```

Dla symulacji PIC (N_e ~ 50 000):
- NumPy jest zdecydowanie szybszy
- Dla N < ~100, koszt overhead NumPy zaczyna dominować

---

## 7. Jak debugować kod NumPy?

```python
# Jeśli coś nie działa, zamień wektorowe na skalarne i porównaj:

# Wektorowo (NumPy):
c0 = x * cs.INV_DX
p = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)

# Skalarne (do debugowania):
for k in range(len(x)):
    c0_k = x[k] * cs.INV_DX
    p_k  = min(int(c0_k), cs.N_G - 2)
    assert p[k] == p_k, f"Mismatch at k={k}: {p[k]} != {p_k}"
```

Użyteczne narzędzia:
```python
print(arr.shape)          # kształt tablicy
print(arr.dtype)          # typ danych
print(arr.min(), arr.max())  # zakres wartości
print(np.isnan(arr).any())   # czy są NaN?
print(np.isinf(arr).any())   # czy są Inf?
```

---

## 8. Jak modyfikować kod NumPy?

### Zmiana parametru fizycznego

Tak samo jak w wersji Go — zmień stałą w `constants.py`:

```python
# constants.py
VOLTAGE: Final[float] = 250.0  # → zmień na 300.0
```

### Dodanie nowej diagnostyki — przykład

Chcemy śledzić maksymalną prędkość elektronów w każdym kroku.

1. Dodaj tablicę w `state.py`:
```python
self.max_vx_e = np.zeros(cs.N_T, dtype=np.float64)
```

2. Zbieraj w `step3_move_electrons`:
```python
# Po obliczeniu vx:
vx = sim.vx_e[:sim.N_e]
# Na końcu funkcji (przed vx -= ...):
sim.max_vx_e[t_index] = float(np.max(np.abs(vx)))
```

3. Zapisz w `io_manager.py` — analogicznie do innych plików wyjściowych.

### Zmiana schematu interpolacji (NGP zamiast CIC)

Nearest Grid Point — przypisz całą wagę do najbliższego węzła:

```python
# Zamiast:
p    = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
p_f  = p.astype(np.float64)
w_left  = p_f + 1.0 - c0
w_right = c0 - p_f
np.add.at(sim.e_density, p,     w_left  * cs.FACTOR_W)
np.add.at(sim.e_density, p + 1, w_right * cs.FACTOR_W)

# Użyj NGP (zaokrąglenie do najbliższego):
p_ngp = np.clip(np.round(c0).astype(np.int32), 0, cs.N_G - 1)
np.add.at(sim.e_density, p_ngp, cs.FACTOR_W)
# Korekcja brzegowa przestaje być potrzebna przy NGP
```

---

## Podsumowanie całego kursu

### Kluczowe wzorce NumPy w symulacji PIC

| Wzorzec | Gdzie używany | Dlaczego |
|:--------|:-------------|:---------|
| `arr[:N]` widok | Wszędzie (aktywne cząstki) | Bez kopiowania, in-place |
| `arr[:] = 0.0` | Zerowanie gęstości | In-place, nie tworzy nowej tablicy |
| `np.add.at` | Depozycja gęstości, diagnostyki | Bezpieczny scatter-add dla duplikatów |
| `arr[:-2] - arr[2:]` | Pole E (centralna różnica) | Przesunięte slicowanie |
| `arr[:, t_index] +=` | Diagnostyki XT | Slice kolumnowy 2D |
| `fancy_arr[idx_arr]` | Interpolacja E, sigma lookup | Gather z tablicy |
| `mask = arr < val` | Granice, EEPF centrum | Boolean mask |
| `arr[mask]` | Filtrowanie pochłoniętych | Fancy indexing z bool |
| `np.where(mask)[0]` | Selekcja zderzających | Indeksy True elementów |
| `rng.random(N)` | Zderzenia | N losowych naraz |
| `rng.normal(0,s,N)` | Atomy Ar | N normalnych naraz |
| `solve_banded` | Poisson | LAPACK solver w jednym wywołaniu |

### Hierarchia optymalizacji

```
NAJSZYBSZE:  solve_banded (LAPACK Fortran/C)
             np.add.at, fancy indexing, slicowanie
             np.exp, np.sqrt, np.where (wektorowe ufuncs)

POŚREDNIE:   collision_electron/ion (Python, ale ~5% cząstek)

NAJWOLNIEJSZE: pętla for t in range(N_T) (4000 it. Pythona — nieuniknione)
```

---

**Koniec kursu.**

Wróć do [spisu lekcji](README.md) jeśli potrzebujesz.

Kody źródłowe:
- NumPy: [`python/numpy_version/`](../../python/numpy_version/)
- Natywny Python: [`python/native_version/`](../../python/native_version/)
