#include <gtest/gtest.h>
#include "test_helpers.h"
#include <omp.h>
#include <vector>
#include <algorithm>
#include <tuple>

class SortTest : public ::testing::Test {
protected:
    void SetUp() override {
        reset_state();
    }
};

TEST_F(SortTest, OrderingCorrectness) {
    N_e = 50000;
    seed_rng(42);
    for (int k = 0; k < N_e; k++) {
        x_e[k]  = L * R01(MTgen);
        vx_e[k] = 1e5 * (R01(MTgen) - 0.5);
        vy_e[k] = 2e5 * (R01(MTgen) - 0.5);
        vz_e[k] = 3e5 * (R01(MTgen) - 0.5);
    }

    omp_set_num_threads(4);
    sort_particles_by_cell(x_e, vx_e, vy_e, vz_e, N_e);

    // Verify cell monotonicity
    for (int k = 0; k < N_e - 1; k++) {
        int cell_current = int(x_e[k] * INV_DX);
        if (cell_current < 0) cell_current = 0;
        if (cell_current >= N_G - 1) cell_current = N_G - 2;

        int cell_next = int(x_e[k + 1] * INV_DX);
        if (cell_next < 0) cell_next = 0;
        if (cell_next >= N_G - 1) cell_next = N_G - 2;

        EXPECT_LE(cell_current, cell_next) << "Sorting violation at index " << k;
    }
}

TEST_F(SortTest, AttributesIntegrityPreserved) {
    N_e = 10000;
    seed_rng(123);
    
    // Store original tuples: (x, vx, vy, vz)
    std::vector<std::tuple<double, double, double, double>> orig_particles(N_e);
    for (int k = 0; k < N_e; k++) {
        x_e[k]  = L * R01(MTgen);
        vx_e[k] = 1000.0 + k;
        vy_e[k] = 2000.0 + 2 * k; // Distinct from vz
        vz_e[k] = 3000.0 + 3 * k;
        orig_particles[k] = {x_e[k], vx_e[k], vy_e[k], vz_e[k]};
    }

    omp_set_num_threads(4);
    sort_particles_by_cell(x_e, vx_e, vy_e, vz_e, N_e);

    // Verify that vy is NOT equal to vz
    for (int k = 0; k < N_e; k++) {
        EXPECT_NE(vy_e[k], vz_e[k]) << "vy_e must not be corrupted by vz_e!";
    }

    // Verify each sorted particle corresponds to an original particle
    // by checking that vx, vy, vz match the formula vx = 1000 + id
    for (int k = 0; k < N_e; k++) {
        int id = (int)(vx_e[k] - 1000.0 + 0.5);
        ASSERT_GE(id, 0);
        ASSERT_LT(id, N_e);
        EXPECT_DOUBLE_EQ(vy_e[k], 2000.0 + 2 * id);
        EXPECT_DOUBLE_EQ(vz_e[k], 3000.0 + 3 * id);
        EXPECT_DOUBLE_EQ(x_e[k], std::get<0>(orig_particles[id]));
    }
}

TEST_F(SortTest, EdgeCases) {
    // 0 particles
    sort_particles_by_cell(x_e, vx_e, vy_e, vz_e, 0);

    // 1 particle
    N_e = 1;
    x_e[0] = 0.5 * L; vx_e[0] = 10.0; vy_e[0] = 20.0; vz_e[0] = 30.0;
    sort_particles_by_cell(x_e, vx_e, vy_e, vz_e, 1);
    EXPECT_DOUBLE_EQ(x_e[0], 0.5 * L);
    EXPECT_DOUBLE_EQ(vx_e[0], 10.0);
    EXPECT_DOUBLE_EQ(vy_e[0], 20.0);
    EXPECT_DOUBLE_EQ(vz_e[0], 30.0);

    // Particles at exact boundaries [0, L]
    N_e = 4;
    x_e[0] = L;     vx_e[0] = 1.0; vy_e[0] = 2.0; vz_e[0] = 3.0;
    x_e[1] = 0.0;   vx_e[1] = 4.0; vy_e[1] = 5.0; vz_e[1] = 6.0;
    x_e[2] = L/2.0; vx_e[2] = 7.0; vy_e[2] = 8.0; vz_e[2] = 9.0;
    x_e[3] = 0.0;   vx_e[3] = 10.0; vy_e[3] = 11.0; vz_e[3] = 12.0;

    sort_particles_by_cell(x_e, vx_e, vy_e, vz_e, N_e);

    EXPECT_DOUBLE_EQ(x_e[0], 0.0);
    EXPECT_DOUBLE_EQ(x_e[1], 0.0);
    EXPECT_DOUBLE_EQ(x_e[2], L/2.0);
    EXPECT_DOUBLE_EQ(x_e[3], L);
}
