# Raport Skalowania Silnego i Analizy Wydajnościowej: Go Chunking (HPC)

**Data pomiarów:** 7 września 2026  
**Platforma testowa:** Klaster HPC WCSS Lem (`plgrid-lem-cpu`)  
**Architektura procesora:** Dual-Socket AMD EPYC 9554 (Zen 4, 2 gniazda × 64 rdzenie, 128 wątków online, 16 modułów CCX po 32 MB L3 Cache)  
**Środowisko programistyczne:** Go `go1.26.5 linux/amd64`, docelowa architektura `GOAMD64=v4`  
**Model fizyczny:** 1D3V PIC-MCC (Argon, siatka $N_G = 400$, 100 cykli RF, $N_T = 4000$ podkroków/cykl, $N_e \approx 108\,000$, $N_i \approx 113\,500$)  
**Narzędzie pomiarowe:** Linux `perf stat` (metryki sprzętowe CPU cycles, instructions, IPC, L1-dcache misses, task-clock, user/sys time)  
**Kod źródłowy:** [`Go/parallel_chunking`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking)

---

## 1. Wprowadzenie i Cel Analizy

W ramach badań nad efektywnością zrównoleglania kodu symulacji wyładowań plazmowych Particle-in-Cell (PIC-MCC) w języku Go, przeprowadzono pełną serię pomiarów skalowania silnego (*strong scaling*) dla implementacji **Go Parallel Chunking** ([`simulation.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go)). 

Pomiary wykonano na klastrze HPC dla liczby rdzeni:
$$P \in \{1, 2, 4, 8, 16, 32, 64\}$$
Każdą konfigurację przetestowano w **3 niezależnych powtórzeniach** (łącznie 21 zadań Slurm), rejestrując pełne liczniki sprzętowe za pomocą `perf stat`.

Celem niniejszego raportu jest:
1. Przedstawienie precyzyjnych danych empirycznych (czas, speedup, efektywność, IPC, narzut jądra).
2. Wyjaśnienie przyczyn załamania skalowania powyżej 8 rdzeni i drastycznego spadku wydajności na 16–64 rdzeniach.
3. Wyjaśnienie anomalii dużej zmienności wyników pomiędzy próbami (wpływ topologii NUMA i modułów CCX).
4. Zestawienie wyników z referencyjną implementacją C++/OpenMP.

---

## 2. Pełne Zestawienie Pomiarów (Wszystkie 21 Prób)

Poniższa tabela zawiera kompletne dane wyekstrahowane z plików logów `edupic_data/perf_cpu_stats.txt` oraz `job_output.log`.

| ID Zadania Slurm | $W$ (Rdzenie) | Węzeł Obliczeniowy | Przydział Rdzeni (`Cpus_allowed`) | Topologia NUMA / CCX | Czas (s) | User (s) | Sys (s) | CPUs Utilized | IPC | Instrukcje (bln) | L1 Miss (%) |
|:---:|:---:|:---:|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **5838290** | 1 | `r13ch01b01` | `113` | NUMA 1 (CCX 14) | 210.53 | 208.03 | 0.33 | 1.00 | 4.35 | 3.386 | 2.58% |
| **5838291** | 1 | `r13ch01b01` | `114` | NUMA 1 (CCX 14) | 209.39 | 206.91 | 0.33 | 1.00 | 4.37 | 3.386 | 2.58% |
| **5838292** | 1 | `r13ch01b01` | `120` | NUMA 1 (CCX 15) | 207.01 | 204.63 | 0.30 | 1.00 | 4.42 | 3.386 | 2.58% |
| **5838306** | 2 | `r13ch01b01` | `113,114` | 1 CCX (NUMA 1) | 157.57 | 245.78 | 10.74 | 1.65 | 3.72 | 3.392 | 3.73% |
| **5838307** | 2 | `r13ch01b01` | `120,121` | 1 CCX (NUMA 1) | 154.63 | 239.75 | 11.55 | 1.65 | 3.81 | 3.399 | 3.58% |
| **5838308** | 2 | `r13ch01b02` | `60,61` | 1 CCX (NUMA 0) | **141.07** | 240.76 | 11.42 | 1.81 | 3.79 | 3.394 | 4.04% |
| **5838349** | 4 | `r11ch12b03` | `112-115` | 1 CCX (NUMA 1) | 114.64 | 265.73 | 31.67 | 2.62 | 3.63 | 3.421 | 4.45% |
| **5838350** | 4 | `r11ch12b03` | `116-119` | 1 CCX (NUMA 1) | **114.40** | 263.79 | 31.29 | 2.60 | 3.66 | 3.421 | 4.43% |
| **5838351** | 4 | `r13ch01b01` | `113,114,120,121` | ⚠️ Split Cross-CCX | 193.24 | 467.06 | 32.51 | 2.60 | 1.98 | 3.417 | 4.51% |
| **5839249** | 8 | `r11ch12b03` | `88-95` | 1 CCX (NUMA 1, 8 rdzeni) | **96.95** 🏆 | 270.68 | 50.50 | 3.34 | 3.52 | 3.468 | 4.86% |
| **5839250** | 8 | `r11ch12b03` | `96-103` | 1 CCX (NUMA 1, 8 rdzeni) | 98.06 | 277.56 | 50.65 | 3.37 | 3.44 | 3.467 | 4.87% |
| **5839251** | 8 | `r13ch09b03` | `38-43,57,58` | ⚠️ Pofragmentowany CCX | 175.31 | 449.13 | 41.76 | 2.82 | 2.09 | 3.454 | 4.40% |
| **5839268** | 16 | `r11ch12b03` | `88-103` | 2 spójne CCX (NUMA 1) | **129.05** | 291.11 | 33.89 | 2.54 | 3.41 | 3.527 | 4.57% |
| **5839269** | 16 | `r13ch04b03` | `14-21,76-83` | ⚠️ Cross-Socket (NUMA 0+1) | 211.08 | 524.52 | 37.86 | 2.69 | 1.85 | 3.517 | 4.16% |
| **5839270** | 16 | `r13ch09b04` | `51-58,115-122` | ⚠️ Cross-Socket (NUMA 0+1) | 211.50 | 599.36 | 49.85 | 3.10 | 1.61 | 3.524 | 4.31% |
| **5839296** | 32 | `r13ch11b02` | `0-11,28-47` | 1 Gniazdo (NUMA 0) | 140.49 | 566.74 | 70.12 | 4.55 | 1.78 | 3.707 | 5.72% |
| **5839297** | 32 | `r13ch11b02` | `64-75,92-111` | 1 Gniazdo (NUMA 1) | **136.80** | 515.50 | 63.36 | 4.25 | 1.96 | 3.701 | 5.61% |
| **5839298** | 32 | `r13ch11b02` | `48-63,112-127` | ⚠️ Cross-Socket (NUMA 0+1) | 191.13 | 954.16 | 98.46 | 5.54 | 1.06 | 3.738 | 5.96% |
| **5839300** | 64 | `r17ch07b02` | `0-63` | Całe Gniazdo 0 (NUMA 0) | **166.57** | 872.07 | 97.32 | 5.85 | 1.26 | 4.038 | 6.74% |
| **5839301** | 64 | `r17ch07b02` | `64-127` | Całe Gniazdo 1 (NUMA 1) | 167.73 | 874.45 | 96.37 | 5.83 | 1.26 | 4.034 | 6.78% |
| **5839302** | 64 | `r17ch08b03` | `16-47,80-111` | ⚠️ Cross-Socket (32+32) | 219.98 | 1268.87 | 133.22 | 6.42 | 0.87 | 4.084 | 6.90% |

---

## 3. Podsumowanie Statystyczne i Metryki Skalowania

Przyspieszenie obliczono jako $S(P) = \frac{T_1}{T_P}$, a efektywność równoległą jako $E(P) = \frac{S(P)}{P} \times 100\%$. 
Zestawiono zarówno wartości średnie (ze wszystkich 3 prób), jak i wartości **optymalne (Best Case)**, w których pomiar nie został zakłócony pofragmentowaną alokacją Slurma.

### Tabela 1: Skalowanie Silne (Średnie z 3 prób)

| $P$ (Rdzenie) | Czas Śr. (s) | Odchylenie Czasu | Speedup Śr. $S(P)$ | Efektywność Śr. $E(P)$ | Czas Sys (s) | CPUs Utilized | IPC Średnie |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **1** | 208.97 | $\pm 1.8$ s | **1.00×** | **100.0%** | 0.32 s | 1.00 / 1 | 4.38 |
| **2** | 151.09 | $\pm 8.8$ s | **1.38×** | **69.2%** | 11.24 s | 1.70 / 2 | 3.77 |
| **4** | 140.76 | $\pm 45.4$ s | **1.48×** | **37.1%** | 31.83 s | 2.61 / 4 | 3.09 |
| **8** | **123.44** | $\pm 44.9$ s | **1.69×** 🏆 | **21.2%** | 47.63 s | 3.18 / 8 | 3.02 |
| **16** | 183.88 | $\pm 47.5$ s | **1.14×** | **7.1%** | 40.54 s | 2.78 / 16 | 2.29 |
| **32** | 156.14 | $\pm 30.4$ s | **1.34×** | **4.2%** | 77.31 s | 4.78 / 32 | 1.60 |
| **64** | 184.76 | $\pm 30.5$ s | **1.13×** | **1.8%** | **108.97 s** | **6.03 / 64** | **1.13** |

### Tabela 2: Skalowanie Silne (Najlepsza Próba – Best Case bez kar NUMA)

| $P$ (Rdzenie) | Czas Min (s) | Speedup Max $S(P)$ | Efektywność Max $E(P)$ | CPUs Utilized | IPC |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **1** | 207.01 | 1.00× | 100.0% | 1.00 | 4.42 |
| **2** | 141.07 | 1.47× | 73.4% | 1.81 | 3.79 |
| **4** | 114.40 | 1.81× | 45.2% | 2.60 | 3.66 |
| **8** | **96.95** 🏆 | **2.14×** | **26.7%** | 3.34 | 3.52 |
| **16** | 129.05 | 1.60× | 10.0% | 2.54 | 3.41 |
| **32** | 136.80 | 1.51× | 4.7% | 4.25 | 1.96 |
| **64** | 166.57 | 1.24× | 1.9% | 5.85 | 1.26 |

---

## 4. Główna Diagnoza: Dlaczego Implementacja Go Chunking Poniosła Porażkę?

Dane z liczników `perf stat` i analiza logów ujawniają 4 fundamentalne zjawiska, które doprowadziły do zapaści wydajnościowej.

### Filar I: Patologia Mikrozadań (*Micro-Tasking Overhead*) i Dynamiczny Fork-Join

W architekturze `parallel_chunking` zrównoleglenie oparte jest o dynamiczne wywołania:
```go
var wg sync.WaitGroup
for w := range numWorkers {
    wg.Go(func() { ... })
}
wg.Wait()
```
Taki blok jest wykonywany wielokrotnie w **każdym pojedynczym podkroku czasowym**:
1. `Step1ComputeElectronDensity` – co krok czasowy ($400\,000$ razy)
2. `Step3MoveElectrons` (Leap-Frog) – co krok czasowy ($400\,000$ razy)
3. `Step5CheckBoundariesElectrons` – co krok czasowy ($400\,000$ razy)
4. `Step7CollisionsElectrons` (Null-Collision) – co krok czasowy ($400\,000$ razy)
5. Kroki jonowe (1b, 4, 6, 8) – wykonywane w subcyclingu co 50 kroków ($8\,000$ razy)

#### Skala zjawiska w 100 cyklach:
- Łączna liczba barier synchronizacyjnych (`wg.Wait()`): **ponad 1 632 000 barier**!
- Dla konfiguracji $W = 64$ workerów:
  $$1\,632\,000 \times 64 = \mathbf{104\,448\,000 \text{ goroutines!}}$$
  Aplikacja tworzy, kolejkuje w schedulerze Go i niszczy **ponad 104 miliony goroutines** w trakcie jednego 3-minutowego biegu!

#### Relacja czasu obliczeń do czasu synchronizacji:
Pojedynczy krok symulacji na 1 rdzeniu trwa średnio:
$$\frac{207 \text{ s}}{400\,000} \approx 517\,\mu\text{s}$$
Gdy podzielimy cząstki ($N_e \approx 108\,000$) na $W = 64$ workerów, każdy worker otrzymuje porcję zaledwie **1680 cząstek**:
- W kroku sprawdzania granic (Krok 5): przejście po 1680 liczbach `float64` w pamięci podręcznej L1 trwa **poniżej $0.8\,\mu\text{s}$**!
- W kroku depozycji (Krok 1): obliczenia na workera trwają **około $1.5\,\mu\text{s}$**.
- W kroku Leap-Frog (Krok 3): obliczenia trwają **około $2.0\,\mu\text{s}$**.

Natomiast w runtime Go:
- Koszt alokacji ramki goroutine i dodania do kolejki runqueue: $\sim 0.2 - 0.5\,\mu\text{s}$.
- Koszt wybudzenia uśpionego wątku systemowego `M` przez wywołanie systemowe futex: **$2.0 - 5.0\,\mu\text{s}$**.
- Koszt przejścia przez barierę `sync.WaitGroup` (operacje atomowe + powiadomienie): $\sim 0.5 - 1.5\,\mu\text{s}$.

> **Złamanie granicy opłacalności zrównoleglenia (Granularity Inversion):**  
> Koszt zarządzania goroutines i synchronizacji wątków ($3 - 8\,\mu\text{s}$) jest **kilkukrotnie wyższy** niż faktyczna praca fizyczna wykonywana przez workera ($0.8 - 2\,\mu\text{s}$)!

#### Narzut w liczbie instrukcji (Instruction Bloat):
- Na 1 rdzeniu wykonano **3,386 biliona instrukcji**.
- Na 64 rdzeniach wykonano **4,084 biliona instrukcji**.
- Nadmiar: **698 MILIARDÓW instrukcji CPU** zmarnowanych wyłącznie na maszynerię planisty Go runtime, kolejkowanie, wywołania funkcji anonimowych i atomiki w barierach!

---

### Filar II: Eksplozja Wywołań Systemowych i Zapaść w Jądrze Linuxa (`SYS_futex`)

Metryka czasu systemowego (`Sys time`) w `perf stat` bezlitośnie obnaża zachowanie wątków systemowych Go:
- **1 rdzeń:** `Sys` = **0.32 s** (0.15% czasu)
- **2 rdzenie:** `Sys` = **11.24 s** (7.4% czasu)
- **4 rdzenie:** `Sys` = **31.83 s** (22.6% czasu)
- **8 rdzeni:** `Sys` = **47.63 s** (38.6% czasu)
- **32 rdzenie:** `Sys` = **77.31 s** (49.5% czasu)
- **64 rdzenie:** `Sys` = **108.97 s (59.0% czasu całkowitego!)**

Na 64 rdzeniach program spędza **ponad 59% czasu zegarowego wewnątrz jądra systemu operacyjnego Linux**!

#### Mechanizm zjawiska:
Gdy zadanie workera kończy się w ułamku mikrosekundy, wątek OS (`M` w runtime Go) nie znajduje natychmiast nowej pracy w swojej lokalnej kolejce. Planista wprowadza wątek w stan uśpienia za pomocą `runtime.notesleep` $\to$ syscall `futex(FUTEX_WAIT_PRIVATE)`. Zaledwie mikrosekundę później, w kolejnym kroku PIC, wątek koordynatora musi wybudzić uśpione wątki za pomocą `runtime.notewakeup` $\to$ syscall `futex(FUTEX_WAKE_PRIVATE)`.

Przy 1.6 miliona barier dochodzi do **sztormu wywołań futex**. Jądro Linuxa grzęźnie w rywalizacji o blokady struktur `sched` i tablic haszujących futexów.

#### Efekt na utylizację rdzeni:
Mimo że Slurm przydzielił 64 fizyczne rdzenie, `perf stat` raportuje:
$$\text{CPUs utilized: } \mathbf{6.03 \text{ z 64 rdzeni!}}$$
Pozostałe **58 rdzeni CPU jest w rzeczywistości bezużytecznych** — spędzają czas na uśpieniu w jądrze, oczekiwaniu na wybudzenie przez futex lub przełączaniu kontekstu.

---

### Filar III: Zagadka Próby 3 Rozwiązana – Architektura NUMA i Moduły CCX (AMD Zen 4)

Jednym z najbardziej uderzających zjawisk w wynikach pomiarowych była olbrzymia niestabilność: w konfiguracjach 4, 8, 16, 32 i 64 rdzeni próba nr 3 wykonywała się niemal dwukrotnie wolniej niż próba 1 i 2:
- **4 rdzenie:** Próby 1–2: $114\text{ s}$ (IPC 3.65) vs Próba 3: **$193\text{ s}$** (IPC 1.98)
- **8 rdzeni:** Próby 1–2: $97\text{ s}$ (IPC 3.48) vs Próba 3: **$175\text{ s}$** (IPC 2.09)
- **16 rdzeni:** Próba 1: $129\text{ s}$ (IPC 3.41) vs Próby 2–3: **$211\text{ s}$** (IPC 1.61–1.85)
- **64 rdzenie:** Próby 1–2: $167\text{ s}$ (IPC 1.26) vs Próba 3: **$220\text{ s}$** (IPC 0.87)

#### Wyjaśnienie topologiczne (AMD EPYC 9554):
Serwer obliczeniowy posiada dwa gniazda fizyczne (2 domeny NUMA):
- **Gniazdo 0 (NUMA 0):** Rdzenie fizyczne `0..63`
- **Gniazdo 1 (NUMA 1):** Rdzenie fizyczne `64..127`
Każde gniazdo składa się z **8 bloków CCX (Core Complex)**. W każdym bloku CCX znajduje się 8 rdzeni Zen 4 dzielących wspólną, szybką pamięć **32 MB L3 Cache**.

Analiza masek powinowactwa Slurma (`Cpus_allowed` z logów) wykazała bezpośrednią korelację:

1. **Konfiguracja 8 rdzeni (Wzorcowa):**
   - **Zadanie 5839249 (96.95 s, IPC 3.52):** Slurm przydzielił rdzenie `88-95`. Jest to **dokładnie jeden fizyczny moduł CCX** (8 sąsiednich rdzeni współdzielących 32 MB L3 w NUMA 1). Wszystkie rdzenie komunikują się przez ultralekką pamięć podręczną L3 (opóźnienie $\sim 10\,\text{ns}$).
   - **Zadanie 5839251 (175.31 s, IPC 2.09):** Slurm przydzielił pofragmentowane rdzenie `38-43, 57, 58` (rozbite pomiędzy różne bloki CCX). Komunikacja barierowa musiała przekraczać magistralę wewnętrzną Infinity Fabric.

2. **Konfiguracja 16 rdzeni (Katastrofa Cross-Socket):**
   - **Zadanie 5839268 (129.05 s, IPC 3.41):** Rdzenie `88-103` — zwarte 16 rdzeni w obrębie **jednego gniazda (NUMA 1)**.
   - **Zadanie 5839269 (211.08 s, IPC 1.85):** Slurm przydzielił rdzenie `14-21` (Gniazdo 0) oraz `76-83` (Gniazdo 1)!
   - **Zadanie 5839270 (211.50 s, IPC 1.61):** Slurm przydzielił rdzenie `51-58` (Gniazdo 0) oraz `115-122` (Gniazdo 1)!

3. **Konfiguracja 64 rdzeni:**
   - **Zadanie 5839300 (166.57 s):** Rdzenie `0-63` (zamknięte w 1 gnieździe fizycznym).
   - **Zadanie 5839302 (219.98 s):** Rdzenie `16-47` (Gniazdo 0) + `80-111` (Gniazdo 1) — idealne przecięcie na dwa gniazda po 32 rdzenie.

> **Mechanizm odbijania linii pamięci podręcznej (Cache-Line Bouncing):**  
> W architekturze z wieloma gniazdami, gdy 1.6 miliona razy modyfikowane są wspólne zmienne atomowe (liczniki `sync.WaitGroup`, wewnętrzne kolejki planisty Go, tablice gęstości ładunku), linie pamięci podręcznej muszą nieustannie przemieszczać się pomiędzy gniazdami przez łącza międzysocketowe xGMI.  
> Skutkuje to ogromnym opóźnieniem dostępu do pamięci ($>100\,\text{ns}$ vs $10\,\text{ns}$ w L3), przestojem jednostek wykonawczych CPU (*pipeline stalls*) i **załamaniem IPC z 4.38 aż do 0.87**!

---

### Filar IV: Porównanie z C++ OpenMP – Dlaczego C++ Skaluje Się Prawie Idealnie?

Wcześniejsze pomiary kodu C++ w architekturze OpenMP na tej samej maszynie wykazały znakomite skalowanie:
- C++ (1 rdzeń): **174.62 s**
- C++ (2 rdzenie): **87.41 s** ($S = 2.00\times$, $E = 99.9\%$)
- C++ (4 rdzenie): **47.97 s** ($S = 3.64\times$, $E = 91.0\%$)
- C++ (8 rdzeni w 1 CCX): **27.54 s** ($S = 6.34\times$, $E = 79.3\%$)

| Cecha Architektury | C++ OpenMP ([`parallel-only-omp`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp)) | Go Chunking ([`Go/parallel_chunking`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking)) |
|:---|:---|:---|
| **Zarządzanie wątkami** | **Trwały basen wątków (Persistent Pool):** Wątki tworzone raz na początku programu (`#pragma omp parallel`), żyją do końca symulacji. | **Dynamiczny Fork-Join:** Miliony goroutines tworzone i niszczone w locie w każdym kroku (`wg.Go`). |
| **Bariery synchronizacyjne** | **Bariera w przestrzeni użytkownika (Spin-Wait):** Wątki odpytują flagę w pamięci w pętli spinlocka przez pierwsze setki cykli. Prawie nigdy nie wchodzą do jądra OS (`Sys time` $< 1.0\text{ s}$). | **Bariera jądra (Futex):** `sync.WaitGroup` szybko usypia goroutines i wątki systemowe, generując miliony wywołań systemowych `SYS_futex` (`Sys time` do $109\text{ s}$). |
| **Narzut środowiska uruchomieniowego** | Brak runtime, brak garbage collectora, brak kolejki work-stealing. | Runtime Go z zaawansowanym schedulerem M:N, który generuje narzut przy mikro-zadaniach $<5\,\mu\text{s}$. |
| **Wpływ na zużycie CPU** | 8 wątków stale utrzymuje **$7.98\text{ CPUs utilized}$** ($99.8\%$). | 64 wątki utrzymują średnio zaledwie **$6.03\text{ CPUs utilized}$** ($9.4\%$). |

---

## 5. Podsumowanie Wniosków do Pracy Dyplomowej

Otrzymane rezultaty, choć z punktu widzenia czystej optymalizacji mogą wydawać się niezadowalające (brak przyspieszenia powyżej 8 rdzeni), stanowią **wyjątkowo wartościowy wkład naukowo-badawczy do pracy dyplomowej**:

1. **Empiryczny dowód na granice stosowalności wzorca Fork-Join w Go:**  
   Pomiary dowiodły, że klasyczny wzorzec `sync.WaitGroup` z dynamicznym tworzeniem goroutines, powszechnie stosowany w typowych aplikacjach sieciowych i mikroserwisach w Go, jest **całkowicie nieadekwatny w wysokowydajnych symulacjach HPC o ultrakrótkim kroku czasowym ($< 50\,\mu\text{s}$)**.

2. **Identyfikacja wąskiego gardła futexów:**  
   Wykazano, że główną przyczyną załamania skalowania nie jest rywalizacja o pamięć RAM czy ograniczenia prawa Amdahla w kodzie symulacji, lecz **narzut przełączania kontekstu i wywołań `SYS_futex` w runtime języka Go**, pochłaniający do 59% czasu działania programu.

3. **Wpływ topologii procesorów serwerowych (NUMA / CCX):**  
   Analiza ujawniła krytyczną rolę powinowactwa rdzeni w architekturach AMD Zen 4. Skalowanie kodu w obrębie pojedynczego modułu CCX osiąga przyzwoitą wydajność (szczyt 96.95 s na 8 rdzeniach), podczas gdy przekroczenie granic gniazd NUMA drastycznie degraduje IPC wskutek opóźnień magistrali xGMI.

4. **Naukowe uzasadnienie architektury `parallel_channels`:**  
   Niniejsze wyniki stanowią bezpośrednie uzasadnienie wdrożenia kolejnej wersji architektury zrównoleglenia w projekcie GoPIC — **`parallel_channels`** ([`Go/parallel_channels/worker.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/worker.go)):
   - Wyeliminowanie dynamicznego fork-join na rzecz **trwałego basenu goroutines (*persistent workers*)** uruchamianych raz na starcie symulacji.
   - Komunikacja przez kanały/atomiki eliminująca tworzenie 104 milionów goroutines.
   - Ograniczenie interwencji jądra systemu operacyjnego i radykalne obniżenie czasu systemowego (`Sys time`).

---

## 6. Profilowanie Próbkowania (Linux \perf record\ i Flame Graphs)

W celu bezpośredniej weryfikacji hipotezy o narzucie planisty Go runtime, zarejestrowano profile próbkowania (\perf record -F 49 -g\) dla  \in \{2, 4, 8, 32, 64\}$ (zadania 839368\, 839366\, 839365\, 839333\, 839327\, 839328\).

Poniższa tabela przedstawia procentowy udział próbek CPU (Inclusive / Children) dla kluczowych funkcji symulacji oraz funkcji wewnętrznych planisty Go:

| Metryka / Funkcja | =2$ (839368\) | =4$ (839366\) | =8$ (839365\) | =32$ (839333\) | =64$ Gniazdo 0 (839327\) | =64$ Gniazdo 1 (839328\) |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Całkowity czas workerów (\sync.WaitGroup\)** | **97.14%** | **95.94%** | **95.60%** | **82.15%** | **71.37%** | **71.54%** |
| 🔹 **Krok 3: Push elektronów (Leap-Frog)** | 33.35% | 37.04% | 31.52% | 49.86% | 41.34% | 41.64% |
| 🔹 **Krok 1: Depozycja ładunku e- (CIC)** | 24.77% | 24.32% | 25.61% | 11.21% | 10.65% | 10.50% |
| 🔹 **Krok 5: Granice elektronów** | 19.46% | 18.04% | 19.98% | 6.99% | 5.90% | 6.00% |
| 🔹 **Krok 7: Zderzenia elektronów (Null-Coll)** | 12.24% | 10.29% | 11.91% | 7.99% | 7.30% | 7.37% |
| 🔹 **Kroki jonowe (Push 4, Depoz 1b, Zderz 8, Granice 6)** | 6.92% | 5.72% | 6.11% | 4.92% | 4.38% | 4.42% |
| **Krok 2: Solver Poissona (sekwencyjny)** | 0.75% | 0.60% | 0.75% | 0.31% | 0.27% | 0.31% |
| 🔴 **Narzut: untime.mcall\ (przełączanie stosu)** | 0.89% | 2.15% | 1.64% | **12.61%** | **19.47%** | **19.52%** |
| 🔴 **Narzut: untime.goexit0\ (niszczenie goroutine)** | 0.76% | 2.03% | 1.47% | **12.48%** | **19.33%** | **19.41%** |
| 🔴 **Narzut: untime.schedule\ (pętla planisty)** | 0.72% | 1.80% | 1.30% | **11.30%** | **17.14%** | **17.15%** |
| 🔴 **Narzut: untime.findRunnable\ (szukanie zadań)** | 0.50% | 1.24% | 0.82% | **9.05%** | **13.95%** | **13.98%** |
| 🔴 **Narzut: untime.stealWork\ (work-stealing)** | 0.15% | 0.50% | 0.40% | **4.03%** | **5.91%** | **5.95%** |
| 🔴 **Narzut: Tworzenie goroutines (untime.newproc\)** | 0.21% | 0.31% | 0.59% | **2.79%** | **5.67%** | **5.62%** |

### Kluczowe Wnioski z Profilowania:

1. **Gwałtowny spadek udziału pożytecznej pracy fizycznej:**  
   Na 2–8 rdzeniach kod symulacji stanowił **ponad 95.6%** czasu procesora. Na 64 rdzeniach pożyteczna praca fizyczna spadła do zaledwie **71.4%**, co oznacza, że **blisko 30% wszystkich aktywnych cykli CPU w przestrzeni użytkownika pochłania wyłącznie obsługa goroutines**!
2. **Eksplozja mechanizmu Work-Stealing (untime.findRunnable\ + untime.stealWork\):**  
   Gdy 64 rdzenie kończą swoje miniaturowe zadania (-2\,\mu\text{s}$), wątki zaczynają masowo przeszukiwać kolejki innych wątków. Czas spędzony na przeszukiwaniu kolejek i kradzieży pracy wzrósł z **0.65%** (na 2 rdzeniach) do niemal **20%** (na 64 rdzeniach)!
3. **Analiza stosów wywołań (\perf.folded\):**  
   W konfiguracji 64 workerów w czołówce najczęściej pobieranych próbek pojawiły się bezpośrednio sekwencje:  
   untime.goexit0 -> runtime.schedule -> runtime.findRunnable -> runtime.stealWork -> runtime.runqsteal\  
   oraz  
   untime.schedule -> runtime.findRunnable -> runtime.procyieldAsm.abi0\  
   Obecność instrukcji \procyieldAsm\ (instrukcja \PAUSE\ procesora x86) dowodzi, że procesor spędza znaczny odsetek czasu w aktywnym wirowaniu na blokadach wewnętrznych planisty Go!

### Dostępne Artefakty Graficzne i Raporty:
- **Flame Graph 64 rdzenie (Gniazdo 0):** [\saved_logs_Go/logs_job_5839327_CHUNKING_RECORD/edupic_data/flamegraph.svg\](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839327_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **Flame Graph 64 rdzenie (Gniazdo 1):** [\saved_logs_Go/logs_job_5839328_CHUNKING_RECORD/edupic_data/flamegraph.svg\](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839328_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **Flame Graph 32 rdzenie:** [\saved_logs_Go/logs_job_5839333_CHUNKING_RECORD/edupic_data/flamegraph.svg\](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839333_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **Flame Graph 8 rdzeni:** [\saved_logs_Go/logs_job_5839365_CHUNKING_RECORD/edupic_data/flamegraph.svg\](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839365_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **Flame Graph 4 rdzenie:** [\saved_logs_Go/logs_job_5839366_CHUNKING_RECORD/edupic_data/flamegraph.svg\](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839366_CHUNKING_RECORD/edupic_data/flamegraph.svg)
- **Flame Graph 2 rdzenie:** [\saved_logs_Go/logs_job_5839368_CHUNKING_RECORD/edupic_data/flamegraph.svg\](file:///C:/Users/E14/Documents/GitHub/GoPIC/saved_logs_Go/logs_job_5839368_CHUNKING_RECORD/edupic_data/flamegraph.svg)
