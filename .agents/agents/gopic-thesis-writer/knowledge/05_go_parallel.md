# Ścieżka Optymalizacji Wielowątkowej w Języku Go (Kroki 1–5)

Niniejszy dokument opisuje architekturę wielowątkowej ewolucji silnika Go, stanowiąc kluczową podstawę merytoryczną dla Podrozdziału 4.6 pracy magisterskiej.

---

## 1. Filozofia Eksperymentalna: Izolacja Zmiennych Badawczych

Każdy z pięciu kroków wielowątkowych w Go izoluje dokładnie **jeden kluczowy aspekt inżynierii wydajnościowej**:

| Przejście | Zmienna Badawcza | Weryfikowana Hipoteza |
| :--- | :--- | :--- |
| **Krok 1 $\to$ 2** | Model CSP (kanały) vs Pamięć Współdzielona + L1d | Paradygmat kanałów w Go załamuje się w obliczeniach o wysokiej częstotliwości synchronizacji przez blokadę `hchan.lock`. |
| **Krok 2 $\to$ 3** | `sync.WaitGroup` (Futex) vs `StarBarrier` (PAUSE) | Wywołania jądra `SYS_futex` niszczą skalowalność barier; wirowanie w przestrzeni użytkownika eliminuje narzut jądra. |
| **Krok 3 $\to$ 4** | Osobne pętle vs Fuzja Integratora i Granic | Sprawdzanie granic w rejestrach CPU i kompaktacja $O(\text{dead})$ oszczędzają pasmo pamięci i usuwają 8000 barier na cykl. |
| **Krok 4 $\to$ 5** | Pętle skalarne vs BCE + Rozwinięcie x4 + AVX-512 | Usunięcie narzutu sprawdzania granic w Go i rozwinięcie pętli pozwala zniwelować lukę do wektoryzacji C++. |

---

## 2. Szczegółowy Opis Poszczególnych Etapów

### 2.1. Krok 1: Model CSP i Komunikacja Kanałowa (`Go/parallel-1-channels`)
- **Architektura:** Wzorzec puli wątków (Worker Pool). Koordynator zleca zadania przez tablicę kanałów `reqCh[w]`, a workerzy odsyłają potwierdzenia przez `respCh[w]`.
- **Diagnoza Wąskiego Gardła:**  
  W symulacji PIC występuje ponad **$20\,000$ barier synchronizacyjnych na cykl RF**. Każde wysłanie i odebranie wiadomości z kanału wymusza zajęcie wewnętrznego muteksu `runtime.lock2(&c.lock)`. Przy wielu rdzeniach dochodzi do drastycznej rywalizacji o blokady, wybudzeń wątków systemowych (OS threads) i załamania skalowalności.

### 2.2. Krok 2: Pamięć Współdzielona, Prywatne Bufory L1d i sync.WaitGroup (`Go/parallel-2-buffers-chunking`)
- **Architektura:** Eliminacja kanałów na rzecz dekompozycji cząstek na ciągłe chunki w pamięci współdzielonej.
- **Prywatne Bufory Gęstości w L1d:** Zamiast operacji atomowych na globalnej siatce $\rho$, każdy worker posiada prywatną tablicę `WorkerEDensity[w][400]`. Mieści się ona w całości w pamięci podręcznej L1d rdzenia ($3.2\text{ KB} < 32\text{ KB}$). Po zakończeniu fazy koordynator wykonuje sekwencyjną redukcję strumieniową.
- **Eliminacja False Sharing:** Wszystkie struktury diagnostyczne i liczniki workerów są wyrównywane do 64-bajtowej linii pamięci podręcznej (`paddedInt64`), co zapobiega zjawisku Cache Line Bouncing w protokole MESI.
- **Prymityw bariery:** `sync.WaitGroup` (oparty na semaforach runtime i wywołaniach systemowych `SYS_futex`).

### 2.3. Krok 3: Bezblokadowa Bariera Gwiazdy (StarBarrier) i Aktywne Wirowanie (`Go/parallel-3-star-barrier`)
- **Architektura:** Własna, bezblokadowa bariera w topologii gwiazdy (`StarBarrier`), zaimplementowana na atomikach:
  - Koordynator inkrementuje globalny krok `step.Add(1)`.
  - Workerzy wirują w przestrzeni użytkownika za pomocą niskolatencyjnej instrukcji procesora `PAUSE` (`procyield(30)` w asemblerze Plan 9 [`procyield_amd64.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel-3-star-barrier/procyield_amd64.s)).
  - **Koordynator samodzielnie wykonuje chunk 0:** Eliminuje to marnowanie rdzenia koordynatora na bezczynne wirowanie oraz zapobiega zjawisku *goroutine oversubscription*.
- **Izolacja badawcza:** W tym kroku Leap-Frog (Krok 3) i detekcja granic (Krok 5) pozostają osobnymi fazami barierowymi, co pozwala precyzyjnie zmierzyć czysty zysk barierowy `StarBarrier` vs `sync.WaitGroup`.

### 2.4. Krok 4: Fuzja Pętli Integratora z Detekcją Granic i Kompaktacja $O(\text{dead})$ (`Go/parallel-4-boundary-compaction`)
- **Architektura:** Zespolenie integratora Leap-Frog z natychmiastowym sprawdzeniem warunków brzegowych (**Fused Move & Detect**):
  - Nowa pozycja $x_k$ jest obliczana w rejestrze procesora.
  - Warunek $x_k < 0 \lor x_k > L$ jest testowany natychmiast, bez zapisywania i ponownego odczytywania pozycji z pamięci RAM.
  - Indeksy cząstek martwych trafiają do prywatnego bufora workera `WorkerDeadElectrons[w]`.
- **Zero-Barierowa Kompaktacja In-Place $O(\text{dead})$:**  
  Koordynator bezpośrednio po wyjściu z pchnięcia wykonuje sekwencyjną kompaktację metodą `swap-with-last` tylko dla cząstek martwych. Ponieważ w jednym kroku ginie zazwyczaj kilkadziesiąt cząstek na $150\,000$, czas kompaktacji wynosi ułamek mikrosekundy.
- **Zysk:** Całkowite wyeliminowanie 2 barier na krok czasowy ($8000$ barier na cykl RF) oraz zaoszczędzenie $4.8\text{ GB}$ transferu pamięci RAM na cykl.

### 2.5. Krok 5: Pełna Optymalizacja Mikroarchitektoniczna (`Go/parallel-5-optimized-final`)
- **Architektura:** Wdrożenie optymalizacji na poziomie kompilatora i kodu maszynowego:
  - Eliminacja sprawdzania granic tablic (BCE — Bounds Check Elimination) we wszystkich pętlach workerów.
  - 4-krotne rozwinięcie pętli (4-way loop unrolling) w celu maksymalizacji Instruction-Level Parallelism (ILP).
  - Wymuszenie flag kompilatora dla mikroarchitektury AMD Zen 4: `GOAMD64=v4` oraz `-ldflags="-s -w"`.
- Stanowi ostateczną, najwydajniejszą implementację wielowątkową w języku Go, poddawaną bezpośredniemu porównaniu z C++ OpenMP.
