# Dokumentacja Implementacji Hybrydowej MPI + OpenMP (eduPIC C++)

Niniejszy dokument stanowi szczegółowe podsumowanie i dokumentację techniczną zrównoleglenia kodu symulacji plazmy **eduPIC** (1D3V PIC/MCC) przy użyciu modelu hybrydowego **MPI (Message Passing Interface) + OpenMP**. Służy jako przewodnik referencyjny opisujący dokładnie wprowadzone zmiany (plik po pliku, funkcja po funkcji) oraz bazę testów jednostkowych weryfikujących poprawność rozproszoną.

---

## 1. Architektura Hybrydowa: Dekompozycja Cząstek i Klonowana Siatka (Replicated Grid)

Ponieważ siatka przestrzenna symulacji jest bardzo mała ($N_G = 400$ węzłów), a liczba cząstek jest duża ($100\ 000$ - $1\ 000\ 000$), zastosowano model **Dekompozycji Cząstek (Particle Decomposition)** połączony z **Klonowaną Siatką (Replicated Grid)**:

1.  **Dekompozycja cząstek**: Cząstki (elektrony i jony) są równomiernie dzielone pomiędzy procesy MPI. Każdy proces zarządza swoją lokalną pulą cząstek, popycha je i przeprowadza zderzenia lokalnie, dodatkowo wykorzystując wątki **OpenMP** do zrównoleglenia tych pętli w pamięci współdzielonej.
2.  **Klonowana siatka (Replicated Grid)**: Każdy proces MPI posiada pełną kopię siatki przestrzennej (gęstość, potencjał, pole elektryczne).
3.  **Synchronizacja gęstości**: Po zakończeniu depozycji ładunku przez poszczególne procesy, lokalne siatki gęstości są sumowane na wszystkich procesach za pomocą wydajnej operacji zbiorczej **`MPI_Allreduce`**. Dzięki temu każdy proces otrzymuje identyczną globalną siatkę gęstości.
4.  **Lokalny solver Poissona**: Każdy proces MPI niezależnie rozwiązuje równanie Poissona na identycznych danych wejściowych, uzyskując identyczne pole elektryczne $E(x)$. Eliminuje to potrzebę przesyłania pola sieciowo.

---

## 2. Szczegółowy Wykaz Zmian (File-by-File)

Wszystkie modyfikacje zostały wprowadzone w katalogu **`C/parallel-hybrid/`**.

### 📄 Plik: [C/parallel-hybrid/state.h](file:///home/oliwier/Dev/GoPIC/C/parallel-hybrid/state.h)

Ten plik zawiera deklaracje zmiennych globalnych symulacji.

*   **Co zmieniono**: Zmienne globalne przechowujące rangę i rozmiar komunikatora MPI.
*   **Kod (linie 71-72)**:
    ```cpp
    inline int mpi_rank = 0;
    inline int mpi_size = 1;
    ```
*   **Dlaczego**: Aby każdy proces miał stały dostęp do swojej rangi (`mpi_rank`) oraz liczby wszystkich procesów w komunikatorze (`mpi_size`), co jest kluczowe dla podejmowania decyzji o podziale pracy i komunikacji.

---

### 📄 Plik: [C/parallel-hybrid/eduPIC.cc](file:///home/oliwier/Dev/GoPIC/C/parallel-hybrid/eduPIC.cc)

Główny punkt wejściowy programu zarządzający cyklem życia symulacji.

*   **Co zmieniono**:
    *   Zainicjalizowano środowisko MPI z obsługą wielowątkowości za pomocą `MPI_Init_thread` z wymaganym poziomem `MPI_THREAD_FUNNELED` (wątek główny wykonuje wszystkie wywołania MPI).
    *   Zabezpieczono parsowanie argumentów linii poleceń i wypisywanie banerów powitalnych tak, by wykonywał je wyłącznie proces Master (`mpi_rank == 0`).
    *   Wprowadzono podział początkowych cząstek (`N_INIT`) na porcje przypisane do rang MPI:
        ```cpp
        int local_N_INIT = N_INIT / mpi_size;
        if (mpi_rank == 0) {
            local_N_INIT += N_INIT % mpi_size;
        }
        init(local_N_INIT);
        ```
    *   Dodano `MPI_Finalize()` na końcu funkcji `main`.
*   **Dlaczego**: Aby symulacja startowała w trybie rozproszonym, nie powielała komunikatów w konsoli na każdym procesie oraz równomiernie dzieliła cząstki startowe.

---

### 📄 Plik: [C/parallel-hybrid/simulation.h](file:///home/oliwier/Dev/GoPIC/C/parallel-hybrid/simulation.h)

Ten plik zarządza głównymi krokami algorytmu PIC.

#### 1. Funkcja: `step1_compute_electron_density`
*   **Co zmieniono**: Po zakończeniu lokalnej depozycji OpenMP na każdym procesie dodano synchronizację globalną siatki gęstości elektronów:
    ```cpp
    MPI_Allreduce(MPI_IN_PLACE, e_density, N_G, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
    ```
*   **Dlaczego**: Każdy proces deponuje ładunek tylko ze swoich cząstek. `MPI_Allreduce` sumuje te wkłady i rozsyła pełną siatkę do wszystkich procesów.

#### 2. Funkcja: `step1_compute_ion_density`
*   **Co zmieniono**: Analogicznie do elektronów, wewnątrz bloku subcyclingu jonowego dodano synchronizację siatki gęstości jonów:
    ```cpp
    MPI_Allreduce(MPI_IN_PLACE, i_density, N_G, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
    ```

#### 3. Funkcja: `do_one_cycle`
*   **Co zmieniono**:
    *   W pętli diagnostycznej (wywoływanej co 1000 kroków czasowych) lokalne liczniki cząstek `N_e` i `N_i` są agregowane za pomocą `MPI_Reduce` na Masterze w celu wypisania sumy globalnej:
        ```cpp
        int global_N_e = 0, global_N_i = 0;
        MPI_Reduce(&N_e, &global_N_e, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
        MPI_Reduce(&N_i, &global_N_i, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
        if (mpi_rank == 0) {
            printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", cycle, t, global_N_e, global_N_i);
        }
        ```
*   **Dlaczego**: Aby logi konsoli poprawnie informowały o sumarycznej liczbie cząstek w całym układzie, a nie tylko o cząstkach na procesie Master.

---

### 📄 Plik: [C/parallel-hybrid/io_manager.h](file:///home/oliwier/Dev/GoPIC/C/parallel-hybrid/io_manager.h)

Zarządza zapisami/odczytami plików oraz końcowym uśrednianiem i zapisem diagnostyk.

#### 1. Funkcja: `load_particle_data`
*   **Co zmieniono**: Wdrożono bezpieczny, etapowy odczyt pliku binarnego:
    1.  Master wczytuje metadane (`Time`, `cycles_done`, `total_N_e`).
    2.  Rozsyłane są one przez `MPI_Bcast` do pozostałych procesów.
    3.  Master wczytuje tablice elektronów i przesyła odpowiednie fragmenty do procesów roboczych za pomocą `MPI_Send` (tagi 10-13). Procesy robocze odbierają swoje porcje przez `MPI_Recv`.
    4.  Master czyta całkowitą liczbę jonów (`total_N_i`) z pliku i rozsyła ją przez `MPI_Bcast`.
    5.  Master wczytuje tablice jonów i przesyła je do procesów za pomocą `MPI_Send` (tagi 20-23, co zapobiega kolizji wiadomości z elektronami).
*   **Dlaczego**: Plik binarny musi być czytany sekwencyjnie. Etapowość zapobiega rozsynchronizowaniu wskaźnika pliku i gwarantuje poprawność odczytanych położeń i prędkości.

#### 2. Funkcja: `save_particle_data`
*   **Co zmieniono**:
    *   Master zbiera za pomocą `MPI_Gather` informacje o liczbie cząstek na każdym procesie.
    *   Procesy robocze wysyłają swoje cząstki do Mastera za pomocą `MPI_Send` (tagi 50-53 i 60-63).
    *   Master odbiera je i zapisuje w odpowiednich offsetach w swoich globalnych tablicach, a następnie jako jedyny zapisuje cały stan do pliku `picdata.bin`.
*   **Dlaczego**: Master musi zebrać cząstki ze wszystkich procesów w jedną spójną strukturę, aby plik stanu był kompletny.

#### 3. Funkcje: `save_eepf` i `save_ifed`
*   **Co zmieniono**: Zastosowano `MPI_Reduce` do zsumowania lokalnych histogramów energii na Masterze przed zapisem:
    ```cpp
    MPI_Reduce(eepf, global_eepf.data(), N_EEPF, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    ```
    Pliki tekstowe `eepf.dat` i `ifed.dat` są otwierane i zapisywane wyłącznie na procesie o randze 0.

#### 4. Funkcja: `check_and_save_info`
*   **Co zmieniono**:
    *   Zredukowano płaskie dwuwymiarowe tablice XT diagnostyki czasoprzestrzennej (np. `counter_e_xt`, `ue_xt`, `meanee_xt`, `ioniz_rate_xt` o rozmiarze $N_G \times N_{XT}$) za pomocą operacji zbiorczej `MPI_Reduce` z parametrem `MPI_IN_PLACE` dla Mastera.
    *   Zredukowano skalary statystyk (absorpcje na elektrodach, kolizje, średnią energię w centrum).
    *   Cały blok zapisu raportu `info.txt` otoczono warunkiem `if (mpi_rank == 0)`.

---

## 3. Baza Testów Jednostkowych i Równoważności ([C/parallel-hybrid/tests/](file:///home/oliwier/Dev/GoPIC/C/parallel-hybrid/tests/))

Napisano zestaw testów jednostkowych weryfikujących poprawność komunikacji oraz poprawność algorytmów fizycznych:

### 1. Testy Komunikacji i Stanu (`HybridCommTest`)
*   **`InitializationSplitting`**: Sprawdza poprawność podziału początkowych cząstek i ich globalną sumę.
*   **`DiagnosticsReduction`**: Weryfikuje sumowanie liczników diagnostycznych z procesów MPI.
*   **`ParticleGatherScatter`**: Weryfikuje poprawność zbierania cząstek z procesów, zapisu na dysk, ponownego odczytu i rozproszenia do procesów.

### 2. Testy Poprawności Algorytmów (`HybridEquivalenceTest`)
Te testy porównują bezpośrednio (co do bitu) wyniki hybrydowego wykonania rozproszonego z referencyjnym, sekwencyjnym kodem:
*   **`DensityDeposition`**: Porównuje globalną gęstość po `step1_compute_electron_density()` z sekwencyjnym algorytmem depozycji.
*   **`ParticlePush`**: Sprawdza, czy popychanie cząstek w polu $E$ (interpolacja + integrator leap-frog) w hybrydzie daje identyczne współrzędne jak referencyjne równania sekwencyjne.
*   **`BoundaryCheck`**: Weryfikuje, czyStream Compaction w hybrydzie poprawnie filtruje cząstki i zlicza te zaabsorbowane na elektrodach zgodnie z referencyjnym modelem sekwencyjnym.

Wszystkie testy przechodzą pomyślnie na 2 procesach MPI.

---

## 4. Instrukcja Kompilacji i Uruchomienia

### Kompilacja:
Do kompilacji hybrydowej wykorzystujemy kompilator MPI (`mpicxx`) z włączoną obsługą dyrektyw OpenMP (`-fopenmp`):
```bash
mpicxx -O3 -fopenmp eduPIC.cc -o eduPIC_hybrid
```

### Uruchomienie lokalne:
Uruchamiamy za pomocą `mpirun`, określając liczbę procesów MPI (`-np`) oraz ustawiając zmienną środowiskową liczby wątków OpenMP na proces (`OMP_NUM_THREADS`):
```bash
# Inicjalizacja (1 cykl):
OMP_NUM_THREADS=4 mpirun -np 2 ./eduPIC_hybrid 0

# Kontynuacja (100 cykli w trybie pomiarowym):
OMP_NUM_THREADS=4 mpirun -np 2 ./eduPIC_hybrid 100 m
```
W powyższym przykładzie symulacja użyje łącznie **8 rdzeni** (2 procesy MPI $\times$ 4 wątki OpenMP na proces).
