# Lekcja 7: Krok 7 & 8 — Zderzenia Monte Carlo: `np.where` + pętla po ~5%

> **Poprzednia lekcja:** [Lekcja 6 — Warunki brzegowe](lekcja_06.md)
> **Następna lekcja:** [Lekcja 8 — Diagnostyki XT](lekcja_08.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Jaka jest architektura "hybrydowa" w wersji NumPy: wektorowe selekcja + skalarne zderzenia
- Jak `np.where` wyłuskuje indeksy cząstek do zderzenia
- Dlaczego funkcja `collision_electron` jest skalarna (nie wektorowa)
- Jak `rng.normal(0, sigma, N)` zastępuje pętlę po jonach
- Jak `sim.sigma[E_ION, e_idx]` łączy fancy indexing 2D

---

## 1. Architektura "hybrydowa" — kluczowy wybór projektowy

Zderzenia są **najtrudniejszą częścią** do wektoryzacji. Problem:

1. **Selekcja cząstek do zderzenia** — prosta, wektorowalna: oblicz p_coll dla wszystkich
2. **Samo zderzenie** — złożona logika rozgałęzień (typ zderzenia, kąty Eulera, jonizacja) — trudna do wektoryzacji

Rozwiązanie w wersji NumPy: **hybryda**:
```
WEKTOROWE:  oblicz p_coll dla wszystkich N_e cząstek
WEKTOROWE:  wylosuj N_e liczb losowych
WEKTOROWE:  znajdź kto się zderza (np.where)
SKALARNE:   dla ~5% zderzających cząstek: wywołaj collision_electron(sim, k, e_idx)
```

Dlaczego tak? Bo ~95% cząstek NIE zderza się. Wektoryzacja selekcji eliminuje
pętle Pythona dla 95% cząstek. Zderzenia per-cząstka (skalarny kod) dotyczą tylko ~5%.

---

## 2. Wersja natywna — pętla po wszystkich

```python
# native_version/simulation.py — step7_collisions_electrons

k = 0
while k < sim.N_e:
    v_sqr    = sim.vx_e[k]**2 + sim.vy_e[k]**2 + sim.vz_e[k]**2
    velocity = math.sqrt(v_sqr)
    energy   = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J
    energy_index = min(int(energy / cs.DE_CS + 0.5), cs.CS_RANGES - 1)
    nu     = sim.sigma_tot_e[energy_index] * velocity
    p_coll = 1.0 - math.exp(-nu * cs.DT_E)
    if sim.rng.random() < p_coll:
        collisions.collision_electron(sim, k, energy_index)
        sim.N_e_coll += 1
    k += 1
```

N_e iteracji Python na każdy krok — jeśli N_e = 50 000, to 50 000 wywołań `math.sqrt`,
`math.exp`, `rng.random()` etc.

---

## 3. Wersja NumPy — krok po kroku

```python
# numpy_version/simulation.py — step7_collisions_electrons

def step7_collisions_electrons(sim: SimulationState):
    vx = sim.vx_e[:sim.N_e]     # (1) widoki
    vy = sim.vy_e[:sim.N_e]
    vz = sim.vz_e[:sim.N_e]

    v_sqr    = vx**2 + vy**2 + vz**2              # (2)
    velocity = np.sqrt(v_sqr)                      # (3)
    energy   = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J  # (4)
    e_idx    = np.minimum(                         # (5)
        (energy / cs.DE_CS + 0.5).astype(np.int32),
        cs.CS_RANGES - 1
    )

    nu     = sim.sigma_tot_e[e_idx] * velocity     # (6)
    p_coll = 1.0 - np.exp(-nu * cs.DT_E)          # (7)

    rands     = sim.rng.random(sim.N_e)            # (8)
    colliding = np.where(rands < p_coll)[0]        # (9)

    for k in colliding:                            # (10) pętla tylko po ~5%
        collisions.collision_electron(sim, int(k), int(e_idx[k]))
        sim.N_e_coll += 1
```

---

## 4. Analiza kroków

### (2–4) Prędkość i energia — czyste wektorowe obliczenia

```python
v_sqr    = vx**2 + vy**2 + vz**2          # shape (N_e,)
velocity = np.sqrt(v_sqr)                  # sqrt na każdym el. w C
energy   = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J  # energia [eV], shape (N_e,)
```

Odpowiednik native:
```python
# Native (1 cząstka):
v_sqr    = vx_e[k]**2 + vy_e[k]**2 + vz_e[k]**2
velocity = math.sqrt(v_sqr)
energy   = 0.5 * E_MASS * v_sqr / EV_TO_J
```

NumPy robi to samo, ale dla **wszystkich N_e naraz**.

### (5) Indeks tablicy przekrojów

```python
e_idx = np.minimum(
    (energy / cs.DE_CS + 0.5).astype(np.int32),
    cs.CS_RANGES - 1
)
```

- `energy / cs.DE_CS` → energia w jednostkach `DE_CS` (ile binów)
- `+ 0.5` → zaokrąglenie do najbliższego binu (zamiast obcięcia)
- `.astype(np.int32)` → konwersja na int (obcięcie po dodaniu 0.5 → efekt zaokrąglenia)
- `np.minimum(..., CS_RANGES-1)` → nie wychodź poza tablicę

Wynik: `e_idx` kształtu `(N_e,)` — indeks tablicy sigma dla każdej cząstki.

### (6) Fancy indexing 1D na tablicy sigma_tot_e

```python
nu = sim.sigma_tot_e[e_idx] * velocity
```

- `sim.sigma_tot_e` shape: `(CS_RANGES,)` = `(1_000_000,)`
- `e_idx` shape: `(N_e,)` — tablica indeksów
- `sim.sigma_tot_e[e_idx]` → fancy indexing: dla każdego k weź `sigma_tot_e[e_idx[k]]`
  - Wynik: shape `(N_e,)`

Prędkość częstości zderzenia `ν = σ_tot × v`:
```python
nu = sim.sigma_tot_e[e_idx] * velocity  # (N_e,) × (N_e,) → (N_e,)
```

### (7) Prawdopodobieństwo zderzenia — wektorowy exp

```python
p_coll = 1.0 - np.exp(-nu * cs.DT_E)
```

- `np.exp` działa element-wise → wynik shape `(N_e,)`
- Dla każdego elektronu: `p_coll[k] = 1 - exp(-nu[k] * DT_E)`

Native: `p_coll = 1 - math.exp(-nu * DT_E)` (skalar, w pętli).

### (8) Losowanie liczb dla wszystkich cząstek naraz

```python
rands = sim.rng.random(sim.N_e)    # shape (N_e,)
```

`rng.random(N)` generuje N liczb z [0,1) **w jednym wywołaniu**.

Native: `sim.rng.random()` w pętli → N wywołań generatora.
NumPy: `rng.random(N)` → 1 wywołanie generatora, N liczb z wewnętrznej pętli C.

Szybciej i statystycznie lepiej (mniejsza korelacja między generowanymi liczbami).

### (9) Selekcja zderzających się cząstek

```python
colliding = np.where(rands < p_coll)[0]
```

`rands < p_coll` → tablica bool shape `(N_e,)`:
```
rands:    [0.05, 0.92, 0.03, 0.78, 0.01, ...]
p_coll:   [0.02, 0.04, 0.07, 0.03, 0.06, ...]
< mask:   [False, False, True, False, True, ...]
```

`np.where(mask)` → krotka z tablicami indeksów:
```
np.where([False, False, True, False, True]) = (array([2, 4]),)
```

`[0]` wypakowuje pierwszą (i jedyną) tablicę indeksów:
```
colliding = array([2, 4])   ← indeksy elektronów, które się zderzyły
```

### (10) Pętla tylko po zderzających się

```python
for k in colliding:   # np. colliding = [2, 4, 17, 231, ...]
    collisions.collision_electron(sim, int(k), int(e_idx[k]))
    sim.N_e_coll += 1
```

Przy p_coll ≈ 1–5%, zderzenia będzie ~500–2500 z 50 000 elektronów.
Pętla Pythona po 2500 iteracjach zamiast 50 000 — zysk 20–50×.

`int(k)` konwertuje element tablicy NumPy na skalar Python — wymagane przez
funkcję `collision_electron`, która oczekuje int.

---

## 5. Zderzenia jonów — krok 8

```python
# numpy_version/simulation.py — step8_collisions_ions

def step8_collisions_ions(sim, t):
    if (t % cs.N_SUB) != 0:
        return

    vx = sim.vx_i[:sim.N_i]
    vy = sim.vy_i[:sim.N_i]
    vz = sim.vz_i[:sim.N_i]

    # Prędkości termiczne atomów Ar — wszystkie naraz!
    vx_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)  # (A)
    vy_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)
    vz_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)

    # Prędkość względna jon-atom
    gx    = vx - vx_a     # (B)
    gy    = vy - vy_a
    gz    = vz - vz_a
    g_sqr = gx**2 + gy**2 + gz**2
    g     = np.sqrt(g_sqr)  # (C)

    energy = 0.5 * cs.MU_ARAR * g_sqr / cs.EV_TO_J  # (D)
    e_idx  = np.minimum(...)                          # (E) — jak dla elektronów

    nu     = sim.sigma_tot_i[e_idx] * g               # (F)
    p_coll = 1.0 - np.exp(-nu * cs.DT_I)             # (G)

    rands     = sim.rng.random(sim.N_i)               # (H)
    colliding = np.where(rands < p_coll)[0]           # (I)

    for k in colliding:                               # (J) pętla ~5%
        collisions.collision_ion(
            sim, int(k),
            float(vx_a[k]), float(vy_a[k]), float(vz_a[k]),  # atom dla jonu k
            int(e_idx[k])
        )
        sim.N_i_coll += 1
```

### (A) Prędkości termiczne — kluczowa optymalizacja

```python
vx_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)
```

`rng.normal(mean, std, size)` — generuje `size` liczb z rozkładu normalnego naraz.

Native:
```python
# Dla każdego jonu osobno:
for k in range(sim.N_i):
    vx_a = sim.rng.gauss(0.0, NORMAL_DISTRIBUTION)  # jedna liczba
    vy_a = sim.rng.gauss(0.0, NORMAL_DISTRIBUTION)  # jedna liczba
    vz_a = sim.rng.gauss(0.0, NORMAL_DISTRIBUTION)  # jedna liczba
```

NumPy:
```python
# Dla wszystkich jonów naraz:
vx_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)  # N_i liczb
vy_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)
vz_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)
```

Zysk: 3 wywołania zamiast 3 × N_i wywołań generatora.

### (B–C) Prędkość względna — wektorowo

```python
gx = vx - vx_a   # odejmowanie element-wise: (N_i,) - (N_i,) = (N_i,)
gy = vy - vy_a
gz = vz - vz_a
g  = np.sqrt(gx**2 + gy**2 + gz**2)   # (N_i,) — prędkości względne
```

### (J) Przekazanie atomu do collision_ion

```python
collisions.collision_ion(
    sim, int(k),
    float(vx_a[k]), float(vy_a[k]), float(vz_a[k]),  # ← atom dla TEGO konkretnego jonu
    int(e_idx[k])
)
```

`vx_a[k]` — skalar (k-ty element tablicy `vx_a`). `float(...)` konwertuje na Python float.

Funkcja `collision_ion` potrzebuje prędkości **konkretnego** atomu dla **konkretnego** jonu k.
Dlatego atom `vx_a[k]` musi być spójny z jonem `k` — tablica `vx_a` jest generowana
na początku i każdy jon ma "przypisany" swój losowy atom.

---

## 6. Dlaczego `collision_electron` jest skalarne?

Funkcja `collision_electron` (w `collisions.py`) używa `math.sin`, `math.cos`, `math.atan2`,
gałęzi `if-else` dla typów zderzeń, warunkowego tworzenia nowych cząstek.

```python
# collisions.py — collision_electron (uproszczone)
def collision_electron(sim, k, e_index):
    vxe = sim.vx_e[k]   # jeden elektron
    # ...
    if rnd < (t0 / t2):      # elastyczne
        chi = math.acos(...)
    elif rnd < (t1 / t2):    # wzbudzenie
        energy -= E_EXC_TH
    else:                     # jonizacja
        sim.x_e[sim.N_e] = xe   # nowy elektron!
        sim.N_e += 1
```

Jonizacja **tworzy nowe cząstki** dynamicznie zmieniając `sim.N_e`. Nie można łatwo
wektoryzować operacji, która modyfikuje rozmiar tablicy podczas działania.

Dlatego kod hybrydowy jest optymalnym rozwiązaniem:
- **Wektorowo:** "Kto się zderza?" (prosta, bez gałęzi)
- **Skalarnie:** "Jak przebiega zderzenie?" (złożona, z gałęziami i dynamicznymi tablicami)

---

## Podsumowanie — architektura krok 7 i 8

```
Krok 7 (elektrony):
┌──────────────────────────────────────────────────────────┐
│ WEKTOROWO (wszystkie N_e cząstki):                       │
│  v_sqr, velocity, energy → e_idx → nu → p_coll          │
│  rands = rng.random(N_e)                                 │
│  colliding = np.where(rands < p_coll)[0]    ← ~5%       │
├──────────────────────────────────────────────────────────┤
│ SKALARNIE (tylko ~5% = ~500-2500 cząstek):               │
│  for k in colliding:                                      │
│      collision_electron(sim, k, e_idx[k])                │
└──────────────────────────────────────────────────────────┘

Krok 8 (jony, co N_SUB kroków):
┌──────────────────────────────────────────────────────────┐
│ WEKTOROWO (wszystkie N_i jony):                          │
│  vx_a = rng.normal(0, sigma, N_i)  ← N_i losowych atomów│
│  g = sqrt((vx-vx_a)² + ...)                             │
│  energy, e_idx, nu, p_coll                              │
│  rands = rng.random(N_i)                                 │
│  colliding = np.where(rands < p_coll)[0]                │
├──────────────────────────────────────────────────────────┤
│ SKALARNIE (tylko zderzające jony):                        │
│  for k in colliding:                                      │
│      collision_ion(sim, k, vx_a[k], vy_a[k], vz_a[k], ..)│
└──────────────────────────────────────────────────────────┘
```

### Kluczowe operacje NumPy

| Operacja | Wyjaśnienie |
|:---------|:-----------|
| `np.sqrt(v_sqr)` | sqrt wektorowy na (N_e,) |
| `sim.sigma_tot_e[e_idx]` | Fancy indexing 1D: (CS_RANGES,) z indeksami (N_e,) |
| `np.exp(-nu * DT_E)` | exp wektorowy na (N_e,) |
| `rng.random(N)` | N liczb z [0,1) naraz |
| `rng.normal(0, sigma, N)` | N liczb z N(0,σ) naraz |
| `np.where(mask)[0]` | Indeksy elementów True |
| `for k in colliding` | Pętla tylko po ~5% cząstek |

---

**Następna lekcja:** [Lekcja 8 — Diagnostyki XT: slicowanie 2D macierzy](lekcja_08.md)
