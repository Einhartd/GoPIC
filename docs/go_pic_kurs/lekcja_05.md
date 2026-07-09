# Lekcja 5: Krok 1 — Depozycja gęstości (interpolacja liniowa)

> **Poprzednia lekcja:** [Lekcja 4 — Inicjalizacja](lekcja_04.md)
> **Następna lekcja:** [Lekcja 6 — Solver Poissona](lekcja_06.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Co to jest "depozycja gęstości" i dlaczego jest potrzebna
- Jak działa interpolacja liniowa (NGP vs. CIC)
- Dokładnie co robi każda linia `step1_compute_electron_density()`
- Dlaczego brzegi siatki wymagają mnożenia przez 2 (boundary correction)
- Czemu jony są depozytowane rzadziej niż elektrony (subcycling)

---

## 1. Problem: cząstki są w przestrzeni ciągłej, siatka jest dyskretna

Cząstki (elektrony, jony) mają **ciągłe** pozycje `x_e[k]` ∈ [0, L].

Siatka obliczeniowa ma **dyskretne** punkty `p = 0, 1, ..., N_G-1`, gdzie punkt `p`
jest w pozycji `p × DX`.

Chcemy obliczyć gęstość ładunku w każdym punkcie siatki — ale cząstki rzadko trafiają
dokładnie w węzeł siatki!

```
Siatka:    p=0    p=1    p=2    p=3    p=4
            |——DX——|——DX——|——DX——|——DX——|
Cząstka:            ↑ tutaj
            (gdzieś między p=1 a p=2)
```

**Rozwiązanie:** Interpolacja — przypisujemy część ładunku do lewego węzła i część do
prawego, proporcjonalnie do odległości.

---

## 2. Interpolacja liniowa (CIC — Cloud-In-Cell)

Niech cząstka jest w pozycji `x`. Definiujemy:

```
c0 = x / DX              (pozycja w jednostkach siatki, np. 1.73)
p  = floor(c0)           (lewy węzeł, np. p = 1)
```

Wagi dla dwóch sąsiednich węzłów:
```
waga dla węzła p:   w_left  = (p + 1) - c0   (np. 2 - 1.73 = 0.27)
waga dla węzła p+1: w_right = c0 - p          (np. 1.73 - 1 = 0.73)
```

Sprawdzenie: `w_left + w_right = 1.0` ✓

```
x = 1.73 × DX

p=1 ←—0.27—→|←——0.73——→ p=2
              ↑ cząstka
```

Im cząstka bliżej prawego węzła (p=2), tym większa waga dla p=2.

---

## 3. Kod: `step1_compute_electron_density()`

```go
// main.go, linia 606–624

func step1_compute_electron_density() {
    var k, p int
    var c0 float64

    // Zerowanie tablicy gęstości
    for p = 0; p < N_G; p++ {
        e_density[p] = 0
    }

    // Depozycja: każdy elektron dodaje ładunek do dwóch sąsiednich węzłów
    for k = 0; k < N_e; k++ {
        c0 = x_e[k] * INV_DX             // pozycja w jednostkach siatki
        p = int(c0)                       // lewy węzeł (obcięcie, nie zaokrąglenie!)
        e_density[p]   += (float64(p) + 1.0 - c0) * FACTOR_W  // waga lewego węzła
        e_density[p+1] += (c0 - float64(p)) * FACTOR_W        // waga prawego węzła
    }

    // Korekcja brzegowa (WAŻNE!)
    e_density[0]    *= 2.0
    e_density[N_G-1] *= 2.0

    // Akumulacja dla uśredniania
    for p = 0; p < N_G; p++ {
        cumul_e_density[p] += e_density[p]
    }
}
```

### Analiza linia po linii

**Zerowanie (`e_density[p] = 0`):**
Gęstość jest **przeliczana od zera** w każdym kroku — cząstki się poruszają, więc
stara gęstość jest bezużyteczna. Nie możemy jej akumulować bez zerowania.

**Wyliczenie pozycji (`c0 = x_e[k] * INV_DX`):**
```
INV_DX = 1 / DX

Przykład: x_e[k] = 0.00011 m,  DX = 6.27e-5 m
c0 = 0.00011 / 6.27e-5 = 1.754
```

**Obcięcie (`p = int(c0)`):**
`int()` w Go obcina ułamek (nie zaokrągla!). Dla c0=1.754 → p=1.
Zawsze dostajemy **lewy** sąsiedni węzeł.

**Depozycja z wagami:**
```go
e_density[p]   += (float64(p) + 1.0 - c0) * FACTOR_W
//                  ↑ to jest w_left = (p+1) - c0

e_density[p+1] += (c0 - float64(p)) * FACTOR_W
//                  ↑ to jest w_right = c0 - p
```

Przykład numeryczny (c0 = 1.754, p = 1):
- `w_left  = 2.0 - 1.754 = 0.246`
- `w_right = 1.754 - 1.0 = 0.754`
- Suma: 1.0 ✓

`FACTOR_W = WEIGHT / (ELECTRODE_AREA × DX)` przelicza "wagę supercząstki" na gęstość [1/m³].

---

## 4. Korekcja brzegowa — dlaczego ×2?

```go
e_density[0]    *= 2.0
e_density[N_G-1] *= 2.0
```

To jest **obowiązkowa korekcja** i jedna z najczęściej popełnianych błędów przy
reimplementacji PIC. Wyjaśnienie:

Interpolacja liniowa zakłada, że cząstka "widzi" węzły po **obu stronach**. Ale
węzły brzegowe `p=0` i `p=N_G-1` mają sąsiadów tylko po **jednej stronie**:

```
Wnętrze:    p=5 ←——DX——→ p=6 ←——DX——→ p=7
Brzeg:   p=0 ←——DX——→ p=1     (lewy brzeg, brak węzła p=-1)
```

Bez korekcji, węzeł brzegowy zbierałby tylko połowę wkładu, który powinien zebrać.
Mnożenie przez 2 kompensuje "brakujący" sąsiad poza granicą układu.

> **Zasada:** Jeśli zmienisz cokolwiek w logice depozycji, ta korekcja musi zostać
> zachowana — jej brak powoduje błędy gęstości na elektrodach, co psuje całą fizykę.

---

## 5. Akumulacja gęstości

```go
for p = 0; p < N_G; p++ {
    cumul_e_density[p] += e_density[p]
}
```

`cumul_e_density` zbiera sumę gęstości przez **wszystkie kroki i cykle** w trybie
pomiarowym. Na końcu jest dzielona przez `no_of_cycles × N_T` żeby dostać
**uśrednioną gęstość**. Dzięki temu wynikowa gęstość jest wygładzona, nie chwilowa.

---

## 6. Gęstość jonów — `step1_compute_ion_density(t int)`

```go
// main.go, linia 626–646

func step1_compute_ion_density(t int) {
    if (t % N_SUB) == 0 {   // ← przelicz gęstość jonów tylko co N_SUB kroków
        for p = 0; p < N_G; p++ {
            i_density[p] = 0
        }
        for k = 0; k < N_i; k++ {
            c0 = x_i[k] * INV_DX
            p = int(c0)
            i_density[p]   += (float64(p) + 1.0 - c0) * FACTOR_W
            i_density[p+1] += (c0 - float64(p)) * FACTOR_W
        }
        i_density[0]    *= 2.0   // korekcja brzegowa
        i_density[N_G-1] *= 2.0
    }

    // Akumulacja ZAWSZE — nawet gdy jonów nie przeliczamy!
    for p = 0; p < N_G; p++ {
        cumul_i_density[p] += i_density[p]
    }
}
```

### Subcycling jonów — `t % N_SUB == 0`

Jony poruszają się ~73 000× wolniej niż elektrony (stosunek mas). Ich gęstość zmienia
się wolno. Przeliczanie jej w każdym kroku byłoby marnotrawstwem.

Rozwiązanie: przelicz gęstość jonów tylko gdy `t % N_SUB == 0`, czyli co 20 kroków.

```
t =  0: oblicz i_density ← używaj tej dla t=1..19
t =  1: użyj starej i_density
...
t = 19: użyj starej i_density
t = 20: oblicz nową i_density ← używaj dla t=21..39
...
```

### Klucz: akumulacja poza blokiem `if`

Zauważ że `cumul_i_density[p] += i_density[p]` jest **poza** blokiem `if`.
Akumulacja następuje **co krok**, używając ostatnio obliczonej gęstości jonów.
Gęstość jonów jest zaktualizowana co 20 kroków, ale sumujemy co krok.

Gdyby akumulacja była wewnątrz bloku `if`, `cumul_i_density` narastałaby 20× wolniej
niż `cumul_e_density` — wynik byłby błędny przy uśrednianiu.

---

## 7. Wizualizacja całego procesu

```
KROK 1a (elektrony, ZAWSZE):
┌─────────────────────────────────┐
│ Zeruj e_density                 │
│ Dla każdego elektronu k:        │
│   c0 = x_e[k] / DX             │
│   p = int(c0)                   │
│   e_density[p]   += w_left  × W │
│   e_density[p+1] += w_right × W │
│ e_density[0]    × = 2            │
│ e_density[N_G-1] × = 2           │
│ cumul_e_density += e_density    │
└─────────────────────────────────┘

KROK 1b (jony, tylko co N_SUB kroków):
┌─────────────────────────────────┐
│ Jeśli t % 20 == 0:              │
│   Zeruj i_density               │
│   Dla każdego jonu k:           │
│     ... (to samo co dla e⁻)    │
│   i_density[0]    × = 2          │
│   i_density[N_G-1] × = 2         │
│ Zawsze: cumul_i_density += ...  │
└─────────────────────────────────┘
```

---

## 8. Co jest dalej?

Mamy teraz `e_density` i `i_density` — gęstości w każdym węźle siatki.
Gęstość ładunku to:
```
rho[p] = E_CHARGE × (i_density[p] - e_density[p])
```

Jony mają ładunek +e, elektrony -e. Ta różnica napędza pole elektryczne — co obliczamy
w kroku 2 (Poisson).

---

## Podsumowanie

| Pojęcie | Wyjaśnienie |
|:--------|:-----------|
| `c0 = x / DX` | Pozycja w jednostkach siatki |
| `p = int(c0)` | Lewy sąsiedni węzeł (obcięcie!) |
| `w_left = (p+1) - c0` | Waga lewego węzła (0..1) |
| `w_right = c0 - p` | Waga prawego węzła (0..1) |
| `FACTOR_W` | Przelicza supercząstkę na gęstość [1/m³] |
| `×2 na brzegach` | Korekcja obowiązkowa — bez niej błędy na elektrodach |
| Subcycling jonów | Gęstość jonów przeliczana co N_SUB=20 kroków |
| `cumul_*_density` | Narastająca suma gęstości do uśredniania |

### Co możesz zmienić?

- **Inny schemat interpolacji** (np. NGP — Nearest Grid Point): zamiast dzielić na
  dwa węzły, dodaj całą wagę do najbliższego węzła. To prostsze, ale mniej dokładne.
- **Inne FACTOR_W**: zmiana `WEIGHT` automatycznie zmienia gęstość na supercząstkę.
- **Inne N_SUB**: zmiana subcyclingu jonów (uważaj na warunki stabilności!).

---

**Następna lekcja:** [Lekcja 6 — Solver Poissona (algorytm Thomasa)](lekcja_06.md)
