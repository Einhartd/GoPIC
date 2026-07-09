# Lekcja 1: Mapa kodu — co jest gdzie i po co

> **Poprzednia lekcja:** brak (to początek)
> **Następna lekcja:** [Lekcja 2 — Stałe i zmienne globalne](lekcja_02.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Co w ogóle symulujemy i dlaczego
- Jak wygląda struktura całego pliku `main.go`
- Jak działa główna pętla symulacji (bez wchodzenia w szczegóły)
- Kilka podstawowych pojęć Go, których będziesz potrzebować

---

## 1. Co symulujemy?

Wyobraź sobie dwa metalowe talerze (elektrody) oddalone od siebie o **25 mm**, wypełnione gazem
Argonem pod niskim ciśnieniem (10 Pa — to jak w słupku lampy neonowej).

```
 Elektroda lewa (zasilana)          Plazma (Ar)          Elektroda prawa (uziemiona)
  V = 250·cos(ωt) [V]        e⁻  Ar⁺  e⁻  Ar⁺  e⁻           V = 0 [V]
        x = 0 m           ←——————————————————————————→       x = L = 0.025 m
```

Na **lewą elektrodę** przykładamy napięcie zmienne o częstotliwości 13.56 MHz (taka sama
jak w kuchenkach mikrofalowych). Napięcie to jonizuje gaz — tworzy się **plazma**: zjonizowany
gaz zawierający wolne elektrony (e⁻) i jony argonu (Ar⁺).

### Co chcemy wiedzieć?

Symulacja odpowiada na pytania takie jak:
- Z jaką energią jony uderzają w elektrody?
- Jak rozkłada się gęstość plazmy między elektrodami?
- Jaka jest moc pochłaniana przez elektrony i jony?

---

## 2. Dlaczego "PIC" i "MCC"?

**PIC (Particle-In-Cell)** = metoda symulowania plazmy, w której:
1. Śledzimy ruch cząstek (elektronów i jonów)
2. Obliczamy pole elektryczne na siatce (gridzie)
3. Sprzęgamy cząstki z polem (cząstki czują pole, pole zależy od cząstek)

**MCC (Monte Carlo Collisions)** = metoda symulowania zderzeń cząstek z gazem tła
przy użyciu losowości — zamiast liczyć każde zderzenie deterministycznie, losujemy czy
zderzenie wystąpi na podstawie prawdopodobieństwa.

### Supercząstki — klucz do wydajności

W rzeczywistym reaktorze jest ~10¹⁰ elektronów. Nie da się symulować każdego osobno.
Dlatego grupujemy je w **supercząstki**: jedna supercząstka = 70 000 prawdziwych cząstek.

```go
const WEIGHT float64 = 7.0e4  // waga supercząstki: 1 supercząstka = 70 000 prawdziwych
```

Symulacja operuje na ~10 000–100 000 supercząstek zamiast na miliardach prawdziwych.

---

## 3. Mapa pliku `main.go`

Cały kod mieści się w jednym pliku (~1300 linii). Poniżej jego struktura:

```
main.go
│
├── Linie 1–17      → Import bibliotek Go (math, os, fmt, ...)
│
├── Linie 19–91     → STAŁE (const)
│   ├── 19–31       → Stałe natury: masa elektronu, ładunek, ε₀, k_B
│   ├── 33–59       → Parametry symulacji: N_G, N_T, napięcie, ciśnienie
│   └── 70–91       → Parametry przekrojów czynnych (zderzenia)
│
├── Linie 93–197    → ZMIENNE GLOBALNE (var)
│   ├── 93–110      → Tablice cząstek: x_e, vx_e, vy_e, vz_e, x_i, ...
│   ├── 112–121     → Tablice siatki: efield, pot, e_density, i_density
│   └── 123–197     → Diagnostyki: EEPF, IFED, rozkłady XT, liczniki
│
├── Linie 199–240   → Generator liczb losowych (Mersenne Twister)
│
├── Linie 242–308   → Przekroje czynne (wzory empiryczne Phelpsa)
│   ├── 246–274     → Elektron/Argon (elastyczne, wzbudzenie, jonizacja)
│   └── 280–308     → Jon/Argon (izotropowe, wsteczne)
│
├── Linie 329–377   → Funkcje pomocnicze (max. częstość zderzeń, init)
│
├── Linie 379–600   → Funkcje fizyczne
│   ├── 383–487     → collisionElectron() — zderzenie e⁻/Ar
│   ├── 493–556     → collisionIon()      — zderzenie Ar⁺/Ar
│   └── 562–600     → solvePoisson()      — rozwiązanie równania Poissona
│
├── Linie 602–891   → GŁÓWNA PĘTLA: doOneCycle()
│   ├── 606–624     → step1a: gęstość elektronów
│   ├── 626–646     → step1b: gęstość jonów
│   ├── 648–654     → step2:  pole elektryczne (Poisson)
│   ├── 656–699     → step3:  ruch elektronów
│   ├── 701–733     → step4:  ruch jonów
│   ├── 735–758     → step5:  absorpcja elektronów na elektrodach
│   ├── 760–802     → step6:  absorpcja jonów na elektrodach
│   ├── 804–820     → step7:  zderzenia elektronów (MCC)
│   ├── 822–848     → step8:  zderzenia jonów (MCC)
│   └── 850–891     → step9:  diagnostyki XT
│
├── Linie 893–1207  → Zapis danych do plików (.dat, .bin, raporty)
│
└── Linie 1216–1273 → main() — punkt wejścia programu
```

---

## 4. Podstawy Go, których potrzebujesz

### `const` — stałe

```go
const E_CHARGE float64 = 1.60217662e-19   // ładunek elementarny [C]
const N_G      int     = 400              // liczba punktów siatki
```

Stałe znasz z Pythona/Javy — wartości, które nigdy się nie zmieniają.

### `var` i typy tablicowe

```go
type particle_vector [MAX_N_P]float64  // typ: tablica 1 000 000 float64
var x_e particle_vector                // pozycje wszystkich elektronów
```

To jest tablicą o **stałym rozmiarze** (w Go rozmiar tablicy jest częścią jej typu).
`x_e[0]` to pozycja 1. elektronu, `x_e[N_e-1]` to pozycja ostatniego *aktywnego*.

> **Ważne:** Tablica ma zawsze 1 000 000 slotów, ale tylko pierwsze `N_e` z nich jest
> aktywnych. Reszta to "rezerwuar" na nowe cząstki (np. powstałe przy jonizacji).

### Wskaźniki `*float64`

```go
func collisionElectron(xe float64, vxe *float64, vye *float64, vze *float64, ...) {
    *vxe = ...  // modyfikujemy oryginalną zmienną (prędkość elektronu)
}
```

Gdy funkcja dostaje `*float64`, to znaczy "przekaż mi adres zmiennej, żebym mógł ją zmienić".
Wywołanie wygląda tak:

```go
collisionElectron(x_e[k], &vx_e[k], &vy_e[k], &vz_e[k], ...)
//                                ^ operator "adres zmiennej"
```

To Go-owy odpowiednik C++ `double&`. Bez wskaźnika funkcja dostałaby **kopię** wartości
i modyfikacja wewnątrz funkcji nie wpłynęłaby na oryginał.

### Pętla `for`

Go nie ma `while`. Pętla `for` pełni wszystkie role:

```go
// Klasyczna (jak C)
for k = 0; k < N_e; k++ {
    // k-ty elektron
}

// Z warunkiem (jak while)
for k < N_e {
    // ...
}
```

---

## 5. Główna pętla — serce symulacji

Funkcja `doOneCycle()` to absolutne serce symulacji.
Jeden "cykl" = jeden **okres RF** ≈ 73.7 ns, podzielony na **4000 kroków czasowych**.

```go
// main.go, linia 863
func doOneCycle() {
    for t = 0; t < N_T; t++ {   // ← N_T = 4000 iteracji

        Time += DT_E             // aktualizacja globalnego czasu

        step1_compute_electron_density()   // Krok 1a: gęstość e⁻
        step1_compute_ion_density(t)       // Krok 1b: gęstość Ar⁺

        step2_solve_poisson(Time)          // Krok 2: pole E

        step3_move_electrons(t_index)      // Krok 3: ruch e⁻
        step4_move_ions(t_index, t)        // Krok 4: ruch Ar⁺

        step5_check_boundaries_electrons() // Krok 5: absorpcja e⁻
        step6_check_boundaries_ions(t)     // Krok 6: absorpcja Ar⁺

        step7_collisions_electrons()       // Krok 7: zderzenia e⁻
        step8_collision_ions(t)            // Krok 8: zderzenia Ar⁺

        step9_collect_xt_data(t_index)     // Krok 9: diagnostyki
    }
}
```

Schemat jest zawsze taki sam — **9 kroków**, powtarzanych 4000 razy na cykl.

---

## 6. Subcycling — dlaczego jony są "wolniejsze"

Zauważ, że część kroków ma argument `t` i zawiera wewnątrz:

```go
func step4_move_ions(t_index, t int) {
    if (t % N_SUB) != 0 {
        return  // ← wróć, nic nie rób
    }
    // ... ruszaj jony
}
```

To **subcycling** (podkrok). Jony są ~73 000× cięższe od elektronów, więc poruszają się
znacznie wolniej i nie potrzebują tak częstych aktualizacji.

- Elektrony: aktualizowane **co krok** (co `DT_E` ≈ 18.4 ps)
- Jony: aktualizowane **co 20 kroków** (co `DT_I = 20 × DT_E` ≈ 368 ps)

`N_SUB = 20` — jony są aktualizowane co 20 kroków elektronowych.
`t % N_SUB != 0` oznacza: "jeśli nie jest to krok wielokrotnością 20, pomiń".

---

## Podsumowanie

| Pojęcie | Znaczenie |
|:--------|:----------|
| Supercząstka | Reprezentuje 70 000 prawdziwych cząstek |
| N_G = 400 | Liczba punktów siatki (przestrzeń 0..L) |
| N_T = 4000 | Liczba kroków czasowych na jeden cykl RF |
| N_SUB = 20 | Jony aktualizowane co 20 kroków elektronowych |
| `doOneCycle()` | Główna pętla, 9 kroków × 4000 iteracji |

---

**Następna lekcja:** [Lekcja 2 — Stałe i zmienne globalne](lekcja_02.md)
