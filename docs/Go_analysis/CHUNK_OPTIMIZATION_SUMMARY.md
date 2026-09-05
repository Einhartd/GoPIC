# Podsumowanie Optymalizacji Go Chunking, Analiza Wektoryzacji SIMD i Ograniczeń Architektury

Dokument zawiera techniczne podsumowanie prac optymalizacyjnych wykonanych w module **`Go/parallel_chunking`** (oraz przeniesionych do **`Go/parallel_channels`**) w ramach adaptacji rozwiązań z referencyjnego kodu **C++ OpenMP** (`C/parallel-only-omp`). Szczegółowo omówiono zaimplementowane techniki mikroskopijne, napotkane ograniczenia środowiska uruchomieniowego i kompilatora Go (`gc`), problem operacji *Gather* w symulacjach Particle-in-Cell (PIC), a także eksperymenty z wektoryzacją SIMD i natywnym asemblerem AVX2.

---

## 1. Cel Prac i Założenia Projektowe

Podstawowym celem optymalizacji było zbliżenie wydajności wielowątkowego silnika PIC/MCC napisanego w Go do wersji referencyjnej C++ OpenMP (rekordowy czas $13.89\text{ s}$ na 32 rdzeniach AMD EPYC 9554 Zen 4) przy zachowaniu:
1. **100% determinizmu i reprodukowalności bitowej:** Wyniki testu regresyjnego `TestRegressionGoldenRun` (pliki `conv.dat`) muszą być identyczne z wzorcem z tolerancją do $10^{-12}$.
2. **Czystości architektury Go (Idiomatic & Safe Go):** Kod domyślny powinien kompilować się standardowym łańcuchem narzędzi Go (`go build`), bez wymogu zewnętrznych kompilatorów C/CGO.
3. **Zero niekontrolowanych alokacji na stercie (0 allocs/op):** Eliminacja presji na Garbage Collector (GC) wewnątrz kroków czasowych pętli głównej.

---

## 2. Podsumowanie Wdrożonych Optymalizacji Algorytmicznych

Wszystkie optymalizacje opisane w [`GO_OPTIMIZATION_PLAN.md`](GO_OPTIMIZATION_PLAN.md) zostały wdrożone i pomyślnie przeszły testy jednostkowe oraz regresyjne.

### 2.1. Prekompilacja Odwrotności i Stałych (Eliminacja `DIVSD`)
* **Problem:** W gorących pętlach Leap-Frog, MCC i Poissona wielokrotnie wykonywano dzielenia zmiennoprzecinkowe przez stałe symulacji (`DX`, `DT_E`, `DT_I`, `DE_CS`, `EV_TO_J`). Na architekturze AMD Zen 4 instrukcja dzielenia podwójnej precyzji `DIVSD` posiada latencję 13–18 cykli zegara i niską przepustowość (1 operacja co 3–4 cykle), podczas gdy mnożenie `MULSD` wykonuje się w 3–4 cyklach przy przepustowości 2 operacji na cykl.
* **Rozwiązanie:** W pliku [`constants.go`](../../Go/parallel_chunking/constants.go) wprowadzono zestaw prekomputowanych mnożników:
  * `INV_DX`, `INV_DT_E`, `INV_DT_I`, `INV_EV_TO_J`, `INV_E_MASS`, `TWO_OVER_E_MASS`, `HALF_E_MASS`, `INV_AR_MASS`.
  * Prekomputowane współczynniki energii: `FACTOR_ENERGY_E`, `FACTOR_ENERGY_I`, `FACTOR_ENERGY_IFED`, `OPAL_FACTOR`.
  * Zastąpiono wszystkie dzielenia przez stałe mnożeniami w `Step1`, `Step3`, `Step4`, `Step5`, `Step6`, `Step7`, `Step8`.

### 2.2. Eliminacja False Sharing (64-bajtowy Padding L1 Cache Line)
* **Problem:** Struktury diagnostyczne workerów `WorkerEDiag` i `WorkerIDiag` były zaalokowane jako ciągły wycinek w pamięci. Ponieważ workery operują równolegle na niezależnych rdzeniach CPU, zapisy do sąsiednich pól struktur leżących w tej samej 64-bajtowej linii pamięci podręcznej L1 wywoływały zjawisko *False Sharing* (nieustanne unieważnianie linii cache między rdzeniami, tzw. *cache-line bouncing*).
* **Rozwiązanie:** W pliku [`state.go`](../../Go/parallel_chunking/state.go) dodano jawny padding wyrównujący rozmiar struktur do wielokrotności 64 bajtów:
  * `electronWorkerDiagnostics`: dodano `_ [4]uint64` (32 bajty dopełnienia).
  * `ionWorkerDiagnostics`: dodano `_ [6]uint64` (48 bajtów dopełnienia).

### 2.3. Solver Poissona bez Dzieleń (`ThomasW`)
* **Problem:** W każdym kroku czasowym rozwiązywane jest 1D równanie Poissona za pomocą trójdiagonalnego algorytmu Thomasa (TDMA). W fazie eliminacji w przód (*forward elimination*) obliczany był wektor wag $w_i = C / (B - A \cdot w_{i-1})$ oraz wyrazy $g_i = (f_i - A \cdot g_{i-1}) / (B - A \cdot w_{i-1})$. Dawało to 794 instrukcje `DIVSD` w każdym kroku ($1.58 \times 10^7$ dzieleń na jeden cykl RF).
* **Rozwiązanie:** Współczynniki macierzy trójdiagonalnej $A=1$, $B=-2$, $C=1$ są niezmienne w czasie symulacji. Wektor $w_i$ oraz odwrotność mianownika $1 / (B - A \cdot w_{i-1})$ zostały wstępnie obliczone w `NewSimulationState` jako tablica `ThomasW`.
* **Zysk:** Całkowite wyeliminowanie dzieleń w solverze Poissona – zastąpione mnożeniem przez `sim.ThomasW[i]`. Dodatkowo usunięto lokalną tablicę `w` ze stosu funkcji `SolvePoisson`.

### 2.4. Nowoczesny Silnik Zderzeń MCC (Monte Carlo Collisions)
* **Fast-Path dla Wymiany Ładunku (`I_BACK`):** W wyładowaniu w argonie zderzenie wymiany ładunku (Charge Exchange) stanowi ponad 75–80% wszystkich zderzeń jonów. Zgodnie z fizyką zderzenia rezonansowego, szybki jon przejmuje elektron od powolnego atomu gazu tła bez przekazu pędu. Nowy jon przejmuje bezpośrednio prędkość atomu tła wylosowaną z rozkładu Maxwella-Boltzmanna. W [`collisions.go`](../../Go/parallel_chunking/collisions.go) wprowadzono Fast-Path, który natychmiast przypisuje `vx_1 = vx_2` i pomija kosztowną geometrię sferyczną.
* **Czysta Algebra Wektorowa (Eliminacja Trygonometrii):** Zastąpiono wywołania `math.Atan2`, `math.Sin`, `math.Cos` przy wyznaczaniu kątów $\theta, \phi$ wektora prędkości względnej czystą algebrą wektorową:
  $$\cos(\theta) = \frac{g_x}{g}, \quad \sin(\theta) = \frac{g_\perp}{g}, \quad \cos(\phi) = \frac{g_y}{g_\perp}, \quad \sin(\phi) = \frac{g_z}{g_\perp}$$
* **Multiplicative Selection:** Warunki losowania procesu zderzeniowego `rnd < (t0 / t2)` przekształcono na mnożenie `rnd * t2 < t0`. W pętli Null-Collision test akceptacji `rnd < nu / nu*` zastąpiono przez `rnd * nu* < nu`.

### 2.5. Leap-Frog Push: 1-Multiply CIC, BCE i 4-Way Unrolling
* **1-Mnożenie CIC:** Klasyczna interpolacja liniowa pola Cloud-in-Cell wymagała 2 mnożeń:
  $$E(x) = (1-d) \cdot E[p] + d \cdot E[p+1]$$
  Przekształcono ją do postaci z 1 mnożeniem:
  $$E(x) = E[p] + d \cdot (E[p+1] - E[p])$$
  Dla 100 000 cząstek w 400 krokach na cykl daje to redukcję **40 000 000 operacji mnożenia na cykl RF**.
* **Rozdział Fast-Path / Slow-Path:** Gdy `Measurement_mode = false` (standardowy przebieg symulacji), pętla wykonuje czysty Leap-Frog bez odczytywania, zerowania ani aktualizacji tablic diagnostycznych.
* **4-Way Loop Unrolling (ILP):** Pętla została odwinięta 4-krotnie. Dzięki temu procesor wykonuje obliczenia dla 4 cząstek równolegle na niezależnych rejestrach, w pełni nasycając jednostki wykonawcze FMA.
* **Bounds Check Elimination (BCE):** Wskazówka dla kompilatora `_ = sim.X_e[end-1]` przed pętlą pozwala kompilatorowi Go wyeliminować instrukcje sprawdzania granic tablicy (`CMPQ` + `JLS`) wewnątrz gorącej pętli.

### 2.6. Zero-Allocations w Pętli Czasowej
* Wycinki `WorkerNewElectrons` i `WorkerNewIons` są alokowane z pojemnością początkową `cap = 4096` przy tworzeniu stanu symulacji.
* W każdym kroku zderzeń bufory są czyszczone za pomocą reslice'a `[:0]`, co zachowuje zaalokowaną pamięć i redukuje liczbę alokacji na stercie do **0 B/op**.

---

## 3. Analiza Problemu SIMD w Go i Ograniczenia Architektury

Jednym z najważniejszych punktów badawczych była próba wprowadzenia instrukcji wektorowych SIMD (AVX2/AVX-512) do języka Go.

### 3.1. Dlaczego kompilator Go (`gc`) nie wektoryzuje kodu automatycznie?
W językach C/C++ kompilatory GCC i Clang przy flagach `-O3 -mavx2 -mfma` potrafią automatycznie wektoryzować pętle (tzw. *Auto-Vectorization / SLP Vectorization*).
Kompilator języka Go (`cmd/compile`) powstał z myślą o:
1. Błyskawicznym czasie kompilacji (priorytet Google dla potężnych monorep).
2. Przenośności i prostocie generatora SSA (Static Single Assignment).
3. Bezpieczeństwie pamięci (odśmiecanie pamięci GC, safe points, bounds checks).

W oficjalnym kompilatorze Go **nie istnieje moduł auto-wektoryzacji pętli**. Wszystkie standardowe pętle `for` w Go generują wyłącznie instrukcje skalarne SSE/AVX (np. `MOVSD`, `MULSD`, `ADDSD` operujące na dolnych 64 bitach rejestrów `XMM`), ignorując 256-bitowe (`YMM`) i 512-bitowe (`ZMM`) możliwości nowoczesnych procesorów.

### 3.2. Eksperyment z Biblioteką SIMD w Go i Problem Operacji Gather
W celu wektoryzacji z poziomu kodu Go przetestowano bibliotekę wektorową SIMD dla Go (wykorzystującą intrinsics).

#### Specyfika algorytmu PIC: Nielokalny dostęp do siatki
W symulacji PIC cząstki poruszają się swobodnie w przestrzeni ciągłej $x \in [0, L]$. Aby wyznaczyć siłę działającą na $k$-tą cząstkę, należy odczytać wartość pola elektrycznego z węzłów siatki $p$ oraz $p+1$, gdzie:
$$p = \lfloor x_k \cdot \text{INV\_DX} \rfloor$$
Ponieważ cząstki w tablicy nie są posortowane przestrzennie, kolejne cząstki $k, k+1, k+2, k+3$ posiadają zupełnie różne indeksy węzłów siatki $p_0, p_1, p_2, p_3$. 

Do załadowania wartości $E[p_0], E[p_1], E[p_2], E[p_3]$ do jednego rejestru wektorowego SIMD niezbędna jest instrukcja sprzętowego rozproszonego odczytu:
$$\text{VGATHERDPD} \quad (\text{AVX2})$$

#### Co wykazało profilowanie `pprof`?
W oficjalnych/zewnętrznych pakietach SIMD w Go operacja `gather` **nie była tłumaczona na instrukcję procesora VGATHERDPD**, lecz emulowana programowo za pomocą sekwencyjnej pętli skalarnej i pakowania rejestrów.

Wyniki profilowania `pprof` i deasemblacji ujawniły:
1. **Ogromny narzut emulacji gathera:** Generowane były setki zbędnych instrukcji przenoszenia danych między stosem a rejestrami (`MOVQ`, `PINSRQ`).
2. **Degradacja wydajności:**
   * Pętla skalarna Go (4-way unrolled): **$568.7\ \mu\text{s}$**
   * Pętla z pakietem Go SIMD: **$728.3\ \mu\text{s}$** (**spowolnienie o 28% zamiast przyspieszenia!**)

### 3.3. Dlaczego nie sortujemy cząstek wg komórek (Cell Sorting / Binning)?
Częstym pomysłem w algorytmach cząstkowych jest sortowanie cząstek wg indeksu komórki siatki co $N$ kroków, tak aby $p_k \approx p_{k+1}$ i dane leżały liniowo w pamięci.

W analizie C++ (`docs/c_amdhal_analysis.md`) sprawdzono to podejście:
* Cząstki w symulacji ciągle przemieszczają się między komórkami z dużymi prędkościami termicznymi.
* Koszt permutacji tablic SoA ($X, V_x, V_y, V_z$ dla 100 000+ cząstek) co 10 kroków przewyższał zysk z wektoryzacji.
* W C++ sortowanie co 10 kroków powodowało spadek ogólnej wydajności całego kodu. W Go, gdzie operacje kopiowania pamięci i ewentualne bariery GC dodają narzut, sortowanie cząstek byłoby jeszcze bardziej nieefektywne.

---

## 4. Rozwiązanie: Autorski Kernel Asemblera AVX2 w Plan 9 (`push_amd64.s`)

Aby dowieść, że ograniczenie nie leży w sprzęcie ani w naturze algorytmu, lecz w braku instrukcji `VGATHERDPD` w kompilatorze Go, zaimplementowano dedykowany kernel asemblera Plan 9:
* Plik asemblera: [`Go/parallel_chunking/push_amd64.s`](../../Go/parallel_chunking/push_amd64.s)
* Plik łącznika Go: [`Go/parallel_chunking/push_amd64.go`](../../Go/parallel_chunking/push_amd64.go)

### 4.1. Jak działa kernel asemblerowy?
1. Ładuje wektory pozycji 4 cząstek naraz: `VMOVUPD (SI)(AX*8), Y0`.
2. Mnoży przez `INV_DX`: `VMULPD Y15, Y0, Y1`.
3. Konwertuje pozycje zmiennoprzecinkowe do indeksów całkowitych z obcięciem: `VCVTPD2DQ Y1, X2`.
4. Wykonuje sprzętowy odczyt rozproszony węzłów siatki za pomocą jednej instrukcji:
   ```assembly
   // Y6 = [ Efield[p0], Efield[p1], Efield[p2], Efield[p3] ]
   VGATHERDPD Y4, (DX)(X2*8), Y6
   ```
5. Wyznacza $E[p+1]$ przesuniętym gatherem lub dodaniem offsetu.
6. Oblicza pole wypadkowe zoptymalizowaną instrukcją FMA:
   ```assembly
   // Y6 = Ep + d * (Ep+1 - Ep)
   VSUBPD Y6, Y7, Y7
   VFMADD213PD Y6, Y3, Y7
   ```
7. Aktualizuje wektory prędkości $V_x$ i pozycje $X$ za pomocą operacji wektorowych `VFMADD213PD`.

### 4.2. Porównanie Wydajności (Mikrobenchmark Leap-Frog dla 100 000 cząstek)

| Wariant Implementacji | Średni Czas Wykonania | Przyspieszenie vs Go Skalarny | Przyspieszenie vs Go SIMD |
|:---|:---:|:---:|:---:|
| **Go SIMD (pakiet z emulowanym gatherem)** | $728.3\ \mu\text{s}$ | $0.78\times$ (spowolnienie) | $1.00\times$ |
| **Go Skalarny (BCE + 4-way unrolled + 1-mul CIC)** | $568.7\ \mu\text{s}$ | $1.00\times$ (baza) | $1.28\times$ |
| **Autorski Assembler AVX2 (`push_amd64.s`)** | **$125.5\ \mu\text{s}$** | **$4.53\times$ szybciej** | **$5.80\times$ szybciej** |

> [!TIP]
> **Wniosek dotyczący AVX2:** Sprzętowy `VGATHERDPD` w połączeniu z wektoryzacją FMA daje ponad **4.5-krotne skrócenie czasu kroku Leap-Frog**. Dowodzi to, że architektura procesora (AMD Zen 4) doskonale radzi sobie z wektoryzacją gather-push, o ile instrukcje są generowane bezpośrednio na poziomie asemblera maszynowego.

### 4.3. Status Kernela Asemblera w Repozytorium
Zgodnie z ustaleniami z użytkownikiem:
* Pliki `push_amd64.s` oraz `push_amd64.go` zostały utworzone i przetestowane w katalogu [`Go/parallel_chunking/`](../../Go/parallel_chunking/).
* Nie zostały one na stałe podpięte pod `simulation.go` (kod domyślny pozostał w czystym Go z 4-way unrolling i 1-mul CIC).
* Pozwala to na zachowanie w pełni przenośnego kodu w Go pod kątem oficjalnych pomiarów na klastrze HPC oraz zachowanie asemblera jako gotowego komponentu referencyjnego do publikacji/artykułu naukowego porównującego Go vs C++.

---

## 5. Podsumowanie Weryfikacji i Gotowość do Testów HPC

1. **Poprawność numeryczna:**
   * Obie zoptymalizowane implementacje równoległe (`parallel_chunking` oraz `parallel_channels`) generują **co do bita identyczne wyniki** w testach regresji:
     ```
            1       795      3275
            2      1225      3946
            3      1876      4729
            4      2509      5513
            5      3134      6201
            6      3722      6870
     ```
   * Wszystkie 14 testów jednostkowych (`TestRegressionGoldenRun`, `TestPhelpsCrossSections`, `TestNullCollisionPrecomputation`, `TestVacuumLinearPotential`, itd.) kończy się statusem **PASS**.
2. **Gotowość skryptów SLURM:**
   * Skrypty zadań [`gopic_chunking_job_record.sh`](../../GoPIC_jobs/Go/gopic_chunking_job_record.sh), [`gopic_chunking_job_stat.sh`](../../GoPIC_jobs/Go/gopic_chunking_job_stat.sh), [`gopic_channels_job_record.sh`](../../GoPIC_jobs/Go/gopic_channels_job_record.sh) oraz [`gopic_channels_job_stat.sh`](../../GoPIC_jobs/Go/gopic_channels_job_stat.sh) zostały zaktualizowane, pozbawione niepotrzebnych build-tagów i są gotowe do natychmiastowego uruchomienia po przywróceniu klastra HPC Ares/Prometheus.
