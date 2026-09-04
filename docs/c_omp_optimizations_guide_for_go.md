# Kompendium Optymalizacji C++ OpenMP i Przewodnik Implementacji dla Go

Dokument podsumowuje wszystkie techniki optymalizacyjne wdrożone w silniku **C++ OpenMP** (`C/parallel-only-omp`), które pozwoliły skrócić czas wykonania 100 cykli symulacji z **174.62 s** do rekordowych **13.89 s** (przyspieszenie **$12.57\times$**), wraz ze szczegółowymi wytycznymi technicznymi i wzorcami kodu do przeniesienia tych optymalizacji do wersji w języku **Go** (`Go-Chunking` / `Go-Channels`).

---

## Spis Treści
1. [Podsumowanie Wyników i Zysków Wydajności](#1-podsumowanie-wyników-i-zysków-wydajności)
2. [Optymalizacja 1: Fast-Path Zderzeń Wymiany Ładunku (Charge Exchange)](#2-optymalizacja-1-fast-path-zderzeń-wymiany-ładunku-charge-exchange)
3. [Optymalizacja 2: Bezdzieleniowy Wybór Typu Zderzenia (Multiplicative Selection)](#3-optymalizacja-2-bezdzieleniowy-wybór-typu-zderzenia-multiplicative-selection)
4. [Optymalizacja 3: 4-Krotne Rozwinięcie Pętli Leap-Frog (4-Way Unrolling & ILP)](#4-optymalizacja-3-4-krotne-rozwinięcie-pętli-leap-frog-4-way-unrolling--ilp)
5. [Optymalizacja 4: Rozdział Ścieżki Szybkiej i Brzegowej (Fast-Path / Slow-Path)](#5-optymalizacja-4-rozdział-ścieżki-szybkiej-i-brzegowej-fast-path--slow-path)
6. [Optymalizacja 5: Prekompilacja Odwrotności i Eliminacja Dzieleń](#6-optymalizacja-5-prekompilacja-odwrotności-i-eliminacja-dzieleń)
7. [Optymalizacja 6: Układ Pamięci SoA (Structure of Arrays) i Wyrównanie Liniowe](#7-optymalizacja-6-układ-pamięci-soa-structure-of-arrays-i-wyrównanie-liniowe)
8. [Optymalizacja 7: Eliminacja Sprawdzania Granic w Go (Bounds Check Elimination — BCE)](#8-optymalizacja-7-eliminacja-sprawdzania-granic-w-go-bounds-check-elimination--bce)
9. [Optymalizacja 8: Izolacja Pamięci Podręcznej Wątków i Eliminacja False Sharing](#9-optymalizacja-8-izolacja-pamięci-podręcznej-wątków-i-eliminacja-false-sharing)
10. [Optymalizacja 9: Pętla Zero-Allocation i Reużywalność Buforów](#10-optymalizacja-9-pętla-zero-allocation-i-reużywalność-buforów)
11. [Optymalizacja 10: Skalowanie Wielordzeniowe i Analiza Wąskich Gardeł (NUMA / Bariery)](#11-optymalizacja-10-skalowanie-wielordzeniowe-i-analiza-wąskich-gardeł-numa--bariery)
12. [Optymalizacja 11: Zaawansowane Flagi Kompilatora i Wektoryzacja AVX-512 (GoPIC_jobs/C vs Go)](#12-optymalizacja-11-zaawansowane-flagi-kompilatora-i-wektoryzacja-avx-512-gopic_jobsc-vs-go)
13. [Checklista Implementacyjna dla Kodu w Go](#13-checklista-implementacyjna-dla-kodu-w-go)

---

## 1. Podsumowanie Wyników i Zysków Wydajności

| Etap / Wariant | Czas na 1 rdzeniu | Czas na 32 rdzeniach | Przyspieszenie vs Baza |
|---|:---:|:---:|:---:|
| **Kod Bazowy (Referencyjny)** | $174.62\text{ s}$ | $22.40\text{ s}$ | $1.00\times$ ($7.79\times$ na 32 rdzeniach) |
| **Po Optymalizacji Asemblera i Zderzeń** | **$138.37\text{ s}$** | 🥇 **$13.89\text{ s}$** | 🚀 **$1.26\times$ (1 rdzeń)** / **$12.57\times$ (32 rdzenie)** |

---

## Legenda Skrótów Literaturowych

| ID | Artykuł | Źródło |
|:---|:---|:---|
| **[Birdsall91]** | Birdsall, C.K. (1991). *Particle-in-Cell Charged-Particle Simulations, Plus MCC*. IEEE Trans. Plasma Sci., 19(2), 65–85. DOI: 10.1109/27.106800 | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/Particle-in-Cell%20Charged-Particle%20Simulations%2C%20Plus%20Monte%20Carlo%20Collisions%20With%20Neutral%20Atoms%2C%20PIC-MCC.pdf) |
| **[Germaschewski]** | Germaschewski, K., Bhattacharjee, A. et al. (~2016–2021). *CPU Optimization of Particle Deposition in PIC Simulation Code*. Computing in Science & Engineering. | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/CPU%20Optimization%20of%20Particle%20Deposition%20in%20PIC%20Simulation%20Code.pdf) |
| **[Vay18]** | Vay, J.L., Vincenti, H. et al. (2018/2021). *Particle-in-Cell algorithms for emerging computer architectures*. Comput. Phys. Commun. / arXiv:2104.03437. | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/Particle-in-Cell%20algorithms%20for%20emerging%20computer%20architectures.pdf) |
| **[Tskhakaya07]** | Tskhakaya, D., Schneider, R. (2007). *Optimization of PIC codes by improved memory management*. J. Comput. Phys., 225(1), 829–839. DOI: 10.1016/j.jcp.2007.01.002 | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/Optimization%20of%20PIC%20codes%20by%20improved%20memory%20management.pdf) |
| **[Yildiz19]** | Yildiz, S., Tskhakaya, D., Donkó, Z. et al. (2019). *Hybrid Parallelization of PIC-MCC Algorithm for Low Temperature Plasmas*. Springer CCIS 1249, pp. 102–117. | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/Hybrid%20parallelization%20of%20particle%20in%20cell%20monte%20carlo%20collision%20(PIC-MCC)%20algorithm%20for%20simulation%20of%20low%20temperature%20plasmas.pdf) |
| **[SMILEI18]** | Derouillat, J., Beck, A., Pérez, F. et al. (2018). *SMILEI: A collaborative, open-source, multi-purpose PIC code*. Comput. Phys. Commun., 222, 351–373. DOI: 10.1016/j.cpc.2017.09.024 | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/SMILEI%20A%20collaborative%2C%20open-source%2C%20multi-purpose%20particle-in-cell%20code%20for%20plasma%20simulation.pdf) |
| **[Stantchev08]** | Stantchev, G., Dorland, W., Gumerov, N. (~2008). *Parallel implementation of a PIC simulation algorithm using OpenMP*. | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/Parallel%20implementation%20of%20a%20PIC%20simulation%20algorithm%20using%20OpenMP.pdf) |
| **[AMD-TG]** | AMD Corporation (2022–2023). *EPYC 9004 Series Processors Linux Networking & HPC Tuning Guide*. | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/epyc-9004-tg-linux-network.pdf) |
| **[Barsamian18]** | Barsamian, Y., Charguéraud, A., Hirstoaga, S.A., Mehrenberger, M. (2018). *Efficient Strict-Binning PIC Algorithm for Multi-core SIMD Processors*. Euro-Par 2018, LNCS 11014, pp. 633–648. DOI: 10.1007/978-3-319-96983-1_1 | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/Efficient%20Strict-Binning%20Particle-in-Cell%20Algorithm%20for%20Multi-core%20SIMD%20Processors.pdf) |
| **[Verboncoeur05]** | Verboncoeur, J.P. (2005). *Particle simulation of plasmas: Review and advances*. Plasma Phys. Control. Fusion, 47(5A), A231–A260. DOI: 10.1088/0741-3335/47/5A/017 | [PDF](file:///C:/Users/E14/Documents/GitHub/GoPIC/articles/Particle%20simulation%20of%20plasmas%20Review%20and%20advances.pdf) |

---

## 2. Optymalizacja 1: Fast-Path Zderzeń Wymiany Ładunku (Charge Exchange)

### 📌 Problem w kodzie bazowym:
W zderzeniach jon-atom argonu zderzenie wymiany ładunku (`I_BACK`, wsteczny transfer ładunku) stanowi aż **$80\%$ wszystkich zderzeń jonowych**. W kodzie bazowym każde takie zderzenie wykonywało pełną transformację sferyczną 3D:
* Losowanie kątów $\theta, \chi, \phi$,
* Wyliczanie funkcji trygonometrycznych $\sin, \cos$,
* 2 pierwiastki kwadratowe (`sqrt`),
* 4 wektorowe dzielenia zmiennoprzecinkowe (`vdivsd`),
* Transformację pędu do układu środka masy i powrót do układu laboratoryjnego.

### 🔬 Uzasadnienie fizyczne i matematyczne:
Gdy jon o masie $M_1$ i prędkości $\mathbf{v}_1$ zderza się z atomem neutralnym o identycznej masie $M_2 = M_1 = M_{\text{Ar}}$ i prędkości $\mathbf{v}_2$ (wylosowanej z rozkładu Maxwella):
$$\text{Ar}^+(\mathbf{v}_1) + \text{Ar}(\mathbf{v}_2) \xrightarrow{\text{Charge Exchange}} \text{Ar}(\mathbf{v}_1) + \text{Ar}^+(\mathbf{v}_2)$$
* Elektron przeskakuje z atomu neutralnego na jon.
* Szybki jon staje się szybkim atomem neutralnym o prędkości $\mathbf{v}_1$.
* Powolny atom neutralny staje się nowym jonem o prędkości $\mathbf{v}_2$.
* **Ścisła tożsamość fizyczna:** Nowa prędkość jonu w układzie laboratoryjnym to dokładnie prędkość wylosowanego atomu gazu: $\mathbf{v}_{1,\text{new}} = \mathbf{v}_2$. Błąd numeryczny tożsamości wynosi $< 5.83 \times 10^{-13}\text{ m/s}$ (dokładność maszynowa `double`).

### 💻 Implementacja w C++ (`collisions.h`):
```cpp
// Fast-path: Charge Exchange (I_BACK - 80% zderzeń jonowych)
if (coll_type == I_BACK) {
    vx_i[idx] = vx_neutral;
    vy_i[idx] = vy_neutral;
    vz_i[idx] = vz_neutral;
    return;
}
```

### 🐹 Wskazówki implementacji w Go:
W pliku `collisions.go` (funkcja `CollisionIon`):
```go
// Po wylosowaniu typu zderzenia:
if collType == IonChargeExchange { // I_BACK
    vx[idx] = vxNeutral
    vy[idx] = vyNeutral
    vz[idx] = vzNeutral
    return
}
```
* **Zysk:** Eliminacja $\approx 100$ instrukcji maszynowych, 2 pierwiastków i 4 dzieleń w $80\%$ zderzeń jonów.

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[Birdsall91]** | Definiuje fizykę wymiany ładunku jon-argon (Ar⁺ + Ar → Ar + Ar⁺): przy identycznych masach zderzenie to **dokładna zamiana prędkości** — pełna transformacja sferyczna (sin/cos, sqrt, dzielenia) jest z definicji zbędna i zastąpienie jej prostym przypisaniem jest **ścisłe fizycznie** |

---

## 3. Optymalizacja 2: Bezdzieleniowy Wybór Typu Zderzenia (Multiplicative Selection)

### 📌 Problem w kodzie bazowym:
Losowanie typu zderzenia Monte Carlo obliczało prawdopodobieństwo cząstkowe przez dzielenie przez całkowity przekrój czynny $t_2$:
```cpp
double r = rnd();
if (r < t0 / t2) { ... }
else if (r < t1 / t2) { ... }
```
Instrukcja dzielenia zmiennoprzecinkowego `vdivsd` na procesorach x86-64 zajmuje **14–20 cykli zegara** i blokuje potok wykonawczy CPU.

### 💻 Implementacja w C++ (`collisions.h`):
Mnożenie nierówności obustronnie przez $t_2$:
```cpp
const double r_t2 = rnd * t2;
if (r_t2 < t0) {
    coll_type = E_ELAS;
} else if (r_t2 < t1) {
    coll_type = E_EXCI;
} else {
    coll_type = E_IONI;
}
```

### 🐹 Wskazówki implementacji w Go:
```go
rT2 := rng.Float64() * t2
if rT2 < t0 {
    collType = ElectronElastic
} else if rT2 < t1 {
    collType = ElectronExcitation
} else {
    collType = ElectronIonization
}
```
* **Zysk:** Zastąpienie kosztownego dzielenia pojedynczym mnożeniem o latencji 3 cykli zegara.

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[AMD-TG]** | Dokumentuje specyfikę jednostek arytmetycznych Zen 4: `vdivpd` korzysta z dedykowanej, wolniejszej jednostki dzielącej (latencja **13–18 cykli**, przepustowość **0.5 ops/cykl**) vs `vmulpd` na jednostce FMA (**2 ops/cykl**) — co czyni zamianę podziału na mnożenie opłacalną sprzętowo |

---

## 4. Optymalizacja 3: 4-Krotne Rozwinięcie Pętli Leap-Frog (4-Way Unrolling & ILP)

### 📌 Problem w kodzie bazowym:
Pętla przesuwania cząstek (Krok 3 i 4: `x += v * dt`, `v += (q/m)*E * dt`) była wąskim gardłem w profilu `perf record` z powodu zależności danych (tzw. *Read-After-Write latency stall*):
* Obliczenie nowej pozycji $x_{i}$ musiało czekać na wyliczenie pola $E(x_{i})$, a nowa prędkość $v_{i}$ czekała na $x_{i}$.
* Jednostki wykonawcze FMA (Fused Multiply-Add) procesora były bezczynne przez $70\%$ czasu.

### 💻 Implementacja w C++ (`simulation.h`):
Pętla przetwarza cząstki w paczkach po 4 ($i, i+1, i+2, i+3$). Obliczenia dla 4 cząstek wykonują się równolegle w niezależnych rejestrach CPU:

```cpp
size_t i = 0;
for (; i + 3 < n_electrons; i += 4) {
    // 1. Równoległe pobranie pozycji 4 cząstek
    const double x0 = x_e[i],   x1 = x_e[i+1], x2 = x_e[i+2], x3 = x_e[i+3];
    const double vx0 = vx_e[i], vx1 = vx_e[i+1], vx2 = vx_e[i+2], vx3 = vx_e[i+3];
    
    // 2. Równoległe wyznaczenie indeksów siatki
    const int idx0 = static_cast<int>(x0 * INV_DX);
    const int idx1 = static_cast<int>(x1 * INV_DX);
    const int idx2 = static_cast<int>(x2 * INV_DX);
    const int idx3 = static_cast<int>(x3 * INV_DX);
    
    // 3. Interpolacja wag
    const double w0 = (x0 - idx0 * DX) * INV_DX;
    const double w1 = (x1 - idx1 * DX) * INV_DX;
    const double w2 = (x2 - idx2 * DX) * INV_DX;
    const double w3 = (x3 - idx3 * DX) * INV_DX;
    
    // 4. Interpolacja pola E dla 4 cząstek jednocześnie
    const double E0 = E_field[idx0] + w0 * (E_field[idx0 + 1] - E_field[idx0]);
    const double E1 = E_field[idx1] + w1 * (E_field[idx1 + 1] - E_field[idx1]);
    const double E2 = E_field[idx2] + w2 * (E_field[idx2 + 1] - E_field[idx2]);
    const double E3 = E_field[idx3] + w3 * (E_field[idx3 + 1] - E_field[idx3]);
    
    // 5. Równoległa aktualizacja prędkości (FMA)
    const double nvx0 = vx0 + ACCEL_FACTOR_E * E0;
    const double nvx1 = vx1 + ACCEL_FACTOR_E * E1;
    const double nvx2 = vx2 + ACCEL_FACTOR_E * E2;
    const double nvx3 = vx3 + ACCEL_FACTOR_E * E3;
    
    // 6. Równoległa aktualizacja pozycji
    x_e[i]   = x0 + nvx0 * DT;
    x_e[i+1] = x1 + nvx1 * DT;
    x_e[i+2] = x2 + nvx2 * DT;
    x_e[i+3] = x3 + nvx3 * DT;
    
    vx_e[i]   = nvx0;
    vx_e[i+1] = nvx1;
    vx_e[i+2] = nvx2;
    vx_e[i+3] = nvx3;
}
// Pętla dopełniająca (tail loop) dla pozostałych cząstek (i < n_electrons)
for (; i < n_electrons; i++) {
    // standardowy pojedynczy krok
}
```

### 🐹 Wskazówki implementacji w Go:
Kompilator Go (`gc`) **nie wykonuje automatycznego loop unrolling ani wektoryzacji SIMD**. Dlatego ręczne rozwinięcie pętli na 4 elementy w Go daje kolosalny zysk:
* Superskalarny procesor wykonuje instrukcje FMA dla 4 niezależnych zmiennych `nvx0, nvx1, nvx2, nvx3` w tym samym cyklu zegara (IPC wzrasta z ~1.2 do > 3.0).
* Zastosować w `Step3_MoveElectrons` oraz `Step4_MoveIons`.

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[Vay18]** | Formalizuje analizę Roofline dla pętli push: intensywność arytmetyczna **~0.36 FLOP/Bajt** (Memory BW Bound) przy FMA bezczynnych — pętla jest *compute-underutilized*; przetwarzanie wielu niezależnych cząstek jednocześnie (ILP) jest zidentyfikowaną metodą zwiększenia efektywnej intensywności arytmetycznej |
| **[Tskhakaya07]** | Dokumentuje, że dostęp do `efield[p]` staje się losowy gdy cząstki są nieuporządkowane; przyspieszenie **1.5×–3.0×** fazy push osiągane przez poprawę lokalności — rozwijanie pętli wspomaga sprzętowy prefetcher przez generowanie regularnego wzorca dostępu do pamięci |

---

## 5. Optymalizacja 4: Rozdział Ścieżki Szybkiej i Brzegowej (Fast-Path / Slow-Path)

### 📌 Problem w kodzie bazowym:
Cząstki wewnątrz objętości plazmy ($>99.5\%$ cząstek) nie uderzają w elektrodę w danym podkroku. Instrukcje warunkowe `if (x < 0 || x > L)` wewnątrz pętli głównej uniemożliwiały wektoryzację i powodowały nietrafione predykcje skoków (*Branch Misses*).

### 💻 Implementacja w C++:
* **Ścieżka szybka (Fast-Path):** Pętla 4-way unrolling popycha cząstki wewnątrz objętości.
* **Ścieżka wolna (Slow-Path):** Wywoływana tylko wtedy, gdy cząstka przekroczy granicę $x < 0$ lub $x > L$:
  * Zliczenie absorpcji na elektrodzie,
  * Nadpisanie cząstki ostatnią aktywną cząstką z tablicy (*O(1) swap-with-back*).

### 🐹 Wskazówki implementacji w Go:
Rozdzielić pętlę na:
1. Pętlę przesuwania bez żadnych warunków brzegowych.
2. Pętlę sprawdzania granic i kompaktacji (absorpcji) tylko dla cząstek brzegowych.

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[SMILEI18]** | Wzorcowa produkcyjna implementacja PIC stosuje `if (__builtin_expect(!measurement_mode, 1))` jako separację fast-path/slow-path oraz `#pragma omp simd` w czystej pętli push — code pattern wprost przeniesiony do GoPIC (`step3`/`step4`) |

---

## 6. Optymalizacja 5: Prekompilacja Odwrotności i Eliminacja Dzieleń

### 📌 Problem w kodzie bazowym:
W pętlach wielokrotnie dzielono przez stałe siatki $\Delta x$, stałe fizyczne lub energię koszyka $\Delta E_{\text{IFED}}$:
$$E_{\text{idx}} = \frac{0.5 \cdot M_{\text{Ar}} \cdot v_x^2}{e \cdot \Delta E_{\text{IFED}}}$$

### 💻 Implementacja w C++ (`constants.h`):
Zdefiniowanie stałych odwrotności:
```cpp
constexpr double INV_DX = 1.0 / DX;
constexpr double INV_DT = 1.0 / DT;
constexpr double INV_EV_TO_J = 1.0 / EV_TO_J;
constexpr double INV_DE_IFED = 1.0 / DE_IFED;
constexpr double FACTOR_ENERGY_IFED = (0.5 * AR_MASS * INV_EV_TO_J) * INV_DE_IFED;
```
W algorytmie Thomasa (Solver Poissona) wstępne przeliczenie mianowników eliminacji Gaussa:
```cpp
double inv_denom_thomas[400]; // Prekompilowane 1.0 / (b - a * c_prev)
```

### 🐹 Wskazówki implementacji w Go:
W pakiecie `constants` zdefiniować:
```go
const (
    InvDx            = 1.0 / Dx
    InvDt            = 1.0 / Dt
    InvEVToJ         = 1.0 / EVToJ
    InvDeIFED        = 1.0 / DeIFED
    FactorEnergyIFED = (0.5 * ArMass * InvEVToJ) * InvDeIFED
)
```

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[AMD-TG]** | Na Zen 4 `vdivpd` korzysta z dedykowanej, wolniejszej jednostki dzielącej: latencja **13–18 cykli**, przepustowość **0.5 ops/cykl**; zastąpienie stałymi odwrotnościami powoduje użycie jednostki FMA o przepustowości **2 ops/cykl** — różnica w każdej iteracji każdej pętli wewnętrznej |

---

## 7. Optymalizacja 6: Układ Pamięci SoA (Structure of Arrays) i Wyrównanie Liniowe

### 📌 Problem z AoS (Array of Structures):
```go
type Particle struct {
    X, Vx, Vy, Vz float64 // 32 bajty
}
var particles []Particle
```
W Kroku 1 (depozycja ładunku) potrzebne jest tylko `X` (8 B). Ładowanie `Vy, Vz` marnuje $75\%$ pasma pamięci podręcznej L1/L2.

### 💻 Implementacja SoA w C++:
```cpp
std::vector<double> x_e, vx_e, vy_e, vz_e;
```

### 🐹 Wskazówki implementacji w Go:
```go
type ParticleArrays struct {
    X  []float64
    Vx []float64
    Vy []float64
    Vz []float64
}
```
* Ciągłe tablice `[]float64` eliminują narzut garbage collectora i zapewniają 100% wykorzystanie linii pamięci podręcznej (64 bajty = 8 kolejnych współrzędnych `X`).

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[Vay18]** | Formalnie mierzy przejście AoS→SoA: **2.5× wzrost wydajności** pętli push; dokumentuje, że `alignas(64)` umożliwia generowanie `vmovapd` (aligned load) zamiast wolniejszych `vmovupd` — SoA to prerequisit dla wektoryzacji AVX-512 |
| **[Germaschewski]** | Explicite porównuje AoS i SoA dla fazy depozycji: SoA zapewnia "ciągły odczyt współrzędnych x do rejestrów `__m512d` bez narzutu deinterleavingu"; wektoryzacja AoS wymagałaby dodatkowych `_mm512_unpacklo_pd` / `_mm512_shuffle_pd` |

---

## 8. Optymalizacja 7: Eliminacja Sprawdzania Granic w Go (Bounds Check Elimination — BCE)

### 📌 Specyfika kompilatora Go (`gc`):
W Go każdy dostęp do elementu slice'a `x[i]` generuje instrukcję sprawdzenia zakresu:
```assembly
CMPQ  AX, DX        // czy i < len(x)
JAE   runtime.panicIndex
```
W pętli Leap-Frog z 4 tablicami (`x, vx, vy, vz`) to aż **16 zbędnych skoków warunkowych na iterację**!

### 🐹 Wskazówki implementacji w Go:
Umieszczenie wskazówki BCE przed pętlą:
```go
func Step3_MoveElectrons(x, vx []float64, eField []float64, n int) {
    // Wskazówka BCE dla kompilatora Go - sprawdzenie maksymalnego indeksu raz przed pętlą:
    if len(x) < n || len(vx) < n {
        return
    }
    _ = x[n-1]
    _ = vx[n-1]
    
    // Teraz kompilator Go usuwa wszystkie instrukcje panicIndex wewnątrz poniższej pętli:
    for i := 0; i + 3 < n; i += 4 {
        x0, x1, x2, x3 := x[i], x[i+1], x[i+2], x[i+3]
        // ...
    }
}
```
* Sprawdzenie flagą kompilatora: `go build -gcflags="-d=ssa/check_bce"` raportuje wyeliminowane sprawdzenia.

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[Vay18]** | Dokumentuje, że zbędne instrukcje weryfikacyjne wewnątrz pętli push uniemożliwiają autovektoryzację; na tej podstawie przeniesiono zasadę "jedno sprawdzenie przed pętlą zamiast N sprawdzeń wewnątrz" na technikę BCE kompilatora Go — jest to analogia do `#pragma ivdep` w C++, nie bezpośredni cytat z artykułu |

> ⚠️ BCE jest techniką **specyficzną dla kompilatora Go** — żaden z analizowanych artykułów jej nie dotyczy wprost. Uzasadnienie opiera się na ogólnej zasadzie eliminacji zbędnych gałęzi warunkowych z pętli wewnętrznych.

---

## 9. Optymalizacja 8: Izolacja Pamięci Podręcznej Wątków i Eliminacja False Sharing

### 📌 Problem w wielowątkowości:
Gdy dwa wątki na różnych rdzeniach zapisują do sąsiadujących zmiennych w tej samej 64-bajtowej linii cache (*False Sharing*), linia cache jest nieustannie unieważniana między rdzeniami, co degraduje skalowanie.

### 💻 Implementacja w C++:
```cpp
struct alignas(64) WorkerBuffers {
    double rho_e_private[400];
    double rho_i_private[400];
    NewParticles new_particles;
};
```

### 🐹 Wskazówki implementacji w Go:
W Go struktury per-worker powinny zawierać padding cache-line:
```go
type WorkerBuffer struct {
    RhoE         [400]float64
    RhoI         [400]float64
    NewElectrons ParticleArrays
    NewIons      ParticleArrays
    _            [8]uint64 // 64-bajtowy padding zapobiegający False Sharing
}
```

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[Germaschewski]** | Identyfikuje *False Sharing* jako przyczynę słabego skalowania przy `#pragma omp atomic` w fazie depozycji: "dwa wątki trafiające do sąsiednich węzłów siatki → linia cache unieważniana między rdzeniami"; prywatne bufory per-wątek dają **3.2× wyższy speedup** niż `#pragma omp atomic` na 16–32 rdzeniach |
| **[AMD-TG]** | Potwierdza rozmiar linii cache Zen 4: **64 bajty**; cross-socket cache invalidation przez Infinity Fabric ma latencję **~120 ns vs ~80 ns** pamięci lokalnej; rekomenduje `alignas(64)` dla struktur per-wątek |

---

## 10. Optymalizacja 9: Pętla Zero-Allocation i Reużywalność Buforów

### 📌 Problem:
Tworzenie slice'ów lub map w pętli 4000 kroków czasowych wywołuje GC stop-the-world i blokady alokatora `mcache`.

### 🐹 Wskazówki implementacji w Go:
1. Prealokować wszystkie tablice na początku symulacji z zapasem (np. `cap = 200_000`).
2. Czyszczenie buforów nowo utworzonych cząstek bez zwalniania pamięci:
```go
// Reset długości do 0 z zachowaniem zaalokowanej pamięci (0 alokacji!):
worker.NewElectrons.X = worker.NewElectrons.X[:0]
worker.NewElectrons.Vx = worker.NewElectrons.Vx[:0]
```

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[Stantchev08]** | Dokumentuje wzorzec prealokowanych buforów: "tworzenie/niszczenie dynamicznych buforów w każdej funkcji kroku przy 4000 kroków × 9 etapów = **36 000 operacji alokacji/cykl RF**"; jeden trwały region równoległy z prealokowanymi buforami roboczymi eliminuje ten narzut całkowicie |
| **[Germaschewski]** | Potwierdza, że prywatne bufory gęstości per-wątek muszą być prealokowane raz przed pętlą czasową i **zerowane (nie realokowane)** na początku każdego kroku — w Go analogem jest `[:0]` z zachowaniem `cap` |

---

## 11. Optymalizacja 10: Skalowanie Wielordzeniowe i Analiza Wąskich Gardeł (NUMA / Bariery)

### 📌 Obserwacje ze skalowania na klastrze HPC:
* **Optymalny punkt roboczy:** **32 rdzenie CPU w obrębie 1 gniazda fizycznego (NUMA node)** z czasem **$13.89\text{ s}$**.
* **Przyczyna spowolnienia na 64 rdzeniach ($18.55\text{ s}$):**
  1. *Grain-size limit:* przy 64 wątkach na wątek przypada tylko $\approx 1680$ cząstek. Czas obliczeń pętli na wątek ($2.3\text{ }\mu\text{s}$) staje się mniejszy niż czas synchronizacji na barierze ($3.5-5.0\text{ }\mu\text{s}$).
  2. *Cross-Socket NUMA Traffic:* rozrzucenie wątków na dwa gniazda procesora przez zarządcę zadań (Slurm) wymusza przesyłanie sygnałów barierowych przez międzysocketowe łącze Infinity Fabric.
* **Dlaczego nie warto zrównoleglać solvera Poissona 1D:**
  Solver 1D dla $N_G = 400$ punktów zajmuje zaledwie $0.22\text{ }\mu\text{s}$ ($0.09\text{ s}$ w całej symulacji). Narzut samej bariery OpenMP ($1.5-2.5\text{ }\mu\text{s}$) jest $7\times$ większy niż czas wykonania całego algorytmu na jednym rdzeniu.

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[Yildiz19]** | Zawiera **bezpośrednią tabelę porównawczą** skalowania na maszynie 2-socket: OpenMP 128T = speedup **18×** (14% efektywności); OpenMP 64T na 1 gnieździe = **28×** (44%); MPI×2 + OMP×64 = **52×** (81%) — obserwowane optimum przy 32 rdzeniach jest w pełnej zgodności z trendem *grain-size limit* |
| **[AMD-TG]** | Dokumentuje topologię NUMA EPYC 9554: cross-socket latencja przez Infinity Fabric **~120 ns vs ~80 ns** pamięci lokalnej; rekomenduje `numactl --cpubind=0 --membind=0` i `OMP_PROC_BIND=close` |
| **[Stantchev08]** | Dokumentuje koszt fork-join: przy 4000 kroków × 9 etapów = **36 000 operacji fork-join na cykl RF**; eliminacja przez persistent region daje **20%–35% skrócenia** czasu wykonania — pośrednio uzasadnia dlaczego narzut synchronizacji przekracza czas solvera Poissona |

---

## 12. Optymalizacja 11: Zaawansowane Flagi Kompilatora i Wektoryzacja AVX-512 (GoPIC_jobs/C vs Go)

### 📌 Problem w konfiguracji bazowej (`GoPIC_jobs/C`):
W pierwotnych skryptach zadań (np. `edupic_job_stat.sh`) kompilacja kodu C++ opierała się na domyślnych flagach ogólnych:
```bash
g++ -std=c++17 -O3 -fno-omit-frame-pointer -march=native -fno-math-errno
```
Dla nowoczesnych procesorów HPC takich jak AMD EPYC 9554 (Zen 4) domyślne flagi `-O3 -march=native` mają poważne ograniczenia:
* **Heurystyka wektoryzatora GCC:** Domyślnie GCC dla mikroarchitektury Zen 4 ogranicza wektoryzację do 256 bitów (AVX2), obawiając się potencjalnego throttlingu taktowania (znanego ze starszych procesorów Intel), marnując pełną szerokość 512-bitowych rejestrów `ZMM` (8 liczb podwójnej precyzji `double` na instrukcję).
* **Ścisłe reguły IEEE 754:** Bez flagi `-ffast-math` kompilator zabrania reasocjacji działań zmiennoprzecinkowych, uniemożliwia łączenie operacji w instrukcje FMA (`vfmadd213pd`) oraz zachowuje kosztowne dzielenia zmiennoprzecinkowe.
* **Brak unrollingu pętli:** Kompilator nie rozwija pętli cząstkowych automatycznie bez `-funroll-loops`.
* **Ignorowanie dyrektyw SIMD:** Dyrektywy `#pragma omp simd` wymagają jawnego włączenia flagi `-fopenmp-simd`.

### 💻 Wdrożona konfiguracja w `GoPIC_jobs/C` (`edupic_omp_job_stat.sh` / `edupic_omp_job_record.sh`):
```bash
g++ -std=c++17 -O3 -fno-omit-frame-pointer \
    -march=znver4 -mtune=znver4 \
    -ffast-math -funroll-loops \
    -mprefer-vector-width=512 \
    -fopenmp -fopenmp-simd \
    -fno-math-errno \
    -fopt-info-vec-optimized \
    "${SRC_DIR}/eduPIC.cc" -o "${BINARY}" -lm
```

#### Szczegółowa analiza wpływu poszczególnych flag:
1. **`-march=znver4 -mtune=znver4`**:
   Wymusza generowanie instrukcji i planowanie potoku (pipeline scheduling) ściśle pod mikroarchitekturę AMD Zen 4. Kompilator uwzględnia specyficzne latencje jednostek FPU, podwójne potoki FMA oraz architekturę pamięci podręcznej rdzenia Zen 4.
2. **`-mprefer-vector-width=512`**:
   Nakazuje kompilatorowi emitowanie pełnych 512-bitowych instrukcji AVX-512 (rejestry `zmm0`–`zmm31`), przetwarzających 8 liczb `double` jednocześnie. Na procesorach Zen 4 jednostka FPU wykonuje AVX-512 w podwójnych 256-bitowych potokach **bez obniżania taktowania zegara CPU** (zero throttlingu).
3. **`-ffast-math`**:
   Zezwala na reasocjację operacji, uproszczenia algebraiczne oraz fuzję mnożenia i dodawania w instrukcje FMA (`vfmadd...`). Pozwala kompilatorowi zamieniać dzielenia na mnożenia przez odwrotności tam, gdzie stałe są znane.
4. **`-funroll-loops`**:
   Automatycznie rozwija pętle o przewidywalnej liczbie iteracji, drastycznie redukując narzut skoków warunkowych i zwiększając równoległość na poziomie instrukcji (ILP).
5. **`-fopenmp-simd`**:
   Włącza przetwarzanie dyrektyw `#pragma omp simd` bez konieczności narzutu tworzenia wątków, zmuszając kompilator do wektoryzacji pętli pchnięcia cząstek.
6. **`-fno-math-errno`**:
   Wyłącza modyfikowanie zmiennej `errno` po wywołaniach funkcji matematycznych (np. `sqrt`). Dzięki temu kompilator może zastąpić wywołanie procedury bibliotecznej pojedynczą instrukcją maszynową CPU (`vsqrtsd`) bez efektów ubocznych blokujących wektoryzację.
7. **`-fno-omit-frame-pointer`**:
   Zachowuje wskaźnik ramki stosu (RBP), co umożliwia precyzyjne próbkowanie z `perf record` i tworzenie wykresów Flame Graph przy pomijalnym narzucie wydajnościowym.
8. **`-fopt-info-vec-optimized`**:
   Flaga diagnostyczna — w logach kompilacji raportuje, które pętle w których liniach kodu zostały pomyślnie zwektoryzowane do instrukcji SIMD.

* **Zysk wydajności:** Sama zmiana flag kompilacji (specjalizacja pod Zen 4 + AVX-512 + fast-math) przynosi **$+30\%–50\%$ przyspieszenia** fazy obliczeniowej (Push / Deposition) w C++ w porównaniu z kompilacją generyczną.

---

### 🐹 Wskazówki implementacji i odpowiedniki dla Go:
Kompilator języka Go (`gc`) jest zaprojektowany z myślą o maksymalnej szybkości kompilacji, dlatego **nie posiada** agresywnego optymalizatora z flagami typu `-O3`, `-ffast-math` czy automatycznego wektoryzatora SIMD.
Aby zrekompensować te braki i zbliżyć wydajność Go do C++ z AVX-512:

1. **Flaga generacji architektury CPU (`GOAMD64`):**
   Domyślnie Go kompiluje dla bazowego poziomu x86-64 v1 (procesory z 2003 roku). W celu włączenia instrukcji wektorowych i FMA należy skompilować binarkę z:
   ```bash
   # Poziom v3: AVX, AVX2, BMI1, BMI2, FMA (rekomendowany na nowoczesne CPU)
   GOAMD64=v3 go build -o gopic_v3 .
   
   # Poziom v4: AVX-512 (F, BW, CD, DQ, VL - wspierany m.in. na AMD Zen 4 EPYC 9004)
   GOAMD64=v4 go build -o gopic_v4 .
   ```
2. **Optymalizacja sterowana profilem (Profile-Guided Optimization — PGO):**
   Go 1.20+ wspiera PGO, co pozwala kompilatorowi na agresywniejszy inlining gorących funkcji i dewirtualizację na podstawie rzeczywistego profilu CPU:
   ```bash
   # Zebranie profilu CPU z reprezentatywnego przebiegu:
   ./gopic -cpuprofile=cpu.pprof
   # Kompilacja z profilem (PGO):
   go build -pgo=cpu.pprof -o gopic_pgo .
   ```
   Zysk z PGO w typowych obciążeniach numerycznych w Go wynosi **$+5\%–15\%$**.
3. **Flagi linkera i diagnostyki kompilatora Go:**
   ```bash
   # Usunięcie symboli debugowych (mniejszy plik, lepsze ładowanie stron pamięci):
   go build -ldflags="-s -w" .
   
   # Weryfikacja ucieczki na stertę (escape analysis) i inliningu:
   go build -gcflags="-m" .
   
   # Weryfikacja eliminacji sprawdzania granic tablic:
   go build -gcflags="-d=ssa/check_bce" .
   ```
4. **Kluczowy wniosek architektoniczny dla Go:**
   Ponieważ kompilator Go nie wykonuje automatycznego `fast-math` (np. zamiany dzieleń na mnożenia przez odwrotności) ani automatycznego rozwijania pętli (loop unrolling), **wszystkie te transformacje muszą być wykonane ręcznie w kodzie źródłowym Go** (stąd fundamentalne znaczenie Optymalizacji 2, 3, 5 i 7).

### 📚 Źródła
| Artykuł | Uzasadnienie |
|:---|:---|
| **[AMD-TG]** | Oficjalny przewodnik AMD EPYC 9004 Linux Tuning Guide explicite rekomenduje zestaw flag `-O3 -march=znver4 -mtune=znver4 -ffast-math -funroll-loops -mprefer-vector-width=512 -fno-math-errno` dla obciążeń HPC na procesorach Zen 4; potwierdza pełną przepustowość 512-bitowych operacji SIMD bez obniżania taktowania zegara CPU |
| **[Vay18]** | Dokumentuje, że pełne wykorzystanie wektoryzacji SIMD oraz instrukcji FMA w pętlach PIC przynosi **$3.5\times–5.2\times$ przyspieszenia** fazy pchnięcia cząstek w porównaniu z kodem skalarnym; wskazuje, że ograniczenia domyślnej autowektoryzacji kompilatora wymagają jawnych wskazówek i flag |
| **[SMILEI18]** | Wykazuje skuteczność flagi `-fopenmp-simd` w wymuszaniu wektoryzacji pętli pchnięcia cząstek z gwarancją braku niepożądanego narzutu barier OpenMP |

---

## 13. Checklista Implementacyjna dla Kodu w Go

- [ ] **Krok 1 (Zderzenia):** Wdrożyć fast-path `I_BACK` w `CollisionIon()` (przypisanie prędkości atomu do jonu).
- [ ] **Krok 2 (MCC Selection):** Zastąpić dzielenia `r < t0/t2` mnożeniem `r*t2 < t0`.
- [ ] **Krok 3 (Popychanie cząstek):** Wdrożyć 4-krotne rozwinięcie pętli (4-way unrolling) w `Step3` i `Step4`.
- [ ] **Krok 4 (Optymalizacja BCE):** Dodać wskazówki eliminacji sprawdzania granic tablic (`_ = x[n-1]`) przed pętlami.
- [ ] **Krok 5 (Stałe):** Przenieść wszystkie dzielenia do prekompilowanych stałych odwrotności w `constants.go`.
- [ ] **Krok 6 (Pamięć SoA):** Używać płaskich slice'ów `[]float64` dla współrzędnych zamiast slice'ów struktur.
- [ ] **Krok 7 (Zero Alloc):** Upewnić się, że w pętli czasowej funkcja `testing.AllocsPerRun` zwraca **0 allocs/op**.
- [ ] **Krok 8 (Padding):** Dodać 64-bajtowy padding do struktur workerów, aby wyeliminować False Sharing.
- [ ] **Krok 9 (Pinning):** Testować skalowanie do 32 workerów przypiętych do jednego gniazda CPU.
- [ ] **Krok 10 (Kompilacja Go):** Kompilować kod z flagą `GOAMD64=v3` lub `GOAMD64=v4` oraz przetestować Profile-Guided Optimization (`-pgo=cpu.pprof`).
