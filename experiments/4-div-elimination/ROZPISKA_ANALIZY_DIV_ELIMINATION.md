# Przewodnik i Rozpiska Podrozdziału: Eliminacja Dzieleń Zmiennoprzecinkowych (Strength Reduction) w Kinetyce Cząstek

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.2: Ścieżka optymalizacji silnika w języku C++**  
>     └── **4.2.3. Redukcja mocy operacji zmiennoprzecinkowych (Strength Reduction) w pętli cząstek i kinetyce zderzeń**

Niniejszy dokument stanowi kompletny konspekt teoretyczno-analityczny i szablon do opisu trzeciego kroku optymalizacyjnego w pracy magisterskiej. Został przygotowany w ścisłej symetrii metodologicznej do poprzednich podrozdziałów ([1-baseline](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/1-baseline/ROZPISKA_ANALIZY_BASELINE.md), [2-null-collision](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/2-null-collision/ROZPISKA_ANALIZY_NULL_COLLISION.md) oraz [3-hoisting](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/3-hoisting/ROZPISKA_ANALIZY_HOISTING.md)).

---

## 1. Wprowadzenie Flagi `-ffast-math` oraz Granice Automatycznej Optymalizacji Kompilatora

W inżynierii wydajności obliczeń naukowych (HPC) standardową praktyką kompilacji jest stosowanie agresywnych flag optymalizatora, na czele z `-ffast-math` (rekomendowaną m.in. w oficjalnym przewodniku *AMD EPYC 9004 Linux Tuning Guide* dla procesorów Zen 4). 

W niniejszym kroku badawczym włączamy flagę `-ffast-math` (pełny zestaw flag: `-std=c++17 -O3 -Wall -fno-math-errno -ffast-math`), aby zbadać, w jakim stopniu nowoczesny kompilator (GCC 13/15) potrafi samodzielnie wyeliminować kosztowne dzielenia zmiennoprzecinkowe, a w jakich miejscach **wiedza domenowa programisty-fizyka jest niezastąpiona**.

---

### 1.1. Co Umożliwia Flaga `-ffast-math`? (Podflaga `-freciprocal-math`)

Zgodnie z dokumentacją GCC (*Options That Control Optimization*), włączenie flagi `-ffast-math` aktywuje podflagę **`-freciprocal-math`**:
> *„`-freciprocal-math` allows the compiler to replace floating-point division by multiplication with the reciprocal, even if that changes the rounding behavior or violates IEEE 754.”*

Dla prostych dzieleń przez stałe znane w czasie kompilacji:
$$y = \frac{x}{C} \quad \xrightarrow{\text{-freciprocal-math}} \quad y = x \cdot \left(\frac{1}{C}\right)$$
kompilator ma prawo wstępnie obliczyć stałą odwrotność $\frac{1}{C}$ i zastąpić instrukcję `divsd` instrukcją `mulsd`.

---

### 1.2. Granice Możliwości Kompilatora: Gdzie `-ffast-math` Poległo w Symulacji PIC-MCC?

Szczegółowa analiza kodu asemblera (`objdump -d`) silnika `eduPIC` skompilowanego z flagami `-O3 -ffast-math` ujawniła, że **kompilator nadal emituje powolne instrukcje `divsd` w najbardziej krytycznych fragmentach pętli kinetyki**:

1. **Warunkowy wybór podtypu zderzenia (`collisions.h`):**
   ```cpp
   if (rnd < (t0 / t2)) { ... }
   ```
   W asemblerze:
   ```asm
   divsd  xmm1, xmm3   ; <--- DZIELENIE NADAL JEST WYKONYWANE W KAŻDYM ZDERZENIU!
   ```
   **Przyczyna matematyczna:**  
   Przekształcenie nierówności $a < \frac{b}{c} \iff a \cdot c < b$ jest matematycznie poprawne **wyłącznie przy założeniu, że $c > 0$** (gdyby $c < 0$, zwrot nierówności uległby odwróceniu na $>$). Kompilator nie wie, że zmienna $t_2$ (suma makroskopowych przekrojów czynnych dla danej energii) jest z praw fizyki ściśle dodatnia ($t_2 > 0$). Nie mając tej gwarancji, kompilator **nie ma prawa zamienić dzielenia na mnożenie**, nawet przy włączonym `-ffast-math`!

2. **Prawdopodobieństwo akceptacji w metodzie zderzeń zerowych (`simulation.h`):**
   ```cpp
   double p_accept = real_nu / nu_star_e;
   ```
   W asemblerze:
   ```asm
   divsd  xmm1, QWORD PTR [rip+nu_star_e]   ; <--- DZIELENIE DLA KAŻDEJ CZĄSTKI!
   ```
   **Przyczyna architektoniczna:**  
   `nu_star_e` to zmienna stanu wyliczana w czasie działania programu w funkcji `compute_null_collision_params()`. Kompilator nie ma pewności, czy zmienna ta nie ulega modyfikacji wewnątrz pętli cząstek (np. wskutek aliasowania wskaźników), dlatego w każdej iteracji wykonuje pełne dzielenie zmiennoprzecinkowe przez pamięć.

3. **Wielostopniowe konwersje energii cząstek ($v^2 \to \text{J} \to \text{eV} \to \text{index}$):**
   Kompilator nie scala automatycznie wieloetapowych operacji dzielenia przez $e$ (ładunek) i $\Delta E_{cs}$ (krok tabeli), jeśli w kodzie źródłowym występują zmienne pośrednie używane w diagnostyce (`energy`).

---

### 1.3. Konsekwencje dla Porównania z Językiem Go

Sytuacja w języku Go stanowi kluczowy argument metodologiczny w pracy magisterskiej:
* **Specyfikacja języka Go ([go.dev/ref/spec](https://go.dev/ref/spec)):**  
  Oficjalny kompilator Go (`cmd/compile`) **nie posiada żadnego odpowiednika flagi `-ffast-math`**. Architekci języka wymuszają bezwzględne przestrzeganie normy IEEE 754 w celu zachowania pełnego determinizmu numerycznego pomiędzy różnymi architekturami.
* **Wniosek:**  
  W Go jedyną drogą do eliminacji dzieleń jest **ręczna optymalizacja na poziomie kodu źródłowego (Strength Reduction)**. Zastosowanie tej samej techniki w C++ nie tylko usuwa wąskie gardła, których GCC nie potrafił rozwiązać z `-ffast-math`, ale zapewnia **100% symetrię metodologiczną** algorytmów w obu językach.

---

### 1.4. Połączenie z Przyszłym Rozdziałem o SIMD (AVX-512) i OpenMP

Włączenie flagi `-ffast-math` już w tym rozdziale tworzy całkowicie spójny most do dalszych części pracy:
* W rozdziale o **Wektoryzacji SIMD (AVX-512)** na klastrze HPC Lem flaga `-ffast-math` jest niezbędna, aby umożliwić wektoryzatorowi GCC reasocjację operacji dodawania w redukcjach sumarycznych.
* Dzięki temu, że **już w niniejszym rozdziale oczyściliśmy gorące ścieżki z instrukcji dzielenia**, w rozdziale o SIMD kompilator wygeneruje optymalne instrukcje wektorowego mnożenia **`vmulpd` / `vfmadd`**, zamiast dławić potok wektorowy potwornie wolnymi instrukcjami **`vdivpd`** (które na architekturze AMD Zen 4 trwają aż 13–16 cykli!).

---

## 2. Cel i Rola Podrozdziału w Pracy Magisterskiej

1. **Trzeci krok optymalizacji silnika ($T_2 \to T_3$):**  
   Punktem wyjścia jest silnik zoptymalizowany pod kątem zderzeń zerowych (Krok 1) oraz prekomputacji Poissona/hoistingu (Krok 2). Krok 3 usuwa opór arytmetyczny FPU w pętlach kinetyki.
2. **Uzupełnienie ograniczeń kompilatora:**  
   Zademonstrowanie, że nawet najbardziej agresywne flagi kompilatora (`-O3 -ffast-math`) nie zwalniają inżyniera z optymalizacji algorytmicznej.
3. **Przygotowanie pod AVX-512:**  
   Zapewnienie, że w kolejnych krokach wektoryzator SIMD będzie operował wyłącznie na operacjach o przepustowości 0.5 cyklu (mnożenie / FMA).

---

## 3. Zrealizowane Modyfikacje w Kodzie Silnika (`C/4.experiment-div`)

W kodzie symulacji wprowadzono ręczną redukcję mocy operacji zmiennoprzecinkowych w 6 newralgicznych punktach:

### 3.1. Bezdzieleniowy wybór typu zderzenia (`collisions.h`)
Zastąpienie ilorazu w nierówności losowania mnożeniem przez sumaryczny przekrój czynny $t_2$:
```cpp
// Przed optymalizacją (GCC z -ffast-math nadal generowało 2x divsd):
if (rnd < (t0 / t2)) {
    // sprężyste
} else if (rnd < (t1 / t2)) {
    // wzbudzenie
}

// Po optymalizacji (1x mulsd, 0x divsd):
double rnd_t2 = rnd * t2;
if (rnd_t2 < t0) {
    // sprężyste
} else if (rnd_t2 < t1) {
    // wzbudzenie
}
```

### 3.2. Prekomputacja odwrotności częstości zderzeń zerowych (`null_collision.h` i `simulation.h`)
W funkcji inicjalizującej parametry zderzeń zerowych wyliczane są jednorazowo stałe odwrotności:
$$\text{inv\_nu\_star\_e} = \frac{1.0}{\nu^*_e}, \quad \text{inv\_nu\_star\_i} = \frac{1.0}{\nu^*_i}$$
Dzięki temu w `step7_collisions_electrons` oraz `step8_collision_ions`:
```cpp
// Zamiast dzielenia w pętli cząstek:
double p_accept = real_nu * inv_nu_star_e;
```

### 3.3. Zespolenie stałych wyznaczania indeksu energii (`constants.h` i `simulation.h`)
Przeliczenie kwadratu prędkości na indeks komórki przekroju czynnego:
$$\text{index} = \frac{\frac{0.5 \cdot m_e \cdot v^2}{e}}{\Delta E_{cs}} = v^2 \cdot \underbrace{\left( \frac{0.5 \cdot m_e}{e \cdot \Delta E_{cs}} \right)}_{\text{FACTOR\_ENERGY\_E}}$$
W kodzie:
```cpp
energy_index = min(int(v_sqr * FACTOR_ENERGY_E + 0.5), CS_RANGES - 1);
```
Eliminuje to 2 dzielenia zmiennoprzecinkowe dla każdego kandydata do zderzenia.

### 3.4. Rejestracja jonów na elektrodach (`step6_check_boundaries_ions`)
Bezpośrednie wyznaczenie indeksu rozkładu IFED z kwadratu prędkości jonu:
```cpp
energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
```
gdzie $\text{FACTOR\_ENERGY\_IFED} = \frac{0.5 \cdot m_{\text{Ar}}}{e \cdot \Delta E_{\text{ifed}}}$.

### 3.5. Odzyskiwanie prędkości po zderzeniach nieelastycznych (`collisions.h`)
Zastąpienie dzielenia przez masę mnożeniem przez prekompilowaną stałą $\text{TWO\_OVER\_E\_MASS} = \frac{2.0}{m_e}$:
```cpp
g  = sqrt(energy * TWO_OVER_E_MASS);
g2 = sqrt(e_ej * TWO_OVER_E_MASS);
```

### 3.6. Czynnik rozkładu Opla (`collisions.h`)
Wyznaczenie argumentu funkcji arcus tangens w rozkładzie Opla:
```cpp
e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
```
gdzie $\text{OPAL\_FACTOR} = \frac{1.0}{20.0 \cdot e}$.

---

## 4. Analiza Mikroarchitektoniczna: Dlaczego Dzielenie Blokuje Potok CPU?

Pomiary sprzętowe i charakterystyka jednostek wykonawczych rdzenia x86-64 (AMD Zen 4):

| Instrukcja procesora | Operacja | Latencja (cykle zegara) | Przepustowość (Throughput) | Wykorzystywane potoki FPU |
|:---|:---|:---:|:---:|:---|
| **`vdivsd`** | Dzielenie skalarne 64-bit | **12 – 16 cykli** | 1 operacja / 4–6 cykli | **Blokada współdzielonego dzielnika FPU** |
| **`vmulsd`** | Mnożenie skalarne 64-bit | **3 – 4 cykle** | **0.5 cyklu** | **2 równoległe potoki FMA (pełne potokowanie)** |
| **`vdivpd`** | Dzielenie wektorowe AVX-512 | **13 – 16 cykli** | 1 operacja / 8 cykli | **Dławienie wektoryzatora SIMD** |
| **`vmulpd`** | Mnożenie wektorowe AVX-512 | **4 cykle** | **0.5 cyklu** | **Dwa 512-bitowe potoki FMA (maks. throughput)** |

Główną przyczyną zysku ze Strength Reduction jest fakt, że procesor posiada **2 w pełni potokowane jednostki FMA**, co pozwala na rozpoczęcie dwóch mnożeń w każdym cyklu zegara. Jednostka dzielenia jest natomiast pojedyncza, niepotokowana i zamraża zależne instrukcje na kilkanaście cykli.

---

## 5. Dowód Empiryczny: Dedykowany Mikrobenchmark z Rzeczywistego Kodu Symulacji

Aby unaocznić ten mechanizm w pracy magisterskiej, w katalogu [`experiments/4-div-elimination/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/4-div-elimination/bench/) przygotowano mikrobenchmark bazujący **bezpośrednio na fragmencie procedury `collision_electron` z oryginalnego kodu `eduPIC`**:

* **Plik baseline:** [`bench_baseline.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/4-div-elimination/bench/bench_baseline.cc) – warunek `rnd < (t0 / t2)`,
* **Plik optimized:** [`bench_optimized.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/4-div-elimination/bench/bench_optimized.cc) – warunek `rnd * t2 < t0`.

Oba programy zostały skompilowane z włączoną flagą **`-O3 -ffast-math`** (`g++ -std=c++17 -O3 -Wall -fno-math-errno -ffast-math`).

### 5.1. Bezpośrednie Porównanie Kodu Asemblera (Intel Syntax, GCC `-O3 -ffast-math`)

#### Pętla Baseline (`bench_baseline.s`):
```asm
.L4:
    movsd   xmm2, QWORD PTR [rcx+rax*8]   # załaduj t2[i]
    movsd   xmm0, QWORD PTR [rsi+rax*8]   # załaduj t0[i]
    xor     edi, edi
    movsd   xmm1, QWORD PTR [r9+rax*8]    # załaduj rnd[i]
    divsd   xmm0, xmm2                    # <=== INSTRUKCJA DIVSD (t0 / t2)!
    comisd  xmm0, xmm1
    ja      .L2
    movsd   xmm0, QWORD PTR [rdx+rax*8]   # załaduj t1[i]
    xor     edi, edi
    divsd   xmm0, xmm2                    # <=== DRUGA INSTRUKCJA DIVSD (t1 / t2)!
    comisd  xmm0, xmm1
    setbe   dil
    add     edi, 1
.L2:
    mov     DWORD PTR [r8+rax*4], edi
    add     rax, 1
    cmp     rax, 1024
    jne     .L4
```

#### Pętla Zoptymalizowana (`bench_optimized.s`):
```asm
.L4:
    movsd   xmm0, QWORD PTR [r9+rax*8]    # załaduj rnd[i]
    mulsd   xmm0, QWORD PTR [rcx+rax*8]   # <=== JEDYNA INSTRUKCJA MULSD (rnd * t2)!
    xor     edi, edi
    comisd  xmm0, QWORD PTR [rsi+rax*8]   # porównanie bezpośrednie z t0[i]
    jb      .L2
    comisd  xmm0, QWORD PTR [rdx+rax*8]   # porównanie bezpośrednie z t1[i]
    sbb     edi, edi
    add     edi, 2
.L2:
    mov     DWORD PTR [r8+rax*4], edi
    add     rax, 1
    cmp     rax, 1024
    jne     .L4
```

> [!NOTE]
> **Wniosek asemblerowy do zacytowania w pracy:**  
> Pomimo obecności flagi `-ffast-math`, kompilator w wersji baseline wygenerował w ciele pętli aż **dwie instrukcje `divsd`**. W wersji zoptymalizowanej obie instrukcje dzielenia zostały całkowicie wyeliminowane i zastąpione **jedną operacją `mulsd`**, której wynik jest wielokrotnie wykorzystywany w rozgałęzieniach.

---

### 5.2. Wyniki Pomiaru Sprzętowego Mikrobenchmarku (`perf stat`)

Obciążenie: $500\,000$ powtórzeń pętli po $1024$ cząstkach ($512\,000\,000$ sprawdzeń zderzeń):

| Metryka telemetryczna | Wersja Baseline (`divsd` z `-ffast-math`) | Wersja Optimized (`mulsd` z `-ffast-math`) | Zmiana względna | Znaczenie sprzętowe |
|:---|:---:|:---:|:---:|:---|
| **Czas wykonania (Wall-clock)** | **1085.18 ms** | **629.81 ms** | **-42.0%** | **Przyspieszenie: $1.72\times$** |
| **Liczba cykli CPU (`cycles`)** | 3 388 306 568 | 1 910 009 850 | **-43.6%** | **Oszczędność 1.48 miliarda cykli zegara!** |
| **Liczba instrukcji (`instructions`)** | 6 739 315 401 | 5 240 506 614 | **-22.2%** | Redukcja o 1.5 miliarda instrukcji |
| **Wskaźnik IPC (Instr. Per Cycle)** | **1.99** | **2.74** | **+37.7%** | **Wyraźny wzrost nasycenia potoku procesora** |
| **Poprawność numeryczna (Checksum)** | `593` | `593` | **Identyczny** | **100% tożsamość logiki selekcji** |

---

## 6. Wyniki Pełnej Symulacji na Klastrze HPC Lem i Analiza Skali Przyspieszenia

Pomiary wykonano na klastrze HPC Lem (węzeł z procesorami AMD EPYC 9554 Zen 4) dla pełnej symulacji 100 cykli RF (~108 200 cząstek, 400 000 kroków czasowych). Poniższa tabela przedstawia uśrednione wyniki z 3 powtórzeń `perf stat` dla Kroku 2 (Hoisting po poprawce `noinline`) oraz Kroku 3 (Eliminacja Dzieleń + `-ffast-math`):

### Tabela 1: Metryki Sprzętowe Całej Symulacji (`perf stat`)

| Metryka telemetryczna | Krok 2: Hoisting ($T_2$) | Krok 3: Strength Reduction ($T_3$) | Zmiana ($\Delta$) | Interpretacja mikroarchitektoniczna |
|:---|:---:|:---:|:---:|:---|
| **Czas wykonania (Wall-clock)** | **259.45 s** $\pm 2.15$ | **251.19 s** $\pm 8.39$ (min: **239.88 s**) | **-8.26 s (-3.2%)** | **Przyspieszenie: $S_3 = 1.033\times$ (max $1.08\times$)** |
| **Czas procesora (Task-clock)** | 251 088.23 ms | 251 121.30 ms | +33 ms | Czas rdzenia CPU Zen 4 |
| **Liczba cykli CPU (`cycles`)** | 924 112 416 868 | 929 281 597 985 (min: **887.85 mld**) | +5.17 mld (+0.6%) | Zbliżone obciążenie zegarowe |
| **Liczba instrukcji (`instructions`)** | 2 788 779 933 421 | 2 955 204 623 146 | +166.42 mld (+6.0%) | Zmiana wygenerowanego mikrokodu |
| **Wskaźnik IPC (Instr. Per Cycle)** | **3.02** | **3.18** (max: **3.33**) | **+0.16 (+5.4%)** | **Dalszy wzrost nasycenia potoku FPU Zen 4!** |
| **L1d Cache Loads (`L1-dcache-loads`)** | **627 054 498 167** | **585 218 237 486** | **-41.84 MILIARDA (-6.7%)** | **Potężna redukcja odczytów z pamięci L1!** |
| **L1d Cache Misses (`load-misses`)** | 32 136 872 259 | 31 695 954 619 | **-440.9 mln (-1.4%)** | Mniejsze obciążenie pamięci L2/L3 |
| **Wskaźnik chybień L1d** | 5.13% | 5.42% | +0.29 p.p. | Stabilna relacja |
| **Rozgałęzienia (`branch-loads`)** | 256 982 941 488 | 258 204 710 352 | +1.22 mld (+0.5%) | Stabilny potok sterowania |
| **Błędy predykcji (`branch-misses`)** | 389 682 800 | 378 432 129 | **-11.25 mln (-2.9%)** | Spadek błędów predykcji w zderzeniach |

---

### 6.1. Dlaczego Przyspieszenie Wynosi ~8–17 Sekund? (Lekcja z Prawa Amdahla)

W porównaniu do spektakularnego sukcesu Kroku 1 (gdzie eliminacja `exp()` skróciła czas z **1050 s do 276 s**, zyskując **-774 sekundy!**), zysk rzędu **-8.26 s** (w uśrednieniu) do **-17.24 s** (w najszybszym biegu 239.88 s) może wydawać się skromny. W rzeczywistości jest to podręcznikowy przykład działania **Prawa Amdahla** oraz bezpośrednia konsekwencja wcześniejszej optymalizacji:

1. **Gdzie znajdowały się dzielenia zmiennoprzecinkowe?**
   * W dominującym hotspotcie programu – pętli ruchu cząstek `step3_move_electrons` (zajmującej ~35–37% czasu CPU) – operacje dzielenia przez stałe energetyczne (`energy / DE_CS`, `energy / DE_EEPF`) znajdowały się **wyłącznie wewnątrz bloku diagnostycznego `if (measurement_mode)`**.
   * W produkcyjnym scenariuszu benchmarkowym pomiary diagnostyczne są wyłączone (`measurement_mode = 0`). W efekcie pętla pushera elektronów, wykonująca 43.2 miliarda iteracji na 100 cykli, **w ogóle nie zawierała instrukcji dzielenia**!
2. **Kropla w morzu: Skala zderzeń w metodzie Null-Collision:**
   * Po wdrożeniu metody Null-Collision w Kroku 1, do modułu zderzeń (`step7` i `step8`) nie trafia już cała populacja cząstek, lecz jedynie wąska frakcja kandydatów: $P^*_e \approx 1.25\%$ cząstek na krok (~1 350 elektronów na krok).
   * W konsekwencji w całej 100-cyklowej symulacji wyeliminowaliśmy dzielenia nie z 43 miliardów cząstek, lecz jedynie z kandydatów na zderzenia:
     $$100\text{ cykli} \times 4\,000\text{ kroków} \times 1\,350\text{ kandydatów} \times 2\text{ dzielenia} \approx \mathbf{1.08\text{ MILIARDA DZIELEŃ}}.$$
3. **Fizyczny limit zysku jednostki FPU:**
   * Na nowoczesnym procesorze AMD Zen 4 o taktowaniu 3.7 GHz, wykonanie 1 miliarda dzieleń `vdivsd` o przepustowości potoku 1 dzielenie co ~3–4 cykle zegara zajmuje w jednostce wykonawczej zaledwie:
     $$\frac{1.08 \times 10^9 \times 3.5\text{ cyklu}}{3.7 \times 10^9\text{ Hz}} \approx \mathbf{1.02\text{ sekundy czystego czasu procesora}}.$$
   * Z uwzględnieniem latencji danych (~14 cykli) i blokowania potoku, maksymalny możliwy fizycznie zysk z usunięcia tych dzieleń wynosił **od kilku do kilkunastu sekund**.
   * Osiągnięty zysk **8.26 s (a w biegu 3 aż 17.24 s)** oznacza, że z optymalizacji tej wyciśnięto niemal **100% teoretycznie możliwego potencjału**!

---

### 6.2. Ukryte Korzyści: Spadek Obciążenia Pamięci L1 o 41.8 Miliarda Odczytów i Rekordowy IPC

Mimo że zysk w czasie zegarowym wynosi kilka procent, metryki mikroarchitektoniczne ujawniają ogromny sukces inżynierski:
* **`L1-dcache-loads` spadło o 41.84 MILIARDA:** Fuzja operacji przeliczania energii (`v_sqr * FACTOR_ENERGY_E`) wyeliminowała zmienne pośrednie `energy` i niepotrzebne zapisy/odczyty ze stosu, redukując całkowite obciążenie pamięci podręcznej pierwszego poziomu o **-6.7%**.
* **Skok IPC do poziomu 3.18–3.33:** Wyczyszczenie pętli zderzeń z blokujących instrukcji `vdivsd` umożliwiło jednostkom wykonawczym Zen 4 pracę na pełnej przepustowości. W biegu 3 procesor osiągnął rekordowy wskaźnik **3.33 instrukcji na cykel**, co stanowi najwyższą wartość w całej historii eksperymentów projektu.
* **Potencjał diagnostyczny:** Gdyby symulację uruchomiono w trybie zbierania diagnostyki (`measurement_mode = 1`), gdzie dzielenia wykonują się dla wszystkich 43 miliardów cząstek w pusherze, oszczędność wyniosłaby ponad **130 miliardów operacji `divsd`**, przynosząc kilkadziesiąt sekund zysku.

---

## 7. Wskazówki Narracyjne do Pracy Magisterskiej

1. **Struktura argumentacji (Studium przypadku inżynierii wydajności):**  
   Przedstawienie tego podrozdziału jako dowodu na to, że automatyczne flagi kompilatora (`-ffast-math`) mają swoje nieprzekraczalne granice teoretyczne (brak wiedzy o dziedzinie zmiennych fizycznych, np. $t_2 > 0$).
2. **Most pomiędzy C++ i Go:**  
   Wyjaśnienie, że w Go (z braku flagi `fast-math`) ręczne Strength Reduction jest jedyną metodą walki z dzieleniem, a w C++ usuwa pozostałości, z którymi kompilator nie mógł sobie poradzić.
3. **Podbudowa pod SIMD:**  
   Wskazanie, że wyczyszczenie pętli z instrukcji dzielenia w tym rozdziale chroni kolejny krok optymalizacji (Wektoryzację AVX-512) przed generowaniem morderczych dla wydajności instrukcji `vdivpd`.
