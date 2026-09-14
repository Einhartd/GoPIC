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

### Prywatyzacja Generatora Liczb Losowych (Thread-Local PRNG)

* **Opis i mechanizm:**
  W symulacji PIC/MCC generator liczb pseudolosowych jest wywoływany w każdym kroku dla zderzeń, losowania cząstek termicznych z rozkładu Maxwella-Boltzmanna oraz rozpraszania kątowego. Współdzielenie pojedynczego obiektu `std::mt19937` pomiędzy wątki wymagałoby synchronizacji muteksem (`std::mutex` lub `#pragma omp critical`), co prowadzi do całkowitej serializacji wykonania i katastrofalnego spadku wydajności (*lock contention*).
  Optymalizacja polega na przydzieleniu każdemu wątkowi OpenMP niezależnej instancji generatora za pomocą specyfikatora pamięci lokalnej wątku:
  ```cpp
  inline thread_local std::mt19937 MTgen(rd());
  inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
  ```
  Każdy wątek losuje liczby w 100% bezblokadowo z prywatnego bufora rejestrów/stosu.
* **Mikrobenchmark:**
  * **Plik:** `C/microbenchmarks/bench_prng_concurrency.cc`
  * **Konstrukcja:** Wielowątkowa pętla generująca łącznie 100 milionów liczb losowych z rozkładu jednorodnego oraz Maxwella-Boltzmanna na 1, 2, 4, 8, 16, 32 i 64 wątkach.
  * **Wariant A:** Jeden wspólny `std::mt19937` zabezpieczony sekcją krytyczną `#pragma omp critical`.
  * **Wariant B:** `thread_local std::mt19937` z niezależnym stanem per wątek.
  * **Pomiary:** Czas wykonania, przepustowość losowań (miliony próbek/sekundę) w funkcji liczby wątków. Zademonstrowanie załamania skalowania wariantu A powyżej 2 wątków.

---

### Prywatyzacja Tablic Depozycji Siatki (WorkerBuffers & Parallel Reduction dla Scatter-Add)

* **Opis i mechanizm:**
  Operacja depozycji ładunku cząstek na siatkę przestrzenną (*scatter-add*) metodą Cloud-in-Cell polega na rozdzielaniu ładunku cząstki pomiędzy dwa sąsiadujące węzły siatki: $p$ oraz $p+1$. Ponieważ cząstki poruszają się swobodnie, wiele wątków przetwarzających różne cząstki próbuje jednocześnie zmodyfikować tę samą komórkę siatki. Naiwne użycie `#pragma omp atomic` powoduje nasycenie magistrali spójności pamięci podręcznej i drastyczny spadek wydajności.
  Optymalizacja polega na zastosowaniu wzorca buforów prywatnych (*thread-private grid buffers*):
  1. Każdy wątek posiada własną tablicę `worker_buffers.e_density[tid][N_G]`.
  2. Depozycja cząstek odbywa się w całości w lokalnej pamięci podręcznej L1d rdzenia (rozmiar bufora to $400 \times 8\text{ B} = 3.2\text{ KB}$, co idealnie mieści się w 32 KB L1d).
  3. Po zakończeniu pętli cząstek następuje szybka, równoległa redukcja węzłów siatki: wątki dzielą między siebie węzły $p \in [1, N_G-2]$ i sumują wiersze buforów prywatnych do tablicy globalnej.
* **Mikrobenchmark:**
  * **Plik:** `C/microbenchmarks/bench_scatter_add.cc`
  * **Konstrukcja:** Równoległa depozycja ładunku 1 miliona cząstek o losowych pozycjach do siatki 400 węzłów, powtórzona 1000 razy na 1, 2, 4, 8, 16, 32, 64 wątkach.
  * **Wariant A:** Bezpośrednia depozycja do wspólnej tablicy z użyciem `#pragma omp atomic`.
  * **Wariant B:** Prywatne bufory `e_density[tid]` w pamięci podręcznej L1d z końcową redukcją równoległą.
  * **Pomiary:** Czas wykonania, skalowanie przyspieszenia, pomiar unieważnień linii cache za pomocą `perf stat -e cache-misses,L1-dcache-load-misses`.

---

### Eliminacja False Sharing i Izolacja Linii Pamięci Podręcznej (alignas(64) Padding)

* **Opis i mechanizm:**
  W symulacji wielowątkowej każdy wątek zlicza lokalne statystyki: liczbę zaabsorbowanych cząstek na elektrodach, liczbę zderzeń oraz próbki energii. Gdyby liczniki te zostały umieszczone w zwartej tablicy (np. `double counters[num_threads]`), zmienne należące do różnych rdzeni znalazłyby się w tej samej 64-bajtowej linii pamięci podręcznej. Zapis przez rdzeń $A$ powoduje unieważnienie całej linii cache w rdzeniu $B$ (*False Sharing*), wywołując nieustanny ruch na magistrali Infinity Fabric procesora.
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
* **Mikrobenchmark:**
  * **Plik:** `C/microbenchmarks/bench_false_sharing.cc`
  * **Konstrukcja:** 64 wątki wykonują ciasną pętlę $10^8$ iteracji, inkrementując swój prywatny licznik.
  * **Wariant A:** Zwykła, zwarta tablica struktur lub skalary umieszczone obok siebie w pamięci (współdzielona linia cache).
  * **Wariant B:** Struktury wyrównane do 64 bajtów z paddingiem (`alignas(64)`).
  * **Pomiary:** Całkowity czas wykonania, profil zdarzeń sprzętowych `perf stat -e cache-misses,L1-dcache-store-misses`.

---

### Bezkonfliktowe Zarządzanie Cyklem Życia Cząstek (Narodziny i Granice)

* **Opis i mechanizm:**
  W symulacji cząstki dynamicznie powstają (procesy jonizacji) oraz giną (absorpcja na elektrodach $x < 0$ lub $x > L$):
  1. **Narodziny cząstek:** Zamiast chronić globalny rozmiar tablicy $N_e$ sekcją krytyczną `#pragma omp critical` przy każdym zderzeniu jonizacyjnym, każdy wątek zapisuje współrzędne nowych cząstek do prywatnej statycznej tablicy `NewParticles` (bufor o stałym rozmiarze 4096 elementów, zero alokacji dynamicznych na stercie). Po zakończeniu pętli cząstki są seryjnie dopisywane do tablic globalnych w jednym bloku.
  2. **Sprawdzanie granic i absorpcja:** W kodzie sekwencyjnym usuwanie cząstki polega na natychmiastowym zamienieniu jej z ostatnią cząstką tablicy (`swap-with-last`). W wersji wielowątkowej powodowałoby to konflikt zapisu na indeksie $N_e$. Zastosowano algorytm dwuetapowy:
     - **Faza 1 (Równoległa):** Wątki równolegle sprawdzają warunek $x < 0 \lor x > L$ i zapisują wyłącznie indeksy cząstek martwych do bufora `absorbed_indices[tid]`.
     - **Faza 2 (Kompaktacja):** Pojedynczy wątek za pomocą szybkiego algorytmu dwuwskanikowego (`last_valid`) przepisuje ostatnie żywe cząstki w miejsca martwych, minimalizując liczbę operacji kopiowania pamięci.
* **Mikrobenchmark:**
  * **Plik:** `C/microbenchmarks/bench_particle_lifecycle.cc`
  * **Konstrukcja:** Równoległa pętla przetwarzająca 500 000 cząstek, w której losowy odsetek cząstek ($1\%$) ginie, a $1\%$ cząstek tworzy nowe pary elektron-jon.
  * **Wariant A:** Bezpośrednie modyfikacje tablicy z użyciem `#pragma omp critical` i dynamicznego `std::vector::push_back`.
  * **Wariant B:** Bufory prywatne `NewParticles` oraz dwuwskanikowa kompaktacja in-place.
  * **Pomiary:** Czas wykonania, skalowanie na 1 .. 64 wątkach, stabilność zużycia pamięci RAM (eliminacja narzutu alokatora sterty).

---

### Strategie Harmonogramowania Pętli Cząstkowych (Scheduling & Load Balancing)

* **Opis i mechanizm:**
  W wyładowaniu wysokiej częstotliwości (RF) rozkład przestrzenny cząstek jest wysoce niejednorodny — w centralnej części szczeliny gęstość plazmy jest wysoka (dużo zderzeń), natomiast przy elektrodach występują warstwy ładunku przestrzennego (*sheath*) niemal całkowicie pozbawione elektronów. Przy podziale cząstek na równe fragmenty (`schedule(static)`) wątki obsługujące cząstki w obszarze plazmy wykonują więcej pracy niż wątki obsługujące warstwy przyelektrodowe (*load imbalance*).
  Badanie polega na analizie strategii harmonogramowania OpenMP:
  - `schedule(static)` — zerowy narzut synchronizacji, ale ryzyko nierównomiernego obciążenia.
  - `schedule(dynamic, chunk)` — dynamiczne przydzielanie paczek cząstek, eliminujące nierówność kosztem narzutu synchronizacji kolejki zadań.
  - `schedule(guided)` — paczki o malejącym rozmiarze, kompromis między narzutem a równowagą.
* **Mikrobenchmark:**
  * **Plik:** `C/microbenchmarks/bench_loop_scheduling.cc`
  * **Konstrukcja:** Równoległa pętla Boris pushera i zderzeń dla niejednorodnego rozkładu przestrzennego cząstek (funkcja gęstości o kształcie parabolicznym z gęstym centrum).
  * **Pomiary:** Całkowity czas wykonania pętli oraz odchylenie standardowe czasu pracy poszczególnych wątków w zespole na 16, 32 i 64 rdzeniach.

---

### Analiza Skalowalności Silnej, Prawo Amdahla i Efekty Topologii NUMA

* **Opis i mechanizm:**
  Zwieńczenie całej pracy badawczej — uruchomienie w pełni zoptymalizowanego silnika wielowątkowego (`C/parallel-only-omp/`) na pełnej symulacji na klastrze HPC (węzeł Lem z 2 procesorami AMD EPYC 9554, łącznie 128 rdzeni fizycznych, pamięć L3 po 32 MB na każde 8 rdzeni, 2 domeny NUMA):
  1. **Skalowanie silne (Strong Scaling):** Pomiary czasu wykonania 100 cykli symulacji dla $p \in \{1, 2, 4, 8, 16, 32, 64, 128\}$ rdzeni.
  2. **Dopasowanie do Prawa Amdahla:** Wyznaczenie przyspieszenia $S(p) = T_1 / T_p$, efektywności $E(p) = S(p)/p$ oraz wyznaczenie granicznej frakcji sekwencyjnej $s = 1 - P$ (część symulacji, która nie podlega zrównolegleniu — m.in. 1D solver Poissona i bariery synchronizacyjne).
  3. **Wpływ topologii NUMA i powinowactwa wątków:**
     - `OMP_PROC_BIND=close` (upakowanie wątków w obrębie jednego procesora / wspólnego bloku L3).
     - `OMP_PROC_BIND=spread` (równomierne rozproszenie wątków po gniazdach NUMA w celu nasycenia kontrolerów pamięci RAM).
     - Przekroczenie granicy 64 rdzeni (skalowanie cross-socket przez łącze AMD Infinity Fabric).
* **Eksperyment / Weryfikacja:**
  Uruchomienie zadań wsadowych Slurm na klastrze Lem (`GoPIC_jobs/C/edupic_job_stat.sh`, `edupic_job_record.sh`). Generowanie wykresów skalowania, raportów `perf stat` oraz profili FlameGraph dla 1, 8, 32, 64 i 128 rdzeni. Weryfikacja osiągnięcia docelowego rekordowego czasu wykonania symulacji (~13.89 s na 32 rdzeniach vs ponad 500 s w kodzie bazowym).
