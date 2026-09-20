# Ścieżka Optymalizacji Sekwencyjnej w Języku Go (Kroki 1–4)

Niniejszy dokument szczegółowo opisuje sekwencyjną ewolucję silnika w języku Go, od czystego portu referencyjnego po optymalizacje mikroarchitektoniczne, stanowiąc podstawę teoretyczną i empiryczną dla Podrozdziału 4.5 pracy magisterskiej.

---

## 1. Zestawienie Etapów Optymalizacji Sekwencyjnej

```
  ┌────────────────────────────────────────────────────────┐
  │ 1. Baseline (Go/1.experiment-baseline)                 │
  │    - Czysty port 1:1 z C++ (Direct MCC)                │
  │    - Czas wykonania: T0_Go (Punkt odniesienia)         │
  └──────────────────────────┬─────────────────────────────┘
                             ▼
  ┌────────────────────────────────────────────────────────┐
  │ 2. Algorithmic Port (Go/2.algorithmic-port)            │
  │    - Wdrożenie metody Zderzeń Zerowych (Null-Collision) │
  │    - Aproksymacja de Moivre'a-Laplace'a                │
  │    - Prekomputacja współczynników Thomasa              │
  │    - Celowa alokacja sterty: make([]int, n)            │
  └──────────────────────────┬─────────────────────────────┘
                             ▼
  ┌────────────────────────────────────────────────────────┐
  │ 3. Zero-Allocation (Go/3.zero-allocation)              │
  │    - Eliminacja 4.8 GB alokacji sterty na cykel RF!    │
  │    - Ponowne użycie bufora sim.SamplePool[:n] (0 B/op) │
  │    - Wyciszenie GC (debug.SetGCPercent(-1))            │
  │    - Przyspieszenie procedury losowania: 4.66x         │
  └──────────────────────────┬─────────────────────────────┘
                             ▼
  ┌────────────────────────────────────────────────────────┐
  │ 4. BCE & Loop Unrolling (Go/4.bce-loop-unrolling)      │
  │    - Bounds Check Elimination (_ = xe[end-1])          │
  │    - 4-krotne rozwinięcie pętli (4-way unrolling, ILP) │
  │    - Strojenie flag architektury Zen 4: GOAMD64=v4     │
  └────────────────────────────────────────────────────────┘
```

---

## 2. Krok 2 vs Krok 3: Problem Presji Alokacyjnej Sterty i Odśmiecacza Pamięci

### 2.1. Diagnoza Wąskiego Gardła w `randomSample`
W Kroku 2 losowanie $N_{\text{coll}}$ cząstek kandydatów do zderzenia z puli $N \approx 150\,000$ cząstek zaimplementowano naiwnie:
```go
// KROK 2 (Naiwny port): Alokacja sterty w każdym kroku czasowym!
func randomSample(n, k int) []int {
    pool := make([]int, n) // 150 000 * 8 B = 1.2 MB na stercie!
    for i := range pool { pool[i] = i }
    // algorytm częściowego tasowania Fishera-Yatesa...
    return pool[:k]
}
```

### 2.2. Skala Zjawiska w Skali Symulacji (Empiryczne Wyniki Mikrobenchmarku)
Dedykowany mikrobenchmark w [`experiments/Go-sequential/3-zero-allocation/bench/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/Go-sequential/3-zero-allocation/bench):

| Wariant Implementacji | Czas 1 Cyklu (4000 kroków) | Alokacja Całkowita | Alokacja / Krok | Cykle GC (`NumGC`) | Łączny Czas Pauz STW | Przyspieszenie |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Naiwny port (Krok 2: `make`)** | `883 ms` | **4.49 GB** | `1176.0 KB` | **1317** | **131.1 ms** | **1.00x** |
| **Zero-Allocation (Krok 3: bufor)** | **`189 ms`** | **0 B** | **0.0 KB** | **0** | **0.0 ms** | **4.66x** |

**Wnioski:**
- Z pozoru niewinna alokacja `make([]int, n)` generowała w jednym cyklu RF aż **$4.5 - 4.8\text{ GB}$ śmieci na stercie**.
- W teście 100 cykli RF oznacza to konieczność przydzielenia i zwolnienia blisko **pół terabajta pamięci RAM ($480\text{ GB}$)**.
- Zastosowanie prealokowanego bufora w strukturze symulacji (`sim.SamplePool[:n]`) sprowadziło narzut do **0 B/op**, całkowicie eliminując cykle GC i dając **4.66x przyspieszenie**.

---

## 3. Krok 4: Eliminacja Sprawdzania Granic Tablic (BCE) i Rozwinięcie Pętli

### 3.1. Mechanizm Bounds Check Elimination w Kompilatorze Go `gc`
Kompilator Go domyślnie wstawia w kodzie maszynowym instrukcje asekuracyjne sprawdzające indeks tablicy przed każdym odczytem lub zapisem:
```asm
CMPQ AX, CX          ; Porównaj indeks AX z rozmiarem wycinka CX
JAE  runtime.panicIndex ; Skok do paniki, jeśli indeks poza zakresem
```
W pętli Leap-Frog dla $150\,000$ cząstek generowało to setki tysięcy zbędnych instrukcji skoków warunkowych.

### 3.2. Wdrożenie Strażnika BCE i Rozwinięcie x4
Umieszczenie na początku funkcji pojedynczego odczytu elementu krańcowego:
```go
if end > start {
    _ = sim.X_e[end-1]
    _ = sim.Vx_e[end-1]
}
```
udowadnia kompilatorowi Go (w fazie SSA — Static Single Assignment), że żaden indeks $k \in [\text{start}, \text{end})$ nie wykracza poza rozmiar wycinka. Weryfikacja flagą `-gcflags="-d=ssa/check_bce/debug=1"` potwierdza całkowite usunięcie instrukcji `runtime.panicIndex` z ciała pętli.

4-krotne rozwinięcie pętli (4-way loop unrolling) pozwala jednostce wykonawczej procesora AMD Zen 4 na równoległe potokowanie instrukcji arytmetycznych (ILP — Instruction-Level Parallelism) i ukrycie opóźnień operacji mnożenia `FMUL`.

---

## 4. Analiza Porównawcza Assemblera: Go `gc` vs GCC/Clang C++

W Podrozdziale 4.5 pracy magisterskiej kluczowym elementem jest porównanie kodu maszynowego:

1. **Brak autowektoryzacji w Go `gc` (Luka SIMD):**  
   Kompilator Go `gc` nie posiada mechanizmu autowektoryzacji pętli. Generuje instrukcje skalarne SSE2/AVX (`MOVSD`, `MULSD`, `SUBSD`, `ADDSD`), operujące na pojedynczych 64-bitowych liczbach zmiennoprzecinkowych w rejestrach `XMM0-XMM15`.
2. **Wektoryzacja w C++:**  
   Kompilatory GCC i Clang kompilują tę samą pętlę do 256-bitowych instrukcji AVX2 (`VMULPD`, `VSUBPD`, `VFMADD213PD`) operujących na 4 liczbach `double` jednocześnie w rejestrach `YMM`, lub do 512-bitowych instrukcji AVX-512 (`ZMM`).
3. **Problem instrukcji Gather:**  
   W C++ odczyt pola $E[p]$ jest wektoryzowany za pomocą instrukcji `VGATHERDPD`. W Go odczyt $E[p]$ musi pozostać skalarny, ponieważ język Go nie udostępnia intrinsics SIMD w składni języka bez pisania ręcznego assemblera Plan 9.
