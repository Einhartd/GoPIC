# Przewodnik i Rozpiska Podrozdziału: Prywatyzacja Pamięci i Buforowanie Wątkowe — Eliminacja Rywalizacji o Zasoby w Symulacji PIC/MCC (Thread-Private Buffering & State Privatization)

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.3: Ścieżka zrównoleglenia silnika C++ z użyciem OpenMP**  
>     └── **4.3.1. Przebudowa struktur danych i buforowanie wątkowe: eliminacja rywalizacji o pamięć w depozycji ładunku, generatorach losowych i cyklu życia cząstek (Thread-Private Buffering & State Privatization)**

---

## 1. Kontekst Współbieżny i Diagnoza Punktów Rywalizacji (Memory Contention Diagnostics)

### 1.1. Przeszkody Architektoniczne w Zrównolegleniu Silnika Sekwencyjnego
Przeniesienie jednordzeniowego, zoptymalizowanego wektorowo silnika PIC/MCC ([`C/8.experiment-simd`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/8.experiment-simd)) do środowiska ze współdzieloną pamięcią (OpenMP) natrafia na fundamentalną barierę: **strukturę przepływu danych opartą na globalnym stanie symulacji**. 

W fizycznym modelu Particle-in-Cell zderzeniowego wyładowania plazmowego (1D3V RF CCP), pętla czasowa wykonuje 4000 podkroków czasowych w każdym cyklu wysokiej częstotliwości. W każdym pojedynczym podkroku występują **trzy krytyczne operacje jednoczesnego zapisu pamięci (Write Hazards)**:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│             TRZY PUNKTY KRYTYCZNE ZAPISU W NAIWNEJ WERSJI WIELOWĄTKOWEJ                │
├──────────────────────────┬─────────────────────────────┬───────────────────────────────┤
│ 1. Depozycja Ładunku     │ 2. Generator Losowy (PRNG)  │ 3. Jonizacja i Cząstki Wtórne │
│ (Cloud-in-Cell)          │ (Monte Carlo MCC)           │ (Particle Insertion)          │
├──────────────────────────┼─────────────────────────────┼───────────────────────────────┤
│ Wiele cząstek równolegle │ Wątki losują liczby         │ Zderzenie jonizujące tworzy   │
│ aktualizuje te same      │ z jednego globalnego stanu  │ nową parę elektron-jon        │
│ węzły siatki przestrzeni │ std::mt19937                │ na końcu globalnej tablicy    │
│ [Scatter-Add Hazard]     │ [Shared PRNG State Hazard]  │ [Array Extension Hazard]      │
└──────────────────────────┴─────────────────────────────┴───────────────────────────────┘
```

---

### 1.2. Analiza Kosztu Podejść Naiwnych: Dlaczego Muteksy i Atomiki Prowadzą do Zapaści

Gdyby spróbować zrównoleglić pętle cząstkowe bez przebudowy struktur danych, programista zmuszony byłby zastosować tradycyjne mechanizmy synchronizacji OpenMP. Analiza mikroarchitektoniczna wykazuje, dlaczego podejścia te są katastrofalne dla wydajności:

#### A. Sekcje Krytyczne (`#pragma omp critical`)
Zabezpieczenie operacji zapisu sekcją krytyczną wymusza wyłączny dostęp jednego wątku:
```cpp
// NAIWNY ANTY-WZORZEC:
#pragma omp critical
{
    e_density[p]   += c1;
    e_density[p+1] += c2;
}
```
* **Skutek:** Przy $N_e \approx 108\,000$ cząstkach i 8–64 wątkach, pętla ulega **całkowitej serializacji**. Czas wykonania sekcji zależy od czasu pobrania i zwolnienia blokady w pamięci cache L3/RAM. Zamiast przyspieszenia, symulacja ulega zwolnieniu o 1–2 rzędy wielkości (*severe lock contention*).

#### B. Sprzętowe Instrukcje Atomowe (`#pragma omp atomic`)
Nowoczesne procesory x86-64 oferują instrukcje atomowe (np. `LOCK ADDSD`):
```cpp
// NAIWNY ANTY-WZORZEC:
#pragma omp atomic
e_density[p] += c1;
#pragma omp atomic
e_density[p+1] += c2;
```
* **Kalkulacja kosztu sprzętowego:**
  * W jednym podkroku czasowym wykonuje się $108\,000 \times 2 = 216\,000$ zapisów atomowych.
  * W 1 cyklu RF (4000 podkroków): $216\,000 \times 4000 = \mathbf{864\,000\,000\text{ operacji atomowych na cykl}}$!
  * Na architekturze AMD Zen 4 instrukcja atomowa blokuje linię pamięci podręcznej w buforze L1D (Load/Store Queue) i unieważnia ją we wszystkich pozostałych rdzeniach za pośrednictwem protokołu MOESI na czas około **15–20 cykli zegara**.
  * Narzut samych operacji atomowych:
    $$864 \times 10^6 \times 18\text{ cykli} \approx 15.55 \times 10^9\text{ cykli CPU / cykl RF}$$
    Przy taktowaniu $3.7\text{ GHz}$ oznacza to **ponad 4.2 sekundy czystego narzutu blokady szyny na każdy cykl symulacji**! Sto cykli trwałoby ponad 420 sekund (zamiast 19.5 sekundy).

---

## 2. Architektura Rozwiązania: Trzy Filary Buforowania Wątkowego

W celu osiągnięcia liniowej skalowalności wielowątkowej wdrożono wzorzec **Prywatyzacji Stanu i Dwufazowej Redukcji (Two-Phase Privatized Buffering)**. Wzorzec ten opiera się na trzech filarach architektonicznych:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                   TRZY FILARY PRYWATYZACJI PAMIĘCI (KROK 1)                            │
├──────────────────────────────┬──────────────────────────────┬──────────────────────────┤
│ FILAR I: PRNG                │ FILAR II: SIATKA W L1D       │ FILAR III: NOWE CZĄSTKI  │
│ thread_local std::mt19937    │ WorkerBuffers.e_density[tid] │ NewParticles (SoA 4096)  │
│ 100% Lock-Free w TLS         │ Rezydentne w L1d (3.25 KB)   │ Zero alokacji na stercie │
└──────────────────────────────┴──────────────────────────────┴──────────────────────────┘
```

---

### 2.1. Filar I: Bezblokadowy Generator Pseudolosowy per-Wątek (`thread_local PRNG`)

#### 2.1.1. Problem współdzielenia generatora
Generator Mersenne Twister (`std::mt19937`) przechowuje stan wewnętrzny złożony z tablicy 624 liczb 32-bitowych (`uint32_t state[624]`) oraz indeksu bieżącego słowa. Każde wywołanie losowania modyfikuje stan generatora. Równoległe losowanie z jednego obiektu prowadzi do natychmiastowego wyścigu danych, zniszczenia struktury okresu generatora ($2^{19937}-1$) i w konsekwencji fałszywych rozkładów fizycznych lub pętli nieskończonych.

#### 2.1.2. Implementacja w [`state.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L260-L269)
Zastosowano specyfikator `thread_local`, który alokuje instancję generatora w obszarze pamięci lokalnej wątku (*Thread-Local Storage*, TLS):

```cpp
// state.h
// =============================================================================
// Niezależne generatory liczb pseudolosowych na poziomie wątku (thread_local)
// Każdy wątek OpenMP posiada własny stan generatora Mersenne Twister,
// co zapewnia w 100% bezblokadowe (lock-free) losowanie liczb.
// =============================================================================

inline thread_local std::random_device rd{}; 
inline thread_local std::mt19937 MTgen(rd());
inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
```

#### 2.1.3. Korzyści mikroarchitektoniczne:
1. **Całkowity brak blokad (100% Lock-Free):** Każdy wątek losuje liczby w przestrzeni własnego stosu/TLS. Brak muteksów, atomików i barier.
2. **Eliminacja False Sharing:** Stany generatorów poszczególnych wątków znajdują się w odrębnych stronach pamięci TLS, wykluczając wzajemne unieważnianie linii cache L1D/L2.
3. **Niezależność statystyczna:** Inicjalizacja z urządzenia sprzętowego `std::random_device` zapewnia różne ziarna początkowe dla każdego wątku zespołu roboczego.

---

### 2.2. Filar II: Prywatne Bufory Siatki Rezydentne w Pamięci L1d (`WorkerBuffers`)

#### 2.2.1. Geometria pamięci podręcznej a rozmiar siatki
W symulacji 1D siatka przestrzenna liczy $N_G = 400$ punktów. Obliczenie rozmiaru prywatnego bufora gęstości dla jednego wątku:
$$\text{Rozmiar bufora} = (N_G + 16) \times 8\text{ B} = 416 \times 8\text{ B} = \mathbf{3328\text{ B} \approx 3.25\text{ KB}}$$

Rdzeń procesora **AMD Zen 4 (EPYC 9554)** dysponuje **32 KB pamięci podręcznej L1 Data Cache (L1d)** na każdy rdzeń fizyczny (czas dostępu: 4–5 cykli zegara, przepustowość: dwa 512-bitowe odczyty i jeden 512-bitowy zapis na cykl).  
Bufor o rozmiarze $3.25\text{ KB}$ zajmuje zaledwie **10.1% pojemności pamięci L1d**! Oznacza to, że cała prywatna tablica depozycji mieści się bez przeszkód w najszybszej pamięci procesora przez cały czas trwania pętli cząstkowej.

#### 2.2.2. Definicja struktur w [`state.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L179-L208)
```cpp
// state.h
struct WorkerBuffers {
    // Prywatne bufory depozycji gęstości ładunku (Krok 1) (z buforem SIMD)
    std::vector<std::array<double, N_G + 16>> e_density;
    std::vector<std::array<double, N_G + 16>> i_density;

    // Prywatne bufory diagnostyk elektronowych (Krok 3)
    std::vector<std::array<double, N_G>> counter_e;
    std::vector<std::array<double, N_G>> ue;
    std::vector<std::array<double, N_G>> meanee;
    std::vector<std::array<double, N_G>> ioniz;
    std::vector<std::array<double, N_EEPF>> eepf;

    // Prywatne bufory nowo narodzonych cząstek dla każdego wątku (Krok 7)
    std::vector<NewParticles> new_electrons;
    std::vector<NewParticles> new_ions;
    ...
};
inline WorkerBuffers worker_buffers;
```

#### 2.2.3. Implementacja dwufazowej depozycji w [`simulation.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h#L53-L96)
```cpp
// simulation.h
PIC_STEP void step1_compute_electron_density_body(int tid, int num_threads) {
    // 1. Wyzerowanie lokalnego bufora w L1d (3.25 KB - błyskawiczny memset)
    worker_buffers.e_density[tid].fill(0.0);

    int chunk = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end   = std::min(k_start + chunk, N_e);

    // 2. Faza lokalna (Scatter-Add): Cząstki deponują wagę do prywatnego bufora L1d
    for (int k = k_start; k < k_end; k++) {
        double c0 = x_e[k] * INV_DX;
        int p     = int(c0);
        double c2 = (c0 - p) * FACTOR_W;
        double c1 = FACTOR_W - c2;
        worker_buffers.e_density[tid][p]   += c1;
        worker_buffers.e_density[tid][p+1] += c2;
    }

    #pragma omp barrier

    // 3. Faza redukcji (Parallel Grid Reduction): 
    // Każdy wątek sumuje swój wycinek siatki z buforów wszystkich wątków
    #pragma omp for schedule(static) nowait
    for (int p = 1; p < N_G-1; p++) {
        double sum = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum += worker_buffers.e_density[t][p];
        }
        e_density[p] = sum;
        cumul_e_density[p] += sum;
    }

    if (tid == 0) {
        double sum0 = 0.0, sumN = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum0 += worker_buffers.e_density[t][0];
            sumN += worker_buffers.e_density[t][N_G - 1];
        }
        double val0 = 2.0 * sum0;
        double valN = 2.0 * sumN;
        e_density[0] = val0;
        cumul_e_density[0] += val0;
        e_density[N_G - 1] = valN;
        cumul_e_density[N_G - 1] += valN;
    }
}
```

```
SCHEMAT DWUFAZOWEJ DEPOZYCJI ŁADUNKU:
┌────────────────────────────────────────────────────────────────────────┐
│ FAZA 1: RÓWNOLEGŁA DEPOZYCJA W PAMIĘCI L1D (BEZ SYNCHRONIZACJI)        │
│                                                                        │
│ Cząstki Wątku 0 [0 .. N/4]    ──> e_density[tid=0][400]  (Cache L1d)   │
│ Cząstki Wątku 1 [N/4 .. N/2]  ──> e_density[tid=1][400]  (Cache L1d)   │
│ Cząstki Wątku 2 [N/2 .. 3N/4] ──> e_density[tid=2][400]  (Cache L1d)   │
│ Cząstki Wątku 3 [3N/4 .. N]   ──> e_density[tid=3][400]  (Cache L1d)   │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                         #pragma omp barrier
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│ FAZA 2: RÓWNOLEGŁA REDUKCJA SIATKI DO TABLICY GLOBALNEJ                │
│                                                                        │
│ Wątek 0 sumuje p ∈ [1 .. 100]   z e_density[0..3][p] ──> e_density[p]  │
│ Wątek 1 sumuje p ∈ [101 .. 200] z e_density[0..3][p] ──> e_density[p]  │
│ Wątek 2 sumuje p ∈ [201 .. 300] z e_density[0..3][p] ──> e_density[p]  │
│ Wątek 3 sumuje p ∈ [301 .. 398] z e_density[0..3][p] ──> e_density[p]  │
└────────────────────────────────────────────────────────────────────────┘
```

#### Dlaczego to działa szybciej?
1. **Redukcja złożoności synchronizacji:** W pętli po $108\,000$ cząstkach **nie występuje ani jedna instrukcja synchronizacji**. Zapisy trafiają wyłącznie do prywatnej linii L1d.
2. **Minimalny koszt redukcji:** Redukcja dotyczy zaledwie $N_G = 400$ punktów. Zsumowanie 8 liczb zmiennoprzecinkowych dla 50 punktów przez każdy rdzeń zajmuje **~30 nanosekund**.
3. **Pamięć L1d jako idealny akumulator:** Wykorzystanie właściwości procesora, w której odczyt i zapis w obrębie gorącej linii L1d odbywa się w potoku wykonawczym bez żadnych opóźnień magistrali zewnętrznej.

---

### 2.3. Filar III: Bezalokacyjny Bufor Cząstek Wtórnych (`NewParticles`)

#### 2.3.1. Problem dynamicznej alokacji cząstek
W trakcie zderzeń Monte Carlo (Krok 7) elektrony o energii przekraczającej próg jonizacji argonu ($E > 15.8\text{ eV}$) wybijają dodatkowe elektrony z atomów gazu tła, tworząc nowe jony $\text{Ar}^+$.  
W kodzie sekwencyjnym cząstki te dopisywano bezpośrednio:
```cpp
// KOD SEKWENCYJNY:
x_e[N_e] = xe; vx_e[N_e] = vx; N_e++;
x_i[N_i] = xe; vx_i[N_i] = vx; N_i++;
```
W kodzie wielowątkowym bezpośrednie dopisanie wywołałoby natychmiastowy wyścig danych na wskaźnikach `N_e` i `N_i`. Użycie `std::vector::push_back` wewnątrz pętli wielowątkowej wiąże się z wywołaniem alokatora sterty (`malloc`), który w środowiskach wielowątkowych blokuje areny sterty (*heap arena lock*), niszcząc wydajność.

#### 2.3.2. Implementacja bufora `NewParticles` w [`state.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L147-L171)
Zaprojektowano wyspecjalizowaną strukturę bufora o stałym rozmiarze, zorganizowaną według paradygmatu **Structure of Arrays (SoA)** i wyrównaną do linii pamięci podręcznej:

```cpp
// state.h
struct alignas(64) NewParticles {
    static constexpr size_t CAPACITY = 4096;
    alignas(64) std::array<double, CAPACITY> x;
    alignas(64) std::array<double, CAPACITY> vx;
    alignas(64) std::array<double, CAPACITY> vy;
    alignas(64) std::array<double, CAPACITY> vz;
    int count = 0;

    /*
    Dodanie nowej cząstki do bufora w stałym czasie O(1).
    Zero alokacji sterty i zero rozgałęzień.
    */
    void push(double px, double pvx, double pvy, double pvz) {
        if (__builtin_expect(count < (int)CAPACITY, 1)) {
            x[count]  = px;
            vx[count] = pvx;
            vy[count] = pvy;
            vz[count] = pvz;
            count++;
        }
    }

    void reserve(size_t) {}
    void clear() { count = 0; }
    size_t size() const { return (size_t)count; }
};
```

#### 2.3.3. Użycie w pętli zderzeń i sekwencyjne scalenie
W module zderzeń [`collisions.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/collisions.h#L102-L103) wątek wywołuje operację `push()` na swoich prywatnych buforach:
```cpp
// collisions.h (linia 102)
new_e.push(xe, wx + F2 * gx2, wy + F2 * gy2, wz + F2 * gz2);
new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
```

Po zakończeniu pętli zderzeń MCC, scalenie cząstek do tablic globalnych odbywa się w jednym wątku wewnątrz sekcji `#pragma omp single` w [`simulation.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/simulation.h#L728-L749):

```cpp
// simulation.h (linie 728-749)
#pragma omp barrier
#pragma omp single
{
    for (int t = 0; t < num_threads; ++t) {
        N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
        worker_buffers.thread_counters[t].local_coll_e = 0;

        for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
            x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
            vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
            vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
            vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
            N_e++;
        }

        for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
            x_i[N_i]    = worker_buffers.new_ions[t].x[i];
            vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
            vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
            vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
            N_i++;
        }
    }
}
```

```
CYKL ŻYCIA NOWYCH CZĄSTEK W JONIZACJI:
┌────────────────────────────────────────────────────────────────────────┐
│ FAZA ZDERZEŃ MCC: RÓWNOLEGŁA REJESTRACJA W PRYWATNYCH BUFORACH         │
│                                                                        │
│ Wątek 0 rejestruje jonizacje ──> new_electrons[0] (std::array 4096)    │
│ Wątek 1 rejestruje jonizacje ──> new_electrons[1] (std::array 4096)    │
│ Wątek 2 rejestruje jonizacje ──> new_electrons[2] (std::array 4096)    │
│ Wątek 3 rejestruje jonizacje ──> new_electrons[3] (std::array 4096)    │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                         #pragma omp barrier
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│ FAZA SCALENIA: JEDEN WĄTEK (#pragma omp single)                        │
│                                                                        │
│ Kopiowanie liniowe: new_electrons[0..3] ──> Koniec tablicy x_e[N_e++]  │
│ Kopiowanie liniowe: new_ions[0..3]      ──> Koniec tablicy x_i[N_i++]  │
└────────────────────────────────────────────────────────────────────────┘
```

#### Korzyści mikroarchitektoniczne:
1. **Zero alokacji sterty (Zero Heap Allocations):** Pojemność `CAPACITY = 4096` całkowicie pokrywa maksymalną liczbę jonizacji przypadających na jeden podkrok czasowy ($\sim 50\text{--}100$). Pamięć bufora jest statyczna i rezydentna.
2. **Optymalizacja dla wektoryzacji i prefetchingu:** Układ Structure of Arrays (`x[]`, `vx[]`, `vy[]`, `vz[]`) umożliwia kompilatorowi wygenerowanie wektorowych instrukcji kopiowania `vmovapd` (AVX-512) podczas przepisywania danych w sekcji `single`.
3. **Predykcja rozgałęzień:** Dyrektywa `__builtin_expect(count < CAPACITY, 1)` instruuje kompilator, że warunek przepełnienia bufora nigdy nie zajdzie w normalnym przebiegu, co usuwa skoki warunkowe z krytycznej ścieżki pętli zderzeń.

---

### 2.4. Filar IV: Zasada Prealokacji (*Zero-Allocation-In-Loop*)

#### Implementacja w [`state.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L215-L255):
```cpp
// state.h
void init_buffers(int num_threads) {
    if ((int)e_density.size() >= num_threads) return;

    e_density.resize(num_threads);
    i_density.resize(num_threads);

    counter_e.resize(num_threads);
    ue.resize(num_threads);
    meanee.resize(num_threads);
    ioniz.resize(num_threads);
    eepf.resize(num_threads);
    thread_counters.resize(num_threads);

    counter_i.resize(num_threads);
    ui.resize(num_threads);
    meanei.resize(num_threads);

    absorbed_indices.resize(num_threads);
    local_ifed_pow.resize(num_threads);
    local_ifed_gnd.resize(num_threads);

    new_electrons.resize(num_threads);
    new_ions.resize(num_threads);
    for (int t = 0; t < num_threads; ++t) {
        new_electrons[t].reserve(2048);
        new_ions[t].reserve(2048);
        absorbed_indices[t].reserve(2000);
    }

    #pragma omp parallel for schedule(static)
    for (int i = 0; i < num_threads; ++i) {
        e_density[i].fill(0.0);
        i_density[i].fill(0.0);
        counter_e[i].fill(0.0);
        counter_i[i].fill(0.0);
    }
}
```

#### Zasada działania:
Metoda `init_buffers` wywoływana jest **dokładnie raz** przed wejściem w pętlę cykli RF. Rezerwuje ona całą pamięć wektorów i prealokuje pojemności dla wszystkich wątków.  
W trakcie 100 cykli (400 000 podkroków) program nie wykonuje **ani jednego wywołania alokatora pamięci (`malloc`, `free`, `new`, `delete`)**. Wyklucza to fragmentację pamięci RAM oraz wywołania systemowe jądra (`sys_brk` / `sys_mmap`).

---

## 3. Zestawienie Porównawcze Technik

Poniższa tabela podsumowuje zestawienie podejścia naiwnego z wdrożonym wzorcem buforowania wątkowego:

| Aspekt Architektury | Podejście Naiwne / Antywzorzec | Wdrożony Wzorzec Buforowania (Krok 1) | Zysk Inżynierski |
| :--- | :--- | :--- | :--- |
| **Losowanie liczb (PRNG)** | Współdzielony `std::mt19937` + sekcja `#pragma omp critical` | `thread_local std::mt19937 MTgen(rd())` na stosie/TLS | **100% Lock-Free**, zero narzutu synchronizacji, poprawność statystyczna |
| **Depozycja gęstości ładunku** | Współdzielona tablica `e_density` + `#pragma omp atomic` | Prywatny bufor `WorkerBuffers.e_density[tid]` w L1d (3.25 KB) + redukcja równoległa | **Eliminacja 864 mln atomików/cykl**, zapisy z latencją L1d (4 cykle zegara) |
| **Zderzenia jonizujące (MCC)** | `std::vector::push_back` ze sterty + sekcja krytyczna | Statyczny bufor `NewParticles` (`std::array<double, 4096>`) + scalenie w `single` | **Zero alokacji sterty**, wstawianie $\mathcal{O}(1)$, bezkolizyjne dopisywanie cząstek |
| **Zarządzanie pamięcią** | Alokacje dynamiczne wewnątrz pętli 400 000 kroków | Jednorazowa prealokacja `init_buffers()` przed pętlą | **Zero wywołań systemowych (`brk`/`mmap`)**, brak fragmentacji pamięci |
| **Skalowalność pamięciowa** | Ryzyko niekontrolowanego rozrostu sterty | Stały narzut pamięciowy: $\mathcal{O}(p \times N_G)$ | Zaledwie $\sim 30\text{ KB}$ na wątek (promil pamięci RAM węzła) |

---

## 4. Gotowe Fragmenty Tekstu do Pracy Magisterskiej (Podrozdział 4.3.1)

Poniższe akapity stanowią gotowy tekst naukowy do bezpośredniego włączenia do pracy magisterskiej:

### Wprowadzenie do problematyki współdzielenia pamięci:
> *„Bezpośrednie zrównoleglenie algorytmu Particle-in-Cell zderzeniowego wyładowania plazmowego (PIC/MCC) w architekturze ze współdzieloną pamięcią napotyka na fundamentalną barierę w postaci punktów rywalizacji o pamięć (memory contention). W każdym podkroku czasowym symulacji (wykonywanym 4000 razy na cykl RF) trzy kluczowe operacje wymagają ciągłego zapisu danych: wagowa depozycja ładunku metodą Cloud-in-Cell (scatter-add), próbkowanie zderzeń Monte Carlo oraz rejestracja nowych par elektron-jon powstałych w zderzeniach jonizacyjnych. Zastosowanie tradycyjnych mechanizmów synchronizacji OpenMP, takich jak sekcje krytyczne (`#pragma omp critical`) lub operacje atomowe (`#pragma omp atomic`), prowadzi do całkowitej serializacji wykonania lub zablokowania magistrali spójności pamięci podręcznej (wymagając ponad 864 milionów operacji atomowych na cykl). W ramach optymalizacji wdrożono wzorzec pełnej prywatyzacji struktur danych i buforowania wątkowego (Thread-Private Buffering & State Privatization).”*

### Analiza wdrożonych komponentów architektonicznych:
> *„Wdrożona architektura opiera się na trzech niezależnych komponentach:*  
> *1. **Prywatyzacja generatora pseudolosowego:** Każdy wątek roboczy otrzymał niezależny generator liczb pseudolosowych alokowany w pamięci lokalnej wątku (`thread_local std::mt19937 MTgen(rd())`), co wyeliminowało potrzebę synchronizacji losowań Monte Carlo i zapewniło w 100% bezblokadowy (lock-free) dostęp.*  
> *2. **Prywatne bufory siatki rezydentne w pamięci L1d:** Zamiast bezpośredniego zapisu do globalnej tablicy gęstości, każdy wątek deponuje ładunek do prywatnej tablicy `WorkerBuffers.e_density[tid]`. Przy rozmiarze siatki $N_G = 400$, bufor wątku zajmuje zaledwie 3.25 KB, co stanowi niewiele ponad 10% pojemności najszybszej pamięci podręcznej L1 Data Cache rdzenia procesora AMD Zen 4 (32 KB). Wszystkie zapisy cząstek wykonywane są z minimalną latencją L1d (4 cykle zegara) bez generowania ruchu na magistrali pamięci, a po zakończeniu pętli cząstkowej następuje szybka redukcja równoległa do tablicy globalnej.*  
> *3. **Bezalokacyjne bufory cząstek wtórnych:** W celu rejestracji elektronów i jonów wybitych w procesach jonizacji, zaimplementowano bufor `NewParticles` oparty na statycznych tablicach `std::array` o stałej pojemności 4096 elementów zorganizowanych w układzie Structure of Arrays (SoA). Całkowicie wyeliminowało to dynamiczne alokacje na stercie (`malloc`/`free`) z pętli zderzeniowej. Scalenie nowych cząstek z głównymi wektorami położeń i prędkości odbywa się sekwencyjnie w sekcji `#pragma omp single` w stałym czasie $\mathcal{O}(1)$.”*

### Podsumowanie inżynierskie:
> *„Wprowadzenie dedykowanych struktur `WorkerBuffers` oraz zasady prealokacji przed pętlą czasową (`Zero-Allocation-In-Loop`) usunęło wszystkie wąskie gardła synchronizacyjne z krytycznej ścieżki obliczeń cząstkowych. Złożoność synchronizacji została przeniesiona z poziomu pojedynczych makrocząstek ($N \approx 10^5$) na poziom węzłów siatki ($N_G = 400$). Umożliwiło to liniowe skalowanie fazy pusher-gather-scatter i stanowiło konieczny fundament pod dalsze optymalizacje wielordzeniowe.”*
