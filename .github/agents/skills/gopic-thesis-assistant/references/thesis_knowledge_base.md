# GoPIC: Baza Wiedzy i Faktów Badawczych do Pracy Dyplomowej

Niniejszy dokument stanowi kompendium faktów technicznych, architektonicznych, algorytmicznych i pomiarowych zebranych podczas rozwoju i optymalizacji projektu **GoPIC**. Służy jako fundament merytoryczny dla asystenta piszącego pracę naukową.

---

## 1. Kontekst Projektu i Cel Naukowy

* **Przedmiot badań:** Porównanie wydajności, skalowalności wielordzeniowej oraz kosztu abstrakcji języka **Go** (warianty: `parallel_chunking` oraz `parallel_channels`) w zestawieniu z referencyjną implementacją w **C++ OpenMP** (`parallel-only-omp`) oraz wersjami edukacyjnymi w języku **Python** (wersja natywna oraz zoptymalizowana NumPy/Numba).
* **Domena zastosowań:** Kinetyczna symulacja wyładowania plazmowego niskiego ciśnienia (RF CCP – *Capacitively Coupled Plasma*) w argonie metodą **Particle-in-Cell z Zderzeniami Monte Carlo (PIC/MCC)** w geometrii jednowymiarowej w przestrzeni położenia i trójwymiarowej w przestrzeni prędkości (**1D3V**).
* **Główna hipoteza badawcza:** Czy nowoczesny język ze środowiskiem uruchomieniowym zarządzanym (Go: automatyczne odśmiecanie pamięci GC, scheduler M:N, abstrakcja goroutines i kanałów) może stanowić efektywną, bezpieczną i skalowalną alternatywę dla C++ z biblioteką OpenMP w obliczeniach wysokiej wydajności (HPC) w fizyce plazmy?

---

## 2. Model Fizyczny i Algorytmika PIC/MCC (1D3V)

### 2.1. Pętla 9 Kroków Czasowych
Symulacja dyskretyzuje czas na kroki $\Delta t_e$. W każdym kroku realizowany jest cykl 9 operacji:
1. **Krok 1: Depozycja gęstości ładunku (Charge Deposition / Scatter):** Rzutowanie ładunku cząstek supercząstkowych ($w_p$) na węzły siatki przestrzennej metodą Cloud-in-Cell (CIC / spline 1. rzędu). Podwojenie gęstości na brzegach układu: $\rho[0] \cdot 2$, $\rho[N_g-1] \cdot 2$.
2. **Krok 2: Rozwiązanie równania Poissona (Poisson Solver):** Wyznaczenie potencjału elektrostatycznego $\phi$ z równania $\nabla^2 \phi = -\rho / \epsilon_0$ za pomocą trójdiagonalnego algorytmu Thomasa (TDMA). Różniczkowanie numeryczne pola elektrycznego: $E = -\nabla \phi$.
3. **Krok 3: Popychacz elektronów (Electron Leap-Frog Push):** Interpolacja pola elektrycznego ze siatki do położenia cząstki (operacja **Gather**) i całkowanie równań ruchu Newtona-Lorentza schematem *Leap-Frog*:
   $$v^{n+1/2} = v^{n-1/2} + \frac{q}{m} E^n \Delta t, \quad x^{n+1} = x^n + v^{n+1/2} \Delta t$$
4. **Krok 4: Popychacz jonów (Ion Leap-Frog Push):** Całkowanie ruchu jonów $Ar^+$. Ponieważ jony są ponad 73 000 razy cięższe od elektronów ($m_{Ar} \approx 73400 \cdot m_e$), ich dynamika jest znacznie wolniejsza. Stosuje się technikę **Subcyclingu** z podkrokiem $N_{\text{SUB}} = 10$ ($\Delta t_i = 10 \cdot \Delta t_e$). Krok 4 wykonuje się wyłącznie wtedy, gdy `step % N_SUB == 0`.
5. **Krok 5: Warunki brzegowe elektronów:** Detekcja cząstek przekraczających granice $x < 0$ lub $x > L$. Pochłanianie na elektrodach, usuwanie z tablicy metodą *Swap with Last* i uaktualnianie diagnostyki prądów.
6. **Krok 6: Warunki brzegowe jonów:** Identyczna detekcja dla jonów (również z subcyclingiem).
7. **Krok 7: Zderzenia Monte Carlo elektronów (MCC Electrons):** Model zderzeń elektron-atom gazu tła (Ar) metodą *Null-Collision* (Vahedi & Surendra). Uwzględniane 4 reakcje z tablic przekrojów czynnych Phelpsa:
   * Sprężyste izotropowe ($e + Ar \to e + Ar$),
   * Wzbudzenie progu 1 ($e + Ar \to e + Ar^*$),
   * Wzbudzenie progu 2,
   * Jonizacja z uderzenia ($e + Ar \to 2e + Ar^+$) – kreacja nowych par elektron-jon.
8. **Krok 8: Zderzenia Monte Carlo jonów (MCC Ions):** Model zderzeń jon-atom gazu tła (również z subcyclingiem $N_{\text{SUB}}=10$):
   * Sprężyste izotropowe ($Ar^+ + Ar \to Ar^+ + Ar$),
   * Rezonansowa wymiana ładunku (**Charge Exchange** / `I_BACK`: $Ar^+_{\text{szybki}} + Ar_{\text{wolny}} \to Ar_{\text{szybki}} + Ar^+_{\text{wolny}}$) – stanowi ponad 80% wszystkich zderzeń jonów.
9. **Krok 9: Akumulacja diagnostyk i zapis danych:** Wyznaczanie gęstości uśrednionych czasowo, temperatur, prądów elektrodowych i zbieżności do pliku `conv.dat`.

---

## 3. Ekwiwalentność Optymalizacji: Go vs C++ OpenMP

Pomiędzy kodami C++ OpenMP a Go (warianty `parallel_chunking` oraz `parallel_channels`) zachowano pełną tożsamość algorytmiczną i mikroarchitektoniczną:

### 3.1. Układ Pamięci i Unikanie Alokacji
* **Structure of Arrays (SoA):** Rezygnacja z tablic struktur (AoS). Płaskie, liniowe tablice zmiennoprzecinkowe `x, vx, vy, vz` zapewniające idealną lokalność przestrzenną w L1 Cache.
* **Eliminacja alokacji w pętli głównej (0 allocs/op):** Bufory cząstek wtórnych prealokowane na stałe. W C++ zerowane przez `clear()`, w Go przez reslice do długości zerowej:
  `sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]`.
  Garbage Collector w Go nie jest wywoływany w gorącej fazie obliczeń.
* **Eliminacja False Sharing:** Wszystkie struktury wątkowe/goroutines wyrównane do linii cache 64 bajtów. W C++ za pomocą `alignas(64)`, w Go za pomocą jawnego paddingu (np. `_ [4]uint64`).

### 3.2. Optymalizacje Numeryczne
* **Prekomputacja odwrotności (Eliminacja `DIVSD`):** Zastąpienie wszystkich dzieleń przez stałe fizyczne prekomputowanymi mnożnikami (`INV_DX`, `INV_DT_E`, `INV_DT_I`, etc.).
* **Interpolacja CIC 1-mnożeniowa:** Redukcja formuły interpolacji z dwóch mnożeń do jednego:
  $$E_p + d \cdot (E_{p+1} - E_p)$$
  Oszczędność 40 milionów instrukcji mnożenia na jeden cykel RF.
* **Solver Poissona `ThomasW` bez dzieleń:** Współczynniki eliminacji w przód TDMA są stałe w czasie. Wstępne stablicowanie odwrotności mianowników eliminuje wszystkie 794 instrukcje dzielenia `DIVSD` w każdym kroku czasowym.
* **Fast-Path wymiany ładunku (`I_BACK`):** W wyładowaniu w argonie ponad 80% zderzeń jonowych to wymiana ładunku. Szybki jon przejmuje prędkość atomu tła wylosowaną z rozkładu Maxwella. Pominięto transformację sferyczną i przejście do środka masy: natychmiastowe przypisanie `*vx_1 = *vx_2; return`.
* **Czysta algebra wektorowa bez trygonometrii:** Wyznaczanie kątów rozproszenia z rzutowania wektorowego ($\cos\theta = g_x/g$), całkowity brak wywołań wolnych funkcji `atan2`, `sin`, `cos`.
* **Multiplikatywna selekcja Null-Collision:** Zamiana testu z dzieleniem na test z mnożeniem: `rnd * Nu* < Nu`.

---

## 4. Problem Wektoryzacji SIMD i Operacji Gather w Go

### 4.1. Definicja Problemu
* **Wektoryzacja w C++:** Kompilator GCC dzięki flagom `-O3 -mavx2 -mfma` przeprowadza automatyczną wektoryzację (DLP) pętli `Push_electrons`. Emituje 256-bitowe instrukcje `VFMADD231PD`, przetwarzające **4 cząstki w jednym takcie zegara**.
* **Kompilator Go (`gc`):** Z założenia projektowego kompilator Go nie posiada modułu auto-wektoryzacji. Pętle `for` kompilują się wyłącznie do kodu skalarnego `VFMADD231SD` (**1 cząstka naraz**). Ręczny unroll 4-way zwiększa ILP, ale nie DLP.
* **Dlaczego występuje problem Gather?** Cząstki poruszają się swobodnie; ich pozycje w pamięci RAM leżą obok siebie, ale indeksy komórek $p = \lfloor x/\Delta x \rfloor$ są rozproszone. Aby załadować pole elektryczne dla 4 cząstek do jednego rejestru SIMD, procesor musi wykonać nielokalny odczyt z pamięci (**Gather**).

### 4.2. Porażka Zewnętrznych Pakietów SIMD w Go
Zastosowanie biblioteki SIMD dla Go wykazało, że pakiety te nie potrafią wyemitować sprzętowej instrukcji `VGATHERDPD`. Zamiast tego emulowały gather programowo (odczyty skalarne ze stosem i instrukcje pakowania `PINSRQ`).
* Czas pętli skalarnej w Go: **$568.7\ \mu\text{s}$**
* Czas pętli z pakietem Go SIMD: **$728.3\ \mu\text{s}$** (**spowolnienie o 28% zamiast zysku!**)

### 4.3. Rozwiązanie: Autorski Kernel Asemblera Plan 9 (`push_amd64.s`)
Napisano eksperymentalny kernel w asemblerze Plan 9 wykorzystujący bezpośrednią instrukcję procesora:
```assembly
VGATHERDPD Y4, (DX)(X2*8), Y6
```
* Czas wykonania dla 100 000 cząstek: **$125.5\ \mu\text{s}$** (**4.53× szybciej niż czysty Go!**).
* **Wniosek naukowy:** Sprzęt (AMD Zen 4) radzi sobie z operacją gather znakomicie. Ograniczenie wydajnościowe leży wyłącznie w braku auto-wektoryzatora w kompilatorze `gc`.

---

## 5. Środowisko Obliczeniowe HPC i Skalowalność

* **Węzeł obliczeniowy klastra HPC:**
  * Procesor: **AMD EPYC 9554** (mikroarchitektura Zen 4).
  * Zasoby: 64 fizyczne rdzenie, 128 wątków (SMT), taktowanie bazowe 3.1 GHz (boost do 3.75 GHz).
  * Pamięć podręczna: 256 MB L3 Cache podzielone na domeny CCX/NUMA.
* **Mechanizmy wielowątkowości:**
  1. `C/parallel-only-omp`: Wątki POSIX, OpenMP runtime (`libgomp`), statyczny podział pętli (`schedule(static)`), natywne bariery sprzętowe CPU. Czas referencyjny na 32 rdzeniach: **$13.89\text{ s}$**.
  2. `Go/parallel_chunking`: Tworzenie goroutines per krok czasowy, synchronizacja przez [`sync.WaitGroup`](../../../Go/parallel_chunking/simulation.go), scheduler M:N.
  3. `Go/parallel_channels`: Trwały zestaw goroutines (worker pool), komunikacja sygnałowa przez kanały `chan struct{}` bez alokacji.
* **Metryki oceny:**
  * Przyspieszenie (Speedup): $S(p) = T(1) / T(p)$.
  * Sprawność (Efficiency): $E(p) = S(p) / p$.
  * Analiza Prawa Amdahla: Identyfikacja sekwencyjnego ułamka symulacji (solver Poissona, redukcje sum diagnostycznych, bariery synchronizacji).
