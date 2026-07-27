# Lekcja 3: Generator liczb losowych i przekroje czynne

> **Poprzednia lekcja:** [Lekcja 2 — Stałe i zmienne globalne](lekcja_02.md)
> **Następna lekcja:** [Lekcja 4 — Inicjalizacja](lekcja_04.md)

---

## Cel lekcji

Po tej lekcji będziesz wiedzieć:
- Dlaczego symulacja potrzebuje dobrego generatora liczb losowych
- Co to jest Mersenne Twister i jak jest użyty w kodzie
- Co to są przekroje czynne i jak są obliczane
- Jak działają tablice przeglądowe (lookup tables) dla przekrojów czynnych

---

## 1. Dlaczego potrzebujemy liczb losowych?

Symulacja MCC (Monte Carlo Collisions) dosłownie opiera się na losowości.
Używamy liczb losowych do:

1. **Inicjalizacji** — losowe pozycje startowe cząstek
2. **Zderzeń** — czy zderzenie wystąpiło? (losujemy liczbę i porównujemy z p_coll)
3. **Kątów rozpraszania** — w jakim kierunku cząstka poleci po zderzeniu?
4. **Prędkości atomów gazu** — atomy Ar mają rozkład Maxwella-Boltzmanna

Kluczowe jest, żeby generator był **wysokiej jakości** — słabe generatory mogą
wprowadzić artefakty do wyników fizycznych (korelacje, periodyczność).

---

## 2. Mersenne Twister — generator losowy

```go
// main.go, linia 207–240

func newMTRand() *rand.Rand {
    seed := uint64(time.Now().UnixNano()) + atomic.AddUint64(&seedCounter, 1)
    src := mt19937.New()          // ← biblioteka Mersenne Twister
    src.Seed(int64(seed))
    return rand.New(src)
}

var rngPool = sync.Pool{New: newRNG}

var RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)  // ≈ 289 m/s

func R01() float64 {
    r := rngPool.Get().(*rand.Rand)
    v := r.Float64()      // ← losowa liczba z [0, 1)
    rngPool.Put(r)
    return v
}

func RMB() float64 {
    r := rngPool.Get().(*rand.Rand)
    v := r.NormFloat64() * RMB_sigma  // ← rozkład normalny × sigma
    rngPool.Put(r)
    return v
}
```

### Co to jest Mersenne Twister?

Mersenne Twister (MT19937) to algorytm generowania pseudolosowych liczb o bardzo
długim okresie (2¹⁹⁹³⁷ − 1). Jest standardem w symulacjach fizycznych i Monte Carlo.

W Go standardowy `math/rand` też jest niezły, ale MT19937 jest histrycznie używany
w oryginalnym kodzie C++ (`std::mt19937`), więc używamy biblioteki zewnętrznej
`github.com/seehuhn/mt19937` dla kompatybilności.

### Dwie funkcje losowe

| Funkcja | Rozkład | Użycie |
|:--------|:--------|:-------|
| `R01()` | Jednostajny [0, 1) | Większość losowań (zderzenia, kąty) |
| `RMB()` | Normalny N(0, σ) | Prędkości termiczne atomów Ar |

**`RMB_sigma`** to odchylenie standardowe rozkładu Maxwella-Boltzmanna dla atomów Ar:
```
σ = √(k_B × T / m_Ar) = √(1.38×10⁻²³ × 350 / 6.63×10⁻²⁶) ≈ 289 m/s
```
Atom Ar ma "typową" prędkość ~289 m/s (dla temperatury 350 K).

### sync.Pool — pula obiektów

```go
var rngPool = sync.Pool{New: newRNG}
```

`sync.Pool` to pula wielokrotnie używanych obiektów — zamiast tworzyć nowy generator
przy każdym wywołaniu `R01()`, kod "wypożycza" istniejący generator z puli i po użyciu
go oddaje. To optymalizacja dla wydajności, szczególnie przy równoległości (goroutines).

---

## 3. Przekroje czynne — czym są?

**Przekrój czynny** σ [m²] to miara prawdopodobieństwa zderzenia. Im większy przekrój,
tym częściej dochodzi do zderzenia.

Wyobraź sobie, że cząstka leci przez gaz. Każdy atom gazu ma "efektywną powierzchnię"
σ — jeśli cząstka w nią trafi, dochodzi do zderzenia. Dla elektronu w Argonie:
- σ zależy od **energii** elektronu (im szybszy, tym inny przekrój)
- σ ma różne wartości dla różnych **typów zderzeń** (elastyczne, wzbudzenie, jonizacja)

---

## 4. Obliczanie przekrojów czynnych dla elektronów

```go
// main.go, linia 246–274

func setElectronCrossSectionsAr() {
    for i := 0; i < CS_RANGES; i++ {   // CS_RANGES = 1 000 000 bin-ów
        en = DE_CS * float64(i)        // energia w eV (0, 0.001, 0.002, ..., 999.999)

        // Elastyczne (Phelps & Petrovic 1999) — skomplikowany wzór empiryczny
        qmel = math.Abs(6.0/math.Pow(1.0+(en/0.1)+math.Pow(en/0.6, 2.0), 3.3) - ...)

        // Wzbudzenie — tylko powyżej progu 11.5 eV
        if en > E_EXC_TH {
            qexc = 0.034 * math.Pow(en-11.5, 1.1) * ...
        } else {
            qexc = 0
        }

        // Jonizacja — tylko powyżej progu 15.8 eV
        if en > E_ION_TH {
            qion = 970.0 * (en-15.8) / math.Pow(70.0+en, 2.0) + ...
        } else {
            qion = 0
        }

        sigma[E_ELA][i] = qmel * 1.0e-20  // w [m²]
        sigma[E_EXC][i] = qexc * 1.0e-20
        sigma[E_ION][i] = qion * 1.0e-20
    }
}
```

### Co to znaczy "empiryczny wzór"?

Przekrojów czynnych nie da się łatwo obliczyć z pierwszych zasad kwantowej mechaniki.
Zamiast tego fizycy **mierzą je eksperymentalnie** dla każdej pary (cząstka, gaz)
i dopasowują wzory matematyczne. Te wzory to własnie formuły Phelpsa i Petrovica (1999).

### Trzy procesy dla elektronu w Ar

```
Elektron + Ar  →  co się może stać?

1. Elastyczne (E_ELA):   e⁻ + Ar → e⁻ + Ar         (odbicie, zmiana kierunku)
2. Wzbudzenie (E_EXC):   e⁻ + Ar → e⁻ + Ar*         (Ar przechodzi na wyższy poziom energii)
3. Jonizacja  (E_ION):   e⁻ + Ar → 2e⁻ + Ar⁺        (Ar traci elektron, tworzymy nową parę!)
```

Jonizacja jest najważniejsza — to ona **tworzy nowe elektrony i jony**, podtrzymując plazmę.

---

## 5. Przekroje czynne dla jonów

```go
// main.go, linia 280–297

func setIonCrossSectionsAr() {
    for i := 0; i < CS_RANGES; i++ {
        e_com = DE_CS * float64(i)        // energia w układzie środka masy [eV]
        e_lab = 2.0 * e_com               // energia w układzie laboratorium [eV]

        qmom = 1.15e-18 * math.Pow(e_lab, -0.1) * ...  // całkowity przekrój pędu
        qiso = 2e-19 * math.Pow(e_lab, -0.5) / (1.0+e_lab) + ...  // część izotropowa
        qback = (qmom - qiso) / 2.0       // część wsteczna

        sigma[I_ISO][i]  = qiso
        sigma[I_BACK][i] = qback
    }
}
```

Dwa procesy dla jonu Ar⁺ w gazie Ar:

```
Jon + atom Ar  →  co się może stać?

1. Izotropowe (I_ISO):  Ar⁺ + Ar → Ar⁺ + Ar   (odbicie w losowym kierunku)
2. Wsteczne   (I_BACK): Ar⁺ + Ar → Ar + Ar⁺   (wymiana ładunku — jon i atom zamieniają się!)
```

**Wymiana ładunku** (charge exchange): jonizacja nie następuje, ale jon i atom zamieniają
się rolami — stary jon staje się szybkim atomem, a stary atom wolnym jonem.
Efektywnie jon traci swój pęd.

### Dlaczego `e_lab = 2 * e_com`?

W zderzeniu dwóch **identycznych** cząstek (Ar⁺ na Ar):
```
e_com = energia w układzie środka masy
e_lab = energia w układzie laboratorium = 2 × e_com
```
Tablicę indeksujemy energią COM (`e_com`), ale wzory Phelpsa są dane dla energii
laboratoryjnej (`e_lab`), stąd przeliczenie.

---

## 6. Całkowity przekrój czynny

```go
// main.go, linia 303–308

func calcTotalCrossSections() {
    for i := 0; i < CS_RANGES; i++ {
        sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY
        sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY
    }
}
```

**Makroskopowy przekrój czynny** = σ × n_gas [1/m]:

```
Σ(ε) = σ(ε) × n_gas
```

Gdzie `n_gas = GAS_DENSITY ≈ 2.06×10²¹ /m³`. Mnożymy przez gęstość gazu, bo im gęstszy
gaz, tym więcej atomów "w zasięgu" i więcej zderzeń.

---

## 7. Jak używana jest tablica przeglądowa w praktyce?

W kroku 7 (zderzenia elektronów):

```go
// 1. Oblicz energię kinetyczną elektronu [eV]
v_sqr = vx_e[k]*vx_e[k] + vy_e[k]*vy_e[k] + vz_e[k]*vz_e[k]
energy = 0.5 * E_MASS * v_sqr / EV_TO_J     // energia w eV

// 2. Znajdź indeks w tablicy przeglądowej
energy_index = int(energy/DE_CS + 0.5)      // zaokrąglenie do najbliższego binu
energy_index = min(energy_index, CS_RANGES-1)  // nie wyjdź poza tablicę

// 3. Odczytaj totalny przekrój czynny dla tej energii
nu = sigma_tot_e[energy_index] * velocity    // ν = Σ × |v| [1/s]

// 4. Oblicz prawdopodobieństwo zderzenia w ciągu kroku DT_E
p_coll = 1 - math.Exp(-nu * DT_E)

// 5. Zdecyduj losowo
if R01() < p_coll {
    collisionElectron(...)  // zderzenie!
}
```

### Skąd bierze się wzór na p_coll?

```
p_coll = 1 - exp(-ν × Δt)
```

To jest **rozkład wykładniczy** (exponential) — klasyczny model dla procesów Poissona.
Jeśli elektron odbywa ν zderzeń na sekundę, to prawdopodobieństwo że zderzenie
**nie wystąpi** w czasie Δt to exp(-ν·Δt). Stąd prawdopodobieństwo że **wystąpi** to
1 - exp(-ν·Δt).

Dla małych wartości ν·Δt (co spełniają nasze warunki stabilności):
```
p_coll ≈ ν × Δt  (przybliżenie liniowe)
```

---

## Podsumowanie

| Pojęcie | Co to jest |
|:--------|:----------|
| `R01()` | Losowa liczba z [0,1) — rozkład jednostajny |
| `RMB()` | Losowa prędkość atomu Ar (rozkład Maxwella-Boltzmanna) |
| `sigma[typ][i]` | Przekrój czynny dla procesu `typ` przy energii `i × DE_CS` eV |
| `sigma_tot_e[i]` | Suma wszystkich przekrojów e⁻ × gęstość gazu |
| `energy_index` | Jak zamienić energię [eV] na indeks tablicy |
| `p_coll` | Prawdopodobieństwo zderzenia w jednym kroku DT |

### Co możesz zmienić?

Jeśli chcesz symulować inny gaz (np. Krypton lub Hel):
1. Zmień `AR_MASS` na masę nowego gazu
2. Zastąp wzory w `setElectronCrossSectionsAr()` wzorami dla nowego gazu
3. Zastąp wzory w `setIonCrossSectionsAr()` analogicznie
4. Zmień progi `E_EXC_TH` i `E_ION_TH` na progi nowego gazu

---

**Następna lekcja:** [Lekcja 4 — Inicjalizacja](lekcja_04.md)
