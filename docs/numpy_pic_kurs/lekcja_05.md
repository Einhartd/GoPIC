# Lekcja 5: Krok 3 & 4 — Ruch cząstek: wektoryzacja Leapfroga

> **Poprzednia lekcja:** [Lekcja 4 — Solver Poissona](lekcja_04.md)
> **Następna lekcja:** [Lekcja 6 — Warunki brzegowe](lekcja_06.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Jak interpolacja pola E z siatki na cząstki jest wektoryzowana
- Dlaczego `vx -= e_x * FACTOR_E` modyfikuje `sim.vx_e` (widoki!)
- Jak `e_x = c1 * efield[p] + c2 * efield[p+1]` działa jako fancy indexing
- Jak diagnostyki w trybie pomiarowym są wektoryzowane z `np.add.at`
- Jak `center_mask` filtruje elektrony w centrum plazmy

---

## 1. Przypomnienie: co robi krok 3?

Dla każdego elektronu:
1. Interpoluj pole E z siatki na pozycję cząstki
2. Zaktualizuj prędkość: `vx -= FACTOR_E × E` (leapfrog)
3. Zaktualizuj pozycję: `x += vx × DT_E`

---

## 2. Wersja natywna — pętla po elektronach

```python
# native_version/simulation.py — step3_move_electrons

for k in range(sim.N_e):
    c0 = sim.x_e[k] * cs.INV_DX     # pozycja w jednostkach siatki
    p  = int(c0)                      # lewy węzeł
    c1 = p + 1.0 - c0               # waga lewego węzła
    c2 = c0 - p                      # waga prawego węzła
    e_x = c1 * sim.efield[p] + c2 * sim.efield[p+1]  # interpolacja E

    # [diagnostyki pominięte dla jasności]

    sim.vx_e[k] -= e_x * cs.FACTOR_E   # aktualizacja prędkości
    sim.x_e[k]  += sim.vx_e[k] * cs.DT_E   # aktualizacja pozycji
```

---

## 3. Wersja NumPy — kompletny krok 3

```python
# numpy_version/simulation.py — step3_move_electrons

def step3_move_electrons(sim: SimulationState, t_index: int):
    x  = sim.x_e[:sim.N_e]    # (1) widok na pozycje
    vx = sim.vx_e[:sim.N_e]   # (1) widok na prędkości x
    vy = sim.vy_e[:sim.N_e]   # (1) widok na prędkości y
    vz = sim.vz_e[:sim.N_e]   # (1) widok na prędkości z

    c0 = x * cs.INV_DX                             # (2)
    p  = np.clip(c0.astype(np.int32), 0, cs.N_G-2) # (3)
    p_f = p.astype(np.float64)                      # (4)
    c1 = p_f + 1.0 - c0                             # (5) wagi lewego węzła
    c2 = c0 - p_f                                   # (5) wagi prawego węzła
    e_x = c1 * sim.efield[p] + c2 * sim.efield[p+1] # (6) interpolacja E

    if sim.measurement_mode:                         # (7) diagnostyki
        # ... (patrz sekcja 5)

    vx -= e_x * cs.FACTOR_E   # (8) aktualizacja prędkości (in-place, przez widok)
    x  += vx  * cs.DT_E       # (9) aktualizacja pozycji  (in-place, przez widok)
```

---

## 4. Krok po kroku

### (1) Widoki na aktywne cząstki

```python
x  = sim.x_e[:sim.N_e]
vx = sim.vx_e[:sim.N_e]
```

`x` i `vx` to **widoki** — nie kopie. Kształt: `(N_e,)`.

Kluczowe: gdy potem piszemy `vx -= ...`, modyfikujemy **oryginalne** `sim.vx_e`!

### (2) Pozycja w jednostkach siatki

```python
c0 = x * cs.INV_DX   # shape: (N_e,), wartości np. [1.754, 23.9, 0.41, ...]
```

Mnożenie tablicy przez skalar — wektorowe.

### (3) Lewy węzeł z clip

```python
p = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
```

Tak samo jak w depozycji (Lekcja 3) — obcinamy float do int, clip gwarantuje `0 ≤ p ≤ 398`.

### (4–5) Wagi interpolacji

```python
p_f = p.astype(np.float64)
c1  = p_f + 1.0 - c0    # waga lewego węzła, shape: (N_e,)
c2  = c0 - p_f           # waga prawego węzła, shape: (N_e,)
```

Operacje wektorowe. Dla i-tej cząstki:
- `c1[i] = p[i] + 1 - c0[i]` (jak blisko lewego węzła)
- `c2[i] = c0[i] - p[i]`     (jak blisko prawego węzła)

### (6) Interpolacja pola E — fancy indexing!

```python
e_x = c1 * sim.efield[p] + c2 * sim.efield[p + 1]
```

To jest **najważniejsza** linia kroku 3. Rozłóżmy ją:

- `sim.efield` to tablica shape `(N_G,) = (400,)`
- `p` to tablica int kształtu `(N_e,)`, np. `[1, 23, 0, 5, ...]`
- `sim.efield[p]` → **fancy indexing**: dla każdego i, weź `efield[p[i]]`
  - Wynik: shape `(N_e,)`, np. `[efield[1], efield[23], efield[0], efield[5], ...]`
- `sim.efield[p + 1]` → indeksujemy `p+1` (prawy węzeł)

```python
# Odpowiednik native per-cząstka:
e_x[k] = c1[k] * efield[p[k]] + c2[k] * efield[p[k]+1]

# NumPy: wszystkie cząstki naraz
e_x = c1 * efield[p] + c2 * efield[p + 1]
#      ↑        ↑              ↑
#   (N_e,)   (N_e,)          (N_e,)  — wszystko element po elemencie
```

**Przykład numeryczny:**

```
efield: [100, 200, 300, 400, ...]
p:      [  1,   2,   0,   3, ...]
c1:     [0.3, 0.7, 0.9, 0.1, ...]
c2:     [0.7, 0.3, 0.1, 0.9, ...]

efield[p]:     [efield[1], efield[2], efield[0], efield[3]] = [200, 300, 100, 400]
efield[p+1]:   [efield[2], efield[3], efield[1], efield[4]] = [300, 400, 200, 500]

e_x = c1 * efield[p] + c2 * efield[p+1]
    = [0.3×200 + 0.7×300, 0.7×300 + 0.3×400, 0.9×100 + 0.1×200, ...]
    = [60+210, 210+120, 90+20, ...]
    = [270, 330, 110, ...]
```

### (8–9) Aktualizacja prędkości i pozycji

```python
vx -= e_x * cs.FACTOR_E   # vx_e[k] -= e_x[k] * FACTOR_E dla wszystkich k
x  += vx  * cs.DT_E       # x_e[k]  += vx_e[k] * DT_E    dla wszystkich k
```

`vx` i `x` to widoki na `sim.vx_e` i `sim.x_e`. Operacje `in-place` (`-=`, `+=`)
modyfikują dane w miejscu → automatycznie modyfikują oryginalne tablice symulacji.

> **Ważne:** `vx -= e_x * FACTOR_E` jest równoważne `vx[:] = vx - e_x * FACTOR_E`.
> Modyfikacja in-place widoku zmienia oryginał — **to jest zamierzone!**

---

## 5. Diagnostyki w trybie pomiarowym

```python
if sim.measurement_mode:
    mean_v = vx - 0.5 * e_x * cs.FACTOR_E  # (A) prędkość "w połowie kroku"
    np.add.at(sim.counter_e_xt[:, t_index], p,     c1)  # (B)
    np.add.at(sim.counter_e_xt[:, t_index], p + 1, c2)  # (B)
    np.add.at(sim.ue_xt[:, t_index], p,     c1 * mean_v)  # (C)
    np.add.at(sim.ue_xt[:, t_index], p + 1, c2 * mean_v)  # (C)

    v_sqr  = mean_v**2 + vy**2 + vz**2     # (D)
    energy = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J  # (D)
    np.add.at(sim.meanee_xt[:, t_index], p,     c1 * energy)  # (E)
    np.add.at(sim.meanee_xt[:, t_index], p + 1, c2 * energy)  # (E)

    e_idx  = np.minimum((energy / cs.DE_CS + 0.5).astype(np.int32), cs.CS_RANGES-1)  # (F)
    rate   = sim.sigma[cs.E_ION, e_idx] * np.sqrt(v_sqr) * cs.DT_E * cs.GAS_DENSITY  # (G)
    np.add.at(sim.ioniz_rate_xt[:, t_index], p,     c1 * rate)  # (H)
    np.add.at(sim.ioniz_rate_xt[:, t_index], p + 1, c2 * rate)  # (H)

    # EEPF w centrum
    center_mask = (x > cs.MIN_X) & (x < cs.MAX_X)  # (I)
    e_center    = energy[center_mask]                # (J)
    eepf_idx    = (e_center / cs.DE_EEPF).astype(np.int32)  # (K)
    valid       = eepf_idx < cs.N_EEPF              # (L)
    np.add.at(sim.eepf, eepf_idx[valid], 1.0)       # (M)
    sim.mean_energy_accu_center    += float(np.sum(e_center))   # (N)
    sim.mean_energy_counter_center += int(np.sum(center_mask))  # (N)
```

### (A) Prędkość "w połowie kroku" — leapfrog

```python
mean_v = vx - 0.5 * e_x * cs.FACTOR_E
```

W schemacie Leapfrog prędkość `vx` jest w czasie `t - Δt/2`. Chcemy prędkość
w czasie `t` dla diagnostyk:
```
v(t) ≈ v(t-Δt/2) + a × Δt/2 = vx - 0.5 × e_x × FACTOR_E
```
Operacja wektorowa — `mean_v` to tablica shape `(N_e,)`.

### (B) Licznik cząstek na siatce XT

```python
np.add.at(sim.counter_e_xt[:, t_index], p,     c1)
np.add.at(sim.counter_e_xt[:, t_index], p + 1, c2)
```

`sim.counter_e_xt[:, t_index]` → kolumna `t_index` z tablicy 2D `(N_G, N_XT)`.
To jest **tablica shape `(N_G,) = (400,)`**.

`np.add.at(col, p, c1)` → dla każdej cząstki k, dodaj `c1[k]` do `col[p[k]]`.
Jak zwykle — bezpieczne scatter-add dla duplikatów indeksów.

### (D–E) Energia elektronów

```python
v_sqr  = mean_v**2 + vy**2 + vz**2    # kwadrat prędkości 3D (N_e,)
energy = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J  # energia [eV] (N_e,)
```

Operacje wektorowe — `**2` i suma tablic.

### (F–G) Indeks tablicy przekrojów i wskaźnik jonizacji

```python
e_idx = np.minimum((energy / cs.DE_CS + 0.5).astype(np.int32), cs.CS_RANGES-1)
```

Dla każdego elektronu zamień energię [eV] na indeks w tablicy sigma.

```python
rate = sim.sigma[cs.E_ION, e_idx] * np.sqrt(v_sqr) * cs.DT_E * cs.GAS_DENSITY
```

`sim.sigma[cs.E_ION, e_idx]` — dwuwymiarowe indeksowanie tablicy sigma kształtu `(N_CS, CS_RANGES)`:
- `cs.E_ION` = 2 → wybiera wiersz (typ zderzenia)
- `e_idx` = tablica indeksów → fancy indexing po kolumnach

Wynik: `rate` kształtu `(N_e,)` — wskaźnik jonizacji dla każdego elektronu.

### (I–M) EEPF w centrum — boolean masking i filtrowanie

```python
center_mask = (x > cs.MIN_X) & (x < cs.MAX_X)  # (I)
```

`center_mask`: tablica `(N_e,)` dtype bool — True dla elektronów w centrum plazmy.

```python
e_center = energy[center_mask]                   # (J)
```

**Boolean masking:** wyciąga tylko energię elektronów w centrum.
Jeśli `N_e = 50 000` i `N_center = 5 000` → `e_center` ma kształt `(5000,)`.

```python
eepf_idx = (e_center / cs.DE_EEPF).astype(np.int32)  # (K)
valid    = eepf_idx < cs.N_EEPF                        # (L)
np.add.at(sim.eepf, eepf_idx[valid], 1.0)             # (M)
```

- `eepf_idx`: indeks binu EEPF dla każdego elektronu w centrum
- `valid`: maska — tylko energie w zakresie tablicy EEPF (< N_EEPF)
- `eepf_idx[valid]`: tylko indeksy w zakresie
- `np.add.at(eepf, indeksy, 1.0)`: dolicza każdy elektron do odpowiedniego binu

---

## 6. Krok 4 — ruch jonów (analogiczny, z różnicami)

```python
def step4_move_ions(sim, t_index, t):
    if (t % cs.N_SUB) != 0:
        return   # subcycling

    x  = sim.x_i[:sim.N_i]
    vx = sim.vx_i[:sim.N_i]
    # ... (identyczne bloki jak dla elektronów) ...

    vx += e_x * cs.FACTOR_I   # ← PLUS (jony mają ładunek +)
    x  += vx  * cs.DT_I       # ← DT_I (krok jonowy)
```

Jedyne różnice:
- `+= FACTOR_I` zamiast `-= FACTOR_E` (znak ładunku)
- `DT_I` zamiast `DT_E` (krok czasowy jonów)
- Subcycling: `if (t % N_SUB) != 0: return`

---

## 7. Porównanie — pętla vs wektorowo

```python
# ── NATIVE ──────────────────────────────────────────────────────────────────
for k in range(sim.N_e):        # N_e iteracji wolnego Pythona
    c0 = sim.x_e[k] * cs.INV_DX
    p  = int(c0)
    c1 = p + 1.0 - c0
    c2 = c0 - p
    e_x = c1 * sim.efield[p] + c2 * sim.efield[p+1]
    sim.vx_e[k] -= e_x * cs.FACTOR_E
    sim.x_e[k]  += sim.vx_e[k] * cs.DT_E

# ── NUMPY ────────────────────────────────────────────────────────────────────
x  = sim.x_e[:sim.N_e]       # widok, O(1)
vx = sim.vx_e[:sim.N_e]      # widok, O(1)
c0 = x * cs.INV_DX           # (N_e,) mnożenie w C
p  = np.clip(c0.astype(np.int32), 0, cs.N_G-2)  # w C
p_f = p.astype(np.float64)   # w C
c1 = p_f + 1.0 - c0          # (N_e,) w C
c2 = c0 - p_f                # (N_e,) w C
e_x = c1*sim.efield[p] + c2*sim.efield[p+1]   # fancy indexing + mnożenie w C
vx -= e_x * cs.FACTOR_E      # (N_e,) in-place w C → modyfikuje sim.vx_e
x  += vx  * cs.DT_E          # (N_e,) in-place w C → modyfikuje sim.x_e
```

---

## Podsumowanie

| Operacja | Native | NumPy |
|:---------|:-------|:------|
| Widok na cząstki | `sim.x_e[k]` w pętli | `sim.x_e[:N_e]` (widok) |
| Pozycja siatki | `c0 = x_e[k] * INV_DX` | `c0 = x * INV_DX` |
| Lewy węzeł | `int(c0)` | `np.clip(c0.astype(int32), 0, N-2)` |
| Interpolacja E | `c1*efield[p] + c2*efield[p+1]` | Fancy indexing: to samo, ale na tablicach |
| Aktualizacja v | `vx_e[k] -= ...` | `vx -= ...` (widok, in-place) |
| Aktualizacja x | `x_e[k] += ...` | `x += ...` (widok, in-place) |
| EEPF w centrum | `if MIN_X < x_e[k] < MAX_X` | `center_mask = (x>MIN_X)&(x<MAX_X)` |
| Diagnostyki XT | `ue_xt[p][t] += c1 * mean_v` | `np.add.at(ue_xt[:,t], p, c1*mean_v)` |

### Kluczowa pułapka: widoki i in-place

```python
x  = sim.x_e[:sim.N_e]   # widok
x += vx * cs.DT_E        # modyfikuje sim.x_e ← ZAMIERZONE

# vs.

x  = sim.x_e[:sim.N_e].copy()  # kopia
x += vx * cs.DT_E               # modyfikuje tylko kopię ← BUG (nic nie zmienia w sim)
```

---

**Następna lekcja:** [Lekcja 6 — Warunki brzegowe: boolean masking zamiast swap](lekcja_06.md)
