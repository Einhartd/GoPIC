# Lekcja 2: Struktura projektu i klasa SimulationState

> **Poprzednia lekcja:** [Lekcja 1 — NumPy od zera](lekcja_01.md)
> **Następna lekcja:** [Lekcja 3 — Depozycja gęstości](lekcja_03.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Jak projekt jest podzielony na pliki i dlaczego
- Co robi klasa `SimulationState` i jak przechowuje dane
- Czym różni się `np.zeros` od `np.empty` i kiedy używamy którego
- Co to jest `_thomas_ab` i dlaczego jest budowany tylko raz
- Jak różnią się typy danych (int64 vs float64) w tablicach diagnostycznych

---

## 1. Mapa plików projektu

```
python/numpy_version/
├── constants.py      ← stałe fizyczne i parametry (identyczne jak w native)
├── state.py          ← klasa SimulationState (wszystkie tablice NumPy)
├── simulation.py     ← główna pętla + kroki 1–9 (WEKTOROWE)
├── poisson.py        ← solver Poissona (scipy.linalg.solve_banded)
├── collisions.py     ← zderzenia per-cząstka (wciąż skalarne, ale ~5% cząstek)
├── cross_sections.py ← wypełnianie tablic przekrojów czynnych
├── io_manager.py     ← zapis/odczyt plików .bin, .dat
└── main.py           ← punkt wejścia (identyczny jak native)
```

Porównanie z wersją natywną:
- **Takie same:** `constants.py`, `main.py`, `collisions.py` (w środku)
- **Przepisane na NumPy:** `simulation.py`, `poisson.py`, `state.py`

---

## 2. `constants.py` — stałe z `Final`

```python
# constants.py
from typing import Final

E_CHARGE: Final[float] = 1.60217662e-19   # Final = "stała, nie zmieniaj"
N_G:      Final[int]   = 400
```

`Final` to adnotacja typowa (z `typing`) informująca edytor kodu i lintér, że ta
wartość nie powinna być zmieniana. Nie jest to egzekwowane przez Python w runtime —
to tylko wskazówka dla programisty.

```python
# Nowe w numpy_version — dodano kilka stałych dla solvera:
A: Final[float] = 1.0     # nad-przekątna macierzy trójdiagonalnej
B: Final[float] = -2.0    # główna przekątna
C: Final[float] = 1.0     # pod-przekątna
S: Final[float] = 1.0 / (2.0 * DX)   # czynnik dla centralnej różnicy E-field
ALPHA: Final[float] = -DX * DX / EPSILON0  # czynnik prawej strony Poissona

NORMAL_DISTRIBUTION: Final[float] = math.sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)
# ≈ 289 m/s — sigma rozkładu Maxwella dla Ar
```

---

## 3. Klasa `SimulationState` — serce danych

Wersja natywna używała listy `[0.0] * MAX_N_P`. Wersja NumPy używa `np.ndarray`.

### Tablice cząstek

```python
# state.py

# Wersja natywna:
self.x_e  = [0.0] * cs.MAX_N_P   # lista Pythona — wolna, brak operacji wektorowych

# Wersja NumPy:
self.x_e  = np.empty(cs.MAX_N_P, dtype=np.float64)   # tablica NumPy
```

**Dlaczego `np.empty` zamiast `np.zeros`?**

- `np.zeros(N)` → alokuje pamięć i wypełnia zerami (operacja zapisu N floatów)
- `np.empty(N)` → tylko alokuje pamięć, nie inicjalizuje (szybsze o ~N operacji)

Tablice cząstek (`x_e`, `vx_e`, itp.) są inicjalizowane przez `initParticles()` przed
użyciem, więc nie musimy ich zerować — `np.empty` jest wystarczający i szybszy.

```python
# Bezpieczne użycie np.empty:
self.x_e = np.empty(cs.MAX_N_P, dtype=np.float64)
# ...
# Później, w initParticles():
sim.x_e[:nseed] = cs.L * sim.rng.random(nseed)  # ← zapisujemy przed odczytem
```

**Kiedy `np.zeros`?**

Gęstości i diagnostyki **muszą zacząć od zera** — są akumulowane przez `+=`:

```python
self.e_density       = np.zeros(cs.N_G, dtype=np.float64)
self.cumul_e_density = np.zeros(cs.N_G, dtype=np.float64)
self.eepf            = np.zeros(cs.N_EEPF, dtype=np.float64)
```

### Tablice siatki

```python
self.efield  = np.zeros(cs.N_G, dtype=np.float64)   # kształt: (400,)
self.pot     = np.zeros(cs.N_G, dtype=np.float64)
```

W wersji natywnej były to listy `[0.0] * N_G`. Zmiana na ndarray pozwala na:
```python
# Native: pętla
for p in range(cs.N_G):
    rho[p] = cs.E_CHARGE * (sim.i_density[p] - sim.e_density[p])

# NumPy: wektorowo (jedna linia!)
rho = cs.E_CHARGE * (sim.i_density - sim.e_density)
```

### Tablice diagnostyczne XT — 2D!

```python
# kształt: (N_G, N_XT) = (400, 200)
self.pot_xt    = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
self.efield_xt = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
```

W wersji natywnej były to listy list:
```python
# Native (state.py):
self.pot_xt = [[0.0] * cs.N_XT for _ in range(cs.N_G)]  # lista 400 list po 200 el.
```

Tablica 2D NumPy vs lista list:

```
Lista list:         [ptr] → [0.0, 0.0, ..., 0.0]
                    [ptr] → [0.0, 0.0, ..., 0.0]   ← każdy wiersz gdzieś indziej w pamięci!
                    ...

NumPy 2D:           [0.0, 0.0, ..., ciągły blok ..., 0.0]  ← wszystko razem w pamięci
```

Ciągłość pamięci NumPy umożliwia wydajne operacje kolumnowe i wierszowe.

### Typ int dla IFED

```python
self.ifed_pow = np.zeros(cs.N_IFED, dtype=np.int64)   # histogram → int
self.ifed_gnd = np.zeros(cs.N_IFED, dtype=np.int64)
```

IFED to histogram — zliczamy ile jonów trafiło w każdy bin energetyczny. To naturalne
liczby całkowite, więc używamy `int64`. Nie ma potrzeby stosowania `float64`.

---

## 4. Generator liczb losowych

```python
# Native:
import random
self.rng = random.Random()        # standardowy RNG Pythona

# NumPy:
self.rng = np.random.default_rng()  # Generator NumPy
```

Różnica: generator NumPy może generować **całe tablice** liczb losowych naraz:

```python
# Native: jedna liczba
r = sim.rng.random()

# NumPy: tablica liczb
r_arr = sim.rng.random(sim.N_e)       # N_e liczb naraz
r_normal = sim.rng.normal(0, sigma, N)  # N liczb z rozkładu normalnego
```

`np.random.default_rng()` używa algorytmu **PCG64** — nowoczesnego, wysokiej jakości
generatora liczb pseudolosowych (nowszy i statystycznie lepszy niż Mersenne Twister).

---

## 5. `_thomas_ab` — macierz trójdiagonalna budowana raz

```python
# state.py

self._thomas_ab = _build_thomas_matrix()
```

```python
def _build_thomas_matrix() -> np.ndarray:
    """Build the constant banded matrix for scipy.linalg.solve_banded."""
    n = cs.N_G - 2    # liczba węzłów wewnętrznych (bez brzegów)
    ab = np.zeros((3, n), dtype=np.float64)  # kształt: (3, 398)
    ab[0, 1:]  = cs.A   # górna przekątna (wiersz 0)
    ab[1, :]   = cs.B   # główna przekątna (wiersz 1)
    ab[2, :-1] = cs.C   # dolna przekątna (wiersz 2)
    return ab
```

### Co to jest macierz pasmowa (banded matrix)?

Solver Poissona rozwiązuje układ równań z macierzą trójdiagonalną:

```
⎡-2  1  0  0 ⎤
⎢ 1 -2  1  0 ⎥   ← ta macierz jest STAŁA przez cały czas symulacji!
⎢ 0  1 -2  1 ⎥
⎣ 0  0  1 -2 ⎦
```

`scipy.linalg.solve_banded` zamiast pełnej macierzy N×N oczekuje **skompresowanej**
reprezentacji pasmowej kształtu `(3, N)`, gdzie:
- Wiersz 0: górna przekątna (nad główną)
- Wiersz 1: główna przekątna
- Wiersz 2: dolna przekątna (pod główną)

```python
ab = np.zeros((3, 398))   # 3 przekątne, 398 węzłów wewnętrznych

ab[0, 1:]  = 1.0   # A = 1.0 — górna przekątna (przesunieta o 1)
ab[1, :]   = -2.0  # B = -2.0 — główna przekątna
ab[2, :-1] = 1.0   # C = 1.0 — dolna przekątna (przesunieta o 1)
```

Dlaczego `ab[0, 1:]` zamiast `ab[0, :]`?

Format `solve_banded` wymaga, żeby elementy przekątnych były wyrównane do kolumn:
```
Kolumna:   0     1     2     3
ab[0]:   NaN   A_01  A_12  A_23   ← górna, pierwszy element nieużywany
ab[1]:   B_00  B_11  B_22  B_33   ← główna
ab[2]:   C_10  C_21  C_32   NaN   ← dolna, ostatni element nieużywany
```

**Kluczowe:** Ta macierz jest **budowana raz w `__init__`** i reużywana w każdym
z 4000 kroków × wiele cykli. Unikamy alokacji pamięci w wewnętrznej pętli.

---

## 6. Porównanie: native list vs NumPy ndarray

| Aspekt | Native (lista) | NumPy (ndarray) |
|:-------|:--------------|:----------------|
| Alokacja | `[0.0] * N` | `np.zeros(N)` |
| Odczyt elementu | `x[k]` | `x[k]` (tak samo) |
| Operacje wektorowe | `for k: x[k] * 2` | `x * 2` |
| Slicowanie (widok) | `x[a:b]` → kopia! | `x[a:b]` → widok (modyfikowalny) |
| Fancy indexing | Nie | `x[arr_of_indices]` |
| Boolean masking | Nie | `x[mask]` |
| 2D tablica | `[[...] for ...]` | `np.zeros((N, M))` |
| Pamięć | Fragmentowana | Ciągła |
| Szybkość pętli | Powolna (Python) | Szybka (C w tle) |

---

## Podsumowanie

| Pojęcie | Wyjaśnienie |
|:--------|:-----------|
| `np.empty` | Alokacja bez inicjalizacji — używaj dla cząstek (nadpisywanych przy init) |
| `np.zeros` | Alokacja z zerami — używaj dla gęstości, diagnostyk (akumulowanych przez +=) |
| `dtype=np.float64` | 64-bitowy float — do pozycji, prędkości, gęstości |
| `dtype=np.int64` | 64-bitowy int — do liczników (IFED) |
| Widok | `a[1:N]` nie kopiuje — modyfikacje zmieniają oryginał |
| `(N_G, N_XT)` | Kształt 2D tablicy XT: 400 wierszy × 200 kolumn |
| `_thomas_ab` | Macierz Poissona zbudowana raz, reużywana co krok |

---

**Następna lekcja:** [Lekcja 3 — Krok 1: Depozycja gęstości z `np.add.at`](lekcja_03.md)
