#include <gtest/gtest.h>
#include "test_helpers.h"
#include <unordered_set>
#include <vector>

class NullCollisionTest : public ::testing::Test {
protected:
    void SetUp() override {
        reset_state();
        set_electron_cross_sections_ar();
        set_ion_cross_sections_ar();
        calc_total_cross_sections();
        
        // Zapewniamy, że parametry zostaną policzone
        compute_null_collision_params();
    }
};

TEST_F(NullCollisionTest, ParamsPrecomputation) {
    // 1. Sprawdzamy, czy maksymalne częstości kolizji są dodatnie
    EXPECT_GT(nu_star_e, 0.0);
    EXPECT_GT(nu_star_i, 0.0);

    // 2. Sprawdzamy, czy prawdopodobieństwa leżą w granicach [0, 1]
    EXPECT_GE(P_star_e, 0.0);
    EXPECT_LE(P_star_e, 1.0);
    EXPECT_GE(P_star_i, 0.0);
    EXPECT_LE(P_star_i, 1.0);

    // 3. Sprawdzamy warunek stabilności fizycznej (prawdopodobieństwo < 5%)
    EXPECT_LT(P_star_e, 0.05);
    EXPECT_LT(P_star_i, 0.05);

    // 4. Weryfikujemy, czy nu_star_e jest rzeczywiście maksymalną częstością elektronów
    for (int i = 0; i < CS_RANGES; i++) {
        double e = (i == 0) ? DE_CS : i * DE_CS;
        double v = sqrt(2.0 * e * EV_TO_J / E_MASS);
        double nu = sigma_tot_e[i] * v;
        EXPECT_LE(nu, nu_star_e + 1e-9); // tolerancja zmiennoprzecinkowa
    }

    // 5. Weryfikujemy, czy nu_star_i jest rzeczywiście maksymalną częstością jonów
    for (int i = 0; i < CS_RANGES; i++) {
        double e = (i == 0) ? DE_CS : i * DE_CS;
        double g = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
        double nu = sigma_tot_i[i] * g;
        EXPECT_LE(nu, nu_star_i + 1e-9);
    }
}

TEST_F(NullCollisionTest, RandomSampleUniqueness) {
    seed_rng(42);
    int n = 1000;
    int count = 50;
    std::vector<int> out;
    
    random_sample(n, count, out);
    
    // 1. Sprawdzamy oczekiwany rozmiar próbki
    ASSERT_EQ(out.size(), count);
    
    // 2. Sprawdzamy unikalność wylosowanych indeksów oraz zakres [0, n)
    std::unordered_set<int> unique_indices;
    for (int idx : out) {
        EXPECT_GE(idx, 0);
        EXPECT_LT(idx, n);
        EXPECT_EQ(unique_indices.count(idx), 0) << "Znaleziono zduplikowany indeks: " << idx;
        unique_indices.insert(idx);
    }
}
