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
        EXPECT_NEAR(pot[i], expected, 1e-11) << "Niezgodność potencjału w weźle i=" << i;
    }
}

// Test B: E-pole stałe w próżni (E = V0 / L)
TEST_F(PoissonTest, VacuumConstantEfield) {
    xvector rho = {};
    solve_Poisson(rho, 0.0);
    const double E_expected = VOLTAGE / L;
    
    // Węzły wewnętrzne (pochodna różnic centralnych)
    for (int i = 1; i < N_G - 1; i++) {
        EXPECT_NEAR(efield[i], E_expected, 1e-8) << "Niezgodność E-pola w weźle i=" << i;
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
                         
    EXPECT_NEAR(efield[0],     expected_e0, 1e-8);
    EXPECT_NEAR(efield[N_G-1], expected_eN, 1e-8);
}