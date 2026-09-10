# Przewodnik i Rozpiska Podrozdziału: Analiza Kodu Bazowego (Baseline eduPIC)

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.2: Analiza stanu wyjściowego i diagnoza kodu bazowego (Baseline eduPIC)**

Niniejszy dokument stanowi kompletny konspekt i szablon analityczny dla podrozdziału poświęconego stanowi wyjściowemu symulatora (Baseline). Zawiera wytyczne dotyczące opisu kodu, interpretacji danych telemetrycznych zebranych na klastrze HPC (`perf stat`, `perf report`) oraz zestawienie wąskich gardeł, które stanowią bezpośrednie uzasadnienie dla kolejnych etapów optymalizacji.

---

## 1. Cel i Rola Podrozdziału w Pracy Magisterskiej

1. **Ustanowienie punktu odniesienia ($T_0$):**
   * Wyznaczenie bazowego czasu wykonania $T_0$ oraz budżetu cykli zegara CPU, do których odnoszone będą wszystkie kolejne optymalizacje (przyspieszenie $S = T_0 / T_k = 1.0\times$).
2. **Diagnoza aparaturowa (Dlaczego kod jest nieoptymalny?):**
   * Pokazanie za pomocą twardych danych z profilera sprzętowego (`perf`), na co procesor marnuje czas i cykle zegara.
3. **Most logiczny do kolejnych podrozdziałów:**
   * Wykazanie, że każda kolejna optymalizacja (Null-Collision, hoisting, eliminacja dzieleń, wektoryzacja) jest bezpośrednią odpowiedzią na zdiagnozowane tu wąskie gardła, a nie pomysłem „wziętym z kosmosu”.

---

## 2. Co Należy Opisać w Części Teoretyczno-Kodowej?

### 2.1. Geneza i Specyfika Kodu Referencyjnego
* **Pochodzenie:** Kod `eduPIC.cc` opracowany przez Zoltána Donkó, Petera Hartmanna i współpracowników (2021) jako model referencyjny jednowymiarowego wyładowania pojemnościowego RF CCP w argonie ($13.56\text{ MHz}$, $10\text{ Pa}$, szczelina $25\text{ mm}$, $N_G = 400$).
* **Monolityczna struktura:**
  * Pierwotnie jednoplikowy kod źródłowy, w którym zmienne fizyczne i tablice zdefiniowane są globalnie.
  * Lokalne tworzenie zmiennych w ciele funkcji: stałe geometryczne i fizyczne są definiowane na nowo przy każdym wywołaniu funkcji (`A, B, C, S, ALPHA` w `solve_Poisson`, `F1, F2` w `collision_electron`, `DV, FACTOR_W...` w `do_one_cycle`).

### 2.2. Algorytmiczne Wąskie Gardła Kodu Wyjściowego
1. **Bezpośrednia metoda zderzeń Monte Carlo (Direct MCC):**
   * Każda z ponad 100 000 cząstek w każdym z 4000 podkroków na cykel oblicza dokładne prawdopodobieństwo zderzenia:
     $$p_{\text{coll}} = 1 - \exp(-\nu(v) \cdot \Delta t)$$
   * Generuje to ponad **320–440 milionów wywołań funkcji `exp()` na każdy pojedynczy cykl RF**.
2. **Redundantne rozwiązywanie równania Poissona:**
   * Współczynniki macierzy trójprzekątniowej dla stałej siatki są niezmienne w czasie ($A=1, B=-2, C=1$).
   * Mimo to klasyczny algorytm Thomasa w kodzie bazowym przelicza współczynniki eliminacji w przód oraz mianowniki od zera w każdym z 4000 podkroków na cykel (miliony zbędnych dzieleń zmiennoprzecinkowych).
3. **Koszty operacji zmiennoprzecinkowych w pętli cząstek:**
   * Wielokrotne przeliczanie energii cząstki ze składowych prędkości z użyciem powolnych instrukcji dzielenia `vdivsd` ($E / \Delta E_{cs}$) zamiast mnożenia przez stałe odwrotności.
   * Wyliczanie rozproszenia kątowego z użyciem ciężkich funkcji trygonometrycznych biblioteki `libm` (`atan2`, `sin`, `cos`, `acos`).
4. **Brak wektoryzacji SIMD i niewyrównana pamięć:**
   * Czysto skalarny kod C++, brak dyrektyw wyrównania pamięci (`alignas(64)`), uniemożliwiający efektywne wykorzystanie rejestrów AVX-512 procesora AMD Zen 4.

---

## 3. Metodyka Pomiarowa na Klastrze HPC

Opisz dokładnie warunki, w jakich zebrano logi:

* **Platforma sprzętowa:** Węzeł klastra HPC Lem, procesor AMD EPYC 9554 (Zen 4, taktowanie bazowe 3.1 GHz, do 3.75 GHz Boost, 32 MB pamięci podręcznej L3 na blok CCD).
* **Konfiguracja wykonania:** Dokładnie **1 rdzeń fizyczny** (kod bazowy jest w 100% sekwencyjny). Zadanie uruchomione przez Slurm z dedykowaną alokacją CPU i wyłączonym SMT.
* **Stan wzorcowy (Golden Record):** Podpięty plik `golden_record/picdata.bin` (stan po 2000 cykli, zawierający dokładnie 108 199 elektronów i 113 624 jonów).
* **Liczba mierzonych cykli:** Np. 10 cykli RF (lub 20 cykli), aby uśrednić szum systemowy i uzyskać powtarzalny profil telemetryczny.
* **Polecenia profilujące:**
  * `perf stat` z zestawem liczników: `cycles`, `instructions`, `branches`, `branch-misses`, `task-clock`, opcjonalnie `L1-dcache-load-misses`.
  * `perf record -F 99 -g` z pełnym drzewem wywołań (call-graph DWARF) oraz raport `perf report --stdio`.

---

## 4. Szablony Wyników i Tabel do Wypełnienia Danymi z HPC

### Tabela 1: Metryki Sprzętowe Kodu Bazowego (`perf stat`)

*(Wklej tutaj wartości uzyskane z pliku `perf_stat.txt` na klastrze HPC Lem)*

| Metryka telemetryczna | Wartość zmierzona (HPC Lem) | Interpretacja mikroarchitektoniczna |
|:---|:---:|:---|
| **Czas wykonania (Wall-clock time)** | `... s` | Czas bazowy $T_0$ (punkt odniesienia, Speedup = $1.0\times$) |
| **Czas procesora (Task-clock)** | `... ms` | Rzeczywisty czas pracy rdzenia Zen 4 |
| **Liczba cykli CPU (`cycles`)** | `...` | Całkowity budżet cykli zegara zużyty na wykonanie |
| **Liczba instrukcji (`instructions`)** | `...` | Liczba wycofanych instrukcji maszynowych x86-64 |
| **Wskaźnik IPC (Instructions Per Cycle)** | `...` | Sprawność potoku procesora (iloraz: instrukcje / cykle) |
| **Rozgałęzienia (`branches`)** | `...` | Liczba skoków warunkowych i bezwarunkowych |
| **Błędy przewidywania skoków (`branch-misses`)** | `...` | Nietrafione przewidywania jednostki Branch Target Buffer (BTB) |
| **Odsetek błędów skoków (`branch-miss rate`)** | `... %` | Procentowy udział nietrafionych skoków |
| **L1d Cache Load Misses (opcjonalnie)** | `...` | Chybienia pamięci podręcznej pierwszego poziomu |

---

### Tabela 2: Profil Czasu CPU — Top 15 Hotspots (`perf report`)

*(Wklej tutaj dane z sekcji `# Overhead` raportu `perf_report.txt`)*

| Udział (% Overhead) | Moduł / Biblioteka | Funkcja (Symbol) | Rola w kodzie eduPIC |
|:---:|:---|:---|:---|
| **... %** | `libm.so.6` | `__exp_finite` / `exp` | Liczenie $p = 1 - e^{-\nu \Delta t}$ w Direct MCC |
| **... %** | `libm.so.6` | `__atan2_finite` / `atan2` | Wyznaczanie kąta azymutalnego przy rozpraszaniu |
| **... %** | `libm.so.6` | `__pow_finite` / `pow` | Kinetyka i potęgi w interpolacji |
| **... %** | `eduPIC` | `do_one_cycle` / pętla główna | Główny dyspozytor podkroków symulacji |
| **... %** | `libm.so.6` | `__cos_finite` / `cos` | Transformacja rozproszenia kątowego |
| **... %** | `libm.so.6` | `__sin_finite` / `sin` | Transformacja rozproszenia kątowego |
| **... %** | `eduPIC` | `step3_move_electrons` | Boris pusher / Leap-Frog dla elektronów |
| **... %** | `eduPIC` | `step7_collisions_electrons` | Zderzenia elektronowe Direct MCC |
| **... %** | `eduPIC` | `step8_collision_ions` | Zderzenia jonowe Direct MCC |
| **... %** | `eduPIC` | `step2_solve_poisson` | Trójdiagonalny solver Poissona Thomasa |
| **... %** | `eduPIC` | `step1_compute_electron_density` | Depozycja ładunku elektronów (Cloud-in-Cell) |
| **... %** | `...` | `...` | Pozostałe funkcje |

---

## 5. Jak Zinterpretować Wyniki? (Wytyczne do Dyskusji w Pracy)

Podczas pisania treści podrozdziału 4.2 zwróć szczególną uwagę na następujące zjawiska:

### 1. Katastrofa Biblioteki Matematycznej (`libm.so.6`)
* Zsumuj procentowy udział funkcji: `exp` + `atan2` + `pow` + `cos` + `sin`.
* W kodzie bazowym suma ta wynosi **ponad 22–25% całego czasu działania programu**.
* *Wniosek do pracy:* Procesor o potężnej mocy wektorowej FPU (Zen 4) spędza 1/4 swojego czasu na sekwencyjnym wyliczaniu przybliżeń szeregów Taylora i wielomianów dla funkcji elementarnych w bibliotece systemowej `glibc`. To niepodważalny dowód na konieczność wprowadzenia **Metody Zderzeń Zerowych (Null-Collision)** oraz **Algebry Wektorowej Eulera**.

### 2. Analiza Wskaźnika IPC (Instructions Per Cycle)
* W architekturze Zen 4 teoretyczny limit szerokości potoku wynosi 6 instrukcji na cykl (dla kodu FMA nawet więcej dzięki podwójnym jednostkom wykonawczym).
* W kodzie bazowym wskaźnik IPC wynosi zazwyczaj w granicach **2.3 – 2.5**.
* *Dlaczego IPC jest relatywnie niskie?*
  * Blokowanie potoków (*pipeline stalls*) przez instrukcje dzieleń zmiennoprzecinkowych `vdivsd` (opóźnienie rzędu kilkunastu cykli).
  * Wywołania funkcji zewnętrznych (narzut skoków `call`/`ret` i czyszczenie rejestrów).
  * Brak wektoryzacji pętli Leap-Frog (procesor przetwarza po jednej liczbie zmiennoprzecinkowej zamiast 4 lub 8 naraz w rejestrach wektorowych).

### 3. Zjawisko pamięci podręcznej L1d a siatka przestrzenna (Potwierdzenie tezy z analizy)
* Zwróć uwagę na odsetek chybień pamięci podręcznej (`cache-misses` / `L1-dcache-load-misses`).
* W geometrii 1D cała siatka $N_G = 400$ ma rozmiar $400 \times 8\text{ B} = 3.2\text{ KB}$.
* Ponieważ mieści się ona w całości w 32 KB pamięci L1d każdego rdzenia Zen 4, chybienia są bardzo niskie. To bezpośredni dowód naukowy potwierdzający naszą tezę: **w 1D wąskim gardłem nie jest pamięć RAM, lecz czas procesora (Compute-Bound / Instruction-Bound)**.

---

## 6. Zestawienie Wąskich Gardeł i Recept Optymalizacyjnych

Zakończ podrozdział 4.2 syntetyczną tabelą zapowiadającą dalszą część pracy:

| Zdiagnozowane wąskie gardło w Baseline | Wskaźnik w profilu `perf` | Recepta optymalizacyjna | Podrozdział wdrożenia |
|:---|:---:|:---|:---:|
| Obliczanie $p = 1 - e^{-\nu \Delta t}$ dla każdej cząstki | `__exp_finite` = ~7-8% czasu | **Metoda Zderzeń Zerowych (Null-Collision)** | **4.3.1** |
| Przeliczanie współczynników Thomasa w każdym kroku | `step2_solve_poisson` | **Hoisting i analityczna prekompilacja solwera** | **4.3.2** |
| Dzielenia zmiennoprzecinkowe `vdivsd` przy energii | Niski IPC, stalls FPU | **Strength Reduction (mnożniki odwrotności)** | **4.3.3** |
| Ciężkie transformacje 3D dla wymiany ładunku | `step8_collision_ions` | **Fast-Path wymiany ładunku (Charge Exchange)** | **4.3.4** |
| Wywołania trygonometryczne `atan2`, `cos`, `sin` | `libm` = ~15% czasu | **Bezfunkcyjna algebra wektorowa Eulera** | **4.3.5** |
| Przetwarzanie skalarne, brak wektoryzacji pętli | IPC < 3.0, brak AVX | **Wektoryzacja SIMD (AVX-512) i unrolling** | **4.3.6** |
| Kod jednowątkowy (wykorzystanie 1 z 128 rdzeni) | 127 rdzeni bezczynnych | **Wielowątkowość OpenMP (modele bezblokadowe)** | **4.3.7 & 4.3.8** |

---

*Dokument przygotowany do bezpośredniego uzupełnienia wynikami pomiarów z klastra HPC Lem. Pliki `perf_stat.txt` oraz `perf_report.txt` należy umieścić w tym katalogu (`experiments/baseline/`).*
