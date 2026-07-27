# Lekcja 7: Krok 3 & 4 — Ruch cząstek (schemat Leapfrog)

> **Poprzednia lekcja:** [Lekcja 6 — Solver Poissona](lekcja_06.md)
> **Następna lekcja:** [Lekcja 8 — Warunki brzegowe](lekcja_08.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Na czym polega schemat całkowania Leapfrog i dlaczego go używamy
- Jak interpolujemy pole E z siatki na pozycję cząstki
- Dlaczego elektrony mają **minus** a jony **plus** przy aktualizacji prędkości
- Co dokładnie robi każda linia `step3_move_electrons()` i `step4_move_ions()`
- Jak subcycling jonów wpływa na krok całkowania

---

## 1. Problem: jak poruszać cząstką pod wpływem pola?

Mamy cząstkę o masie `m`, ładunku `q`, w polu elektrycznym `E`.
Chcemy scałkować równania ruchu Newtona:

```
F = q × E
a = F / m = (q/m) × E

dv/dt = a = (q/m) × E     ← równanie na prędkość
dx/dt = v                  ← równanie na pozycję
```

Najprostsze całkowanie (metoda Eulera) byłoby:
```
v_new = v_old + a × Δt
x_new = x_old + v_new × Δt
```

Ale Euler jest **niestabilny numerycznie** dla oscylacyjnych układów (jak plazma).
Zamiast niego używamy **schematu Leapfrog**.

---

## 2. Schemat Leapfrog

Pomysł: prędkości i pozycje są przesunięte o **pół kroku** w czasie:

```
czas:  0       Δt/2      Δt      3Δt/2     2Δt
       |——————|——————|——————|——————|
x:     x₀            x₁            x₂      ← pozycje co Δt
v:          v_{1/2}       v_{3/2}           ← prędkości co Δt (ale przesunięte!)
```

Równania aktualizacji:
```
v_{n+1/2} = v_{n-1/2} + (q/m) × E(x_n) × Δt
x_{n+1}   = x_n       + v_{n+1/2} × Δt
```

**Zalety Leapfrog:**
- Zachowuje energię bez dryfu (symplektyczny schemat)
- Dokładność drugiego rzędu: błąd ~ Δt²
- Stabilny dla oscylacyjnych układów
- Prosty w implementacji

---

## 3. Interpolacja pola E na pozycję cząstki

Pole `efield[p]` jest znane tylko w węzłach siatki. Cząstka jest między węzłami.
Używamy tej samej interpolacji liniowej co przy depozycji (ale odwrotnie):

```go
c0 = x_e[k] * INV_DX        // pozycja w jednostkach siatki
p  = int(c0)                  // lewy węzeł
c1 = float64(p) + 1.0 - c0   // waga lewego węzła
c2 = c0 - float64(p)          // waga prawego węzła

e_x = c1*efield[p] + c2*efield[p+1]  // interpolowane pole w pozycji cząstki
```

To jest operacja odwrotna do depozycji — w depozycji rozdzielamy ładunek z cząstki
na siatkę, tutaj interpolujemy pole z siatki na pozycję cząstki.

---

## 4. Kod: `step3_move_electrons()`

```go
// main.go, linia 656–699

func step3_move_electrons(t_index int) {
    for k = 0; k < N_e; k++ {   // każdy elektron, każdy krok

        // 1. Interpolacja pola E na pozycję elektronu
        c0 = x_e[k] * INV_DX
        p  = int(c0)
        c1 = float64(p) + 1.0 - c0
        c2 = c0 - float64(p)
        e_x = c1*efield[p] + c2*efield[p+1]

        // 2. Diagnostyki (tylko w trybie pomiarowym)
        if measurement_mode {
            mean_v = vx_e[k] - 0.5*e_x*FACTOR_E   // średnia prędkość w kroku
            // ... zbieranie danych do tablic XT ...
        }

        // 3. Aktualizacja prędkości (LEAPFROG)
        vx_e[k] -= e_x * FACTOR_E   // ← MINUS dla elektronu (ładunek ujemny!)

        // 4. Aktualizacja pozycji
        x_e[k] += vx_e[k] * DT_E
    }
}
```

### Dlaczego `vx_e[k] -= e_x * FACTOR_E` (minus)?

Elektron ma **ładunek ujemny**: `q = -e`.
Siła na elektron: `F = q × E = -e × E`
Przyspieszenie: `a = F/m = -(e/m) × E`
Zmiana prędkości: `Δv = a × Δt = -(e × Δt / m) × E = -FACTOR_E × E`

Stąd `v -= FACTOR_E × E`.

Gdybyś przez pomyłkę napisał `+= FACTOR_E × E`, elektrony poruszałyby się
**w złym kierunku** — plazma by nie istniała!

### `FACTOR_E` — co to dokładnie?

```go
FACTOR_E = DT_E / E_MASS * E_CHARGE
         = 18.4e-12 / 9.1e-31 × 1.6e-19
         ≈ 3.24 × 10⁶  [(m/s) per (V/m)]
```

To ile zmienia się prędkość elektronu (w m/s) na każdy V/m pola elektrycznego,
w czasie jednego kroku DT_E.

### Diagnostyki: `mean_v = vx_e[k] - 0.5*e_x*FACTOR_E`

W schemacie Leapfrog, prędkość `vx_e[k]` przed aktualizacją jest w czasie `t - Δt/2`.
Pozycja `x_e[k]` jest w czasie `t`. Chcemy mieć prędkość i pozycję w **tym samym** czasie
dla diagnostyk. Przybliżamy prędkość w czasie `t` jako:

```
v(t) ≈ v(t - Δt/2) + a × Δt/2 = vx_e[k] - 0.5 × e_x × FACTOR_E
```

(Minus dlatego że idziemy w przód o Δt/2 od chwili t-Δt/2 do t, a przyspieszenie
elektronu ma znak ujemny.)

---

## 5. Kod: `step4_move_ions()`

```go
// main.go, linia 701–733

func step4_move_ions(t_index, t int) {
    if (t % N_SUB) != 0 {
        return    // ← wróć jeśli nie jest to krok jonowy
    }

    for k = 0; k < N_i; k++ {
        // Interpolacja pola E
        c0 = x_i[k] * INV_DX
        p  = int(c0)
        c1 = float64(p) + 1.0 - c0
        c2 = c0 - float64(p)
        e_x = c1*efield[p] + c2*efield[p+1]

        // Diagnostyki
        if measurement_mode {
            mean_v = vx_i[k] + 0.5*e_x*FACTOR_I   // ← PLUS dla jonu!
            // ...
        }

        // Aktualizacja prędkości
        vx_i[k] += e_x * FACTOR_I   // ← PLUS dla jonu (ładunek dodatni!)

        // Aktualizacja pozycji
        x_i[k] += vx_i[k] * DT_I   // ← DT_I, nie DT_E!
    }
}
```

### Kluczowe różnice między jonami a elektronami

| Aspekt | Elektrony | Jony |
|:-------|:----------|:-----|
| Znak prędkości | `vx_e[k] -= e_x * FACTOR_E` | `vx_i[k] += e_x * FACTOR_I` |
| Krok czasowy | `DT_E` ≈ 18.4 ps | `DT_I = 20 × DT_E` ≈ 368 ps |
| Kiedy | Każdy krok | Co 20 kroków |
| `FACTOR_*` | DT_E/m_e × e | DT_I/m_Ar × e |

### Dlaczego `vx_i[k] += e_x * FACTOR_I` (plus)?

Jon Ar⁺ ma **ładunek dodatni**: `q = +e`.
Siła na jon: `F = q × E = +e × E`
Przyspieszenie: `a = F/m = +(e/m) × E`
Zmiana prędkości: `Δv = +FACTOR_I × E`

Stąd `v += FACTOR_I × E`. Elektrony i jony poruszają się w **przeciwnych kierunkach**
pod wpływem tego samego pola.

---

## 6. Schemat Leapfrog w czasie

```
Elektrony:

czas:  t₀       t₁       t₂       t₃
       |——DT_E——|——DT_E——|——DT_E——|
x_e:   x₀       x₁       x₂       x₃
v_e:     v_{1/2}  v_{3/2}  v_{5/2}

Kroki:
  x₁ = x₀ + v_{1/2} × DT_E
  v_{3/2} = v_{1/2} - FACTOR_E × E(x₁) × 1     (FACTOR_E już zawiera DT_E!)
  x₂ = x₁ + v_{3/2} × DT_E
  ...

Jony (co 20 kroków elektronowych):

czas:  t₀                t_{20}             t_{40}
       |——————DT_I———————|——————DT_I————————|
x_i:   x₀               x₁                 x₂
v_i:        v_{1/2}              v_{3/2}

```

---

## 7. Diagnostyki w krokach 3 i 4

W trybie pomiarowym (`measurement_mode = true`) kroki 3 i 4 zbierają dodatkowe dane:

```go
// Dla elektronów (krok 3):
counter_e_xt[p][t_index] += c1       // ile elektronów w węźle p, w chwili t_index
counter_e_xt[p+1][t_index] += c2

ue_xt[p][t_index] += c1 * mean_v    // ważona suma prędkości → srednia prędkość
ue_xt[p+1][t_index] += c2 * mean_v

energy = 0.5 * E_MASS * v_sqr / EV_TO_J
meanee_xt[p][t_index] += c1 * energy  // ważona suma energii → średnia energia

// EEPF (tylko w centrum, 45%–55% szczeliny)
if MIN_X < x_e[k] && x_e[k] < MAX_X {
    energy_index = int(energy / DE_EEPF)
    eepf[energy_index] += 1.0
}
```

`t_index = t / N_BIN` — czas jest podzielony na `N_XT = 200` przedziałów (N_BIN=20 kroków na przedział).

---

## 8. Co może się nie udać?

| Błąd | Objaw | Przyczyna |
|:-----|:------|:---------|
| Zmieniono `+=` na `-=` dla jonów | Jony lecą "pod prąd" | Zły znak sił |
| Użyto `DT_E` zamiast `DT_I` dla jonów | Jony za wolno się poruszają | Zły krok czasowy |
| Zapomniano o warunku subcyclingu | Jony aktualizowane co krok | Brak `if (t % N_SUB) != 0` |
| Zły wskaźnik `p` (poza zakresem) | Panic: index out of range | Cząstka poza siatką (przed krokiem 5) |

Ostatni błąd nie powinien wystąpić w stabilnej symulacji — krok 5 usuwa cząstki
przed granicami. Ale przy źle dobranych parametrach cząstka może przeskoczyć przez
kilka węzłów i wypaść poza `[0, N_G-1]`.

---

## Podsumowanie

| Pojęcie | Wyjaśnienie |
|:--------|:-----------|
| Leapfrog | Schemat całkowania: v i x przesunięte o Δt/2 — stabilny i energetycznie poprawny |
| Interpolacja E | Tak samo jak depozycja, ale odwrotnie: siatka → cząstka |
| `FACTOR_E` | DT_E × e / m_e — skala zmiany prędkości e⁻ na V/m |
| `FACTOR_I` | DT_I × e / m_Ar — skala zmiany prędkości Ar⁺ na V/m |
| Minus dla e⁻ | Ładunek ujemny → siła w kierunku przeciwnym do E |
| Plus dla Ar⁺ | Ładunek dodatni → siła w kierunku E |
| Subcycling | Jony: co 20 kroków (`t % N_SUB != 0 → return`) |

### Co możesz zmienić?

- **Inne masy cząstek**: Zmiana `AR_MASS` lub `E_MASS` automatycznie zmienia `FACTOR_I`/`FACTOR_E`.
- **Inna częstotliwość subcyclingu**: Zmiana `N_SUB` (pamiętaj: też zmień `DT_I`).
- **Dodanie ruchów poprzecznych**: Kod śledzi `vy_e`, `vz_e` przez zderzenia, ale pole
  jest tylko w osi x — możesz rozszerzyć na 2D/3D zmieniając solver Poissona.

---

**Następna lekcja:** [Lekcja 8 — Warunki brzegowe (absorpcja na elektrodach)](lekcja_08.md)
