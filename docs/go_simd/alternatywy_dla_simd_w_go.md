# Alternatywne metody implementacji SIMD w języku Go: Plan 9 Assembly, Cgo, Strumieniowy SIMD i Sortowanie Komórkowe (Cell Sorting)

## Wprowadzenie

W badaniu udokumentowanym w [`docs/go_simd/README.md`](./README.md) wykazano, że oficjalny eksperymentalny pakiet `simd` z Go 1.27 (`GOEXPERIMENT=simd`) nie nadaje się bezpośrednio do wektoryzacji schematu **Leap-Frog** w symulacji Particle-in-Cell. Przyczyną jest brak w API biblioteki operacji rozproszonego odczytu (**Hardware Gather**), co zmusza kompilator do zrzucania skalarów na stos i wywołuje w procesorze zjawisko **Store-to-Load Forwarding (STLF) Failure**, degradując wydajność ponad 5-krotnie w stosunku do kodu skalarnego.

Pojawia się zatem fundamentalne pytanie inżynierskie: **Czy w języku Go istnieją inne, alternatywne metody na wdrożenie operacji wektorowych SIMD (AVX2 / AVX-512) z ominięciem tego problemu?**

Niniejszy dokument przedstawia cztery alternatywne ścieżki implementacji wektorowej w ekosystemie Go, wraz z ich analizą techniczną, kodami przykładowymi oraz oceną zysków i narzutów pod kątem pracy dyplomowej.

---

## 1. Metoda 1: Natywny asembler Plan 9 w Go (`.s`) ze sprzętowym `VGATHERDPD`

Język Go od swoich początków posiada pełne wsparcie dla wstawek w asemblerze Plan 9. W asemblerze Go programista ma bezpośredni dostęp do rejestrów sprzętowych procesora (`Y0`–`Y15` dla AVX2 oraz `Z0`–`Z31` dla AVX-512) i może wyemitować dowolną instrukcję maszynową x86-64, w tym sprzętowy **Gather**.

### Jak działałby sprzętowy Gather w asemblerze Go?
Zamiast zapisywać 4 skalary na stos (`MOVSD`), w asemblerze ładujemy 4 indeksy siatki $p_0, p_1, p_2, p_3$ do rejestru wektorowego, po czym wywołujemy sprzętową instrukcję `VGATHERDPD`:
```asm
// Przykład koncepcyjny w asemblerze Plan 9 (Go amd64):
// Y0 = wektor indeksów siatki [p0, p1, p2, p3] (32-bitowe inty)
// R9 = wskaźnik bazowy tablicy sim.Efield
// Y1 = maska ładowania (wszystkie bity 1)
// Wynik w rejestrze Y2 = [E[p0], E[p1], E[p2], E[p3]]

VGATHERDPD (R9)(Y0*8), Y2
```
Instrukcja ta ładuje dane z pamięci RAM/L1 Cache **bezpośrednio do rejestru wektorowego `Y2`, całkowicie omijając stos i eliminując problem STLF**.

### Narzędzie ułatwiające: Avo (Go-based Assembly Generator)
Pisanie asemblera Plan 9 ręcznie jest żmudne. W ekosystemie Go standardem przemysłowym jest biblioteka **Avo** (`github.com/mmcloughlin/avo` stworzona przez firmę Segment):
- Kod generujący asembler pisze się w czystym Go.
- Avo automatycznie zarządza alokacją rejestrów, etykietami skoków, rozwijaniem pętli i offsetami ramek stosu.
- Obsługuje pełen zestaw instrukcji AVX, AVX2, AVX-512 i FMA3.

### Analiza narzutów i opłacalności
- **Brak inlinowania:** Funkcje zdefiniowane w plikach `.s` w Go nie podlegają inlinowaniu przez kompilator. Wywołanie funkcji asemblerowej kosztuje ok. **15–20 ns**.
- **Amortyzacja w chunkingu:** W naszej architekturze wielowątkowej cząstki są podzielone na chunki (np. $25\,000$ cząstek na worker). Jeśli funkcja w asemblerze zostanie wywołana **raz na cały chunk**:
  $$\text{Narzut na cząstkę} = \frac{20\text{ ns}}{25\,000} = 0.0008\text{ ns/cząstkę}$$
  Narzut wywołania funkcji jest całkowicie pomijalny!
- **Ograniczenie na Zen 3 (laptop):** Jak wykazano w rozdziale 6 [`docs/go_simd/README.md`](./README.md), w architekturze AVX2 instrukcja `VGATHERDPD` jest w krzemie rozbijana na mikrorozkazy (latency 15–25 cykli). Natomiast na klastrze HPC z procesorami **Zen 4 (AVX-512)** sprzętowa jednostka Gather działa z pełną przepustowością i mogłaby przynieść realny zysk.

---

## 2. Metoda 2: Moduł jądra obliczeniowego w C/C++ wywoływany przez `cgo`

Drugą metodą jest przeniesienie samej pętli Leap-Frog do języka C lub C++ skompilowanego z pełnymi optymalizacjami wektorowymi GCC/Clang (`-O3 -mavx512f -mfma`), a następnie wywołanie jej z Go przez mechanizm `cgo`.

### Architektura rozwiązania
W pliku `push_kernel.c`:
```c
#include <immintrin.h>

void push_particles_avx512(double* restrict x, double* restrict vx, 
                           const double* restrict efield, 
                           int s, int e, double factorE, double dtE, double invDx) {
    #pragma omp simd
    for (int k = s; k < e; k++) {
        double c0 = x[k] * invDx;
        int p = (int)c0;
        if (p < 0) p = 0;
        if (p > 398) p = 398;
        double d = c0 - (double)p;
        double ex = efield[p] + d * (efield[p+1] - efield[p]);
        vx[k] -= ex * factorE;
        x[k] += vx[k] * dtE;
    }
}
```
W pliku Go:
```go
package gopic

/*
#cgo CFLAGS: -O3 -mavx512f -mfma
void push_particles_avx512(double* x, double* vx, const double* efield, 
                           int s, int e, double factorE, double dtE, double invDx);
*/
import "C"
import "unsafe"

func pushChunkCgo(x, vx *ParticleVector, efield *Xvector, s, e int) {
    C.push_particles_avx512(
        (*C.double)(unsafe.Pointer(&x[0])),
        (*C.double)(unsafe.Pointer(&vx[0])),
        (*C.double)(unsafe.Pointer(&efield[0])),
        C.int(s), C.int(e),
        C.double(FACTOR_E), C.double(DT_E), C.double(INV_DX),
    )
}
```

### Bilans narzutu `cgo`
- Pojedyncze przejście z Go do C przez `cgo` wiąże się ze zmianą stosu i kosztuje ok. **50–60 ns**.
- Ponieważ wywołanie następuje **raz na cały chunk** ($25\,000$ cząstek):
  $$\text{Narzut cgo na cząstkę} = \frac{50\text{ ns}}{25\,000} = 0.002\text{ ns}$$
- **Ocena:** Daje dostęp do pełnego kompilatora wektorowego Clang/GCC z AVX-512 na węzłach HPC. Jednak w kontekście pracy inżynierskiej/magisterskiej poświęconej językowi Go, wprowadzenie kodu C narusza czystość środowiska Go ("pure Go") i komplikuje proces budowania (wymaga kompilatora Cgo i wyklucza prosty cross-compiling).

---

## 3. Metoda 3: Sortowanie Komórkowe (Cell Sorting / Binning) — podejście algorytmiczne

Trzecią, najbardziej elegancką naukowo metodą jest **zmiana organizacji danych cząstek w pamięci**, tak aby całkowicie wyeliminować potrzebę operacji Gather. Jest to technika powszechnie stosowana w wiodących superkomputerowych kodach PIC (m.in. WarpX, EPOCH, PIConGPU).

```
STAN OBECNY (Cząstki w losowych komórkach -> Wymaga Gather):
Pamięć:  [k: p=15] [k+1: p=380] [k+2: p=3] [k+3: p=210]  --> 4 różne węzły siatki!

SORTOWANIE KOMÓRKOWE (Cząstki w tej samej komórce leżą obok siebie w pamięci):
Pamięć:  [k: p=15] [k+1: p=15]  [k+2: p=15] [k+3: p=15]   --> TEN SAM węzeł siatki!
                                                              BroadcastFloat64s(E[15])!
                                                              100% CZYSTE STREAMING SIMD!
```

### Na czym polega mechanizm?
1. Jeśli cząstki w tablicach SoA zostaną posortowane lub pogrupowane według komórki siatki, w której się znajdują:
   Wszystkie cząstki w danej komórce $p$ mają **identyczne wartości węzłów siatki**: $E[p]$ oraz $E[p+1]$!
2. Wtedy dla grupy cząstek w komórce $p$:
   - Wartości pola $E[p]$ i $E[p+1]$ ładujemy do wektorów **jednorazowo** za pomocą instrukcji `BroadcastFloat64s` (która w x86 mapuje się na super-szybką instrukcję `VBROADCASTSD` bez żadnego narzutu STLF!):
     ```go
     vEp0 := simd.BroadcastFloat64s(efield[p])
     vEp1 := simd.BroadcastFloat64s(efield[p+1])
     ```
   - Pętla po cząstkach w komórce $p$ staje się **w 100% strumieniowym wektorem SIMD**:
     ```go
     // Wszystkie cząstki w komórce p:
     vX := simd.LoadFloat64s(cell_x[i:i+4])
     vD := vX.Mul(vInvDx).Sub(vP) // odchylenie d
     vEx := vD.MulAdd(vEp1SubEp0, vEp0) // interpolacja CIC wektorowo w rejestrach!
     vVx := simd.LoadFloat64s(cell_vx[i:i+4])
     vVxNew := vEx.MulAdd(vNegFactor, vVx)
     vXNew := vVxNew.MulAdd(vDt, vX)
     vVxNew.Store(cell_vx[i:i+4])
     vXNew.Store(cell_x[i:i+4])
     ```
3. **Zalety:**
   - **Zero odwołań do stosu i zero błędów STLF.**
   - Pakiet `simd` z Go 1.27 działa tutaj z maksymalną teoretyczną wydajnością sprzętową (AVX2 / AVX-512).
   - Dodatkowo krok depozycji ładunku CIC (`Step1`) staje się bezkonfliktowy (brak wyścigów danych do węzłów siatki).
4. **Koszt:** Wymaga periodycznego sortowania cząstek (np. co 5–10 kroków czasowych) za pomocą algorytmu Counting Sort o złożoności $O(N)$ w 1D.

---

## 4. Metoda 4: Zastosowanie SIMD w operacjach siatkowych (Grid Operations)

Choć tablice cząstek w obecnym układzie wymagają rozproszonego odczytu, w kodzie GoPIC istnieją moduły operujące na siatce przestrzennej ($N_G = 400$ węzłów), które są z natury **ciągłe w pamięci** i idealnie pasują do pakietu `simd`:

### A. Różniczkowanie pola elektrycznego z potencjału (Krok 2)
Obliczenie pola elektrycznego w węzłach siatki metodą różnic centralnych:
$$E[p] = -\frac{\Phi[p+1] - \Phi[p-1]}{2\Delta x}$$
W kodzie wektorowym z pakietem `simd`:
```go
vInv2Dx := simd.BroadcastFloat64s(-INV_2DX)
for p := 1; p <= N_G-1-vLen; p += vLen {
    vPhiNext := simd.LoadFloat64s(sim.Pot[p+1 : p+1+vLen])
    vPhiPrev := simd.LoadFloat64s(sim.Pot[p-1 : p-1+vLen])
    vE := vPhiNext.Sub(vPhiPrev).Mul(vInv2Dx)
    vE.Store(sim.Efield[p : p+vLen])
}
```
Jest to czysty **Streaming SIMD** — odczyt z ciągłych wycinków `Pot`, wektorowe odejmowanie i mnożenie, zapis do `Efield`.

### B. Obliczanie gęstości ładunku przestrzennego $\rho$ (Krok 2)
$$\rho[p] = e \cdot (n_i[p] - n_e[p])$$
W kodzie wektorowym:
```go
vCharge := simd.BroadcastFloat64s(E_CHARGE)
for p := 0; p <= N_G-vLen; p += vLen {
    vNi := simd.LoadFloat64s(sim.I_density[p : p+vLen])
    vNe := simd.LoadFloat64s(sim.E_density[p : p+vLen])
    vRho := vNi.Sub(vNe).Mul(vCharge)
    vRho.Store(rho[p : p+vLen])
}
```

### C. Akumulacja gęstości uśrednionych w czasie (Krok 1)
```go
for p := 0; p <= N_G-vLen; p += vLen {
    vDens := simd.LoadFloat64s(sim.E_density[p : p+vLen])
    vCumul := simd.LoadFloat64s(sim.Cumul_e_density[p : p+vLen])
    vCumul.Add(vDens).Store(sim.Cumul_e_density[p : p+vLen])
}
```

*Uwaga praktyczna:* Ponieważ siatka przestrzenna $N_G = 400$ węzłów mieści się w zaledwie 50 wektorach AVX-512 (lub 100 wektorach AVX2), cały Krok 2 wykonuje się w ułamku mikrosekundy. Wektoryzacja tego modułu przynosi zysk rzędu kilkunastu nanosekund, co stanowi doskonałą demonstrację techniczną w pracy, lecz ma znikomy wpływ na całkowity czas cyklu RF (gdzie dominuje pchnięcie 100 000 cząstek).

---

## 5. Podsumowanie i ocena porównawcza metod

| Metoda | Obsługa Gather | Złożoność implementacji | Wpływ na czystość Go | Potencjał zysku na HPC (Zen 4) |
| :--- | :---: | :---: | :---: | :---: |
| **Pakiet `simd` z Go 1.27 (naiwny)** | ❌ Brak (błąd STLF) | Bardzo niska | 100% czyste Go | **Degradacja 5–10×** |
| **Skalarne 4-way ILP (obecne)** | Niezbędne nie jest (rejestry XMM) | Niska (prosty unroll) | 100% czyste Go | **Bardzo wysoki (IPC > 3.5)** |
| **Asembler Plan 9 (Avo)** |  Sprzętowe `VGATHERDPD` | Wysoka (kod `.s`) | 100% zgodne z Go | Wysoki (omija stos) |
| **Cgo z GCC/Clang AVX-512** |  Automatyczne przez kompilator C | Średnia | Wymaga środowiska C | Bardzo wysoki (pełny AVX-512) |
| **Sortowanie Komórkowe (Cell Sorting)** |  Zbędne (Broadcast SIMD) | Średnia/Wysoka (algorytm) | 100% czyste Go | **Maksymalny teoretycznie** |

### Rekomendacja dla projektu GoPIC i pracy dyplomowej:
1. **Wnioski badawcze:** W pracy warto przedstawić zestawienie: dlaczego naiwne użycie `simd` w Go zawodzi (konflikt STLF), oraz wykazać, że **zoptymalizowany kod skalarny z 4-krotnym rozwinięciem (4-way ILP)** jest w obecnym stanie języka Go **najbardziej optymalnym, przenośnym i bezkompromisowym rozwiązaniem**.
2. **Kierunek przyszłych badań (Future Work):** Jako naturalny kolejny krok w pracy dyplomowej można wskazać implementację **Sortowania Komórkowego (Cell Sorting)** lub jądra w **Avo Plan 9 Assembly**, które pozwoliłoby odblokować pełną moc AVX-512 bez opuszczania ekosystemu Go.
