# Lekcja 2: Stałe i zmienne globalne — każda liczba ma sens

> **Poprzednia lekcja:** [Lekcja 1 — Mapa kodu](lekcja_01.md)
> **Następna lekcja:** [Lekcja 3 — Generator liczb losowych i przekroje czynne](lekcja_03.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Co oznacza każda stała w sekcji `const`
- Skąd biorą się wartości pochodne (jak DT_E, DX, FACTOR_E)
- Jak jest zorganizowana pamięć na cząstki i siatkę
- Jak odczytać "sens fizyczny" zmiennej z jej nazwy i wartości

---

## 1. Stałe natury (linie 21–31)

```go
const (
    PI          float64 = 3.141592653589793
    TWO_PI      float64 = 2.0 * PI
    E_CHARGE    float64 = 1.60217662e-19   // ładunek elementarny [C]
    EV_TO_J     float64 = E_CHARGE         // 1 eV = 1.6e-19 J
    E_MASS      float64 = 9.10938356e-31   // masa elektronu [kg]
    AR_MASS     float64 = 6.63352090e-26   // masa atomu Argonu [kg]
    MU_ARAR     float64 = AR_MASS / 2.0    // masa zredukowana Ar-Ar [kg]
    K_BOLTZMANN float64 = 1.38064852e-23   // stała Boltzmanna [J/K]
    EPSILON0    float64 = 8.85418781e-12   // przenikalność elektryczna próżni [F/m]
)
```

Są to **stałe fizyczne** — wartości zmierzone eksperymentalnie. Żadna z nich nie zmienia
się w symulacji.

### Dlaczego `EV_TO_J = E_CHARGE`?

Elektronowolt (eV) to jednostka energii używana w fizyce plazmy.
- 1 eV = energia jaką elektron zyskuje przyspieszony przez napięcie 1 V
- Matematycznie: 1 eV = q × 1V = 1.6×10⁻¹⁹ C × 1 V = 1.6×10⁻¹⁹ J

Dlatego `EV_TO_J = E_CHARGE`. Mnożąc energię w eV przez `EV_TO_J` dostajemy dżule.

### Dlaczego `MU_ARAR = AR_MASS / 2`?

To **masa zredukowana** dwóch identycznych atomów Argonu:
```
μ = (m₁ × m₂) / (m₁ + m₂) = (m_Ar × m_Ar) / (2 × m_Ar) = m_Ar / 2
```
Używamy jej do obliczania energii kinetycznej w układzie środka masy podczas zderzeń jon-atom.

---

## 2. Parametry symulacji (linie 33–46)

```go
const (
    N_G            int     = 400       // liczba punktów siatki
    N_T            int     = 4000      // kroków czasowych na cykl RF
    FREQUENCY      float64 = 13.56e6  // częstotliwość RF [Hz]
    VOLTAGE        float64 = 250.0    // amplituda napięcia [V]
    L              float64 = 0.025    // odległość elektrod [m] = 25 mm
    PRESSURE       float64 = 10.0     // ciśnienie gazu [Pa]
    TEMPERATURE    float64 = 350.0    // temperatura gazu [K]
    WEIGHT         float64 = 7.0e4    // waga supercząstki
    ELECTRODE_AREA float64 = 1.0e-4   // "fikcyjna" powierzchnia elektrody [m²] = 1 cm²
    N_INIT         int     = 1000     // liczba początkowych e⁻ i Ar⁺
)
```

### Dlaczego N_G = 400, N_T = 4000?

Siatka obliczeniowa dzieli przestrzeń między elektrodami na 399 równych odcinków:
```
x: 0 ——Δx——Δx——Δx——... (399 odcinków, 400 punktów) ——→ L
     p=0  p=1  p=2                                    p=399
```

N_T = 4000 kroków na cykl RF. Jeden cykl to 1/13.56MHz ≈ 73.7 ns.
Krok elektronowy: DT_E = 73.7 ns / 4000 ≈ 18.4 ps.

Dlaczego akurat tyle? To wynika z **warunków stabilności** (omówimy je w lekcji 10):
siatka musi być wystarczająco gęsta, a krok czasowy wystarczająco mały, żeby symulacja
była poprawna numerycznie.

### Dlaczego ELECTRODE_AREA jest "fikcyjna"?

Symulacja jest **1D** — rozwiązujemy tylko wzdłuż osi x. Ale gęstość ładunku ma jednostki
[1/m³], więc musimy znać objętość. Przyjmujemy fikcyjną powierzchnię 1 cm² = 1×10⁻⁴ m²
jako umowną wartość. Jest ona konsekwentnie używana wszędzie, więc wyniki są spójne.

---

## 3. Stałe pochodne (linie 50–67)

To wartości **wyliczone z poprzednich stałych**. Go pozwala na wyrażenia w `const`
dla wartości obliczanych w czasie kompilacji:

```go
const (
    PERIOD  float64 = 1.0 / FREQUENCY         // ≈ 73.7 ns — okres RF
    DT_E    float64 = PERIOD / float64(N_T)   // ≈ 18.4 ps — krok elektronowy
    N_SUB   int     = 20                      // jony co 20 kroków
    DT_I    float64 = float64(N_SUB) * DT_E  // ≈ 368 ps — krok jonowy
    DX      float64 = L / float64(N_G-1)     // ≈ 62.7 μm — odstęp siatki
    INV_DX  float64 = 1.0 / DX              // ≈ 15940 /m — odwrotność DX
    GAS_DENSITY float64 = PRESSURE / (K_BOLTZMANN * TEMPERATURE) // ≈ 2.06×10²¹ /m³
    OMEGA   float64 = TWO_PI * FREQUENCY     // ≈ 85.2 Mrad/s — pulsacja
)
```

### Tabela pochodnych wartości

| Stała | Wzór | Wartość | Co to jest? |
|:------|:-----|:--------|:-----------|
| `PERIOD` | 1/f | ≈ 73.7 ns | Czas trwania jednego cyklu RF |
| `DT_E` | PERIOD/N_T | ≈ 18.4 ps | Krok czasowy dla elektronów |
| `DT_I` | N_SUB × DT_E | ≈ 368 ps | Krok czasowy dla jonów |
| `DX` | L/(N_G-1) | ≈ 62.7 μm | Odległość między węzłami siatki |
| `GAS_DENSITY` | P/(k_B × T) | ≈ 2.06×10²¹ /m³ | Gęstość gazu Ar (prawo gazu doskonałego) |
| `OMEGA` | 2π × f | ≈ 8.52×10⁷ rad/s | Pulsacja (kątowa częstość) |

### Czynniki skalujące (var, bo zależą od var)

```go
var (
    DV       float64 = ELECTRODE_AREA * DX         // objętość komórki siatki [m³]
    FACTOR_W float64 = WEIGHT / DV                 // gęstość 1 supercząstki [1/m³]
    FACTOR_E float64 = DT_E / E_MASS * E_CHARGE    // przyspieszenie elektronu przez E
    FACTOR_I float64 = DT_I / AR_MASS * E_CHARGE   // przyspieszenie jonu przez E
    MIN_X    float64 = 0.45 * L                    // min x dla pomiarów EEPF (centrum)
    MAX_X    float64 = 0.55 * L                    // max x dla pomiarów EEPF (centrum)
)
```

> **Dlaczego `var` a nie `const`?** W Go `const` wymaga wartości możliwych do obliczenia
> w czasie kompilacji. `ELECTRODE_AREA * DX` zawiera `DX`, które samo jest `const`,
> więc mogłoby być `const`. Autor wybrał `var` — to działa tak samo.

### FACTOR_E i FACTOR_I — pełny wywód: od fizyki do linii kodu

Zamiast przyjmować `FACTOR_E` na wiarę, wyprowadźmy go krok po kroku z praw Newtona.

#### Krok 1: Siła na ładunek w polu elektrycznym

Elektron ma ładunek `q = -e` (ujemny!). W polu elektrycznym `E` działa na niego siła:

```
F = q × E = -e × E
```

Przykład: jeśli `E = 1000 V/m`, siła na elektron wynosi:
```
F = -1.6×10⁻¹⁹ C × 1000 V/m = -1.6×10⁻¹⁶ N
```
(Minus oznacza: siła skierowana przeciwnie do pola E.)

#### Krok 2: Drugie prawo Newtona — przyspieszenie

```
F = m × a   →   a = F / m = (-e × E) / m_e
```

Podstawiając wartości:
```
a = -1.6×10⁻¹⁶ N / 9.1×10⁻³¹ kg ≈ -1.76×10¹⁴ m/s²
```

(To monstrualne przyspieszenie — elektrony są ekstremalnie lekkie!)

#### Krok 3: Zmiana prędkości w kroku czasowym DT_E

W każdym kroku symulacji czas przesuwa się o `DT_E ≈ 18.4 ps`. Zmiana prędkości:

```
Δv = a × DT_E = (-e/m_e) × E × DT_E
```

Przestawiając czynniki:

```
Δv = -E × (e × DT_E / m_e) = -E × FACTOR_E
```

gdzie:

```
FACTOR_E = e × DT_E / m_e = DT_E / m_e × e
```

#### Krok 4: To dokładnie definicja z kodu

```go
FACTOR_E float64 = DT_E / E_MASS * E_CHARGE
//                  ≈ 18.4e-12 / 9.1e-31 × 1.6e-19
//                  ≈ 3.24×10⁶  [(m/s) per (V/m)]
```

I użycie w pętli ruchu (krok 3):
```go
vx_e[k] -= e_x * FACTOR_E
//  Δvx = -E_x × FACTOR_E = -E_x × (e × DT_E / m_e)
```

Co dosłownie odpowiada: `Δv = a × Δt = (-e/m_e) × E × DT_E`. ✓

#### Dlaczego minus (`-=`) a nie plus?

Elektron ma **ładunek ujemny** (`q = -e`). Siła na elektron jest **przeciwna** do pola E.
Jeśli pole E wskazuje w prawo (`e_x > 0`), elektron przyspiesza w **lewo** (`vx_e maleje`).
Stąd `vx_e[k] -= e_x * FACTOR_E`.

Gdybyś przez pomyłkę napisał `+=`, elektrony leciałyby w złym kierunku — plazma nie mogłaby istnieć.

#### A co z jonem?

Jon Ar⁺ ma ładunek **dodatni** (`q = +e`), więc:

```
Δv = +E × (e × DT_I / m_Ar) = +E × FACTOR_I
```

```go
FACTOR_I float64 = DT_I / AR_MASS * E_CHARGE   // DT_I bo jony mają inny krok czasowy!

vx_i[k] += e_x * FACTOR_I   // ← PLUS
```

Zwróć uwagę: `FACTOR_I` używa `DT_I = 20 × DT_E`, bo jony są aktualizowane co 20 kroków elektronowych.

#### Tabela porównawcza

| Wielkość | Elektron | Jon Ar⁺ |
|:---------|:---------|:--------|
| Ładunek | `-e = -1.6×10⁻¹⁹ C` | `+e = +1.6×10⁻¹⁹ C` |
| Masa | `m_e = 9.1×10⁻³¹ kg` | `m_Ar = 6.6×10⁻²⁶ kg` |
| Krok czasowy | `DT_E ≈ 18.4 ps` | `DT_I = 20 × DT_E ≈ 368 ps` |
| FACTOR | `DT_E × e / m_e ≈ 3.24×10⁶` | `DT_I × e / m_Ar ≈ 887` |
| Znak w kodzie | `vx -= E × FACTOR_E` | `vx += E × FACTOR_I` |

`FACTOR_E` jest ~3650× większy niż `FACTOR_I` — elektrony są o wiele łatwiej przyspieszane (bo są lżejsze i mają większy krok czasowy w stosunku do jonu).

---

## 4. Zmienne globalne — cząstki (linie 93–121)

```go
const MAX_N_P int = 1000000 // maksymalna liczba cząstek

type particle_vector [MAX_N_P]float64

var (
    N_e  int             // bieżąca liczba elektronów (aktywnych)
    N_i  int             // bieżąca liczba jonów (aktywnych)
    x_e  particle_vector // pozycje elektronów [m]
    vx_e particle_vector // prędkości elektronów w osi x [m/s]
    vy_e particle_vector // prędkości elektronów w osi y [m/s]
    vz_e particle_vector // prędkości elektronów w osi z [m/s]
    x_i  particle_vector // pozycje jonów [m]
    vx_i particle_vector // prędkości jonów w osi x [m/s]
    vy_i particle_vector // prędkości jonów w osi y [m/s]
    vz_i particle_vector // prędkości jonów w osi z [m/s]
)
```

### Układ SoA (Structure of Arrays)

Dane cząstek są przechowywane w układzie **SoA** (Structure of Arrays), nie AoS
(Array of Structures). Porównanie:

```
AoS (nie używamy):          SoA (używamy):
struct Particle {           x_e  = [x₀, x₁, x₂, ...]
    x, vx, vy, vz           vx_e = [vx₀, vx₁, vx₂, ...]
}                           vy_e = [vy₀, vy₁, vy₂, ...]
particles[MAX_N_P]          vz_e = [vz₀, vz₁, vz₂, ...]
```

SoA jest **wydajniejszy pamięciowo** przy pętlach — gdy iterujemy po wszystkich x_e,
procesor ładuje do cache'u ciągłe bloki pamięci.

### Tylko pierwsze `N_e` / `N_i` pozycji jest aktywnych!

```
x_e: [x₀ | x₁ | x₂ | ... | x_{N_e-1} | ??? | ??? | ... | ???]
      ←——————— N_e aktywnych ————————→  ←— nieużywane —→
```

Dostęp do k-tego elektronu: `x_e[k]`, `vx_e[k]`, `vy_e[k]`, `vz_e[k]` dla `k < N_e`.

---

## 5. Zmienne siatki (linie 112–121)

```go
type xvector [N_G]float64   // tablica N_G = 400 float64

var (
    efield          xvector // pole elektryczne E[x] [V/m]
    pot             xvector // potencjał elektryczny φ[x] [V]
    e_density       xvector // gęstość elektronów n_e[x] [1/m³]
    i_density       xvector // gęstość jonów n_i[x] [1/m³]
    cumul_e_density xvector // skumulowana gęstość e⁻ (dla uśredniania)
    cumul_i_density xvector // skumulowana gęstość Ar⁺ (dla uśredniania)
)
```

Siatka ma `N_G = 400` punktów. Każdy punkt `p` odpowiada pozycji `p × DX`:
- `p = 0` → `x = 0` (elektroda zasilana)
- `p = 399` → `x = L = 0.025 m` (elektroda uziemiona)

Zmienne `cumul_*` to **suma narastająca** — akumulują gęstość przez wiele kroków,
żeby na końcu policzyć uśrednione wartości.

---

## 6. Zmienne diagnostyczne

```go
// Liczniki pochłoniętych cząstek
var (
    N_e_abs_pow uint64  // elektrony pochłonięte przez lewą elektrodę
    N_e_abs_gnd uint64  // elektrony pochłonięte przez prawą elektrodę
    N_i_abs_pow uint64  // jony pochłonięte przez lewą elektrodę
    N_i_abs_gnd uint64  // jony pochłonięte przez prawą elektrodę
)

// Rozkład energetyczny elektronów (EEPF) — centrum plazmy
const N_EEPF = 2000    // 2000 przedziałów energetycznych
const DE_EEPF = 0.05   // szerokość przedziału: 0.05 eV → zakres 0–100 eV

// Rozkład energetyczny jonów na elektrodach (IFED)
const N_IFED = 200     // 200 przedziałów
const DE_IFED = 1.0    // szerokość: 1 eV → zakres 0–200 eV
```

**EEPF** (Electron Energy Probability Function) = histogram energii elektronów.
Bin `i` odpowiada energiom od `i × 0.05 eV` do `(i+1) × 0.05 eV`.

**IFED** (Ion Flux-Energy Distribution) = rozkład energii jonów uderzających w elektrody.
To kluczowa diagnostyka — mówi jak mocno jony bombardują powierzchnię elektrody.

---

## 7. Przekroje czynne — tablica przeglądowa

```go
const CS_RANGES int     = 1000000  // 1 milion bin-ów
const DE_CS     float64 = 0.001    // szerokość: 0.001 eV → zakres 0–1000 eV
const N_CS      int     = 5        // 5 typów procesów zderzeniowych

var sigma [N_CS]cross_section  // sigma[typ][energia_index]
```

Dla każdej energii cząstki (w eV) przechowujemy wartość przekroju czynnego
(prawdopodobieństwa zderzenia) dla każdego z 5 procesów:

| Indeks | Nazwa | Opis |
|:-------|:------|:-----|
| `E_ELA = 0` | Elastic e⁻ | Sprężyste rozpraszanie elektronu |
| `E_EXC = 1` | Excitation | Wzbudzenie atomu Ar (próg: 11.5 eV) |
| `E_ION = 2` | Ionization | Jonizacja Ar (próg: 15.8 eV) |
| `I_ISO = 3` | Ion isotropic | Sprężyste rozpraszanie jonu — izotropowe |
| `I_BACK = 4` | Ion backward | Sprężyste rozpraszanie jonu — wsteczne |

To jest **tablica przeglądowa (lookup table)**: zamiast liczyć przekrój czynny w każdym
kroku, liczymy go raz na początku dla wszystkich energii i potem tylko indeksujemy:

```go
energy_index = int(energy_eV / DE_CS)   // znajdź indeks z energii [eV]
sigma_val = sigma[E_ELA][energy_index]  // odczytaj przekrój czynny
```

---

## Podsumowanie — tabela najważniejszych wartości

| Stała/Zmienna | Wartość | Co to jest |
|:--------------|:--------|:----------|
| `E_CHARGE` | 1.6×10⁻¹⁹ C | Ładunek elementarny |
| `E_MASS` | 9.1×10⁻³¹ kg | Masa elektronu |
| `AR_MASS` | 6.6×10⁻²⁶ kg | Masa atomu Ar (~73 000× masa e⁻) |
| `L` | 0.025 m | Odległość elektrod (25 mm) |
| `N_G` | 400 | Punkty siatki |
| `DX` | 62.7 μm | Odstęp między punktami siatki |
| `N_T` | 4000 | Kroków na cykl RF |
| `DT_E` | 18.4 ps | Krok czasowy elektronów |
| `DT_I` | 368 ps | Krok czasowy jonów |
| `WEIGHT` | 7×10⁴ | 1 supercząstka = 70 000 prawdziwych |
| `FACTOR_E` | ≈ 3.24×10⁶ | (m/s) na każdy V/m pola E (dla e⁻) |
| `FACTOR_I` | ≈ 8.87×10² | (m/s) na każdy V/m pola E (dla Ar⁺) |

---

**Następna lekcja:** [Lekcja 3 — Generator liczb losowych i przekroje czynne](lekcja_03.md)
