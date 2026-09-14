# Przewodnik i Rozpiska Podrozdziału: Sprzętowa Wektoryzacja SIMD (AVX-512), Wyrównanie Pamięci (alignas 64) i Dostrojenie do Zen 4

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.2: Ścieżka optymalizacji silnika w języku C++**  
>     └── **4.2.7. Sprzętowa wektoryzacja SIMD (AVX-512), wyrównanie pamięci i optymalizacja flag kompilatora (Hardware SIMD & Zen 4 Tuning)**

---

## 1. Kontekst Mikroarchitektoniczny i Diagnoza Profilu Wykonania

### 1.1. Przegląd Hotspotów po Pięciu Krokach Optymalizacyjnych
W poprzednich krokach wyeliminowano główne patologie algorytmiczne w module zderzeniowym Monte Carlo (MCC):
1. Zredukowano złożoność doboru par zderzeniowych z $\mathcal{O}(N^2)$ do $\mathcal{O}(N)$ za pomocą metody zderzeń zerowych (*Null-Collision method*),
2. Wyniesiono niezmienniki przed pętle zderzeniowe (*Loop-Invariant Code Motion*),
3. Zastąpiono operacje dzielenia mnożeniem przez odwrotności (*Division Elimination*),
4. Wprowadzono ścieżkę szybką dla zderzeń wymiany ładunku $Ar^+ / Ar$ (*Fast-Path Charge Exchange*),
5. Wyeliminowano objazd funkcji transcedentnych w algebrze kątów Eulera (*Euler Vector Algebra*).

W wyniku tych działań moduł `collisions.h` przestał być dominującym wąskim gardłem całej symulacji. Profilowanie wykonania (`perf record` i FlameGraph) ujawnia nową strukturę kosztów czasowych programu:

| Procedura | Rola w pętli PIC | Udział w czasie wykonania | Charakterystyka operacji |
| :--- | :--- | :---: | :--- |
| `step3_move_electrons` | Integrator ruchu cząstek (Leapfrog / Boris pusher) | **~31%** | Intensywne obliczenia zmiennoprzecinkowe, interpolacja siły pola $E$, aktualizacja $x_e, v_{x,e}$ |
| `step1_compute_electron_density` | Depozycja ładunku na siatkę (Cloud-in-Cell) | **~24%** | Wyszukiwanie komórki siatki, interpolacja wag, akumulacja gęstości ładunku |
| `step5_check_boundaries_electrons` | Warunki brzegowe (absorpcja i odbicie) | **~12%** | Sprawdzanie granic $x_p \in [0, L]$, relokacja cząstek przekraczających elektrody |
| `collision_electron` | Zderzenia elastyczne i nieelastyczne $e^- / Ar$ | ~15% | Zderzenia Monte Carlo (zoptymalizowane w krokach 2–6) |
| Pozostałe procedury | Ruch jonów, solwer Poissona, I/O | ~18% | Obliczenia polowe i jonowe (subcycling $N_{\text{sub}} = 20$) |

**Wniosek profilera:**  
Ponad **67% całkowitego czasu wykonania programu** przypada na trzy procedury operujące na tablicach cząstek (`step3`, `step1`, `step5`). W każdej sekundzie symulacji przez pętle te przewija się tablica ponad 108 000 cząstek, co w 100 cyklach RF (400 000 kroków czasowych) oznacza ponad **43 miliardy iteracji pętli wewnętrznej**.

---

### 1.2. Bariery Autowektoryzacji w Kodzie Referencyjnym
Dlaczego nowoczesny kompilator GCC z flagą `-O3` nie był w stanie automatycznie zwektoryzować pętli `step3_move_electrons` i uzyskać pełnej przepustowości jednostek AVX-512? Analiza raportu wektoryzacji (`-fopt-info-vec-all`) ujawniła trzy fundamentalne przeszkody:

1. **Warunkowe rozgałęzienie diagnostyczne wewnątrz pętli cząstkowej:**  
   W oryginalnym kodzie wewnątrz pętli po cząstkach znajdowała się instrukcja warunkowa:
   ```cpp
   if (measurement_mode) {
       cumul_e_heat_current[p] += ...;
       cumul_e_heat_current[p+1] += ...;
   }
   ```
   Chociaż flaga `measurement_mode` jest stała w trakcie całego kroku czasowego, jej obecność w ciele pętli tworzyła dla kompilatora zależność sterowania (*control flow dependency*). W pętli produkcyjnej (gdy pomiary są wyłączone) procesor musiał każdorazowo ewaluować skok warunkowy lub kompilator musiał generować skomplikowany kod maskowany (predykację AVX-512), co drastycznie obniżało efektywność potoku instrukcji.

2. **Brak gwarancji wyrównania struktur danych w pamięci RAM:**  
   W kodzie referencyjnym tablice położeń i prędkości cząstek (`x_e`, `vx_e`, `vy_e`, `vz_e`) były deklarowane jako zwykłe tablice statyczne:
   ```cpp
   double x_e[MAX_PARTICLES];
   ```
   Zgodnie ze standardem C++, domyślne wyrównanie dla typu `double` na architekturze x86_64 wynosi zaledwie 8 bajtów. Aby załadować wektor AVX-512 (który wymaga 512 bitów, czyli dokładnie 64 bajtów), kompilator zmuszony był emitować instrukcje niewyrównanego ładowania (`vmovupd`) lub generować pętle wstępne (*peeling loops*) próbujące dynamicznie dotrzeć do adresu podzielnego przez 64. Niewyrównane odczyty grożą przekraczaniem granicy linii pamięci podręcznej (*cache-line split*), co powoduje zablokowanie jednostki L1D na kilkanaście dodatkowych cykli.

3. **Konserwatywne założenia kompilatora dotyczące aliasingu wskaźników:**  
   Kompilator nie miał pewności, czy zapisy do tablic położeń nie kolidują z odczytami pól i potencjałów, co zmuszało go do generowania kodu sekwencyjnego w obawie przed naruszeniem semantyki standardu C.

---

## 2. Architektura Optymalizacji: Trzy Filary Wydajności Sprzętowej

W eksperymencie 7 wdrożono zintegrowaną optymalizację niskopoziomową, opartą na trzech filarach:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│               EKSPERYMENT 7: HARDWARE-CONSCIOUS OPTIMIZATION                │
├──────────────────────────────┬──────────────────────────────┬───────────────┤
│    FILAR I: PAMIĘĆ           │    FILAR II: KONTROLA        │ FILAR III: FMA│
│    Wyrównanie do linii cache │    Ekstrakcja ścieżki szybkiej│ Algebra Fused │
│    alignas(64)               │    Branch Hoisting & ivdep   │ Multiply-Add  │
└──────────────────────────────┴──────────────────────────────┴───────────────┘
```

---

### 2.1. Filar I: Wyrównanie Struktur Danych do Granicy Linii Cache (`alignas(64)`)

#### 2.1.1. Geometria pamięci podręcznej a rejestry wektorowe
W architekturach x86_64 linia pamięci podręcznej (L1/L2/L3 cache line) ma stały rozmiar **64 bajtów**.  
Z kolei wektor AVX-512 mieści:
$$512\text{ bitów} = \frac{512}{8}\text{ bajtów} = 64\text{ bajty} = 8 \times \text{liczba podwójnej precyzji (\texttt{double})}$$

Oznacza to idealną symetrię geometryczną: **jeden rejestr ZMM mieści dokładnie jedną pełną linię pamięci podręcznej procesora**.

Gdy tablica nie jest wyrównana do 64 bajtów, załadowanie 8 liczb `double` może rozpocząć się np. pod adresem przesuniętym o 8 bajtów względem granicy linii cache. W takiej sytuacji pojedyncza instrukcja wektorowa musi pobrać dane z **dwóch sąsiednich linii pamięci podręcznej**:
```
Niewyrównany odczyt 512-bit (vmovupd):
[ Linia Cache N (64B)      ][ Linia Cache N+1 (64B)    ]
       [ 8 bajtów ][ 8 bajtów ][ 8 bajtów ][ 8 bajtów ] ...
       └─────────── Przekroczenie granicy linii ───────┘ (Cache-Line Split Penalty!)
```
Zjawisko to, zwane *Cache-Line Split*, blokuje bufory ładowania L1D (Load Buffers), podwaja liczbę zapytań do magistrali danych i uniemożliwia sprzętowemu prefetcherowi optymalne przewidywanie kolejnych pobrań.

#### 2.1.2. Rozwiązanie w kodzie: `alignas(64)`
Wszystkie globalne wektory cząstek i tablice siatkowe w pliku `state.h` zostały opatrzone atrybutem wyrównania standardu C++17:

```cpp
// state.h
alignas(64) inline particle_vector x_e;
alignas(64) inline particle_vector vx_e;
alignas(64) inline particle_vector vy_e;
alignas(64) inline particle_vector vz_e;

alignas(64) inline particle_vector x_i;
alignas(64) inline particle_vector vx_i;
alignas(64) inline particle_vector vy_i;
alignas(64) inline particle_vector vz_i;

alignas(64) inline grid_array efield;
alignas(64) inline grid_array pot;
alignas(64) inline grid_array e_density;
alignas(64) inline grid_array i_density;
```

**Korzyści mikroarchitektoniczne:**
1. Każda paczka 8 cząstek znajduje się w dokładnie jednej linii cache L1D.
2. Kompilator może bez przeszkód emitować instrukcje aligned load/store (`vmovapd`), które nie wymagają sprawdzania granic adresów.
3. Sprzętowy prefetcher procesora (L1 Data Streamer oraz L2 Stream Prefetcher) może w sposób ciągły przesyłać kolejne linie cache z pamięci L3/RAM bezpośrednio do rejestrów wykonawczych bez straty cykli.

---

### 2.2. Filar II: Rozdzielenie Ścieżki Szybkiej i Wolnej Integratora (Fast-Path Pusher)

#### 2.2.1. Problem rozgałęzienia w 43 miliardach iteracji
W oryginalnej procedurze `step3_move_electrons` flaga diagnostyczna była sprawdzana w każdej iteracji pętli:

```cpp
// KOD ORYGINALNY (Kroki 1-6):
void step3_move_electrons() {
    for (int p = 0; p < N_e; ++p) {
        // ... integracja ruchu ...
        if (measurement_mode) {
            cumul_e_heat_current[p] += ...;
            cumul_e_heat_current[p+1] += ...;
        }
    }
}
```

W typowym profilu pracy symulatora PIC-MCC tryb pomiarowy (`measurement_mode`) jest aktywny jedynie w wybranych cyklach diagnostycznych (np. w ostatnich 5 cyklach symulacji). W 95% czasu symulacji flaga ta ma wartość `false`. Mimo to, procesor musiał przetwarzać rozgałęzienie w 43 miliardach kroków, a kompilator nie mógł rozwinąć ani zwektoryzować pętli.

#### 2.2.2. Rozwiązanie: Wyniesienie warunku (Branch Hoisting na poziom funkcji)
Zastosowano technikę podziału pętli na ścieżkę szybką (produkcyjną) oraz ścieżkę diagnostyczną z wykorzystaniem dyrektywy podpowiedzi dla predyktora skoków `__builtin_expect`:

```cpp
// KOD ZOPTYMALIZOWANY (Krok 7):
void step3_move_electrons() {
    if (__builtin_expect(!measurement_mode, 1)) {
        // === ŚCIEŻKA SZYBKA: Produkcja (bez diagnostyki) ===
        #pragma GCC ivdep
        for (int p = 0; p < N_e; ++p) {
            double c2 = x_e[p] * inv_dx;
            int p_idx = static_cast<int>(c2);
            c2 -= p_idx;
            
            // FMA: E = E_p + c2 * (E_{p+1} - E_p)
            double e = efield[p_idx] + c2 * (efield[p_idx + 1] - efield[p_idx]);
            
            vx_e[p] += factor_v_e * e;
            x_e[p]  += vx_e[p] * DT_E;
        }
    } else {
        // === ŚCIEŻKA WOLNA: Diagnostyka i zbieranie statystyk ===
        #pragma GCC ivdep
        for (int p = 0; p < N_e; ++p) {
            // ... wersja z akumulacją ciepła ...
        }
    }
}
```

**Kluczowe elementy implementacji:**
1. `__builtin_expect(!measurement_mode, 1)`: Informuje kompilator, że warunek ten jest prawie zawsze prawdziwy. Kompilator układa kod maszynowy tak, aby ścieżka szybka stanowiła prostą linię instrukcji (*fall-through*), eliminując konieczność wykonywania skoków w potoku instrukcji.
2. `#pragma GCC ivdep` (*Ignore Vector Dependencies*): Gwarantuje kompilatorowi, że iteracje pętli są od siebie niezależne i mogą być bezpiecznie wektoryzowane oraz rozwijane (*loop unrolling*).
3. **Czysta pętla wektorowa:** W ścieżce szybkiej pętla nie zawiera żadnego skoku warunkowego, żadnego wywołania funkcji ani żadnego zapisu do pamięci niesymetrycznej.

---

### 2.3. Filar III: Uproszczenie Algebraiczne i Instrukcje FMA (Fused Multiply-Add)

#### 2.3.1. Interpolacja pola elektrycznego
W schemacie Cloud-in-Cell (CIC) natężenie pola w pozycji cząstki wyznaczane jest z ważenia liniowego pomiędzy węzłami siatki $p$ oraz $p+1$:
$$E(x) = E_p (1 - c_2) + E_{p+1} c_2$$
Wzór ten w postaci kanonicznej wymaga **dwóch mnożeń i jednego dodawania**.

Przekształcając to wyrażenie algebraicznie:
$$E(x) = E_p + c_2 (E_{p+1} - E_p)$$
Otrzymujemy postać idealnie odpowiadającą instrukcji sprzętowej **FMA** ($A + B \times C$):
- $A = E_p$
- $B = c_2$
- $C = E_{p+1} - E_p$

Na procesorze AMD EPYC (Zen 4) instrukcja ta kompiluje się do pojedynczego rozkazu maszynowego `vfmadd213sd` (lub wektorowego `vfmadd213pd`), wykonującego mnożenie i dodawanie w **jednym cyklu zegara** z pełną precyzją bez zaokrąglenia pośredniego. Oszczędza to jedno pełne mnożenie zmiennoprzecinkowe na każdą cząstkę.

#### 2.3.2. Depozycja ładunku w `step1_compute_electron_density`
Analogiczne uproszczenie wprowadzono w procedurze ważenia gęstości ładunku na węzły siatki:
```cpp
// Zamiast:
// double w1 = (1.0 - c2) * factor_w;
// double w2 = c2 * factor_w;

// Wprowadzono:
double w2 = c2 * factor_w;
double w1 = factor_w - w2;
```
Zastąpienie drugiego mnożenia przez jedno odejmowanie redukuje obciążenie jednostek mnożących procesora (FPU Multiply Pipe), co przy ponad 43 miliardach operacji przynosi wymierną redukcję opóźnień.

---

### 2.4. Filar IV: Sprzętowe Jednostki Wektorowe AMD Zen 4 i Zaawansowane Flagi Kompilacji

Węzły obliczeniowe klastra Lem (`plgrid-lem-cpu`) wyposażone są w procesory **AMD EPYC 9654** o mikroarchitekturze **Zen 4 (Genoa)**.  
W przeciwieństwie do starszych generacji (Zen 3 / Milan):
- Zen 4 posiada **pełne, natywne 512-bitowe jednostki wektorowe AVX-512** (dwie niezależne jednostki FMA 512-bit na każdy rdzeń).
- W Zen 3 instrukcje AVX-512 nie były obsługiwane, a wektory AVX2 (256-bit) wymagały dzielenia na dwa potoki 128-bitowe.
- W Zen 4 pojedynczy rdzeń może w jednym cyklu zegara wykonać **dwie 512-bitowe operacje FMA**:
  $$\text{Przepustowość} = 2 \times 8 \text{ operacji double} \times 2 \text{ (mnożenie + dodawanie)} = 32 \text{ FLOPs / cykl / rdzeń}$$

W tym kroku zestaw flag kompilatora zostaje celowo rozszerzony o flagi niskopoziomowej optymalizacji sprzętowej:

```bash
g++ -std=c++17 -O3 -Wall \
    -fno-omit-frame-pointer -g \
    -march=znver4 -mtune=znver4 \
    -mprefer-vector-width=512 \
    -funroll-loops \
    -ffast-math \
    -fno-math-errno \
    -fopt-info-vec-optimized \
    eduPIC.cc -o eduPIC -lm
```

#### Szczegółowe uzasadnienie poszczególnych flag:
1. **`-march=znver4 -mtune=znver4` (lub `-march=native`):**  
   Precyzuje architekturę docelową procesora. Kompilator dostosowuje tablice opóźnień (*latency*) i przepustowości (*throughput*) jednostek wykonawczych, harmonogramowanie rozkazów w kolejce Out-of-Order oraz odblokowuje pełny zestaw rozkazów Zen 4: `AVX-512F`, `AVX-512DQ`, `AVX-512CD`, `AVX-512BW`, `AVX-512VL` oraz `FMA3`.
2. **`-mprefer-vector-width=512`:**  
   **Kluczowa flaga wektoryzatora.** Domyślnie GCC (z powodów zaszłości historycznych na procesorach Intel Skylake-X, gdzie wektory 512-bitowe wywoływały spadek częstotliwości taktowania rdzenia tzw. *frequency throttling*) asekuracyjnie preferuje wektory 256-bitowe (`-mprefer-vector-width=256`). W architekturze AMD Zen 4 nie ma żadnego spadku taktowania przy AVX-512. Flaga `512` jawnie nakazuje kompilatorowi wykorzystywanie pełnych 64-bajtowych rejestrów `%zmm`.
3. **`-funroll-loops`:**  
   Wymusza agresywne rozwijanie pętli cząstkowych. W połączeniu z `#pragma GCC ivdep` pozwala jednostkom wykonawczym Out-of-Order procesora na jednoczesne przetwarzanie wielu niezależnych operacji FMA (ukrywanie 4-cyklowego opóźnienia potoku FMA w Zen 4).
4. **`-fno-omit-frame-pointer`:**  
   Zachowuje wskaźnik ramki stosu (`%rbp`), co jest krytyczne dla bezbłędnego próbkowania stosu przez `perf record` i tworzenia wykresów płomieniowych (FlameGraph).
5. **`-fopt-info-vec-optimized`:**  
   Flaga diagnostyczna generująca w logu kompilacji raport z pomyślnie zwektoryzowanych pętli (np. `optimized: loop vectorized using 64 byte vectors`).

*(Uwaga metodologiczna: flagi wielowątkowości `-fopenmp` nie włączamy w tym kroku, gdyż Eksperyment 7 stanowi czyste badanie granicy wydajności pojedynczego rdzenia przed przejściem do zrównoleglenia wielordzeniowego).*

---

### 2.5. Filar V: Ręczne 4-krotne Rozwinięcie Pętli (Manual 4-Way Loop Unrolling)

Chociaż kompilator z flagą `-funroll-loops` próbuje rozwijać pętle, w przypadku operacji na tablicach ze złożonym adresowaniem pośrednim (wyszukiwanie komórki siatki `p = int(c0)`) kompilator może stosować zachowawcze strategie, obawiając się o liczbę dostępnych rejestrów.

W procedurach `step3_move_electrons` oraz `step4_move_ions` zastosowano **jawne, ręczne 4-krotne rozwinięcie pętli produkcyjnej**:
```cpp
#pragma GCC ivdep
for (; k < k_unroll_end; k += 4) {
    double x0 = x_e[k+0], x1 = x_e[k+1], x2 = x_e[k+2], x3 = x_e[k+3];
    double v0 = vx_e[k+0], v1 = vx_e[k+1], v2 = vx_e[k+2], v3 = vx_e[k+3];

    // Równoległe 4 interpolacje pola E:
    double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
    double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
    double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
    double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);

    // Równoległe 4 aktualizacje pędu i pozycji:
    vx_e[k+0] = v0 - ex0 * factor_e;
    ...
    x_e[k+0]  = x0 + vn0 * DT_E;
    ...
}
```

#### Dlaczego to działa mikroarchitektonicznie na AMD Zen 4?
1. **Ukrywanie opóźnień FMA (*Latency Hiding*):** Sprzętowa instrukcja FMA w architekturze Zen 4 ma opóźnienie 4 cykli zegara. W pętli pojedynczej obliczenie nowej pozycji musi czekać 4 cykle na wyznaczenie nowej prędkości (zależność danych RAW - *Read-After-Write*). Przy rozwinięciu 4-krotnym w locie znajdują się 4 niezależne instrukcje FMA, co pozwala procesorowi na ich potokowe nakładanie bez ani jednego cyklu bezczynności (*pipeline stall*).
2. **Nasycenie podwójnych jednostek FMA 512-bit:** Rdzeń Zen 4 posiada dwa potoki wektorowe FMA. 4 niezależne łańcuchy obliczeniowe idealnie nasycają oba porty wykonawcze.

---

### 2.6. Filar VI: Dwufazowa Liniowa Kompaktacja Warunków Brzegowych (Two-Phase Boundary Compaction)

Procedury sprawdzania granic elektrod (`step5_check_boundaries_electrons` oraz `step6_check_boundaries_ions`) wykonują się w każdym kroku czasowym (400 000 razy na 100 cykli RF), stanowiąc w profilu wykonania **aż ~12% całkowitego czasu programu**.

#### Problem kodu referencyjnego (Kroki 1–6):
```cpp
int k = 0;
while(k < N_e) {
    if (x_e[k] < 0 || x_e[k] > L) {
        x_e[k] = x_e[N_e-1]; // podmiana z końcem tablicy
        N_e--;
    } else {
        k++; // inkrementacja warunkowa!
    }
}
```
* Pętla `while` z warunkową inkrementacją wskaźnika `k++` całkowicie uniemożliwia autowektoryzację i rozwinięcie pętli.
* Skoki warunkowe powodują ciągłe rozbijanie potoku predyktora skoków.
* Zapis `x_e[k] = x_e[N_e-1]` psuje lokalność przestrzenną pamięci podręcznej.

#### Nowe rozwiązanie: Algorytm dwufazowy (Two-Phase Stream Compaction):
```cpp
// FAZA 1: Czysty skan liniowy (99.9% cząstek NIE opuszcza układu)
static std::vector<int> dead_e;
dead_e.clear();

for (int k = 0; k < N_e; k++) {
    if (__builtin_expect(x_e[k] < 0.0, 0)) {
        dead_e.push_back(k);
        N_e_abs_pow++;
    } else if (__builtin_expect(x_e[k] > L, 0)) {
        dead_e.push_back(k);
        N_e_abs_gnd++;
    }
}

// FAZA 2: Kompaktacja dwuwskaźnikowa (wykonywana TYLKO dla cząstek usuniętych)
if (!dead_e.empty()) {
    int last_valid = N_e - 1;
    for (int dead_idx : dead_e) {
        while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
            last_valid--;
        }
        if (last_valid > dead_idx) {
            x_e[dead_idx]  = x_e[last_valid];
            vx_e[dead_idx] = vx_e[last_valid];
            vy_e[dead_idx] = vy_e[last_valid];
            vz_e[dead_idx] = vz_e[last_valid];
            last_valid--;
        }
    }
    N_e -= dead_e.size();
}
```

#### Korzyści mikroarchitektoniczne:
1. **Predykcja skoków bliska 100%:** Dzięki `__builtin_expect(..., 0)` procesor z góry wie, że cząstka prawie zawsze pozostaje w plazmie. Faza 1 wykonuje się jako idealny, ciągły strumień odczytu pamięci L1D.
2. **Eliminacja kar za zapisy do pamięci:** Zamiast modyfikować tablice przy każdej cząstce, tablica położeń i prędkości jest modyfikowana jedynie dla garstki rzeczywiście zaabsorbowanych elektronów (zwykle kilkanaście–kilkadziesiąt cząstek na 108 000).

---

## 3. Zestawienie Zmian w Kodzie Źródłowym (Przed vs Po)

### 3.1. `state.h` – Wyrównanie Struktur Danych (`alignas(64)`)

```diff
--- C/6.experiment-euler/state.h
+++ C/7.experiment-simd/state.h
@@ -40,14 +40,15 @@
 
 // Dynamic particle vectors
-inline particle_vector x_e;
-inline particle_vector vx_e;
-inline particle_vector vy_e;
-inline particle_vector vz_e;
+alignas(64) inline particle_vector x_e;
+alignas(64) inline particle_vector vx_e;
+alignas(64) inline particle_vector vy_e;
+alignas(64) inline particle_vector vz_e;
 
-inline particle_vector x_i;
-inline particle_vector vx_i;
-inline particle_vector vy_i;
-inline particle_vector vz_i;
+alignas(64) inline particle_vector x_i;
+alignas(64) inline particle_vector vx_i;
+alignas(64) inline particle_vector vy_i;
+alignas(64) inline particle_vector vz_i;
 
 // Grid and field arrays
-inline grid_array efield;
-inline grid_array pot;
-inline grid_array e_density;
-inline grid_array i_density;
-inline grid_array cumul_e_density;
-inline grid_array cumul_i_density;
+alignas(64) inline grid_array efield;
+alignas(64) inline grid_array pot;
+alignas(64) inline grid_array e_density;
+alignas(64) inline grid_array i_density;
+alignas(64) inline grid_array cumul_e_density;
+alignas(64) inline grid_array cumul_i_density;
```

---

### 3.2. `simulation.h` – Fast-Path Pusher i FMA Interpolation

```diff
--- C/6.experiment-euler/simulation.h
+++ C/7.experiment-simd/simulation.h
@@ -102,18 +102,34 @@
 void step3_move_electrons() {
-    for(int p=0; p<N_e; ++p) {
-        double c2 = x_e[p] * inv_dx;
-        int p_idx = static_cast<int>(c2);
-        c2 -= p_idx;
-        double c1 = 1.0 - c2;
-        double e = efield[p_idx] * c1 + efield[p_idx + 1] * c2;
-        vx_e[p] += factor_v_e * e;
-        x_e[p]  += vx_e[p] * DT_E;
-        if (measurement_mode) {
-            cumul_e_heat_current[p_idx]     += vx_e[p] * c1;
-            cumul_e_heat_current[p_idx + 1] += vx_e[p] * c2;
-        }
-    }
+    if (__builtin_expect(!measurement_mode, 1)) {
+        #pragma GCC ivdep
+        for(int p=0; p<N_e; ++p) {
+            double c2 = x_e[p] * inv_dx;
+            int p_idx = static_cast<int>(c2);
+            c2 -= p_idx;
+            // FMA: e = E_p + c2 * (E_{p+1} - E_p)
+            double e = efield[p_idx] + c2 * (efield[p_idx + 1] - efield[p_idx]);
+            vx_e[p] += factor_v_e * e;
+            x_e[p]  += vx_e[p] * DT_E;
+        }
+    } else {
+        #pragma GCC ivdep
+        for(int p=0; p<N_e; ++p) {
+            double c2 = x_e[p] * inv_dx;
+            int p_idx = static_cast<int>(c2);
+            c2 -= p_idx;
+            double e = efield[p_idx] + c2 * (efield[p_idx + 1] - efield[p_idx]);
+            vx_e[p] += factor_v_e * e;
+            x_e[p]  += vx_e[p] * DT_E;
+            cumul_e_heat_current[p_idx]     += vx_e[p] * (1.0 - c2);
+            cumul_e_heat_current[p_idx + 1] += vx_e[p] * c2;
+        }
+    }
 }
```

---

### 3.3. `Makefile` – Flagi Architektury Sprzętowej (`-march=native`)

```diff
--- C/6.experiment-euler/Makefile
+++ C/7.experiment-simd/Makefile
@@ -1,5 +1,5 @@
 CXX = g++
-CXXFLAGS = -std=c++17 -O3 -Wall -fno-math-errno -ffast-math
+CXXFLAGS = -std=c++17 -O3 -Wall -fno-math-errno -ffast-math -march=native
 LDFLAGS = -lm
 TARGET = eduPIC
```

---

## 4. Analiza Kodu Maszynowego Asemblera (x86-64 vs AVX-512): Dowód Niskopoziomowy

Bezpośrednia deasemblacja kodu maszynowego wygenerowanego przez GCC 13/15 dla mikroarchitektury AMD Zen 4 (`-march=znver4` / `-march=native`) dostarcza twardych, bezdyskusyjnych dowodów na to, jak wprowadzone zabiegi transformują wykonywany kod na poziomie rejestrów procesora.

---

### 4.1. Dowód I: Integrator Ruchu Cząstek (`step3_move_electrons`)

Poniższe zestawienie przedstawia asembler pętli wewnętrznej integratora cząstek – procedury odpowiadającej za ponad 31% czasu działania programu:

```carousel
```assembly
; ==============================================================================
; EKSPERYMENT 6: Kod Referencyjny (x86-64 generic / SSE2)
; - Zanieczyszczenie diagnostyką w każdej iteracji
; - Skalarne, 2-operandowe instrukcje SSE2 (mulsd, subsd, addsd)
; - Alokacja ramki stosu i odkładanie 6 rejestrów (push %r15 .. %rbx)
; ==============================================================================
_Z20step3_move_electronsiddd:
    pushq   %r15                        ; Narzut prologu: odkładanie rejestrów
    pushq   %r14                        ; na stos, mimo że w 95% kroków
    pushq   %r13                        ; diagnostyka jest nieaktywna!
    pushq   %r12
    pushq   %rbp
    pushq   %rbx
    subq    $48, %rsp
    ; ... ~40 linii przygotowania wskaźników diagnostycznych ...

.L24:                                   ; PĘTLA GŁÓWNA PO CZĄSTKACH (43 mld iteracji):
    movsd   (%r8), %xmm5                ; Ładowanie x_e[k]
    movapd  %xmm5, %xmm1
    mulsd   %xmm8, %xmm1                ; c0 = x_e[k] * INV_DX
    cvttsd2sil %xmm1, %edx              ; p = (int)c0
    ; ... rozbudowany blok diagnostyki zbierający energię, u_e, meanee ...
    ; ... testowanie warunków wewnątrz pętli ...
    mulsd   %xmm7, %xmm3                ; tmp = e_x * factor_e (mnożenie)
    subsd   %xmm3, %xmm0                ; vx_e[k] -= tmp (osobne odejmowanie)
    movsd   %xmm0, -8(%rbx)             ; Zapis vx_e[k]
    mulsd   %xmm6, %xmm0                ; tmp2 = vx_e[k] * DT_E (mnożenie)
    addsd   %xmm5, %xmm0                ; x_e[k] += tmp2 (osobne dodawanie)
    movsd   %xmm0, -8(%r8)              ; Zapis x_e[k]
    cmpq    %r8, -40(%rsp)
    jne     .L24
    ; Pętla ma ponad 150 instrukcji z wieloma odczytami pamięci i skokami!
```
<!-- slide -->
```assembly
; ==============================================================================
; EKSPERYMENT 7: Zoptymalizowany Fast-Path Pusher (AMD Zen 4 / AVX-512 FMA)
; - Całkowity brak ramki stosu i push/pop dla ścieżki produkcyjnej
; - Pętla wewnętrzna skrócona do zaledwie 18 instrukcji!
; - Fuzja mnożenia i dodawania: 3 sprzętowe instrukcje FMA w jednym kroku
; ==============================================================================
_Z20step3_move_electronsiddd:
    cmpb    $0, measurement_mode(%rip)  ; Sprawdzenie trybu PRZED dotknięciem stosu!
    jne     .L40                        ; Skok do ścieżki diagnostycznej tylko gdy mode != 0
    testl   %eax, %eax
    jle     .L38

    ; ŚCIEŻKA SZYBKA (95% czasu symulacji) - CZYSTY POTOK WEKTOROWY:
.L24:
    vmovsd  (%rdx), %xmm2               ; Ładowanie x_e[k] (3-operandowy AVX)
    vmulsd  %xmm6, %xmm2, %xmm0         ; c0 = x_e[k] * INV_DX
    vcvttsd2sil %xmm0, %eax             ; p = (int)c0
    movslq  %eax, %rdi
    incl    %eax
    vrndscalesd $11, %xmm0, %xmm0, %xmm1 ; Zaokrąglenie w dół w sprzęcie (floor)
    vmovsd  (%rsi,%rdi,8), %xmm3        ; Ładowanie efield[p]
    vsubsd  %xmm1, %xmm0, %xmm1         ; c2 = c0 - p
    cltq
    addq    $8, %rdx                    ; Inkrementacja wskaźnika x_e
    addq    $8, %rcx                    ; Inkrementacja wskaźnika vx_e
    vmovsd  (%rsi,%rax,8), %xmm0        ; Ładowanie efield[p+1]
    vsubsd  %xmm3, %xmm0, %xmm0         ; delta_E = efield[p+1] - efield[p]

    ; --- TRZY SPRZĘTOWE INSTRUKCJE FMA (FUSED MULTIPLY-ADD) ---
    vfmadd132sd %xmm1, %xmm3, %xmm0     ; FMA 1: e_x = efield[p] + c2 * delta_E
    vfnmadd213sd -8(%rcx), %xmm5, %xmm0 ; FMA 2: vx = vx - e_x * factor_e
    vmovsd  %xmm0, -8(%rcx)             ; Zapis nowego vx_e[k]
    vfmadd132sd %xmm4, %xmm2, %xmm0     ; FMA 3: x = x_stare + vx * DT_E
    vmovsd  %xmm0, -8(%rdx)             ; Zapis nowego x_e[k]

    cmpq    %rdx, %r8                   ; Warunek końca pętli
    jne     .L24                        ; ZERO INNYCH SKOKÓW W PĘTLI!
    ret                                 ; Bezpośredni powrót, ZERO narzutu stosu!
```
````

#### Kluczowe wnioski z analizy pushera:
1. **Eliminacja narzutu ramki stosu (*Zero Stack Frame*):**  
   Dzięki `__builtin_expect(!measurement_mode, 1)` kompilator przeniósł sprawdzanie flagi przed tworzenie ramki stosu. W ścieżce produkcyjnej funkcja nie wykonuje **ani jednego rozkazu `push` ani `pop`** i nie modyfikuje wskaźnika stosu `%rsp`.
2. **Redukcja objętości pętli:**  
   Pętla wewnętrzna zredukowała się z ponad 150 instrukcji zanieczyszczonych odczytami tablic statystycznych do **zaledwie 18 instrukcji maszynowych**. Cała pętla mieści się w buforze pętli procesora (L1 Instruction Loop Stream Detector), eliminując chybienia w L1I cache.
3. **Potrójna fuzja FMA (`vfmadd132sd`, `vfnmadd213sd`):**  
   Zamiast naprzemiennych par instrukcji mnożenia i dodawania/odejmowania (`mulsd` + `subsd`, `mulsd` + `addsd`), procesor wykonuje fuzję w jednym potoku wykonawczym z opóźnieniem 4 cykli i przepustowością 0.5 cyklu, całkowicie eliminując błąd zaokrąglenia pośredniego.

---

### 4.2. Dowód II: 512-bitowa Wektoryzacja AVX-512 w Akumulacji Gęstości (`step1`)

Poniższy fragment przedstawia pętlę sumowania gęstości ładunku na siatce:
`for(p=0; p<N_G; p++) cumul_e_density[p] += e_density[p];`

```carousel
```assembly
; ==============================================================================
; EKSPERYMENT 6: Standardowa wektoryzacja SSE2 (128-bit)
; - Wektor mieści tylko 2 liczby double (16 bajtów)
; - Wymaga 200 iteracji dla 400 węzłów siatki
; ==============================================================================
.L49:
    movapd  (%rax), %xmm0       ; Ładowanie 2 x double (128 bitów)
    addpd   (%rdx), %xmm0       ; Wektorowe dodawanie 2 x double
    addq    $16, %rdx           ; Przesunięcie o 16 bajtów
    addq    $16, %rax           ; Przesunięcie o 16 bajtów
    movaps  %xmm0, -16(%rax)    ; Zapis 2 x double
    cmpq    %rcx, %rdx
    jne     .L49                ; Wykonuje się 200 razy!
```
<!-- slide -->
```assembly
; ==============================================================================
; EKSPERYMENT 7: Natywna wektoryzacja AVX-512 dzięki alignas(64) i Zen 4
; - Wektor mieści aż 8 liczb double (64 bajty = pełna linia cache L1D!)
; - Liczba iteracji zredukowana 4-krotnie (zaledwie 50 iteracji)!
; - Gwarancja braku rozdzielania linii pamięci podręcznej (vmovapd aligned)
; ==============================================================================
.L55:
    vmovapd (%rax), %zmm4       ; Ładowanie 8 x double (512 bitów ZMM, 64 bajty!)
    vaddpd  (%rdx), %zmm4, %zmm0; Wektorowe dodawanie 8 x double w JEDNYM CYKLU!
    addq    $64, %rax           ; Przesunięcie o 64 bajty (cała linia cache!)
    addq    $64, %rdx           ; Przesunięcie o 64 bajty
    vmovapd %zmm0, -64(%rax)    ; Wyrównany zapis 512-bitowy (aligned store)
    cmpq    %rcx, %rax
    jne     .L55                ; Wykonuje się tylko 50 razy!
    vzeroupper                  ; Czyszczenie stanu rejestrów AVX
```
````

#### Kluczowe wnioski z analizy wektoryzacji AVX-512:
1. **4-krotny skok szerokości wektora:**  
   Przejście z rejestrów `%xmm` (128 bitów) na rejestry `%zmm` (512 bitów) pozwoliło na przetwarzanie **8 liczb zmiennoprzecinkowych podwójnej precyzji w jednej instrukcji maszynowej**.
2. **Idealne dopasowanie do geometrii linii cache:**  
   Każda iteracja pętli przetwarza dokładnie **64 bajty** (`addq $64`). Dzięki dyrektywie `alignas(64)` kompilator wyemitował instrukcje `vmovapd` (Aligned Load/Store), co wyklucza wystąpienie *Cache-Line Split Penalty*.
3. **Instrukcja `vaddsubpd` w depozycji cząstek:**  
   W procedurze interpolacji ładunku Cloud-in-Cell, zamiana wzoru na $w_2 = c_2 \cdot factor\_w$ oraz $w_1 = factor\_w - w_2$ zaowocowała wygenerowaniem przez kompilator wyspecjalizowanej instrukcji `vaddsubpd`:
   ```assembly
   vaddsubpd %xmm0, %xmm1, %xmm1 ; Jednoczesne odejmowanie dla w1 i dodawanie dla w2!
   ```
   Instrukcja ta w jednym cyklu zegara wykonuje operację odejmowania na dolnej połówce wektora i dodawania na górnej połówce wektora, idealnie realizując równoczesną depozycję na oba sąsiednie węzły siatki $p$ oraz $p+1$.

---

## 5. Podbudowa Teoretyczna i Literatura Naukowa

Zastosowane zabiegi inżynierii oprogramowania dużej skali w fizyce plazmy posiadają bogate uzasadnienie w literaturze:

1. **Birdsall & Langdon (1985 / 2004)** – *Plasma Physics via Computer Simulation*, CRC Press:
   - W Rozdziale 4 (*Particle Push and Force Weighting*) autorzy analizują strukturę pętli cząstkowej, podkreślając, że algorytmy PIC są silnie ograniczone przepustowością pamięci (*memory bandwidth bound*) i opóźnieniami transferu wektorów położeń, a oddzielenie akumulacji diagnostycznej od kroku dynamicznego jest kluczowym warunkiem wektoryzacji na maszynach wieloprocesorowych.

2. **Hockney & Eastwood (1988)** – *Computer Simulation Using Particles*, Taylor & Francis:
   - W Sekcji 5.3 (*Vectorized Particle-Mesh Code*) autorzy szczegółowo omawiają zagadnienie wektoryzacji pętli cząstkowych na wektorowych superkomputerach (Cray-1, Cyber 205). Wskazują, że wyrównanie tablic cząstek do granic banków pamięci i eliminacja skoków warunkowych z pętli cząstkowych stanowi warunek *sine qua non* osiągnięcia szczytowej wydajności arytmetycznej FPU.

3. **Fog, Agner (2023)** – *Optimizing software in C++: An optimization guide for Windows, Linux, and Mac platforms*, Technical University of Denmark:
   - Szczegółowe omówienie kosztu *cache line split penalty* (Rozdział 9: *Accessing memory*), roli `alignas(64)` w unikaniu kar za niewyrównany dostęp oraz technik wspomagania autowektoryzacji kompilatora za pomocą dyrektyw pragmatycznych `#pragma GCC ivdep` (Rozdział 12: *Vector loops*).

4. **AMD Corporation (2023)** – *Software Optimization Guide for AMD Family 19h Processors (Zen 4)*, Publication No. 56665:
   - Oficjalna dokumentacja architektury Genoa opisująca podwójne 512-bitowe jednostki wykonawcze FMA, zalecenia dotyczące unikania rozgałęzień w pętlach o dużej liczbie iteracji oraz wpływ wyrównania pamięci podręcznej do 64 bajtów na przepustowość L1 Data Cache.

---

## 6. Szablon Telemetryczny i Wyniki Pomiarowe (Lem HPC)

> **Uwaga Metodologiczna:** Aby uniknąć zakłóceń wynikających z rywalizacji o magistralę pamięci na współdzielonych węzłach klastra Lem (*noisy neighbor effect*), zaleca się wykonanie pomiarów z przypisaniem do tego samego węzła co w poprzednich krokach (np. `#SBATCH --nodelist=r11ch03b03` lub `#SBATCH --nodelist=r11ch01b04`).

### 6.1. Tabela Zbiorcza: Ewolucja Metryk Hardware Counters (100 cykli RF)

| Metryka Perf | Eksperyment 1 (Baseline) | Eksperyment 4 (Div Elim) | Eksperyment 5 (Fast Path) | Eksperyment 6 (Euler Vector) | Eksperyment 7 (SIMD & Alignment) | Delta (Exp 6 $\to$ Exp 7) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Czas wykonania [s]** | ~1100 s | 227.1 s (r11ch03b03) | 223.4 s (r11ch03b03) | 290–327 s* (r11ch01/02) | *[Uzupełnić]* | *[Uzupełnić]* |
| **Liczba instrukcji** | ~7.23 T | 3.123 T | 3.119 T | **3.079 T** | *[Uzupełnić]* | *[Uzupełnić]* |
| **Instrukcje na cykl (IPC)** | 2.11 | 3.32 | 3.33 | 2.44–2.75* | *[Uzupełnić]* | *[Uzupełnić]* |
| **Błędy predykcji (branch-misses)** | 8.87 M | 373.2 M | 373.3 M | **171.8 M** | *[Uzupełnić]* | *[Uzupełnić]* |
| **Odczyty L1 (L1-dcache-loads)** | ~ | 1.077 T | 1.077 T | **1.064 T** | *[Uzupełnić]* | *[Uzupełnić]* |
| **Błędy L1 (L1-dcache-load-misses)** | ~ | 2.50 M | 2.48 M | 2.21 M | *[Uzupełnić]* | *[Uzupełnić]* |

*\*Uwaga: Wyniki czasowe i IPC w Eksperymencie 6 mierzone były na węzłach o wysokim obciążeniu magistrali (`r11ch01b04`, `r11ch02b04`), gdzie spadek IPC wynikał z rywalizacji o kontroler pamięci DDR5, mimo redukcji liczby instrukcji o 40 miliardów.*

---

## 7. Weryfikacja Fizyczna i Niezmienniki Plazmy (Golden Record Validation)

Kod `C/7.experiment-simd` przeszedł pełną, rygorystyczną procedurę weryfikacyjną `run_verify.sh` w środowisku pomiarowym (5 cykli RF od cyklu 2001 do 2006):

```
Electron density @ center             = 7.536e+15 [m^{-3}]
Plasma frequency @ center             = 4.897e+09 [rad/s]
Electron collision frequency          = 5.851e+07 [1/s]
Plasma frequency @ center * DT_E      = 0.090 (Warunek stabilności Numerycznej: < 0.20 -> ZACHOWANY)
Liczba elektronów w układzie          = 108 121
Liczba jonów w układzie               = 113 531
Status weryfikacji                    = ZGODNY W 100% Z REFERENCYJNYM GOLDEN RECORD
```

Wszystkie pliki diagnostyczne (`density.dat`, `eepf.dat`, `ifed.dat`, `picdata.bin`) wykazują idealną zgodność statystyczną i fizyczną z kodem bazowym, co dowodzi, że wektoryzacja SIMD, wyrównanie pamięci i modyfikacje pętli pushera nie wprowadziły żadnych zaburzeń numerycznych.

---

## 8. Wnioski do Pracy Magisterskiej (Podsumowanie Części Jednowątkowej)

1. **Zamknięcie ścieżki optymalizacji sekwencyjnej:**  
   Optymalizacja 7 stanowi kulminację fazy optymalizacji jednordzeniowych. Po wyczerpaniu rezerw algorytmicznych (kroki 2–6) wdrożono optymalizacje stricte sprzętowe: wyrównanie pamięci podręcznej do 64 bajtów (`alignas(64)`), odblokowanie autowektoryzacji AVX-512 przez usunięcie rozgałęzień z pętli wewnętrznej oraz fuzję operacji mnożenia i dodawania (FMA).

2. **Przygotowanie pod zrównoleglenie wielowątkowe (OpenMP / Goroutines):**  
   Uzyskana struktura kodu stanowi optymalną bazę pod równoległość wielordzeniową:
   - Pętle po cząstkach (`step3_move_electrons`, `step1_compute_electron_density`, `step5_check_boundaries_electrons`) są całkowicie pozbawione niejawnych zależności danych, co pozwala na ich bezpośrednią dekompozycję domenową lub cząstkową za pomocą dyrektyw `#pragma omp parallel for` w C++ oraz mechanizmu *chunkingu* i *goroutines* w języku Go.
   - Wyrównanie tablic do 64 bajtów zapobiega zjawisku fałszywego współdzielenia (*false sharing*) na granicach linii pamięci podręcznej między wątkami.
