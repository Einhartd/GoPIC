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
    
    EXPECT_NEAR(vx_e[0], expected_v, 1e-5);
    EXPECT_NEAR(x_e[0],  expected_x, 1e-10);
}