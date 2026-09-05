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

### Rozdział 4. Zaawansowane Optymalizacje Numeryczne i Pamięciowe
* **4.1. Układ pamięci i hierarchia cache:**
  * Zastąpienie Array of Structures (AoS) strukturą **Structure of Arrays (SoA)** – lokalność pamięci L1/L2.
  * Zjawisko **False Sharing** i jego eliminacja przez 64-bajtowy padding linii pamięci podręcznej.
  * Eliminacja alokacji na stercie w pętli głównej (0 allocs/op) i neutralizacja Garbage Collectora w Go.
* **4.2. Optymalizacje numeryczne w pętlach czasowych:**
  * Prekomputacja stałych i eliminacja operacji dzielenia zmiennoprzecinkowego (`DIVSD`).
  * 1-mnożeniowa formuła interpolacji Cloud-in-Cell ($E_p + d(E_{p+1}-E_p)$) – oszczędność 40 mln mnożeń na cykl.
  * Trójdiagonalny solver Poissona `ThomasW` bez dzieleń w fazie eliminacji w przód.
* **4.3. Mikrooptymalizacje modułu zderzeń Monte Carlo:**
  * Fast-Path dla rezonansowej wymiany ładunku (`I_BACK`) – optymalizacja 80% zderzeń jonów.
  * Czysta algebra wektorowa bez wywołań funkcji transcedentnych (`atan2`, `sin`, `cos`).
  * Multiplikatywna selekcja typu zderzenia w metodzie Null-Collision.
* **4.4. Eliminacja testów granic tablic (Bounds Check Elimination - BCE) i Unrolling w Go.**

---

### Rozdział 5. Problem Wektoryzacji SIMD i Operacji Gather
* **5.1. Równoległość na poziomie instrukcji (ILP) a równoległość danych (DLP / SIMD):**
  * Dlaczego 4-krotny unroll pętli w Go nie zastępuje wektoryzacji AVX2.
  * Asymetria szczytowej mocy obliczeniowej (Peak FLOPS) rdzenia procesora.
* **5.2. Nielokalny dostęp do siatki w algorytmie PIC jako źródło operacji Gather:**
  * Chaotyczny ruch cząstek a rozproszenie indeksów siatki w pamięci RAM.
  * Dlaczego sortowanie cząstek (*cell binning*) jest nieefektywne czasowo.
* **5.3. Ograniczenia kompilatora Go `gc` i analiza bibliotek zewnętrznych:**
  * Profilowanie pprof: emulacja operacji gather przez stos i spadek wydajności o 28%.
* **5.4. Projekt i implementacja autorskiego kernela asemblera Plan 9 AVX2 (`push_amd64.s`):**
  * Zastosowanie sprzętowej instrukcji `VGATHERDPD` i wektorowego FMA.
  * Wyniki mikrobenchmarku: 4.53-krotne przyspieszenie w Go – dowód poprawności hipotezy.

---

### Rozdział 6. Wyniki Eksperymentalne i Analiza Skalowalności na Klastrze HPC
* **6.1. Charakterystyka środowiska pomiarowego:**
  * Architektura procesora AMD EPYC 9554 (Zen 4, 64 rdzenie, struktura CCX/NUMA, L3 Cache).
  * Konfiguracja systemu kolejkowego SLURM i metodyka eliminacji zakłóceń pomiarowych.
* **6.2. Weryfikacja poprawności fizycznej:**
  * Bitowa zgodność wyników (testy regresyjne `conv.dat`, zachowanie energii i gęstości).
* **6.3. Wyniki wydajności jednowątkowej (Single-Thread Performance):**
  * Bezpośrednie porównanie czasów wykonania poszczególnych kroków (Leap-Frog, Poisson, MCC).
* **6.4. Skalowalność silna i słaba (Strong and Weak Scaling):**
  * Pomiary przyspieszenia $S(p)$ i sprawności $E(p)$ dla konfiguracji 1, 2, 4, 8, 16, 32, 64 rdzeni.
  * Porównanie modelu OpenMP vs Go Chunking vs Go Channels.
* **6.5. Narzut środowiska uruchomieniowego i analiza Prawa Amdahla:**
  * Koszt synchronizacji schedulera Go M:N w skali klastra.
  * Wpływ nieparalelizowalnych ułamków kodu na asymetrię skalowania.

---

### Rozdział 7. Dyskusja Wyników i Wytyczne Inżynierskie
* **7.1. Koszt abstrakcji środowiska zarządzanego w obliczeniach HPC:**
  * Czy narzut Go jest akceptowalny w symulacjach fizycznych?
* **7.2. Porównanie produktywności programistycznej:**
  * Bezpieczeństwo pamięci, czytelność kodu, czas kompilacji vs czas wykonania (Go vs C++).
* **7.3. Rekomendacje dla inżynierii oprogramowania naukowego:**
  * W jakich scenariuszach Go może zastąpić C++, a gdzie C++ pozostaje bezkonkurencyjny.

---

### Rozdział 8. Podsumowanie i Wnioski Końcowe
* **8.1. Zestawienie osiągniętych rezultatów.**
* **8.2. Weryfikacja hipotez badawczych.**
* **8.3. Kierunki dalszych badań:**
  * Hybrydowy model Go + Assembler / CGO na GPU (CUDA/HIP).
  * Rozszerzenie modelu do geometrii 2D3V i zastosowanie wielowęzłowego MPI.
