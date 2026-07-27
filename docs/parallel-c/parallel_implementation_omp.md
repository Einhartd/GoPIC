# Dokumentacja Implementacji Równoległej OpenMP (eduPIC C++)

Niniejszy dokument stanowi szczegółowe podsumowanie i dokumentację techniczną zrównoleglenia kodu symulacji plazmy **eduPIC** (1D3V PIC/MCC) w języku C++ przy użyciu interfejsu **OpenMP**. Służy jako przewodnik referencyjny opisujący dokładnie wprowadzone zmiany (plik po pliku, funkcja po funkcji).

---

## 1. Wstęp i Cel Projektu

Głównym celem była optymalizacja i zrównoleglenie kodu symulacji, w którym wąskim gardłem obliczeniowym jest ruch cząstek (Move) oraz zderzenia (Collisions), stanowiące łącznie ponad 90% czasu działania programu. Równoległość zrealizowano na poziomie współdzielenia pamięci (Shared Memory) za pomocą dyrektyw OpenMP, dbając o:
1.  **Poprawność fizyczną**: Zapewnienie identycznych wyników statystycznych (brak wyścigów o dane).
2.  **Efektywność (Speedup)**: Minimalizację narzutu synchronizacji i alokacji pamięci.
3.  **Determinizm testowy**: Stworzenie bazy testów Google Test weryfikujących poprawność krok po kroku.

---

## 2. Szczegółowy Wykaz Zmian (File-by-File)

### 📄 Plik: [C/parallel-only-omp/state.h](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/state.h)

Ten plik zawiera deklaracje zmiennych globalnych symulacji.

*   **Co zmieniono**: Zmienne generatora liczb losowych zostały oznaczone jako `thread_local`.
*   **Dokładny kod (linie 66-70)**:
    ```cpp
    inline thread_local std::random_device                 rd;
    inline thread_local std::mt19937                       MTgen;
    inline thread_local std::uniform_real_distribution<>   R01(0.0, 1.0);
    inline thread_local std::normal_distribution<>         RMB(0.0, VT_I);
    ```
*   **Dlaczego**: Unika to wyścigów o dane (data races) przy jednoczesnym losowaniu z wielu wątków. Kwalifikator `thread_local` sprawia, że każdy wątek OpenMP otrzymuje własną, odrębną instancję generatora i obiektów rozkładów. Rozkład `std::normal_distribution` przechowuje wewnętrzny bufor wygenerowanych liczb (Box-Muller), dlatego on również musi być prywatny dla wątku.

---

### 📄 Plik: [C/parallel-only-omp/collisions.h](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/collisions.h)

Ten plik zawiera szczegółową fizykę zderzeń cząstek z gazem tła.

*   **Funkcja/Symbol**: `struct NewParticles` (nowo dodana, linie 7-19)
    *   **Co zmieniono**: Stworzono strukturę buforującą do zbierania nowo powstałych cząstek podczas procesów jonizacji:
        ```cpp
        struct NewParticles {
            std::vector<double> x, vx, vy, vz;
            void push(double px, double pvx, double pvy, double pvz) {
                x.push_back(px);
                vx.push_back(pvx);
                vy.push_back(pvy);
                vz.push_back(pvz);
            }
        };
        ```
*   **Funkcja**: `collision_electron` (zmiana nagłówka i implementacji, linie 21-100)
    *   **Co zmieniono**: Zmieniono sygnaturę funkcji tak, by przyjmowała referencje do lokalnych buforów wątku:
        ```cpp
        inline void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex,
                                        NewParticles& new_e, NewParticles& new_i)
        ```
    *   Wewnątrz sekcji jonizacji (blok `else`, linie 88-92) zastąpiono bezpośrednie dodawanie cząstek do tablic globalnych (`x_e[N_e] = xe; N_e++;`) zapisem do buforów:
        ```cpp
        new_e.push(xe, wx + F2 * gx, wy + F2 * gy, wz + F2 * gz);
        new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
        ```
    *   **Dlaczego**: Bezpośrednie modyfikowanie liczników `N_e` i `N_i` wewnątrz wątków w pętli zderzeń powodowało katastrofalne wyścigi o dane.

---

### 📄 Plik: [C/parallel-only-omp/simulation.h](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/simulation.h)

Ten plik zawiera główne pętle czasowe i fazy symulacji.

#### 1. Funkcja: `step1_compute_electron_density` (linie 24-45)
*   **Co zmieniono**: Zrównoleglono główną pętlę depozycji elektronów za pomocą redukcji tablicowej i prywatności zmiennych:
    ```cpp
    #pragma omp parallel for reduction(+:e_density[0:N_G]) private(k, p, c0)
    for(k=0; k<N_e; k++) { ... }
    ```
*   **Dlaczego**: Każda cząstka dodaje ładunek do sąsiednich węzłów. Ponieważ wiele wątków mogło pisać do tych samych węzłów siatki, redukcja tworzy lokalną tablicę $N_G$ dla każdego wątku i sumuje je po zakończeniu pętli. Pętla zerująca siatkę i akumulująca gęstości XT pozostały sekwencyjne ze względu na mały rozmiar siatki ($N_G = 400$) i narzut Fork-Join.

#### 2. Funkcja: `step1_compute_ion_density` (linie 47-67)
*   **Co zmieniono**: Zrównoleglono pętlę depozycji jonów. Dyrektywa została umieszczona **wewnątrz** warunku `if ((t % N_SUB) == 0)`:
    ```cpp
    #pragma omp parallel for reduction(+:i_density[0:N_G]) private(k, p, c0)
    for(k=0; k<N_i; k++) { ... }
    ```
*   **Dlaczego**: Ponieważ jony podlegają subcyclingowi, ich depozycja jest liczona co $N_{SUB}$ kroków. Umieszczenie dyrektywy wewnątrz bloku `if` zapobiega niepotrzebnemu tworzeniu regionów OpenMP w krokach, w których jony się nie poruszają.

#### 3. Funkcja: `step3_move_electrons` (linie 79-144)
*   **Co zmieniono**: Zrównoleglono ruch elektronów. Zmienne pomocnicze (`p`, `c0`, `c1` itp.) zostały zadeklarowane wewnątrz pętli jako wątkowo-lokalne.
    *   Dodano redukcję dla skalarów zbierających energię w centrum: `reduction(+:mean_energy_accu_center, mean_energy_counter_center)`.
    *   Wszystkie zapisy do globalnych tablic XT (`counter_e_xt`, `ue_xt`, `meanee_xt`, `ioniz_rate_xt`) oraz histogramu `eepf` zabezpieczono za pomocą:
        ```cpp
        #pragma omp atomic
        ```
*   **Dlaczego**: Każdy elektron porusza się niezależnie. Blokady atomowe zapobiegają wyścigom o dane przy zapisach diagnostycznych, bez konieczności kosztownej alokacji pamięci na kopie tablic XT dla każdego wątku.

#### 4. Funkcja: `step4_move_ions` (linie 146-186)
*   **Co zmieniono**: Zrównoleglono ruch jonów. Zmienne pomocnicze zadeklarowano wewnątrz pętli. Dodano `#pragma omp atomic` przed wszystkimi zapisami do tablic diagnostycznych jonów XT (`counter_i_xt`, `ui_xt`, `meanei_xt`). Brak redukcji skalarnej (nieużywana dla jonów).

#### 5. Funkcja: `step5_check_boundaries_electrons` (linie 189-253)
*   **Co zmieniono**: Zastąpiono algorytm Fast-Swap wątkowo-bezpiecznym algorytmem **Stream Compaction**.
*   **Szczegóły implementacji**:
    *   Wprowadzono statyczne buforowanie w celu eliminacji alokacji pamięci na stercie:
        ```cpp
        static std::vector<int> thread_counts;
        static std::vector<int> thread_offsets;
        static std::vector<std::vector<int>> thread_local_indices;
        static std::vector<double> temp_x_e, temp_vx_e, temp_vy_e, temp_vz_e;
        ```
    *   **Faza 1 (Znakowanie)**: Pierwszy region `#pragma omp parallel` z pętlą `for (int k = start; k < end; ++k)` sprawdza granice. Ocalałe cząstki trafiają do `thread_local_indices[tid].push_back(k)`.
    *   **Faza 2 (Suma Prefiksowa)**: Po wyjściu z bloku parallel, wątek główny sekwencyjnie wylicza offsety startowe:
        ```cpp
        int total_survived = 0;
        for (int t = 0; t < num_threads; ++t) {
            thread_offsets[t] = total_survived;
            total_survived += thread_counts[t];
        }
        ```
    *   **Faza 3 (Relokacja)**: Drugi region `#pragma omp parallel` kopiuje cząstki do wektorów tymczasowych `temp_x_e` itp. zaczynając od pozycji `write_idx = thread_offsets[tid]`.
    *   **Faza 4**: Przepisanie z powrotem do tablic głównych i aktualizacja `N_e = total_survived;`.

#### 6. Funkcja: `step6_check_boundaries_ions` (linie 255-350)
*   **Co zmieniono**: Zaimplementowano Stream Compaction dla jonów (analogicznie do elektronów), wykonując go wewnątrz warunku subcyclingu.
    *   Dodatkowo, dla cząstek uderzających w elektrody, wyliczana jest ich energia kinetyczna i inkrementowane są histogramy energetyczne `ifed_pow[energy_index]` i `ifed_gnd[energy_index]` zabezpieczone blokadą `#pragma omp atomic`.

#### 7. Funkcja: `step7_collisions_electrons` (linie 352-425)
*   **Co zmieniono**: Zrównoleglono zderzenia elektronów.
    *   Dodano statyczną prealokację buforów na nowe cząstki: `static std::vector<NewParticles> new_electrons, new_ions;`. Są one czyszczone za pomocą `.clear()` na początku każdego kroku.
    *   W sekcji `#ifdef USE_NULL_COLLISION` zrównoleglono pętlę po indeksach kandydatów:
        ```cpp
        #pragma omp parallel for
        for (size_t i = 0; i < candidates_e.size(); ++i) { ... }
        ```
    *   W sekcji `#else` zrównoleglono pętlę po wszystkich elektronach:
        ```cpp
        #pragma omp parallel for
        for (k=0; k<N_e; k++) { ... }
        ```
    *   Obie pętle przekazują `new_electrons[tid]` i `new_ions[tid]` do `collision_electron`, a licznik `N_e_coll` jest inkrementowany atomowo.
    *   Na końcu funkcji dodano sekwencyjne przepisanie nowych cząstek z buforów wszystkich wątków do tablic globalnych.

#### 8. Funkcja: `step8_collision_ions` (linie 427-503)
*   **Co zmieniono**: Zrównoleglono zderzenia jonów (zarówno dla wersji Null-Collision, jak i standardowej). Ponieważ zderzenia jonów nie generują nowych cząstek, nie wymagają one buforowania. Zabezpieczono atomowo jedynie licznik `N_i_coll++` za pomocą `#pragma omp atomic`.

---

## 3. Optymalizacja Wydajności: Eliminacja Alokacji Sterty

*   **Problem**: Wstępna wersja kodu alokowała dynamicznie wektory w każdym kroku czasowym (wykonywanym 120 000 razy dla 30 cykli). Spowodowało to alokację i usunięcie ponad **480 GB** pamięci w 26 sekund, co wygenerowało **5.9 miliona page faults** i sparaliżowało procesor (brak realnego przyspieszenia).
*   **Rozwiązanie**: Wprowadzono modyfikator **`static`** dla wszystkich tymczasowych tablic wektorowych (`thread_counts`, `thread_offsets`, `thread_local_indices`, `temp_x_e`, `temp_vx_e` itp.).
*   **Efekt**: Wektory są alokowane tylko raz (podczas pierwszego kroku). W kolejnych krokach metoda `.clear()` resetuje ich logiczną wielkość, zachowując fizyczną pojemność (capacity) w pamięci. Metoda `.resize(total_survived)` zmienia rozmiar bez ponownej alokacji. Liczba błędów stron spadła do **14 712**, a czas wykonania skrócił się z **29.15 s** do **15.64 s** (Speedup **1.86x**).

---

## 4. Baza Testów Jednostkowych ([C/parallel-only-omp/tests/](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/tests/))

Napisano kompleksowe testy jednostkowe Google Test, aby zagwarantować stabilność kodu:
1.  **[test_rng.cc](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/tests/test_rng.cc)**: Weryfikuje niezależność losowania na wątkach oraz poprawność rozkładów przy `thread_local`.
2.  **[test_density.cc](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/tests/test_density.cc)**: Weryfikuje spójność depozycji ładunku (redukcje tablicowe) w wersji 1-wątkowej vs 4-wątkowej.
3.  **[test_push.cc](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/tests/test_push.cc)**: Weryfikuje bitową zgodność ruchu cząstek i zbierania diagnostyki XT.
4.  **[test_boundaries.cc](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/tests/test_boundaries.cc)**: Testuje poprawność Stream Compaction. Zawiera test deterministyczny `DeterministicStreamCompactionElectrons` (sprawdza kompaktowanie 5 z góry określonych cząstek) oraz `DeterministicIonFluxEnergyDistribution` (sprawdza poprawność zliczania energii jonu 50.5 eV w histogramie).
5.  **[test_collisions.cc](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/tests/test_collisions.cc)**: Testuje poprawność buforowania nowych cząstek przy jonizacji. Generuje elektrony o energii 100 eV i sprawdza przyrost cząstek.
