# Lekcja 4: Krok 2 — Solver Poissona: `scipy.linalg.solve_banded`

> **Poprzednia lekcja:** [Lekcja 3 — Depozycja gęstości](lekcja_03.md)
> **Następna lekcja:** [Lekcja 5 — Ruch cząstek](lekcja_05.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Co to jest `scipy.linalg.solve_banded` i jakie dane przyjmuje
- Jak zastąpiono pętlę Thomasa jednym wywołaniem bibliotecznym
- Jak slicowanie `pot[:-2]`, `pot[2:]` zastępuje pętlę obliczania pola E
- Czym jest "broadcasting" w NumPy i jak tu działa
- Jak rho jest obliczane wektorowo zamiast w pętli

---

## 1. Przypomnienie: co robi solver Poissona?

Z gęstości ładunku `rho[p] = E_CHARGE × (n_i[p] - n_e[p])` rozwiązujemy równanie:
```
φ_{p-1} - 2φ_p + φ_{p+1} = -(DX²/ε₀) × ρ_p    dla p = 1..N_G-2
```

z warunkami brzegowymi `φ_0 = V₀cos(ωt)`, `φ_{N_G-1} = 0`.

Jest to układ **trójdiagonalny** (algorytm Thomasa w natywnej wersji).

---

## 2. Wersja natywna — algorytm Thomasa ręcznie

```python
# native_version/poisson.py (uproszczone)

def solve_poisson(sim, rho, tt):
    sim.pot[0]      = VOLTAGE * cos(OMEGA * tt)
    sim.pot[N_G-1]  = 0.0

    f = [ALPHA * rho[i] for i in range(1, N_G-1)]  # prawa strona
    f[0]  -= sim.pot[0]
    f[-1] -= sim.pot[N_G-1]

    # Algorytm Thomasa: faza eliminacji
    w = [0.0] * (N_G - 1)
    g = [0.0] * (N_G - 1)
    w[1] = C / B
    g[1] = f[0] / B   # ← f[0] = f[1] w 1-indexing
    for i in range(2, N_G - 1):
        denom = B - A * w[i-1]
        w[i]  = C / denom
        g[i]  = (f[i-1] - A * g[i-1]) / denom

    # Faza podstawienia wstecznego
    sim.pot[N_G-2] = g[N_G-2]
    for i in range(N_G-3, 0, -1):
        sim.pot[i] = g[i] - w[i] * sim.pot[i+1]

    # Pole elektryczne — pętla
    for i in range(1, N_G-1):
        sim.efield[i] = (sim.pot[i-1] - sim.pot[i+1]) * S
    sim.efield[0]    = (sim.pot[0]    - sim.pot[1])   * INV_DX - rho[0]    * DX/(2*EPSILON0)
    sim.efield[N_G-1]= (sim.pot[N_G-2]- sim.pot[N_G-1])* INV_DX + rho[N_G-1]*DX/(2*EPSILON0)
```

Trzy pętle Pythona: przygotowanie f, eliminacja Thomasa, obliczanie E.

---

## 3. Wersja NumPy — kompletny kod

```python
# numpy_version/poisson.py

from scipy.linalg import solve_banded
import constants as cs

def solve_poisson(sim, rho, tt):

    # (1) Warunki brzegowe
    sim.pot[0]      = cs.VOLTAGE * np.cos(cs.OMEGA * tt)
    sim.pot[cs.N_G - 1] = 0.0

    # (2) Prawa strona układu dla węzłów wewnętrznych
    f = cs.ALPHA * rho[1:-1].copy()
    f[0]  -= sim.pot[0]
    f[-1] -= sim.pot[cs.N_G - 1]

    # (3) Rozwiązanie układu trójdiagonalnego
    sim.pot[1:-1] = solve_banded((1, 1), sim._thomas_ab, f)

    # (4) Pole elektryczne — wektorowo
    sim.efield[1:-1] = (sim.pot[:-2] - sim.pot[2:]) * cs.S

    # (5) Brzegi — z korekcją
    sim.efield[0]  = (sim.pot[0]  - sim.pot[1])  * cs.INV_DX \
                     - rho[0]  * cs.DX / (2.0 * cs.EPSILON0)
    sim.efield[-1] = (sim.pot[-2] - sim.pot[-1]) * cs.INV_DX \
                     + rho[-1] * cs.DX / (2.0 * cs.EPSILON0)
```

Przeanalizujmy każdy krok.

---

## 4. Krok (1): Warunki brzegowe

```python
sim.pot[0]      = cs.VOLTAGE * np.cos(cs.OMEGA * tt)
sim.pot[cs.N_G - 1] = 0.0
```

`np.cos(skalar)` = `math.cos(skalar)` — dla jednego argumentu wynik taki sam.
Tutaj `np.cos` jest używany dla spójności z resztą kodu NumPy.

Identyczne z wersją natywną — nic nowego.

---

## 5. Krok (2): Prawa strona układu — wektorowe slicowanie

```python
f = cs.ALPHA * rho[1:-1].copy()
```

**`rho[1:-1]`**: slice tablicy rho — elementy od indeksu 1 do N_G-2 (węzły wewnętrzne):

```
rho: [rho_0, rho_1, rho_2, ..., rho_{N_G-2}, rho_{N_G-1}]
              ↑——————————————————↑
         rho[1:-1]: N_G-2 elementów
```

**`.copy()`**: tutaj tworzymy kopię! Dlaczego?

Gdybyśmy nie skopiowali: `f = cs.ALPHA * rho[1:-1]` — wciąż widok na `rho`.
Następna linia modyfikuje `f[0]` i `f[-1]`, a to zmieniałoby `rho[1]` i `rho[N_G-2]`.
Nie chcemy modyfikować tablicy rho. Stąd `.copy()`.

```python
f[0]  -= sim.pot[0]         # korekta na lewy warunek brzegowy
f[-1] -= sim.pot[cs.N_G-1]  # korekta na prawy warunek brzegowy
```

`f[-1]` to ostatni element (Python: `f[N_G-3]`) — identyczna logika jak w algorytmie Thomasa.

**Odpowiednik natywny:**
```python
# Native:
f = [0.0] * (N_G - 2)
for i in range(N_G - 2):
    f[i] = ALPHA * rho[i + 1]
f[0]  -= pot[0]
f[-1] -= pot[N_G-1]

# NumPy:
f = cs.ALPHA * rho[1:-1].copy()  # jedna linia zamiast pętli!
f[0] -= sim.pot[0]
f[-1] -= sim.pot[cs.N_G - 1]
```

---

## 6. Krok (3): `scipy.linalg.solve_banded` — solver trójdiagonalny

```python
sim.pot[1:-1] = solve_banded((1, 1), sim._thomas_ab, f)
```

### Co to jest `solve_banded`?

`scipy.linalg.solve_banded(l_and_u, ab, b)` rozwiązuje układ `A @ x = b`,
gdzie `A` jest macierzą pasmową (band matrix).

Argumenty:
- **`(1, 1)`**: krotka `(l, u)` — szerokość pasma pod i nad przekątną. Dla trójdiagonalnej: l=1, u=1.
- **`ab`**: macierz pasmowa w skompresowanym formacie shape `(3, N)` — to jest nasz `_thomas_ab`
- **`f`**: wektor prawej strony shape `(N,)`

Wynik: wektor `x` shape `(N,)` — rozwiązanie układu.

```python
sim.pot[1:-1] = solve_banded(...)  # wynik wpisujemy w węzły wewnętrzne
```

Cała eliminacja Thomasa (dwie pętle po N_G-2 iteracji) wykonana przez bibliotekę
LAPACK w C/Fortran — **wiele razy szybsza** niż pętle Pythona.

### Przypomnienie: format `_thomas_ab`

```python
# Z state.py:
def _build_thomas_matrix():
    n = cs.N_G - 2   # = 398 węzłów wewnętrznych
    ab = np.zeros((3, n))
    ab[0, 1:]  = cs.A   # = 1.0  (górna przekątna)
    ab[1, :]   = cs.B   # = -2.0 (główna)
    ab[2, :-1] = cs.C   # = 1.0  (dolna przekątna)
    return ab
```

```
Kolumna:  0     1     2    ...   396   397
ab[0]:    0.0   1.0   1.0  ...   1.0   1.0   ← pierwsza kolumna nieużywana
ab[1]:   -2.0  -2.0  -2.0  ...  -2.0  -2.0   ← główna przekątna
ab[2]:    1.0   1.0   1.0  ...   1.0   0.0   ← ostatnia kolumna nieużywana
```

---

## 7. Krok (4): Pole elektryczne — slicowanie offsetowe

```python
sim.efield[1:-1] = (sim.pot[:-2] - sim.pot[2:]) * cs.S
```

To jest **wektoryzacja centralnej różnicy skończonej** `E[i] = (φ[i-1] - φ[i+1]) / (2·DX)`.

Wyjaśnienie slicowania:

```
sim.pot:         [φ_0, φ_1, φ_2, φ_3, ..., φ_{N-2}, φ_{N-1}]

sim.pot[:-2]:    [φ_0, φ_1, φ_2, ..., φ_{N-3}]   ← od 0 do N-3
sim.pot[2:]:     [φ_2, φ_3, φ_4, ..., φ_{N-1}]   ← od 2 do N-1

Różnica:         [φ_0-φ_2, φ_1-φ_3, φ_2-φ_4, ..., φ_{N-3}-φ_{N-1}]
```

Każdy element różnicy: `pot[i-1] - pot[i+1]` dla i = 1, 2, ..., N-2. Dokładnie
to, co chcemy!

```
sim.efield[1:-1] = (pot[:-2] - pot[2:]) * S
    ↑                  ↑           ↑
efield[1..N_G-2]  pot[0..N_G-3]  pot[2..N_G-1]

Indeks i-ty:
efield[i] = (pot[i-1] - pot[i+1]) * S    ← dla i = 1..N_G-2
```

**Odpowiednik natywny:**
```python
# Native (pętla):
for i in range(1, N_G-1):
    efield[i] = (pot[i-1] - pot[i+1]) * S

# NumPy (jedno wyrażenie):
efield[1:-1] = (pot[:-2] - pot[2:]) * S
```

Numpy wykonuje N_G-2 = 398 odejmowań i mnożeń naraz w C. Zero pętli Pythona!

---

## 8. Krok (5): Brzegi siatki

```python
sim.efield[0]  = (sim.pot[0]  - sim.pot[1])  * cs.INV_DX \
                 - rho[0]  * cs.DX / (2.0 * cs.EPSILON0)

sim.efield[-1] = (sim.pot[-2] - sim.pot[-1]) * cs.INV_DX \
                 + rho[-1] * cs.DX / (2.0 * cs.EPSILON0)
```

`sim.efield[-1]` = ostatni element = `efield[N_G-1]`.
`sim.pot[-2]` = przedostatni element = `pot[N_G-2]`.

To jest skrótowy zapis Pythona — `pot[-2]` to to samo co `pot[N_G-2]`.
Czytelniejszy niż `pot[cs.N_G-2]`.

---

## 9. Wywołanie z `step2_solve_poisson`

```python
# simulation.py

def step2_solve_poisson(sim: SimulationState):
    rho = cs.E_CHARGE * (sim.i_density - sim.e_density)  # ← wektorowo!
    poisson.solve_poisson(sim, rho, sim.Time)
```

**Obliczenie rho:**

```python
# Native (pętla):
rho = [0.0] * cs.N_G
for p in range(cs.N_G):
    rho[p] = cs.E_CHARGE * (sim.i_density[p] - sim.e_density[p])

# NumPy (jedna linia):
rho = cs.E_CHARGE * (sim.i_density - sim.e_density)
```

`sim.i_density` i `sim.e_density` to tablice kształtu `(N_G,)`.
Operacja `(i_density - e_density)` to odejmowanie element po elemencie w C.

---

## 10. Dlaczego `_thomas_ab` jest budowany tylko raz?

Macierz trójdiagonalna `_thomas_ab` zależy tylko od `A`, `B`, `C` — stałych!
Wartości te nie zmieniają się przez całą symulację.

```python
# Zbudowana raz w SimulationState.__init__():
self._thomas_ab = _build_thomas_matrix()   # ← raz na początku

# Reużywana 4000 razy × liczba cykli:
sim.pot[1:-1] = solve_banded((1, 1), sim._thomas_ab, f)
```

Gdybyśmy budowali macierz w każdym kroku:
- 4000 kroków × N_G-2 alokacji elementów tablicy = miliony niepotrzebnych operacji

Wyniki: jeden raz zaalokowany blok pamięci, wielokrotnie używany.
To klasyczny wzorzec optymalizacji: **precompute co możesz, cache co wielokrotnie używasz**.

---

## Podsumowanie

| Operacja | Native | NumPy |
|:---------|:-------|:------|
| rho = e(n_i - n_e) | pętla for | `E_CHARGE * (i_density - e_density)` |
| Prawa strona f | pętla for | `ALPHA * rho[1:-1].copy()` |
| Eliminacja Thomasa | 2 pętle (forward + backward) | `solve_banded((1,1), ab, f)` |
| Pole E (wnętrze) | pętla for | `(pot[:-2] - pot[2:]) * S` |
| Pole E (brzegi) | 2 przypisania | 2 przypisania (tak samo) |

### Kluczowe nowe operacje NumPy

| Operacja | Wyjaśnienie |
|:---------|:-----------|
| `rho[1:-1]` | Elementy od 1 do N-2 (węzły wewnętrzne) |
| `pot[:-2]` | Wszystkie elementy bez ostatnich 2 |
| `pot[2:]` | Wszystkie elementy od indeksu 2 |
| `.copy()` | Kopia, nie widok — chroni oryginał przed modyfikacją |
| `solve_banded((1,1), ab, f)` | LAPACK solver dla macierzy trójdiagonalnych |
| `sim.pot[-1]` | Ostatni element (Python-style negative indexing) |
| `sim.pot[-2]` | Przedostatni element |

---

**Następna lekcja:** [Lekcja 5 — Ruch cząstek: wektoryzacja Leapfroga](lekcja_05.md)
