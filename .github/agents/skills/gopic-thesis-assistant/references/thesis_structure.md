# Propozycja Struktury i Spisu Treści Pracy Dyplomowej

Poniższa propozycja struktury pracy naukowej / dyplomowej (inżynierskiej lub magisterskiej) została opracowana na podstawie zrealizowanych badań, eksperymentów optymalizacyjnych i analizy wyników w projekcie **GoPIC**.

---

## Proponowane Tytuły Pracy

1. **Wariant formalny (Inżynieria Oprogramowania / HPC):**  
   *„Analiza porównawcza wydajności i skalowalności języków Go i C++ w symulacjach fizyki plazmy metodą Particle-in-Cell na wielordzeniowych architekturach HPC”*
2. **Wariant fizyczno-obliczeniowy:**  
   *„Wielowątkowa symulacja kinetyczna wyładowania RF metodą PIC/MCC: studium optymalizacji mikroarchitektonicznych i kosztu abstrakcji środowisk uruchomieniowych Go i C++”*
3. **Wariant w języku angielskim:**  
   *„Comparative Performance and Scalability Analysis of Go and C++ in Particle-in-Cell Plasma Simulations on Modern HPC Architectures”*

---

## Szczegółowy Spis Treści

### Rozdział 1. Wstęp i Cel Pracy
* **1.1. Motywacja badawcza:** Wzrost znaczenia języków z zarządzanym środowiskiem uruchomieniowym w obliczeniach inżynierskich; wyzwania związane z wydajnością w modelowaniu plazmy.
* **1.2. Problem badawczy:** Czy język Go może stanowić wydajną, bezpieczną i skalowalną alternatywę dla C++/OpenMP w symulacjach typu Particle-in-Cell?
* **1.3. Cele i zakres pracy:**
  * Implementacja równoległego silnika PIC/MCC 1D3V w Go (warianty Chunking oraz Channels).
  * Osiągnięcie ekwiwalentności optymalizacji algorytmiczno-pamięciowych względem C++ OpenMP.
  * Zbadanie ograniczeń wektoryzacji SIMD (problem operacji Gather) w kompilatorze Go.
  * Przeprowadzenie kompleksowych testów skalowalności na klastrze HPC z procesorem AMD EPYC Zen 4.
* **1.4. Struktura pracy:** Zwięzłe omówienie zawartości kolejnych rozdziałów.

---

### Rozdział 2. Podstawy Teoretyczne Modelowania Plazmy Metodą PIC/MCC
* **2.1. Fizyka wyładowań pojemnościowych w gazach szlachetnych (RF CCP w argonie):**
  * Warstwa ładunku przestrzennego (*sheath dynamics*), zjawisko nagrzewania stochastycznego i omowego.
* **2.2. Układ równań Własowa-Poissona:**
  * Formalizm kinetyczny, przejście od równania ciągłości do dyskretnego układu supercząstek.
* **2.3. Algorytm Particle-in-Cell (PIC 1D3V):**
  * Cykl obliczeniowy PIC: depozycja ładunku (Scatter / CIC), rozwiązanie równania Poissona, interpolacja siły (Gather), całkowanie równań ruchu (Leap-Frog).
  * Technika Subcyclingu dla jonów ($N_{\text{SUB}}=10$) i jej uzasadnienie fizyczne (stosunek mas $m_{Ar}/m_e \approx 73400$).
* **2.4. Model Zderzeń Monte Carlo (MCC / Null-Collision):**
  * Metoda zerowych zderzeń (Vahedi & Surendra).
  * Przekroje czynne Phelpsa dla argonu (zderzenia sprężyste, wzbudzenia, jonizacja, wymiana ładunku).

---

### Rozdział 3. Architektura Systemu i Paradygmaty Równoległości
* **3.1. Projekt referencyjny C++ z biblioteką OpenMP:**
  * Model pamięci współdzielonej, dyrektywy `#pragma omp parallel for`, statyczny podział pracy, natywne bariery synchronizacyjne.
* **3.2. Implementacja w języku Go – Wariant Chunking (`parallel_chunking`):**
  * Podział przestrzeni iteracyjnej na chunki, dynamiczne tworzenie goroutines na krok czasowy, synchronizacja barierowa przez `sync.WaitGroup`.
* **3.3. Implementacja w języku Go – Wariant Channels (`parallel_channels`):**
  * Architektura puli trwałych wątków roboczych (*persistent worker pool*), bezalokacyjna komunikacja zdarzeniowa przez kanały `chan struct{}` (paradygmat CSP).
* **3.4. Implementacje edukacyjne i referencyjne w języku Python:**
  * Wersja czysto skryptowa a wersja wektoryzowana NumPy / Numba – rola Global Interpreter Lock (GIL).

---

### Rozdział 4. Eksperymentalna Optymalizacja i Analiza Wydajności w Językach C++ oraz Go
*(Główny rozdział badawczo-eksperymentalny pracy. Każda optymalizacja posiada autonomiczny podrozdział z 5-elementowym schematem: Motywacja -> Rozwiązanie -> Eksperyment -> Telemetria -> Walidacja fizyczna. Szczegóły w `experiments/struktura_rozdzialu_pracy_magisterskiej.md`)*

* **4.1. Analiza stanu wyjściowego i diagnoza kodu bazowego (Baseline):**
  * 4.1.1. Środowisko badawcze, aparatura telemetryczna (`perf`) i stan wzorcowy (Golden Record).
  * 4.1.2. Charakterystyka modularnego kodu referencyjnego eduPIC i metoda bezpośrednia Direct MCC.
  * 4.1.3. Profilowanie sprzętowe i identyfikacja wąskich gardeł (Stan $T_0$, bazowe IPC = 2.51, dominacja `libm`).
* **4.2. Ścieżka optymalizacji silnika w języku C++ (OpenMP i SIMD):**
  * 4.2.1. Algorytmiczna redukcja zderzeń kinetycznych: Metoda Zderzeń Zerowych (Null-Collision).
  * 4.2.2. Hoisting niezmienników pętli i analityczna prekompilacja solwera Poissona (Thomas solver).
  * 4.2.3. Redukcja siły operacji (Strength Reduction) i eliminacja dzieleń zmiennoprzecinkowych.
  * 4.2.4. Dedykowana ścieżka szybkiej obsługi (Fast-Path) zderzeń wymiany ładunku (Charge Exchange).
  * 4.2.5. Bezfunkcyjna algebra wektorowa kątów rozproszenia Eulera.
  * 4.2.6. Wektoryzacja SIMD (AVX-512), wyrównanie pamięci (`alignas(64)`) i 4-krotne rozwinięcie pętli.
  * 4.2.7. Mechanizmy współbieżności OpenMP (PRNG thread-local, WorkerBuffers scatter-add, eliminacja False Sharing, cykl życia cząstek).
  * 4.2.8. Badanie skalowalności silnej i weryfikacja Prawa Amdahla na klastrze HPC (rekord **13.89 s**, analiza barier `libgomp` i NUMA).
* **4.3. Ścieżka optymalizacji i architektura współbieżna w języku Go:**
  * 4.3.1. Przeniesienie silnika do Go i gospodarka pamięcią (Zero-Alloc SoA, neutralizacja GC).
  * 4.3.2. Model dynamiczny: Goroutyny per-krok (`parallel_chunking`, `sync.WaitGroup`, eksplozja futexów).
  * 4.3.3. Model trwały: Pula workerów sterowana kanałami (`parallel_channels`).
  * 4.3.4. Dedykowana bariera użytkownika `StarBarrier` ze spin-lockiem i instrukcją `PAUSE` (`parallel_optimized`, rekord **20.72 s**).
  * 4.3.5. Problem braku autowektoryzacji w Go, emulacja gather i autorski kernel w asemblerze Plan 9 AVX2 (`push_amd64.s`).
  * 4.3.6. Skalowalność Go na klastrze HPC i interakcja ze schedulerem GMP.
* **4.4. Bezpośrednie porównanie międzyjęzykowe (C++ vs Go) i dyskusja wyników:**
  * 4.4.1. Zestawienie wydajnościowe na 1–64/128 rdzeniach (C++ 13.89 s vs Go 20.72 s).
  * 4.4.2. Rzeczywisty koszt abstrakcji środowiska zarządzanego (narzut $1.49\times$, GC, GMP vs OpenMP).
  * 4.4.3. Skumulowany wykres kaskadowy przyspieszenia (Waterfall Chart).
  * 4.4.4. Rekomendacje inżynierskie dla symulacji HPC w języku Go.

---

### Rozdział 5. Podsumowanie i Wnioski Końcowe
* **5.1. Zestawienie osiągniętych rezultatów.**
* **5.2. Weryfikacja hipotez badawczych.**
* **5.3. Kierunki dalszych badań:**
  * Hybrydowy model Go + Assembler / CGO na GPU (CUDA/HIP).
  * Rozszerzenie modelu do geometrii 2D3V i wielowęzłowego MPI.
