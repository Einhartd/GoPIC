#include <gtest/gtest.h>
#include "test_helpers.h"
#include <unordered_set>
#include <vector>
#include <omp.h>

class HybridNullCollisionTest : public ::testing::Test {
protected:
    void SetUp() override {
        reset_state();
        set_electron_cross_sections_ar();
        set_ion_cross_sections_ar();
        calc_total_cross_sections();
        compute_null_collision_params();
    }
};

TEST_F(HybridNullCollisionTest, PrecomputationAndStability) {
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
}

TEST_F(HybridNullCollisionTest, ThreadLocalRandomSampleUniqueness) {
    seed_rng(42);
    int n = 1000;
    int count = 50;

    #pragma omp parallel
    {
        std::vector<int> out;
        random_sample(n, count, out);
        
        EXPECT_EQ((int)out.size(), count);
        
        std::unordered_set<int> unique_indices;
        for (int idx : out) {
            EXPECT_GE(idx, 0);
            EXPECT_LT(idx, n);
            EXPECT_EQ(unique_indices.count(idx), 0) << "Zduplikowany indeks na wątku: " << idx;
            unique_indices.insert(idx);
        }
    }
}
