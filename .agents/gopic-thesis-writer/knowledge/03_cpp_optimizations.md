# Ścieżka Optymalizacji C++ (OpenMP i Wektoryzacja SIMD)

Niniejszy dokument opisuje architekturę referencyjną i ścieżkę optymalizacyjną w języku C++, stanowiącą ostateczny punkt odniesienia (ang. *gold standard*) dla silnika w Go.

---

## 1. Architektura Referencyjna i Zasada "Apples-to-Apples"

Aby porównanie międzyjęzykowe C++ vs Go było w 100% uczciwe metodologicznie (*apples-to-apples*):
1. **Tożsamość algorytmiczna:** Obie implementacje operują na dokładnie tych samych schematach numerycznych (metoda Null-Collision, jednakowe przekroje czynne Phelpsa, dyskretyzacja CIC, trójprzekątniowy solver Poissona, krok Leap-Frog).
2. **Struktury danych:** Obie implementacje stosują układ Structure of Arrays (SoA) dla tablic cząstek (`x`, `vx`, `vy`, `vz` jako osobne, ciągłe bloki pamięci).
3. **Determinizm fizyczny:** Każda zmiana w kodzie C++ i Go weryfikowana jest testem zgodności binarnej względem stanu [`golden_record/picdata.bin`](file:///C:/Users/E14/Documents/GitHub/GoPIC/golden_record/picdata.bin).

---

## 2. Ewolucja Optymalizacji w C++

### 2.1. Faza Algorytmiczna (Null-Collision)
- W oryginalnym kodzie `eduPIC.cc` (Direct MCC) każda cząstka w każdym kroku sprawdzała prawdopodobieństwo zderzenia:
  $$P_i = 1 - \exp(-\nu(E_i) \Delta t)$$
  co wymagało wielokrotnych wywołań generatora liczb losowych oraz funkcji wykładniczej `std::exp`.
- Przejście na metodę Zderzeń Zerowych (Null-Collision) zredukowało liczbę losowań z $N \approx 150\,000$ do zaledwie $N_{\text{coll}} \approx 500$ na krok czasowy.

### 2.2. Wektoryzacja SIMD (AVX2 / AVX-512) i Problem Operacji Gather
W C++ pętla integratora Leap-Frog podlega automatycznej wektoryzacji przez kompilatory GCC i Clang:
- **Flagi kompilatora:** `-O3 -march=native -mavx512f -ffast-math -fno-trapping-math`.
- **Problem rozproszonego odczytu (The Gather Problem):**  
  W pętli Leap-Frog każda cząstka rzutowana jest na węzeł siatki $p_k = \lfloor x_k / \Delta x \rfloor$. Odczyt pola elektrycznego $E[p_k]$ i $E[p_k+1]$ wymaga nielokalnego dostępu do pamięci (ang. *non-contiguous memory access*).
- Kompilator C++ generuje instrukcje sprzętowego zbierania danych z wektorowych rejestrów indeksowych:
  `VGATHERDPD` (AVX2) lub `VPGATHERDQ` / maskowane `VGATHERDPD` (AVX-512).
- Ponieważ siatka pola $E$ liczy zaledwie $N_G = 400$ elementów typu `double` ($400 \times 8\text{ B} = 3.2\text{ KB}$), **cała tablica pola elektrycznego mieści się bezwzględnie w pamięci podręcznej L1d rdzenia (32 KB)**. Dzięki temu operacja Gather w C++ uderza wyłącznie w L1d Cache, osiągając przepustowość rzędu kilkudziesięciu GB/s.

---

## 3. Zrównoleglenie Wielowątkowe OpenMP

### 3.1. Dyrektywy i Pętle
Zrównoleglenie w C++ zrealizowano przy użyciu OpenMP:
- **Popychanie cząstek (Step 3 & 4):**
  ```cpp
  #pragma omp parallel for schedule(static)
  for (int k = 0; k < N; k++) {
      // Leap-Frog + lokalna detekcja granic
  }
  ```
- **Depozycja gęstości (Step 1a & 1b):**  
  Podobnie jak w Go, każdy wątek OpenMP dysponuje prywatną tablicą `density_local[omp_get_thread_num()][N_G]`, co eliminuje konieczność stosowania atomików (`#pragma omp atomic`) na siatce przestrzennej.
- **Bariery synchronizacyjne:**  
  Realizowane przez zoptymalizowaną bibliotekę wykonawczą `libgomp` (GCC) lub `libomp` (LLVM). Niejawna bariera na końcu pętli `#pragma omp parallel for`.

### 3.2. Topologia Sprzętowa AMD Zen / EPYC i Powiązanie Rdzeni (Affinity)
Procesory AMD EPYC (klaster WCSS, np. węzły z EPYC 9004 / Zen 4) charakteryzują się architekturą modułową:
- Rdzenie zgrupowane są w moduły **CCX (Core Complex)**, zazwyczaj po 8 rdzeni współdzielących **32 MB pamięci podręcznej L3 Cache**.
- Komunikacja między różnymi modułami CCX odbywa się poprzez magistralę *Infinity Fabric*, co wiąże się ze znacznym wzrostem opóźnień i spadkiem przepustowości.
- **Konfiguracja OpenMP w GoPIC:**
  ```bash
  export OMP_PROC_BIND=close
  export OMP_PLACES=cores
  export SLURM_CPUS_PER_TASK=8  # Dokładnie 1 moduł CCX!
  ```
  Przypisanie wątków do jednego modułu CCX eliminuje narzut transferów między-modułowych i pozwala osiągnąć niemal liniowe skalowanie OpenMP.
