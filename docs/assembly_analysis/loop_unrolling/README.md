# Ścisłe Porównanie Asemblera Go vs C++ — Identyczne Sygnatury i Struktury Danych

Dokument przedstawia w 100% równoważne, ścisłe porównanie kodu asemblera generowanego przez:
* **Go (`gc` v1.22)** — natywny kompilator języka Go
* **C++ (`g++` v13.3 z flagami `-std=c++20 -O3 -funroll-loops`)**

---

## 1. Dlaczego poprzedni test mógł budzić wątpliwości i jak to wyrównaliśmy?

W naiwnym teście C++ często podaje się surowe wskaźniki `double*` oraz słowo kluczowe `__restrict__`:
```cpp
// ❌ NIEUCZCIWE PORÓWNANIE (C++ ma ułatwione zadanie):
void Move(double* __restrict__ x, const double* __restrict__ v, double dt, int n);
```
Taki kod nie jest tożsamy z Go, ponieważ:
1. Ma **4 argumenty** zamiast 3 (długość przekazywana osobnym `int n`).
2. Słowo kluczowe **`__restrict__`** obiecuje kompilatorowi C++, że pamięci `x` i `v` na pewno na siebie nie nachodzą (brak aliasingu wskaźników). W Go takiego słowa kluczowego nie ma.

### ✅ Wyrównanie: 100% identyczna semantyka i struktury pamięci
W nowoczesnym C++ (C++20) bezpośrednim odpowiednikiem slice'a z Go (`[]float64`) jest **`std::span<double>`**:
* Obie struktury to tzw. *fat pointer* (para: wskaźnik na początek bufora + długość).
* Obie funkcje przyjmują **dokładnie 3 argumenty: `(x, v, dt)`**.
* **Żadna z funkcji nie posiada `__restrict__`** — kompilator w obu językach musi sam poradzić sobie z faktem, że `x` i `v` potencjalnie mogłyby na siebie nachodzić w pamięci (*pointer aliasing*).

---

## 2. Porównywany Kod Źródłowy

### Kod w Go ([`loop_unroll_demo.go`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/loop_unroll_demo.go)):
```go
func MoveStandard(x, v []float64, dt float64) {
    for i := 0; i < len(x); i++ {
        x[i] += v[i] * dt
    }
}
```

### Kod w C++ ([`loop_unroll_demo.cc`](file:///C:/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/Go/loop_unroll_demo.cc)):
```cpp
#include <span>

void MoveStandardCPP(std::span<double> x, std::span<const double> v, double dt) {
    for (size_t i = 0; i < x.size(); i++) {
        x[i] += v[i] * dt;
    }
}
```

---

## 3. Wygenerowany Kod Asemblera

### Kompilator Go (`asm_go_standard.s`):
```assembly
0x0016:  MOVSD  (DI)(CX*8), X2      ; Załaduj dokładnie 1 liczbę: v[i]
0x001b:  MULSD  X0, X2              ; Pomnóż przez dt: v[i] * dt
0x001f:  ADDSD  X2, X1              ; Dodaj do x[i]
0x0023:  MOVSD  X1, (AX)(CX*8)      ; Zapisz wynik: x[i] = ...
0x0028:  INCQ   CX                  ; i++ (inkrementuj licznik o 1)
0x002b:  CMPQ   BX, CX              ; Czy i < len(x)?
0x002e:  JLE    60                  ; Skok wyjścia
0x0035:  CMPQ   SI, CX              ; Bounds check (czy i < len(v))
0x0038:  JHI    22                  ; Skok powrotny do kolejnej iteracji
```

### Kompilator C++ (`asm_cpp_unrolled.s`):
Ponieważ w C++ **nie użyliśmy `__restrict__`**, kompilator GCC sam wygenerował na wstępie automatyczny test nakładania się pamięci (*Runtime Pointer Alias Check*):
```assembly
    leaq    8(%rdx), %rdi           ; Oblicz koniec bufora v
    cmpq    %rdi, %rcx              ; Sprawdź czy x nachodzi na v w pamięci!
    jne     .L91                    ; Jeśli NIE nachodzą: przejdź do szybkiej pętli wektorowej
```

A wewnątrz etykiety `.L4` (główna pętla wektorowa):
```assembly
.L4:
    movupd  (%rdx,%rax), %xmm2       ; Ładuj 2 liczby double naraz (Packed Double)
    movupd  (%rcx,%rax), %xmm3
    movupd  16(%rax,%rcx), %xmm4
    movupd  32(%rax,%rcx), %xmm7
    mulpd   %xmm1, %xmm2            ; Mnożenie wektorowe 2 liczb
    ...
    mulpd   %xmm1, %xmm14           ; Kolejne FPU mnożenia w tym samym bloku
    ...
    subq    $-128, %rax             ; Przesuń wskaźnik o 128 bajtów (= 16 liczb double naraz!)
    cmpq    %rsi, %rax              ; Tylko JEDNO sprawdzenie końca na 16 liczb!
    jb      .L4
```

---

## 4. Kluczowe Wnioski ze Ścisłego Porównania

| Aspekt | Go (`gc`) | C++ (`g++ -O3 -funroll-loops`) |
|:---|:---|:---|
| **Liczba elementów na iterację** | **1 element** (`INCQ CX` o 1) | **16 elementów** (skok o 128 bajtów) |
| **Typ instrukcji zmiennoprzecinkowych** | `MOVSD`/`MULSD`/`ADDSD` (Scalar Double — 1 liczba) | `MOVUPD`/`MULPD`/`ADDPD` (Packed Double — wektor SIMD) |
| **Brak `__restrict__` (Aliasing)** | Ignoruje problem; generuje zachowawczy, wolny kod skalarny | Generuje **automatyczny test nakładania wskaźników** i wybiera rozwiniętą ścieżkę wektorową |
| **Liczba skoków i porównań na 16 liczb** | **32 instrukcje** (`CMPQ` + `JLE` + `CMPQ` + `JHI` $\times 16$) | **1 instrukcja** (`CMPQ` + `JB` raz na 16 liczb) |

### Dlaczego to rozstrzyga kwestię optymalizacji w Go?
Kompilator C++ jest w stanie sam wykryć możliwość unrollingu i wektoryzacji, generując nawet własne zabezpieczenia przed aliasingiem. 

Kompilator Go z założenia **nie wykonuje takich transformacji**. Dlatego w Go jedynym sposobem, by uzyskać kod przetwarzający po 4 lub 8 elementów na iterację i odciążyć procesor ze skoków sterujących, jest **napisanie pętli rozwiniętej ręcznie** w kodzie źródłowym (`MoveUnrolled4`).
