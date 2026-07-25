# Analiza Profilowania i Strategia Zrównoleglenia Kodu C/C++ (eduPIC)

Niniejszy raport zawiera szczegółową analizę sekwencyjnego kodu źródłowego w katalogu `C/` projektu eduPIC. Każdy plik nagłówkowy oraz wchodzące w jego skład funkcje, struktury danych i zmienne zostały przeanalizowane pod kątem opłacalności zrównoleglenia (wykorzystując np. OpenMP).

---

## 1. constants.h (Stałe i Definicje Typów)
Plik zawiera definicje fizycznych stałych, parametrów symulacji oraz typów struktur danych (tablice cząstek o stałym rozmiarze `MAX_N_P = 1 000 000`).

*   **Zmienne/Stałe**: `MAX_N_P`, `N_G`, `N_T`, `particle_vector` itp.
*   **Ocena opłacalności**: **N/A (Brak kodu wykonywalnego)**
*   **Wyzwanie**: Zmienne `particle_vector` to statyczne tablice o rozmiarze 1 000 000 elementów typu double (np. `x_e`, `vx_e`). Ułatwia to dostęp do pamięci, ale wymusza alokację pamięci o stałym rozmiarze na stercie/pamięci globalnej.

---

## 2. state.h (Globalny Stan Symulacji)
Zawiera deklaracje globalnych zmiennych reprezentujących stan fizyczny układu (współrzędne cząstek, pola, rozkłady diagnostyczne oraz generatory liczb losowych).

*   **Elementy**: `x_e`, `vx_e`, `x_i`, `vx_i`, `efield`, `pot`, diagnostyki XT (`pot_xt`, `ne_xt`, itp.), generator `MTgen`.
*   **Ocena opłacalności**: **N/A** (Plik deklaratywny).
*   **Wyzwanie wielowątkowości**: 
    1.  **Generator liczb losowych `MTgen`**: Standardowy `std::mt19937` **nie jest bezpieczny wątkowo**. Równoległe wywoływanie `R01(MTgen)` z różnych wątków doprowadzi do uszkodzenia stanu generatora i błędów. *Rozwiązanie*: Każdy wątek musi posiadać swój własny, niezależny generator liczb losowych (np. tablicę generatorów indeksowaną identyfikatorem wątku OpenMP `omp_get_thread_num()`).
    2.  **Globalne diagnostyki**: Równoległy zapis do np. `ne_xt` czy `counter_e_xt` przez wiele wątków spowoduje wyścig o dane (Data Race).

---

## 3. cross_sections.h (Przekroje Czynne i Częstotliwości)
Zawiera funkcje do prekomputacji przekrojów czynnych zderzeń z argonem oraz wyliczania maksymalnej częstotliwości zderzeń.

*   **Funkcje**: `set_electron_cross_sections_ar()`, `set_ion_cross_sections_ar()`, `calc_total_cross_sections()`, `max_electron_coll_freq()`, `max_ion_coll_freq()`.
*   **Ocena opłacalności**: **BARDZO NISKA**
    *   *Uzasadnienie*: Funkcje te są wywoływane **tylko raz** podczas inicjalizacji programu (poza pętlą czasową symulacji). Ich zrównoleglenie nie przyniosłoby żadnego mierzalnego zysku dla całkowitego czasu działania programu (zgodnie z Prawem Amdahla).
*   **Trudność**: Bardzo niska (proste pętle for), ale niewarta zachodu.

---

## 4. poisson.h (Solver Poissona)
Rozwiązuje równanie Poissona w celu wyznaczenia potencjału i pola elektrycznego na siatce przy użyciu algorytmu Thomasa (trójprzekątna eliminacja Gaussa).

*   **Funkcja**: `solve_Poisson(xvector rho1, double tt)`
*   **Ocena opłacalności**: **BARDZO NISKA**
    *   *Uzasadnienie*: Rozmiar siatki wynosi $N_G = 400$ punktów. Algorytm Thomasa rozwiązuje ten układ w czasie poniżej 1 mikrosekundy. Narzut na zrównoleglenie (fork-join) byłby wielokrotnie większy niż czas trwania obliczeń.
*   **Trudność**: Bardzo wysoka. Zrównoleglenie algorytmu Thomasa wymaga zaawansowanych metod typu *Parallel Prefix Scan* lub *Cyclic Reduction*.
*   **Zalety/Wady**: Próba zrównoleglenia spowolni program.
*   **Co należy zmienić**: Pozostawić funkcję jako w 100% sekwencyjną, wykonywaną przez wątek główny (Master Thread).

---

## 5. null_collision.h (Stałe Zderzeniowe i Próbkowanie)
Wylicza parametry zderzeniowe i losuje unikalnych kandydatów do zderzeń.

*   **Funkcja**: `random_sample(int n, int count, std::vector<int> &out)`
    *   *Opis*: Implementacja tasowania Fishera-Yatesa do wyboru unikalnych cząstek do zderzeń.
*   **Ocena opłacalności**: **NISKA**
    *   *Uzasadnienie*: Operacja ma złożoność $O(count)$ gdzie $count$ (liczba zderzeń) jest mała. Wykonywana raz na krok czasowy.
*   **Trudność**: Wysoka (algorytm jest z natury sekwencyjny).
*   **Co należy zmienić**: Pozostawić jako sekwencyjną.

---

## 6. collisions.h (Fizyka Zderzeń)
Odpowiada za modyfikację prędkości cząstek po zderzeniu oraz generowanie nowych cząstek w procesie jonizacji.

*   **Funkcje**: `collision_electron(...)`, `collision_ion(...)`
*   **Ocena opłacalności**: **WYSOKA** (jako część zrównoleglonej pętli zderzeń).
*   **Wyzwanie / Data Race (Kluczowy Problem)**:
    *   W przypadku jonizacji (linia 70 w `collisions.h`), funkcja dodaje nowy elektron i nowy jon na koniec globalnych tablic:
        ```cpp
        x_e[N_e] = xe; N_e++;
        x_i[N_i] = xe; N_i++;
        ```
    *   W środowisku wielowątkowym doprowadzi to do natychmiastowego wyścigu o dane na licznikach `N_e`/`N_i` oraz nadpisywania współrzędnych cząstek.
*   **Co należy zmienić**:
    *   Każdy wątek musi zbierać nowo wygenerowane cząstki do **lokalnego, prywatnego bufora (Thread-Local Buffer)**.
    *   Po zakończeniu pętli zderzeń, wątki dokonują redukcji (np. z użyciem prefiksowej sumy) i bezpiecznie kopiują nowe cząstki do globalnych tablic `x_e`/`x_i` w sposób równoległy.

---

## 7. simulation.h (Główna Pętla i Kroki Symulacji)
Zawiera funkcje reprezentujące poszczególne etapy metody Particle-in-Cell. To tutaj znajduje się **99% czasu obliczeniowego programu**.

### A. step1_compute_electron_density / step1_compute_ion_density
*   *Opis*: Depozycja ładunku supercząstek na siatce (interpolacja chmury ładunku do węzłów).
*   **Ocena opłacalności**: **WYSOKA** ($O(N_e)$ oraz $O(N_i)$ operacji).
*   **Wyzwanie**: Wiele wątków może jednocześnie dodawać ładunek do tych samych węzłów siatki `e_density[p]` i `e_density[p+1]`.
*   **Co należy zmienić**:
    *   Zamiast synchronizacji typu `atomic` (która nasyciłaby szynę pamięci z powodu blokowania), należy stworzyć **prywatną tablicę gęstości dla każdego wątku**:
        `double e_density_local[omp_get_max_threads()][N_G];`
    *   Każdy wątek deponuje ładunek lokalnie. Na koniec wykonujemy równoległą redukcję tych małych tablic do globalnej tablicy `e_density` (trwa to ułamek mikrosekundy ze względu na małe $N_G = 400$).

### B. step3_move_electrons / step4_move_ions
*   *Opis*: Interpolacja sił na cząstki, pchnięcie (aktualizacja prędkości i pozycji) oraz zbieranie diagnostyk.
*   **Ocena opłacalności**: **EKSTREMALNIE WYSOKA** (najbardziej kosztowne operacje w całej symulacji).
*   **Wyzwanie**: Zbieranie diagnostyk (np. `counter_e_xt[p][t_index] += c1`, `eepf[energy_index] += 1.0`). Jednoczesny zapis z wielu wątków wygeneruje wyścigi.
*   **Co należy zmienić**:
    *   Pętle `for(k=0; k<N_e; k++)` oraz `for(k=0; k<N_i; k++)` należy zrównoleglić za pomocą `#pragma omp parallel for`.
    *   Wszystkie akumulatory diagnostyczne XT (np. `counter_e_xt`, `ue_xt`, `meanee_xt`) muszą zostać sprywatyzowane na poziomie wątków (lub zabezpieczone atomowo, choć ze względu na wydajność preferowana jest prywatyzacja i końcowa redukcja).

### C. step5_check_boundaries_electrons / step6_check_boundaries_ions
*   *Opis*: Usuwanie cząstek, które przekroczyły elektrody (pochłanianie).
*   **Ocena opłacalności**: **ŚREDNIA/WYSOKA**
*   **Wyzwanie**: Obecny algorytm modyfikuje tablicę w miejscu za pomocą "zamiany z ostatnim elementem" (`x_e[k] = x_e[N_e-1]; N_e--;`). Jest to operacja wysoce sekwencyjna i zależna od globalnego licznika `N_e`.
*   **Co należy zmienić**:
    *   Zamiast usuwania w miejscu wewnątrz pętli, wątki mogą oznaczać cząstki jako "martwe" (np. ustawiając pozycję na wartość specjalną typu `NaN` lub flagę).
    *   Następnie wykonuje się etap **kompresji tablicy** (Stream Compaction) przy użyciu sumy prefiksowej (Prefix Sum / Scan), co pozwala przepisać aktywne cząstki na początek tablicy w sposób w 100% równoległy.

### D. step7_collisions_electrons / step8_collision_ions
*   *Opis*: Wykonywanie zderzeń przy użyciu metody Null-Collision lub metody standardowej.
*   **Ocena opłacalności**: **WYSOKA**
*   **Wyzwanie**: Każde zderzenie potrzebuje generatora liczb losowych. Jonizacja generuje nowe cząstki (wyścig o `N_e` i `N_i`).
*   **Co należy zmienić**:
    *   Zrównoleglenie pętli przechodzącej po kandydatach do zderzeń (`candidates_e` / `candidates_i`).
    *   Użycie dedykowanego generatora liczb losowych dla każdego wątku.
    *   Użycie buforów lokalnych wątków do tymczasowego przechowywania nowo narodzonych cząstek z jonizacji.

---

## 8. Podsumowanie i Priorytety Wdrożenia

Tabela przedstawia priorytety zrównoleglania poszczególnych elementów w celu uzyskania maksymalnego przyspieszenia:

| Krok symulacji | Opłacalność | Trudność | Sugerowana metoda zrównoleglenia |
| :--- | :--- | :--- | :--- |
| **Move Particles (Step 3 & 4)** | **Krytyczna** | Średnia | `#pragma omp parallel for`, prywatyzacja tablic diagnostycznych. |
| **Charge Deposition (Step 1)** | **Wysoka** | Niska | `#pragma omp parallel for` z prywatnymi tablicami gęstości na wątek + końcowa redukcja. |
| **Collisions (Step 7 & 8)** | **Wysoka** | Wysoka | Zrównoleglenie pętli kandydatów, wątkowo-bezpieczne RNG, lokalne bufory na nowe cząstki (jonizacja). |
| **Boundary Check (Step 5 & 6)** | **Średnia** | Wysoka | Algorytm Stream Compaction (dwuetapowy z sumą prefiksową) zamiast modyfikacji w miejscu. |
| **Poisson Solver (Step 2)** | **Brak** | Bardzo wysoka | Pozostawić jako sekwencyjny (Master Thread). |
| **IO / Init (cross_sections.h)**| **Brak** | Niska | Pozostawić jako sekwencyjne. |
