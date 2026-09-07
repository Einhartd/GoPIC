# Analiza Kodu Asemblera: `Go/parallel_optimized` (GOAMD64=v4)

Katalog zawiera zrzuty asemblera x86_64 dla zoptymalizowanego wariantu **`Go/parallel_optimized`**, wygenerowane narzędziem `go tool objdump -S` przy włączonym poziomie architektury **`GOAMD64=v4`** (obsługa AVX, AVX2, FMA3, BMI1, BMI2).

---

## 1. Wygenerowane Pliki Asemblera

| Plik | Rozmiar | Analizowane Symbole |
|:---|:---:|:---|
| [`barrier_and_procyield.s`](./barrier_and_procyield.s) | 12.6 KB | `procyield`, `broadcastAndWait`, `startWorker` |
| [`execute_worker_task.s`](./execute_worker_task.s) | 3.3 KB | `executeWorkerTask` (lekki dyspozytor, ramka 16 bajtów) |
| [`worker_move_electrons.s`](./worker_move_electrons.s) | 51.8 KB | `workerMoveElectrons` (fuzja Leap-Frog + granice in-register) |
| [`worker_move_ions.s`](./worker_move_ions.s) | 65.0 KB | `workerMoveIons` (fuzja Leap-Frog + granice jonów + IFED) |
| [`worker_density.s`](./worker_density.s) | 10.5 KB | `workerComputeEDensity`, `workerComputeIDensity` (depozycja CIC) |
| [`step1_density.s`](./step1_density.s) | 10.4 KB | `Step1ComputeElectronDensity`, `Step1ComputeIonDensity` (streaming) |
| [`solve_poisson.s`](./solve_poisson.s) | 12.0 KB | `Step2SolvePoisson`, `SolvePoisson` (algorytm Thomasa) |
| [`step3_fused_push_electrons.s`](./step3_fused_push_electrons.s) | 6.1 KB | `Step3MoveAndBoundariesElectrons` (wrapper wywołania bariery) |
| [`step4_fused_push_ions.s`](./step4_fused_push_ions.s) | 5.2 KB | `Step4MoveAndBoundariesIons` (subcycling jonów) |
| [`step5_compact_electrons.s`](./step5_compact_electrons.s) | 9.3 KB | `Step5CompactElectrons`, `Step5CheckBoundariesElectrons` |
| [`step6_compact_ions.s`](./step6_compact_ions.s) | 10.8 KB | `Step6CompactIons`, `Step6CheckBoundariesIons` |
| [`step7_collisions_electrons.s`](./step7_collisions_electrons.s) | 17.9 KB | `Step7CollisionsElectrons`, `workerSampleBinomial` |
| [`step8_collision_ions.s`](./step8_collision_ions.s) | 2.1 KB | `Step8CollisionIons` |
| [`collision_electron.s`](./collision_electron.s) | 31.4 KB | `CollisionElectron` (kinematyka rozpraszania e- / Ar) |
| [`collision_ion.s`](./collision_ion.s) | 14.9 KB | `CollisionIon` (sprężyste izotropowe i wymiana ładunku) |
| [`do_one_cycle.s`](./do_one_cycle.s) | 10.6 KB | `DoOneCycle` (główna pętla czasowa cyklu RF) |

---

## 2. Sukcesy Optymalizacyjne Zaobserwowane w Asemblerze

### A. Bezblokadowy `broadcastAndWait` w asemblerze
W porównaniu do wariantu `channels` (gdzie występowały dziesiątki wywołań `runtime.chansend`, `runtime.chanrecv`, `runtime.selectgo` i blokady `hchan.lock`), nowa procedura rozsyłania rozkazu sprowadza się do **zaledwie 4 instrukcji CPU**:
```asm
875a08        XCHGL BX, 0x8(DX)          // Atomowy zapis komendy (Store cmd)
be01000000    MOVL $0x1, SI
f0480fc17210  LOCK XADDQ SI, 0x10(DX)    // Atomowa inkrementacja kroku bariery (Add step)
e81b280000    CALL executeWorkerTask(SB) // Natychmiastowe wykonanie zadania workera 0
```
- **Brak wywołań systemowych:** ani jedno wywołanie `SYS_futex`.
- **Zero alokacji na stercie:** parametry przekazywane wyłącznie przez rejestry.

### B. Wykorzystanie instrukcji FMA (Fused Multiply-Add)
Dzięki fladze `GOAMD64=v4` kompilator w pętli Leap-Frog generuje sprzętowe instrukcje FMA:
```asm
c4e2f9b9ee    VFMADD231SD X6, X0, X5     // ex3 = sim.Efield[p3] + d3*(E[p3+1]-E[p3])
c4e2f9b9ef    VFMADD231SD X7, X0, X5     // x0 = sim.X_e[k] + vx0*DT_E
```
Obliczenie $A \cdot B + C$ wykonuje się w jednym cyklu maszynowym z pojedynczym zaokrągleniem IEEE-754.

### C. Fuzja detekcji granic na rejestrach procesora
Nowa pozycja cząstki $X_{new}$ po obliczeniu instrukcją `VFMADD231SD` znajduje się bezpośrednio w rejestrze `X5`. Test granic wykonywany jest natychmiast:
```asm
0f57e4        XORPS X4, X4
660f2ee5      UCOMISD X5, X4             // Porównanie z 0.0 w rejestrach
0f86b6000000  JBE dead_boundary          // Skok brzegowy (przewidywany jako NIEWYKONANY)
```
- Gdy cząstka pozostaje w plazmie (99.9% przypadków), kod przeskakuje natychmiast do kolejnej cząstki bez dotykania pamięci RAM.

---

## 3. Zastosowane Usprawnienia Niskopoziomowe (b, c, d)

### Poprawka b: Eliminacja Register Spilling
- **Wdrożenie:** Rozbito monolityczną funkcję `executeWorkerTask` na dedykowane metody: `workerMoveElectrons`, `workerMoveIons`, `workerComputeEDensity`, `workerComputeIDensity`, `workerCollisionsE`, `workerCollisionsI`.
- **Wynik w asemblerze:** Ramka stosu `executeWorkerTask` zmniejszyła się z **488 bajtów do zaledwie 16 bajtów** (`SUBQ $0x10, SP`). W pętlach obliczeniowych zmienne `k`, `end`, tablice i rejestry FMA nie są już zrzucane na stos.

### Poprawka c: Eliminacja Sprzętowego Dzielenia `IDIVQ`
- **Wdrożenie:** Prekomputacja rozmiarów podzbiorów cząstek `EChunkSize` i `IChunkSize` w metodzie `UpdateChunkSizes()`.
- **Wynik w asemblerze:** Całkowite wyeliminowanie instrukcji `IDIVQ` (kosztującej ~35–45 cykli zegara) z gorących pętli workerów. Granice wyznaczane są w 1 instrukcji `IMULQ` i 1 `ADDQ`.

### Poprawka d: Sekwencyjny Streaming w Redukcji Siatki Ładunku
- **Wdrożenie:** Przestawienie pętli w `Step1ComputeElectronDensity` i `Step1ComputeIonDensity` na sekwencyjny odczyt po węzłach $p$ dla kolejnych workerów.
- **Wynik w asemblerze:** Wyeliminowano instrukcję `IMULQ $0xc80` z pętli wewnętrznej. Wskaźnik bufora danego workera pobierany jest raz przed pętlą, a odczyt po węzłach siatki odbywa się ze stałym krokiem +8 bajtów, co pozwala jednostce sprzętowej *Hardware Stream Prefetcher* procesora na automatyczne ładowanie danych do L1.

---

## 4. Ostatnia Kluczowa Rezerwa Wydajnościowa: SIMD AVX2

Jedyną pozostałą dużą rezerwą jest **ręczna wektoryzacja SIMD (AVX2)**:
- Obecny kod wykonuje obliczenia na rejestrach skalarnych 64-bitowych (`MOVSD`, `VFMADD231SD`).
- Wpięcie procedury asemblerowej z rejestrami 256-bitowymi `YMM` (`VGATHERDPD`, `VFMADD231PD`) pozwala przetwarzać **4 cząstki w jednym cyklu zegara**, co według pomiarów w `scratch/avx2_test` daje kolejne **`3.84x` przyspieszenia samego kroku pchania cząstek**.
