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

    EXPECT_NEAR(e_density[p0],     FACTOR_W, 1e-2);
    EXPECT_NEAR(e_density[p0 + 1], 0.0,      1e-2);
    EXPECT_NEAR(e_density[p0 - 1], 0.0,      1e-2);
}

// Test B: Korekta x2 na lewym brzegu (x_e = 0.5 * DX)
TEST_F(DensityTest, BoundaryDoublingLeft) {
    N_e = 1;
    x_e[0] = DX * 0.5;
    step1_compute_electron_density();
    
    // Węzeł 0 powinien otrzymać 0.5 * W, po korekcie *2 -> W
    // Węzeł 1 powinien otrzymać 0.5 * W (brak korekty)
    EXPECT_NEAR(e_density[0], FACTOR_W,       1e-2);
    EXPECT_NEAR(e_density[1], 0.5 * FACTOR_W, 1e-2);
}

// Test C: Korekta x2 na prawym brzegu (x_e = L - 0.25 * DX)
TEST_F(DensityTest, BoundaryDoublingRight) {
    N_e = 1;
    x_e[0] = L - DX * 0.25; // index: N_G - 1.25
    step1_compute_electron_density();
    
    // Węzeł N_G-2: 0.25 * W
    // Węzeł N_G-1: 0.75 * W, po korekcie *2 -> 1.5 * W
    EXPECT_NEAR(e_density[N_G - 2], 0.25 * FACTOR_W, 1e-2);
    EXPECT_NEAR(e_density[N_G - 1], 1.50 * FACTOR_W, 1e-2);
}