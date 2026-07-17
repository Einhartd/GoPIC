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
    EXPECT_NEAR(x_e[1],  L * 0.75, 1e-12);
    EXPECT_NEAR(vx_e[1], 30.0,    1e-12);
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