# Plan testów — wersja C (eduPIC.cc)

Pliki źródłowe w katalogu: [`C/`](../../C/)  
Framework: [Google Test (gtest)](https://github.com/google/googletest)  
Alternatywa: [Catch2 v3](https://github.com/catchorg/Catch2) (header-only, zero zależności zewnętrznych)

> **Standard:** C++17 (wymagany dla `inline` zmiennych w nagłówku `state.h` — GCC 7+, Clang 5+)

---

## Spis treści

1. [Architektura testów](#1-architektura-testów)
2. [Konfiguracja środowiska](#2-konfiguracja-środowiska)
3. [Testy regresyjne (golden run)](#3-testy-regresyjne-golden-run)
4. [Testy jednostkowe — Tier 1 (deterministyczne)](#4-testy-jednostkowe--tier-1-deterministyczne)
5. [Testy jednostkowe — Tier 2 (stochastyczne)](#5-testy-jednostkowe--tier-2-stochastyczne)
6. [Testy jednostkowe — Tier 3 (diagnostyczne)](#6-testy-jednostkowe--tier-3-diagnostyczne)
7. [Makefile / CMake](#7-makefile--cmake)
8. [Checklist](#8-checklist)

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

// Seed deterministyczny RNG — wymagany dla testów stochastycznych i regresyjnych
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

### Krok 1: Deterministyczny seed RNG

W pliku `C/state.h` przed wygenerowaniem plików wzorcowych (golden) podmień inicjalizację `MTgen`:

```cpp
// PRZED:
inline std::mt19937 MTgen(std::random_device{}());  // losowy seed

// PO (na czas generowania golden output):
inline std::mt19937 MTgen(42ULL);   // stały seed — powtarzalne wyniki
```

### Krok 2: Wygeneruj golden output

```bash
cd C
g++ -std=c++17 -O2 -o eduPIC eduPIC.cc
./eduPIC 0          # 1 cykl inicjalizacyjny
./eduPIC 5          # 5 cykli
mkdir -p tests/golden
cp density.dat tests/golden/density_golden.dat
cp conv.dat    tests/golden/conv_golden.dat
./eduPIC 5 m        # measurement mode
cp eepf.dat    tests/golden/eepf_golden.dat
```

### Krok 3: Skrypt regresyjny

```bash
#!/bin/bash
# tests/run_regression.sh
set -e

echo "=== Budowanie ==="
cd ..
g++ -std=c++17 -O2 -o eduPIC eduPIC.cc
cd tests

echo "=== Uruchamianie symulacji ==="
rm -f picdata.bin
../eduPIC 0
../eduPIC 5 m

echo "=== Porównanie z golden ==="
diff density.dat golden/density_golden.dat \
    || { echo "FAIL: density.dat differs"; exit 1; }
diff conv.dat golden/conv_golden.dat \
    || { echo "FAIL: conv.dat differs"; exit 1; }

echo "=== Porównanie numeryczne eepf.dat (tolerancja 1e-10) ==="
python3 compare_numeric.py eepf.dat golden/eepf_golden.dat 1e-10

echo "=== OK: wszystkie testy regresyjne przeszły ==="
```

---

## 4. Testy jednostkowe — Tier 1 (deterministyczne)

Każdy plik testowy dołącza `test_helpers.h`, dający pełny dostęp do wszystkich zmiennych stanu i funkcji.

### 4.1 `solve_Poisson` — solver Thomasa (`tests/test_poisson.cc`)

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class PoissonTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); seed_rng(); }
};

// Test A: potencjał liniowy w próżni (ρ=0)
TEST_F(PoissonTest, VacuumLinearPotential) {
    xvector rho = {};
    solve_Poisson(rho, 0.0);   // tt=0 -> VOLTAGE*cos(0) = VOLTAGE

    for (int i = 1; i < N_G - 1; i++) {
        double expected = VOLTAGE * (1.0 - (double)i / (N_G - 1));
        EXPECT_NEAR(pot[i], expected, 1e-8) << "Blad w wezle i=" << i;
    }
}

// Test B: E-pole stałe w próżni (E = V0 / L)
TEST_F(PoissonTest, VacuumConstantEfield) {
    xvector rho = {};
    solve_Poisson(rho, 0.0);
    const double E_expected = VOLTAGE / L;
    for (int i = 1; i < N_G - 2; i++) {
        EXPECT_NEAR(efield[i], E_expected, 1e-6) << "Blad E-pola w wezle i=" << i;
    }
}

// Test C: warunki graniczne E-pola z rho!=0 na granicy
TEST_F(PoissonTest, BoundaryEfieldWithCharge) {
    xvector rho = {};
    rho[0]     = 1e15 * E_CHARGE;
    rho[N_G-1] = 1e15 * E_CHARGE;
    solve_Poisson(rho, 0.0);

    double expected_e0 = (pot[0] - pot[1]) * INV_DX
                         - rho[0] * DX / (2.0 * EPSILON0);
    double expected_eN = (pot[N_G-2] - pot[N_G-1]) * INV_DX
                         + rho[N_G-1] * DX / (2.0 * EPSILON0);
    EXPECT_NEAR(efield[0],     expected_e0, 1e-6);
    EXPECT_NEAR(efield[N_G-1], expected_eN, 1e-6);
}
```

---

### 4.2 `step1_compute_electron_density` — ważenie liniowe (`tests/test_density.cc`)

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class DensityTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: cząstka dokładnie na węźle
TEST_F(DensityTest, SingleParticleOnNode) {
    int p0 = 100;
    N_e = 1;
    x_e[0] = DX * p0;
    step1_compute_electron_density();

    EXPECT_NEAR(e_density[p0],     FACTOR_W, 1e-10);
    EXPECT_NEAR(e_density[p0 + 1], 0.0,      1e-10);
}

// Test B: KRYTYCZNY — korekta x2 na lewej granicy
TEST_F(DensityTest, BoundaryDoublingLeft) {
    N_e = 1;
    x_e[0] = DX * 0.5;
    step1_compute_electron_density();
    EXPECT_NEAR(e_density[0], FACTOR_W,       1e-10);
    EXPECT_NEAR(e_density[1], 0.5 * FACTOR_W, 1e-10);
}

// Test C: subcycling guard dla jonów
TEST_F(DensityTest, IonDensitySubcyclingGuard) {
    N_i = 1;
    x_i[0] = L / 2.0;
    step1_compute_ion_density(1);   // t != wielokrotność N_SUB
    EXPECT_NEAR(i_density[N_G / 2], 0.0, 1e-15);
    step1_compute_ion_density(0);   // t == 0 -> oblicza
    EXPECT_GT(i_density[N_G / 2], 0.0);
}
```

---

### 4.3 Popychanie cząstek (`tests/test_push.cc`)

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class PushTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: KRYTYCZNY — znak przyspieszenia elektronu (vx -= FACTOR_E * E)
TEST_F(PushTest, ElectronPushSign) {
    N_e = 1;
    x_e[0] = L / 2.0;
    vx_e[0] = vy_e[0] = vz_e[0] = 0.0;
    for (int i = 0; i < N_G; i++) efield[i] = 1000.0;
    step3_move_electrons(0);
    EXPECT_LT(vx_e[0], 0.0);  // Ujemny ładunek elektronu przyspiesza w lewo przy E > 0
}

// Test B: interpolacja E-pola w połowie odległości między węzłami
TEST_F(PushTest, EfieldInterpolationMidpoint) {
    N_e = 1;
    int p0 = 100;
    x_e[0] = DX * (p0 + 0.5);
    vx_e[0] = 0.0;
    for (int i = 0; i < N_G; i++) efield[i] = 0.0;
    efield[p0]     = 200.0;
    efield[p0 + 1] = 400.0;
    step3_move_electrons(0);
    // e_x = 0.5*200 + 0.5*400 = 300 -> dv = -300 * FACTOR_E
    EXPECT_NEAR(vx_e[0], -300.0 * FACTOR_E, 1e-10);
}
```

---

### 4.4 Warunki brzegowe (`tests/test_boundaries.cc`)

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class BoundaryTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: fast-swap (zastąpienie usuwanej cząstki ostatnią aktywną cząstką)
TEST_F(BoundaryTest, FastSwapCorrectness) {
    N_e = 3;
    x_e[0] = L * 0.25;  vx_e[0] = 100.0;
    x_e[1] = -0.001;    vx_e[1] = 200.0;   // Wychodzi za lewą granicę
    x_e[2] = L * 0.75;  vx_e[2] = 300.0;   // Ostatnia cząstka
    step5_check_boundaries_electrons();
    
    EXPECT_EQ(N_e, 2);
    // Cząstka o indeksie 2 zastępuje usuniętą cząstkę o indeksie 1
    EXPECT_NEAR(x_e[1],  L * 0.75, 1e-15);
    EXPECT_NEAR(vx_e[1], 300.0,    1e-15);
}
```

---

## 5. Testy jednostkowe — Tier 2 (stochastyczne) (`tests/test_collisions.cc`)

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

class CollisionTest : public ::testing::Test {
protected:
    void SetUp() override {
        reset_state();
        seed_rng(42);
        set_electron_cross_sections_ar();
        set_ion_cross_sections_ar();
        calc_total_cross_sections();
    }
};

// Test A: jonizacja -> dodanie nowej pary elektron-jon (N_e++ i N_i++)
TEST_F(CollisionTest, IonizationCreatesParticlePair) {
    double energy_eV = 30.0;
    double g = sqrt(2.0 * energy_eV * EV_TO_J / E_MASS);
    double vx = g, vy = 0.0, vz = 0.0;
    int eindex = (int)(energy_eV / DE_CS);
    N_e = 1; N_i = 0;

    bool ionization_occurred = false;
    for (int trial = 0; trial < 500; trial++) {
        seed_rng(trial);
        int Ne_before = N_e, Ni_before = N_i;
        double tvx = vx, tvy = vy, tvz = vz;
        collision_electron(L / 2, &tvx, &tvy, &tvz, eindex);
        if (N_e > Ne_before) {
            EXPECT_EQ(N_e, Ne_before + 1);
            EXPECT_EQ(N_i, Ni_before + 1);
            ionization_occurred = true;
            break;
        }
    }
    EXPECT_TRUE(ionization_occurred);
}
```

---

## 6. Testy jednostkowe — Tier 3 (diagnostyczne) (`tests/test_diagnostics.cc`)

```cpp
#include <gtest/gtest.h>
#include "test_helpers.h"

TEST(DiagnosticsTest, DensityNormalizationFactor) {
    int nc = 10;
    double c = 1.0 / (double)nc / (double)N_T;
    EXPECT_NEAR(c, 1.0 / (nc * N_T), 1e-15);
}
```

---

## 7. Makefile / CMake

### Makefile (`C/tests/Makefile`)

```makefile
CXX      = g++
CXXFLAGS = -std=c++17 -O2 -Wall
LDFLAGS  = -lgtest -lgtest_main -lpthread

TEST_SRCS = test_poisson.cc test_density.cc test_push.cc \
            test_boundaries.cc test_cross_sections.cc \
            test_collisions.cc test_diagnostics.cc

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
    tests/test_collisions.cc
    tests/test_diagnostics.cc
)

target_include_directories(run_tests PRIVATE ${CMAKE_SOURCE_DIR})
target_link_libraries(run_tests GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(run_tests)
```

---

## 8. Checklist

| # | Test | Funkcja | Priorytet | Status |
|:-:|:-----|:--------|:---------:|:------:|
| 1 | `VacuumLinearPotential` | `solve_Poisson` | 🔴 | ☐ |
| 2 | `VacuumConstantEfield` | `solve_Poisson` | 🔴 | ☐ |
| 3 | `BoundaryEfieldWithCharge` | `solve_Poisson` | 🔴 | ☐ |
| 4 | `SingleParticleOnNode` | `step1_compute_electron_density` | 🔴 | ☐ |
| 5 | `BoundaryDoublingLeft` | `step1_compute_electron_density` | 🔴 | ☐ |
| 6 | `IonDensitySubcyclingGuard` | `step1_compute_ion_density` | 🔴 | ☐ |
| 7 | `ElectronPushSign` | `step3_move_electrons` | 🔴 | ☐ |
| 8 | `EfieldInterpolationMidpoint` | `step3_move_electrons` | 🟡 | ☐ |
| 9 | `FastSwapCorrectness` | `step5_check_boundaries` | 🔴 | ☐ |
| 10 | `IonizationCreatesParticlePair` | `collision_electron` | 🟡 | ☐ |
| R1 | Golden run — `density.dat` | `do_one_cycle` | 🔴 | ☐ |
| R2 | Golden run — `conv.dat` | `do_one_cycle` | 🔴 | ☐ |
