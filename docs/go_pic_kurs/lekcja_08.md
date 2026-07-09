# Lekcja 8: Krok 5 & 6 — Warunki brzegowe (absorpcja na elektrodach)

> **Poprzednia lekcja:** [Lekcja 7 — Ruch cząstek (Leapfrog)](lekcja_07.md)
> **Następna lekcja:** [Lekcja 9 — Zderzenia Monte Carlo (MCC)](lekcja_09.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Co się dzieje gdy cząstka "uderzy" w elektrodę
- Jak działa algorytm "swap z ostatnim" do usuwania cząstek z tablicy
- Dlaczego ten algorytm nie zaburza symulacji
- Jak zbieramy rozkład energii jonów (IFED) na elektrodach
- Dlaczego krok 6 (jony) jest uwarunkowany subcyclingiem

---

## 1. Fizyka: absorpcja na elektrodach

Gdy elektron lub jon dotrze do elektrody, jest **pochłaniany** (absorbowany):
- Jego energia jest oddana do elektrody (prąd elektryczny)
- Cząstka przestaje istnieć w symulacji

Warunki absorpcji:
- `x < 0` → cząstka dotarła do **lewej elektrody** (zasilanej, "powered")
- `x > L` → cząstka dotarła do **prawej elektrody** (uziemionej, "grounded")

Po każdym kroku ruchu (krok 3/4) sprawdzamy te warunki dla wszystkich cząstek.

---

## 2. Kod: `step5_check_boundaries_electrons()`

```go
// main.go, linia 735–758

func step5_check_boundaries_electrons() {
    var k int = 0
    var out bool

    for k < N_e {              // iteruj po wszystkich aktywnych elektronach
        out = false

        if x_e[k] < 0 {
            N_e_abs_pow++     // licz pochłoniętych przez lewą elektrodę
            out = true
        }
        if x_e[k] > L {
            N_e_abs_gnd++     // licz pochłoniętych przez prawą elektrodę
            out = true
        }

        if out {               // usuń elektron jeśli wyszedł poza granicę
            // ALGORYTM "SWAP Z OSTATNIM"
            x_e[k]  = x_e[N_e-1]
            vx_e[k] = vx_e[N_e-1]
            vy_e[k] = vy_e[N_e-1]
            vz_e[k] = vz_e[N_e-1]
            N_e--             // zmniejsz liczbę aktywnych elektronów
            // NIE inkrementuj k — ten sam indeks teraz ma nową cząstkę!
        } else {
            k++               // przejdź do następnej cząstki
        }
    }
}
```

---

## 3. Algorytm "swap z ostatnim" — dlaczego tak?

### Naiwne usunięcie (NIE robimy tego!)

Klasyczne usunięcie elementu z środka tablicy wymagałoby przesunięcia wszystkich
kolejnych elementów:

```
Przed: [e₀, e₁, e₂*, e₃, e₄, e₅]   (* = do usunięcia)
Naiwne:  k=2  →  przesuwamy e₃→e₂, e₄→e₃, e₅→e₄ → O(N) operacji!
Po:    [e₀, e₁, e₃, e₄, e₅]
```

Przy N_e = 50 000 cząsteczkach i wielu absorpcjach na krok → ogromny narzut.

### Algorytm swap z ostatnim (używamy!)

Zamiast przesuwać, **zamieniamy usuwaną cząstkę z ostatnią** i zmniejszamy licznik:

```
Przed: [e₀, e₁, e₂*, e₃, e₄, e₅]   N_e=6
Swap:  e₂ ← e₅,  N_e = 5
Po:    [e₀, e₁, e₅, e₃, e₄]   (e₂ zniknął, e₅ jest teraz na pozycji 2)
```

Złożoność: **O(1)** — tylko 4 przypisania niezależnie od N_e!

### Dlaczego nie inkrementujemy k po usunięciu?

```go
if out {
    x_e[k] = x_e[N_e-1]   // na pozycji k jest teraz nowa cząstka
    N_e--
    // k pozostaje takie samo!  ← kluczowe
} else {
    k++
}
```

Po swapie, na pozycji `k` znajduje się **nowa cząstka** (była ostatnia). Musimy ją
sprawdzić w kolejnej iteracji pętli! Gdybyśmy zrobili `k++`, pominęlibyśmy tę cząstkę.

### Dlaczego `for k < N_e` zamiast `for k = 0; k < N_e; k++`?

Właśnie z tego samego powodu — klasyczna pętla `for` z `k++` inkrementuje za każdym
razem, co jest błędne przy usuwaniu elementów. Pętla `for k < N_e` z ręcznym k++
daje pełną kontrolę.

---

## 4. Wizualizacja działania algorytmu

Przykład z 6 elektronami, 3 do usunięcia (pozycje ×):

```
Start: [A, B, ×C, D, ×E, F]   N_e=6, k=0

k=0: A ok, k=1
k=1: B ok, k=2
k=2: ×C — swap z F → [A, B, F, D, ×E, F]  N_e=5, k=2
k=2: F ok, k=3
k=3: D ok, k=4
k=4: ×E — swap z E → [A, B, F, D, E, F]   N_e=4, k=4
         ale N_e=4, więc E (stary "ostatni") jest teraz "poza" tablicą → N_e--
         k=4 >= N_e=4, koniec pętli

Wynik: [A, B, F, D]  ← kolejność może się zmienić, ale to OK!
```

**Ważne:** Kolejność cząstek w tablicy może się zmienić. Jest to **poprawne** —
cząstki w PIC nie mają tożsamości, liczy się tylko ich pozycja i prędkość.

---

## 5. Kod: `step6_check_boundaries_ions()`

```go
// main.go, linia 760–802

func step6_check_boundaries_ions(t int) {
    if (t % N_SUB) != 0 {
        return   // subcycling: sprawdzaj tylko co 20 kroków
    }

    for k < N_i {
        out = false

        if x_i[k] < 0 {
            N_i_abs_pow++
            out = true
            // Dla jonów: zbieramy rozkład energii (IFED)!
            v_sqr  = vx_i[k]*vx_i[k] + vy_i[k]*vy_i[k] + vz_i[k]*vz_i[k]
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J   // energia kinetyczna w eV
            energy_index = int(energy / DE_IFED)
            if energy_index < N_IFED {
                ifed_pow[energy_index]++   // histogram energii na lewej elektrodzie
            }
        }

        if x_i[k] > L {
            N_i_abs_gnd++
            out = true
            // ... analogicznie dla prawej elektrody → ifed_gnd
        }

        if out {
            // Swap z ostatnim (tak samo jak dla elektronów)
            x_i[k]  = x_i[N_i-1]
            vx_i[k] = vx_i[N_i-1]
            vy_i[k] = vy_i[N_i-1]
            vz_i[k] = vz_i[N_i-1]
            N_i--
        } else {
            k++
        }
    }
}
```

### Różnica względem elektronów: IFED

Dla jonów, przy absorpcji, zapisujemy energię kinetyczną do histogramu **IFED**
(Ion Flux-Energy Distribution):

```
v² = vx² + vy² + vz²
E_kin = ½ × m_Ar × v² [w dżulach]
E_eV  = E_kin / EV_TO_J [w eV]
energy_index = E_eV / DE_IFED   (DE_IFED = 1 eV/bin)
ifed_pow[energy_index]++
```

IFED mówi nam z jaką energią jony bombardują elektrodę — kluczowe dla zastosowań
przemysłowych (trawienie plazmowe).

### Dlaczego elektrony nie mają IFED?

Elektrony mają śladowy wpływ na elektrodę w porównaniu do jonów — ich masa jest
73 000× mniejsza, więc ich energia kinetyczna jest znikoma. W zastosowaniach
(np. trawienie) liczy się bombardowanie jonami.

---

## 6. Liczniki absorpcji

```go
var (
    N_e_abs_pow uint64  // elektrony pochłonięte przez lewą elektrodę
    N_e_abs_gnd uint64  // elektrony pochłonięte przez prawą elektrodę
    N_i_abs_pow uint64  // jony pochłonięte przez lewą elektrodę
    N_i_abs_gnd uint64  // jony pochłonięte przez prawą elektrodę
)
```

Typ `uint64` (nieujemna 64-bitowa liczba całkowita) — przez cały czas symulacji
mogą być pochłonięte miliardy cząstek (ale supercząstek, więc nie aż tak wiele).

Na końcu symulacji te liczniki służą do obliczenia **strumienia cząstek**:

```go
// w checkAndSaveInfo():
ion_flux_pow = float64(N_i_abs_pow) * WEIGHT / ELECTRODE_AREA / (float64(no_of_cycles) * PERIOD)
// [supercząstki] × [cząstek/supercząstkę] / [m²] / [s]  =  [cząstek / m² / s]
```

---

## 7. Balans w plazmie: absorpcja vs jonizacja

Plazma jest w stanie stacjonarnym gdy:

```
Liczba nowych par (jonizacja) = Liczba pochłoniętych (absorpcja)
```

Na początku symulacji jonizacja dominuje → plazma rośnie.
Po jakimś czasie osiągamy równowagę → N_e i N_i stabilizują się.

Śledząc `conv.dat`, możesz zobaczyć ten proces:
```
cykl 1:    1043 e⁻
cykl 5:    3842 e⁻
cykl 50:   9734 e⁻
cykl 200:  9821 e⁻   ← stan stacjonarny
```

---

## Podsumowanie

| Pojęcie | Wyjaśnienie |
|:--------|:-----------|
| Absorpcja | `x < 0` lub `x > L` → cząstka pochłonięta przez elektrodę |
| Swap z ostatnim | O(1) usunięcie cząstki: zamień z ostatnią, zmniejsz licznik |
| Bez k++ po usunięciu | Nowa cząstka (ze swapu) na pozycji k musi być sprawdzona |
| `N_e_abs_pow/gnd` | Liczniki pochłoniętych elektronów (do obliczenia strumienia) |
| IFED | Histogram energii jonów na elektrodzie — tylko dla jonów |
| Subcycling | Krok 6 (jony) tylko gdy `t % N_SUB == 0` |

### Co możesz zmienić?

| Modyfikacja | Jak |
|:------------|:----|
| Współczynnik emisji wtórnej | Przy absorpcji elektronu: z prawdopodobieństwem γ dodaj nowy elektron na elektrodzie |
| Inne warunki brzegowe | Zamiast absorbować, odbij cząstkę (`vx *= -1`) |
| Szerszy zakres IFED | Zmień `N_IFED` lub `DE_IFED` |
| Zbieranie energii elektronów na elektrodzie | Dodaj analogiczny histogram jak IFED ale dla e⁻ |

### Implementacja emisji elektronów wtórnych (szkic):

```go
if x_e[k] < 0 {
    N_e_abs_pow++
    if R01() < SECONDARY_EMISSION_COEFF {
        // dodaj nowy elektron na lewej elektrodzie
        x_e[N_e] = 0.0
        vx_e[N_e] = math.Abs(RMB())  // prędkość w głąb układu (>0)
        vy_e[N_e] = RMB()
        vz_e[N_e] = RMB()
        N_e++
    }
    out = true
}
```

---

**Następna lekcja:** [Lekcja 9 — Zderzenia Monte Carlo (MCC)](lekcja_09.md)
