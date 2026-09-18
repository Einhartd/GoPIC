# Plan Optymalizacji Silnika PIC/MCC oraz Katalog Eksperymentów

Dokument definiuje zestaw optymalizacji algorytmicznych, mikroarchitektonicznych i współbieżnych dla silnika symulacji plazmy eduPIC (C++), z podziałem na część sekwencyjną (Single-Core) oraz wielowątkową (Multi-Core OpenMP). Dla każdej optymalizacji określono mechanizm działania, przyczynę wąskiego gardła oraz dedykowany eksperyment weryfikacyjny lub mikrobenchmark.

---

## Metodologia Badawcza

1. **Część Sekwencyjna (Single-Core):**
   * Badana bezpośrednio na **pełnej symulacji PIC/MCC** (katalog `C/experimental/`).
   * Zaczynamy od czystego kodu bazowego (Baseline eduPIC) z podpiętym stanem wzorcowym **Golden Record** (`picdata.bin`), co zapewnia realistyczne obciążenie (~108 tys. cząstek).
   * Wprowadzamy kolejno optymalizacje, mierząc czas wykonania stałej liczby cykli RF (np. 1, 5, 20 lub 50 cykli), zysk cząstkowy $\Delta T$ oraz weryfikując poprawność fizyczną (brak dryfu gęstości ładunku i zachowanie energii w `density.dat` i `conv.dat`).
   * **Lokalne zbieranie logów z `perf` (Pętla Ewaluacji Deweloperskiej):**
     Przed i po każdej wprowadzonej zmianie uruchamiany jest automatyczny skrypt profilujący `C/experimental/run_local_perf.sh`. Zapisuje on w katalogu ze stemplem czasowym (`perf_results_<timestamp>/`):
     - `perf_stat.txt` — sprzętowe liczniki CPU: całkowity czas wykonania, liczba cykli, instrukcji, wskaźnik **IPC (Instructions Per Cycle)**, nietrafione rozgałęzienia (`branch-misses`),
     - `perf_report.txt` — próbkowanie stosu wywołań (call-graph) z identyfikacją **Top Hotspots** (procent czasu CPU spędzony w poszczególnych funkcjach, np. `exp`, `atan2`, pętlach Boris pushera).
     Pozwala to na natychmiastową lokalną weryfikację (na WSL 2 lub Arch Linuxie) czy optymalizacja zlikwidowała przewidziane wąskie gardło, zanim kod trafi do testów na klastrze HPC.

2. **Część Wielowątkowa (Multi-Core OpenMP):**
   * Mechanizmy współbieżności są wzajemnie powiązane (nie można uruchomić połowicznie zrównoleglonej symulacji PIC bez wyścigów danych i błędów pamięci).
   * Z tego względu poszczególne techniki równoległe (atomiki vs bufory prywatne, False Sharing, losowanie, buforowanie cząstek) badane są w **izolowanych mikrobenchmarkach** (katalog `C/microbenchmarks/`) na 1, 2, 4, 8, 16, 32, 64 rdzeniach.
   * Każdy mikrobenchmark również profilowany jest lokalnie za pomocą `perf stat` pod kątem unieważnień linii pamięci podręcznej (`cache-misses`, `L1-dcache-load-misses`), a następnie uruchamiany w pełnej skali na klastrze HPC.
   * Na koniec wszystkie techniki łączone są w pełnym silniku wielowątkowym (`C/parallel-only-omp/`), na którym przeprowadzane jest **pełne badanie skalowalności silnej (Strong Scaling)**, dopasowanie do **Prawa Amdahla** oraz analiza wpływu architektury **NUMA**.

---

## Część I: Optymalizacje Sekwencyjne i Wektorowe (Single-Core)

### Punkt Odniesienia: Modularny Kod Bazowy (Baseline eduPIC)

* **Opis i mechanizm:**
  Oryginalna implementacja modelu PIC/MCC (Donkó et al. 2021) rozbita na moduły nagłówkowe, lecz zachowująca 100% oryginalnych algorytmów i zasięgów zmiennych. Zderzenia cząstek z gazem tła realizowane są metodą bezpośrednią (Direct MCC) — każda cząstka w każdym kroku czasowym oblicza prawdopodobieństwo zderzenia:
  $$p_{coll} = 1 - \exp(-\nu(v) \cdot \Delta t)$$
  Dla 80 000 cząstek w 4000 podkrokach na cykel generuje to ponad 320 milionów wywołań funkcji `exp()` na cykl. Stałe fizyczne i geometryczne wewnątrz funkcji `solve_Poisson`, `collision_electron` i `do_one_cycle` są definiowane lokalnie. Solver Poissona przelicza współczynniki eliminacji Thomasa w każdym kroku od zera.
* **Eksperyment / Weryfikacja:**
  Pomiar czasu wykonania 20 i 50 cykli na 1 rdzeniu. Zebranie profilu sprzętowego `perf record` i raportu `perf report` w celu udokumentowania dominacji funkcji matematycznych `__exp_finite`, `atan2` oraz `pow` w profilu wykonania. Stanowi punkt odniesienia ($T_0$, speedup $1.0\times$).

---

### Metoda Zderzeń Zerowych (Null-Collision Method)

* **Opis i mechanizm:**
  Zastąpienie metody bezpośredniej algorytmem zderzeń pozornych (Vahedi & Surendra 1995). Wprowadzana jest stała, maksymalna częstość zderzeń w układzie $\nu^* = \max_v(\nu(v))$ oraz odpowiadające jej stałe prawdopodobieństwo $P^* = 1 - \exp(-\nu^* \Delta t) \approx 1-2\%$. Zamiast testować 80 000 cząstek, losowana jest liczba kandydatów do zderzenia z rozkładu dwumianowego:
  $$N_{coll}^* \sim \text{Binom}(N, P^*)$$
  Dla wylosowanych cząstek obliczana jest rzeczywista częstość $\nu(v)$ i zderzenie jest akceptowane z prawdopodobieństwem $p_{accept} = \nu(v) / \nu^*$. Odrzucenie oznacza zderzenie pozorne (brak zmiany pędu).
* **Eksperyment / Weryfikacja:**
  Wdrożenie metody do `simulation.h`. Pomiar czasu wykonania 20 i 50 cykli symulacji. Zliczenie liczby wywołań funkcji wykładniczej na cykl (spadek z 320M do zera w pętli cząstek). Weryfikacja fizyczna: porównanie profili gęstości plazmy `density.dat`, rozkładów EEPF i IFED z danymi referencyjnymi Donkó (potwierdzenie tożsamości statystycznej rozkładów).

---

### Eliminacja redundancji obliczeniowej poprzez hoisting stałych skalarnych i tablicowych

* **Opis i mechanizm:**
  1. **Hoisting stałych:** Wyniesienie stałych definiowanych lokalnie w funkcjach (`A, B, C, S, ALPHA` w `solve_Poisson`, `F1, F2` w `collision_electron`, `DV, FACTOR_W, FACTOR_E, FACTOR_I` w `do_one_cycle`) do pliku nagłówkowego `constants.h`. Wyliczenie ich jednorazowo przy starcie programu zamiast ponownego tworzenia w każdym wywołaniu funkcji.
  2. **Prekompilacja algorytmu Thomasa:** Współczynniki macierzy trójprzekątniowej dla jednowymiarowego równania Poissona ($A=1, B=-2, C=1$) są stałe w czasie. Wstępne wyznaczenie wektora współczynników $w_i = C / (B - A \cdot w_{i-1})$ oraz odwrotności mianowników `inv_denom_thomas[i] = 1.0 / (B - A * w[i-1])` w funkcji inicjalizującej przed startem symulacji.
  3. **Fuzja stałych pola:** Połączenie stałych gęstości z ładunkiem elementarnym: $\alpha_Q = \alpha \cdot e$, co eliminuje konieczność wyliczania osobnej tablicy gęstości ładunku `rho` w każdym kroku.
* **Eksperyment / Weryfikacja:**
  Pomiar pełnej symulacji. Profilowanie `perf stat -e instructions,cycles`: wykazanie redukcji 1.6 miliona operacji dzielenia zmiennoprzecinkowego na cykl RF w funkcji `solve_Poisson`. Weryfikacja zgodności potencjału elektrostatycznego `pot[p]` z dokładnością maszynową `double`.

---

### Eliminacja Dzieleń Zmiennoprzecinkowych (Strength Reduction)

* **Opis i mechanizm:**
  Instrukcje dzielenia zmiennoprzecinkowego (`vdivsd` na architekturze x86-64) charakteryzują się opóźnieniem rzędu 12–16 cykli zegara i nie mogą być w pełni potokowane. W pętli ruchu cząstek i zderzeń każda cząstka przeliczała prędkość na dżule, a następnie dżule na eV, po czym dzieliła przez krok tabeli przekrojów:
  $$E = \frac{0.5 \cdot m \cdot v^2}{e}, \quad \text{index} = \frac{E}{\Delta E_{cs}}$$
  Optymalizacja polega na prekompilacji łączonego mnożnika odwrotności:
  $$\text{FACTOR\_ENERGY\_E} = \frac{0.5 \cdot m_e}{e \cdot \Delta E_{cs}}$$
  Przeliczenie sprowadza się do **jednego mnożenia**: `int(v_sqr * FACTOR_ENERGY_E)`. Podobnie eliminuje się dzielenia przy interpolacji siatki ($x \cdot \text{INV\_DX}$) oraz w rozkładzie Opla dla energii elektronów wtórnych (`OPAL_FACTOR`).
* **Eksperyment / Weryfikacja:**
  Pomiar pełnej symulacji. Zbadanie asemblera pętli Leap-Frog i MCC za pomocą `objdump -d` — weryfikacja zamiany instrukcji `vdivsd` na `vmulsd`. Pomiar wzrostu wskaźnika IPC (Instructions Per Cycle) w `perf stat`.

---

### Fast-Path Zderzeń Wymiany Ładunku (Charge Exchange)

* **Opis i mechanizm:**
  W wyładowaniu w argonie zderzenie wstecznego transferu ładunku (`I_BACK`: $\text{Ar}^+ + \text{Ar} \to \text{Ar} + \text{Ar}^+$) stanowi **$80\%$ wszystkich zderzeń jonowych**. W kodzie bazowym każde takie zderzenie wykonywało pełną transformację 3D zderzenia dwuciałowego: losowanie kątów Eulera, wyliczanie `atan2`, `sin`, `cos`, `acos` dla kąta rozproszenia $\chi = \pi$ oraz przejście przez układ środka masy.
  Fizycznie wymiana ładunku oznacza przeskoczenie elektronu z powolnego neutralnego atomu gazu na szybki jon. W układzie laboratoryjnym nowy jon posiada dokładnie prędkość wylosowanego termicznego atomu gazu tła. Optymalizacja polega na natychmiastowym podstawieniu prędkości:
  ```cpp
  if (rnd * t2 >= t1) { // 80% zderzeń jonowych
      *vx_1 = *vx_2; *vy_1 = *vy_2; *vz_1 = *vz_2;
      return;
  }
  ```
* **Eksperyment / Weryfikacja:**
  Pomiar pełnej symulacji. Profilowanie czasu spędzonego w podkroku zderzeń jonowych `step8_collision_ions` (oczekiwany spadek czasu funkcji o >70%). Weryfikacja fizyczna: brak zmian w rozkładzie strumieniowo-energetycznym jonów docierających do elektrod (`ifed.dat`).

---

### Algebra Wektorowa Kątów Eulera i Bezdzieleniowy Wybór Typu Zderzenia

* **Opis i mechanizm:**
  1. **Eliminacja trygonometrii kątów Eulera:** Zamiast wywoływać `theta = atan2(...)`, a następnie `sin(theta)` i `cos(theta)`, cosinusy i sinusy wyznaczane są bezpośrednio ze składowych prędkości względnej: $ct = g_x / g$, $st = g_\perp / g$, $cp = g_y / g_\perp$, $sp = g_z / g_\perp$.
  2. **Eliminacja `acos`:** Zamiast losować kąt rozproszenia $\chi = \arccos(1 - 2R)$, a następnie liczyć $\sin(\chi)$ i $\cos(\chi)$, bezpośrednio podstawia się $cc = 1 - 2R$ oraz $sc = \sqrt{\max(0.0, 1.0 - cc^2)}$.
  3. **Wybór bezdzieleniowy:** Zastąpienie warunku wyboru podtypu zderzenia $R < \sigma_{ela} / \sigma_{tot}$ równoważną operacją mnożenia: $R \cdot \sigma_{tot} < \sigma_{ela}$.
  4. **Symetria azymutalna elektronu wtórnego:** Zamiast przeliczać funkcje trygonometryczne dla kąta $\eta_2 = \eta + \pi$, wykorzystuje się tożsamość: $\sin(\eta + \pi) = -\sin(\eta)$, $\cos(\eta + \pi) = -\cos(\eta)$.
* **Eksperyment / Weryfikacja:**
  Pomiar pełnej symulacji. Profilowanie za pomocą `perf stat`: wykazanie eliminacji wywołań biblioteki matematycznej `libm` z pętli zderzeń elektronowych i jonowych.

---

### Eksperyment 7: Optymalizacja Strukturalna Integratora i Liniowa Kompaktacja Warunków Brzegowych (Pusher Fast-Path & Boundary Compaction)

* **Katalog eksperymentu:** `C/7.experiment-pusher-boundaries` oraz `experiments/7-pusher-boundaries/`
* **Flagi kompilatora:** Identyczne jak w krokach 1–6 (`-std=c++17 -O3 -Wall -fno-math-errno -fno-omit-frame-pointer -g -ffast-math`). Pełna izolacja zysku algorytmiczno-strukturalnego bez zmian flag kompilacji.
* **Opis i mechanizm:**
  Po wyeliminowaniu wąskich gardeł w module zderzeniowym (kroki 2–6), ponad 67% czasu symulacji zaczęły zajmować procedury cząstkowe: pchnięcie cząstek (`step3`, `step4`) oraz warunki brzegowe na elektrodach (`step5`, `step6`). Zidentyfikowano dwie patologie strukturalne:
  1. **Fast-path pushera (`__builtin_expect(!measurement_mode, 1)`):** W kodzie referencyjnym wewnątrz ciasnej pętli integratora (wykonywanej ponad 43 miliardy razy na 100 cykli) znajdowały się rozgałęzienia diagnostyczne badające `measurement_mode`. Ponieważ diagnostyka włączana jest tylko w ostatnich cyklach, rozdzielono procedurę na ścieżkę szybką (czysty Leap-Frog bez odgałęzień) oraz ścieżkę pomiarową, wspomaganą predyktorem GCC.
  2. **Uproszczenie interpolacji pola (CIC FMA):** Zastąpienie standardowej dwumnożnikowej interpolacji CIC $E = (1 - c_2)E_p + c_2 E_{p+1}$ zoptymalizowaną formułą o jednym mnożeniu: $E = E_p + c_2(E_{p+1} - E_p)$, bezpośrednio redukowalną do pojedynczej instrukcji `vfmadd213sd`.
  3. **Dwuetapowa liniowa kompaktacja warunków brzegowych (Linear Stream Compaction):** Zastąpienie pętli `while (k < N)` z warunkową inkrementacją i natychmiastowym `swap-with-last` (która całkowicie uniemożliwiała wektoryzację i powodowała nieliniowe zanieczyszczanie cache) deterministyczną pętlą `for`:
     - **Faza 1 (Skan liniowy):** Pętla `for (int k = 0; k < N; ++k)` bada $x_k \in [0, L]$. W 99.9% iteracji warunek spełniony jest bez rozgałęzień; jedynie cząstki martwe odkładają swoje indeksy do bufora `absorbed_indices`.
     - **Faza 2 (Kompaktacja późna):** Szybkie, jednokrotne przepisanie cząstek z końca tablicy w luki po cząstkach pochłoniętych za pomocą algorytmu dwuwskanikowego.
  4. **Redukcja siły operacji w depozycji CIC:** Przeliczenie wag siatki: $w_2 = c_2 \cdot factor\_w$, $w_1 = factor\_w - w_2$, eliminujące jedno mnożenie zmiennoprzecinkowe na cząstkę.
* **Eksperyment / Weryfikacja:**
  Uruchomienie pełnej symulacji 100 cykli na klastrze HPC (`GoPIC_jobs/C/edupic_exp_job_stat.sh`). Weryfikacja redukcji liczby instrukcji w `perf stat` (oczekiwany spadek z 3.08 T do ~2.4–2.5 T) oraz wzrostu wskaźnika IPC. Potwierdzenie identyczności fizycznej (Golden Record: 108 203 elektrony, 113 620 jonów, stabilność $\omega_{pe}\Delta t = 0.090$).

---

### Eksperyment 8: Wektoryzacja SIMD (AVX-512), Wyrównanie Linii Pamięci Podręcznej `alignas(64)` i Strojenie Pod Architekturę Zen 4 (SIMD & Zen 4 Tuning)

* **Katalog eksperymentu:** `C/8.experiment-simd` oraz `experiments/8-simd/`
* **Flagi kompilatora:** `-std=c++17 -O3 -Wall -fno-math-errno -fno-omit-frame-pointer -g -march=znver4 -mtune=znver4 -mprefer-vector-width=512 -funroll-loops -ffast-math -fopt-info-vec-optimized`.
* **Opis i mechanizm:**
  Zwieńczenie optymalizacji pojedynczego rdzenia procesora (Peak Single-Core Performance), przygotowujące bazę kodu do zrównoleglenia wielordzeniowego OpenMP:
  1. **Izolacja i wyrównanie linii pamięci podręcznej (`alignas(64)`):** Wszystkie tablice cząstek (`x_e`, `vx_e`, `vy_e`, `vz_e`, `x_i`...) oraz pola siatki w `state.h` otrzymują atrybut `alignas(64)`. Gwarantuje to dopasowanie adresu bazowego do 64-bajtowej linii cache L1d i uniemożliwia wystąpienie kar za dostęp przekraczający granicę linii cache (*split cache-line access*) podczas ładowania wektorów 512-bitowych (8 liczb typu `double`).
  2. **Ręczne 4-krotne rozwinięcie pętli integratora (4-Way Loop Unrolling):** Przetwarzanie 4 cząstek w jednej iteracji pętli `step3_move_electrons` i `step4_move_ions` (`k += 4`). W pętli Leap-Frog instrukcje FMA dla pojedynczej cząstki mają zależność danych (latencja 4 cykli na Zen 4). Rozwinięcie 4-krotne dostarcza niezależnych strumieni instrukcji, całkowicie ukrywając opóźnienie potoku FMA i wysycając podwójne 512-bitowe jednostki wykonawcze rdzenia Zen 4.
  3. **Wymuszenie 512-bitowej szerokości wektorów (`-mprefer-vector-width=512`):** Standardowo GCC na architekturach x86-64 ogranicza automatyczną wektoryzację do wektorów 256-bitowych (`%ymm`) z powodu historycznych kar termicznych na starszych układach Intel. Procesory AMD EPYC 9654 (Genoa / Zen 4) posiadają pełnoprawne, podwójne 512-bitowe ścieżki danych bez obniżania taktowania zegara. Wymuszenie wektorów 512-bitowych generuje instrukcje operujące bezpośrednio na rejestrach `%zmm0-%zmm31`.
  4. **Dowód asemblerowy:** Porównanie dezasemblacji pushera skalarnego (instrukcje SSE2 `movsd`, `mulsd`, `addsd`) z wektorowym kodem generowanym dla Zen 4 (`vmovupd %zmm`, `vfmadd213pd %zmm`, `vsubpd %zmm`).
* **Eksperyment / Weryfikacja:**
  Uruchomienie na klastrze HPC Lem. Spadek liczby wykonanych instrukcji do poziomu ~1.86 T (identycznie jak w referencyjnym 1-rdzeniowym przebiegu OMP), wskaźnik IPC osiągający ~3.70 oraz czas wykonania 100 cykli symulacji skrócony do ~148 sekund (przyspieszenie blisko 2.2x względem Eksperymentu 6). Potwierdzenie identyczności fizycznej (Golden Record: 108 175 elektronów, 113 606 jonów, stabilność $\omega_{pe}\Delta t = 0.090$).

---

## Część II: Optymalizacje Wielowątkowe i Współbieżność OpenMP

W części wielowątkowej symulacji PIC/MCC wprowadzane techniki tworzą spójną ścieżkę optymalizacyjną: od **przebudowy struktur danych i buforowania wątkowego**, przez **bezkolizyjne zarządzanie cyklem życia cząstek**, **izolację linii pamięci podręcznej (False Sharing)**, **architekturę zespołu wątków i amortyzację narzutu OpenMP**, **strojenie polityki oczekiwania środowiska wykonawczego**, aż po **pełne badanie skalowalności silnej i prawo Amdahla na klastrze HPC**.

---

### Krok 1: Prywatyzacja Pamięci i Buforowanie Wątkowe (*Thread-Private Buffering & State Privatization*)

* **Opis i mechanizm:**  
  Trzy fundamentalne operacje symulacji cząstkowej wymagają nieustannego zapisu danych w każdym kroku czasowym:
  1. **Losowanie stanów Monte Carlo:** Generator liczb pseudolosowych posiada stan wewnętrzny modyfikowany przy każdym losowaniu.
  2. **Depozycja ładunku metodą Cloud-in-Cell (Scatter-Add):** Wiele cząstek próbuje jednocześnie zaktualizować ten sam węzeł siatki przestrzennej.
  3. **Tworzenie nowych cząstek w zderzeniach jonizacyjnych:** Zapis współrzędnych i prędkości nowo powstałych par elektron-jon.  
  W naiwnym podejściu wielowątkowym operacje te wymagałyby sekcji krytycznych (`#pragma omp critical`) lub instrukcji atomowych (`#pragma omp atomic`), co prowadzi do całkowitej serializacji wykonania (*lock contention*) i nasycenia magistrali pamięci.
  
  Optymalizacja polega na zastosowaniu spójnego wzorca prywatnych buforów wątkowych:
  * **Prywatyzacja generatora PRNG:** Każdy wątek otrzymuje niezależną instancję generatora `inline thread_local std::mt19937 MTgen(rd())` na własnym stosie/rejestrach, co zapewnia w 100% bezblokadowe (*lock-free*) losowanie liczb.
  * **Prywatne bufory siatki w pamięci L1d (`WorkerBuffers.e_density`):** Każdy wątek posiada własną tablicę `worker_buffers.e_density[tid][N_G]`. Rozmiar bufora wynosi $400 \times 8\text{ B} = 3.2\text{ KB}$, co idealnie mieści się w lokalnej pamięci podręcznej L1d rdzenia (32 KB). Cząstki są deponowane bez jakiejkolwiek synchronizacji w L1d, a po zakończeniu pętli cząstek następuje szybka redukcja równoległa do tablicy globalnej.
  * **Statyczne bufory narodzin cząstek (`NewParticles`):** Nowo narodzone elektrony i jony są zapisywane do prywatnych tablic statycznych `NewParticles` (bufor `std::array` o stałym rozmiarze 4096 elementów, zero alokacji na stercie). Po zakończeniu pętli zderzeń cząstki są seryjnie i bezkolizyjnie dopisywane do tablic globalnych w jednym bloku.
* **Eksperyment / Weryfikacja:**  
  Wdrożenie wzorca do silnika [`C/parallel-only-omp/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp). Wykazanie eliminacji wszystkich sekcji krytycznych i atomików z pętli cząstkowych.

---

### Krok 2: Dwuetapowa Bezkonfliktowa Obsługa Warunków Brzegowych (*Two-Phase Boundary Handling & Compaction*)

* **Opis i mechanizm:**  
  Gdy cząstki wylatują poza elektrody ($x < 0 \lor x > L$), w kodzie sekwencyjnym są natychmiast usuwane przez podmianę z ostatnią cząstką z tablicy (`swap-with-last`) i dekrementację licznika `N--`. W kodzie wielowątkowym jednoczesne modyfikowanie globalnego rozmiaru `N` i zamienianie elementów z końca tablicy przez wiele rdzeni prowadzi do wyścigów danych (*data races*) i nadpisywania żywych cząstek.
  
  Optymalizacja polega na wdrożeniu algorytmu dwuetapowego:
  1. **Faza 1 (Równoległa):** Wątki równolegle skanują swoje fragmenty tablicy położeń i jedynie odkładają indeksy cząstek martwych do prywatnych wektorów `absorbed_indices[tid]`.
  2. **Faza 2 (Kompaktacja in-place):** Pojedynczy wątek za pomocą szybkiego algorytmu dwuwskanikowego (`last_valid`) przepisuje żywe cząstki z końca tablicy w miejsca martwych, minimalizując operacje kopiowania pamięci.
* **Eksperyment / Weryfikacja:**  
  Weryfikacja braku wyścigów danych na tablicach cząstek, stabilności zużycia pamięci RAM oraz poprawności liczby zaabsorbowanych cząstek na elektrodach.

---

### Krok 3: Eliminacja Zjawiska False Sharing i Izolacja Linii Pamięci Podręcznej (`alignas(64)`)

* **Opis i mechanizm:**  
  W symulacji wielowątkowej każdy wątek zlicza lokalne statystyki diagnostyczne (liczbę cząstek zaabsorbowanych na elektrodach, liczbę zderzeń, próbki energii elektronów w centrum szczeliny). Gdyby umieścić te liczniki w zwartej tablicy (np. `double counters[num_threads]`), zmienne należące do różnych rdzeni znalazłyby się w tej samej 64-bajtowej linii pamięci podręcznej. Zapis przez rdzeń $A$ powoduje unieważnienie całej linii cache w rdzeniu $B$ (*False Sharing*), wywołując nieustanny ruch spójności na magistrali procesora.
  
  Optymalizacja polega na zastosowaniu struktury z wymuszonym wyrównaniem i dopełnieniem do pełnej linii pamięci podręcznej:
  ```cpp
  struct alignas(64) AlignedThreadCounters {
      double accu_center = 0.0;
      Ullong counter_center = 0;
      Ullong local_abs_pow = 0;
      Ullong local_abs_gnd = 0;
      Ullong local_coll_e = 0;
      Ullong local_coll_i = 0;
  };
  ```
* **Dedykowany Mikrobenchmark:**
  * **Plik:** `C/microbenchmarks/bench_false_sharing.cc`
  * **Konstrukcja:** Ciasna pętla $10^8$ iteracji wykonywana równolegle przez 1..64 wątki, inkrementująca lokalne liczniki.
  * **Wariant A:** Zwarta tablica liczników (współdzielona 64-bajtowa linia cache).
  * **Wariant B:** Struktury wyrównane do 64 bajtów z paddingiem (`alignas(64)`).
  * **Pomiary:** Całkowity czas wykonania oraz profil zdarzeń sprzętowych `perf stat -e cache-misses,L1-dcache-store-misses`. Bezpośrednie wykazanie eliminacji narzutu unieważnień cache.

---

### Krok 4: Architektura Trwałego Zespołu Wątków i Minimalizacja Barier Synchronizacyjnych (*Persistent Thread Team & `nowait`*)

* **Opis i mechanizm:**  
  W jednym cyklu RF występuje 4000 podkroków czasowych, a w każdym podkroku wykonuje się 8 kroków algorytmu PIC. Naiwne umieszczanie dyrektyw `#pragma omp parallel for` na każdej pętli oznacza tworzenie i niszczenie zespołu wątków (*fork-join*) **ponad 32 000 razy na cykl** (3.2 miliona razy w 100 cyklach!). Narzut biblioteki OpenMP zniszczyłby zysk ze zrównoleglenia. Dodatkowo domyślne niejawne bariery na końcu każdej pętli generują jałowe oczekiwanie.
  
  Optymalizacja polega na:
  1. **Trwałym zespole wątków (Persistent Thread Team):** Otwarcie **jednego nadrzędnego bloku `#pragma omp parallel` na cały okres RF (4000 kroków)** wewnątrz funkcji `do_one_cycle()`. Wątki są tworzone tylko raz na cykl, a synchronizacja odbywa się wyłącznie za pomocą lekkich barier sprzętowych `#pragma omp barrier` oraz sekcji `#pragma omp single`.
  2. **Klauzuli `nowait` na redukcjach:** Zastosowanie `#pragma omp for schedule(static) nowait` przy redukcji siatki, co pozwala wątkom natychmiast przejść do kolejnego kroku bez czekania na najwolniejszy rdzeń.
* **Eksperyment / Weryfikacja:**  
  Wykazanie redukcji narzutu tworzenia wątków w profilu czasowym `perf report` i FlameGraph.

---

### Krok 5: Strojenie Środowiska Wykonawczego OpenMP: Polityka Oczekiwania (`OMP_WAIT_POLICY=ACTIVE` vs `PASSIVE`)

* **Opis i mechanizm:**  
  Domyślnie w systemie Linux wątki po krótkim oczekiwaniu na barierze są przełączane w stan uśpienia przez kernel (wywołanie systemowe `futex`). W symulacji PIC/MCC mamy 4000 podkroków na cykl i częste bariery. Usypianie i wybudzanie wątków generuje lawinę przełączeń kontekstu (*voluntary context-switches*) i narzut opóźnień rzędu milisekund.
  
  Optymalizacja polega na wymuszeniu `OMP_WAIT_POLICY=ACTIVE`, co nakazuje wątkom aktywne wirowanie (*busy-spin*) w przestrzeni użytkownika, eliminując opóźnienia wybudzania.
* **Dedykowany Test na Klastrze Lem HPC (np. na 8 lub 16 rdzeniach):**
  * **Wariant A:** `OMP_WAIT_POLICY=PASSIVE` (usypianie w kernelu przez `futex`).
  * **Wariant B:** `OMP_WAIT_POLICY=ACTIVE` (aktywne wirowanie *busy-spin*).
  * **Pomiary w `perf stat`:**
    * Liczba przełączeń kontekstu `context-switches` (wykazanie setek tysięcy przełączeń w wariancie A vs **dokładnie 0** w wariancie B),
    * Całkowity czas wykonania 100 cykli symulacji,
    * Wskaźnik instrukcji na cykl (IPC).

---

### Krok 6: Analiza Skalowalności Silnej (Strong Scaling 1..128 rdzeni), Prawo Amdahla i Efekty Topologii NUMA

* **Opis i mechanizm:**  
  Zwieńczenie całej pracy nad silnikiem wielowątkowym C++ — uruchomienie w pełni zoptymalizowanego kodu [`C/parallel-only-omp/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp) na klastrze HPC (węzeł Lem z 2 procesorami AMD EPYC 9554, łącznie 128 rdzeni fizycznych, pamięć L3 po 32 MB na każde 8 rdzeni, 2 domeny NUMA):
  1. **Skalowanie silne (Strong Scaling):** Pomiary czasu wykonania 100 cykli symulacji dla $p \in \{1, 2, 4, 8, 16, 32, 64, 128\}$ rdzeni (po 3 powtórzenia per punkt). Punkt odniesienia: w pełni zoptymalizowany silnik jednordzeniowy ($T_1 \approx 148–161\text{ s}$). Wyznaczenie przyspieszenia $S(p) = T_1 / T_p$ oraz efektywności $E(p) = S(p)/p$.
  2. **Dopasowanie do Prawa Amdahla:** Wyznaczenie granicznej frakcji sekwencyjnej $s = 1 - P$ (część symulacji, która nie podlega zrównolegleniu — m.in. 1D solver Poissona, redukcje siatkowe i bariery) oraz asymptoty teoretycznego maksymalnego przyspieszenia $S_{\max} = 1/s$.
  3. **Wpływ topologii klastra i architektury CCX / NUMA:**
     * Wykazanie wpływu geometrii przydziału rdzeni przez Slurma na procesorach AMD EPYC: alokacja w obrębie 1 modułu CCX (wspólne 32 MB L3 cache $\to$ 19.5 s) vs Cross-CCX (przekraczanie granic L3 przez I/O Die $\to$ 22.7–24.7 s) vs Cross-Socket (przekraczanie granicy 64 rdzeni przez AMD Infinity Fabric $\to$ 29.5 s).
  4. **Profilowanie i ewolucja hotspotów:** Pomiary `perf record` i FlameGraph dla 1, 8, 32 i 64 rdzeni — wykazanie zaniku kosztu pushera i relatywnego wzrostu kosztu solwera Poissona i barier w profilu czasowym.
  5. **Weryfikacja Fizyczna (Golden Record):** Potwierdzenie zachowania gęstości centralnej ($n_c \approx 7.5 \times 10^{15}\text{ m}^{-3}$) oraz stabilności plazmowej ($\omega_{pe}\Delta t = 0.090$) w całym zakresie 1–128 rdzeni.
