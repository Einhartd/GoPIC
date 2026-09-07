# Raport z analizy kodu asemblera `Go/parallel_channels` (Zen 4, `GOAMD64=v4`)

## 1. Wprowadzenie i środowisko kompilacji

Niniejszy dokument przedstawia szczegółową analizę kodu maszynowego wygenerowanego przez kompilator Go dla zoptymalizowanej implementacji wielowątkowej opartej na trwałych workerach i kanałach: **`Go/parallel_channels`**.

- **Architektura procesora:** AMD Zen 4 (`GOAMD64=v4` — AVX-512F, AVX-512DQ, AVX-512BW, AVX-512VL, FMA3, BMI2, POPCNT).
- **Kompilator:** Go `go1.27.1 windows/amd64` (oraz `go1.26.5 linux/amd64` na klastrze HPC Lem).
- **Struktura katalogu:** Katalog [`docs/assembly_analysis/Go/channels/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels) zawiera 12 plików z dezasemblacją z przeplotem kodu źródłowego Go (`go tool objdump -S`):

| Plik Asemblera | Rozmiar | Analizowane Symbole | Opis Funkcjonalny |
|:---|:---:|:---|:---|
| [`start_worker.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/start_worker.s) | **92 KB** | `gopic.(*SimulationState).startWorker` | Główna pętla wykonawcza trwałego workera: odbiór rozkazów przez `runtime.chanrecv2`, gałęzie pętli cząstkowych (Leap-Frog, CIC, Granice, Kolizje) oraz wysyłanie sygnału ukończenia przez `runtime.chansend1`. |
| [`step1_density.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/step1_density.s) | **13 KB** | `Step1ComputeElectronDensity`, `Step1ComputeIonDensity` | Koordynator depozycji gęstości elektronów i jonów: rozesłanie rozkazu kanałowego, oczekiwanie na workery oraz sekwencyjna redukcja buforów $W 	imes N_G$. |
| [`solve_poisson.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/solve_poisson.s) | **12 KB** | `Step2SolvePoisson`, `SolvePoisson` | Jednowątkowy solver Poissona (Thomas TDMA): eliminacja dzieleń zmiennoprzecinkowych dzięki tablicy `ThomasW`. |
| [`step3_push_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/step3_push_electrons.s) | **8.5 KB** | `Step3MoveElectrons` | Koordynator Leap-Frog dla elektronów: wstrzyknięcie `CmdMoveElectrons` i redukcja diagnostyk XT w trybie pomiarowym. |
| [`step4_push_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/step4_push_ions.s) | **7.0 KB** | `Step4MoveIons` | Koordynator Leap-Frog dla jonów w krokach subcyclingu ($t \% N_{\text{SUB}} == 0$). |
| [`step5_boundaries_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/step5_boundaries_electrons.s) | **9.0 KB** | `Step5CheckBoundariesElectrons` | Koordynator granic elektronów: dwufazowa obsługa absorpcji oraz sekwencyjna kompaktacja in-place $O(\text{dead})$. |
| [`step6_boundaries_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/step6_boundaries_ions.s) | **11 KB** | `Step6CheckBoundariesIons` | Koordynator granic jonów, redukcja liczników absorpcji i histogramu IFED. |
| [`step7_collisions_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/step7_collisions_electrons.s) | **18 KB** | `Step7CollisionsElectrons`, `workerSampleBinomial` | Koordynator zderzeń elektronów metodą Null-Collision i scalanie (flush) buforów AoS do SoA. |
| [`step8_collision_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/step8_collision_ions.s) | **6.5 KB** | `Step8CollisionIons` | Koordynator zderzeń jonów z atomami tła w krokach subcyclingu. |
| [`collision_electron.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/collision_electron.s) | **32 KB** | `CollisionElectron` | Fizyka zderzeń elastycznych, wzbudzeń i jonizacji elektron-argon. |
| [`collision_ion.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/collision_ion.s) | **13 KB** | `CollisionIon` | Fizyka zderzeń sprężystych i wymiany ładunku (charge-exchange) jon-argon. |
| [`do_one_cycle.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/do_one_cycle.s) | **13 KB** | `DoOneCycle` | Główna pętla czasowa symulacji ($N_T = 4000$ podkroków RF na cykl). |

---

## 2. Architektura Wykonawcza: `start_worker.s` i Komunikacja Kanałowa

W architekturze `parallel_channels` workery są powoływane **dokładnie raz** na początku programu i trwają przez wszystkie cykle symulacji.

### 2.1. Odbiór rozkazów przez kanał (`runtime.chanrecv2`)
W pliku [`start_worker.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/channels/start_worker.s) na początku pętli każdego workera wywoływana jest funkcja runtime odbierająca polecenie:
```asm
; for cmd := range sim.WorkerCmdChan[workerID]
0x1400c5fa4   LEAQ 0xc8(SP), BX
0x1400c5fac   CALL runtime.chanrecv2(SB)
0x1400c5fb1   TESTL AL, AL
0x1400c5fb3   JE   0x1400c646b    ; Wyjście po zamknięciu kanału (CmdStop)
0x1400c5fb9   MOVQ 0xc8(SP), DX   ; Wczytanie odebranego rozkazu (WorkerCommand)
```
Po odebraniu rozkazu rejestr `DX` steruje skokiem do odpowiedniej gałęzi pętli cząstkowej:
- `0` $	o$ `CmdComputeEDensity`
- `1` $	o$ `CmdComputeIDensity`
- `2` $	o$ `CmdMoveElectrons`
- `3` $	o$ `CmdMoveIons`
- `4` $	o$ `CmdCheckBoundariesE`
- `5` $	o$ `CmdCheckBoundariesI`
- `6` $	o$ `CmdCollisionsE`
- `7` $	o$ `CmdCollisionsI`
- `8` $	o$ `CmdStop`

### 2.2. Sygnalizacja ukończenia zadania (`sim.WorkerDoneChan <- workerID`)
Na końcu każdej gałęzi obliczeniowej worker przesyła swój identyfikator do wspólnego kanału bariery:
```asm
; sim.WorkerDoneChan <- workerID
0x1400c782d   MOVQ 0x7ba2e48(CX), AX   ; sim.WorkerDoneChan
0x1400c7834   MOVQ 0xf0(SP), BX        ; workerID
0x1400c783c   CALL runtime.chansend1(SB)
```

### 2.3. Rozsyłanie rozkazów przez koordynatora (`broadcastAndWait`)
Kompilator Go dokonał **inline'owania** funkcji `broadcastAndWait` bezpośrednio do każdego koordynatora (np. `Step1ComputeElectronDensity`, `Step3MoveElectrons`). W asemblerze koordynatora widoczna jest pętla wysyłania:
```asm
; for w := range numWorkers { sim.WorkerCmdChan[w] <- cmd }
0x1400c3420   MOVQ (DX)(SI*8), AX      ; sim.WorkerCmdChan[w]
0x1400c3424   LEAQ 0x48(SP), BX        ; &cmd
0x1400c3429   CALL runtime.chansend1(SB)
...
; for range numWorkers { <-sim.WorkerDoneChan }
0x1400c3460   MOVQ 0x7ba2e48(CX), AX   ; sim.WorkerDoneChan
0x1400c3467   XORL BX, BX              ; nil (brak bufora odbiorczego)
0x1400c3469   CALL runtime.chanrecv1(SB)
```

---

## 3. Analiza Asemblera Obliczeń Numerycznych (AVX-512 i FMA)

### 3.1. Sprzętowa fuzja FMA (`VFMADD231SD`) w pętli Leap-Frog
Wewnątrz `start_worker.s` w gałęzi `CmdMoveElectrons` interpolacja pola elektrycznego (CIC) oraz popychanie cząstki zostały skompilowane z użyciem instrukcji FMA:
```asm
; ex0 = Efield[p0] + d0 * (Efield[p0+1] - Efield[p0])
0x1400c721a   MOVSD_XMM 0x7270ed0(CX)(SI*8), X2   ; Efield[p0]
0x1400c7223   MOVSD_XMM 0x7270ed8(CX)(SI*8), X3   ; Efield[p0+1]
0x1400c722c   SUBSD     X2, X3                    ; dE = Efield[p0+1] - Efield[p0]
0x1400c7230   VFMADD231SD X1, X3, X2              ; X2 = Efield[p0] + d0 * dE
; Vx_e -= ex0 * FACTOR_E
0x1400c7240   VFMADD231SD X2, X4, X0              ; Sprzętowe uaktualnienie prędkości
```

### 3.2. Eliminacja dzieleń w solverze Poissona (`solve_poisson.s`)
W funkcji `SolvePoisson` klasyczne dzielenia w algorytmie Thomasa zostały w pełni zastąpione mnożeniem przez prekomputowaną tablicę `ThomasW`:
```asm
; pot[i] = (pot[i] + C * pot[i+1]) * sim.ThomasW[i]
0x1400c2420   MOVSD_XMM (R8)(SI*8), X1            ; ThomasW[i]
0x1400c2426   MULSD     X1, X0                    ; Mnożenie zamiast kosztownego DIVSD!
```

---

## 4. Wąskie Gardła Zidentyfikowane na Poziomie Asemblera

Mimo braku ciągłego tworzenia goroutines, analiza kodu maszynowego ujawnia dwa kluczowe źródła narzutu w architekturze Channels:

1. **Narzut wywołań `runtime.chanrecv2` i `runtime.chansend1`:**  
   W każdym podkroku czasowym program wykonuje $W$ wywołań `chansend1` oraz $W$ wywołań `chanrecv1`. Każde z tych wywołań wewnątrz biblioteki runtime Go pobiera blokadę `hchan.lock`. Dla 64 workerów oznacza to **intensywną rywalizację o pamięć podręczną na pojedynczym muteksie kanału `WorkerDoneChan`**.
2. **Pętla sekwencyjnej redukcji w koordynatorze:**  
   W pliku `step1_density.s` koordynator po odebraniu sygnałów z kanałów wykonuje sekwencyjną pętlę sumowania buforów workerów:
   ```asm
   ; for w := range numWorkers { for p := range N_G { E_density[p] += WorkerEDensity[w][p] } }
   0x1400c34a0   ADDSD (R9)(DX*8), X0
   0x1400c34a6   MOVSD_XMM X0, (R8)(DX*8)
   ```
   Dla $W=64$ jest to $64 \times 400 = 25\,600$ operacji zmiennoprzecinkowych wykonywanych na jednym rdzeniu, podczas gdy pozostałe 63 rdzenie czekają na kolejny rozkaz.
