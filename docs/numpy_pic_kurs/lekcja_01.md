# Lekcja 1: NumPy od zera — tablice, typy i operacje wektorowe

> **Następna lekcja:** [Lekcja 2 — Struktura projektu i SimulationState](lekcja_02.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Czym jest `np.ndarray` i czym różni się od listy Pythona
- Co to znaczy "operacja wektorowa" i dlaczego jest szybsza
- Jak działają `dtype`, `shape`, slicowanie i fancy indexing
- Jak działają operacje porównania (boolean masking)
- Jakich operacji NumPy używamy w tym projekcie i po co

---

## 1. Lista Pythona vs `np.ndarray`

### Lista Pythona

```python
x = [1.5, 2.3, 0.7, 4.1]

# Jeśli chcesz pomnożyć każdy element przez 2:
y = [v * 2 for v in x]   # pętla
```

### Tablica NumPy

```python
import numpy as np

x = np.array([1.5, 2.3, 0.7, 4.1])

# Mnożenie przez 2 — BEZ pętli:
y = x * 2   # wynik: array([3.0, 4.6, 1.4, 8.2])
```

**Kluczowa różnica:** NumPy wykonuje operację na **wszystkich elementach jednocześnie**
(wektorowo). Pod spodem jest pętla, ale napisana w C, a nie Pythonie — działa
10–1000× szybciej dla dużych tablic.

### Dlaczego to ważne w symulacji?

Mamy ~50 000 cząstek. W wersji natywnej:
```python
for k in range(sim.N_e):           # 50 000 iteracji Pythona
    c0 = sim.x_e[k] * cs.INV_DX   # jeden float na raz
```

W wersji NumPy:
```python
x  = sim.x_e[:sim.N_e]            # widok na aktywne elektrony
c0 = x * cs.INV_DX                # mnożenie 50 000 floatów naraz (w C!)
```

---

## 2. Tworzenie tablic

```python
# Z listy
a = np.array([1.0, 2.0, 3.0])

# Zera
b = np.zeros(400)              # 400 zer
b2 = np.zeros((400, 200))     # macierz 400×200 zer

# Puste (bez inicjalizacji — szybsze niż zeros)
c = np.empty(1_000_000)       # 1M elementów, wartości losowe (garbage)

# Zakres (jak range(), ale zwraca tablicę)
d = np.arange(10)             # array([0, 1, 2, ..., 9])
e = np.arange(1_000_000, dtype=np.float64)  # z typem
```

---

## 3. `dtype` — typ danych w tablicy

Każda tablica NumPy przechowuje dane **jednego typu**:

```python
a = np.zeros(10, dtype=np.float64)   # 64-bitowe liczby zmiennoprzecinkowe
b = np.zeros(10, dtype=np.int32)     # 32-bitowe liczby całkowite
c = np.zeros(10, dtype=np.int64)     # 64-bitowe liczby całkowite
```

W symulacji:
- Pozycje i prędkości cząstek: `dtype=np.float64` (potrzebna precyzja)
- Liczniki IFED: `dtype=np.int64`
- Indeksy węzłów siatki `p`: konwertujemy na `np.int32`

### Konwersja typów: `.astype()`

```python
c0 = np.array([1.73, 2.54, 0.88])     # float64

p = c0.astype(np.int32)               # obcięcie do int: [1, 2, 0]
# UWAGA: astype obcina, nie zaokrągla!
# 1.73 → 1,  2.54 → 2,  0.88 → 0

p_f = p.astype(np.float64)            # z powrotem do float: [1.0, 2.0, 0.0]
```

W kodzie symulacji:
```python
c0 = x * cs.INV_DX              # float64: np. [1.73, 2.54, 0.88]
p  = c0.astype(np.int32)        # int32:   [1, 2, 0]  ← lewy węzeł siatki
p_f = p.astype(np.float64)      # float64: [1.0, 2.0, 0.0] ← do obliczeń
```

---

## 4. Operacje wektorowe — wszystko naraz

Operatory arytmetyczne (+, -, *, /, **) działają na każdym elemencie:

```python
a = np.array([1.0, 2.0, 3.0, 4.0])
b = np.array([10., 20., 30., 40.])

a + b     # array([11., 22., 33., 44.])
a * 2.0   # array([ 2.,  4.,  6.,  8.])
a ** 2    # array([ 1.,  4.,  9., 16.])
np.sqrt(a)# array([1., 1.414, 1.732, 2.])
np.exp(-a)# exp na każdym elemencie
```

Przykład z symulacji — obliczanie p_coll dla wszystkich cząstek naraz:

```python
# Native (pętla):
for k in range(sim.N_e):
    nu = sigma_tot_e[energy_index] * velocity
    p_coll = 1.0 - math.exp(-nu * DT_E)

# NumPy (wektorowo):
nu     = sim.sigma_tot_e[e_idx] * velocity   # tablica × tablica
p_coll = 1.0 - np.exp(-nu * cs.DT_E)        # exp na całej tablicy
```

---

## 5. Slicowanie — widoki na fragment tablicy

```python
a = np.array([10., 20., 30., 40., 50., 60.])

a[2]       # 30.0  — jeden element
a[1:4]     # array([20., 30., 40.])  — elementy 1,2,3
a[:3]      # array([10., 20., 30.])  — od początku do 3
a[2:]      # array([30., 40., 50., 60.]) — od 2 do końca
a[:-1]     # array([10., 20., 30., 40., 50.]) — bez ostatniego
a[1:-1]    # array([20., 30., 40., 50.]) — bez pierwszego i ostatniego
```

### KLUCZOWE: widoki vs kopie

```python
a = np.array([1., 2., 3., 4., 5.])
b = a[1:4]   # b to WIDOK na a, NIE kopia!

b[0] = 99.   # modyfikuje oryginał!
print(a)     # array([ 1., 99.,  3.,  4.,  5.])
```

To fundamentalne dla symulacji:

```python
# simulation.py, step3:
x  = sim.x_e[:sim.N_e]   # widok na aktywne elektrony
vx = sim.vx_e[:sim.N_e]  # widok na ich prędkości

# Ta linia modyfikuje sim.x_e i sim.vx_e bezpośrednio!
vx -= e_x * cs.FACTOR_E   # vx to widok → modyfikuje sim.vx_e
x  += vx  * cs.DT_E       # x  to widok → modyfikuje sim.x_e
```

Gdybyśmy napisali `x = sim.x_e[:sim.N_e].copy()`, to `x += ...` zmodyfikowałoby
tylko lokalną kopię, nie oryginał!

### Slicowanie 2D

Dla tablicy kształtu `(N_G, N_XT) = (400, 200)`:

```python
mat = np.zeros((400, 200))

mat[:, t_index]    # cała kolumna t_index — typ: array kształtu (400,)
mat[p, :]          # cały wiersz p — typ: array kształtu (200,)
mat[1:-1]          # wiersze 1..398 — slice po pierwszej osi
mat[:-2]           # wiersze 0..397
mat[2:]            # wiersze 2..399
```

W solverze Poissona:
```python
# Oblicz E dla węzłów wewnętrznych (1..N_G-2) naraz:
sim.efield[1:-1] = (sim.pot[:-2] - sim.pot[2:]) * cs.S
#           ↑          ↑              ↑
#       węzły 1..N_G-2  pot[0..N_G-3]  pot[2..N_G-1]
```

---

## 6. Fancy indexing — indeksowanie tablicą

```python
a = np.array([10., 20., 30., 40., 50.])

idx = np.array([0, 2, 4])
a[idx]           # array([10., 30., 50.]) — elementy o indeksach 0, 2, 4

# Możesz też przypisywać:
a[idx] = 99.     # a = [99., 20., 99., 40., 99.]
```

W symulacji — interpolacja pola elektrycznego:

```python
p = np.array([1, 2, 0, 1, ...])   # indeksy węzłów (po jednym na cząstkę)

# Fancy indexing: pobierz efield[p[k]] dla każdego k naraz
e_x = c1 * sim.efield[p] + c2 * sim.efield[p + 1]
```

`sim.efield[p]` to tablica o długości N_e — element `i` to `efield[p[i]]`.
Zamiast pętli `for k: e_x[k] = efield[p[k]]` → jedna operacja wektorowa!

---

## 7. Boolean masking — filtrowanie przez warunek

```python
a = np.array([1., -2., 3., -4., 5.])

mask = a > 0           # array([True, False, True, False, True])
a[mask]                # array([1., 3., 5.]) — tylko elementy > 0

# Zliczanie:
np.sum(mask)           # 3 (liczba True)

# Odwrócenie:
~mask                  # array([False, True, False, True, False])

# Kombinacje:
mask2 = a < 4
mask & mask2           # AND: a > 0 AND a < 4 → [T, F, T, F, F]
mask | mask2           # OR:  a > 0 OR  a < 4 → [T, T, T, T, T]
```

W kroku 5 (usuwanie cząstek poza granicami):

```python
x = sim.x_e[:sim.N_e]

mask_pow = x < 0.0          # kto wyszedł przez lewą elektrodę
mask_gnd = x > cs.L         # kto wyszedł przez prawą elektrodę
mask_out = mask_pow | mask_gnd  # kto w ogóle wyszedł
mask_keep = ~mask_out       # kto zostaje

# Zachowaj tylko cząstki, które NIE wyszły:
sim.x_e[:n_keep] = sim.x_e[:sim.N_e][mask_keep]
```

---

## 8. `np.where` — znajdź indeksy spełniające warunek

```python
a = np.array([0.1, 0.8, 0.3, 0.9, 0.2])
mask = a > 0.5
np.where(mask)     # (array([1, 3]),)  ← indeksy gdzie True
np.where(mask)[0]  # array([1, 3])     ← wypakowujemy z krotki
```

W kroku 7 (zderzenia):

```python
rands = sim.rng.random(sim.N_e)    # losowe liczby dla każdego elektronu
colliding = np.where(rands < p_coll)[0]  # indeksy elektronów, które się zderzają

for k in colliding:                # pętla tylko po ~5% cząstek
    collisions.collision_electron(sim, int(k), int(e_idx[k]))
```

---

## 9. `np.clip` — ograniczanie wartości do zakresu

```python
a = np.array([-1, 0, 1, 5, 10, 20])
np.clip(a, 0, 8)   # array([0, 0, 1, 5, 8, 8])
#              ↑↑ min i max
```

W symulacji — zabezpieczenie indeksu węzła siatki:

```python
p = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
# Jeśli cząstka jest dokładnie na granicy lub minimalnie poza:
# c0 = N_G-1.0001 → int = N_G-1 = 399 → ale p+1 = 400 → out of bounds!
# np.clip gwarantuje: 0 ≤ p ≤ N_G-2 = 398, więc p+1 ≤ 399 ✓
```

---

## 10. `np.minimum` / `np.maximum` — element-wise min/max

```python
a = np.array([1, 5, 2, 8])
np.minimum(a, 4)    # array([1, 4, 2, 4]) — każdy element ≤ 4
np.maximum(a, 3)    # array([3, 5, 3, 8]) — każdy element ≥ 3
```

W symulacji — ograniczanie indeksu tablicy przekrojów czynnych:

```python
e_idx = np.minimum(
    (energy / cs.DE_CS + 0.5).astype(np.int32),
    cs.CS_RANGES - 1           # nie wychodź poza tablicę!
)
```

---

## 11. Generator liczb losowych: `np.random.default_rng()`

```python
rng = np.random.default_rng()   # inicjalizacja generatora

rng.random(1000)                # 1000 liczb z [0, 1)
rng.random()                    # jedna liczba (skalar)
rng.normal(0.0, sigma, 1000)    # 1000 liczb z rozkładu normalnego N(0, σ)
```

Porównanie z native:
```python
# Native:
for k in range(sim.N_i):
    vx_a = sim.rng.gauss(0.0, NORMAL_DISTRIBUTION)  # jedna liczba

# NumPy:
vx_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)  # N_i liczb naraz
```

---

## Podsumowanie — ściągawka NumPy dla tego projektu

| Operacja | Składnia | Co robi |
|:---------|:---------|:--------|
| Widok na aktywne cząstki | `sim.x_e[:sim.N_e]` | Bez kopiowania, modyfikowalny |
| Konwersja na int (obcięcie) | `arr.astype(np.int32)` | float → int, obcina ułamek |
| Ograniczanie zakresu | `np.clip(arr, 0, N-2)` | Każdy element w [0, N-2] |
| Element-wise minimum | `np.minimum(arr, MAX)` | Każdy element ≤ MAX |
| Fancy indexing | `efield[p]` gdzie p to array | p[i]-ty element dla każdego i |
| Boolean mask | `x < 0` | Array True/False |
| Filtrowanie | `arr[mask]` | Tylko elementy gdzie mask==True |
| Indeksy True | `np.where(mask)[0]` | Array indeksów gdzie True |
| Scatter-add | `np.add.at(arr, idx, val)` | `arr[idx[i]] += val[i]` bezpiecznie |
| Losowe liczby | `rng.random(N)` | N liczb z [0,1) naraz |
| Normalne | `rng.normal(0, sigma, N)` | N liczb z N(0, σ) |
| Wektorowy exp | `np.exp(arr)` | exp na każdym elemencie |
| Wektorowy sqrt | `np.sqrt(arr)` | sqrt na każdym elemencie |
| Suma | `np.sum(arr)` | Suma wszystkich elementów |
| Maximum | `np.max(arr)` | Maksimum ze wszystkich elementów |

---

**Następna lekcja:** [Lekcja 2 — Struktura projektu i klasa SimulationState](lekcja_02.md)
