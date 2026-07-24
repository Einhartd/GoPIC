# Podsumowanie Optymalizacji Równoległych C (OMP & Hybrid MPI+OMP)
## Przewodnik przenoszenia wzorców wydajnościowych na języki Go oraz Python

Dokument ten zawiera szczegółowy opis wszystkich optymalizacji wydajnościowych, które zostały zaimplementowane i zweryfikowane w C (`parallel-only-omp` oraz `parallel-hybrid`), wraz z bezpośrednimi wytycznymi dotyczącymi ich realizacji w planowanych wersjach **Go** (z użyciem goroutin i kanałów) oraz **Python** (z użyciem NumPy / PyMP / SharedMemory).

---

## 📋 Spis Zastosowanych Optymalizacji

1. [Stream Compaction: Eliminacja alokacji $O(N)$ na rzecz $O(N_{abs})$ Swap-with-Last](#1-stream-compaction-swap-with-last)
2. [Wstępnie alokowane bufory wątkowe (`WorkerBuffers`) i zero-alokacji w pętli](#2-wstępnie-alokowane-bufory-wątkowe-workerbuffers)
3. [Eliminacja False Sharingu w L1 Cache (`alignas(64)`)](#3-eliminacja-false-sharingu-w-l1-cache-alignas64)
4. [Zrównoleglenie redukcji buforów diagnostycznych ($O(N_G)$ i $O(N_{EEPF})$)](#4-zrównoleglenie-redukcji-buforów-diagnostycznych)
5. [Warunkowe zerowanie buforów diagnostycznych (`if (measurement_mode)`)](#5-warunkowe-zerowanie-buforów-diagnostycznych)
6. [Trwałe wątki / trwałe regiony równoległe (Persistent Workers)](#6-trwałe-wątki--trwałe-regiony-równoległe-persistent-workers)
7. [Wzorzec depozycji gęstości ładunku (Scatter-Add bez wyścigów)](#7-wzorzec-depozycji-gęstości-ładunku-scatter-add)
8. [Ion Subcycling (`t % N_SUB == 0`)](#8-ion-subcycling)

---

### 1. Stream Compaction: Swap-with-Last
- **Problem w C**: Pierwotna 3-fazowa filtracja cząstek przekraczających brzegi ($x < 0$ lub $x > L$) alokowała i kopiowała wektory `temp_x_e`, `temp_vx_e` dla wszystkich ~70 000 cząstek. Generowało to ~4.5 MB ruchu pamięci na krok (~18 GB na cykl RF!).
- **Rozwiązanie w C**: Wprowadzono algorytm z równoległym oznaczaniem flagą `absorbed[k]` i pojedynczą pętlą zamiany elementu usuwanego z ostatnim elementem tablicy (`x[k] = x[N-1]; N--`). Redukcja ruchu pamięci z 4.5 MB do ~6 KB na krok (700× spadek).
- **Wytyczne dla Go**:
  - Używaj operacji na wycinkach (*slices*) bez alokowania nowych tablic: `particles[k] = particles[n-1]; n--`.
  - Unikaj wywoływań `append()` lub tworzenia tymczasowych slice'ów wewnątrz ciasnych pętli symulacji.
- **Wytyczne dla Pythona**:
  - W NumPy unikać tworzenia nowych tablic przez masowe maskowanie `x = x[mask]`, jeśli powoduje to kopiowanie całej pamięci.
  - Alternatywa: utrzymywanie indeksów aktywnych cząstek `sim.N_e` i nadpisywanie wewnątrz istniejącego bufora NumPy.

---

### 2. Wstępnie alokowane bufory wątkowe (`WorkerBuffers`)
- **Problem w C**: Alokowanie obiektów `std::vector` na stercie wewnątrz regionów równoległych powodowało kontencję alokatora sterty, fragmentację pamięci oraz unieważnianie pamięci podręcznej.
- **Rozwiązanie w C**: Utworzono globalną strukturę `WorkerBuffers` alokowaną jednorazowo podczas uruchomienia programu dla `num_threads`. Wewnątrz 4000 kroków czasowych występuje zero alokacji dynamicznych.
- **Wytyczne dla Go**:
  - Alokuj bufory robocze (`[]float64`, tablice gęstości) raz w strukturze symulacji lub przydziel prywatny bufor dla każdej goroutiny roboczej przed pętlą czasową.
  - Unikaj alokowania pamięci na stercie w pętli `for t := 0; t < N_T; t++`.
- **Wytyczne dla Pythona**:
  - Alokuj dwuwymiarowe tablice NumPy dla pracowników: `sim.e_density_workers = np.zeros((num_workers, N_G))` przy starcie obiektu symulacji.
  - Reużywaj tablice za pomocą operacji `.fill(0.0)`.

---

### 3. Eliminacja False Sharingu w L1 Cache (`alignas(64)`)
- **Problem w C**: Sąsiadujące ze sobą liczniki skalarne wątków (np. `accu_center`, `counter_center`, `local_abs_pow`) leżały w tej samej 64-bajtowej linii pamięci podręcznej L1. Modyfikacja przez jeden wątek unieważniała linię cache dla pozostałych rdzeni, wywołując *involuntary context switches* i ruch na magistrali.
- **Rozwiązanie w C**: Wprowadzono `struct alignas(64) AlignedThreadCounters`, która dopasowuje rozmiar struktury każdego wątku do 64 bajtów (rozmiar L1 cache line). Liczba niechcianych przełączeń kontekstu spadła o **43%**.
- **Wytyczne dla Go**:
  - W strukturach przeznaczonych dla równoległych goroutin dodawaj wyściełanie pamięci (*cache line padding*):
    ```go
    type WorkerCounter struct {
        val uint64
        _   [56]byte // Padded to 64 bytes
    }
    ```
- **Wytyczne dla Pythona**:
  - Unikaj modyfikowania wspólnych skalarnych tablic przez różne procesy/wątki. Używaj zmiennych lokalnych dla procesu lub tablic 2D o osobnych wierszach.

---

### 4. Zrównoleglenie redukcji buforów diagnostycznych
- **Problem w C**: Po wykonaniu równoległym kroków cząsteczkowych, zliczanie gęstości całkowitej oraz diagnostyk `counter_e_xt`, `ue_xt`, `meanee_xt`, `eepf` odbywało się w jednowątkowej pętli `for (int t = 0; t < num_threads; t++)`. Dla dużej liczby wątków pętla ta stawała się wąskim gardłem (Prawo Amdahla).
- **Rozwiązanie w C**: Przekształcono pętle redukcji na pętle zrównoleglone po węzłach siatki $p \in [0, N_G)$ oraz koszykach energii $i \in [0, N_{EEPF})$ (`#pragma omp for schedule(static)`).
- **Wytyczne dla Go**:
  - Rozdzielaj zadanie sumowania wyników cząstkowych z buforów wątkowych na goroutiny robocze (podział zakresem węzłów $p$).
- **Wytyczne dla Pythona**:
  - W NumPy wykorzystuj wektoryzację macierzową wzdłuż osi pracowników: `np.sum(e_density_workers, axis=0)`.

---

### 5. Warunkowe zerowanie buforów diagnostycznych
- **Problem w C**: Bezwzględne czyszczenie dużych tablic diagnostycznych XT i EEPF w każdym kroku czasowym, nawet gdy `measurement_mode == false` (np. podczas pierwszych 2000 cykli dochodzenia do stanu ustalonego).
- **Rozwiązanie w C**: Owinięcie operacji `.fill(0.0)` oraz akumulacji diagnostyk w warunek `if (measurement_mode)`.
- **Wytyczne dla Go i Pythona**:
  - Sprawdzaj flagę `measurement_mode` na samym początku funkcji diagnostycznych i całkowicie pomijaj ich zerowanie i przeliczanie, gdy diagnostyka jest wyłączona.

---

### 6. Trwałe wątki / Trwałe regiony równoległe (Persistent Workers)
- **Problem w C**: Tworzenie i niszczenie zespołu wątków przy każdym kroku czasowym (7-10 razy na krok × 4000 kroków = 30 000+ powołań fork/join na cykl) powodowało wysoki narzut jądra systemu (System CPU time ~16s).
- **Rozwiązanie w C**: Tworzenie pojedynczego trwałego regionu `#pragma omp parallel` na poziomie `do_one_cycle()` otaczającego całą pętlę 4000 kroków czasowych. Synchronizacja odbywa się bezkosztowymi barierami (`#pragma omp barrier`).
- **Wytyczne dla Go**:
  - Twórz goroutiny robocze **RAZ** na początku cyklu symulacji lub przy starcie programu.
  - Synchronizuj kroki czasowe za pomocą barier (np. dwuetapowy `sync.WaitGroup` lub kanały synchronizacyjne), zamiast uruchamiać `go func()` 4000 razy na cykl.
- **Wytyczne dla Pythona**:
  - W przypadku `multiprocessing` / `concurrent.futures` używaj trwałej puli procesów (`ProcessPoolExecutor`) lub pamięci dzielonej `multiprocessing.shared_memory` i trwałej pętli procesu wykonawczego.

---

### 7. Wzorzec depozycji gęstości ładunku (Scatter-Add)
- **Problem w C**: Wielowątkowa depozycja ładunku z cząstek do węzłów siatki grozi wyścigiem pamięci (*race condition*), jeśli dwa wątki dodają ładunek do tego samego węzła siatki $p$.
- **Rozwiązanie w C**: Każdy wątek deponuje ładunek do prywatnej tablicy gęstości `worker_buffers.e_density[tid][p]`, a po zrównoleglonej pętli po cząstkach następuje zrównoleglone sumowanie do tablicy głównej `e_density[p]`.
- **Wytyczne dla Go**:
  - Stosuj prywatne tablice gęstości dla każdej goroutiny (`e_density_go[goroutine_id][p]`), a następnie sumuj je po zakończeniu depozycji cząstek.
- **Wytyczne dla Pythona**:
  - Stosuj `np.add.at(e_density_local, indices, weights)` dla wycinków procesów lub ułóż bufory w macierz 2D `(num_workers, N_G)` i zsumuj przez `axis=0`.

---

### 8. Ion Subcycling (`t % N_SUB == 0`)
- **Problem w C**: Jony są ~270 razy cięższe od elektronów ($m_i / m_e = 73 440$), przez co ich prędkość i ruch zmieniają się znacznie wolniej.
- **Rozwiązanie w C**: Depozycja gęstości jonów (`step1b`), popychani jonów (`step4`), pochłanianie na brzegach (`step6`) oraz zderzenia jonów (`step8`) wykonują się wyłącznie wtedy, gdy `(t % N_SUB) == 0` (standardowo $N_{SUB} = 2$ lub $4$).
- **Wytyczne dla Go i Pythona**:
  - Zawsze zachowuj rygorystyczny warunek `if t % N_SUB == 0` wokół wszystkich operacji dotyczących jonów.

---

## 📊 Zbiorcze Porównanie Wyników Osiągniętych w C

| Wersja Kodowa | Konfiguracja | Wall Clock Time (10 cykli) | Speedup vs Sekwencyjny |
|:---|:---|---:|---:|
| **Sekwencyjna (Baseline)** | 1 rdzeń | 23.61 s | 1.00× |
| **OpenMP (Poprawiony OMP)** | 2 wątki OMP | 15.97 s | 1.48× |
| **Hybrid MPI+OMP** | 2 MPI × 2 OMP | **13.45 s** | **1.76×** |
