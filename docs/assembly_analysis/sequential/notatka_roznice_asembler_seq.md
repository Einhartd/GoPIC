# Przewodnik techniczny: Dlaczego sekwencyjny Go jest wolniejszy od C++?
## Analiza kodu maszynowego AMD Zen 4 (`znver4` / `GOAMD64=v4`)

Niniejszy dokument przedstawia techniczne porównanie kodu maszynowego wygenerowanego dla bazowych wersji sekwencyjnych:
- **C++:** [`C/sequential/`](./C/) (kompilator GCC 13.3, `-O3 -march=znver4`)
- **Go:** [`Go/native_version/`](./Go/) (kompilator Go 1.24+, `GOAMD64=v4 -tags nullcollision`)

Wyjaśnia on, dlaczego bazowy kod w **Go** wykonuje 100 cykli symulacji w **~295 s**, podczas gdy kod w **C++** wykonuje dokładnie to samo zadanie w **~115 s** (przewaga ~2.5x na 1 rdzeniu HPC).

---

## 1. Słowniczek pojęć niskopoziomowych

1. **Rejestry procesora vs Pamięć RAM:**
   - **Rejestry** (np. `%rax`, `%xmm0`, `%zmm1`) to najszybsze komórki pamięci wbudowane w rdzeń CPU (dostęp w < 1 ns).
   - **RAM / Stos** to pamięć zewnętrzna. Każdy odczyt/zapis pamięci wymaga przejścia przez hierarchię cache i jest wielokrotnie wolniejszy niż operacja na rejestrach.
2. **FMA (Fused Multiply-Add):**
   - Instrukcja sprzętowa wykonująca operację $a \cdot b + c$ **w jednym cyklu zegara** (np. `vfmadd132sd`). Brak FMA zmusza procesor do osobnego mnożenia i dodawania (2 cykle).
3. **SIMD / Wektoryzacja (Single Instruction, Multiple Data):**
   - Równoległe przetwarzanie wielu liczb w jednym szerokim rejestrze: 128-bit (`%xmm`, 2x double), 256-bit (`%ymm`, 4x double) lub 512-bit AVX-512 (`%zmm`, 8x double).
4. **BCE (Bounds Check Elimination):**
   - W Go każde odwołanie `tablica[i]` domyślnie generuje instrukcje sprawdzające, czy indeks mieści się w granicach tablicy. W razie przekroczenia wywoływana jest funkcja `runtime.panicBounds`. W C++ takie testy nie występują.
5. **Garbage Collector (GC):**
   - Mechanizm automatycznego odśmiecania pamięci w Go. Ciągłe alokowanie pamięci wewnątrz pętli czasowej wymusza cykliczne wstrzymywanie potoku obliczeniowego (`runtime.gcDrain`).

---

## 2. Pięć kluczowych różnic implementacyjnych i asemblerowych

---

### RÓŻNICA 1: Dynamiczna alokacja pamięci na stercie w metodzie Null-Collision (Krok 7)
📁 **Pliki:** [`C/step7_collisions_electrons.s`](./C/step7_collisions_electrons.s) vs [`Go/step7_collisions_electrons.s`](./Go/step7_collisions_electrons.s)

#### A. Pseudokod operacji (Algorytm Fishera-Yatesa):
```c
// Cel: wylosuj N_coll unikalnych cząstek z puli N_e elementów do zderzenia
funkcja random_sample(n, count):
    // C++: bufor 'pool' zadeklarowany jako 'static' - alokowany tylko raz na starcie
    // Go:  'pool := make([]int, n)' - alokacja nowej tablicy 1.2 MB w KAŻDYM wywołaniu!
    dla i od 0 do n-1:
        pool[i] = i
    dla i od 0 do count-1:
        j = i + losuj_zakres(n - i)
        zamień(pool[i], pool[j])
    zwróć pool[0 .. count-1]
```

#### B. Co robi kompilator C++ vs Go?
- **C++:** Bufor `static std::vector<int> pool` jest tworzony raz. W kolejnych krokach funkcja sprawdza tylko, czy bufor istnieje i ponownie używa tej samej pamięci. **Narzut alokacji: 0 bajtów.**
- **Go:** Instrukcja `make([]int, n)` w każdym z 4000 kroków czasowych wywołuje alokator sterty `runtime.makeslice`.

#### C. Porównanie asemblera:
```assembly
# --- Go (Go/step7_collisions_electrons.s) ---
0x4bcee8   MOVQ  BX, CX
0x4bceeb   CALL  runtime.makeslice(SB)     # <-- BŁĄD: Alokacja 1.2 MB na stercie w KAŻDYM kroku!
0x4bcef0   XORL  DX, DX
0x4bcef9   MOVQ  DX, 0(AX)(DX*8)          # Pętla: pool[i] = i (150 000 zapisów do RAM)

# --- C++ (C/step7_collisions_electrons.s) ---
movzbl  _ZGVZ13random_sample...pool(%rip), %eax
testb   %al, %al
je      .L757                             # Alokacja TYLKO RAZ przy starcie programu!
.L745:
cmpq    %rbx, %rax                        # Czy rozmiar pool >= n?
jb      .L758                             # Jeśli tak -> BRAK ALOKACJI, praca na istniejącej pamięci!
```
* **Skutek wydajnościowy:** Go alokuje **4.8 GB zbędnej pamięci na każdy cykl RF** (niemal 0.5 TB w 100 cyklach!). Garbage Collector bez przerwy zatrzymuje wątek, by sprzątać pamięć.

---

### RÓŻNICA 2: Brak optymalizacji Loop Unswitching i redundancja rejestrów w Leap-Frog (Krok 3)
📁 **Pliki:** [`C/step3_move_electrons.s`](./C/step3_move_electrons.s) vs [`Go/step3_push_electrons.s`](./Go/step3_push_electrons.s)

#### A. Pseudokod operacji:
```c
// Cel: interpolacja pola E oraz aktualizacja prędkości i pozycji 150 000 elektronów
dla każdego k od 0 do N_e-1:
    p = int(x_e[k] * INV_DX)
    E_x = c1 * Efield[p] + c2 * Efield[p+1]
    
    // Niezmiennik pętli (flaga pomiarowa wyłączona przez 99% symulacji):
    jeśli (measurement_mode == prawda):
        oblicz_diagnostyki_i_eepf(k, E_x)
        
    vx_e[k] = vx_e[k] - E_x * FACTOR_E
    x_e[k]  = x_e[k]  + vx_e[k] * DT_E
```

#### B. Co robi kompilator C++ vs Go?
- **C++ (Loop Unswitching):** GCC widzi, że flaga `measurement_mode` nie zmienia się w pętli. Sklonował pętlę na dwie wersje: rzadką diagnostyczną oraz ultra-szybką Fast-Path (20 instrukcji, stałe fizyczne na stałe w rejestrach, 3x FMA).
- **Go:** Kompilator Go sprawdza flagę przy każdym elektronie. W ścieżce bez pomiarów skacze do bloku `0x4bbe55`, który **w każdej iteracji odczytuje z pamięci 10 tych samych stałych fizycznych do rejestrów XMM**.

#### C. Porównanie asemblera:
```assembly
# --- Go (Go/step3_push_electrons.s) ---
# 1. Pytanie o flagę przy KAŻDEJ cząstce (150 000 razy na krok):
0x4bbbca   CMPB  0x7ba20a0(AX), $0x0        # Czy sim.Measurement_mode != 0?
0x4bbbd1   JE    0x4bbe55                   # Jeśli false -> skocz do bloku przeładowania stałych

# 2. Blok 0x4bbe55: Przeładowywanie 10 stałych z RAM w KAŻDEJ iteracji pętli!
0x4bbe55   MOVSD_XMM $f64.3fa999999999999a(SB), X0   # Odczyt stałej 1 z pamięci
0x4bbe5d   MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3   # Odczyt stałej 2 z pamięci
... (odczyt kolejnych 8 stałych)...
0x4bbea0   MOVSD_XMM $f64.3ff0000000000000(SB), X13  # Odczyt stałej 10 z pamięci
0x4bbea9   JMP   0x4bbb08                   # Skocz z powrotem do pętli!

# 3. Testy granic tablicy (BCE) przy każdym elektronie:
0x4bbb4e   CMPQ  CX, $0xf4240; JAE panicBounds   # Indeks k w X_e
0x4bbb91   CMPQ  DX, $0x190;   JAE panicBounds   # Indeks p w Efield

# --- C++ (C/step3_move_electrons.s) ---
# Warunek sprawdzony RAZ przed wejściem do pętli:
cmpb    $0, measurement_mode(%rip)
jne     .L190                               # Skok do wersji pomiarowej tylko w razie potrzeby

# Czysta pętla Fast-Path (.L191) - stałe fizyczne trzymane na stałe w rejestrach CPU:
.L191:
    vmovsd      (%rdx), %xmm3               # Pobierz x_e[k]
    vmulsd      %xmm7, %xmm3, %xmm1         # c0 = x_e[k] * INV_DX (stała w xmm7)
    vcvttsd2sil %xmm1, %eax                 # p = int(c0)
    ...
    vfmadd132sd (%r15,%rsi,8), %xmm1, %xmm0 # FMA 1: E_x = c1*E[p] + c2*E[p+1] (1 cykl)
    vfnmadd213sd -8(%rcx), %xmm5, %xmm0     # FMA 2: vx = vx - E_x * factor     (1 cykl)
    vmovsd      %xmm0, -8(%rcx)             # Zapis vx
    vfmadd132sd %xmm4, %xmm3, %xmm0         # FMA 3: x = x + vx * dt            (1 cykl)
    vmovsd      %xmm0, -8(%rdx)             # Zapis x
    cmpq        %rdx, %rdi
    jne         .L191                       # ZERO zbędnych skoków i odczytów stałych z RAM!
```
* **Skutek wydajnościowy:** Pętla w C++ wykonuje się z maksymalną przepustowością potoku wykonawczego, podczas gdy Go traci cykle na skoki, sprawdzanie granic i nieustanne odczytywanie stałych z RAM.

---

### RÓŻNICA 3: Brak automatycznej wektoryzacji SIMD w depozycji ładunku CIC (Krok 1)
📁 **Pliki:** [`C/step1_density.s`](./C/step1_density.s) vs [`Go/step1_density.s`](./Go/step1_density.s)

#### A. Pseudokod operacji:
```c
// Cel: rozdzielenie ładunku cząstki na dwa sąsiednie węzły siatki (p oraz p+1)
dla każdego k od 0 do N_e-1:
    p = int(x_e[k] * INV_DX)
    waga_lewa  = (p + 1.0 - c0) * FACTOR_W
    waga_prawa = (c0 - p) * FACTOR_W
    
    // Zauważ: węzeł p i p+1 leżą bezpośrednio obok siebie w pamięci (odstęp 8 bajtów):
    e_density[p]   = e_density[p]   + waga_lewa
    e_density[p+1] = e_density[p+1] + waga_prawa
```

#### B. Co robi kompilator C++ vs Go?
- **C++ (SIMD):** GCC połączył wagi w 128-bitowy wektor i zaktualizował **oba węzły jednocześnie jedną instrukcją wektorową** `vfmadd213pd`. Dodatkowo sumowanie siatki zwektoryzował 512-bitowymi rejestrami AVX-512 (`%zmm`).
- **Go:** Kompilator Go nie ma autowektoryzatora. Wykonuje wszystko ściśle skalarne — osobno węzeł $p$, osobno $p+1$, z testami granic tablicy.

#### C. Porównanie asemblera:
```assembly
# --- Go (Go/step1_density.s) ---
# Węzeł p (skalarnie):
CMPQ    DX, $0x190; JAE panicBounds         # Test granicy dla p
MULSD   X4, X3                              # Mnożenie skalarne
ADDSD   0x7272710(AX)(DX*8), X3             # Dodanie do węzła p
MOVSD_XMM X3, 0x7272710(AX)(DX*8)           # Zapis węzła p

# Węzeł p+1 (skalarnie):
CMPQ    BX, $0x190; JAE panicBounds         # Test granicy dla p+1
MULSD   X4, X0                              # Mnożenie skalarne
ADDSD   0x7272718(AX)(DX*8), X0             # Dodanie do węzła p+1
MOVSD_XMM X0, 0x7272718(AX)(DX*8)           # Zapis węzła p+1

# --- C++ (C/step1_density.s) ---
vunpcklpd   %xmm1, %xmm0, %xmm0     # Połącz [waga_p, waga_p+1] w rejestr wektorowy 128-bit
vfmadd213pd (%rcx), %xmm4, %xmm0    # WEKTOROWE FMA: przemnóż i dodaj OBA węzły naraz!
vmovupd     %xmm0, (%rcx)           # JEDEN zapis 16 bajtów aktualizujący OBA węzły w 1 cyklu!

# Sumowanie gęstości w AVX-512 (8 punktów siatki jednocześnie):
vmovupd     (%rdx), %zmm6           # Pobierz 8 węzłów siatki naraz
vaddpd      (%rax), %zmm6, %zmm0    # Dodaj 8 węzłów naraz
vmovupd     %zmm0, -64(%rax)        # Zapisz 8 węzłów naraz
```
* **Skutek wydajnościowy:** C++ wykonuje operację depozycji i redukcji gęstości w wielokrotnie mniejszej liczbie cykli zegara.

---

### RÓŻNICA 4: Wymuszone zerowanie pamięci stosu (Zero-Value Guarantee) w solverze Poissona (Krok 2)
📁 **Pliki:** [`C/solve_poisson.s`](./C/solve_poisson.s) vs [`Go/solve_poisson.s`](./Go/solve_poisson.s)

#### A. Pseudokod operacji:
```c
// Cel: rozwiązanie równania Poissona metodą Thomasa
funkcja SolvePoisson(rho):
    tablica g[400]
    tablica w[400]
    tablica f[400]
    
    // W Go: specyfikacja WYMUSZA wyzerowanie tych tablic (9.6 KB) przed użyciem!
    // W C++: pamięć nie jest czyszczona; algorytm od razu nadpisuje dane:
    dla i od 1 do N_G-2:
        f[i] = ALPHA * rho[i]
```

#### B. Co robi kompilator C++ vs Go?
- **C++:** Rezerwuje ramkę stosu instrukcją `subq`, ale nie wykonuje żadnego zerowania. Dane są od razu nadpisywane wynikami.
- **Go:** Specyfikacja języka gwarantuje, że każda nowo zadeklarowana zmienna ma wartość zero (*zero-value guarantee*). Kompilator wstawia potrójny rozkaz `REP STOSQ` czyszczący 9.6 KB w każdym kroku czasowym.

#### C. Porównanie asemblera:
```assembly
# --- Go (Go/solve_poisson.s) ---
0x4bad64   f348ab    REP; STOSQ AX, ES:0(DI)   # Fizyczne zerowanie tablicy g (3200 B)
0x4bad71   f348ab    REP; STOSQ AX, ES:0(DI)   # Fizyczne zerowanie tablicy w (3200 B)
0x4bad81   f348ab    REP; STOSQ AX, ES:0(DI)   # Fizyczne zerowanie tablicy f (3200 B)

# --- C++ (C/solve_poisson.s) ---
subq    $4096, %rsp
subq    $4096, %rsp
subq    $1504, %rsp
# Zero instrukcji zerujących! Pamięć jest natychmiast nadpisywana obliczeniami.
```
* **Skutek wydajnościowy:** W Go procesor wykonuje **~38.4 MB zupełnie niepotrzebnych zapisów zer do pamięci podręcznej na każdy cykl RF**.

---

### RÓŻNICA 5: Brak promocji rejestrowej (Loop Store Motion) w warunkach brzegowych (Krok 5)
📁 **Pliki:** [`C/step5_check_boundaries_electrons.s`](./C/step5_check_boundaries_electrons.s) vs [`Go/step5_boundaries_electrons.s`](./Go/step5_boundaries_electrons.s)

#### A. Pseudokod operacji:
```c
// Cel: usunięcie elektronów poza obszarem [0, L] metodą zamiany z ostatnim elementem
k = 0
dopóki (k < N_e):
    jeśli (x_e[k] < 0 lub x_e[k] > L):
        zwiększ licznik wchłonięć
        // Zamiana O(1):
        x_e[k]  = x_e[N_e - 1]
        vx_e[k] = vx_e[N_e - 1]
        N_e = N_e - 1
    w przeciwnym razie:
        k = k + 1
```

#### B. Co robi kompilator C++ vs Go?
- **C++ (Loop Store Motion):** Zmienne `N_e` oraz liczniki wchłonięć zostały podniesione do rejestrów CPU (`%ecx, %rbx`). Cała pętla modyfikuje wyłącznie rejestry procesora. Zapis do pamięci RAM następuje **tylko raz, po zakończeniu pętli**.
- **Go:** Każda usunięta cząstka powoduje natychmiastowy, bezpośredni zapis do pamięci struktury w RAM (`sim.N_e--`). Dodatkowo każda zamiana generuje **4 testy poprawności indeksu tablic** (`panicBounds`).

#### C. Porównanie asemblera:
```assembly
# --- Go (Go/step5_boundaries_electrons.s) ---
0x4bc1bf   INCQ  0x7275910(AX)              # Bezpośredni zapis do RAM: sim.N_e_abs_pow++
0x4bc2bb   DECQ  0x3567e00(AX)              # Bezpośredni zapis do RAM: sim.N_e--
# Cztery osobne testy granic tablicy przy zamianie cząstki:
0x4bc220   CMPQ BX, $0xf4240; JAE panicBounds  # Test indeksu dla tablicy X_e
0x4bc24a   CMPQ BX, $0xf4240; JAE panicBounds  # Test indeksu dla tablicy Vx_e
0x4bc274   CMPQ BX, $0xf4240; JAE panicBounds  # Test indeksu dla tablicy Vy_e
0x4bc2a0   CMPQ BX, $0xf4240; JAE panicBounds  # Test indeksu dla tablicy Vz_e

# --- C++ (C/step5_check_boundaries_electrons.s) ---
incq    %rbx                     # Inkrementacja rejestru rbx (brak zapisu do RAM!)
decl    %ecx                     # Dekrementacja rejestru ecx (brak zapisu do RAM!)
# Zero testów granic przy zamianie cząstki!
# Zapis ostatecznego wyniku do RAM tylko raz na samym końcu funkcji:
movl    %ecx, N_e(%rip)          # Zapis ostatecznego N_e do pamięci
movq    %rbx, N_e_abs_pow(%rip)  # Zapis ostatecznego licznika do pamięci
```
* **Skutek wydajnościowy:** C++ eliminuje setki tysięcy niepotrzebnych odwołań do pamięci RAM i rozgałęzień warunkowych.

---

## 3. Precyzyjna analiza instrukcji FMA: Gdzie Go miało FMA, a gdzie go zabrakło?

Częstym nieporozumieniem przy powierzchownym czytaniu asemblera jest założenie, że kompilator Go w ogóle nie wygenerował instrukcji FMA (*Fused Multiply-Add*). **To nieprawda.** 

Dzięki fladze kompilacji `GOAMD64=v4`, kompilator Go jak najbardziej potrafi używać instrukcji FMA, ale robi to **niepełnie i wyłącznie w trybie skalarnym**.

---

### A. Gdzie w Go sekwencyjnym FMA faktycznie występuje?
W asemblerze Go instrukcja `VFMADD231SD` (skalarne FMA dla liczb `double`) pojawia się w trzech kluczowych miejscach:
1. **Aktualizacja pozycji elektronu** (`X_e[k] += Vx_e[k] * DT_E`):
   Plik [`Go/step3_push_electrons.s`](./Go/step3_push_electrons.s):
   ```assembly
   0x4bbb2e   VFMADD231SD X9, X4, X2    # X2 = X2 + (X9 * X4) [pozycja = pozycja + v * dt w 1 cyklu!]
   ```
2. **Interpolacja pola elektrycznego** (`e_x = c1*E[p] + c2*E[p+1]`):
   Plik [`Go/step3_push_electrons.s`](./Go/step3_push_electrons.s):
   ```assembly
   0x4bbbc5   VFMADD231SD X4, X0, X2    # Dodanie c1*E[p] do c2*E[p+1] w 1 cyklu zegara
   ```
3. **Obliczanie kwadratu prędkości w zderzeniach** (`v_sqr = vx*vx + vy*vy + vz*vz`):
   Plik [`Go/step7_collisions_electrons.s`](./Go/step7_collisions_electrons.s):
   ```assembly
   0x4bd2b5   VFMADD231SD X0, X0, X1    # Akumulacja energii kinetycznej w 1 cyklu zegara
   ```

---

### B. Czego zabrakło w optymalizatorze Go w porównaniu do C++?
Mimo poprawnej obsługi FMA w powyższych wzorach, kompilator Go ma dwie poważne luki mikroarchitektoniczne:

1. **Brak ujemnego FMA przy aktualizacji prędkości ($v = v - E \cdot \text{factor}$):**
   - **W C++:** Kompilator GCC użył instrukcji `vfnmadd213sd` (*Fused Negative Multiply-Add*). Liczy ona wzór $-(A \cdot B) + C$ w **1 cyklu zegara**.
   - **W Go:** Kompilator Go nie rozpoznał, że odejmowanie można połączyć z mnożeniem w ujemne FMA. Rozbił tę operację na dwie osobne instrukcje:
     ```assembly
     0x4bbb12   MULSD X6, X2   # Krok 1: e_x * FACTOR_E (mnożenie)
     0x4bbb16   SUBSD X2, X9   # Krok 2: vx - wynik     (odejmowanie w osobnym cyklu)
     ```
     Zamiast 1 cyklu mamy 2 osobne instrukcje blokujące rejestry.

2. **Brak WEKTOROWEGO FMA (Różnica między `SD` a `PD`):**
   - **`SD` (Scalar Double):** przetwarza tylko **1 liczbę** `double` naraz (tak działa FMA w Go: `VFMADD231SD`).
   - **`PD` (Packed Double):** przetwarza **wektor liczb** naraz (tak działa FMA w C++: `vfmadd213pd`).
   - W Kroku 1 (CIC) C++ liczy oba węzły siatki $p$ i $p+1$ naraz wektorowym FMA (`vfmadd213pd`), a Go liczy je po kolei skalarnie.

---

### C. Zestawienie wszystkich operacji z FMA w kodzie symulacji:

| Operacja fizyczna | C++ (`-O3 -march=znver4`) | Go (`GOAMD64=v4`) | Komentarz wydajnościowy |
|---|:---:|:---:|---|
| **Interpolacja pola $E_x$** | ✅ `vfmadd132sd` | ✅ `VFMADD231SD` | **Remis** (oba kody robią FMA w 1 cyklu) |
| **Pozycja: $x = x + v \cdot \Delta t$** | ✅ `vfmadd132sd` | ✅ `VFMADD231SD` | **Remis** (oba kody robią FMA w 1 cyklu) |
| **Prędkość: $v = v - E \cdot \text{factor}$** | ✅ `vfnmadd213sd` (ujemne FMA) | ❌ `MULSD` + `SUBSD` (2 rozkazy) | **Go traci 1 cykl** (brak fuzji z odejmowaniem) |
| **Kwadrat prędkości: $v_x^2 + v_y^2 + v_z^2$** | ✅ `vfmadd132sd` | ✅ `VFMADD231SD` | **Remis** (oba kody robią FMA w 1 cyklu) |
| **Depozycja CIC (węzły $p$ i $p+1$)** | ✅ **Wektorowe** `vfmadd213pd` | ❌ Skalarne `MULSD` + `ADDSD` | **C++ liczy 2 węzły naraz**, Go po kolei |

---

## 4. Zestawienie: Kto odpowiada za te różnice?

| Mechanizm | Źródło narzutu | Dlaczego tak jest? |
|---|:---:|---|
| **Alokacja sterty (Krok 7)** | **Programista (Przepisanie)** | W C++ użyto bufora `static`. W Go napisano `make()`, co tworzy tablicę na stercie w kółko. Przeniesienie bufora do struktury rozwiązuje problem. |
| **Przeładowywanie stałych (Krok 3)** | **Kompilator Go** | Kod w C++ i Go był identyczny. GCC sam wyciągnął warunek z pętli (*unswitching*), kompilator Go nie potrafi tego zrobić. |
| **Brak wektoryzacji SIMD (Krok 1)** | **Kompilator Go** | Kompilator Go w ogóle nie posiada modułu automatycznej wektoryzacji pętli. |
| **Sprawdzanie granic tablic (BCE)** | **Kompilator / Język Go** | Go dba o bezpieczeństwo pamięci, więc domyślnie zabezpiecza każdy indeks. Wymaga manualnych asercji programisty, by to wyłączyć. |
| **Zerowanie buforów (Krok 2)** | **Język Go (Specyfikacja)** | Go wymusza zerowanie zmiennych lokalnych. Można to ominąć, trzymając bufory w strukturze. |

---

## 5. Praktyczny wniosek do pracy magisterskiej

> Przepisanie kodu numerycznego z C++ do Go w sposób **dosłowny ("linijka w linijkę")** niemal zawsze da kod wolniejszy, ponieważ C++ polega na potężnym, agresywnym optymalizatorze GCC (`-O3`), który sam naprawia wiele niedoskonałości kodu źródłowego.
>
> Kompilator Go (`gc`) został stworzony pod kątem **błyskawicznego budowania aplikacji internetowych**, dlatego celowo pomija kosztowne optymalizacje matematyczne.
>
> Aby kod w Go osiągnął wydajność C++, **programista musi ręcznie wykonać pracę optymalizatora**:
> 1. Prealokować bufory zamiast używać `make()` w pętlach czasowych.
> 2. Ręcznie wyciągać niezmiennicze warunki `if` przed pętle `for` (*Manual Loop Unswitching*).
> 3. Dodawać asercje zakresów na początku funkcji, by wyłączyć sprawdzanie granic (`panicBounds`).
> 4. Ręcznie rozwijać pętle (*Loop Unrolling 4x*), aby umożliwić procesorowi jednoczesne wykonywanie instrukcji.
