# Raport z analizy asemblera kodów sekwencyjnych C++ i Go (AMD Zen 4, `znver4` / `GOAMD64=v4`)

## 1. Wprowadzenie i środowisko kompilacji

Niniejszy raport przedstawia dogłębną analizę porównawczą kodu maszynowego wygenerowanego dla bazowych, **sekwencyjnych** implementacji symulatora kinetycznego plazmy wyładowań wcz.:
- **C++ sekwencyjny:** [`C/sequential/eduPIC.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/C/sequential/eduPIC.cc)
- **Go sekwencyjny:** [`Go/native_version`](file:///C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version)

Oba programy zostały skompilowane dla mikroarchitektury **AMD Zen 4 (EPYC 9554)** z pełnym zestawem wektorowym AVX-512, FMA3 i BMI2:

| Parametr | C++ (GCC 13.3) | Go (1.24+) |
|---|---|---|
| **Ścieżka źródłowa** | `C/sequential/` | `Go/native_version/` |
| **Flagi kompilacji** | `-std=c++17 -O3 -march=znver4 -DUSE_NULL_COLLISION -ffunction-sections -fno-inline -fverbose-asm` | `GOOS=linux GOARCH=amd64 GOAMD64=v4 -tags nullcollision` |
| **Profil wektorowy** | AVX-512F, AVX-512DQ, AVX-512BW, AVX-512VL, FMA3 | AVX-512F, AVX-512DQ, AVX-512BW, AVX-512VL, FMA3 |
| **Zderzenia MCC** | Null-Collision method (`USE_NULL_COLLISION`) | Null-Collision method (`-tags nullcollision`) |
| **Tryb wykonania** | 1 wątek (Single-Threaded / Sequential) | 1 wątek (Single-Threaded / Sequential) |

---

## 2. Struktura katalogu i wygenerowane pliki asemblera

Wszystkie wyizolowane pliki asemblera znajdują się w dedykowanych podkatalogach:
- **C++:** [`docs/assembly_analysis/sequential/C/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/)
- **Go:** [`docs/assembly_analysis/sequential/Go/`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/)

| Krok algorytmu / Funkcja | Asembler C++ (`sequential/C/`) | Asembler Go (`sequential/Go/`) | Kluczowe różnice w asemblerze |
|---|---|---|---|
| **Krok 1: Depozycja gęstości (CIC)** | [`step1_density.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/step1_density.s) | [`step1_density.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/step1_density.s) | C++: 128-bit `vunpcklpd` + `vfmadd213pd` (depozycja 2 węzłów w 1 instrukcji) oraz AVX-512 (`zmm`) w akumulacji. Go: 2x operacje skalarne z testami granic tablicy (BCE). |
| **Krok 2: Solver Poissona (Thomas)** | [`solve_poisson.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/solve_poisson.s) | [`solve_poisson.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/solve_poisson.s) | C++: wektorowe obliczanie ładunku $f[i]$ przez `%zmm1`. Go: alokacja 9.6 KB na stosie i 3x `REP STOSQ` co krok czasowy; obydwa kody wykonują sprzętowe dzielenia `DIVSD`. |
| **Krok 3: Popychanie elektronów** | [`step3_move_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/step3_move_electrons.s) | [`step3_push_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/step3_push_electrons.s) | C++: Loop Unswitching (warunek diagnostyki poza pętlą), 3 sprzętowe instrukcje FMA, zero BCE. Go: sprawdzanie flagi wewnątrz pętli, przeładowywanie 10 stałych co iterację, 3x BCE. |
| **Krok 4: Popychanie jonów** | [`step4_move_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/step4_move_ions.s) | [`step4_push_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/step4_push_ions.s) | C++: sprzętowe FMA, rejestrowa obsługa subcyclingu. Go: skalarne mnożenia i dodawania, testy granic. |
| **Krok 5: Granice elektronów** | [`step5_check_boundaries_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/step5_check_boundaries_electrons.s) | [`step5_boundaries_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/step5_boundaries_electrons.s) | C++: Loop Store Motion (LSM) — liczniki i $N_e$ trzymane w rejestrach `%ecx, %rbx, %r11`. Go: bezpośrednie zapisy do pamięci i 4 testy granic na swap. |
| **Krok 6: Granice jonów & IFED** | [`step6_check_boundaries_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/step6_check_boundaries_ions.s) | [`step6_boundaries_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/step6_boundaries_ions.s) | C++: rejestrowa akumulacja energii jonów, zero BCE. Go: skalarne testy warunków brzegowych. |
| **Krok 7: Zderzenia elektronów** | [`step7_collisions_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/step7_collisions_electrons.s) | [`step7_collisions_electrons.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/step7_collisions_electrons.s) | C++: statyczny bufor `pool` (`static std::vector<int>`) alokowany raz na start. Go: alokacja 1.2 MB na stercie w KAŻDYM kroku (`runtime.makeslice`), co daje 4.8 GB śmieci na cyklu! |
| **Krok 8: Zderzenia jonów** | [`step8_collision_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/step8_collision_ions.s) | [`step8_collision_ions.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/step8_collision_ions.s) | C++: zderzenia jonów z subcyclingiem i statycznym buforem losowania. Go: dynamiczny bufor i wywołania `makeslice`. |
| **Kolizje elektronów (MCC)** | [`collision_electron.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/collision_electron.s) | [`collision_electron.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/collision_electron.s) | **Wersje bazowe**: obydwa kody wywołują funkcje trygonometryczne (`sincos`, `atan2`, `acos` w C++ libc; `math.sin`, `math.cos`, `math.atan2` w Go). |
| **Kolizje jonów (MCC)** | [`collision_ion.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/collision_ion.s) | [`collision_ion.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/collision_ion.s) | Obsługa wymiany ładunku i zderzeń sprężystych; w wersjach sekwencyjnych brak branchless fast-path. |
| **Pętla główna cyklu** | [`do_one_cycle.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/do_one_cycle.s) | [`do_one_cycle.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/do_one_cycle.s) | Pętla 4000 kroków czasowych: sekwencja wywołań poszczególnych procedur `CALL`. |
| **Inicjalizacja cząstek** | [`init.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/C/init.s) | [`init.s`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/sequential/Go/init.s) | Losowanie cząstek początkowych w domenie $[0, L]$. |

---

## 3. Szczegółowa analiza asemblera poszczególnych kroków

### 3.1. Krok 1: Depozycja gęstości ładunku (CIC)

W metodzie *Cloud-in-Cell* ładunek każdej cząstki jest rozdzielany na dwa sąsiednie węzły siatki $p$ oraz $p+1$ z wagami $(p + 1 - c_0)$ oraz $(c_0 - p)$.

#### C++ (`step1_density.s`, linie 40–54):
GCC zauważył, że `e_density[p]` oraz `e_density[p+1]` leżą bezpośrednio obok siebie w pamięci (odstęp 8 bajtów):
```assembly
vmulsd      (%rax), %xmm5, %xmm1        # c0 = x_e[k] * INV_DX
vcvttsd2sil %xmm1, %edx                 # p = int(c0)
movslq      %edx, %rcx                  # indeks p
leal        1(%rdx), %esi               # indeks p + 1
leaq        (%rdi,%rcx,8), %rcx         # adres &e_density[p]
addq        $8, %rax                    # kolejny elektron x_e[k+1]
vcvtsi2sdl  %esi, %xmm3, %xmm0          # (double)(p + 1)
vcvtsi2sdl  %edx, %xmm3, %xmm2          # (double)p
vsubsd      %xmm1, %xmm0, %xmm0         # waga0 = p + 1 - c0
vsubsd      %xmm2, %xmm1, %xmm1         # waga1 = c0 - p
vunpcklpd   %xmm1, %xmm0, %xmm0         # Złożenie wag [waga0, waga1] w rejestr wektorowy 128-bit!
vfmadd213pd (%rcx), %xmm4, %xmm0        # Wektorowe FMA: [waga0, waga1] * FACTOR_W + [rho[p], rho[p+1]]!
vmovupd     %xmm0, (%rcx)               # ZAPIS OBU WĘZŁÓW W JEDNEJ INSTRUKCJI WEKTOROWEJ!
```
Dodatkowo pętla sumowania `cumul_e_density[p] += e_density[p]` została w C++ zwektoryzowana za pomocą rejestrów **AVX-512 (`%zmm6`)**:
```assembly
vmovupd     (%rdx), %zmm6               # Odczyt 8 elementów double naraz (512 bitów)
vaddpd      (%rax), %zmm6, %zmm0        # Wektorowe dodawanie 8 punktów siatki
vmovupd     %zmm0, -64(%rax)            # Zapis wektorowy
```

#### Go sekwencyjny (`step1_density.s`, linie 19–54):
Kompilator Go generuje kod w 100% skalarny z osobnym odczytem i zapisem dla każdego węzła oraz testami granic:
```assembly
# Depozycja węzła p:
CMPQ    DX, $0x190                      # Test granicy: czy p < 400?
JAE     panicBounds
...
MULSD   X4, X3                          # (p + 1 - c0) * FACTOR_W
ADDSD   0x7272710(AX)(DX*8), X3         # e_density[p] += ...
MOVSD_XMM X3, 0x7272710(AX)(DX*8)

# Depozycja węzła p+1:
LEAQ    0x1(DX), BX
CMPQ    BX, $0x190                      # Test granicy: czy p+1 < 400?
JAE     panicBounds
SUBSD   X2, X0
MULSD   X4, X0
ADDSD   0x7272718(AX)(DX*8), X0         # e_density[p+1] += ...
MOVSD_XMM X0, 0x7272718(AX)(DX*8)
```

---

### 3.2. Krok 2: Solver równania Poissona

Obydwie wersje sekwencyjne rozwiązują jednowymiarowe równanie Poissona algorytmem Thomasa dla macierzy trójprzekątnej.

#### C++ (`solve_poisson.s`, linie 47–94):
Przeliczenie gęstości ładunku $f[i] = alpha \cdot 
ho[i]$ jest w pełni zwektoryzowane instrukcją AVX-512:
```assembly
.L150:
vmulpd      (%rbx,%rax), %zmm1, %zmm0   # 8 liczb double przemnażanych jednocześnie!
vmovupd     %zmm0, (%rsi,%rax)          # Zapis 64 bajtów w jednym cyklu
addq        $64, %rax
cmpq        $3144, %rax
jne         .L150
```
Następnie algorytm Thomasa wykonuje sprzętowe dzielenia `vdivsd %xmm1, %xmm4, %xmm6` (ponieważ w wersji bazowej współczynniki $w_i$ nie były prekomputowane).

#### Go sekwencyjny (`solve_poisson.s`, linie 60–135):
1. **Ogromny narzut na czyszczenie stosu:**
   Na początku funkcji Go rezerwuje **9608 bajtów** na ramkę stosu (`SUBQ $0x2588, SP`) i zeruje tablice pomocnicze $g, w, f$ trzema kolejnymi instrukcjami `REP; STOSQ`:
   ```assembly
   0x4bad64   f348ab    REP; STOSQ AX, ES:0(DI)   # Zerowanie tablicy g (3200 bajtów)
   0x4bad71   f348ab    REP; STOSQ AX, ES:0(DI)   # Zerowanie tablicy w (3200 bajtów)
   0x4bad81   f348ab    REP; STOSQ AX, ES:0(DI)   # Zerowanie tablicy f (3200 bajtów)
   ```
   W każdym z 4000 kroków czasowych procesor zeruje w pamięci stosu **9.6 KB** (co daje niemal **40 MB niepotrzebnych zapisów do cache L1 na cykl RF**).
2. **Dzielenia zmiennoprzecinkowe w pętli:**
   ```assembly
   0x4bae6d   f20f5ec1  DIVSD X1, X0              # w[i] = C / (B - A*w[i-1])
   0x4bae9a   f20f5ec2  DIVSD X2, X0              # g[i] = (f[i] - A*g[i-1]) / (...)
   ```
   Dwie instrukcje `DIVSD` (o latencji 14–16 cykli każda) blokują potok wykonawczy procesora.

---

### 3.3. Krok 3: Popychanie cząstek (Leap-Frog)

Krok 3 odpowiada za interpolację pola elektrycznego, aktualizację prędkości oraz pozycji cząstek.

#### C++ (`step3_move_electrons.s`, linie 38–87):
Kompilator GCC zastosował optymalizację **Loop Unswitching**. Flaga `measurement_mode` jest sprawdzana **przed pętlą**:
```assembly
cmpb    $0, measurement_mode(%rip)
jne     .L190                               # Skok do rzadkiej pętli diagnostycznej
```
Główna pętla obliczeniowa (Fast-Path, `.L191`) liczy zaledwie **20 instrukcji**, nie zawiera żadnych skoków warunkowych ani testów granic tablic i łączy wszystkie operacje w **3 sprzętowe instrukcje FMA**:
```assembly
.L191:
vmovsd          (%rdx), %xmm3               # x_e[k]
vmulsd          %xmm7, %xmm3, %xmm1         # c0 = x_e[k] * INV_DX
vcvttsd2sil     %xmm1, %eax                 # p = int(c0)
vcvtsi2sdl      %eax, %xmm8, %xmm2          # (double)p
vaddsd          %xmm6, %xmm2, %xmm0
vsubsd          %xmm1, %xmm0, %xmm0         # c1
vsubsd          %xmm2, %xmm1, %xmm1         # c2
vmulsd          (%r15,%rax,8), %xmm1, %xmm1 # c2 * efield[p+1]
vfmadd132sd     (%r15,%rsi,8), %xmm1, %xmm0 # FMA 1: e_x = c1 * efield[p] + c2 * efield[p+1]
vfnmadd213sd    -8(%rcx), %xmm5, %xmm0      # FMA 2: vx_e -= e_x * FACTOR_E
vmovsd          %xmm0, -8(%rcx)             # Zapis nowej prędkości
vfmadd132sd     %xmm4, %xmm3, %xmm0         # FMA 3: x_e += vx_e * DT_E
vmovsd          %xmm0, -8(%rdx)             # Zapis nowej pozycji
cmpq            %rdx, %rdi
jne             .L191
```

#### Go sekwencyjny (`step3_push_electrons.s`):
1. **Brak Loop Unswitching:** Flaga `sim.Measurement_mode` jest sprawdzana **wewnątrz pętli dla każdej cząstki**:
   ```assembly
   0x4bbbca   CMPB 0x7ba20a0(AX), $0x0
   0x4bbbd1   JE   0x4bbe55
   ```
2. **Przeładowywanie stałych co iterację:** Gdy `Measurement_mode == false`, kod skacze pod adres `0x4bbe55`, gdzie **w każdej iteracji pętli przeładowuje z pamięci podręcznej 10 stałych zmiennoprzecinkowych do rejestrów XMM**, a następnie skacze z powrotem `JMP 0x4bbb08`!
3. **Potrójny test granic (BCE):**
   - `CMPQ CX, $0xf4240; JAE panicBounds` (sprawdzenie indeksu $k$ w tablicy cząstek),
   - `CMPQ DX, $0x190; JAE panicBounds` (sprawdzenie węzła $p$ w `Efield`),
   - `CMPQ SI, $0x190; JAE panicBounds` (sprawdzenie węzła $p+1$ w `Efield`).
4. **Brak pełnej fuzji FMA:** Zamiast potrójnego FMA Go wykonuje sekwencję `MULSD` + `SUBSD` dla prędkości i tylko jedno `VFMADD231SD` dla pozycji.

---

### 3.4. Krok 5: Warunki brzegowe elektronów

W wersji sekwencyjnej cząstka wylatująca poza obszar wyładowania jest usuwana poprzez zastąpienie jej ostatnią cząstką z tablicy: $x_e[k] = x_e[N_e - 1], \dots, N_e--$.

#### C++ (`step5_check_boundaries_electrons.s`):
Kompilator zastosował **Loop Store Motion (LSM)**:
- Liczniki zaabsorbowanych elektronów `N_e_abs_pow` i `N_e_abs_gnd` oraz globalna liczba cząstek `N_e` zostały podniesione do rejestrów `%rbx`, `%r11` oraz `%ecx`.
- Podczas usuwania cząstki GCC modyfikuje wyłącznie rejestry procesora.
- Do pamięci RAM nowe wartości `N_e` i liczników brzegowych są zapisywane **dokładnie raz — po zakończeniu całej pętli**:
  ```assembly
  movl  %ecx, N_e(%rip)
  movq  %r11, N_e_abs_gnd(%rip)
  movq  %rbx, N_e_abs_pow(%rip)
  ```
- Podczas podmiany cząstki brak jakichkolwiek testów granic (czyste instrukcje `vmovsd`).

#### Go sekwencyjny (`step5_boundaries_electrons.s`):
1. Każde pochłonięcie cząstki modyfikuje zmienną w strukturze w pamięci:
   ```assembly
   0x4bc1bf   INCQ 0x7275910(AX)        # Modyfikacja sim.N_e_abs_pow w pamięci
   0x4bc2bb   DECQ 0x3567e00(AX)        # Dekrementacja sim.N_e w pamięci
   ```
2. Każda zamiana generuje **4 sprawdzenia granic tablic** (dla $X_e, Vx_e, Vy_e, Vz_e$).
3. Warunek `sim.X_e[k] < 0` jest ewaluowany dwukrotnie przez brak eliminacji wspólnych podwyrażeń.

---

### 3.5. Krok 7: Kolizje elektronów (Metoda Null-Collision)

W metodzie Null-Collision najpierw losuje się liczbę potencjalnych kolizji, a następnie bez powtórzeń wybiera się kandydatów do zderzenia za pomocą algorytmu Fishera-Yatesa (`random_sample`).

#### Kluczowa patologia wydajnościowa w Go sekwencyjnym (`step7_collisions_electrons.s`):
W implementacji `Go/native_version/simulation_null.go` procedura losowania próby bez zwracania wygląda następująco:
```go
func (sim *SimulationState) randomSample(n, count int) []int {
    pool := make([]int, n)
    for i := range pool {
        pool[i] = i
    }
    for i := 0; i < count; i++ {
        j := i + sim.Rng.Intn(n-i)
        pool[i], pool[j] = pool[j], pool[i]
    }
    return pool[:count]
}
```
W asemblerze (`step7_collisions_electrons.s`, linie 368–381) odpowiada temu:
```assembly
0x4bcee8   MOVQ BX, CX
0x4bceeb   CALL runtime.makeslice(SB)   # Dynamiczna alokacja tablicy na stercie!
0x4bcef0   XORL DX, DX
...
0x4bcef9   MOVQ DX, 0(AX)(DX*8)        # Inicjalizacja n elementów: pool[i] = i
```
- Przy $N_e approx 150\,000$ cząstek, `make([]int, n)` alokuje **1.2 MB pamięci na stercie w każdym kroku czasowym**!
- W jednym cyklu RF (4000 kroków) funkcja ta alokuje:
  $$4000 	imes 1.2	ext{ MB} approx \mathbf{4.8	ext{ GB pamięci śmieci na cykl!}}$$
- W 100 cyklach wygenerowane zostaje prawie **0.5 TB alokacji**, co powoduje gigantyczne obciążenie odśmiecacza pamięci (Go Garbage Collector) i spadek IPC.

#### Rozwiązanie w C++ sekwencyjnym (`step7_collisions_electrons.s` i `eduPIC_seq.s:9948`):
W C++ bufor indeksów jest zadeklarowany jako zmienna statyczna:
```cpp
static std::vector<int> pool;
if (pool.size() < (size_t)n) pool.resize(n);
```
W asemblerze C++:
```assembly
movzbl  _ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %eax # Czy zainicjalizowano
...
cmpq    %rbx, %rax                      # pool.size() < n ?
jb      .L758                           # Jeśli nie, brak jakiejkolwiek alokacji!
```
Bufor jest alokowany **dokładnie raz** na początku symulacji i zerokrotnie w kolejnych krokach, całkowicie eliminując alokacje dynamiczne na stercie.

---

### 3.6. Ciało zderzeń cząstek (MCC): `collision_electron.s`

Zarówno w sekwencyjnym C++ (`C/sequential/collisions.h`), jak i w sekwencyjnym Go (`Go/native_version/collisions.go`):
- Obydwa kody są **wersjami bazowymi przed optymalizacją wektorową**.
- Obydwa kody wyznaczają kąty rozproszenia w układzie sferycznym i obracają wektory prędkości za pomocą bibliotecznych funkcji trygonometrycznych:

```assembly
# C++ sequential (docs/assembly_analysis/sequential/C/collision_electron.s):
call    sincos@PLT                      # Wywołanie GNU libc sincos
call    acos@PLT                        # Wywołanie GNU libc acos
call    atan@PLT                        # Wywołanie GNU libc atan
call    atan2@PLT                       # Wywołanie GNU libc atan2

# Go sequential (docs/assembly_analysis/sequential/Go/collision_electron.s):
CALL    math.atan2(SB)                  # Wywołanie pakietu math Go
CALL    math.sin(SB)
CALL    math.cos(SB)
```
Dopiero w wersji zoptymalizowanej `Go/parallel_chunking` oraz `C/parallel_omp` kąty sferyczne i biblioteki matematyczne zostały zastąpione czystą algebrą iloczynów wektorowych i instrukcjami `sqrtsd`.

---

## 4. Wnioski wydajnościowe: Skąd wynika różnica 115 s (C++) vs 295 s (Go)?

Porównanie kodu maszynowego jednoznacznie wyjaśnia, dlaczego na 1 rdzeniu HPC wersja bazowa C++ wykonuje 100 cykli w **ok. 115–125 s**, podczas gdy wersja sekwencyjna Go potrzebuje **ok. 293–295 s**:

1. **Alokacja 4.8 GB/cykl w Step 7 Go:**
   Ciągłe wywołania `runtime.makeslice` w `randomSample` generują potężne narzuty alokatora i cykliczne wstrzymywanie potoku przez GC (`runtime.gcDrain` / `runtime.bgsweep`). W C++ `static pool` nie alokuje nic.
2. **Krok 3 (Leap-Frog) — 3x FMA i Loop Unswitching:**
   W C++ pętla popychania to zaledwie 20 instrukcji z 3 sprzętowymi FMA i zerem testów brzegowych. W Go to ciągłe przeładowywanie 10 stałych z pamięci, sprawdzanie flagi `Measurement_mode` i 3 testy granic tablic na cząstkę.
3. **Krok 1 (CIC) — Wektorowe 128-bitowe `vfmadd213pd`:**
   C++ zapisuje gęstość w obu sąsiednich węzłach w jednej wektorowej instrukcji i sumuje siatkę 512-bitowymi rejestrami AVX-512 (`zmm`). Go wykonuje operacje ściśle skalarne.
4. **Krok 2 (Poisson) — Alokacja 9.6 KB i `REP STOSQ` co krok:**
   Go w każdym podkroku czasowym czyści na stosie tablice $g, w, f$ trzema wywołaniami `REP STOSQ`, podczas gdy C++ utrzymuje lokalne bufory bez wielokrotnego zerowania.

---

## 5. Zestawienie z optymalizacjami równoległymi (`parallel_chunking`)

Analiza kodu asemblera wersji sekwencyjnej potwierdza trafność zmian wprowadzonych w `parallel_chunking`:
- **Prealokacja buforów losowania (Step 7/8):** Eliminacja `makeslice` zredukowała czas 1 rdzenia z 295 s do 208 s.
- **Unrolling i BCE (Step 3/4):** 4-krotne rozwinięcie i usunięcie `panicBounds` podniosło IPC z 3.1 do 4.4.
- **Wstępne tablicowanie Thomasa (Step 2):** Eliminacja dzieleń zmiennoprzecinkowych `DIVSD`.
- **Dalszy krok (Równoległość):** Zastąpienie dynamicznego `sync.WaitGroup` trwałymi wątkami roboczymi (Worker Pools) w celu zlikwidowania narzutów `SYS_futex`, analogicznie do trwałego regionu OpenMP w C++.
