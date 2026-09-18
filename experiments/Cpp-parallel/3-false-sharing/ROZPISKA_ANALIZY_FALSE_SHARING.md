# Przewodnik i Rozpiska Podrozdziału: Eliminacja Zjawiska Fałszywego Współdzielenia Pamięci Podręcznej (False Sharing) i Izolacja Linii Cache (`alignas(64)`)

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.3: Ścieżka zrównoleglenia silnika C++ z użyciem OpenMP**  
>     └── **4.3.3. Eliminacja zjawiska fałszywego współdzielenia pamięci podręcznej (False Sharing) i wyrównanie struktur wątkowych do linii cache (`alignas(64)`)**

---

## 1. Kontekst Mikroarchitektoniczny i Problem Badawczy

### 1.1. Mechanizm Protokołów Spójności Pamięci Podręcznej (MESI / MOESI)
W nowoczesnych procesorach wielordzeniowych architektury x86-64 (w tym AMD Zen 4 oraz Intel Xeon), każdy rdzeń fizyczny posiada własne, prywatne pamięci podręczne pierwszego poziomu (L1 Instruction i L1 Data Cache po 32 KB) oraz drugiego poziomu (L2 Cache po 1 MB).  
W celu zapewnienia spójnego widoku pamięci RAM przez wszystkie rdzenie, kontrolery sprzętowe implementują protokół spójności linii pamięci podręcznej (np. **MOESI** w procesorach AMD lub **MESI/MESIF** w Intelu).

Podstawową jednostką transferu danych i zarządzania spójnością nie jest pojedyncze słowo czy liczba zmiennoprzecinkowa, lecz **pełna linia pamięci podręcznej o rozmiarze 64 bajtów** (*Cache Line*).

```
LINIA PAMIĘCI PODRĘCZNEJ (64 BAJTY = 8 × LICZBA DOUBLE / INT64):
┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
│ Bajte  │ Bajte  │ Bajte  │ Bajte  │ Bajte  │ Bajte  │ Bajte  │ Bajte  │
│  0..7  │  8..15 │ 16..23 │ 24..31 │ 32..39 │ 40..47 │ 48..55 │ 56..63 │
└────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘
```

---

### 1.2. Definicja Zjawiska False Sharing (Fałszywe Współdzielenie)
Zjawisko **False Sharing** zachodzi wtedy, gdy dwa lub więcej wątków wykonujących się na różnych rdzeniach fizycznych procesora modyfikuje **niezależne logicznie zmienne**, które jednak na skutek ułożenia w strukturze danych znalazły się **w tej samej 64-bajtowej linii pamięci podręcznej**.

```
ZJAWISKO CACHE LINE BOUNCING (PING-PONG) PRZY FALSE SHARINGU:
┌────────────────────────────────────────────────────────────────────────┐
│ WSPÓLNA 64-BAJTOWA LINIA PAMIĘCI PODRĘCZNEJ:                           │
│ [ Zmienne Wątku 0 (0..47 B) ]   [ Zmienne Wątku 1 (48..63 B) ]         │
└────────────────────────────────────────────────────────────────────────┘
                 ▲                                ▲
                 │                                │
        1. Rdzeń 0 zapisuje               2. Rdzeń 1 zapisuje
           swoje liczniki.                   swoje liczniki.
                 │                                │
                 ▼                                ▼
       Wysłanie sygnału RFO             Wysłanie sygnału RFO
    (Request For Ownership)          (Request For Ownership)
                 │                                │
                 ▼                                ▼
    Inwalidacja linii w L1d Rdzenia 1!  Inwalidacja linii w L1d Rdzenia 0!
                 │                                │
                 └───────────────┬────────────────┘
                                 │
                                 ▼
         NIEUSTANNE ODBIJANIE LINII CACHE MIĘDZY RDZENIAMI
       (Każdy zapis to Cache Miss, opóźnienie magistrali L3/RAM)
```

1. Rdzeń 0 chce zapisać do swojej zmiennej. Aby uzyskać wyłączność zapisu (stan *Modified* w MOESI), wysyła przez magistralę żądanie **RFO (Request For Ownership)**, co **unieważnia całą linię pamięci podręcznej w pamięci L1D Rdzenia 1**.
2. Ułamek nanosekundy później Rdzeń 1 chce zapisać do swojej zmiennej. Ponieważ jego kopia linii została unieważniona, zgłasza chybienie zapisu (**L1D Store Miss**), blokuje potok wykonawczy i żąda linii na wyłączność, unieważniając ją w Rdzeniu 0.
3. Linia pamięci podręcznej zaczyna nieustannie przeskakiwać tam i z powrotem między rdzeniami (*Cache Line Bouncing / Ping-Pong effect*), degradując wydajność o 1–2 rzędy wielkości.

---

## 2. Anatomia Struktur Danych w GoPIC

W silniku OpenMP symulacji PIC/MCC każdy wątek zlicza lokalne statystyki diagnostyczne (próbki energii elektronów w centrum szczeliny, liczniki absorpcji cząstek na elektrodach, liczniki zderzeń Monte Carlo).

### 2.1. Przypadek Bez Wyrównania (Unaligned / False Sharing)
W pliku [`C/parallel-only-omp/state.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L133) struktura liczników składa się z 6 pól:
```cpp
struct UnalignedThreadCounters {
    double accu_center = 0.0;          // 8 bajtów (offset 0..7)
    Ullong counter_center = 0;         // 8 bajtów (offset 8..15)
    Ullong local_abs_pow = 0;          // 8 bajtów (offset 16..23)
    Ullong local_abs_gnd = 0;          // 8 bajtów (offset 24..31)
    Ullong local_coll_e = 0;           // 8 bajtów (offset 32..39)
    Ullong local_coll_i = 0;           // 8 bajtów (offset 40..47)
};
```
* **Rozmiar struktury:** $6 \times 8\text{ bajtów} = \mathbf{48\text{ bajtów}}$.
* W strukturze `WorkerBuffers` liczniki te są przechowywane w wektorze:  
  `std::vector<UnalignedThreadCounters> thread_counters;`
* Elementy wektora leżą w pamięci ściśle obok siebie:
  * Wątek 0 zajmuje bajty $0 \dots 47$,
  * Wątek 1 zajmuje bajty $48 \dots 95$,
  * Wątek 2 zajmuje bajty $96 \dots 143$,
  * Wątek 3 zajmuje bajty $144 \dots 191$.

#### Rozmieszczenie w 64-bajtowych liniach cache:
* **Linia Cache 0 (bajty 0–63):** Mieści cały Wątek 0 (0–47 B) oraz pierwsze 16 bajtów Wątku 1 (`accu_center`, `counter_center`)!
* **Linia Cache 1 (bajty 64–127):** Mieści pozostałe 32 bajty Wątku 1 (64–95 B) oraz pierwsze 32 bajty Wątku 2 (96–127 B)!
* **Linia Cache 2 (bajty 128–191):** Mieści pozostałe 16 bajtów Wątku 2 (128–143 B) oraz cały Wątek 3 (144–191 B)!

**Wniosek mikroarchitektoniczny:**  
Nawet na 4 rdzeniach **każdy wątek dzieli linię pamięci podręcznej ze swoim sąsiadem**! Wszelkie aktualizacje liczników przez Wątek 0 bezpośrednio unieważniają pamięć podręczną Wątku 1, a zapisy Wątku 1 unieważniają pamięć Wątku 2.

---

### 2.2. Rozwiązanie: Wymuszenie Wyrównania `alignas(64)`

Zastosowanie specyfikatora standardu C++17 `alignas(64)`:
```cpp
// state.h (linie 133-140)
struct alignas(64) AlignedThreadCounters {
    double accu_center = 0.0;
    Ullong counter_center = 0;
    Ullong local_abs_pow = 0;
    Ullong local_abs_gnd = 0;
    Ullong local_coll_e = 0;
    Ullong local_coll_i = 0;
};
```
* Kompilator wymusza adres początkowy podzielny przez 64 oraz dopełnia strukturę 16 bajtami pustymi (*padding*), zwiększając jej rozmiar z 48 do **dokładnie 64 bajtów**:
  $$\text{sizeof(AlignedThreadCounters)} = \mathbf{64\text{ bajty}}$$
* W wektorze `thread_counters`:
  * Wątek 0 zajmuje bajty $0 \dots 63$ (dokładnie Linia Cache 0),
  * Wątek 1 zajmuje bajty $64 \dots 127$ (dokładnie Linia Cache 1),
  * Wątek 2 zajmuje bajty $128 \dots 191$ (dokładnie Linia Cache 2),
  * Wątek 3 zajmuje bajty $192 \dots 255$ (dokładnie Linia Cache 3).
* **Pełna izolacja cache:** Żadne dwa rdzenie nie dzielą tej samej linii pamięci podręcznej. Zero sygnałów RFO, zero unieważnień linii L1D, 100% lokalności zapisu.

---

## 3. Dedykowany Mikrobenchmark: `bench_false_sharing.cc`

W celu laboratoryjnego wyizolowania zjawiska False Sharing i udowodnienia skuteczności `alignas(64)`, zaimplementowano dedykowany mikrobenchmark w pliku [`bench/bench_false_sharing.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Cpp-parallel/3-false-sharing/bench/bench_false_sharing.cc).

### 3.1. Na Czym Dokładnie Polega Ten Benchmark?

Mikrobenchmark został zaprojektowany, aby w 100% laboratoryjnie i w izolacji od reszty fizyki plazmy odtworzyć zachowanie pamięci podręcznej L1/L2 przy operacjach na strukturach liczników wątków:

#### A. Co jest testowane (Dwa warianty w pamięci):
Program porównuje dwie struktury danych odpowiadające dokładnie licznikom używanym w symulacji GoPIC ([`state.h`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp/state.h#L133-L140)):
1. **Wariant A (`UnalignedCounters` — 48 bajtów):**  
   Struktura zawiera 1 pole `double` i 5 pól `unsigned long long` ($1 \times 8 + 5 \times 8 = 48\text{ bajtów}$). Gdy tablica `std::vector<UnalignedCounters> counters(p)` leży w pamięci RAM, kolejne wątki są upakowane co 48 bajtów, co sprawia, że **wątek $i$ oraz wątek $i+1$ dzielą tę samą 64-bajtową linię pamięci podręcznej**.
2. **Wariant B (`AlignedCounters` — 64 bajty z `alignas(64)`):**  
   Ta sama struktura, lecz opatrzona atrybutem `alignas(64)`. Kompilator wyrównuje początek do 64 bajtów i dodaje 16 bajtów dopełnienia (*padding*), zwiększając rozmiar do $64\text{ bajtów}$. Każdy wątek otrzymuje **własną, w pełni izolowaną linię pamięci L1D**.

#### B. Przebieg eksperymentu krok po kroku:
1. **Alokacja wektora w pamięci:** Dla danej liczby wątków $p$ alokowany jest wektor struktur:
   `std::vector<UnalignedCounters> counters(num_threads);` (dla wariantu A) lub `std::vector<AlignedCounters> counters(num_threads);` (dla wariantu B).
2. **Start precyzyjnego zegara:** Wywoływany jest pomiar czasu `std::chrono::high_resolution_clock::now()`.
3. **Równoległa pętla $10^8$ iteracji:** Wewnątrz dyrektywy `#pragma omp parallel num_threads(num_threads)` każdy wątek pobiera swój identyfikator `tid` i wykonuje ciasną pętlę $100\ 000\ 000$ iteracji:
   ```cpp
   int tid = omp_get_thread_num();
   for (long long i = 0; i < iterations; ++i) {
       counters[tid].local_coll_e++;
       counters[tid].local_abs_pow += (i & 1);
   }
   ```
4. **Dlaczego pola mają kwalifikator `volatile`? (Kluczowy detal inżynierski):**  
   Nowoczesne kompilatory (GCC `-O3`) posiadają optymalizację *Scalar Replacement of Aggregates (SRA)*. Bez słowa kluczowego `volatile`, kompilator zauważyłby, że `counters[tid]` jest modyfikowane w pętli przez ten sam wątek, i trzymałby licznik wyłącznie w rejestrze procesora (`%rax`), wykonując tylko jeden zapis na koniec! Spowodowałoby to fałszywy brak False Sharing. Kwalifikator `volatile` zmusza procesor do wyemitowania fizycznej instrukcji zapisu `movq` do pamięci podręcznej L1D przy **każdej pojedynczej iteracji**.
5. **Ochrona przed usunięciem martwego kodu (*Dead Code Elimination*):**  
   Po wyjściu z pętli równoległej program sumuje wartości wszystkich liczników do zmiennej `dummy`. Gwarantuje to, że kompilator nie usunie pętli jako bezużytecznej.
6. **Zatrzymanie zegara:** Obliczana jest różnica czasu wykonania $\Delta t$ w sekundach.

#### C. Jak interpretować wyniki w tabeli:
* **Kolumna `Unaligned [s]`:** Czas wykonania przy ciasnym upakowaniu struktur (48 B). Gdy wiele rdzeni próbuje jednocześnie pisać do tej samej 64-bajtowej linii cache, sprzętowy protokół MOESI nieustannie unieważnia linie w sąsiednich rdzeniach i wymusza żądania RFO (*Request For Ownership*), drastycznie spowalniając wykonanie.
* **Kolumna `Aligned [s]`:** Czas wykonania z `alignas(64)`. Każdy rdzeń pisze do własnej linii L1D, linie nigdy nie są unieważniane, brak jakiejkolwiek komunikacji na magistrali międzyrdzeniowej.
* **Kolumna `Przyspieszenie`:** $\frac{T_{\text{Unaligned}}}{T_{\text{Aligned}}}$. Wartość $10\times - 14\times$ oznacza, że False Sharing spowalniał program ponad dziesięciokrotnie!

---

### 3.2. Instrukcja Kompilacji i Uruchomienia

Kompilacja i uruchomienie za pomocą dołączonego pliku [`bench/Makefile`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Cpp-parallel/3-false-sharing/bench/Makefile):
```bash
# Wejście do katalogu benchmarku
cd experiments/Cpp-parallel/3-false-sharing/bench

# 1. Kompilacja i automatyczny bieg (wyniki na ekranie + zapis do raw_results_false_sharing.txt):
make run

# 2. Pomiar sprzętowych liczników pamięci podręcznej przez Linux perf (zapis do perf_stat_false_sharing.txt):
make perf
```

---

## 4. Wyniki Eksperymentu i Wpływ na Pełną Symulację

### 4.1. Rzeczywiste Wyniki Pomiarowe (Procesor AMD Ryzen 5 7535U, Architektura Zen 3+)

Poniższa tabela przedstawia rzeczywiste wyniki pomiarów laboratoryjnych wykonanych na stacji roboczej wyposażonej w 6-rdzeniowy procesor AMD Ryzen 5 7535U (6C/12T, linie cache 64 B) dla $10^8$ iteracji na wątek:

| Liczba Wątków ($p$) | Wariant Unaligned (False Sharing) [s] | Wariant Aligned (`alignas(64)`) [s] | Przyspieszenie ($S$) | Obserwowany Efekt Sprzętowy |
| :---: | :---: | :---: | :---: | :--- |
| **1 wątek** | 0.0501 s | 0.0478 s | **1.05x** | Brak współdzielenia (baza odniesienia) |
| **2 wątki** | 0.0490 s | 0.0509 s | **0.96x** | Brak kolizji (specyfika offsetów: W0 bajty 16/32, W1 bajty 64/80) |
| **4 wątki** | **1.0456 s** | **0.0993 s** | **10.53x!** | **Masywne False Sharing na liniach cache 1 i 2** |
| **6 wątków** | **1.1068 s** | **0.0776 s** | **14.27x!** | **Nasycenie protokołu MOESI na wszystkich rdzeniach fizycznych** |

#### Matematyczne wyjaśnienie anomalii dla 2 wątków:
Dlaczego dla 2 wątków nie odnotowano spowolnienia, a dla 4 i 6 wątków pojawił się gwałtowny 10–14-krotny spadek wydajności?
Wynika to bezpośrednio z przesunięć pól w strukturze 48-bajtowej:
* W pętli testowej modyfikowane są pola `local_abs_pow` (offset +16 B) i `local_coll_e` (offset +32 B).
* Dla **Wątku 0**: adresy pól to bajty **16** i **32** $\longrightarrow$ leżą w całości w **Linii Cache 0** ($0 \dots 63$ B).
* Dla **Wątku 1**: struktura zaczyna się w bajcie 48, więc pola te wypadają w bajtach $48 + 16 = \mathbf{64}$ oraz $48 + 32 = \mathbf{80}$ $\longrightarrow$ leżą w całości w **Linii Cache 1** ($64 \dots 127$ B).
* Czysty przypadek geometrii sprawił, że Wątek 0 i Wątek 1 nie kolidowały na tych konkretnych polach.
* Jednak dla **Wątku 2**: struktura zaczyna się w bajcie 96. Pole `local_abs_pow` leży w bajcie $96 + 16 = \mathbf{112}$ ($\in$ **Linia Cache 1**). Wątek 2 i Wątek 1 **uderzają w tę samą Linię Cache 1**, wywołując nieustanny ping-pong RFO. Z kolei pole `local_coll_e` leży w bajcie $96 + 32 = \mathbf{128}$ ($\in$ **Linia Cache 2**), kolidując z polami **Wątku 3**!
* W rezultacie przy 4 i 6 wątkach powstaje kaskada unieważnień cache obejmująca wszystkie rdzenie.

*Wykres przyspieszenia z alignas(64) na procesorze AMD Ryzen (6 rdzeni fizycznych):*
```
CZAS WYKONANIA MIKROBENCHMARKU DLA 6 WĄTKÓW [s] (mniej = lepiej)
Unaligned (False Sharing): [████████████████████████████████████████] 1.107 s
Aligned (alignas(64)):     [██] 0.078 s  (PRZYSPIESZENIE 14.27x!)
                           0.0        0.3        0.6        0.9        1.2
```

---

### 4.2. Dlaczego w Pełnej Symulacji Wymagany Był Mikrobenchmark?

W pełnym silniku PIC/MCC ([`C/parallel-only-omp/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/parallel-only-omp)):
* Ponad **80–90% czasu procesora** przypada na pętlę Leap-Frog (ruch cząstek) i interpolację CIC, które operują na odrębnych, dużych wycinkach tablic cząstek `[k_start, k_end)`.
* Liczniki zderzeń `local_coll_e` i absorpcji `local_abs_pow` są aktualizowane rzadziej (tylko w momencie zajścia zderzenia lub uderzenia w ściankę).
* W pełnej symulacji False Sharing nie powoduje 15-krotnego zwolnienia całego programu, lecz objawia się jako **ukryty narzut kilku procent czasu** oraz gwałtowny wzrost wskaźnika **`L1-dcache-store-misses`** w raportach `perf stat`.

Dedykowany mikrobenchmark stanowi podręcznikowe narzędzie inżynierskie: **izoluje zjawisko w 100% czystej postaci**, uniemożliwiając zamaskowanie problemu przez pozostałe moduły obliczeniowe symulacji.

---

## 5. Gotowe Fragmenty Tekstu do Pracy Magisterskiej (Podrozdział 4.3.3)

Poniższe akapity stanowią gotowy tekst naukowy do bezpośredniego włączenia do pracy magisterskiej:

### Wprowadzenie do problemu spójności linii pamięci podręcznej:
> *„W architekturach wielordzeniowych ze współdzieloną pamięcią fizyczną transfer danych pomiędzy pamięcią podręczną a rdzeniami procesora odbywa się w porcjach o stałej wielkości 64 bajtów (Cache Line). Gdy dwa lub więcej wątków wykonujących się na różnych rdzeniach procesora modyfikuje niezależne zmienne zlokalizowane w obrębie tej samej linii pamięci podręcznej, dochodzi do zjawiska fałszywego współdzielenia pamięci (False Sharing). Sprzętowy protokół spójności pamięci (MOESI na procesorach AMD Zen 4) zmuszony jest nieustannie unieważniać linię pamięci podręcznej w prywatnych pamięciach L1D pozostałych rdzeni, wywołując lawinowy wzrost żądań własności linii (Request For Ownership) oraz degradację przepustowości magistrali.”*

### Diagnoza w strukturach silnika symulacji:
> *„W pierwotnej implementacji wielowątkowej liczniki diagnostyczne wątków (obejmujące liczniki cząstek pochłoniętych na elektrodach, liczniki zderzeń Monte Carlo oraz akumulatory energii w centrum szczeliny) zorganizowano w strukturę `UnalignedThreadCounters` o rozmiarze 48 bajtów, przechowywaną w wektorze `std::vector`. Ponieważ 48 bajtów jest wartością mniejszą od 64 bajtów, sąsiadujące w tablicy elementy wątków dzieliły te same linie pamięci podręcznej: pierwszy wątek współdzielił linię z drugim, a drugi z trzecim. W efekcie każda aktualizacja statystyk przez jeden rdzeń unieważniała kopię linii cache w sąsiednich rdzeniach roboczych.”*

### Rozwiązanie i wyniki mikrobenchmarku:
> *„Problem wyeliminowano poprzez zastosowanie specyfikatora standardu C++17 `alignas(64)`, który wymusza wyrównanie adresu bazowego struktury do wielokrotności 64 bajtów oraz dopełnia jej rozmiar 16-bajtowym paddingiem (`sizeof(AlignedThreadCounters) == 64`). Aby precyzyjnie zmierzyć zysk z eliminacji tego zjawiska bez zakłóceń ze strony pętli ruchu cząstek, zaimplementowano dedykowany mikrobenchmark (`bench_false_sharing.cc`). Pomiar dla $10^8$ operacji wykazał spadek czasu wykonania na 4 rdzeniach z 1.05 s do 0.099 s (przyspieszenie **10.5x**), a na pełnym zespole 6 rdzeni fizycznych z 1.11 s do 0.078 s, co stanowi **ponad 14-krotne przyspieszenie (speedup 14.27x)**. Wynik ten bezsprzecznie dowodzi, że właściwe dopasowanie struktur danych do geometrii linii pamięci podręcznej jest kluczowym warunkiem skalowalności wielowątkowej na nowoczesnych procesorach wielordzeniowych.”*
