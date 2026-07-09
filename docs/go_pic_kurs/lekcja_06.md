# Lekcja 6: Krok 2 — Solver Poissona (algorytm Thomasa)

> **Poprzednia lekcja:** [Lekcja 5 — Depozycja gęstości](lekcja_05.md)
> **Następna lekcja:** [Lekcja 7 — Ruch cząstek (Leapfrog)](lekcja_07.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Co to jest równanie Poissona i dlaczego go rozwiązujemy
- Jak dyskretyzuje się równania różniczkowe na siatce
- Co to jest układ trójdiagonalny i algorytm Thomasa
- Jak obliczane jest pole elektryczne z potencjału
- Dlaczego brzegi siatki wymagają specjalnego traktowania

---

## 1. Fizyka: Równanie Poissona

Pole elektryczne w plazmie pochodzi od ładunków. Związek między ładunkiem a polem
elektrycznym opisuje **równanie Poissona**:

```
d²φ/dx² = -ρ/ε₀
```

Gdzie:
- `φ(x)` — potencjał elektryczny [V]
- `ρ(x)` — gęstość ładunku [C/m³]
- `ε₀` — przenikalność elektryczna próżni

A pole elektryczne to po prostu ujemny gradient potencjału:
```
E(x) = -dφ/dx
```

**Warunki brzegowe:**
- `φ(0) = V₀ × cos(ω·t)` — elektroda zasilana (napięcie RF)
- `φ(L) = 0` — elektroda uziemiona (masa)

---

## 2. Dyskretyzacja — metoda różnic skończonych

Na siatce numerycznej zastępujemy pochodne **różnicami skończonymi**:

```
d²φ/dx²  ≈  [φ(x-Δx) - 2φ(x) + φ(x+Δx)] / Δx²
```

Dla węzła `p` siatki (gdzie `φ_p = φ(p × DX)`):

```
[φ_{p-1} - 2φ_p + φ_{p+1}] / DX² = -ρ_p / ε₀
```

Przepisując:
```
φ_{p-1} - 2φ_p + φ_{p+1} = -(DX²/ε₀) × ρ_p
```

To równanie dla każdego p = 1, ..., N_G-2 (węzły wewnętrzne). Wartości `φ_0` i
`φ_{N_G-1}` są **znane** z warunków brzegowych.

---

## 3. Układ trójdiagonalny

Zbierając równania dla wszystkich węzłów wewnętrznych dostajemy układ liniowy:

```
⎡-2  1  0  0  0 ⎤ ⎡φ₁     ⎤   ⎡f₁ - φ₀     ⎤
⎢ 1 -2  1  0  0 ⎥ ⎢φ₂     ⎥   ⎢f₂           ⎥
⎢ 0  1 -2  1  0 ⎥ ⎢φ₃     ⎥ = ⎢f₃           ⎥
⎢ 0  0  1 -2  1 ⎥ ⎢...    ⎥   ⎢...          ⎥
⎣ 0  0  0  1 -2 ⎦ ⎣φ_{N-2}⎦   ⎣f_{N-2} - φ_{N-1}⎦

gdzie f_p = ALPHA × ρ_p,   ALPHA = -DX²/ε₀
```

Macierz ma wartości **tylko na 3 przekątnych** — stąd "trójdiagonalna".
Identyfikujemy: A=1 (pod-przekątna), B=-2 (główna), C=1 (nad-przekątna).

---

## 4. Algorytm Thomasa

Układ trójdiagonalny można rozwiązać w O(N) — znacznie szybciej niż ogólny Gauss (O(N³)).

### Faza 1: Eliminacja w przód

Tworzymy tablice pomocnicze `w` i `g`:

```
w[1] = C / B
g[1] = f[1] / B

dla i = 2, 3, ..., N_G-2:
    w[i] = C / (B - A × w[i-1])
    g[i] = (f[i] - A × g[i-1]) / (B - A × w[i-1])
```

### Faza 2: Podstawienie wsteczne

```
pot[N_G-2] = g[N_G-2]

dla i = N_G-3, N_G-4, ..., 1:
    pot[i] = g[i] - w[i] × pot[i+1]
```

---

## 5. Kod: `solvePoisson()`

```go
// main.go, linia 562–600

func solvePoisson(rho1 *xvector, tt float64) {
    const A float64 = 1.0
    const B float64 = -2.0
    const C float64 = 1.0
    const S float64 = 1.0 / (2.0 * DX)
    const ALPHA float64 = -DX * DX / EPSILON0
    var g, w, f xvector

    // Warunki brzegowe
    pot[0]    = VOLTAGE * math.Cos(OMEGA*tt)   // lewa elektroda: V₀cos(ωt)
    pot[N_G-1] = 0.0                           // prawa elektroda: uziemiona

    // Przygotowanie prawej strony układu
    for i := 1; i <= N_G-2; i++ {
        f[i] = ALPHA * (*rho1)[i]
    }
    f[1]     -= pot[0]       // korekta na brzeg lewy
    f[N_G-2] -= pot[N_G-1]  // korekta na brzeg prawy

    // Faza 1: eliminacja w przód
    w[1] = C / B
    g[1] = f[1] / B
    for i := 2; i <= N_G-2; i++ {
        w[i] = C / (B - A*w[i-1])
        g[i] = (f[i] - A*g[i-1]) / (B - A*w[i-1])
    }

    // Faza 2: podstawienie wsteczne
    pot[N_G-2] = g[N_G-2]
    for i := N_G - 3; i > 0; i-- {
        pot[i] = g[i] - w[i]*pot[i+1]
    }

    // Obliczenie pola elektrycznego (węzły wewnętrzne)
    for i := 1; i <= N_G-2; i++ {
        efield[i] = (pot[i-1] - pot[i+1]) * S   // centralna różnica: E = -dφ/dx
    }

    // Węzły brzegowe (specjalna formuła)
    efield[0]    = (pot[0]-pot[1])*INV_DX - (*rho1)[0]*DX/(2.0*EPSILON0)
    efield[N_G-1] = (pot[N_G-2]-pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*DX/(2.0*EPSILON0)
}
```

### Dlaczego wskaźnik `*xvector`?

```go
func solvePoisson(rho1 *xvector, tt float64) {
```

Tablica `xvector` ma 400 elementów × 8 bajtów = 3200 bajtów. Przekazanie przez
wskaźnik `*xvector` zamiast kopii jest efektywniejsze — unikamy kopiowania 3200 bajtów
przy każdym wywołaniu.

### Obliczanie pola E: centralna różnica skończona

Dla węzłów wewnętrznych:
```
E[i] = -dφ/dx ≈ -(φ_{i+1} - φ_{i-1}) / (2·DX)
     = (φ_{i-1} - φ_{i+1}) / (2·DX)
     = (pot[i-1] - pot[i+1]) × S
```

gdzie `S = 1/(2×DX)`.

### Pole E na brzegach — dlaczego inna formuła?

Na brzegach siatki nie możemy użyć centralnej różnicy (brakuje sąsiada).
Zamiast tego używamy jednostronnej różnicy plus korektę z rozkładu ładunku:

```go
efield[0] = (pot[0]-pot[1])*INV_DX - rho[0]*DX/(2.0*EPSILON0)
```

Pierwsza część `(pot[0]-pot[1])/DX` to jednostronna różnica skończona.
Druga część `-rho[0]*DX/(2ε₀)` to korekcja wynikająca z metodologii PIC — elektroda
brzegowa "widzi" ładunek tylko z jednej strony, więc dodajemy połowę wkładu.

---

## 6. Wywołanie z `step2_solve_poisson()`

```go
// main.go, linia 648–654

func step2_solve_poisson(currentTime float64) {
    var rho xvector
    for p := 0; p < N_G; p++ {
        rho[p] = E_CHARGE * (i_density[p] - e_density[p])  // ρ = e(n_i - n_e)
    }
    solvePoisson(&rho, currentTime)
}
```

Gęstość ładunku: jony mają ładunek +e, elektrony -e. Gdy jest więcej jonów niż
elektronów, ρ > 0, co generuje pole odpychające dla jonów.

---

## 7. Przepływ danych w krokach 1 i 2

```
Cząstki (x_e, x_i)
       ↓  Krok 1 (depozycja)
e_density[p], i_density[p]
       ↓  Krok 2a (gęstość ładunku)
rho[p] = E_CHARGE × (i_density[p] - e_density[p])
       ↓  Krok 2b (solvePoisson)
pot[p]       → potencjał elektryczny φ(x)
       ↓  Kroki 2c
efield[p]    → pole elektryczne E(x)
       ↓  Krok 3 (ruch cząstek)
Cząstki przyspieszają pod wpływem E
```

---

## Podsumowanie

| Pojęcie | Wyjaśnienie |
|:--------|:-----------|
| Równanie Poissona | `d²φ/dx² = -ρ/ε₀` — związek ładunku z potencjałem |
| Dyskretyzacja | Zastąpienie pochodnych różnicami skończonymi na siatce |
| Układ trójdiagonalny | A=1, B=-2, C=1 — wynika z dyskretyzacji laplasjan |
| Algorytm Thomasa | Rozwiązuje trójdiagonalny układ w O(N) zamiast O(N³) |
| `S = 1/(2·DX)` | Czynnik dla centralnej różnicy skończonej |
| `ALPHA = -DX²/ε₀` | Czynnik skalujący prawą stronę układu |
| Korekcja brzegów E | Jednostronna różnica + wkład ładunku z jednej strony |

### Co możesz zmienić?

- **Inne napięcie RF**: zmień `VOLTAGE` lub `FREQUENCY`.
- **Asymetryczne napięcia**: zmień `pot[N_G-1] = 0.0` na inną wartość — prawa
  elektroda nie musi być uziemiona.
- **Inne warunki brzegowe**: dla bardziej zaawansowanych wariantów (np. dielektryk
  na elektrodzie) trzeba zmodyfikować `solvePoisson()` i dodać nowe człony.

---

**Następna lekcja:** [Lekcja 7 — Ruch cząstek (schemat Leapfrog)](lekcja_07.md)
