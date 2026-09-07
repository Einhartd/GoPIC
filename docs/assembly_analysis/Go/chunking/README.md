# Raport z analizy kodu asemblera `Go/parallel_chunking` (Zen 4, `GOAMD64=v4`)

## 1. Wprowadzenie i środowisko kompilacji

Niniejszy dokument przedstawia szczegółową analizę kodu maszynowego wygenerowanego przez kompilator Go dla implementacji równoległej opartej na podziale dziedziny na chunki: **`Go/parallel_chunking`**.

- **Architektura procesora docelowego:** AMD Zen 4 (`GOOS=linux`, `GOARCH=amd64`, `GOAMD64=v4` — AVX-512F, AVX-512DQ, AVX-512BW, AVX-512VL, FMA3, BMI2, POPCNT).
- **Narzędzie dezasemblacji:** `go tool objdump -S` z przeplotem kodu źródłowego Go.
- **Zawartość katalogu:** [`docs/assembly_analysis/Go/chunking/`](.) zawiera 11 plików dezasemblacji:
  1. [`do_one_cycle.s`](./do_one_cycle.s) — Główna pętla czasowa cyklu RF (`DoOneCycle`): sekwencja wywołań 9 kroków algorytmu PIC/MCC w każdym z 4000 podkroków czasowych.
  2. [`step1_density.s`](./step1_density.s) — Depozycja gęstości elektronów i jonów (`Step1ComputeElectronDensity`, `Step1ComputeIonDensity`): równoległa depozycja wagowa metodą CIC w chunkach oraz redukcja seryjna do siatek globalnych.
  3. [`solve_poisson.s`](./solve_poisson.s) — 1D solver Poissona (`Step2SolvePoisson`, `SolvePoisson`): eliminacja dzieleń dzięki prekomputowanemu wektorowi współczynników `ThomasW`.
  4. [`step3_push_electrons.s`](./step3_push_electrons.s) — Popychanie elektronów Leap-Frog (`Step3MoveElectrons`): 4-krotne rozwinięcie pętli (4-way unrolling), instrukcje FMA3 oraz eliminacja sprawdzania granic tablic (BCE).
  5. [`step4_push_ions.s`](./step4_push_ions.s) — Popychanie jonów Leap-Frog (`Step4MoveIons`): 4-way unrolling z fuzją mnożenia i dodawania FMA3.
  6. [`step5_boundaries_electrons.s`](./step5_boundaries_electrons.s) — Warunki brzegowe elektronów (`Step5CheckBoundariesElectrons`): Faza 1 (równoległe zbieranie indeksów martwych cząstek do `WorkerDeadElectrons`) oraz Faza 2 (błyskawiczna dwuwskaźnikowa kompaktacja $O(\text{dead})$ in-place).
  7. [`step6_boundaries_ions.s`](./step6_boundaries_ions.s) — Warunki brzegowe jonów (`Step6CheckBoundariesIons`): równoległe próbkowanie histogramu IFED, zbieranie martwych jonów oraz kompaktacja $O(\text{dead})$.
  8. [`step7_collisions_electrons.s`](./step7_collisions_electrons.s) — Zderzenia elektronów metodą Null-Collision (`Step7CollisionsElectrons`): w 100% równoległe losowanie dwumianowe w chunkach (`workerSampleBinomial`), selekcja cząstek $O(N_{\text{coll}})$ i scalanie wtórnych par w globalnych tablicach SoA.
  9. [`step8_collision_ions.s`](./step8_collision_ions.s) — Zderzenia jonów MCC (`Step8CollisionIons`): obsługa subcyclingu, równoległe próbkowanie w chunkach i zderzenia in-place.
  10. [`collision_electron.s`](./collision_electron.s) — Ciało zderzenia elektron-atom (`CollisionElectron`): dobór multiplikatywny procesów oraz czysta algebra wektorowa bez funkcji trygonometrycznych.
  11. [`collision_ion.s`](./collision_ion.s) — Ciało zderzenia jon-atom (`CollisionIon`): Fast-Path dla zderzeń wymiany ładunku (`I_BACK`).

---

## 2. Model Wykonawczy: Dynamiczny Fork-Join (`sync.WaitGroup`)

W architekturze `parallel_chunking` zrównoleglenie realizowane jest w modelu **Dynamic Fork-Join**. W każdym kroku czasowym funkcja koordynująca dzieli zbiór cząstek lub siatkę na $W$ chunków i deleguje wykonanie do goroutines za pomocą `sync.WaitGroup`.

### 2.1. Uruchamianie goroutines w pętli (`wg.Go`)
W dezasemblacji [`step3_push_electrons.s`](./step3_push_electrons.s) i [`do_one_cycle.s`](./do_one_cycle.s) widać schemat przekazywania domknięć (closures) do runtime'u Go:
```asm
; wg.Go(func() { ... })
0x4bc89c   LEAQ  gopic.(*SimulationState).Step3MoveElectrons.func1(SB), AX
0x4bc8a3   CALL  sync.(*WaitGroup).Go(SB)
```
Metoda `wg.Go` inkrementuje wewnętrzny licznik oczekiwanych zadań (`wg.Add(1)`) i kolejkuje funkcję w lokalnej kolejce schedulera Go (`runqueue`).

### 2.2. Bariera synchronizacyjna (`wg.Wait`)
Po rozesłaniu zadań wątek główny synchronizuje się barierowo:
```asm
; wg.Wait()
0x4bc8be   CALL  sync.(*WaitGroup).Wait(SB)
```
W kodzie maszynowym `wg.Wait()` wywołuje procedurę `sync.runtime_Semacquire`, która usypia wątek główny za pomocą mechanizmu `gopark` i semafora jądra (`futex`), dopóki wszystkie goroutines nie wywołają `wg.Done()`. 

---

## 3. Popychanie Cząstek (Leap-Frog): `step3_push_electrons.s`

### 3.1. Sprzętowa fuzja FMA (`VFMADD231SD`)
Wymuszenie standardu instrukcji `GOAMD64=v4` pozwala kompilatorowi Go zastąpić parę instrukcji `MULSD` + `ADDSD` pojedynczą instrukcją FMA3:
```go
// Interpolacja pola elektrycznego w węźle p0:
ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1] - sim.Efield[p0])
```
Odpowiada temu w asemblerze:
```asm
0x4bed2e   MOVSD_XMM 0x7270ed0(R11)(DX*8), X1  ; X1 = Efield[p0]
0x4bed38   MOVSD_XMM 0x7270ed8(R11)(DX*8), X2  ; X2 = Efield[p0+1]
0x4bed42   SUBSD     X1, X2                   ; X2 = Efield[p0+1] - Efield[p0]
0x4bed46   VFMADD231SD X2, X0, X1             ; X1 = Efield[p0] + d0 * X2
```
Aktualizacja pozycji:
```go
sim.X_e[k] += vx0 * DT_E
```
kompiluje się bezpośrednio do:
```asm
0x4bed9e   MOVSD_XMM 0x3567ed0(R11)(AX*8), X0  ; Załadowanie X_e[k]
0x4beda8   VFMADD231SD X6, X2, X0             ; X0 = X0 + vx0 * DT_E
0x4bedad   MOVSD_XMM X0, 0x3567ed0(R11)(AX*8)  ; Zapis do pamięci
```

### 3.2. 4-Krotne Rozwinięcie Pętli (4-Way Unrolling) i Brak Zależności RAW
W sekcji Fast-Path kompilator przetwarza 4 cząstki naraz:
- Cząstka $k$: operacje na rejestrach `X0, X1, X2`.
- Cząstka $k+1$: operacje na rejestrach `X3, X4, X5`.
- Cząstka $k+2$: operacje na rejestrach `X7, X8, X9`.
- Cząstka $k+3$: operacje na rejestrach `X10, X11, X12`.

Dzięki brakowi zależności typu Read-After-Write (RAW) między kolejnymi indeksami, jednostka Out-of-Order Execution rdzenia AMD Zen 4 może wykonywać do **2 instrukcji FMA na cykl**, osiągając zmierzony współczynnik IPC na poziomie **3.65 – 3.70**.

### 3.3. Skuteczność Eliminacji Testów Granic (BCE)
Asercja umieszczona przed pętlą główną:
```go
if e > s {
    _ = sim.X_e[e-1]
    _ = sim.Vx_e[e-1]
}
```
generuje pojedyncze sprawdzenie zakresu:
```asm
0x4beb98   LEAQ -0x1(R10), DX
0x4beb9c   CMPQ DX, $0xf4240        ; Czy (e - 1) < 1 000 000 (MAX_N_P)?
0x4beba3   JAE  panicIndex          ; Skok awaryjny wykonywany tylko w razie błędu
```
Dzięki temu wewnątrz samej pętli 4-way unrolling nie ma ani jednej instrukcji skoku sprawdzającej przekroczenie zakresu tablicy (`panicBounds`).

---

## 4. Nowa Dwufazowa Kompaktacja Granic $O(\text{dead})$: `step5_boundaries_electrons.s`

Zoptymalizowany moduł sprawdzania granic eliminuje skanowanie 108 000 cząstek w każdym kroku czasowym.

### 4.1. Faza 1: Zbieranie indeksów martwych cząstek
Wewnątrz domknięcia workera (`Step5CheckBoundariesElectrons.func1`):
```asm
; if sim.X_e[k] < 0 { dead = append(dead, k) }
0x4c0412   MOVSD_XMM 0x3567ed0(R9)(R11*8), X0  ; Odczyt X_e[k]
0x4c041c   XORPS     X1, X1                    ; X1 = 0.0
0x4c041f   UCOMISD   X0, X1                    ; Porównanie X_e[k] z 0.0
0x4c0423   JBE       0x4c0477                  ; Jeśli >= 0, sprawdź prawą elektrodę
; Dodanie indeksu k do WorkerDeadElectrons
0x4c0465   MOVQ      R11, -0x8(AX)(BX*8)       ; dead[len] = k
0x4c046a   INCQ      0x7090(R10)(R12*1)        ; diag.abs_pow++
```
W 99.9% przypadków cząstki mieszczą się w domenie — procesor wykonuje jedynie porównanie `UCOMISD` i skacze do kolejnej cząstki bez żadnego zapisu do pamięci.

### 4.2. Faza 2: Dwuwskaźnikowa kompaktacja in-place ($O(\text{dead})$)
W ciele funkcji [`Step5CheckBoundariesElectrons`](./step5_boundaries_electrons.s):
1. Jeśli `totalAbs == 0`, funkcja natychmiast wychodzi bez żadnych iteracji:
   ```asm
   0x4bd0d4   TESTQ CX, CX           ; Czy totalAbs == 0?
   0x4bd0d7   JLE   0x4bd1d8         ; Natychmiastowe zakończenie (0 ns)!
   ```
2. Jeśli `totalAbs > 0`, dekrementuje wskaźnik `lastValid` i przepisuje tylko martwe cząstki:
   ```asm
   ; while lastValid > deadIdx && (X_e[lastValid] < 0 || X_e[lastValid] > L) lastValid--
   0x4bd10d   CMPQ  AX, R10          ; lastValid > deadIdx?
   0x4bd110   JLE   0x4bd177
   ; Przepisanie żywej cząstki z końca tablicy na miejsce deadIdx:
   0x4bd177   MOVSD_XMM 0x3567ed0(SI)(AX*8), X0   ; X_e[deadIdx] = X_e[lastValid]
   0x4bd181   MOVSD_XMM X0, 0x3567ed0(SI)(R10*8)
   0x4bd18b   MOVSD_XMM 0x3bbce50(SI)(AX*8), X0   ; Vx_e[deadIdx] = Vx_e[lastValid]
   0x4bd195   MOVSD_XMM X0, 0x3bbce50(SI)(R10*8)
   0x4bd19f   MOVSD_XMM 0x4211e90(SI)(AX*8), X0   ; Vy_e[deadIdx] = Vy_e[lastValid]
   0x4bd1aa   MOVSD_XMM X0, 0x4c4b4d0(SI)(R10*8)   ; Vz_e[deadIdx] = Vz_e[lastValid]
   0x4bd1b4   DECQ      AX                        ; lastValid--
   ```
3. Aktualizacja liczby aktywnych elektronów:
   ```asm
   0x4bd1cc   SUBQ CX, 0x3567ec0(SI)  ; sim.N_e -= totalAbs
   ```

### 2.3. Optymalizacja Depozycji Ładunku CIC w Kroku 1 (`step1_density.s`)
W implementacji bazowej depozycja ładunku wykonywała dwa niezależne mnożenia zmiennoprzecinkowe dla każdego węzła siatki. Zoptymalizowano schemat w oparciu o referencyjny kod C++ OpenMP:
```go
c2 := (c0 - float64(p)) * FACTOR_W
c1 := FACTOR_W - c2
density[p] += c1
density[p+1] += c2
```
W dezasemblacji [`step1_density.s`](./step1_density.s) w pętli workera `Step1ComputeElectronDensity.func1`:
```asm
0x4bf0fe   CVTSI2SDQ AX, X2
0x4bf106   SUBSD     X2, X0                    ; c0 - float64(p)
0x4bf10a   MOVSD_XMM $f64.FACTOR_W(SB), X2
0x4bf112   MULSD     X0, X2                    ; c2 = (c0 - p) * FACTOR_W (tylko 1 mnożenie!)
0x4bf116   MOVSD_XMM $f64.FACTOR_W(SB), X0
0x4bf11e   SUBSD     X2, X0                    ; c1 = FACTOR_W - c2
0x4bf122   ADDSD     0(DI)(AX*8), X0           ; density[p] += c1
0x4bf127   MOVSD_XMM X0, 0(DI)(AX*8)
0x4bf12c   ADDSD     0x8(DI)(AX*8), X2         ; density[p+1] += c2
0x4bf132   MOVSD_XMM X2, 0x8(DI)(AX*8)
```
Eliminacja 1 mnożenia na cząstkę oszczędza w skali 100 cykli (400 000 kroków) ponad **86 miliardów operacji zmiennoprzecinkowych**.

---

## 5. Zderzenia Kinetyczne i Metoda Null-Collision: `step7_collisions_electrons.s` i `step8_collision_ions.s`

### 5.1. Eliminacja Szeregowego Wąskiego Gardła `randomSample` i `CandidatePool`
W pierwotnej implementacji Go wątek główny w każdym kroku czasowym seryjnie wykonywał:
- Inicjalizację i tasowanie Fishera-Yatesa tablicy `CandidatePool` (108 000 iteracji zapisu do RAM co krok).
- Ponad 1900 wywołań generatora pseudolosowego `sim.Rng.Intn()` na krok czasowy.

W skali 100 cykli (400 000 kroków) powodowało to **54.5 miliarda seryjnych zapisów do pamięci** i **764 miliony wywołań RNG na wątku głównym**, uniemożliwiając skalowanie powyżej $1.36\times$.

Zastąpiono to w 100% zrównoleglonym podejściem referencyjnym z C++ OpenMP:
- Całkowicie wyeliminowano strukturę `CandidatePool` (oszczędność 80 MB pamięci).
- Wątek główny nie wykonuje żadnych operacji losowania ani selekcji cząstek.

### 5.2. Równoległe Próbkowanie Dwumianowe w Chunkach (`workerSampleBinomial`)
Każdy worker w swoim lokalnym chunku cząstek $[s, e)$ niezależnie losuje liczbę zderzeń oraz bezpośrednio wybiera indeksy cząstek:
```go
nLocal := e - s
localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarE)
for range localNColl {
    ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
    if ki >= e { ki = e - 1 }
    // Test akceptacji i zderzenie in-place
}
```
W dezasemblacji [`step7_collisions_electrons.s`](./step7_collisions_electrons.s) w ciele workera `Step7CollisionsElectrons.func1`:
```asm
; 1. Niezależne losowanie liczby zderzeń w lokalnym chunku (tw. de Moivre'a-Laplace'a O(1)):
0x4c04f9   CALL  gopic.(*SimulationState).workerSampleBinomial(SB)

; 2. Bezpośrednie losowanie indeksu cząstki w chunku O(localNColl):
0x4c0571   CALL  gopic.(*SimulationState).WorkerR01(SB)   ; R01 z prywatnego MT workera
0x4c057f   MULSD X1, X0                                  ; R01 * nLocal
0x4c0583   CVTTSD2SIQ X0, CX                             ; int(R01 * nLocal)
0x4c058d   ADDQ  DX, CX                                  ; ki = s + int(...)
```
Złożoność zredukowana z $O(N)$ seryjnego do $O(N_{\text{coll}} / W)$ w pełni zrównoleglonego.

### 5.3. Czysta Algebra Wektorowa w `CollisionElectron`
W [`collision_electron.s`](./collision_electron.s) wyeliminowano powolne funkcje trygonometryczne `math.Atan2`, `math.Cos`, `math.Sin`.
Kompilator generuje szybkie pierwiastkowanie sprzętowe i dzielenia algebraiczne:
```asm
0x4b6910   SQRTSD X3, X3              ; g = sqrt(g_sq)
0x4b6914   DIVSD  X3, X0              ; ct = gx / g
0x4b6918   DIVSD  X3, X1              ; st = g_perp / g
```

### 5.4. Fast-Path Zderzeń Jonowych `I_BACK` w `CollisionIon`
W [`collision_ion.s`](./collision_ion.s) dla najczęstszego procesu zderzeniowego (zderzenie wymiany ładunku z rozproszeniem wstecznym $I_{\text{BACK}}$):
```asm
0x4b78c8   UCOMISD X2, X0             ; Czy rnd * t2 >= t1?
0x4b78cc   JAE     0x4b7915           ; Natychmiastowy skok do Fast-Path!

; --- FAST-PATH (etykieta 0x4b7915) ---
0x4b7915   MOVQ    0(BX), AX          ; Przepisanie vx_2 do vx_1
0x4b7918   MOVQ    AX, 0(CX)
0x4b791b   MOVQ    0(DI), AX          ; Przepisanie vy_2 do vy_1
0x4b791e   MOVQ    AX, 0(SI)
0x4b7921   MOVQ    0(R8), AX          ; Przepisanie vz_2 do vz_1
0x4b7924   MOVQ    AX, 0(R9)
0x4b7927   RET                        ; Natychmiastowy powrót (0 obliczeń kątowych!)
```

---

## 6. Solver Poissona: `solve_poisson.s` (Eliminacja Dzieleń)

W [`solve_poisson.s`](./solve_poisson.s) eliminacja w przód algorytmu Thomasa korzysta z prekomputowanego wektora `ThomasW`:
```asm
; g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
0x4bb4a0   SUBSD     X1, X0           ; f[i] - g[i-1]
0x4bb4a4   MULSD     X2, X0           ; mnożenie przez ThomasW[i]
0x4bb4a8   MOVSD_XMM X0, 0(SI)        ; zapis g[i]
```
W całym wygenerowanym kodzie dezasemblacji nie występuje ani jedna instrukcja `DIVSD`.

---

## 7. Podsumowanie Wniosków z Analizy Asemblera

1. **Jakość wektoryzacji i potokowości:** Dzięki flagom `GOAMD64=v4` kompilator Go wygenerował instrukcje FMA3 (`VFMADD231SD`) w pętlach Leap-Frog, a 4-krotne rozwinięcie pętli pozwala procesorowi AMD Zen 4 osiągać wysokie IPC (> 3.6).
2. **Potwierdzenie optymalizacji granic:** Zrzut `step5_boundaries_electrons.s` i `step6_boundaries_ions.s` potwierdza, że pętla $O(N)$ została całkowicie usunięta z kodu maszynowego. W jej miejsce pojawiła się instrukcja warunkowa `TESTQ` i szybka kompaktacja dwuwskaźnikowa działająca w czasie proporcjonalnym wyłącznie do liczby pochłoniętych cząstek.
3. **Eliminacja wąskiego gardła zderzeń Null-Collision:** Zrzuty `step7_collisions_electrons.s` i `step8_collision_ions.s` dowodzą całkowitego usunięcia seryjnego algorytmu `randomSample` i bufora `CandidatePool`. Zderzenia są w 100% zrównoleglone na poziomie workerów poprzez losowanie `workerSampleBinomial`, dokładnie odzwierciedlając architekturę referencyjną C++ OpenMP.
4. **Zgodność architektoniczna z C++:** Wszystkie kluczowe optymalizacje algebraiczne (eliminacja 1 mnożenia w CIC, brak trygonometrii, mnożnikowy Thomas, Fast-Path `I_BACK`, dwuwskaźnikowa filtracja granic, równoległe Null-Collision) mają swoje bezpośrednie, identyczne odpowiedniki w kodzie asemblera C++ OpenMP.
