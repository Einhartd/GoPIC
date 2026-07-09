# Plan testów — wersja C (eduPIC.cc)

Plik źródłowy: [`C/eduPIC.cc`](../C/eduPIC.cc)  
Framework: [Google Test (gtest)](https://github.com/google/googletest)  
Alternatywa: [Catch2 v3](https://github.com/catchorg/Catch2) (header-only, zero zależności zewnętrznych)

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

### Problem: globalny stan

`eduPIC.cc` używa wyłącznie zmiennych globalnych. Aby testy były izolowane:

**Opcja A — Plik nagłówkowy ze stanem (preferowana):**
```
C/
├── eduPIC.cc          <- produkcja (bez zmian)
├── eduPIC_core.h      <- wyciągnięte deklaracje + implementacje funkcji
└── tests/
    ├── test_poisson.cc
    ├── test_density.cc
    ├── test_push.cc
    ├── test_boundaries.cc
    ├── test_cross_sections.cc
    ├── test_collisions.cc
    └── test_regression.cc
```

**Opcja B — Kompilacja z `-DTESTING` flagą:**
```cpp
// W eduPIC.cc dodaj:
#ifndef TESTING
int main(...) { ... }
#endif
```
Wtedy testy linkują `eduPIC.o` bezpośrednio i mają dostęp do wszystkich globalnych.

**Rekomendacja: Opcja B** — zero refaktoryzacji produkcji, pełen dostęp do stanu.

### Pomocniczy helper: reset stanu

```cpp
// tests/test_helpers.h
#pragma once

// Resetuje cały globalny stan przed każdym testem
inline void reset_state() {
    N_e = 0; N_i = 0;
    N_e_abs_pow = 0; N_e_abs_gnd = 0;
    N_i_abs_pow = 0; N_i_abs_gnd = 0;
    N_e_coll = 0;    N_i_coll = 0;
    Time = 0.0;
    for (int i = 0; i < N_G; i++) {
        e_density[i] = 0.0; i_density[i] = 0.0;
        cumul_e_density[i] = 0.0; cumul_i_density[i] = 0.0;
        efield[i] = 0.0; pot[i] = 0.0;
    }
    std::fill(std::begin(eepf), std::end(eepf), 0.0);
    std::fill(std::begin(ifed_pow), std::end(ifed_pow), 0);
    std::fill(std::begin(ifed_gnd), std::end(ifed_gnd), 0);
}

// Seed deterministyczny RNG — wymagany dla testów regresyjnych
inline void seed_rng(uint64_t seed = 42) {
    MTgen.seed(seed);
}
```

---

## 2. Konfiguracja środowiska

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
# Pobierz catch2.hpp do tests/
curl -LO https://github.com/catchorg/Catch2/releases/download/v3.7.1/catch_amalgamated.hpp
```

---

## 3. Testy regresyjne (golden run)

### Cel

Zagwarantować, że żadna zmiana nie modyfikuje fizyki symulacji. Idealne do CI/CD.

### Krok 1: Zmień seed RNG na deterministyczny

```cpp
// W eduPIC.cc zamień:
std::mt19937 MTgen(rd());
// na:
std::mt19937 MTgen(42ULL);   // fixed seed — TYLKO W TRYBIE TESTOWYM
```

Lub lepiej z flagą kompilacji:
```cpp
#ifdef TESTING
std::mt19937 MTgen(42ULL);
#else
std::mt19937 MTgen(rd());
#endif
```

### Krok 2: Wygeneruj golden output

```bash
g++ -DTESTING -O2 -o eduPIC_test C/eduPIC.cc
./eduPIC_test 0          # 1 cykl inicjalizacyjny
./eduPIC_test 5          # 5 cykli produkcyjnych
cp density.dat tests/golden/density_golden.dat
cp conv.dat    tests/golden/conv_golden.dat
```

### Krok 3: Skrypt regresyjny

```bash
#!/bin/bash
# tests/run_regression.sh

set -e
echo "=== Budowanie ==="
g++ -DTESTING -O2 -o eduPIC_test ../C/eduPIC.cc

echo "=== Uruchamianie symulacji ==="
rm -f picdata.bin
./eduPIC_test 0        # init
./eduPIC_test 5 m      # 5 cykli + measurement

echo "=== Porównanie z golden ==="
diff density.dat golden/density_golden.dat || { echo "FAIL: density.dat differs"; exit 1; }
diff conv.dat    golden/conv_golden.dat    || { echo "FAIL: conv.dat differs"; exit 1; }

echo "=== Porównanie numeryczne eepf.dat (tolerancja 1e-10) ==="
python3 compare_numeric.py eepf.dat golden/eepf_golden.dat 1e-10

echo "=== OK: wszystkie testy regresyjne przeszły ==="
```

### Krok 4: Skrypt porównania numerycznego

```python
# tests/compare_numeric.py
import sys
import numpy as np

file1, file2, tol = sys.argv[1], sys.argv[2], float(sys.argv[3])
a = np.loadtxt(file1)
b = np.loadtxt(file2)
assert a.shape == b.shape, f"Shape mismatch: {a.shape} vs {b.shape}"
rel_err = np.max(np.abs(a - b) / (np.abs(b) + 1e-30))
assert rel_err < tol, f"Max relative error {rel_err:.2e} exceeds tolerance {tol}"
print(f"OK: max relative error = {rel_err:.2e}")
```

---

## 4. Testy jednostkowe — Tier 1 (deterministyczne)

### 4.1 `solve_Poisson` — solver Thomasa

```cpp
// tests/test_poisson.cc
#include <gtest/gtest.h>
// Zakładamy kompilację z -DTESTING i eduPIC.cc w LDFLAGS
#include "test_helpers.h"

class PoissonTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); seed_rng(); }
};

// Test A: potencjał liniowy w próżni
// Przy ρ=0, pot[0]=V0, pot[N_G-1]=0 → potencjał MUSI być liniowy
TEST_F(PoissonTest, VacuumLinearPotential) {
    const double V0 = 250.0;
    xvector rho = {};  // zero charge density
    // tt=0 → VOLTAGE*cos(0) = VOLTAGE = V0
    solve_Poisson(rho, 0.0);

    for (int i = 1; i < N_G - 1; i++) {
        double expected = V0 * (1.0 - (double)i / (N_G - 1));
        EXPECT_NEAR(pot[i], expected, 1e-8) << "Blad w wezle i=" << i;
    }
}

// Test B: E-pole stałe w próżni
// E = V0 / L dla liniowego potencjału
TEST_F(PoissonTest, VacuumConstantEfield) {
    const double V0 = 250.0;
    xvector rho = {};
    solve_Poisson(rho, 0.0);

    const double E_expected = V0 / L;
    for (int i = 1; i < N_G - 2; i++) {
        EXPECT_NEAR(efield[i], E_expected, 1e-6) << "Blad E-pola w wezle i=" << i;
    }
}

// Test C: warunki graniczne E-pola z rho!=0 na granicy
// efield[0] = (pot[0]-pot[1])*INV_DX - rho[0]*DX/(2*EPSILON0)
TEST_F(PoissonTest, BoundaryEfieldWithCharge) {
    xvector rho = {};
    rho[0]     = 1e15 * E_CHARGE;
    rho[N_G-1] = 1e15 * E_CHARGE;
    solve_Poisson(rho, 0.0);

    double expected_e0 = (pot[0] - pot[1]) * INV_DX - rho[0] * DX / (2.0 * EPSILON0);
    double expected_eN = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho[N_G-1] * DX / (2.0 * EPSILON0);
    EXPECT_NEAR(efield[0],     expected_e0, 1e-6);
    EXPECT_NEAR(efield[N_G-1], expected_eN, 1e-6);
}

// Test D: pot[N_G/2] ≈ V0/2 przy liniowym potencjale
TEST_F(PoissonTest, MidpointPotential) {
    xvector rho = {};
    solve_Poisson(rho, 0.0);
    EXPECT_NEAR(pot[N_G / 2], 250.0 * 0.5, 1.0);
}

// Test E: Gauss — dywergencja E-pola odpowiada ładunkowi
TEST_F(PoissonTest, GaussLaw) {
    const double rho_val = 1e15 * E_CHARGE;
    xvector rho;
    for (int i = 0; i < N_G; i++) rho[i] = rho_val;
    solve_Poisson(rho, 0.0);
    double div_E = (efield[N_G-1] - efield[0]) / L;
    EXPECT_NEAR(div_E, rho_val / EPSILON0, rho_val / EPSILON0 * 0.01);
}
```

---

### 4.2 `step1_compute_electron_density` — ważenie liniowe

```cpp
// tests/test_density.cc

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
    EXPECT_NEAR(e_density[p0 - 1], 0.0,      1e-10);
}

// Test B: cząstka w połowie między węzłami
TEST_F(DensityTest, SingleParticleMidpoint) {
    int p0 = 100;
    N_e = 1;
    x_e[0] = DX * (p0 + 0.5);
    step1_compute_electron_density();

    EXPECT_NEAR(e_density[p0],     0.5 * FACTOR_W, 1e-10);
    EXPECT_NEAR(e_density[p0 + 1], 0.5 * FACTOR_W, 1e-10);
}

// Test C: zachowanie masy
TEST_F(DensityTest, MassConservation) {
    N_e = 50;
    for (int k = 0; k < N_e; k++)
        x_e[k] = DX + (L - 2 * DX) * k / (N_e - 1);
    step1_compute_electron_density();

    double total = 0.0;
    for (int p = 0; p < N_G; p++) total += e_density[p] * DX * ELECTRODE_AREA;
    EXPECT_NEAR(total, (double)N_e * WEIGHT, (double)N_e * WEIGHT * 0.01);
}

// Test D: KRYTYCZNY — korekta x2 na lewej granicy
TEST_F(DensityTest, BoundaryDoublingLeft) {
    N_e = 1;
    x_e[0] = DX * 0.5;  // pół węzła od lewej granicy
    step1_compute_electron_density();
    // Bez korekcji: e_density[0] = 0.5*FACTOR_W
    // Z korekcją x2: e_density[0] = FACTOR_W
    EXPECT_NEAR(e_density[0], FACTOR_W,       1e-10);
    EXPECT_NEAR(e_density[1], 0.5 * FACTOR_W, 1e-10);
}

// Test E: KRYTYCZNY — korekta x2 na prawej granicy
TEST_F(DensityTest, BoundaryDoublingRight) {
    N_e = 1;
    x_e[0] = L - DX * 0.5;
    step1_compute_electron_density();
    int last = N_G - 1;
    EXPECT_NEAR(e_density[last],     FACTOR_W,       1e-10);
    EXPECT_NEAR(e_density[last - 1], 0.5 * FACTOR_W, 1e-10);
}

// Test F: cumul_e_density akumuluje w każdym kroku
TEST_F(DensityTest, CumulativeDensityAccumulation) {
    N_e = 1;
    x_e[0] = L / 2.0;
    step1_compute_electron_density();
    double after_step1 = cumul_e_density[N_G / 2];
    step1_compute_electron_density();
    double after_step2 = cumul_e_density[N_G / 2];
    EXPECT_NEAR(after_step2, 2.0 * after_step1, 1e-10);
}

// Test G: subcycling guard dla jonów
TEST_F(DensityTest, IonDensitySubcyclingGuard) {
    N_i = 1;
    x_i[0] = L / 2.0;
    // t != wielokrotnosc N_SUB — i_density musi pozostac 0
    step1_compute_ion_density(1);
    EXPECT_NEAR(i_density[N_G / 2], 0.0, 1e-15);
    // t == wielokrotnosc N_SUB — i_density musi byc obliczona
    step1_compute_ion_density(0);
    EXPECT_GT(i_density[N_G / 2], 0.0);
}
```

---

### 4.3 `step3_move_electrons` / `step4_move_ions` — push leapfrog

```cpp
// tests/test_push.cc

class PushTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); measurement_mode = false; }
};

// Test A: KRYTYCZNY — znak przyspieszenia elektronu
// Elektron (-e) w polu E > 0 przyspiesza w -x: vx -= FACTOR_E * E
TEST_F(PushTest, ElectronPushSign) {
    N_e = 1;
    x_e[0] = L / 2.0;
    vx_e[0] = vy_e[0] = vz_e[0] = 0.0;
    for (int i = 0; i < N_G; i++) efield[i] = 1000.0;
    step3_move_electrons(0);
    EXPECT_LT(vx_e[0], 0.0);
    EXPECT_NEAR(vy_e[0], 0.0, 1e-15);
    EXPECT_NEAR(vz_e[0], 0.0, 1e-15);
}

// Test B: KRYTYCZNY — znak przyspieszenia jonu
// Jon (+e) w polu E > 0 przyspiesza w +x: vx += FACTOR_I * E
TEST_F(PushTest, IonPushSign) {
    N_i = 1;
    x_i[0] = L / 2.0;
    vx_i[0] = vy_i[0] = vz_i[0] = 0.0;
    for (int i = 0; i < N_G; i++) efield[i] = 1000.0;
    step4_move_ions(0, 0);  // t=0 → t%N_SUB==0
    EXPECT_GT(vx_i[0], 0.0);
}

// Test C: swobodny ruch przy E=0
TEST_F(PushTest, FreeStreamingElectron) {
    N_e = 1;
    x_e[0] = L / 2.0;
    vx_e[0] = 1e5;
    for (int i = 0; i < N_G; i++) efield[i] = 0.0;
    double x_before = x_e[0];
    step3_move_electrons(0);
    EXPECT_NEAR(x_e[0], x_before + 1e5 * DT_E, 1e-15);
    EXPECT_NEAR(vx_e[0], 1e5, 1e-15);
}

// Test D: interpolacja E-pola — cząstka na węźle
TEST_F(PushTest, EfieldInterpolationOnNode) {
    N_e = 1;
    int p0 = 100;
    x_e[0] = DX * p0;
    vx_e[0] = 0.0;
    for (int i = 0; i < N_G; i++) efield[i] = 0.0;
    efield[p0] = 500.0;
    step3_move_electrons(0);
    EXPECT_NEAR(vx_e[0], -500.0 * FACTOR_E, 1e-10);
}

// Test E: interpolacja E-pola — cząstka w połowie
TEST_F(PushTest, EfieldInterpolationMidpoint) {
    N_e = 1;
    int p0 = 100;
    x_e[0] = DX * (p0 + 0.5);
    vx_e[0] = 0.0;
    for (int i = 0; i < N_G; i++) efield[i] = 0.0;
    efield[p0]     = 200.0;
    efield[p0 + 1] = 400.0;
    step3_move_electrons(0);
    // e_x = 0.5*200 + 0.5*400 = 300 → dv = -300 * FACTOR_E
    EXPECT_NEAR(vx_e[0], -300.0 * FACTOR_E, 1e-10);
}

// Test F: subcycling guard — jon nie rusza gdy t%N_SUB != 0
TEST_F(PushTest, IonSubcyclingGuard) {
    N_i = 1;
    x_i[0] = L / 2.0;
    vx_i[0] = 0.0;
    for (int i = 0; i < N_G; i++) efield[i] = 1000.0;
    step4_move_ions(0, 1);  // t=1 → t%N_SUB != 0
    EXPECT_NEAR(vx_i[0], 0.0, 1e-15);
}
```

---

### 4.4 `step5/6_check_boundaries` — usuwanie cząstek

```cpp
// tests/test_boundaries.cc

class BoundaryTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); measurement_mode = false; }
};

// Test A: elektron na lewej granicy
TEST_F(BoundaryTest, ElectronAbsorbedAtPowered) {
    N_e = 1; x_e[0] = -0.001;
    step5_check_boundaries_electrons();
    EXPECT_EQ(N_e, 0);
    EXPECT_EQ(N_e_abs_pow, 1ULL);
    EXPECT_EQ(N_e_abs_gnd, 0ULL);
}

// Test B: elektron na prawej granicy
TEST_F(BoundaryTest, ElectronAbsorbedAtGrounded) {
    N_e = 1; x_e[0] = L + 0.001;
    step5_check_boundaries_electrons();
    EXPECT_EQ(N_e, 0);
    EXPECT_EQ(N_e_abs_gnd, 1ULL);
    EXPECT_EQ(N_e_abs_pow, 0ULL);
}

// Test C: elektron wewnątrz — nie usuwany
TEST_F(BoundaryTest, ElectronInsideNotRemoved) {
    N_e = 1; x_e[0] = L / 2.0;
    step5_check_boundaries_electrons();
    EXPECT_EQ(N_e, 1);
    EXPECT_EQ(N_e_abs_pow, 0ULL);
    EXPECT_EQ(N_e_abs_gnd, 0ULL);
}

// Test D: fast-swap — poprawnosc po usunieciu srodkowej czastki
// Czastki: [dobra, ZLA, dobra] -> po usunieciu ZLej: [dobra, dobra]
TEST_F(BoundaryTest, FastSwapCorrectness) {
    N_e = 3;
    x_e[0] = L * 0.25;  vx_e[0] = 100.0;
    x_e[1] = -0.001;    vx_e[1] = 200.0;   // wychodzi
    x_e[2] = L * 0.75;  vx_e[2] = 300.0;
    step5_check_boundaries_electrons();
    EXPECT_EQ(N_e, 2);
    // Czastka 2 zastapila czastke 1
    EXPECT_NEAR(x_e[1],  L * 0.75, 1e-15);
    EXPECT_NEAR(vx_e[1], 300.0,    1e-15);
}

// Test E: wszystkie czastki na zewnatrz
TEST_F(BoundaryTest, AllElectronsAbsorbed) {
    N_e = 10;
    for (int k = 0; k < 5; k++)  x_e[k] = -0.001;
    for (int k = 5; k < 10; k++) x_e[k] = L + 0.001;
    step5_check_boundaries_electrons();
    EXPECT_EQ(N_e, 0);
    EXPECT_EQ(N_e_abs_pow, 5ULL);
    EXPECT_EQ(N_e_abs_gnd, 5ULL);
}

// Test F: energia jonu rejestrowana w IFED
TEST_F(BoundaryTest, IonEnergyRecordedInIFED) {
    N_i = 1;
    x_i[0]  = -0.001;
    vx_i[0] = 1000.0; vy_i[0] = 0.0; vz_i[0] = 0.0;
    double energy = 0.5 * AR_MASS * 1000.0 * 1000.0 / EV_TO_J;
    int expected_bin = (int)(energy / DE_IFED);
    step6_check_boundaries_ions(0);
    EXPECT_EQ(N_i, 0);
    EXPECT_EQ(N_i_abs_pow, 1ULL);
    if (expected_bin < N_IFED)
        EXPECT_EQ(ifed_pow[expected_bin], 1);
}
```

---

### 4.5 `set_electron_cross_sections_ar` / `calc_total_cross_sections`

```cpp
// tests/test_cross_sections.cc

class CrossSectionTest : public ::testing::Test {
protected:
    void SetUp() override {
        set_electron_cross_sections_ar();
        set_ion_cross_sections_ar();
        calc_total_cross_sections();
    }
};

// Test A: progi energetyczne excytacji
TEST_F(CrossSectionTest, ExcitationThreshold) {
    for (int i = 0; i < (int)(11.5 / DE_CS); i++)
        EXPECT_NEAR(sigma[E_EXC][i], 0.0f, 1e-30f) << "bin=" << i;
    EXPECT_GT(sigma[E_EXC][(int)(12.0 / DE_CS)], 0.0f);
}

// Test B: progi energetyczne jonizacji
TEST_F(CrossSectionTest, IonizationThreshold) {
    for (int i = 0; i < (int)(15.8 / DE_CS); i++)
        EXPECT_NEAR(sigma[E_ION][i], 0.0f, 1e-30f) << "bin=" << i;
    EXPECT_GT(sigma[E_ION][(int)(16.0 / DE_CS)], 0.0f);
}

// Test C: przekroje elastyczne sa zawsze nieujemne
TEST_F(CrossSectionTest, ElasticAlwaysPositive) {
    for (int i = 1; i < CS_RANGES; i++)
        EXPECT_GE(sigma[E_ELA][i], 0.0f) << "bin=" << i;
}

// Test D: formula calkowitego przekroju
TEST_F(CrossSectionTest, TotalCrossSectionFormula) {
    for (int i = 0; i < CS_RANGES; i += 1000) {
        float expected = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * (float)GAS_DENSITY;
        EXPECT_NEAR(sigma_tot_e[i], expected, expected * 1e-5f);
    }
}

// Test E: rzad wielkosci przy znanych energiach
TEST_F(CrossSectionTest, KnownElasticValueAt1eV) {
    int idx = (int)(1.0 / DE_CS);
    EXPECT_GT(sigma[E_ELA][idx], 0.5e-20);
    EXPECT_LT(sigma[E_ELA][idx], 10.0e-20);
}
```

---

## 5. Testy jednostkowe — Tier 2 (stochastyczne)

```cpp
// tests/test_collisions.cc

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

// Test A: jonizacja -> N_e++ i N_i++
TEST_F(CollisionTest, IonizationCreatesParticlePair) {
    double energy_eV = 30.0;   // powyzej progu 15.8 eV
    double g = sqrt(2.0 * energy_eV * EV_TO_J / E_MASS);
    double vx = g, vy = 0.0, vz = 0.0;
    int eindex = (int)(energy_eV / DE_CS);
    N_e = 1; N_i = 0;

    bool ionization_occurred = false;
    for (int trial = 0; trial < 500; trial++) {
        seed_rng(trial);
        int Ne_before = N_e, Ni_before = N_i;
        double tvx = vx, tvy = vy, tvz = vz;
        collision_electron(L/2, &tvx, &tvy, &tvz, eindex);
        if (N_e > Ne_before) {
            EXPECT_EQ(N_e, Ne_before + 1);
            EXPECT_EQ(N_i, Ni_before + 1);
            ionization_occurred = true;
            break;
        }
    }
    EXPECT_TRUE(ionization_occurred);
}

// Test B: kolizja jonow zachowuje ped
TEST_F(CollisionTest, IonCollisionMomentumConservation) {
    double vx1 = 1000.0, vy1 = 0.0, vz1 = 0.0;
    double vx2 =    0.0, vy2 = 0.0, vz2 = 0.0;  // atom w spoczynku
    double gx = vx1 - vx2;
    double energy_com = 0.5 * MU_ARAR * gx * gx / EV_TO_J;
    int eindex = (int)(energy_com / DE_CS);
    double p_before = AR_MASS * vx1 + AR_MASS * vx2;

    collision_ion(&vx1, &vy1, &vz1, &vx2, &vy2, &vz2, eindex);

    double p_after = AR_MASS * (vx1 + vx2);
    EXPECT_NEAR(p_after, p_before, std::abs(p_before) * 1e-10);
}

// Test C: excytacja ponizej progu nie zachodzi (sigma=0)
TEST_F(CollisionTest, ExcitationBelowThresholdImpossible) {
    // Przy 5 eV: sigma[E_EXC] = 0 → typ kolizji nie moze byc excytacja
    double energy_eV = 5.0;
    int eindex = (int)(energy_eV / DE_CS);
    EXPECT_NEAR(sigma[E_EXC][eindex], 0.0f, 1e-30f)
        << "sigma_exc musi byc 0 ponizej 11.5 eV";
}
```

---

## 6. Testy jednostkowe — Tier 3 (diagnostyczne)

```cpp
// tests/test_diagnostics.cc

// Test A: formula normalizacji density
TEST(DiagnosticsTest, DensityNormalizationFactor) {
    int nc = 10;
    double c = 1.0 / (double)nc / (double)N_T;
    EXPECT_NEAR(c, 1.0 / (nc * N_T), 1e-15);
}

// Test B: formula normalizacji XT f1
TEST(DiagnosticsTest, XTNormalizationF1) {
    int nc = 5;
    double f1 = (double)N_XT / (double)(nc * N_T);
    EXPECT_NEAR(f1, (double)N_XT / (nc * N_T), 1e-15);
}
```

---

## 7. Makefile / CMake

### Makefile (prosty)

```makefile
# C/tests/Makefile
CXX      = g++
CXXFLAGS = -std=c++17 -O2 -Wall -DTESTING
LDFLAGS  = -lgtest -lgtest_main -lpthread

SRCS = test_poisson.cc test_density.cc test_push.cc \
       test_boundaries.cc test_cross_sections.cc \
       test_collisions.cc test_diagnostics.cc

all: run_tests
	./run_tests

run_tests: $(SRCS) test_helpers.h
	$(CXX) $(CXXFLAGS) $(SRCS) $(LDFLAGS) -I.. -o run_tests

regression:
	bash run_regression.sh

clean:
	rm -f run_tests
```

### CMakeLists.txt (z automatycznym pobraniem gtest)

```cmake
cmake_minimum_required(VERSION 3.14)
project(eduPIC_C_tests CXX)
set(CMAKE_CXX_STANDARD 17)

include(FetchContent)
FetchContent_Declare(googletest
  URL https://github.com/google/googletest/archive/v1.14.0.zip)
FetchContent_MakeAvailable(googletest)

add_compile_definitions(TESTING)

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

```bash
# Uruchomienie
cmake -B build -S . && cmake --build build && ./build/run_tests
```

---

## 8. Checklist

| # | Test | Funkcja | Priorytet | Status |
|:-:|:-----|:--------|:---------:|:------:|
| 1 | `VacuumLinearPotential` | `solve_Poisson` | 🔴 | ☐ |
| 2 | `VacuumConstantEfield` | `solve_Poisson` | 🔴 | ☐ |
| 3 | `BoundaryEfieldWithCharge` | `solve_Poisson` | 🔴 | ☐ |
| 4 | `GaussLaw` | `solve_Poisson` | 🟡 | ☐ |
| 5 | `SingleParticleOnNode` | `step1_compute_electron_density` | 🔴 | ☐ |
| 6 | `SingleParticleMidpoint` | `step1_compute_electron_density` | 🔴 | ☐ |
| 7 | `BoundaryDoublingLeft` | `step1_compute_electron_density` | 🔴 | ☐ |
| 8 | `BoundaryDoublingRight` | `step1_compute_electron_density` | 🔴 | ☐ |
| 9 | `MassConservation` | `step1_compute_electron_density` | 🟡 | ☐ |
| 10 | `CumulativeDensityAccumulation` | `step1_compute_electron_density` | 🔴 | ☐ |
| 11 | `IonDensitySubcyclingGuard` | `step1_compute_ion_density` | 🔴 | ☐ |
| 12 | `ElectronPushSign` | `step3_move_electrons` | 🔴 | ☐ |
| 13 | `IonPushSign` | `step4_move_ions` | 🔴 | ☐ |
| 14 | `FreeStreamingElectron` | `step3_move_electrons` | 🟡 | ☐ |
| 15 | `EfieldInterpolationOnNode` | `step3_move_electrons` | 🟡 | ☐ |
| 16 | `EfieldInterpolationMidpoint` | `step3_move_electrons` | 🟡 | ☐ |
| 17 | `IonSubcyclingGuard` | `step4_move_ions` | 🔴 | ☐ |
| 18 | `ElectronAbsorbedAtPowered` | `step5_check_boundaries` | 🔴 | ☐ |
| 19 | `ElectronAbsorbedAtGrounded` | `step5_check_boundaries` | 🔴 | ☐ |
| 20 | `FastSwapCorrectness` | `step5_check_boundaries` | 🔴 | ☐ |
| 21 | `AllElectronsAbsorbed` | `step5_check_boundaries` | 🟡 | ☐ |
| 22 | `IonEnergyRecordedInIFED` | `step6_check_boundaries` | 🟡 | ☐ |
| 23 | `ExcitationThreshold` | `set_electron_cross_sections_ar` | 🔴 | ☐ |
| 24 | `IonizationThreshold` | `set_electron_cross_sections_ar` | 🔴 | ☐ |
| 25 | `TotalCrossSectionFormula` | `calc_total_cross_sections` | 🔴 | ☐ |
| 26 | `IonizationCreatesParticlePair` | `collision_electron` | 🟡 | ☐ |
| 27 | `IonCollisionMomentumConservation` | `collision_ion` | 🟡 | ☐ |
| R1 | Golden run — `density.dat` | `do_one_cycle` | 🔴 | ☐ |
| R2 | Golden run — `conv.dat` | `do_one_cycle` | 🔴 | ☐ |
| R3 | Golden run — `eepf.dat` | `do_one_cycle` | 🟡 | ☐ |
