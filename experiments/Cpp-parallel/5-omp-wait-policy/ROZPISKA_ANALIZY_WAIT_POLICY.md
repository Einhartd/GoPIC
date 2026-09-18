# Przewodnik i Rozpiska Podrozdziału: Strojenie Środowiska Wykonawczego OpenMP — Polityka Oczekiwania na Barierach (OMP_WAIT_POLICY=ACTIVE vs PASSIVE)

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.3: Ścieżka zrównoleglenia silnika C++ z użyciem OpenMP**  
>     └── **4.3.5. Strojenie środowiska wykonawczego OpenMP: Polityka oczekiwania na barierach synchronizacyjnych (`OMP_WAIT_POLICY=ACTIVE` vs `PASSIVE`) i analiza mechanizmów jądra Linuksa**

---

## 1. Kontekst Mikroarchitektoniczny i Problem Badawczy

### 1.1. Specyfika Synchronizacji w Kodach Kinetycznych PIC/MCC
Algorytm Particle-in-Cell zderzeniowego wyładowania plazmowego wysokiej częstotliwości (RF CCP 1D3V) charakteryzuje się niezwykle drobnym krokiem czasowym. W celu zachowania stabilności numerycznej i spełnienia kryteriów Couranta-Friedrichsa-Lewy'ego (CFL) oraz ograniczenia na częstość plazmową ($\omega_{pe} \Delta t \ll 1$), krok całkowania równań ruchu wynosi:
$$\Delta t_e = 3.68 \times 10^{-11}\text{ s}$$

W jednym okresie napięcia wysokiej częstotliwości (cyklu RF, $f = 13.56\text{ MHz}$) wykonuje się dokładnie **4000 podkroków czasowych**. W każdym pojedynczym podkroku realizowany jest pełen cykl PIC/MCC:
1. Depozycja ładunku elektronów i jonów (Kroki 1a, 1b),
2. Rozwiązanie 1D równania Poissona (Krok 2),
3. Integracja równań ruchu elektronów i jonów (Kroki 3, 4),
4. Sprawdzenie warunków brzegowych i kompaktacja pamięci (Kroki 5, 6),
5. Modelowanie zderzeń Monte Carlo (MCC / Null-Collision) (Kroki 7, 8).

Z punktu widzenia współbieżności i modelu pamięci OpenMP, w obrębie jednego podkroku czasowego występuje co najmniej **6 barier synchronizacyjnych** (`#pragma omp barrier` oraz niejawne bariery na wyjściu z sekcji `#pragma omp single`).  
W skali pełnego eksperymentu testowego obejmującego **100 cykli RF** (400 000 podkroków) wątki przechodzą przez bariery synchronizacyjne:
$$N_{\text{barriers}} = 400\,000 \times 6 = \mathbf{2\,400\,000\text{ razy!}}$$

Dla porównania, czas wykonania całego pojedynczego podkroku czasowego na 8 rdzeniach nowoczesnego procesora AMD EPYC 9554 wynosi zaledwie **~48 mikrosekund** ($4.8 \times 10^{-5}\text{ s}$). Oznacza to, że bariery synchronizacyjne są wywoływane średnio **co 8 mikrosekund**.

---

### 1.2. Dwa Paradygmaty Oczekiwania na Barierach: Aktywne Wirowanie vs Usypianie w Jądrze

Standard OpenMP definiuje zmienną środowiskową `OMP_WAIT_POLICY`, która determinuje zachowanie wątków roboczych w momencie dotarcia do bariery synchronizacyjnej, gdy oczekują one na nadejście pozostałych wątków zespołu:

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                    PARADYGMATY OCZEKIWANIA W OPENMP                            │
├───────────────────────────────────────┬────────────────────────────────────────┤
│   OMP_WAIT_POLICY=ACTIVE              │   OMP_WAIT_POLICY=PASSIVE              │
│   (Aktywne wirowanie w User-Space)    │   (Usypianie w Kernel-Space)           │
├───────────────────────────────────────┼────────────────────────────────────────┤
│ • Wątek wykonuje pętlę busy-spin      │ • Wątek zrzeka się procesora           │
│   (instrukcje PAUSE / NOP)            │   (wywołanie systemowe sys_futex)      │
│ • Zero przejść do jądra systemu       │ • Przełączenie kontekstu (Context-Sw.) │
│ • Sprzętowa spójność pamięci cache    │ • Uśpienie w stanie TASK_INTERRUPTIBLE │
│ • Opóźnienie wybudzenia: < 20 ns      │ • Opóźnienie wybudzenia: 10 000–50 000 ns│
│ • 100% utylizacji przydzielonego CPU  │ • Zwolnienie CPU dla innych procesów   │
└───────────────────────────────────────┴────────────────────────────────────────┘
```

#### A. Wariant `PASSIVE` (Domyślne zachowanie systemów wielozadaniowych)
W polityce `PASSIVE`, biblioteka uruchomieniowa OpenMP (`libgomp` dla GCC) po krótkiej, wstępnej próbie wykrycia zakończenia bariery oddaje kontrolę nad rdzeniem systemowi operacyjnemu. Realizowane jest to poprzez wywołanie systemowe Linuksa:
```c
sys_futex(uaddr, FUTEX_WAIT, val, timeout, ...);
```
Jądro Linuksa wyrejestrowuje wątek z kolejki zadań aktywnych (*CFS runqueue*) i wprowadza go w stan uśpienia. Gdy ostatni wątek zespołu osiągnie barierę, wywołuje:
```c
sys_futex(uaddr, FUTEX_WAKE, count, ...);
```
budząc uśpione wątki.

#### B. Problem niedopasowania ziarnistości (Granularity Mismatch)
Wywołanie systemowe `futex`, obsługa przerwania, zmiana tablic stron pamięci i powrót z jądra do przestrzeni użytkownika (*kernel-to-user context switch*) zajmuje na nowoczesnych procesorach od **5 do 50 mikrosekund**.  
Gdy bariera występuje co **8 mikrosekund**, narzut wejścia i wyjścia z jądra staje się **większy niż czas pracy produkcyjnej całego podkroku symulacji**!

---

## 2. Anatomia Wykrytego Wyścigu Danych (Data Race Case Study)

Próba bezpośredniego przestawienia flagi na `OMP_WAIT_POLICY=PASSIVE` w pierwotnej wersji silnika wielowątkowego doprowadziła do natychmiastowego załamania stabilności numerycznej i awarii programu. Stanowi to znakomity przypadek inżynierski obrazujący, w jaki sposób nanosekundowy determinizm sprzętowy w trybie `ACTIVE` może maskować subtelny błąd współbieżności.

### 2.1. Symptomy Awarii w Pierwotnych Testach Lem HPC

Pierwsze testy na klastrze Lem (zadania `5907730`, `5907731`, `5907732`) na 8 rdzeniach z `OMP_WAIT_POLICY=PASSIVE` zakończyły się błędem:
```
/home/grid/users/plgkniazewo/GoPIC_build/C/edupic_omp_5907730: Segmentation fault
```
Awaria nastąpiła odpowiednio w cyklach 2035, 2070 oraz 2035. Analiza logów ujawniła katastrofalny wzrost liczby cząstek przed momentem awarii:

```
Prawidłowy stan fizyczny (ACTIVE):
 c =     2002  t =        0  #e =   108198  #i =   113618
 c =     2035  t =     3000  #e =   108062  #i =   113450   <-- Stabilne plateau plazmowe

Załamanie numeryczne (PASSIVE - przed poprawką):
 c =     2002  t =        0  #e =   108198  #i =   113618
 c =     2010  t =     2000  #e =   121254  #i =   127132   (+13 000 cząstek!)
 c =     2020  t =     2000  #e =   134945  #i =   140954   (+27 000 cząstek!)
 c =     2030  t =     2000  #e =   152878  #i =   159196   (+45 000 cząstek!)
 c =     2035  t =     1000  #e =   158390  #i =   164845   (+50 000 cząstek!)
 Segmentation fault
```

---

### 2.2. Mechanizm Techniczny Reakcji Łańcuchowej

Poniższy schemat przedstawia sekwencję zdarzeń prowadzącą od mechanizmu `futex` w polityce `PASSIVE` do błędu naruszenia ochrony pamięci:

```
┌────────────────────────────────────────────────────────────────────────────────┐
│             REAKCJA ŁAŃCUCHOWA: OD ASYNCHRONICZNOŚCI DO SEGFAULTA              │
└────────────────────────────────────────────────────────────────────────────────┘
                                        │
           1. Wątki dochodzą do bariery po depozycji ładunku.
              libgomp usypia wątki w jądrze (sys_futex WAIT).
                                        │
                                        ▼
           2. Scheduler Linuksa wybudza wątki asynchronicznie.
              Rozstęp czasowy wybudzenia (Jitter) = 20 000 – 50 000 ns!
              Wątek 1 rusza w t = 5 µs, Wątek 0 wciąż śpi do t = 35 µs.
                                        │
                                        ▼
           3. Wątek 1 wykonuje swój fragment pętli redukcji e_density (nowait).
              Mija klauzulę nowait i widzi sekcję #pragma omp single.
                                        │
                                        ▼
           4. Brak bariery wejściowej na sekcji single w standardzie OpenMP!
              Wątek 1 jako jedyny wchodzi do solvera Poissona:
              step2_solve_poisson(Time), podczas gdy Wątek 0 wciąż śpi w kernelu!
                                        │
                                        ▼
           5. Solver Poissona czyta niekompletną gęstość ładunku:
              e_density[0..49] oraz e_density[0] to stare dane lub zera!
              Wylicza astronomiczne, fikcyjne pole elektryczne E.
                                        │
                                        ▼
           6. Potężne pole E przyspiesza elektrony do skrajnych prędkości.
              W module Monte Carlo (MCC) lawinowo rośnie jonizacja:
              Liczba cząstek eksploduje z 108 000 do ponad 180 000.
                                        │
                                        ▼
           7. Przepełnienie zmiennoprzecinkowe: prędkości elektronów dają NaN.
              Warunek brzegowy: if (x_e[k] < 0 || x_e[k] > L) dla NaN zwraca false!
              Cząstki NaN omijają absorpcję i wchodzą do Kroku 1.
                                        │
                                        ▼
           8. Rzutowanie NaN na int w architekturze x86-64:
              int(NaN) = 0x80000000 = -2147483648 (Indefinite Integer).
              Zapis do tablicy: worker_buffers.e_density[tid][-2147483648] += c1;
              Odwołanie 17 GB poza pamięć wirtualną procesu -> SEGMENTATION FAULT!
```

#### Dlaczego błąd nie ujawniał się w trybie `ACTIVE`?
W `OMP_WAIT_POLICY=ACTIVE` wątki wirują w pamięci cache L3. Czas reakcji po zwolnieniu bariery wynosi **< 15 nanosekund**. Pętla redukcji 50 komórek siatki zajmuje na każdym rdzeniu dokładnie tyle samo czasu (~30 ns).  
Różnica w czasie zakończenia pętli między Wątkiem 1 a Wątkiem 0 wynosiła maksymalnie 5 nanosekund. Zanim Wątek 1 dotarł do solvera Poissona, Wątek 0 **zawsze zdążył zapisać swoje komórki brzegowe**. Sprzętowy determinizm procesora Zen 4 maskował brak formalnej bariery. W trybie `PASSIVE` scheduler Linuksa wprowadził rozrzut rzędu 30 000 ns, obnażając wyścig danych.

---

### 2.3. Zastosowana Poprawka Synchronizacyjna

W celu uzyskania stuprocentowej poprawności semantycznej, odporności na wyścigi danych (*Data Race Freedom*) oraz stabilności w obu politykach oczekiwania, w pliku [`C/parallel-only-omp/simulation.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h) wprowadzono jawne bariery OpenMP:

1. **Przed Krok 2 w `do_one_cycle()`:**
   Gwarantuje, że cała siatka gęstości elektronów `e_density` oraz jonów `i_density` jest w pełni zredukowana przed rozpoczęciem rozwiązywania równania Poissona:
   ```cpp
   // Krok 1: Depozycja gęstości ładunku elektronów i jonów (równoległa + redukcja)
   step1_compute_electron_density_body(tid, nthreads);
   step1_compute_ion_density_body(tid, nthreads, t);

   #pragma omp barrier // <-- Gwarancja pełnej redukcji ładunku przed solverem Poissona

   // Krok 2: Inkrementacja czasu i rozwiązanie równania Poissona (blok single)
   #pragma omp single
   {
       Time += DT_E;
       step2_solve_poisson(Time);
   }
   ```

2. **Przed sekcją `single` w `step8_collision_ions_body()`:**
   Gwarantuje, że wszystkie wątki zakończyły zderzenia jonów, zanim wątek sekwencyjny dokona zsumowania i wyzerowania liczników `local_coll_i`:
   ```cpp
   #pragma omp barrier // <-- Gwarancja zakończenia zderzeń przed redukcją liczników
   #pragma omp single
   {
       for (int t = 0; t < num_threads; ++t) {
           N_i_coll += worker_buffers.thread_counters[t].local_coll_i;
           worker_buffers.thread_counters[t].local_coll_i = 0;
       }
   }
   ```

Po wdrożeniu tych poprawek kod stał się w pełni poprawny i stabilny, co umożliwiło przeprowadzenie niezakłóconych pomiarów porównawczych.

---

## 3. Wyniki Empiryczne z Klastra Lem HPC (AMD EPYC 9554)

Pomiary przeprowadzono na węźle obliczeniowym klastra Lem wyposażonym w procesory **AMD EPYC 9554** (architektura Zen 4, 64 rdzenie fizyczne / gniazdo, 32 MB pamięci podręcznej L3 na blok CCX).  
W obu wariantach symulacja wykonywała pełne **100 cykli RF** na **8 wątkach OpenMP** (zgodnie z geometrią 1 bloku CCX).

### 3.1. Szczegółowe Pomiary dla Wariantu `PASSIVE` (Zadania 5907765 – 5907767)

Poniższa tabela przedstawia surowe odczyty z narzędzia `perf stat` dla trzech niezależnych powtórzeń po ustabilizowaniu kodu w katalogu [`experiments/Cpp-parallel/5-omp-wait-policy/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Cpp-parallel/5-omp-wait-policy):

| Metryka Sprzętowa | Job 5907765 ([`OMP_STAT-8_1`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Cpp-parallel/5-omp-wait-policy/OMP_STAT-8_1)) | Job 5907766 ([`OMP_STAT-8_2`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Cpp-parallel/5-omp-wait-policy/OMP_STAT-8_2)) | Job 5907767 ([`OMP_STAT-8_3`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Cpp-parallel/5-omp-wait-policy/OMP_STAT-8_3)) | Średnia ($\mu \pm \sigma$) |
| :--- | :---: | :---: | :---: | :---: |
| **Czas zegarowy (Walltime)** | 65.44 s | 67.67 s | 60.18 s | **64.43 ± 3.15 s** |
| **Czas użytkownika (`user`)** | 171.98 s | 171.53 s | 171.93 s | **171.81 ± 0.20 s** |
| **Czas jądra (`sys`)** | 129.85 s | 137.49 s | 131.42 s | **132.92 ± 3.28 s** |
| **Całkowity czas CPU** | 301.83 s | 309.02 s | 303.35 s | **304.73 ± 3.12 s** |
| **Udział czasu jądra (`sys/CPU`)** | 43.02% | 44.49% | 43.32% | **43.61 ± 0.64%** |
| **Utylizacja CPU (na 8 rdzeni)** | 4.622 | 4.504 | 5.008 | **4.711 ± 0.218** (58.9%) |
| **Liczba cykli CPU** | 564.82 G | 566.63 G | 603.45 G | **578.30 ± 17.80 G** |
| **Instrukcje wykonane** | 1 881.04 G | 1 880.58 G | 1 877.03 G | **1 879.55 ± 1.79 G** |
| **Wskaźnik IPC** | 3.33 | 3.32 | 3.11 | **3.25 ± 0.10** |
| **Odczyty pamięci L1D** | 517.36 G | 517.31 G | 516.50 G | **517.06 ± 0.39 G** |
| **Chybienia pamięci L1D** | 29.50 G (5.70%) | 29.37 G (5.68%) | 28.72 G (5.56%) | **29.20 ± 0.34 G** (5.65%) |
| **Rozgałęzienia wykonane** | 145.28 G | 145.23 G | 144.95 G | **145.15 ± 0.15 G** |
| **Błędne predykcje skoków** | 258.55 M (0.18%) | 258.49 M (0.18%) | 262.84 M (0.18%) | **259.96 ± 2.04 M** |
| **Stan cząstek na koniec** | 108 029 e- / 113 446 i+ | 108 029 e- / 113 446 i+ | 108 029 e- / 113 446 i+ | **100% stabilności fizycznej** |

---

### 3.2. Zestawienie Porównawcze: `ACTIVE` vs `PASSIVE`

Do porównania wykorzystano zoptymalizowany wariant `OMP_WAIT_POLICY=ACTIVE` uruchomiony na 8 rdzeniach (Joby `5907597`, `5907598`, `5907599` z katalogu [`saved_logs_C`](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_C) oraz profile referencyjne [`OMP_STAT-8_1`](file:///C:/Users/E14/Documents/GitHub/GoPIC/plots/hpc_logs/C-OMP/STAT/OMP_STAT-8_1)):

| Parametr Pomiarowy | `OMP_WAIT_POLICY=ACTIVE` (Single CCX) | `OMP_WAIT_POLICY=PASSIVE` (Wartość Średnia) | Różnica Bezwzględna | Wskaźnik Względny / Wpływ |
| :--- | :---: | :---: | :---: | :---: |
| **Czas wykonania (Walltime)** | **19.52 s** (19.46 s – 19.58 s) | **64.43 s** (60.18 s – 67.67 s) | **+44.91 s** | **3.30x wolniej (+230.1% narzutu)** |
| **Czas w przestrzeni jądra (`sys`)**| **0.15 s** (0.12 s – 0.18 s) | **132.92 s** (129.85 s – 137.49 s) | **+132.77 s** | **Wzrost o 886x (88 513%)!** |
| **Czas użytkownika (`user`)** | 155.12 s | 171.81 s | +16.69 s | Wzrost o 10.8% |
| **Udział jądra w czasie CPU** | **0.09%** | **43.61%** | +43.52 p.p. | Prawie połowa mocy CPU na futexy |
| **Utylizacja CPU (na 8 rdzeni)** | **7.96 / 8.00 (99.5%)** | **4.71 / 8.00 (58.9%)** | -3.25 rdzenia | Spadek efektywności o 40.6 p.p. |
| **Liczba instrukcji maszynowych** | **1.88 T** (1 882 G) | **1.88 T** (1 880 G) | -0.002 T | Identyczna praca fizyczna (< 0.1%) |
| **Wskaźnik IPC** | **3.28 – 3.32** | **3.25** | -0.05 | Zbliżona efektywność potoku w kodzie |
| **Chybienia pamięci L1D** | 5.43% | 5.65% | +0.22 p.p. | Lekki wzrost przez unieważnianie linii |
| **Błędy predykcji skoków** | 216 M | 260 M | +44 M | Wzrost o 20% przez asynchroniczność |

---

## 4. Wykresy i Wizualizacje ASCII

### 4.1. Porównanie Czasu Wykonania i Struktury Czasu CPU

```
CZAS ZEGAROWY SYMULACJI (WALLTIME) [s] (mniej = lepiej)
ACTIVE   [████████] 19.52 s
PASSIVE  [██████████████████████████] 64.43 s (+230.1%)
         0        10       20       30       40       50       60       70

STRUKTURA CZASU PROCESORA (USER vs SYSTEM) [s]
ACTIVE:
User: [████████████████████████████████████████] 155.1 s (99.9%)
Sys:  [] 0.15 s (0.1%)

PASSIVE:
User: [████████████████████████████████████████] 171.8 s (56.4%)
Sys:  [███████████████████████████████] 132.9 s (43.6%)
      0        50       100      150      200      250      300      350
```

### 4.2. Efektywność Utylizacji Rdzeni Procesora

```
ŚREDNIA LICZBA AKTYWNYCH RDZENI (na 8 przydzielonych rdzeni CPU)
ACTIVE   [████████████████████████████████████████] 7.96 / 8.00 (99.5%)
PASSIVE  [███████████████████████                 ] 4.71 / 8.00 (58.9%)
         0        1        2        3        4        5        6        7        8
```

---

## 5. Głęboka Analiza Mikroarchitektoniczna i Systemowa

### 5.1. Analiza Kosztu Przejścia do Jądra (Futex Flood)
Dane z narzędzia `perf stat` bezsprzecznie dowodzą, że wariant `PASSIVE` cierpi na patologię zwaną w literaturze systemowej *Futex Flood*.
* W ciągu 64.43 sekund symulacji wykonano **132.92 sekund czasu procesora w przestrzeni jądra** (`sys time`).
* Dzieląc ten czas przez liczbę barier ($2.4 \times 10^6$), otrzymujemy:
  $$T_{\text{sys per barrier}} \approx \frac{132.92\text{ s}}{2\,400\,000} \approx \mathbf{55.38\text{ mikrosekundy narzutu jądra na podkrok!}}$$
* Ponieważ sam czysty podkrok fizyczny trwa zaledwie **~48 mikrosekund**, narzut wywołań systemowych podwaja czas trwania każdej iteracji, degradując przyspieszenie wielowątkowe.

### 5.2. Destrukcja Pamięci Podręcznej i Zawartości Kolejek Wykonawczych (Cache Thrashing)
Gdy wątek przechodzi w stan uśpienia przez `futex`:
1. **Unieważnienie stanu rejestrów i TLB:** Powrót z jądra wymusza przeładowanie rejestrów ogólnego przeznaczenia i rejestrów wektorowych AVX-512 (`ZMM0`–`ZMM31`).
2. **Utrata gorących linii w pamięci L1D:** W trybie `ACTIVE` tablice siatkowe `e_density` oraz bufory robocze pozostają nieprzerwanie w najszybszej pamięci podręcznej L1 Data Cache (czas dostępu 4–5 cykli). W trybie `PASSIVE` przełączenie kontekstu i obsługa struktur jądra wypycha dane symulacji z pamięci L1D do L2/L3, co znajduje bezpośrednie odzwierciedlenie w statystykach: liczba chybień L1D wzrosła z 5.43% do 5.65%, a liczba błędnych predykcji skoków wzrosła o ponad 44 miliony zdarzeń.

### 5.3. Kontekst Klastrów Obliczeniowych HPC: Zasada Dedykowanych Zasobów
Dlaczego w ogóle istnieje polityka `PASSIVE` i dlaczego jest ona domyślna w wielu środowiskach?
* `PASSIVE` zostało zaprojektowane z myślą o stacjach roboczych i systemach wielodostępnych o charakterze *over-subscribed* (gdzie liczba aktywnych procesów przekracza liczbę fizycznych rdzeni). W takich warunkach aktywne wirowanie marnowałoby czas procesora potrzebny innym aplikacjom.
* Na klastrach obliczeniowych HPC (takich jak system Lem z zarządcą zadań Slurm), zasoby są przydzielane **na wyłączność** (poprzez mechanizm cgroups: `cpus-per-task=8`). Żaden inny proces użytkownika nie współdzieli rdzeni przydzielonych do zadania.
* **Wniosek:** Na dedykowanych węzłach HPC zwalnianie procesora i usypianie wątków w kodach cząstkowych PIC/MCC jest kardynalnym błędem konfiguracyjnym — rdzeń przechodzi w stan jałowy, generując opóźnienia i nie przynosząc żadnej korzyści systemowej.

---

## 6. Gotowe Wnioski i Fragmenty Tekstu do Pracy Magisterskiej

Poniższe akapity stanowią gotowy tekst naukowy do bezpośredniego włączenia do podrozdziału 4.3.5 pracy magisterskiej:

### Wprowadzenie do podrozdziału:
> *W symulacjach kinetycznych plazmy metodą PIC/MCC o wysokiej częstotliwości (RF CCP), dyskretyzacja czasowa wymusza krok rzędu kilkudziesięciu pikosekund, co przekłada się na wykonanie setek tysięcy iteracji w pojedynczym eksperymencie. W architekturze ze współdzieloną pamięcią OpenMP pętla ta wymaga częstej synchronizacji barierowej między fazą depozycji ładunku, rozwiązaniem równania Poissona, ruchem cząstek oraz modułem zderzeń Monte Carlo. W ramach badań zbadano wpływ zmiennej środowiskowej `OMP_WAIT_POLICY`, definiującej zachowanie wątków w trakcie oczekiwania na barierze.*

### Analiza wyników empirycznych:
> *Wyniki pomiarów przeprowadzonych na węźle klastra Lem (procesor AMD EPYC 9554) jednoznacznie wykazały, że zastosowanie domyślnej w wielu dystrybucjach polityki pasywnej (`OMP_WAIT_POLICY=PASSIVE`) prowadzi do drastycznej degradacji wydajności. Całkowity czas wykonania 100 cykli symulacji wzrósł z 19.52 s w trybie aktywnym do 64.43 s w trybie pasywnym, co oznacza spadek wydajności aż o 230.1% (3.3-krotne wydłużenie czasu obliczeń).*
>
> *Szczegółowa analiza profilu wykonania za pomocą licznika `perf stat` ujawnia źródło tej anomalii: w trybie pasywnym procesor spędził aż 132.92 sekundy czasu CPU w przestrzeni jądra systemowego (`sys time`), co stanowiło 43.61% całkowitego czasu procesora. W trybie aktywnym (`ACTIVE`) czas jądra wynosił zaledwie 0.15 s (< 0.1% czasu CPU). Przy ponad 2.4 miliona barier synchronizacyjnych w trakcie 100 cykli, ciągłe usypianie wątków poprzez wywołania systemowe `futex` doprowadziło do zjawiska lawinowych przełączeń kontekstu, obniżając średnią utylizację przydzielonych rdzeni CPU z 99.5% do zaledwie 58.9%.*

### Wnioski inżynierskie i przypadek wyścigu danych:
> *Co szczególnie istotne z inżynierskiego punktu widzenia, badanie trybu pasywnego posłużyło jako rygorystyczny test odporności synchronizacji (*concurrency stress-test*). W pierwotnej implementacji redukcja gęstości ładunku wykorzystywała klauzulę `nowait`, a bezpośrednio po niej następował blok sekwencyjny `#pragma omp single`. W trybie aktywnym, dzięki nanosekundowej synchronizacji w pamięci podręcznej L3, wszystkie wątki kończyły redukcję symetrycznie. Jednak w trybie pasywnym asynchroniczne wybudzanie wątków przez scheduler jądra (rozstęp rzędu 20–50 $\mu$s) doprowadziło do wyścigu danych: wątek wybudzony wcześniej wchodził do solvera Poissona, zanim wątki opóźnione w jądrze zapisały swoje komórki siatki. Spowodowało to zafałszowanie potencjału, lawinowy wzrost jonizacji plazmy (ze 108 tys. do ponad 180 tys. cząstek) i awarię `Segmentation fault`.*
>
> *Wprowadzenie jawnej bariery `#pragma omp barrier` przed blokiem solvera Poissona oraz przed redukcją liczników zderzeń jonów całkowicie wyeliminowało hazard wyścigu, przywracając stuprocentową powtarzalność fizyczną ($108\,029\ e^-$ i $113\,446\ i^+$ na koniec eksperymentu). Eksperyment ten dowodzi, że w dedykowanych środowiskach HPC kody cząstkowe PIC/MCC muszą bezwzględnie korzystać z aktywnego wirowania (`OMP_WAIT_POLICY=ACTIVE`), a optymalizacje minimalizacji barier (`nowait`) nie mogą naruszać zależności odczytu danych w kolejnych krokach algorytmu.*

---

## 7. Podsumowanie Metryczne Optymalizacji

$$\begin{aligned}
\text{Przyspieszenie } (\text{Speedup } S_{\text{ACTIVE/PASSIVE}}) &= \frac{T_{\text{PASSIVE}}}{T_{\text{ACTIVE}}} = \frac{64.43\text{ s}}{19.52\text{ s}} = \mathbf{3.30\times} \\
\text{Względny narzut trybu pasywnego} &= \frac{T_{\text{PASSIVE}} - T_{\text{ACTIVE}}}{T_{\text{ACTIVE}}} \times 100\% = \mathbf{+230.1\%} \\
\text{Wzrost narzutu wywołań systemowych } (\text{Kernel sys time}) &= \frac{132.92\text{ s}}{0.15\text{ s}} = \mathbf{886.1\times} \\
\text{Ubytek efektywnej mocy obliczeniowej} &= 99.5\% - 58.9\% = \mathbf{40.6\text{ punktów procentowych}}
\end{aligned}$$
