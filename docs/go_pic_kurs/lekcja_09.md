# Lekcja 9: Krok 7 & 8 — Zderzenia Monte Carlo (MCC)

> **Poprzednia lekcja:** [Lekcja 8 — Warunki brzegowe](lekcja_08.md)
> **Następna lekcja:** [Lekcja 10 — Diagnostyki, dane i uruchamianie](lekcja_10.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Jak wyznaczamy czy zderzenie wystąpiło (metoda Monte Carlo)
- Na czym polega "cold gas approximation" dla elektronów
- Jak 3D obrót wektora prędkości jest realizowany matematycznie (kąty Eulera)
- Co dokładnie dzieje się przy każdym z 5 typów zderzeń
- Jak zderzenia jonów różnią się od elektronowych

---

## 1. Idea MCC — decyzja "czy zderzenie?"

Dla każdej cząstki w każdym kroku losujemy czy zderzenie wystąpi.

```go
// Krok 7: elektrony
for k = 0; k < N_e; k++ {
    v_sqr  = vx_e[k]² + vy_e[k]² + vz_e[k]²
    velocity = √v_sqr
    energy = 0.5 × E_MASS × v_sqr / EV_TO_J       // [eV]
    energy_index = int(energy/DE_CS + 0.5)          // indeks do tablicy

    nu     = sigma_tot_e[energy_index] × velocity   // częstość zderzeń [1/s]
    p_coll = 1 - exp(-nu × DT_E)                    // prawdopodobieństwo zderzenia

    if R01() < p_coll {
        collisionElectron(x_e[k], &vx_e[k], &vy_e[k], &vz_e[k], energy_index)
        N_e_coll++
    }
}
```

Typowo `p_coll ≈ 0.01–0.05` — zderzenie następuje u ~1–5% cząstek w każdym kroku.

---

## 2. Zderzenie elektronu: `collisionElectron()`

Funkcja przyjmuje:
- `xe float64` — pozycja elektronu (do tworzenia nowych cząstek przy jonizacji)
- `vxe, vye, vze *float64` — wskaźniki na prędkości (modyfikowane in-place)
- `eindex int` — indeks energii w tablicy przekrojów czynnych

### 2a. Prędkość względna i prędkość środka masy

"Cold gas approximation" = zakładamy, że atomy Ar są **nieruchome** (T_Ar → 0).
To dobre przybliżenie gdy elektron jest znacznie szybszy niż atom (co prawie zawsze zachodzi).

```go
// Prędkość względna = prędkość elektronu (atom w spoczynku)
gx = *vxe;  gy = *vye;  gz = *vze
g  = √(gx² + gy² + gz²)

// Prędkość środka masy (COM):
wx = F1 × (*vxe)
wy = F1 × (*vye)
wz = F1 × (*vze)

// F1 = E_MASS / (E_MASS + AR_MASS) ≈ 9.1e-31 / 6.63e-26 ≈ 0.0000137
// F2 = AR_MASS / (E_MASS + AR_MASS) ≈ 1 - F1 ≈ 0.9999863
```

Ponieważ elektron jest ~73 000× lżejszy od Ar, środek masy jest prawie w miejscu
atenu (F1 ≈ 0): `w ≈ 0`, `F2 ≈ 1`. Elektron odbija się od nieruchomego Ar.

### 2b. Kąty Eulera — orientacja wektora g

Przed obrotem musimy znać kierunek wektora prędkości względnej `g`:

```go
if gx == 0 {
    theta = 0.5 × PI
} else {
    theta = atan2(√(gy² + gz²), gx)   // kąt od osi x
}
if gy == 0 {
    phi = ±0.5 × PI                    // specjalny przypadek
} else {
    phi = atan2(gz, gy)                // kąt w płaszczyźnie y-z
}

st, ct = sin(theta), cos(theta)
sp, cp = sin(phi),   cos(phi)
```

`theta` i `phi` to kąty sferyczne opisujące kierunek wektora g. Potrzebujemy ich,
żeby obrócić wektor prędkości po zderzeniu.

### 2c. Wybór typu zderzenia

```go
t0 = sigma[E_ELA][eindex]                // przekrój elastyczny
t1 = t0 + sigma[E_EXC][eindex]          // + przekrój wzbudzenia
t2 = t1 + sigma[E_ION][eindex]          // + przekrój jonizacji = suma

rnd = R01()

if rnd < (t0 / t2) {         // elastyczne: [0, t0/t2)
    chi = acos(1 - 2×R01())  // losowy kąt rozpraszania (izotropowy)
    eta = 2π × R01()         // losowy kąt azymutalny
} else if rnd < (t1 / t2) {  // wzbudzenie: [t0/t2, t1/t2)
    // odejmij energię wzbudzenia i rozprosz izotropowo
} else {                     // jonizacja: [t1/t2, 1)
    // odejmij energię jonizacji, podziel na dwa elektrony
}
```

Losowanie proporcjonalne do przekrojów: jeśli σ_ela = 0.7, σ_exc = 0.2, σ_ion = 0.1,
to 70% zderzeń jest elastycznych, 20% wzbudzeniowych, 10% jonizacyjnych.

### 2d. Obrót wektora prędkości (macierz Eulera)

Po wylosowaniu kąta rozpraszania chi (polarne) i azymutu eta:

```go
sc = sin(chi);  cc = cos(chi)
se = sin(eta);  ce = cos(eta)

// Nowy wektor prędkości względnej:
gx = g × (ct×cc - st×sc×ce)
gy = g × (st×cp×cc + ct×cp×sc×ce - sp×sc×se)
gz = g × (st×sp×cc + ct×sp×sc×ce + cp×sc×se)
```

To jest **macierz obrotu 3D** zapisana jawnie. Obraca wektor `g` o kąt chi wokół
osi prostopadłej do `g`, z azymutem eta. Matematycznie to złożenie trzech obrotów.

### Prędkość po zderzeniu:

```go
*vxe = wx + F2×gx
*vye = wy + F2×gy
*vze = wz + F2×gz
```

"Prędkość COM + F2 × prędkość względna" — standardowa formula dla zderzeń 2-ciał.

---

## 3. Zderzenia jonizacyjne — tworzenie nowych cząstek

To jest najważniejsza część — jonizacja tworzy nowe pary elektron/jon:

```go
} else {  // jonizacja
    energy = 0.5 × E_MASS × g² - E_ION_TH × EV_TO_J   // energia po odj. progu

    // Podział energii między dwa elektrony (losowy):
    e_ej = 10 × tan(R01() × atan(energy/EV_TO_J/20)) × EV_TO_J  // ejektowany
    e_sc = |energy - e_ej|                                        // rozproszony

    g  = √(2 × e_sc / E_MASS)    // prędkość rozpraszanego elektronu
    g2 = √(2 × e_ej / E_MASS)    // prędkość ejektowanego elektronu

    chi  = acos(√(e_sc / energy))  // kąt rozproszenia dla pierwotnego elektronu
    chi2 = acos(√(e_ej / energy))  // kąt rozproszenia dla ejektowanego elektronu
    eta  = 2π × R01()
    eta2 = eta + π                 // ejektowany elektron leci w przeciwną stronę

    // Oblicz prędkości ejektowanego elektronu
    // (obrót g2 o kąty chi2, eta2)
    gx = g2 × (ct×cc2 - st×sc2×ce2)
    ...

    // Dodaj nowy elektron do tablicy
    x_e[N_e] = xe
    vx_e[N_e] = wx + F2×gx
    ...
    N_e++

    // Dodaj nowy jon (z prędkościami termicznymi)
    x_i[N_i] = xe
    vx_i[N_i] = RMB()   // prędkość z rozkładu Maxwella
    vy_i[N_i] = RMB()
    vz_i[N_i] = RMB()
    N_i++

    // (teraz obsłuż rozproszony elektron — patrz poniżej)
}
```

### Tworzenie nowej pary e⁻/Ar⁺

Nowy elektron i jon są umieszczane w **tej samej pozycji** co zderzający się elektron
(`xe`). Nowy jon dostaje prędkość termiczną (RMB) — bo nowo powstały jon nie ma
prędkości "od uderzenia".

### Dlaczego `N_e++` jest bezpieczne?

Tablice mają rozmiar `MAX_N_P = 1 000 000`. Symulacja ma warunki stabilności, które
gwarantują że N_e nie przekroczy tego limitu. Jeśli N_e zbliża się do MAX_N_P, coś
jest poważnie nie tak z parametrami symulacji.

---

## 4. Zderzenia jonów: `collisionIon()`

```go
func collisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int) {
    // vx_1/vy_1/vz_1 = prędkość jonu
    // vx_2/vy_2/vz_2 = losowo wybrana prędkość atomu Ar (z RMB)

    // Prędkość względna jon-atom
    gx = (*vx_1) - (*vx_2)
    gy = (*vy_1) - (*vy_2)
    gz = (*vz_1) - (*vz_2)
    g = √(gx² + gy² + gz²)

    // Prędkość środka masy (masy równe → po połowie)
    wx = 0.5 × ((*vx_1) + (*vx_2))
    wy = 0.5 × ...

    // Kąty Eulera (to samo co dla elektronów)
    ...

    // Wybór typu zderzenia:
    t1 = sigma[I_ISO][e_index]
    t2 = t1 + sigma[I_BACK][e_index]

    if R01() < (t1 / t2) {
        chi = acos(1 - 2×R01())   // izotropowe: losowy kąt
    } else {
        chi = PI                   // wsteczne: χ = 180° (zawróć!)
    }

    // Obrót i nowa prędkość jonu:
    *vx_1 = wx + 0.5×gx_new
    *vy_1 = wy + 0.5×gy_new
    *vz_1 = wz + 0.5×gz_new
}
```

### Jak to wywołujemy? (krok 8)

```go
func step8_collision_ions(t int) {
    if (t % N_SUB) != 0 { return }

    for k = 0; k < N_i; k++ {
        // Losuj prędkość termiczną atomu Ar
        vx_a = RMB()
        vy_a = RMB()
        vz_a = RMB()

        // Oblicz prędkość względną
        gx = vx_i[k] - vx_a
        gy = vy_i[k] - vy_a
        gz = vz_i[k] - vz_a
        g = √(gx² + gy² + gz²)

        energy = 0.5 × MU_ARAR × g² / EV_TO_J   // energia w układzie COM [eV]
        energy_index = int(energy/DE_CS + 0.5)

        nu = sigma_tot_i[energy_index] × g
        p_coll = 1 - exp(-nu × DT_I)

        if R01() < p_coll {
            collisionIon(&vx_i[k], &vy_i[k], &vz_i[k], &vx_a, &vy_a, &vz_a, energy_index)
            N_i_coll++
        }
    }
}
```

### Różnice między zderzeniami elektronów a jonów

| Aspekt | Elektrony | Jony |
|:-------|:----------|:-----|
| Aprox. gazu | Cold gas (Ar w spoczynku) | Prędkości termiczne Ar losowane z RMB() |
| Typy zderzeń | ELA, EXC, ION (3 typy) | ISO, BACK (2 typy) |
| Tworzenie nowych cząstek | TAK (jonizacja) | NIE |
| Energia w COM | `0.5×E_MASS×g²` (g=|v_e|) | `0.5×MU_ARAR×g²` (g=|v_ion-v_atom|) |
| Kiedy | Co krok | Co N_SUB kroków |

---

## 5. Wzbudzenie — krok energetyczny

```go
} else if rnd < (t1 / t2) {  // wzbudzenie
    energy = 0.5 × E_MASS × g² - E_EXC_TH × EV_TO_J  // energia po odj. progu
    energy = |energy|                                    // abs na wypadek błędów
    g = √(2 × energy / E_MASS)                          // nowa prędkość
    chi = acos(1 - 2×R01())                             // izotropowy kąt
    eta = 2π × R01()
}
```

Wzbudzenie to "elastyczne" zderzenie z **utratą 11.5 eV energii** (próg E_EXC_TH).
Energię tę pochłania atom Ar, który przechodzi do stanu wzbudzonego (Ar*).
Elektron traci prędkość, ale zmienia też kierunek.

---

## 6. Wydajność sekcji zderzeń

Zderzenia to zwykle ~30–40% całkowitego czasu symulacji. Warto je optymalizować.

Możliwe optymalizacje:
- **Null collision method**: Zamiast obliczać `sigma_tot` per cząstka, użyj
  globalnego maksimum `nu_max` i odrzucaj "null collisions" — prostsze, ale wymaga
  dodatkowych losowań.
- **Wektoryzacja**: Obliczanie `p_coll` wektorowo (NumPy, SIMD), zderzenia per-cząstka.
- **Goroutines**: Podział pętli po cząstkach między wątki Go.

---

## Podsumowanie

| Pojęcie | Wyjaśnienie |
|:--------|:-----------|
| `p_coll = 1 - exp(-ν·Δt)` | Prawdopodobieństwo zderzenia w kroku Δt |
| Cold gas approximation | Atom Ar nieruchomy → g = |v_e| |
| Kąty Eulera (theta, phi) | Orientacja wektora g przed zderzeniem |
| chi (angle of scattering) | Kąt rozpraszania — jak bardzo zmienia się kierunek |
| eta (azimuthal angle) | Kąt azymutalny — w jaką stronę obraca się cząstka |
| Macierz Eulera | Formuła obrotu 3D wektora g po zderzeniu |
| F1, F2 | Czynniki środka masy: F1=m_e/(m_e+m_Ar), F2=m_Ar/(m_e+m_Ar) |
| `N_e++` po jonizacji | Nowy elektron dodany do tablicy na pozycji N_e |

### Co możesz zmienić?

| Modyfikacja | Jak |
|:------------|:----|
| Dodaj nowy typ zderzenia | Nowy przypadek w `if-else` w `collisionElectron`, dodaj sigma[E_NEW] |
| Zmień modelowanie progów | Zmień `E_EXC_TH` lub `E_ION_TH` |
| Symuluj inny gaz | Zmień wzory w `setElectronCrossSectionsAr()` |
| Trójciałowe zderzenia | Bardziej zaawansowana fizyka — wymaga specjalnego traktowania |

---

**Następna lekcja:** [Lekcja 10 — Diagnostyki, dane i jak uruchamiać program](lekcja_10.md)
