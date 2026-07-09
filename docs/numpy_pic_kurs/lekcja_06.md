# Lekcja 6: Krok 5 & 6 — Warunki brzegowe: boolean masking zamiast swap

> **Poprzednia lekcja:** [Lekcja 5 — Ruch cząstek](lekcja_05.md)
> **Następna lekcja:** [Lekcja 7 — Zderzenia Monte Carlo](lekcja_07.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Jak boolean masking zastępuje algorytm "swap z ostatnim"
- Dlaczego `mask_keep = ~mask_out` jest centralną operacją
- Jak filtrowanie tablic (fancy indexing z maską) usuwa cząstki
- Jak `np.sum(mask)` zlicza pochłonięte cząstki
- Jak IFED dla jonów jest obliczane wektorowo

---

## 1. Przypomnienie: Co robi krok 5?

Po przesunięciu cząstek, część elektronów znalazła się poza elektrodami:
- `x < 0` → pochłonięte przez lewą elektrodę
- `x > L` → pochłonięte przez prawą elektrodę

Musimy je **usunąć** z tablic i zaktualizować liczniki `N_e`, `N_i`.

---

## 2. Wersja natywna — swap z ostatnim

```python
# native_version/simulation.py — step5_check_boundaries_electrons

k = 0
while k < sim.N_e:
    out = False
    if sim.x_e[k] < 0:
        sim.N_e_abs_pow += 1
        out = True
    if sim.x_e[k] > cs.L:
        sim.N_e_abs_gnd += 1
        out = True
    if out:
        # Zamień usuwaną cząstkę z ostatnią aktywną
        sim.x_e[k]  = sim.x_e[sim.N_e - 1]
        sim.vx_e[k] = sim.vx_e[sim.N_e - 1]
        sim.vy_e[k] = sim.vy_e[sim.N_e - 1]
        sim.vz_e[k] = sim.vz_e[sim.N_e - 1]
        sim.N_e -= 1
    else:
        k += 1
```

Złożoność: O(N_e) iteracji Pythona, ale zachowuje kolejność cząstek częściowo.
Algorytm "swap z ostatnim" jest O(1) na usunięcie — ale piszemy pętlę w Pythonie.

---

## 3. Wersja NumPy — boolean masking

```python
# numpy_version/simulation.py — step5_check_boundaries_electrons

def step5_check_boundaries_electrons(sim: SimulationState):
    x = sim.x_e[:sim.N_e]          # (1) widok na aktywne elektrony

    mask_pow = x < 0.0              # (2) kto wyszedł przez lewą elektrodę
    mask_gnd = x > cs.L             # (2) kto wyszedł przez prawą elektrodę
    mask_out = mask_pow | mask_gnd  # (3) kto w ogóle wyszedł

    sim.N_e_abs_pow += int(np.sum(mask_pow))  # (4) zlicz pochłoniętych
    sim.N_e_abs_gnd += int(np.sum(mask_gnd))  # (4)

    mask_keep = ~mask_out           # (5) kto zostaje
    n_keep    = int(np.sum(mask_keep))  # (6) ile zostaje

    sim.x_e[:n_keep]  = sim.x_e[:sim.N_e][mask_keep]   # (7) przepakuj
    sim.vx_e[:n_keep] = sim.vx_e[:sim.N_e][mask_keep]  # (7)
    sim.vy_e[:n_keep] = sim.vy_e[:sim.N_e][mask_keep]  # (7)
    sim.vz_e[:n_keep] = sim.vz_e[:sim.N_e][mask_keep]  # (7)
    sim.N_e = n_keep                                     # (8)
```

---

## 4. Krok po kroku

### (1) Widok na aktywne elektrony

```python
x = sim.x_e[:sim.N_e]   # shape: (N_e,)
```

Jak zawsze — bez kopiowania, tylko aktywne.

### (2) Maski warunków

```python
mask_pow = x < 0.0    # shape: (N_e,), dtype bool
mask_gnd = x > cs.L   # shape: (N_e,), dtype bool
```

Operatory porównania na tablicach zwracają tablice `bool`:
```
x:        [-0.01, 0.015, 0.03, -0.001, 0.02]
mask_pow:  [True, False, False,  True, False]   # x < 0
mask_gnd:  [False, False, True, False, False]   # x > L (=0.025)
```

### (3) Suma logiczna (OR)

```python
mask_out = mask_pow | mask_gnd
```

`|` to operator **bitowy OR** na tablicach bool (odpowiednik `or` dla list):
```
mask_pow:  [True,  False, False, True, False]
mask_gnd:  [False, False, True,  False, False]
mask_out:  [True,  False, True,  True,  False]  # wyszedł gdziekolwiek
```

### (4) Zliczanie pochłoniętych cząstek

```python
sim.N_e_abs_pow += int(np.sum(mask_pow))
sim.N_e_abs_gnd += int(np.sum(mask_gnd))
```

`np.sum(mask)` zlicza wartości `True` (True = 1, False = 0).

```
np.sum([True, False, False, True, False]) = 2
```

`int(...)` konwertuje wynik NumPy na skalar Python — bezpieczna konwersja.

### (5) Maska "zostaje"

```python
mask_keep = ~mask_out
```

`~` to operator **bitowy NOT** na tablicach bool (negacja):
```
mask_out:  [True,  False, True,  True,  False]
mask_keep: [False, True,  False, False, True]   # NIE wyszedł
```

### (6) Ile cząstek zostaje

```python
n_keep = int(np.sum(mask_keep))   # liczba True w mask_keep
```

### (7) Przepakowanie tablic — fancy indexing z maską

```python
sim.x_e[:n_keep] = sim.x_e[:sim.N_e][mask_keep]
```

To jest kluczowa operacja. Rozbijmy ją na części:

```python
sim.x_e[:sim.N_e][mask_keep]
```

1. `sim.x_e[:sim.N_e]` → widok shape `(N_e,)`
2. `[mask_keep]` → **fancy indexing** z maską bool → tworzy KOPIĘ z elementami gdzie mask_keep==True

Wynik: nowa tablica shape `(n_keep,)` zawierająca tylko "żyjące" cząstki.

```python
sim.x_e[:n_keep] = ...
```

Przypisujemy tę kopię do pierwszych `n_keep` slotów tablicy `sim.x_e`.

**Wizualizacja:**

```
Przed:
sim.x_e: [A, B, C, D, E, ...]
          ↑        ↑  ↑       ← indeksy 0, 2, 3 wyszły poza granicę (mask_out=True)
mask_keep: [F, T, F, F, T]   ← B i E zostają

sim.x_e[:sim.N_e][mask_keep] = [B, E]

Po:
sim.x_e: [B, E, C, D, E, ...]   ← B i E na pozycjach 0,1; reszta nieistotna
sim.N_e = 2
```

### (8) Aktualizacja licznika

```python
sim.N_e = n_keep
```

Teraz tylko pierwsze `n_keep` pozycji w tablicach jest aktywnych.

---

## 5. Czy boolean masking zmienia kolejność cząstek?

**Tak.** Cząstki, które zostają, są przepakowane na **początku** tablic, ale ich
kolejność wzajemna jest zachowana (np. B przed E, tak jak były).

W algorytmie "swap z ostatnim" kolejność może się zmienić (ostatnia cząstka ląduje
na miejscu usuniętej). W NumPy kolejność jest zachowana, ale to nie ma znaczenia
dla fizyki — cząstki są bezimienne.

---

## 6. Krok 6 — warunki brzegowe jonów + IFED

```python
# numpy_version/simulation.py — step6_check_boundaries_ions

def step6_check_boundaries_ions(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        return

    x  = sim.x_i[:sim.N_i]
    vx = sim.vx_i[:sim.N_i]
    vy = sim.vy_i[:sim.N_i]
    vz = sim.vz_i[:sim.N_i]

    mask_pow = x < 0.0
    mask_gnd = x > cs.L
    mask_out = mask_pow | mask_gnd

    sim.N_i_abs_pow += int(np.sum(mask_pow))
    sim.N_i_abs_gnd += int(np.sum(mask_gnd))

    # Oblicz IFED dla wszystkich jonów (wektorowo)
    v_sqr  = vx**2 + vy**2 + vz**2
    energy = 0.5 * cs.AR_MASS * v_sqr / cs.EV_TO_J   # (N_i,) energii

    # Dla każdej elektrody: wybierz pochłoniętych i zbuduj histogram
    for mask, ifed in [(mask_pow, sim.ifed_pow), (mask_gnd, sim.ifed_gnd)]:
        e_abs = energy[mask]                          # energie pochłoniętych jonów
        idx   = (e_abs / cs.DE_IFED).astype(np.int64) # bin IFED
        valid = idx < cs.N_IFED                       # w zakresie histogramu
        np.add.at(ifed, idx[valid], 1)                # doliczy histogram

    # Przepakuj jak dla elektronów
    mask_keep = ~mask_out
    n_keep    = int(np.sum(mask_keep))
    sim.x_i[:n_keep]  = sim.x_i[:sim.N_i][mask_keep]
    sim.vx_i[:n_keep] = sim.vx_i[:sim.N_i][mask_keep]
    sim.vy_i[:n_keep] = sim.vy_i[:sim.N_i][mask_keep]
    sim.vz_i[:n_keep] = sim.vz_i[:sim.N_i][mask_keep]
    sim.N_i = n_keep
```

### IFED — wektorowa akumulacja histogramu

Natywnie IFED był liczony w pętli:
```python
# Native:
if sim.x_i[k] < 0:
    energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
    energy_index = int(energy / DE_IFED)
    if energy_index < N_IFED:
        sim.ifed_pow[energy_index] += 1
```

NumPy — wszystkie pochłonięte jony naraz:

```python
# 1. Oblicz energię WSZYSTKICH jonów (wektorowo)
v_sqr  = vx**2 + vy**2 + vz**2           # (N_i,)
energy = 0.5 * cs.AR_MASS * v_sqr / cs.EV_TO_J  # (N_i,)

# 2. Wybierz pochłoniętych przez lewą elektrodę
e_abs = energy[mask_pow]                  # (N_pow_absorbed,) — energii tych jonów

# 3. Oblicz indeksy binów IFED
idx   = (e_abs / cs.DE_IFED).astype(np.int64)  # (N_pow_absorbed,)

# 4. Filtruj zakres
valid = idx < cs.N_IFED                         # maska bool

# 5. Histogramuj
np.add.at(sim.ifed_pow, idx[valid], 1)          # dodaj 1 do każdego binu
```

### Pętla `for mask, ifed in [...]`

```python
for mask, ifed in [(mask_pow, sim.ifed_pow), (mask_gnd, sim.ifed_gnd)]:
```

To idiom Pythona — iterujemy po **parach** (maska, histogram), żeby nie powielać
kodu dla lewej i prawej elektrody. Elegancki sposób na "kod bez duplikacji".

---

## 7. Dlaczego boolean masking jest szybszy niż swap?

| Aspekt | Swap z ostatnim (native) | Boolean masking (NumPy) |
|:-------|:------------------------|:------------------------|
| Pętla Pythona | TAK (N_e iteracji) | NIE |
| Operacje C | Nie | Tak (wszystko w C) |
| Zachowanie kolejności | Nie (swap losuje kolejność) | Tak |
| Dodatkowa pamięć | Stała O(1) | O(N_e) na maski |

Przy N_e = 50 000 cząstek, pętla Pythona to ~50 000 wywołań interpretera.
Operacje tablicowe NumPy to ~5 wywołań funkcji C (każda przetwarza całą tablicę).

---

## Podsumowanie

| Operacja | Native | NumPy |
|:---------|:-------|:------|
| Sprawdź granicę | `if x_e[k] < 0` w pętli | `mask_pow = x < 0.0` (wektorowo) |
| OR warunków | `if ... or ...` | `mask_out = mask_pow \| mask_gnd` |
| Zliczanie | `counter += 1` w pętli | `int(np.sum(mask))` |
| Usuwanie | swap z ostatnim | `arr[:n_keep] = arr[:N][mask_keep]` |
| IFED | `if energy_index < N: ifed[idx] += 1` | `np.add.at(ifed, idx[valid], 1)` |

### Kluczowe operatory NumPy bool

| Operator | Znaczenie | Przykład |
|:---------|:----------|:---------|
| `<`, `>`, `==` | Porównanie element-wise | `x < 0` |
| `\|` | OR bit-wise (bool) | `mask_a \| mask_b` |
| `&` | AND bit-wise (bool) | `mask_a & mask_b` |
| `~` | NOT bit-wise (bool) | `~mask_out` |
| `arr[mask]` | Filtrowanie | Tylko elementy gdzie mask==True |
| `np.sum(mask)` | Zliczanie True | Liczba elementów spełniających warunek |

---

**Następna lekcja:** [Lekcja 7 — Zderzenia Monte Carlo: `np.where` + pętla po ~5%](lekcja_07.md)
