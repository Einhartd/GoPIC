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