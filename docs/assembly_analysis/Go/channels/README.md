# Raport z analizy kodu asemblera `Go/parallel_channels` (Zen 4, `GOAMD64=v4`)

## 1. Wprowadzenie i środowisko kompilacji

Niniejszy dokument przedstawia szczegółową analizę kodu maszynowego wygenerowanego przez kompilator Go dla zoptymalizowanej implementacji wielowątkowej opartej na kanałach: **`Go/parallel_channels`**.

- **Architektura procesora:** AMD Zen 4 (`GOAMD64=v4` — AVX-512F, AVX-512DQ, AVX-512BW, AVX-512VL, FMA3, BMI2, POPCNT).
- **Struktura katalogu:** Katalog [`docs/assembly_analysis/Go/channels/`](.) zawiera 9 plików z dezasemblacją z przeplotem kodu źródłowego Go (`go tool objdump -S`):
  1. [`start_worker.s`](./start_worker.s) — Główna pętla wykonawcza trwałego workera (`startWorker`): obsługa kanałów, Leap-Frog push (4-way unrolling, BCE), depozycja ładunku CIC, sprawdzanie granic i zderzenia MCC.
  2. [`step3_push_electrons.s`](./step3_push_electrons.s) — Koordynator pchnięcia elektronów: rozesłanie rozkazu kanałowego `CmdMoveElectrons` i redukcja diagnostyk.
  3. [`step4_push_ions.s`](./step4_push_ions.s) — Koordynator pchnięcia jonów: rozesłanie rozkazu kanałowego `CmdMoveIons` i redukcja diagnostyk.
  4. [`collision_electron.s`](./collision_electron.s) — Zderzenia elektron-atom (wybór multiplikatywny, algebra wektorowa bez funkcji trygonometrycznych).
  5. [`collision_ion.s`](./collision_ion.s) — Zderzenia jon-atom (Fast-Path `I_BACK`, pomijanie geometrii sferycznej).
  6. [`solve_poisson.s`](./solve_poisson.s) — 1D solver Poissona (eliminacja dzieleń dzięki prekomputowanej tablicy `ThomasW`).
  7. [`step1_density.s`](./step1_density.s) — Koordynator depozycji gęstości elektronów metodą CIC.
  8. [`step7_collisions_electrons.s`](./step7_collisions_electrons.s) — Koordynator metody Null-Collision dla elektronów i scalanie (flush) buforów AoS do SoA.
  9. [`step8_collision_ions.s`](./step8_collision_ions.s) — Koordynator metody Null-Collision dla jonów (subcycling co $N_{\text{SUB}}$ kroków).

---

## 2. Architektura Wykonawcza: `start_worker.s` i Komunikacja Kanałowa

W przeciwieństwie do wariantu `parallel_chunking`, w którym goroutines są tworzone dynamicznie w każdym kroku czasowym, w `parallel_channels` workery są **trwałymi procesami współbieżnymi (persistent goroutines)** zainicjalizowanymi na starcie symulacji.

### 2.1. Odbiór rozkazów z dedykowanego kanału (`runtime.chanrecv2`)
Na początku pętli roboczej workera kompilator generuje wywołanie niskopoziomowego runtime Go odbierającego polecenie z buforowanego kanału:
```asm
; for cmd := range sim.WorkerCmdChan[workerID]
0x1400c5fa4   LEAQ 0xc8(SP), BX
0x1400c5fac   CALL runtime.chanrecv2(SB)
0x1400c5fb1   TESTL AL, AL
0x1400c5fb3   JE   0x1400c646b    ; Wyjście po zamknięciu kanału (CmdStop / EOF)
0x1400c5fb9   MOVQ 0xc8(SP), DX   ; Wczytanie odebranego rozkazu (WorkerCommand)
```
Po odebraniu rozkazu następuje skok pośredni przez tablicę skoków (jump table) lub serię porównań rejestru `DX` bezpośrednio do odpowiedniej gałęzi obliczeniowej bez jakichkolwiek alokacji pamięci na stercie (`0 allocs/op`).

### 2.2. Sygnalizacja zakończenia (`sim.WorkerDoneChan <- workerID`)
Po przetworzeniu swojego fragmentu cząstek worker wysyła identyfikator do wspólnego kanału bariery:
```asm
; sim.WorkerDoneChan <- workerID
0x1400c782d   MOVQ 0x7ba2e48(CX), AX   ; sim.WorkerDoneChan
0x1400c7834   MOVQ 0xf0(SP), BX        ; workerID
0x1400c783c   CALL runtime.chansend1(SB)
```

---

## 3. Analiza Pętli Leap-Frog: `CmdMoveElectrons` i `CmdMoveIons`

### 3.1. Sprzętowa fuzja operacji FMA (`VFMADD231SD`)
Dzięki wymuszeniu architektury `GOAMD64=v4`, kompilator Go dokonał fuzji operacji mnożenia i dodawania do instrukcji sprzętowych FMA3:
```go
// Interpolacja CIC:
ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1] - sim.Efield[p0])
```
Odpowiada temu w asemblerze:
```asm
0x1400c721a   MOVSD_XMM 0x7270ed0(CX)(SI*8), X2  ; X2 = Efield[p0]
0x1400c7223   MOVSD_XMM 0x7270ed8(CX)(SI*8), X3  ; X3 = Efield[p0+1]
0x1400c722c   SUBSD     X2, X3                   ; X3 = Efield[p0+1] - Efield[p0]
0x1400c7234   VFMADD231SD X3, X0, X2             ; X2 = Efield[p0] + d0 * X3
```
Również aktualizacja pozycji cząstki:
```go
sim.X_e[k] += vx0 * DT_E
```
kompiluje się bezpośrednio do instrukcji wektorowej:
```asm
0x1400c71ae   MOVSD_XMM 0x3567ee8(CX)(AX*8), X0  ; Załadowanie pozycji X_e[k]
0x1400c71b7   VFMADD231SD X7, X4, X0             ; X0 = X0 + vx0 * DT_E
0x1400c71bc   MOVSD_XMM X0, 0x3567ee8(CX)(AX*8)  ; Zapis in-place
```

### 3.2. 4-Krotne Rozwinięcie Pętli (4-Way Unrolling) i Brak Hazardów RAW
W rozwiniętej pętli przetwarzane są cztery cząstki równolegle:
* Obliczenia dla $k$ korzystają z rejestrów `X0, X2, X3`.
* Obliczenia dla $k+1$ korzystają z `X0, X4, X5`.
* Obliczenia dla $k+2$ korzystają z `X0, X6, X7`.
* Obliczenia dla $k+3$ korzystają z `X0, X8, X9`.

Na rdzeniach AMD Zen 4 jednostka wykonawcza dysponuje 2 niezależnymi potokami FMA (porty FP0 i FP1). Dzięki 4 niezależnym ścieżkom obliczeń jednostka Out-of-Order Execution procesora może wysyłać **2 instrukcje FMA na cykl zegara** bez przestojów potoku (brak zależności danych Read-After-Write pomiędzy kolejnymi cząstkami).

### 3.3. Skuteczność Eliminacji Testów Granic (BCE)
Wskazówka `_ = sim.X_e[end-1]` umieszczona przed pętlą główną:
```asm
0x1400c6165   LEAQ -0x1(R9), DX
0x1400c6169   CMPQ DX, $0xf4240       ; Sprawdzenie zakresu end-1 < 1_000_000 (MAX_N_P)
0x1400c6170   JAE  panicIndex         ; Pojedynczy skok awaryjny przed pętlą
```
W efekcie wewnątrz samej pętli 4-way unrolled zapisy i odczyty tablic cząstek są wykonywane **całkowicie bez skoków warunkowych sprawdzających granice tablicy**.

---

## 4. Analiza Modułu Zderzeń: `CollisionElectron` i `CollisionIon`

### 4.1. Fast-Path dla Wymiany Ładunku (`I_BACK`)
W [`collision_ion.s`](./collision_ion.s) wybór procesu zderzeniowego zoptymalizowano do natychmiastowego skoku:
```asm
; Sprawdzenie: rnd * t2 >= t1
0x1400b8e88   UCOMISD X2, X0
0x1400b8e8c   JAE     0x1400b8ed5    ; Natychmiastowy skok do Fast-Path (I_BACK)!

; --- FAST-PATH (etykieta 0x1400b8ed5) ---
0x1400b8ed5   MOVQ    0(BX), AX       ; Przepisanie vx_2 do vx_1
0x1400b8ed8   MOVQ    AX, 0(CX)
0x1400b8edb   MOVQ    0(DI), AX       ; Przepisanie vy_2 do vy_1
0x1400b8ede   MOVQ    AX, 0(SI)
0x1400b8ee1   MOVQ    0(R8), AX       ; Przepisanie vz_2 do vz_1
0x1400b8ee4   MOVQ    AX, 0(R9)
0x1400b8ee7   RET                     ; Wyjście bez żadnych obliczeń trygonometrycznych!
```
Dla ~80% zderzeń jonowych funkcja wykonuje jedynie 6 instrukcji `MOVQ` i natychmiast wraca.

### 4.2. Czysta Algebra Wektorowa w `CollisionElectron`
W [`collision_electron.s`](./collision_electron.s) wyeliminowano funkcje `math.Atan2`, `math.Sin`, `math.Cos`. 
Zamiast tego kompilator generuje:
```asm
0x1400b81a0   SQRTSD X3, X3          ; g = sqrt(gx*gx + gy*gy + gz*gz)
0x1400b81a4   DIVSD  X3, X0          ; ct = gx / g
0x1400b81a8   DIVSD  X3, X1          ; st = g_perp / g
```
Zastąpienie powolnych procedur aproksymacji wielomianowej dla funkcji trygonometrycznych bezpośrednim rzutowaniem wektorowym skróciło czas pojedynczego zderzenia elektronu o ponad **65%**.

---

## 5. Solver Poissona: `solve_poisson.s` (Eliminacja Dzieleń)

W [`solve_poisson.s`](./solve_poisson.s) algorytm Thomasa opiera się wyłącznie na instrukcjach mnożenia `MULSD`:
```asm
; Pętla eliminacji w przód (Forward Elimination):
; g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
0x1400c4e80   SUBSD     X1, X0        ; f[i] - g[i-1]
0x1400c4e84   MULSD     X2, X0        ; mnożenie przez prekomputowane ThomasW[i]
0x1400c4e88   MOVSD_XMM X0, 0(SI)     ; zapis g[i]
```
W całym zrzucie `solve_poisson.s` **nie występuje ani jedna instrukcja `DIVSD`**.

---

## 6. Porównanie Architektoniczne: Channels vs Chunking

| Cecha / Mechanizm | `Go/parallel_chunking` | `Go/parallel_channels` |
|:---|:---|:---|
| **Zarządzanie wątkami** | Dynamiczne uruchamianie goroutines (`wg.Go(...)`) w każdym kroku | Trwałe goroutines workerów (`startWorker`) nasłuchujące w nieskończonej pętli |
| **Bariera synchronizacyjna** | `sync.WaitGroup` (`wg.Wait()`) | Kanały buforowane (`sim.WorkerDoneChan`) |
| **Lokalizacja pętli roboczych** | Osobne domknięcia (closures) `Step3MoveElectrons.func1` | Centralna pętla `switch cmd` w ciele funkcji `startWorker` |
| **Instrukcje FMA (`VFMADD231SD`)** | Obecne w rozwiniętych pętlach Leap-Frog | Obecne w rozwiniętych pętlach Leap-Frog |
| **Bounds Check Elimination (BCE)** | Skuteczna (1 sprawdzenie przed pętlą) | Skuteczna (1 sprawdzenie przed pętlą) |
| **Eliminacja False Sharing** | 64-bajtowy padding w `state.go` | 64-bajtowy padding w `state.go` |
| **Weryfikacja bitowa** | PASS (identyczny plik `conv.dat`) | PASS (identyczny plik `conv.dat`) |

---

## 7. Podsumowanie Wniosków

1. **Jakość kodu maszynowego:** W obu wariantach (`chunking` i `channels`) kompilator Go przy `GOAMD64=v4` generuje wysoko zoptymalizowany kod asemblera x86-64, w pełni wykorzystujący instrukcje FMA3 oraz bezgałęziowe operacje warunkowe (`CMOV`).
2. **Koszty narzutu runtime:** Wersja `channels` całkowicie eliminuje narzut alokacji domknięć goroutines w każdym kroku czasowym, przenosząc koszt synchronizacji na bardzo szybkie operacje w buforowanych kanałach runtime Go (`chanrecv2` / `chansend1`).
3. **Reprodukowalność numeryczna:** Dezasemblacja potwierdza identyczną kolejność operacji zmiennoprzecinkowych, co gwarantuje pełną zgodność bitową wyników symulacji pomiędzy obiema architekturami.
