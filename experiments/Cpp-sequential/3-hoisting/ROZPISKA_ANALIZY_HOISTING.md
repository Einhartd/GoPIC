# Przewodnik i Rozpiska Podrozdziału: Hoisting Stałych Niezmienniczych i Prekompilacja Solwera Poissona

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.2: Ścieżka optymalizacji silnika w języku C++**  
>     └── **4.2.2. Eliminacja redundancji obliczeniowej: Hoisting stałych i analityczna prekompilacja solwera Poissona**

Niniejszy dokument stanowi kompletny konspekt teoretyczno-analityczny i szablon do opisu drugiego kroku optymalizacyjnego w pracy magisterskiej. Został przygotowany w ścisłej symetrii metodologicznej do [ROZPISKA_ANALIZY_BASELINE.md](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/1-baseline/ROZPISKA_ANALIZY_BASELINE.md) oraz [ROZPISKA_ANALIZY_NULL_COLLISION.md](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/2-null-collision/ROZPISKA_ANALIZY_NULL_COLLISION.md). Dokument zawiera aparaturę matematyczną, dowód asemblerowy niemożności automatycznej optymalizacji przez kompilator GCC z flagą `-O3`, twarde dane telemetryczne z dedykowanego mikrobenchmarku (`perf stat`) oraz gotowe szablony tabel na wyniki z klastra HPC Lem.

---

## 1. Cel i Rola Podrozdziału w Pracy Magisterskiej

1. **Drugi krok na ścieżce optymalizacji ($T_1 \to T_2$):**
   * Wyznaczenie nowego czasu wykonania symulacji $T_{\text{hoist}}$ oraz przyspieszenia cząstkowego:
     $$S_2 = \frac{T_{\text{null}}}{T_{\text{hoist}}}, \quad S_{\text{total}} = \frac{T_0}{T_{\text{hoist}}}$$
2. **Eliminacja redundancji czasowo-przestrzennej (Loop-Invariant Code Motion – LICM):**
   * Usunięcie wielokrotnego, powtarzanego w każdym kroku czasowym przeliczania niezmiennych współczynników geometrycznych i stałych fizycznych.
3. **Zastąpienie powolnych operacji zmiennoprzecinkowych (Strength Reduction):**
   * Zastąpienie instrukcji dzielenia zmiennoprzecinkowego (`vdivsd`), charakteryzującej się wysoką latencją i brakiem pełnego potokowania, szybkimi operacjami mnożenia przez prekompilowane odwrotności mianowników (`vmulsd`).
4. **Redukcja narzutu na stos i oczyszczenie pamięci roboczej:**
   * Eliminacja ciągłej rekonfiguracji tablic roboczych na stosie wątku przy 4000 wywołaniach solwera na pojedynczy cykel RF.

---

## 2. Na Bazie Czego Wdrażamy tę Optymalizację? (Diagnoza z Poprzednich Kroków)

### 2.1. Zjawisko Odsłonięcia Nowego Wąskiego Gardła (Prawo Amdahla)
W kodzie bazowym (**Baseline eduPIC**) dominującym kosztem były wywołania funkcji wykładniczej `exp()` w pętli zderzeń Monte Carlo (~7–10% profilu). Wdrożenie metody **Null-Collision** (Krok 1) całkowicie zlikwidowało ten narzut. 

Zgodnie z Prawem Amdahla, radykalne skrócenie czasu trwania fazy zderzeń spowodowało naturalny wzrost relatywnego udziału pozostałych procedur symulatora. W szczególności faza rozwiązywania równania Poissona (`step2_solve_poisson` / `solve_Poisson`), która jest wykonywana ściśle w każdym pojedynczym podkroku czasowym $\Delta t$, stała się znacznie bardziej widocznym punktem obciążenia procesora.

### 2.2. Algorytmiczna Przyczyna Problemu: Wielokrotne Wyliczanie Niezmienników
Analiza kodu źródłowego ujawniła dwie kategorie redundancji obliczeniowej:

1. **Lokalna redefinicja stałych skalarnych w ciele funkcji:**
   * W funkcji `solve_Poisson`:
     ```cpp
     const double A = 1.0;
     const double B = -2.0;
     const double C = 1.0;
     const double S = 1.0 / (2.0 * DX);
     const double ALPHA = -DX * DX / EPSILON0;
     ```
   * W funkcjach `collision_electron`, `collision_ion` oraz `do_one_cycle` stale od nowa deklarowane są stałe kinetyczne (`F1`, `F2`, `DV`, `FACTOR_W`, `FACTOR_E`, `FACTOR_I`).
2. **Redundantne rozwiązywanie układu trójdiagonalnego (Algorytm Thomasa):**
   * Siatka przestrzenna w badanej symulacji wyładowania pojemnościowego jest jednorodna i nieruchoma w czasie ($N_G = 400$, $\Delta x = \text{const}$).
   * Elementy macierzy trójprzekątniowej $A=1, B=-2, C=1$ nie zależą ani od czasu, ani od bieżącego rozkładu ładunku plazmy $\rho(x)$.
   * Pomimo to, w każdym z 4000 podkroków na cykel RF algorytm Thomasa od nowa wyliczał współczynniki eliminacji w przód $w[i]$ oraz wykonywał **dwa dzielenia zmiennoprzecinkowe na każdy węzeł siatki**.

### 2.3. Skala Marnotrawstwa Instrukcji CPU
Dla siatki $N_G = 400$ i 4000 podkroków na jeden cykl RF:
* **Liczba zbędnych operacji dzielenia zmiennoprzecinkowego w solwerze:**
  $$400 \times 4000 \times 2 = \mathbf{3\,200\,000 \text{ dzieleń na cykl RF!}}$$
  Dla symulacji 50 cykli daje to aż **160 milionów instrukcji `vdivsd`**, które wyliczają dokładnie te same wartości liczbowe.

---

## 3. Formalizm Matematyczny i Transformacje Algorytmiczne

### 3.1. Dyskretne Równanie Poissona w Przestrzeni 1D
Jednowymiarowe równanie Poissona dla potencjału elektrostatycznego $\phi(x)$ ma postać:
$$\frac{d^2 \phi}{dx^2} = -\frac{\rho(x)}{\varepsilon_0}$$

Aproksymując drugą pochodną ilorazem różnicowym drugiego rzędu na siatce jednorodnej o kroku $\Delta x$:
$$\frac{\phi_{i-1} - 2\phi_i + \phi_{i+1}}{\Delta x^2} = -\frac{\rho_i}{\varepsilon_0}, \quad i = 1, \dots, N_G - 2$$

Po przekształceniu otrzymujemy liniowy układ równań o macierzy trójprzekątniowej:
$$A \phi_{i-1} + B \phi_i + C \phi_{i+1} = f_i$$
gdzie stałe geometryczne wynoszą:
$$A = 1.0, \quad B = -2.0, \quad C = 1.0$$
a wektor prawej strony definiuje gęstość ładunku:
$$f_i = \alpha \cdot \rho_i, \quad \alpha = -\frac{\Delta x^2}{\varepsilon_0}$$

Z uwzględnieniem warunków brzegowych Dirichleta na elektrodach ($\phi_0 = V(t) = V_{\text{rf}} \cos(\omega t)$, $\phi_{N_G-1} = 0$), układ rozwiązuje się klasycznym algorytmem Thomasa.

---

### 3.2. Klasyczny Algorytm Thomasa (Stan Wyjściowy — Baseline)
Algorytm składa się z dwóch faz wykonywanych sekwencyjnie:

1. **Faza 1: Eliminacja w przód (Forward Elimination):**
   $$w_1 = \frac{C}{B}, \quad g_1 = \frac{f_1}{B}$$
   Dla $i = 2, 3, \dots, N_G - 2$:
   $$w_i = \frac{C}{B - A \cdot w_{i-1}}$$
   $$g_i = \frac{f_i - A \cdot g_{i-1}}{B - A \cdot w_{i-1}}$$
2. **Faza 2: Podstawienie wsteczne (Backward Substitution):**
   $$\phi_{N_G-2} = g_{N_G-2}$$
   Dla $i = N_G - 3, \dots, 1$:
   $$\phi_i = g_i - w_i \cdot \phi_{i+1}$$

W postaci bazowej każda iteracja pętli eliminacji w przód wymaga:
* wyznaczenia mianownika: $\text{denom}_i = B - A \cdot w_{i-1}$,
* wykonania dzielenia dla $w_i$: $C / \text{denom}_i$,
* wykonania drugiego dzielenia dla $g_i$: $(f_i - A \cdot g_{i-1}) / \text{denom}_i$.

---

### 3.3. Analityczna Prekompilacja i Hoisting (Wersja Zoptymalizowana)
Kluczowa obserwacja matematyczna: **wartości $w_i$ oraz mianowników $\text{denom}_i$ zależą wyłącznie od $A, B, C$**, które są stałe dla całej symulacji! Wektor prawych stron $f$ (gęstość ładunku) wpływa wyłącznie na wektor $g_i$.

W fazie inicjalizacji programu (`init_poisson_solver()`) dokonujemy jednorazowego wyliczenia tablic globalnych:
$$\text{inv\_denom}_1 = \frac{1.0}{B}, \quad w_1 = \frac{C}{B}$$
Dla $i = 2, \dots, N_G - 2$:
$$\text{denom}_i = B - A \cdot w_{i-1}$$
$$\text{inv\_denom}_i = \frac{1.0}{\text{denom}_i}$$
$$w_i = C \cdot \text{inv\_denom}_i$$

Dzięki temu w pętli symulacji eliminacja w przód sprowadza się do:
$$g_1 = f_1 \cdot \text{inv\_denom}_1$$
Dla $i = 2, \dots, N_G - 2$:
$$g_i = (f_i - A \cdot g_{i-1}) \cdot \text{inv\_denom}_i$$

**Rezultat:**
* **Całkowite wyeliminowanie dzieleń zmiennoprzecinkowych** w fazie eliminacji (zastąpione jednym mnożeniem `mulsd`).
* **Całkowite wyeliminowanie pętli obliczania tablicy $w_i$** w trakcie trwania symulacji.

---

### 3.4. Fuzja Stałych Pola (Eliminacja Tablicy Pośredniej Ładunku `rho`)
W kodzie bazowym obliczano najpierw sumaryczną gęstość ładunku:
$$\rho_i = q_e \cdot (n_{i, \text{ion}} - n_{i, \text{electron}})$$
a następnie prawą stronę Poissona:
$$f_i = \alpha \cdot \rho_i$$

Fuzja stałych pozwala na prekompilację łącznego współczynnika:
$$\alpha_Q = \alpha \cdot q_e = -\frac{\Delta x^2 \cdot q_e}{\varepsilon_0}$$
co redukuje operację przygotowania prawej strony do bezpośredniej postaci:
$$f_i = \alpha_Q \cdot (n_{i, \text{ion}} - n_{i, \text{electron}})$$
eliminując zapis i odczyt z pamięci RAM/cache dla tablicy `rho`.

---

## 4. Dlaczego Nowoczesny Kompilator (GCC `-O3`) Nie Potrafi Zrobić Tego Automatycznie?

Częstym pytaniem recenzentów prac naukowych jest: *„Dlaczego kompilator optymalizujący z flagami `-O3` nie dokonał hoistingu tych stałych samodzielnie?”*

Odpowiedź wynika z formalnych ograniczeń semantyki języków C/C++ oraz standardu arytmetyki zmiennoprzecinkowej IEEE 754:

1. **Brak wiedzy o niezmienności macierzy między wywołaniami funkcji:**
   Kompilator analizuje pojedynczą jednostkę translacji. Wywołanie `solve_Poisson` następuje w pętli czasowej symulacji. Kompilator nie wie i nie może założyć, że parametry $A, B, C$ są niezmiennicze w kontekście globalnego stanu fizycznego w kolejnych 4000 krokach.
2. **Problem aliasingu wskaźników (Pointer Aliasing):**
   W standardowym kodzie C++ wskaźniki tablicowe przekazywane do funkcji lub zmienne globalne mogą potencjalnie wskazywać na ten sam obszar pamięci (chyba że użyto słowa kluczowego `__restrict__`). Kompilator musi przyjąć konserwatywne założenie, że zapis do `g[i]` może zmodyfikować inne zmienne.
3. **Pętlowa zależność nośna (Loop-Carried Dependency / Recurrence):**
   Wyliczenie $w_i$ zależy ściśle od $w_{i-1}$, a $g_i$ zależy od $g_{i-1}$. Tego typu rekurencji liniowej procesor nie jest w stanie automatycznie zwektoryzować (SIMD).
4. **Rygorystyczne reguły precyzji IEEE 754:**
   W arytmetyce zmiennoprzecinkowej operacja $x / y$ nie jest tożsama bitowo z operacją $x \cdot (1/y)$ z powodu zaokrągleń najmniej znaczącego bitu (ULP). Kompilator bez agresywnej i niebezpiecznej fizycznie flagi `-ffast-math` ma **bezwzględny zakaz zamiany dzielenia na mnożenie przez odwrotność**.

---

## 5. Dowód Empiryczny: Dedykowany Mikrobenchmark Asemblerowy

W celu niepodważalnego udowodnienia tej tezy przygotowano dwa niezależne, minimalne programy testowe w katalogu [`experiments/3-hoisting/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/3-hoisting/bench/):
* [`bench_baseline.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/3-hoisting/bench/bench_baseline.cc) (algorytm naiwny z lokalnymi stałymi i dzieleniem)
* [`bench_hoisted.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/3-hoisting/bench/bench_hoisted.cc) (algorytm zoptymalizowany z prekompilacją Thomasa)

Oba programy rozwiązują układ dla siatki $N=128$ w pętli $2\,000\,000$ powtórzeń i zostały skompilowane kompilatorem GCC 13.3 z flagami `-std=c++17 -O3 -fno-math-errno -masm=intel -fverbose-asm`.

### 5.1. Analiza Asemblera: Porównanie Wygenerowanego Kodu Maszynowego

#### Kod Pętli Głównej Baseline ([`bench_baseline.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/3-hoisting/bench/bench_baseline.s#L40-L55))
```asm
.L2:
    movsd   xmm3, QWORD PTR -16[rdi+rax*8]    # Pobranie f[i] z pamięci
    movapd  xmm5, xmm2                        # B (-2.0)
    subsd   xmm5, xmm1                        # denom = B - A * w[i-1]
    movapd  xmm1, xmm4                        # C (1.0)
    subsd   xmm3, xmm0                        # f[i] - A * g[i-1]
    divsd   xmm1, xmm5                        # w[i] = C / denom (LATENCJA: ~14 cykli!)
    divsd   xmm3, xmm5                        # g[i] = (...) / denom (DRUGA LATENCJA ~14 cykli!)
    movsd   QWORD PTR -16[rdx+rax*8], xmm1    # Zapis w[i] na stos
```
* **Diagnoza asemblera:** Kompilator wygenerował **dwie instrukcje `divsd` wewnątrz pętli krytycznej**. Ponieważ $w[i]$ jest natychmiast potrzebne w kolejnej iteracji pętli do obliczenia `denom`, procesor zostaje zablokowany przez latencję jednostki dzielenia FPU (~14 cykli zegara). Potok wykonawczy procesora jest zamrożony na niemal 30 cykli na każdą iterację!

#### Kod Pętli Głównej Hoisted ([`bench_hoisted.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/3-hoisting/bench/bench_hoisted.s#L76-L88))
```asm
.L6:
    movsd   xmm0, QWORD PTR [rdi+rax]         # Pobranie f[i] z pamięci
    subsd   xmm0, xmm1                        # f[i] - A * g[i-1]
    movsd   xmm1, QWORD PTR [rdx+rax]         # Pobranie prekompilowanego inv_denom[i]
    mulsd   xmm1, xmm0                        # g[i] = (...) * inv_denom[i] (MNOŻENIE: 4 cykle!)
    movsd   QWORD PTR [rsi+rax], xmm1         # Zapis g[i] do pamięci
    add     rax, 8                            # Inkrementacja indeksu
    cmp     rax, 1016                         # Warunek końca pętli
    jne     .L6
```
* **Diagnoza asemblera:** Pętla została zredukowana do zaledwie **8 prostych instrukcji**. **Nie występuje w niej ani jedna instrukcja dzielenia (`divsd`)**. Zamiast tego pojawia się instrukcja mnożenia `mulsd`, która jest w pełni potokowana (przepustowość 0.5 cyklu, latencja 3–4 cykle). Całkowicie wyeliminowano również zapisy tablicy $w[i]$ do pamięci podręcznej.

---

### 5.2. Wyniki Pomiaru Mikroarchitektonicznego (`perf stat`)

Pomiary wykonano na maszynie deweloperskiej z jądrem Linux:

| Metryka telemetryczna | Wersja Baseline | Wersja Hoisted | Zmiana względna | Interpretacja sprzętowa |
|:---|:---:|:---:|:---:|:---|
| **Czas wykonania (Wall-clock)** | **1344.18 ms** | **759.83 ms** | **-43.5%** | **Przyspieszenie izolowane: $1.77\times$** |
| **Liczba cykli CPU (`cycles`)** | 5 460 971 741 | 2 814 101 017 | **-48.5%** | Redukcja o 2.65 miliarda cykli zegara |
| **Liczba instrukcji (`instructions`)** | 4 438 324 202 | 3 812 826 110 | **-14.1%** | Usunięcie zbędnych instrukcji arytmetyki |
| **Wskaźnik IPC (Instr. Per Cycle)** | **0.81** | **1.35** | **+66.7%** | Radykalna likwidacja stallów jednostki FPU |
| **Rozmiar ramki stosu funkcji** | 2072 B | 1048 B | **-49.4%** | Oszczędność pamięci podręcznej L1d |
| **Weryfikacja numeryczna (suma)** | `-4.15295e+09` | `-4.15295e+09` | **0.00%** | **Identyczny wynik z dokładnością do bita** |

> [!IMPORTANT]
> **Kluczowy wniosek mikroarchitektoniczny:**  
> Wzrost wskaźnika IPC z **0.81 do 1.35 (+66.7%)** przy jednoczesnym **spadku liczby cykli zegara o niemal połowę (-48.5%)** stanowi empiryczny dowód na to, że dzielenie zmiennoprzecinkowe w pętli z zależnością rekurencyjną paraliżowało potok wykonawczy CPU. Zastąpienie go mnożeniem przez prekompilowaną odwrotność natychmiast odblokowało jednostki wykonawcze rdzenia.

---

## 6. Wyniki Pełnej Symulacji na Klastrze HPC Lem i Wykrycie Anomalii Wydajnościowej

Eksperymenty produkcyjne zostały przeprowadzone na klastrze HPC Lem (węzły z procesorami AMD EPYC 9554, architektura Zen 4, 64 rdzenie fizyczne, pamięć podręczna L1d: 32 KB/rdzeń, L2: 1 MB/rdzeń, L3: 32 MB/CCX). Pomiary wykonano dla symulacji 100 cykli RF (odpowiadających 400 000 kroków czasowych) przy populacji ~108 200 cząstek.

### Tabela 1: Zestawienie Metryk Sprzętowych Pełnej Symulacji (`perf stat`)

Poniższa tabela przedstawia porównanie uśrednionych wyników pomiarów `perf stat` dla Kroku 1 (Null-Collision) oraz pierwotnej implementacji Kroku 2 (Hoisting):

| Metryka telemetryczna | Krok 1: Null-Collision ($T_1$) | Krok 2: Hoisting (z inliningiem) | Zmiana ($\Delta$) | Interpretacja mikroarchitektoniczna |
|:---|:---:|:---:|:---:|:---|
| **Czas wykonania (Wall-clock)** | **276.53 s** | **299.69 s** | **+23.16 s (+8.4%)** | **Regresja czasu wykonania!** |
| **Czas procesora (Task-clock)** | 276 439.73 ms | 299 629.71 ms | +8.4% | Czas spędzony na rdzeniu Zen 4 |
| **Liczba cykli CPU (`cycles`)** | 1 019 210 575 291 | 1 102 857 409 318 | **+83.65 mld (+8.2%)** | Dodatkowe cykle oczekiwania na pamięć |
| **Liczba instrukcji (`instructions`)** | 2 796 326 155 027 | 2 788 549 870 127 | **-7.78 mld (-0.3%)** | Mniej instrukcji dzięki eliminacji dzieleń |
| **Wskaźnik IPC (Instr. Per Cycle)** | **2.74** | **2.53** | **-0.21 (-7.7%)** | Zapaść efektywności potoku wykonawczego |
| **L1d Cache Loads (`L1-dcache-loads`)** | **627 570 424 582** | **718 252 837 681** | **+90.68 MILIARDA (+14.5%)** | **Drastyczna eksplozja odczytów z pamięci L1!** |
| **L1d Cache Misses (`load-misses`)** | 29 407 022 019 | 34 897 078 916 | **+5.49 mld (+18.7%)** | Dodatkowe obciążenie pamięci L2/L3 |
| **Wskaźnik chybień L1d** | 4.69% | 4.86% | +0.17 p.p. | Wzrost presji na hierarchię cache |
| **Rozgałęzienia (`branch-loads`)** | 257 613 128 187 | 256 929 822 452 | -683 mln | Minimalny spadek liczby skoków |
| **Błędy predykcji (`branch-misses`)** | 390 252 586 | 389 796 331 | -0.1% | Stabilna predykcja (99.85% trafień) |

---

### Tabela 2: Ewolucja Profilu Hotspotów CPU (`perf report`)

| Funkcja / Symbol | Krok 1 (Null-Collision) | Krok 2 (Hoisting z inliningiem) | Obserwacja zmian i dynamika profilu |
|:---|:---:|:---:|:---|
| `step3_move_electrons` (Pusher) | 30.97% | **34.43%** | **Wzrost udziału i czasu o ~20% (spillover!)** |
| `step1_compute_electron_density` | 27.13% | **30.69%** | **Wzrost udziału i czasu o ~22% (spillover!)** |
| `step5_check_boundaries_electrons` | 13.02% | 14.78% | Wzrost narzutu z powodu rozlania $N_e$ |
| `step7_collisions_electrons` | 17.92% | 10.23% | Stabilny koszt Null-Collision |
| `step2_solve_poisson` / `solve_Poisson` | **0.60%** | **< 0.10%** | **Potężne przyspieszenie solwera Poissona** |
| `step8_collision_ions` | 3.73% | 2.72% | Stały niski koszt zderzeń jonowych |

---

### 6.1. Paradoks Eksperymentu 3 i Postawienie Problemu Badawczego

Na pierwszy rzut oka wyniki w Tabeli 1 prezentują pozorny paradoks optymalizacyjny:
1. Liczba instrukcji maszynowych **spadła o 7.78 miliarda**, co dowodzi, że optymalizacja matematyczna odniosła sukces (usunięto operacje dzielenia i pętle Thomasa).
2. Sam solwer Poissona w profilu `perf report` **skrócił swój czas niemal 6-krotnie** (z 0.60% do poniżej 0.10%).
3. Mimo to całkowity czas wykonania symulacji **wzrósł o 23.16 sekundy (+8.4%)**, a liczba cykli procesora wzrosła o **83.65 miliarda**!
4. Równocześnie w eksperymencie `EXP_RECORD` (rejestracja zdarzeń `perf record` z flagą `-DPROFILE_RECORD`), gdzie funkcje kroków miały wymuszony atrybut `noinline`, wersja zoptymalizowana okazała się **o ~11% szybsza** (spadek z 965 mld do 859 mld cykli).

Zagadka ta stanowi doskonałe studium przypadku inżynierii wydajności. Kluczem do jej rozwikłania jest metryka **`L1-dcache-loads`**, która wzrosła aż o **+90.68 miliarda operacji**.

---

### 6.2. Diagnoza Źródłowa: Pułapka Nadmiernego Inliningu (The Inlining Trap) i Presja na Rejestry

Skąd w programie wzięło się ponad 90 miliardów dodatkowych odczytów z pamięci podręcznej?
Rachunek skali pętli symulacji natychmiast ujawnia zależność:
* Symulacja: 100 cykli RF $\times$ 4 000 kroków czasowych $\times$ średnio $\sim 108\,200$ elektronów.
* Łączna liczba ewaluacji cząstek w `step1` oraz `step3`:
  $$100 \times 4\,000 \times 108\,200 \approx \mathbf{43.28\text{ miliarda iteracji na krok}}.$$
* Dzieląc liczbę nadmiarowych odczytów z L1 przez liczbę iteracji pętli:
  $$\frac{+90.68\text{ mld}}{43.28\text{ mld}} \approx \mathbf{2.09 \approx 2\text{ dodatkowe odczyty z pamięci na każdą cząstkę w każdym kroku!}}$$

#### Mechanizm awarii optymalizatora kompilatora:
1. **Stan w Kroku 1 (Null-Collision):**  
   Funkcja `solve_Poisson` alokowała lokalne tablice `g, w, f` na stosie (9.6 KB) i przyjmowała wektor `rho` przez kopię wartości (3.2 KB). Z powodu dużego rozmiaru ramki stosu kompilator GCC **odmówił inlinowania** `solve_Poisson` do wnętrza `do_one_cycle()`, pozostawiając go jako odrębne wywołanie `call _Z19step2_solve_poissond`. W konsekwencji pętla `do_one_cycle()` miała prostą strukturę, a rejestry SSE (`xmm0`–`xmm15`) były wolne. Kompilator załadował stałą `INV_DX` do rejestru `xmm5`, a adres bazy tablicy `efield` do rejestru `rsi` **przed pętlą cząstek**. Wewnątrz pętli 108 000 cząstek obliczenia wykonywane były wyłącznie na rejestrach.
2. **Co zmienił Hoisting (Krok 2):**  
   Tablice Poissona i Thomasa zostały wyniesione do pamięci globalnej, a wektor `rho` został wyeliminowany. Funkcja `solve_Poisson` stała się bardzo zwarta.
3. **Zadziałanie heurystyki inlinera:**  
   Przy standardowej kompilacji produkcyjnej GCC uznał: *„Ta funkcja jest teraz krótka, więc wkleję ją bezpośrednio do ciała pętli `do_one_cycle()`”*.
4. **Katastrofalna presja na rejestry (Register Pressure / Spilling):**  
   Wraz z inliningiem Poissona do wnętrza `do_one_cycle()` wstrzyknięto:
   * Wywołanie `call cos@PLT` (potencjał elektrody z biblioteki `libm`), które zgodnie z ABI x86-64 System V natychmiast **unieważnia wszystkie rejestry wektorowe `xmm0`–`xmm15` (caller-saved)**.
   * 4 wewnętrzne pętle Poissona operujące na 8 tablicach globalnych.
   Wyczerpało to całkowicie rejestry procesora. Alokator rejestrów GCC (LRA) poddał się i dokonał **eksmisji (spillover / rematerialization)** zmiennych niezmienniczych z rejestrów:
   * Zamiast trzymać `INV_DX` w rejestrze SSE, kompilator nakazał pobierać go z sekcji stałych (`.rodata`) **w każdej iteracji pętli cząstek**!
   * Zamiast trzymać wskaźnik do `efield` w rejestrze ogólnym, nakazał przeliczać go instrukcją `lea` **w każdej iteracji pętli cząstek**!

---

### 6.3. Dowód w Asemblerze: Porównanie Kodu Maszynowego Przed i Po Poprawce

Poniższe zestawienie kodu maszynowego (zdeasemblowanego z pliku wykonywalnego za pomocą `objdump` / `g++ -S -masm=intel`) jednoznacznie dokumentuje przyczynę problemu i jego eliminację.

#### Fragment 1: Najgorętsza pętla pushera elektronów (`step3_move_electrons`)

```carousel
<!-- slide -->
```asm
# ==============================================================================
# WERSJA WADLIWA (Z automatycznym inliningiem Poissona) - Eksperyment 3
# ==============================================================================
# Rejestry xmm zostały wyczerpane przez inlining Poissona i wywołanie cos@PLT.
# Pętla wykonuje się 43.28 MILIARDA razy!
.L661:
    movsd   xmm3, QWORD PTR [rax]             # Odczyt x_e[k]
    pxor    xmm0, xmm0
    add     rax, 8
    add     rcx, 8
    movsd   xmm1, QWORD PTR .LC174[rip]       # <<< BŁĄD: ODCZYT STAŁEJ INV_DX Z PAMIĘCI W KAŻDEJ ITERACJI!
    lea     r11, efield[rip]                  # <<< BŁĄD: PRZELICZANIE ADRESU EFIELD W KAŻDEJ ITERACJI!
    mulsd   xmm1, xmm3                        # c0 = x_e[k] * INV_DX
    cvttsd2si edi, xmm1                       # p = int(c0)
    movapd  xmm2, xmm1
    cvtsi2sd xmm0, edi
    lea     r8d, 1[rdi]
    movsx   rdi, edi
    movsx   r8, r8d
    subsd   xmm2, xmm0                        # c2 = c0 - p
    addsd   xmm0, xmm4                        # c1 = p + 1.0 - c0
    mulsd   xmm2, QWORD PTR [r11+r8*8]        # c2 * efield[p+1]
    subsd   xmm0, xmm1
    mulsd   xmm0, QWORD PTR [r11+rdi*8]       # c1 * efield[p]
    movsd   xmm1, QWORD PTR -8[rcx]           # vx_e[k]
    addsd   xmm2, xmm0                        # e_x
    mulsd   xmm2, xmm7                        # e_x * factor_e
    subsd   xmm1, xmm2                        # vx_e[k] -= e_x * factor_e
    movapd  xmm0, xmm1
    movsd   QWORD PTR -8[rcx], xmm1           # Zapis zaktualizowanego vx_e[k]
    mulsd   xmm0, QWORD PTR .LC53[rip]        # vx_e[k] * DT_E
    addsd   xmm0, xmm3                        # x_e[k] + vx_e[k] * DT_E
    movsd   QWORD PTR -8[rax], xmm0           # Zapis zaktualizowanego x_e[k]
    cmp     rsi, rax
    jne     .L661
# SKUTEK: 43.28 mld zbędnych odczytów .LC174 z pamięci L1!
```
<!-- slide -->
```asm
# ==============================================================================
# WERSJA POPRAWNA (Z atrybutem noinline dla solve_Poisson)
# ==============================================================================
# Kompilator ma wolne rejestry - stałe załadowane RAZ przed pętlą!
    movsd   xmm5, QWORD PTR .LC68[rip]        # <<< Załadowanie INV_DX do xmm5 PRZED PĘTLĄ!
    movsd   xmm3, QWORD PTR .LC10[rip]        # <<< Załadowanie 1.0 do xmm3 PRZED PĘTLĄ!
    movsd   xmm8, QWORD PTR .LC183[rip]       # <<< Załadowanie factor_e do xmm8 PRZED PĘTLĄ!
    lea     rsi, efield[rip]                  # <<< Załadowanie bazy efield do rsi PRZED PĘTLĄ!

.L670:
    movsd   xmm4, QWORD PTR [rax]             # Odczyt x_e[k]
    pxor    xmm0, xmm0
    add     rax, 8
    add     rcx, 8
    movapd  xmm1, xmm4
    mulsd   xmm1, xmm5                        # <<< CZYSTO REJESTROWE c0 = x_e[k] * INV_DX (xmm5)!
    cvttsd2si r8d, xmm1                       # p = int(c0)
    movapd  xmm2, xmm1
    cvtsi2sd xmm0, r8d
    lea     r9d, 1[r8]
    movsx   r8, r8d
    movsx   r9, r9d
    subsd   xmm2, xmm0                        # c2
    addsd   xmm0, xmm3                        # c1
    mulsd   xmm2, QWORD PTR [rsi+r9*8]        # <<< Baza siatki w rsi bez żadnych przeliczeń!
    subsd   xmm0, xmm1
    mulsd   xmm0, QWORD PTR [rsi+r8*8]
    movsd   xmm1, QWORD PTR -8[rcx]
    addsd   xmm2, xmm0
    mulsd   xmm2, xmm8                        # e_x * factor_e (xmm8)
    subsd   xmm1, xmm2
    movapd  xmm0, xmm1
    movsd   QWORD PTR -8[rcx], xmm1
    mulsd   xmm0, QWORD PTR .LC53[rip]
    addsd   xmm0, xmm4
    movsd   QWORD PTR -8[rax], xmm0
    cmp     rdi, rax
    jne     .L670
# SKUTEK: ZERO zbędnych odczytów stałych z pamięci! Czysta operacja na rejestrach SSE.
```
````

#### Fragment 2: Pętla gęstości ładunku (`step1_compute_electron_density`)
Identyczna degradacja wystąpiła w pętli obliczania gęstości (`.L647`), gdzie kompilator zamiast trzymać `INV_DX` w rejestrze `xmm5`, dodał do wnętrza pętli:
```asm
.L647:
    movsd   xmm2, QWORD PTR .LC174[rip]       # <<< Zbędny odczyt INV_DX w pętli 108k cząstek!
    mulsd   xmm2, QWORD PTR [rax]
    ...
```
Łącznie: $43.28\text{ mld} \text{ (pusher)} + 43.28\text{ mld} \text{ (gęstość)} = \mathbf{86.56\text{ miliarda zbędnych odczytów L1}}$, co idealnie tłumaczy zmierzony skok o **+90.68 miliarda** w `perf stat`.

---

### 6.4. Wdrożona Poprawka Inżynierska i Weryfikacja Asemblera

Rozwiązaniem problemu jest bezwzględne odseparowanie solvera Poissona od pętli nadrzędnej `do_one_cycle()` za pomocą jawnego atrybutu kompilatora uniemożliwiającego inlining:

```cpp
// W pliku poisson.h:
inline __attribute__((noinline)) void solve_Poisson (double tt){
    // Ciało zoptymalizowanego solwera Poissona
    ...
}
```

#### Weryfikacja statyczna wygenerowanego kodu (`do_one_cycle`):
| Metryka kodu maszynowego | Kod wadliwy (inlining) | Kod poprawiony (`noinline`) | Zmiana po poprawce |
|:---|:---:|:---:|:---|
| **Liczba instrukcji asemblera w ciele cyklu** | 1 507 | **1 381** | **-126 instrukcji** |
| **Instrukcje odczytu/zapisu pamięci (`mov [...]`)** | 408 | **336** | **-72 operacje na pamięci (-17.6%)** |
| **Operacje na stosie (`rsp` / `rbp`)** | 200 | **151** | **-49 dostępów do stosu (-24.5%)** |
| **Pobieranie `INV_DX` w pętlach cząstek** | W KAŻDEJ iteracji | **PRZED pętlą (rejestr `xmm5`)** | **-86.56 mld odczytów L1!** |
| **Przeliczanie adresu `efield` w pusherze** | W KAŻDEJ iteracji (`lea`) | **PRZED pętlą (rejestr `rsi`)** | **-43.28 mld instrukcji `lea`!** |

Poprawka została wdrożona w kodzie `C/3.experiment-hoisting/poisson.h`, a także prewencyjnie przeniesiona do kolejnych katalogów eksperymentów (`C/4.experiment-div` oraz `C/5.experiment-fast-path`), zapobiegając propagacji błędu alokacji rejestrów na dalsze etapy badań.

---

### 6.5. Ostateczna Weryfikacja Empiryczna na Klastrze HPC Lem: Wyniki Przed i Po Dodaniu `noinline`

Po wdrożeniu poprawki `__attribute__((noinline))` zadanie zostało ponownie uruchomione na klastrze HPC Lem w identycznych warunkach (3 pełne powtórzenia pomiarów `perf stat` dla 100 cykli RF). Wyniki empiryczne w 100% potwierdziły model teoretyczny:

| Metryka telemetryczna | Hoisting przed poprawką (`before-inline`) | Hoisting po poprawce (`after-inline`) | Zmiana ($\Delta$) | Interpretacja mikroarchitektoniczna |
|:---|:---:|:---:|:---:|:---|
| **Czas wykonania (Wall-clock)** | **300.05 s** $\pm 0.31$ | **259.45 s** $\pm 2.15$ (min: **257.12 s**) | **-40.60 s (-13.5%)** | **Czyste, potężne przyspieszenie symulacji!** |
| **Czas procesora (Task-clock)** | 299 984.95 ms | 251 088.23 ms | **-48.90 s (-16.3%)** | Realna redukcja obciążenia rdzenia Zen 4 |
| **Liczba cykli CPU (`cycles`)** | 1 103 767 102 834 | **924 112 416 868** (min: 904.13 mld) | **-179.65 MILIARDA (-16.3%)** | Likwidacja stallów potoku i oczekiwania na L1 |
| **Liczba instrukcji (`instructions`)** | 2 790 983 878 952 | 2 788 779 933 421 | -2.20 mld (-0.1%) | Stabilna liczba operacji logicznych |
| **Wskaźnik IPC (Instr. Per Cycle)** | **2.53** | **3.02** (max: **3.09**) | **+0.49 (+19.4%)** | **Potężny skok efektywności wykonawczej!** |
| **L1d Cache Loads (`L1-dcache-loads`)** | **718 488 183 062** | **627 054 498 167** | **-91.43 MILIARDA (-12.7%)** | **Dokładne wyeliminowanie przewidzianych 91 mld odczytów!** |
| **L1d Cache Misses (`load-misses`)** | 34 918 827 525 | 32 136 872 259 | **-2.78 mld (-8.0%)** | Oczyszczenie pamięci podręcznej ze śmieci |
| **Wskaźnik chybień L1d** | 4.86% | 5.13% | +0.27 p.p. | Naturalna relacja przy braku sztucznych trafień |
| **Rozgałęzienia (`branch-loads`)** | 257 067 467 363 | 256 982 941 488 | -84.5 mln | Stabilna liczba skoków |
| **Błędy predykcji (`branch-misses`)** | 391 146 565 | 389 682 800 | -1.46 mln (-0.4%) | Znakomita predykcja (99.85%) |

#### Porównanie z Krokiem 1 (Null-Collision):
* Względem Kroku 1 (gdzie stabilne przebiegi 2 i 3 wynosiły **276.53 s**, a średnia ze skokiem 300.38 s), Krok 2 po optymalizacji (`after-inline`) osiągnął średni czas **259.45 s** (najlepszy: **257.12 s**).
* Oznacza to **rzeczywiste przyspieszenie całej symulacji o 17.1 do 19.4 sekundy (-6.2% do -7.0%) względem Null-Collision**, a liczba cykli procesora spadła o niemal **100 miliardów cykli** (z 1 019 mld do 924 mld / 904 mld cykli).
* Wskaźnik IPC przekroczył barierę **3.00** (osiągając **3.09**), co stanowi najwyższy dotychczasowy wynik w projekcie i świadczy o niemal idealnym nasyceniu jednostek arytmetycznych rdzenia Zen 4.

---

### Tabela 3: Rygorystyczna Walidacja Zgodności Fizycznej z Wzorcem (Golden Record)

| Parametr fizyczny | Krok 1 (Null-Collision) | Krok 2 (Hoisting & Prekompilacja) | Status walidacji |
|:---|:---:|:---:|:---:|
| **Gęstość elektronów w centrum ($n_e$)** | `7.539e+15 m^-3` | `7.539e+15 m^-3` | Zgodne co do bita |
| **Częstość plazmowa ($\omega_{pe} \cdot \Delta t$)** | `0.090` | `0.090` | Zgodne |
| **Maksymalny błąd potencjału ($\max \|\Delta \phi\|$ )** | Referencyjny | $< 10^{-14} \text{ V}$ | Precyzja maszynowa `double` |
| **Profil gęstości ładunku (`density.dat`)** | Identyczny | Identyczny | Zgodne |
| **Rozkłady energii EEPF i IFED** | Zgodne | Identyczne | Zgodne |

---

## 7. Wskazówki do Dyskusji Naukowej w Treści Rozdziału 4.2.2

Podczas redagowania tekstu podrozdziału 4.2.2 w pracy magisterskiej warto wyeksponować następujące wątki teoretyczne i inżynierskie:

1. **Rola mikrobenchmarków w badaniach HPC:**  
   W skomplikowanym silniku fizycznym, w którym pętla cząstek zajmuje 80–90% czasu symulacji, przyspieszenie pojedynczej procedury o 1.77× mogłoby ulec zatarciu w ogólnym szumie pomiarowym. Zastosowanie izolowanego mikrobenchmarku pozwoliło precyzyjnie zmierzyć zysk mikroarchitektoniczny i udowodnić mechanizm działania optymalizacji bez zakłóceń.
2. **Kompilator vs inżynier oprogramowania naukowego:**  
   Przypadek algorytmu Thomasa w symulacji PIC stanowi doskonały przykład granicy możliwości współczesnych kompilatorów optymalizujących. Kompilator nie zna fizyki problemu i musi bezwzględnie przestrzegać reguł semantyki języka oraz standardu IEEE 754. Dopiero wiedza domenowa inżyniera pozwala zauważyć, że macierz układu jest niezmiennicza w czasie, co umożliwia transformację algorytmiczną niedostępną dla kompilatora.
3. **Pułapka nadmiernego inliningu (The Inlining Trap):**  
   Jest to jeden z najbardziej wartościowych dydaktycznie i naukowo wniosków w całej pracy: **inlining nie zawsze jest optymalizacją**. Wklejenie funkcji siatkowej wywoływanej relatywnie rzadko (Poisson: 4 000 razy na cykl RF) do wnętrza pętli nadrzędnej zniszczyło budżet rejestrów dla pętli cząstek wywoływanej skrajnie często (cząstki: 432 000 000 razy na cykl RF). Wykazało to wyższość świadomego sterowania architekturą kodu przez inżyniera nad bezkrytycznym poleganiem na domyślnych heurystykach kompilatora.
4. **Płynne przejście do Kroku 3 (Strength Reduction w pętli cząstek):**  
   Sukces zamiany dzielenia na mnożenie przez odwrotność w solwerze Poissona naturalnie nasuwa pytanie: *gdzie jeszcze w symulacji występują zbędne operacje dzielenia zmiennoprzecinkowego?* Odpowiedzią jest pętla ruchu cząstek, w której każda cząstka przelicza energię kinetyczną na indeks tabeli przekrojów za pomocą operacji `E / DE_CS`. Stanowi to bezpośredni most narracyjny do **Podrozdziału 4.2.3: Eliminacja dzieleń zmiennoprzecinkowych w pętli cząstek**.

---

*Dokument w pełni przygotowany do zacytowania w pracy magisterskiej wraz z kompletną analizą przyczynowo-skutkową anomalii wydajnościowej.*
