# Lekcja 3: Krok 1 — Depozycja gęstości: `np.add.at` vs pętla

> **Poprzednia lekcja:** [Lekcja 2 — Struktura projektu](lekcja_02.md)
> **Następna lekcja:** [Lekcja 4 — Solver Poissona](lekcja_04.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Dlaczego `+=` z fancy indexing nie działa poprawnie dla duplikatów
- Co robi `np.add.at` i kiedy jest niezbędne
- Jak wektoryzacja depozycji działa krok po kroku
- Dlaczego korekcja brzegowa ×2 jest trywialna w NumPy
- Jak subcycling jonów zmienia logikę w NumPy vs native

---

## 1. Przypomnienie: co robi depozycja gęstości?

Każda supercząstka w pozycji `x` rozkłada swój ładunek na dwa sąsiednie węzły siatki
proporcjonalnie do odległości (interpolacja liniowa CIC):

```
Węzeł p:   waga = (p+1) - c0   (jak daleko do prawego węzła)
Węzeł p+1: waga = c0 - p       (jak daleko do lewego węzła)

gdzie c0 = x / DX
```

---

## 2. Wersja natywna — prosta pętla

```python
# native_version/simulation.py — step1_compute_electron_density

for p in range(cs.N_G):           # zerowanie
    sim.e_density[p] = 0.0

for k in range(sim.N_e):          # depozycja
    c0 = sim.x_e[k] * cs.INV_DX
    p  = int(c0)
    sim.e_density[p]   += (p + 1.0 - c0) * cs.FACTOR_W   # lewy węzeł
    sim.e_density[p+1] += (c0 - p)       * cs.FACTOR_W   # prawy węzeł

sim.e_density[0]          *= 2.0   # korekcja brzegowa
sim.e_density[cs.N_G - 1] *= 2.0

for p in range(cs.N_G):           # akumulacja
    sim.cumul_e_density[p] += sim.e_density[p]
```

Złożoność: **O(N_e)** pętli Pythona — dla N_e = 50 000 to 50 000 iteracji wolnego interpretera.

---

## 3. Wersja NumPy — krok po kroku

```python
# numpy_version/simulation.py — step1_compute_electron_density

def step1_compute_electron_density(sim: SimulationState):
    x  = sim.x_e[:sim.N_e]              # (1)
    c0 = x * cs.INV_DX                  # (2)
    p  = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)  # (3)
    p_f = p.astype(np.float64)          # (4)
    w_left  = p_f + 1.0 - c0           # (5)
    w_right = c0 - p_f                  # (6)

    sim.e_density[:] = 0.0             # (7)
    np.add.at(sim.e_density, p,     w_left  * cs.FACTOR_W)  # (8)
    np.add.at(sim.e_density, p + 1, w_right * cs.FACTOR_W)  # (9)

    sim.e_density[0]         *= 2.0    # (10)
    sim.e_density[cs.N_G - 1] *= 2.0  # (11)
    sim.cumul_e_density       += sim.e_density  # (12)
```

Przeanalizujmy każdy krok:

---

### Krok (1): Widok na aktywne elektrony

```python
x = sim.x_e[:sim.N_e]
```

`sim.x_e` ma 1 000 000 slotów, ale tylko pierwsze `sim.N_e` jest aktywnych.
`[:sim.N_e]` to **widok** — tablica kształtu `(N_e,)` bez kopiowania pamięci.

Wszystkie dalsze operacje pracują na tej podtablicy — automatycznie pomijamy
nieaktywne sloty.

---

### Krok (2): Pozycja w jednostkach siatki

```python
c0 = x * cs.INV_DX
```

- `x`: shape `(N_e,)`, np. `[0.00011, 0.00023, 0.0015, ...]`
- `cs.INV_DX`: skalar (1/DX ≈ 15940)
- `c0`: shape `(N_e,)`, np. `[1.754, 3.669, 23.93, ...]`

Mnożenie wektorowe: każdy element x[k] × INV_DX w jednej operacji C.

---

### Krok (3): Lewy węzeł siatki + clip

```python
p = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
```

**`c0.astype(np.int32)`**: konwersja float → int przez obcięcie:
- `1.754 → 1`
- `3.669 → 3`
- `23.93 → 23`

**`np.clip(..., 0, cs.N_G - 2)`**: gwarantuje że `0 ≤ p ≤ 398`:
- Jeśli cząstka jest dokładnie na lewej granicy: `c0 = 0.0 → p = 0` ✓
- Jeśli cząstka jest dokładnie na prawej granicy: `c0 = 399.0 → p = 399` ale
  `p + 1 = 400` → **out of bounds!** → `clip` → `p = 398`, `p+1 = 399` ✓

Wynik: `p` to tablica `(N_e,)` int32 z indeksami lewych węzłów.

---

### Kroki (4–6): Obliczenie wag

```python
p_f = p.astype(np.float64)    # p jako float do obliczeń
w_left  = p_f + 1.0 - c0     # waga lewego węzła: (p+1) - c0
w_right = c0 - p_f            # waga prawego węzła: c0 - p
```

Przykład numeryczny dla jednej cząstki (c0 = 1.754, p = 1, p_f = 1.0):
- `w_left  = 1.0 + 1.0 - 1.754 = 0.246`
- `w_right = 1.754 - 1.0 = 0.754`
- Suma: `0.246 + 0.754 = 1.0` ✓

Wszystkie te operacje są **wektorowe** — obliczane dla wszystkich N_e cząstek naraz.

---

### Krok (7): Zerowanie gęstości

```python
sim.e_density[:] = 0.0
```

`sim.e_density[:]` to zapis "przypisz 0.0 do WSZYSTKICH elementów".

**Dlaczego nie `sim.e_density = np.zeros(cs.N_G)`?**

Gdybyśmy napisali `sim.e_density = np.zeros(N_G)`, stworzylibyśmy **nową tablicę**
i przypisali ją do atrybutu. Problem: wszystkie inne miejsca w kodzie trzymają
referencje do starej tablicy — nie zobaczyłyby nowych zer!

```python
# BŁĄD (tworzy nową tablicę):
sim.e_density = np.zeros(cs.N_G)  # pozostałe referencje wciąż wskazują starą tablicę!

# POPRAWNIE (modyfikuje in-place):
sim.e_density[:] = 0.0            # zero w tej samej tablicy, wszystkie referencje widzą zmianę
```

---

### Kroki (8–9): Depozycja z `np.add.at`

```python
np.add.at(sim.e_density, p,     w_left  * cs.FACTOR_W)
np.add.at(sim.e_density, p + 1, w_right * cs.FACTOR_W)
```

To jest **kluczowa operacja**. Wyjaśnienie:

#### Dlaczego nie możemy użyć `sim.e_density[p] += w_left * cs.FACTOR_W`?

Pozornie prostsza wersja:

```python
# BŁĘDNA wersja!
sim.e_density[p] += w_left * cs.FACTOR_W
```

Problem: gdy dwie cząstki są w tym samym przedziale siatki (mają ten sam `p`):

```python
p = np.array([1, 1, 2])       # dwie cząstki w węźle 1, jedna w węźle 2
val = np.array([0.3, 0.5, 0.8])

arr = np.zeros(5)
arr[p] += val    # BŁĄD NUMERYCZNY!
# Python wykonuje:
# arr[1] += 0.3  → arr[1] = 0.3
# arr[1] += 0.5  → arr[1] = 0.8  ← BŁĄD: pierwsze dodanie zostało "zapomniane"!
# arr[2] += 0.8  → arr[2] = 0.8  ← OK

# Oczekiwany wynik: arr[1] = 0.3 + 0.5 = 0.8  ← tak jest, ale tylko przypadkowo!
```

Bardziej subtelny przykład — NumPy READS indeks przed WRITE:

```python
# arr[p] += val to w rzeczywistości: arr[p] = arr[p] + val
# Gdy p = [1, 1], NumPy czyta arr[1] RAZ, dodaje OBA val, zapisuje raz:
arr = np.zeros(5)
p = np.array([1, 1])
val = np.array([0.3, 0.5])
arr[p] += val
# arr[p] = arr[p] + val
# = [arr[1], arr[1]] + [0.3, 0.5]
# = [0.0, 0.0] + [0.3, 0.5]
# = [0.3, 0.5]
# Zapisujemy na indeks [1,1]: arr[1] = 0.3, arr[1] = 0.5
# Wynik: arr[1] = 0.5   ← GUBILIŚMY 0.3!
```

#### `np.add.at` — bezpieczne scatter-add

```python
np.add.at(arr, p, val)
# Wykonuje OSOBNE arr[p[i]] += val[i] dla każdego i
# Gwarantuje poprawność dla duplikatów!

arr = np.zeros(5)
np.add.at(arr, np.array([1, 1]), np.array([0.3, 0.5]))
# arr[1] += 0.3  → arr[1] = 0.3
# arr[1] += 0.5  → arr[1] = 0.8  ✓ poprawnie!
```

#### Jak to wygląda w symulacji?

```python
p         = np.array([1, 1, 2, 0, 3, ...])     # lewi sąsiedzi (mogą się powtarzać!)
w_left    = np.array([0.3, 0.6, 0.8, 0.2, ...])
FACTOR_W  = 1.12e13  # skalar

np.add.at(sim.e_density, p, w_left * FACTOR_W)
# Dla p[0]=1: e_density[1] += 0.3 * FACTOR_W
# Dla p[1]=1: e_density[1] += 0.6 * FACTOR_W  ← oba dodane poprawnie!
# Dla p[2]=2: e_density[2] += 0.8 * FACTOR_W
# ...
```

---

### Kroki (10–11): Korekcja brzegowa

```python
sim.e_density[0]         *= 2.0
sim.e_density[cs.N_G - 1] *= 2.0
```

Identyczna logika jak w native — tylko krótsza składnia.
W wersji natywnej była pętla `for p in range(cs.N_G)` z warunkiem dla `p==0` i `p==N_G-1`.
Tu po prostu indeksujemy bezpośrednio.

---

### Krok (12): Akumulacja skumulowanej gęstości

```python
sim.cumul_e_density += sim.e_density
```

**`+=` dla tablic NumPy = in-place dodawanie element po elemencie.**

Native:
```python
for p in range(cs.N_G):
    sim.cumul_e_density[p] += sim.e_density[p]
```

NumPy:
```python
sim.cumul_e_density += sim.e_density   # 400 dodań w jednej C-pętli
```

---

## 4. Gęstość jonów — subtelność subcyclingu

```python
# numpy_version/simulation.py

def step1_compute_ion_density(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        sim.cumul_i_density += sim.i_density  # (A)
        return

    # ... depozycja (identyczna jak dla elektronów, ale na x_i) ...
    sim.cumul_i_density += sim.i_density      # (B)
```

### Kluczowa różnica względem native!

W **wersji natywnej** dla jonów:
```python
# native_version:
def step1_compute_ion_density(sim, t):
    if t % cs.N_SUB != 0:
        return            # ← WRÓĆ BEZ akumulacji!
    # ... depozycja ...
    for p in range(cs.N_G):
        sim.cumul_i_density[p] += sim.i_density[p]  # akumulacja PO depozycji
```

W **wersji NumPy**:
```python
# numpy_version:
def step1_compute_ion_density(sim, t):
    if (t % cs.N_SUB) != 0:
        sim.cumul_i_density += sim.i_density  # (A) ← AKUMULUJ przed return!
        return
    # ... depozycja ...
    sim.cumul_i_density += sim.i_density      # (B) ← akumuluj po depozycji
```

Wersja NumPy akumuluje `cumul_i_density` w **każdym** kroku (linie A i B).
W krokach subcyclingu (t % N_SUB != 0) akumuluje stare `i_density`.
W krokach pełnych (t % N_SUB == 0) przelicza i_density, potem akumuluje nowe.

To konieczne, bo `cumul_i_density` musi narastać co krok (jak w C++), żeby
uśrednianie na końcu dało poprawny wynik.

> **Uwaga:** Jest to subtelna różnica od natywnej implementacji — natywna pomija
> akumulację w krokach subcyclingu, co jest błędem (ale skompensowanym gdzie indziej).
> Wersja NumPy implementuje oryginalną logikę C++ poprawnie.

---

## 5. Pełne porównanie — native vs NumPy

```python
# ── NATIVE (czysty Python) ──────────────────────────────────────────────────
for p in range(cs.N_G):              # zerowanie: 400 iteracji Pythona
    sim.e_density[p] = 0.0

for k in range(sim.N_e):             # depozycja: N_e iteracji Pythona
    c0 = sim.x_e[k] * cs.INV_DX
    p  = int(c0)
    sim.e_density[p]   += (p + 1.0 - c0) * cs.FACTOR_W
    sim.e_density[p+1] += (c0 - p)       * cs.FACTOR_W

sim.e_density[0] *= 2.0
sim.e_density[cs.N_G-1] *= 2.0

for p in range(cs.N_G):             # akumulacja: 400 iteracji Pythona
    sim.cumul_e_density[p] += sim.e_density[p]

# ── NUMPY (wektorowe) ───────────────────────────────────────────────────────
x   = sim.x_e[:sim.N_e]             # widok, O(1)
c0  = x * cs.INV_DX                 # mnożenie wektorowe w C
p   = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
p_f = p.astype(np.float64)
w_left  = p_f + 1.0 - c0            # wagi wektorowo
w_right = c0  - p_f

sim.e_density[:] = 0.0              # zerowanie wektorowe
np.add.at(sim.e_density, p,     w_left  * cs.FACTOR_W)
np.add.at(sim.e_density, p + 1, w_right * cs.FACTOR_W)

sim.e_density[0]         *= 2.0
sim.e_density[cs.N_G - 1] *= 2.0
sim.cumul_e_density       += sim.e_density   # += wektorowe
```

---

## Podsumowanie

| Operacja | Native | NumPy |
|:---------|:-------|:------|
| Zerowanie | `for p: density[p] = 0` | `density[:] = 0.0` |
| Pozycja w siatce | `c0 = x_e[k] * INV_DX` | `c0 = x * INV_DX` (wektorowo) |
| Lewy węzeł | `p = int(c0)` | `np.clip(c0.astype(int32), 0, N-2)` |
| Wagi | `w_l = p+1-c0`, `w_r = c0-p` | Wektorowo (te same wzory) |
| Scatter-add | `density[p] += w * FACTOR_W` | `np.add.at(density, p, w*FACTOR_W)` |
| Korekcja ×2 | `density[0] *= 2.0` | `density[0] *= 2.0` (tak samo) |
| Akumulacja | `for p: cumul[p] += density[p]` | `cumul += density` |

**Kluczowe:** `np.add.at` jest **obowiązkowe** dla scatter-add z duplikatami.
Zwykłe `density[p] += val` daje błędne wyniki gdy dwie cząstki trafiają do tego samego węzła!

---

**Następna lekcja:** [Lekcja 4 — Solver Poissona: `scipy.linalg.solve_banded`](lekcja_04.md)
