# Plan testów — wersja C (eduPIC.cc)

Pliki źródłowe w katalogu: [`C/`](../../C/)  
Framework: [Google Test (gtest)](https://github.com/google/googletest)  
Alternatywa: [Catch2 v3](https://github.com/catchorg/Catch2) (header-only, zero zależności zewnętrznych)

> **Standard:** C++17 (wymagany dla `inline` zmiennych w nagłówku `state.h` — GCC 7+, Clang 5+)

---

## 1. Architektura testów

### Podział plików (Spójny z wersją Python/NumPy)

Kod produkcyjny C++ jest podzielony w identyczny sposób jak wersja zoptymalizowana w Pythonie:

```
C/
├── constants.h       ← Stałe fizyczne, parametry symulacji i definicje typów (typedefs)
├── state.h           ← Zmienne globalne inline (C++17) oraz generatory RNG
├── cross_sections.h  ← Przekroje czynne Phelpsa i Petrovica
├── poisson.h         ← Solver Poissona (algorytm Thomasa)
├── collisions.h      ← Fizyka zderzeń (Monte Carlo)
├── simulation.h      ← Popychanie, depozycja gęstości, pętla główna
├── io_manager.h      ← Zapis/odczyt plików .dat, .bin, info.txt
├── eduPIC.cc         ← Tylko main() (punkt wejścia)
└── tests/
    ├── test_helpers.h         ← Resetowanie stanu przed każdym testem
    ├── test_poisson.cc        ← Testy solvera Thomasa
    ├── test_density.cc        ← Testy liniowej depozycji gęstości ładunku
    ├── test_push.cc           ← Testy popychania cząstek (leapfrog)
    ├── test_boundaries.cc     ← Testy absorpcji na elektrodach
    ├── test_cross_sections.cc ← Testy poprawności wyliczania sigm
    ├── test_collisions.cc     ← Testy stochastyczne zderzeń
    ├── test_diagnostics.cc    ← Testy normalizacji i diagnostyk
    └── test_regression.cc     ← Skrypt regresji (golden run)
```

### Jak to działa (Header-Only z `inline`)

Dzięki podzieleniu kodu na pliki nagłówkowe z implementacjami i użyciu `inline` dla zmiennych stanu w `state.h`, testy jednostkowe mogą zaimportować całą logikę poprzez dołączenie nagłówków. Linker automatycznie scali zmienne globalne z różnych plików testowych w jeden wspólny stan w pamięci.

* **`eduPIC.cc`** nie jest linkowany do testów (ponieważ zawiera własną funkcję `main()`, która kolidowałaby z `gtest_main`).
* Cały stan i funkcjonalności są zaciągane przez nagłówki.

### Pomocniczy helper: reset stanu

Wszystkie pliki testowe dołączają nagłówek `test_helpers.h`, który automatycznie dołącza pliki z logiką symulacji i udostępnia funkcję resetującą stan przed uruchomieniem każdego testu:

```cpp
// C/tests/test_helpers.h
#pragma once
#include "../constants.h"
#include "../state.h"
#include "../cross_sections.h"
#include "../poisson.h"
#include "../collisions.h"
#include "../simulation.h"
#include "../io_manager.h"
#include <algorithm>

// Resetuje cały globalny stan przed każdym testem
inline void reset_state() {
    N_e = 0; N_i = 0;
    N_e_abs_pow = 0; N_e_abs_gnd = 0;
    N_i_abs_pow = 0; N_i_abs_gnd = 0;
    N_e_coll = 0;    N_i_coll = 0;
    Time = 0.0;
    measurement_mode = false;
    for (int i = 0; i < N_G; i++) {
        e_density[i] = 0.0; i_density[i] = 0.0;
        cumul_e_density[i] = 0.0; cumul_i_density[i] = 0.0;
        efield[i] = 0.0; pot[i] = 0.0;
    }
    std::fill(std::begin(eepf),     std::end(eepf),     0.0);
    std::fill(std::begin(ifed_pow), std::end(ifed_pow), 0);
    std::fill(std::begin(ifed_gnd), std::end(ifed_gnd), 0);
}

// Seed deterministyczny RNG — wyłącznie dla testów jednostkowych (Tier 2).
// NIE używać do golden run — tam stan RNG jest serializowany przez save/load_rng_state().
inline void seed_rng(uint64_t seed = 42) {
    MTgen.seed(seed);
}
```

---

## 2. Konfiguracja środowiska

### Wymagania kompilatora

```bash
# Sprawdź wersję GCC — musi być >= 7 dla C++17 inline variables
g++ --version

# Kompilacja ZAWSZE z flagą -std=c++17
g++ -std=c++17 -O2 -o eduPIC eduPIC.cc
```

### Instalacja gtest (Linux/WSL)
```bash
sudo apt-get install libgtest-dev
cd /usr/src/gtest && sudo cmake . && sudo make
sudo cp lib/*.a /usr/local/lib/
```

### Instalacja gtest (Windows — vcpkg)
```powershell
vcpkg install gtest:x64-windows
```

### Alternatywa — Catch2 (single header, zero instalacji)
```bash
curl -LO https://github.com/catchorg/Catch2/releases/download/v3.7.1/catch_amalgamated.hpp
```

---

## 3. Testy regresyjne (golden run)

### Cel

Zagwarantować, że zmiany w strukturze plików lub optymalizacjach nie modyfikują wyników fizycznych symulacji.

### Dlaczego nie modyfikujemy kodu produkcyjnego

Moglibyśmy zaszyć seedowanie i zapis/odczyt RNG bezpośrednio w `C/eduPIC.cc`, ale zanieczyszczałoby to kod produkcyjny logiką testową. Zamiast tego tworzymy **dedykowany runner testowy** `C/tests/test_regression_runner.cc`. 

Dzięki temu:
1. Oryginalny kod produkcyjny (`C/eduPIC.cc` oraz nagłówki) pozostaje w 100% nienaruszony.
2. Domyślne uruchomienia produkcyjne nadal są niedeterministyczne (losowy seed z `std::random_device`).
3. Narzędzie testowe ma pełną, bit-perfect kontrolę nad generatorem pseudolosowym dzięki serializacji stanu `MTgen` przez `operator<<` / `operator>>` do pliku `rng_state.bin`.

### Krok 1: Struktura `test_regression_runner.cc`

Plik znajduje się w katalogu `C/tests/test_regression_runner.cc`. Zawiera on własną funkcję `main()`, która kompiluje się do osobnego programu. Wczytuje oryginalne nagłówki i implementuje zapis/odczyt stanu generatora:

```cpp
// C/tests/test_regression_runner.cc
#include "../constants.h"
#include "../state.h"
#include "../cross_sections.h"
#include "../simulation.h"
#include "../io_manager.h"
#include <fstream>

inline void save_rng_state() {
    std::ofstream f("rng_state.bin");
    f << MTgen;
}

inline void load_rng_state() {
    std::ifstream f("rng_state.bin");
    f >> MTgen;
}

int main(int argc, char *argv[]) {
    // ...
    // Przy arg1 == 0: MTgen.seed(42ULL); do_one_cycle(); save_rng_state();
    // Przy arg1 > 0: load_rng_state(); do_one_cycle() w pętli; save_rng_state();
    // ...
}
```

### Krok 2: Wygeneruj golden output

Kompilujemy dedykowany program testowy `eduPIC_reg` z pliku `test_regression_runner.cc`:

```bash
cd C
# Kompilacja runnera testów regresyjnych
g++ -std=c++17 -O2 -o eduPIC_reg tests/test_regression_runner.cc

# Inicjalizacja: seed=42, 1 cykl, zapisuje picdata.bin + rng_state.bin
rm -f picdata.bin rng_state.bin
./eduPIC_reg 0

# Kontynuacja (5 cykli): wczytuje rng_state.bin, kontynuuje, zapisuje oba pliki
./eduPIC_reg 5

# Pomiar (kolejne 5 cykli): wczytuje rng_state.bin, wykonuje pomiary i zapisuje eepf.dat
./eduPIC_reg 5 m

# Zapisanie wyników jako wzorcowe (golden)
mkdir -p tests/golden
cp density.dat tests/golden/density_golden.dat
cp conv.dat    tests/golden/conv_golden.dat
cp eepf.dat    tests/golden/eepf_golden.dat
```

### Krok 3: Skrypt regresyjny

Skrypt automatycznie kompiluje runner regresji, uruchamia test i porównuje wyjście z wzorcem:

```bash
#!/bin/bash
# tests/run_regression.sh
set -e

echo "=== Budowanie runnera regresji ==="
cd ..
g++ -std=c++17 -O2 -o eduPIC_reg tests/test_regression_runner.cc
cd tests

echo "=== Uruchamianie symulacji testowej ==="
rm -f picdata.bin rng_state.bin
../eduPIC_reg 0           # seed=42 → picdata.bin + rng_state.bin
../eduPIC_reg 5           # kontynuacja z rng_state.bin
../eduPIC_reg 5 m         # measurement mode

echo "=== Porównanie z danymi golden ==="
diff density.dat golden/density_golden.dat \
    || { echo "FAIL: density.dat differs"; exit 1; }
diff conv.dat golden/conv_golden.dat \
    || { echo "FAIL: conv.dat differs"; exit 1; }

echo "=== Porównanie numeryczne eepf.dat (tolerancja 1e-6) ==="
python3 compare_numeric.py eepf.dat golden/eepf_golden.dat 1e-6

echo "=== OK: wszystkie testy regresyjne przeszły ==="
```

> **Tolerancja dla `eepf.dat`:** Ustawiona na `1e-6`. Daje to bezpieczny margines na drobne błędy zaokrąglenia przy różnych poziomach optymalizacji kompilatora (`-O0` vs `-O2` / `-O3`), zachowując przy tym pełną czułość na błędy logiczne i fizyczne.

---

## 4. Testy jednostkowe — Walidacja Międzyjęzykowa (Cross-Language Parity)

Te testy jednostkowe są w 100% deterministyczne. Używają **sztywno zdefiniowanych danych wejściowych** (zamiast generatora losowości), co pozwala na ich identyczną implementację w Pythonie i Go. Sukces tych testów gwarantuje, że wzory fizyczne we wszystkich trzech językach są implementowane w identyczny sposób z dokładnością zmiennoprzecinkową (double).

Każdy plik testowy dołącza `test_helpers.h`, dający pełny dostęp do wszystkich zmiennych stanu i funkcji.

### 4.1 `solve_Poisson` — solver Thomasa (`tests/test_poisson.cc`)

Weryfikuje poprawność obliczania potencjału $V$ i pola $E$. Te same testy powinny być powtórzone w Pythonie i Go, dając identyczne wektory wynikowe.

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class PoissonTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: potencjał liniowy w próżni (ρ=0)
TEST_F(PoissonTest, VacuumLinearPotential) {
    xvector rho = {};
    solve_Poisson(rho, 0.0);   // tt=0 -> VOLTAGE*cos(0) = VOLTAGE

    for (int i = 0; i < N_G; i++) {
        double expected = VOLTAGE * (1.0 - (double)i / (N_G - 1));
        EXPECT_NEAR(pot[i], expected, 1e-15) << "Niezgodność potencjału w weźle i=" << i;
    }
}

// Test B: E-pole stałe w próżni (E = V0 / L)
TEST_F(PoissonTest, VacuumConstantEfield) {
    xvector rho = {};
    solve_Poisson(rho, 0.0);
    const double E_expected = VOLTAGE / L;
    
    // Węzły wewnętrzne (pochodna różnic centralnych)
    for (int i = 1; i < N_G - 1; i++) {
        EXPECT_NEAR(efield[i], E_expected, 1e-14) << "Niezgodność E-pola w weźle i=" << i;
    }
}

// Test C: warunki brzegowe E-pola z niezerową gęstością rho na samych granicach
TEST_F(PoissonTest, BoundaryEfieldWithCharge) {
    xvector rho = {};
    rho[0]     = 1e15 * E_CHARGE;
    rho[N_G-1] = 2e15 * E_CHARGE;
    solve_Poisson(rho, 0.0);

    double expected_e0 = (pot[0] - pot[1]) * INV_DX
                         - rho[0] * DX / (2.0 * EPSILON0);
    double expected_eN = (pot[N_G-2] - pot[N_G-1]) * INV_DX
                         + rho[N_G-1] * DX / (2.0 * EPSILON0);
                         
    EXPECT_NEAR(efield[0],     expected_e0, 1e-14);
    EXPECT_NEAR(efield[N_G-1], expected_eN, 1e-14);
}
```

---

### 4.2 Liniowa depozycja gęstości (`tests/test_density.cc`)

Weryfikuje ważenie ładunku cząstek na siatkę oraz krytyczne boundary correction (mnożenie przez 2).

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class DensityTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: cząstka leżąca dokładnie na węźle wewnętrznym
TEST_F(DensityTest, SingleParticleOnInternalNode) {
    int p0 = 150;
    N_e = 1;
    x_e[0] = DX * p0;
    step1_compute_electron_density();

    EXPECT_NEAR(e_density[p0],     FACTOR_W, 1e-15);
    EXPECT_NEAR(e_density[p0 + 1], 0.0,      1e-15);
    EXPECT_NEAR(e_density[p0 - 1], 0.0,      1e-15);
}

// Test B: Korekta x2 na lewym brzegu (x_e = 0.5 * DX)
TEST_F(DensityTest, BoundaryDoublingLeft) {
    N_e = 1;
    x_e[0] = DX * 0.5;
    step1_compute_electron_density();
    
    // Węzeł 0 powinien otrzymać 0.5 * W, po korekcie *2 -> W
    // Węzeł 1 powinien otrzymać 0.5 * W (brak korekty)
    EXPECT_NEAR(e_density[0], FACTOR_W,       1e-15);
    EXPECT_NEAR(e_density[1], 0.5 * FACTOR_W, 1e-15);
}

// Test C: Korekta x2 na prawym brzegu (x_e = L - 0.25 * DX)
TEST_F(DensityTest, BoundaryDoublingRight) {
    N_e = 1;
    x_e[0] = L - DX * 0.25; // index: N_G - 1.25
    step1_compute_electron_density();
    
    // Węzeł N_G-2: 0.25 * W
    // Węzeł N_G-1: 0.75 * W, po korekcie *2 -> 1.5 * W
    EXPECT_NEAR(e_density[N_G - 2], 0.25 * FACTOR_W, 1e-15);
    EXPECT_NEAR(e_density[N_G - 1], 1.50 * FACTOR_W, 1e-15);
}
```

---

### 4.3 Popychanie cząstek Leapfrog (`tests/test_push.cc`)

Weryfikuje poprawność kierunku działania sił dla ładunku ujemnego (elektrony) i dodatniego (jony) oraz interpolację pól.

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class PushTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: Znak przyspieszenia elektronu (vx -= FACTOR_E * E) vs jonu (vx += FACTOR_I * E)
TEST_F(PushTest, ParticlePushSigns) {
    N_e = 1; x_e[0] = L / 2.0; vx_e[0] = 0.0; vy_e[0] = 0.0; vz_e[0] = 0.0;
    N_i = 1; x_i[0] = L / 2.0; vx_i[0] = 0.0; vy_i[0] = 0.0; vz_i[0] = 0.0;
    
    for (int i = 0; i < N_G; i++) efield[i] = 1000.0; // dodatnie pole elektryczne

    step3_move_electrons(0);
    step4_move_ions(0, 0); // t = 0 (subcycling trigger)

    EXPECT_LT(vx_e[0], 0.0);  // Elektron (ujemny) leci w lewo (pod prąd pola E)
    EXPECT_GT(vx_i[0], 0.0);  // Jon (dodatni) leci w prawo (z prądem pola E)
}

// Test B: Interpolacja pola elektrycznego dokładnie pośrodku komórki
TEST_F(PushTest, EfieldInterpolationMidpoint) {
    N_e = 1;
    int p0 = 200;
    x_e[0] = DX * (p0 + 0.5); // w połowie między p0 a p0+1
    vx_e[0] = 0.0;
    
    efield[p0]     = 100.0;
    efield[p0 + 1] = 300.0;
    
    step3_move_electrons(0);
    
    // E_interp = 0.5 * 100.0 + 0.5 * 300.0 = 200.0 V/m
    // v_new = 0.0 - 200.0 * FACTOR_E
    // x_new = x_old + v_new * DT_E
    double expected_v = -200.0 * FACTOR_E;
    double expected_x = DX * (p0 + 0.5) + expected_v * DT_E;
    
    EXPECT_NEAR(vx_e[0], expected_v, 1e-15);
    EXPECT_NEAR(x_e[0],  expected_x, 1e-15);
}
```

---

### 4.4 Warunki brzegowe (`tests/test_boundaries.cc`)

Weryfikuje usuwanie cząstek poza elektrodami oraz poprawność zbierania histogramów energetycznych jonów (IFED).

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class BoundaryTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: Metoda usuwania cząstek przez zamianę z ostatnim elementem (Fast-Swap)
TEST_F(BoundaryTest, FastSwapCorrectness) {
    N_e = 3;
    x_e[0] = L * 0.25;  vx_e[0] = 10.0;
    x_e[1] = -0.001;    vx_e[1] = 20.0;   // Do usunięcia (lewa granica)
    x_e[2] = L * 0.75;  vx_e[2] = 30.0;   // Ostatnia cząstka w tablicy
    
    step5_check_boundaries_electrons();
    
    EXPECT_EQ(N_e, 2);
    EXPECT_EQ(N_e_abs_pow, 1);
    // Cząstka o indeksie 2 zastąpiła usuniętą o indeksie 1
    EXPECT_NEAR(x_e[1],  L * 0.75, 1e-15);
    EXPECT_NEAR(vx_e[1], 30.0,    1e-15);
}

// Test B: Zbieranie energii jonów na elektrodzie do histogramu IFED
TEST_F(BoundaryTest, IonFluxEnergyDistribution) {
    N_i = 1;
    x_i[0] = L + 0.001; // Wykracza poza prawą granicę (grounded electrode)
    
    // Obliczamy energię w eV: E_kin = 0.5 * m_Ar * v^2 / E_CHARGE
    // Chcemy energię równą dokładnie 50.5 eV
    double target_energy_eV = 50.5;
    double v_x = sqrt(2.0 * target_energy_eV * E_CHARGE / AR_MASS);
    vx_i[0] = v_x; vy_i[0] = 0.0; vz_i[0] = 0.0;
    
    step6_check_boundaries_ions(0); // t = 0 (subcycling)
    
    EXPECT_EQ(N_i, 0);
    EXPECT_EQ(N_i_abs_gnd, 1);
    
    // Indeks histogramu IFED: idx = int(energy_eV / DE_IFED) (DE_IFED = 1.0 eV)
    // Dla 50.5 eV indeks to 50.
    EXPECT_EQ(ifed_gnd[50], 1);
    EXPECT_EQ(ifed_gnd[51], 0);
}
```

---

## 5. Testy jednostkowe — Przekroje czynne Phelpsa/Petrovica (`tests/test_cross_sections.cc`)

Weryfikacja tożsamości interpolacji przekrojów czynnych zderzeń (argonu) dla zdefiniowanych energii. To kluczowy test, ponieważ minimalne różnice w interpolacji wielomianowej doprowadzą do różnych częstotliwości zderzeń w pełnej symulacji.

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class CrossSectionTest : public ::testing::Test {
protected:
    void SetUp() override {
        set_electron_cross_sections_ar();
        set_ion_cross_sections_ar();
        calc_total_cross_sections();
    }
};

TEST_F(CrossSectionTest, PhelpsPetrovicArValues) {
    // Sprawdzamy wartości dla energii progowych i losowych w eV
    double test_energies[] = {0.1, 11.5, 15.8, 50.0};
    
    // Przekroje czynne dla elektronów (wszystkie wartości w 1e-20 m^2)
    // 0.1 eV -> poniżej progu na wzbudzenie i jonizację (tylko elastyczne)
    int idx_0_1 = (int)(0.1 / DE_CS);
    EXPECT_GT(sigma[E_ELA][idx_0_1], 0.0);
    EXPECT_NEAR(sigma[E_EXC][idx_0_1], 0.0, 1e-15);
    EXPECT_NEAR(sigma[E_ION][idx_0_1], 0.0, 1e-15);
    
    // 50.0 eV -> powyżej wszystkich progów
    int idx_50 = (int)(50.0 / DE_CS);
    EXPECT_GT(sigma[E_ELA][idx_50], 0.0);
    EXPECT_GT(sigma[E_EXC][idx_50], 0.0);
    EXPECT_GT(sigma[E_ION][idx_50], 0.0);
    
    // Suma przekrojów
    double total_macro = (sigma[E_ELA][idx_50] + sigma[E_EXC][idx_50] + sigma[E_ION][idx_50]) * GAS_DENSITY;
    EXPECT_NEAR(sigma_tot_e[idx_50], total_macro, 1e-12);
}
```

---

## 6. Makefile / CMake

### Makefile (`C/tests/Makefile`)

```makefile
CXX      = g++
CXXFLAGS = -std=c++17 -O2 -Wall
LDFLAGS  = -lgtest -lgtest_main -lpthread

TEST_SRCS = test_poisson.cc test_density.cc test_push.cc \
            test_boundaries.cc test_cross_sections.cc

all: run_tests
	./run_tests

# Kompilacja: dołączamy tylko źródła testów.
# Cała logika symulacji jest wciągana automatycznie z nagłówków w test_helpers.h
run_tests: $(TEST_SRCS) test_helpers.h ../constants.h ../state.h ../poisson.h ../collisions.h ../simulation.h ../io_manager.h
	$(CXX) $(CXXFLAGS) $(TEST_SRCS) $(LDFLAGS) -I.. -o run_tests

regression:
	bash run_regression.sh

clean:
	rm -f run_tests
```

### CMakeLists.txt (`C/CMakeLists.txt`)

```cmake
cmake_minimum_required(VERSION 3.14)
project(eduPIC_C_tests CXX)
set(CMAKE_CXX_STANDARD 17)   # Wymagane dla inline variables

include(FetchContent)
FetchContent_Declare(googletest
  URL https://github.com/google/googletest/archive/v1.14.0.zip)
FetchContent_MakeAvailable(googletest)

# Kompilujemy wyłącznie testy. Plik eduPIC.cc (zawierający main) jest pomijany.
add_executable(run_tests
    tests/test_poisson.cc
    tests/test_density.cc
    tests/test_push.cc
    tests/test_boundaries.cc
    tests/test_cross_sections.cc
)

target_include_directories(run_tests PRIVATE ${CMAKE_SOURCE_DIR})
target_link_libraries(run_tests GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(run_tests)
```

---



