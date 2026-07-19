#include <gtest/gtest.h>
#include "test_helpers.h"
#include <omp.h>
#include <vector>

class PushTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

TEST_F(PushTest, ParallelElectronPushEquivalence) {
    // 1. Generate random particles and electric field
    N_e = 20000;
    seed_rng(50);
    for (int k = 0; k < N_e; k++) {
        x_e[k] = L * R01(MTgen);
        vx_e[k] = 1e5 * (R01(MTgen) - 0.5);
        vy_e[k] = 1e5 * (R01(MTgen) - 0.5);
        vz_e[k] = 1e5 * (R01(MTgen) - 0.5);
    }
    for (int p = 0; p < N_G; p++) {
        efield[p] = 1000.0 * (R01(MTgen) - 0.5);
    }

    // Save initial state
    std::vector<double> x_e_init(N_e), vx_e_init(N_e), vy_e_init(N_e), vz_e_init(N_e);
    std::copy(x_e, x_e + N_e, x_e_init.begin());
    std::copy(vx_e, vx_e + N_e, vx_e_init.begin());
    std::copy(vy_e, vy_e + N_e, vy_e_init.begin());
    std::copy(vz_e, vz_e + N_e, vz_e_init.begin());

    // 2. Run sequentially (with 1 thread)
    omp_set_num_threads(1);
    measurement_mode = true;
    int t_index = 5;
    step3_move_electrons(t_index);

    std::vector<double> ref_x_e(N_e), ref_vx_e(N_e);
    std::copy(x_e, x_e + N_e, ref_x_e.begin());
    std::copy(vx_e, vx_e + N_e, ref_vx_e.begin());

    double ref_mean_energy = mean_energy_accu_center;
    Ullong ref_mean_counter = mean_energy_counter_center;

    std::vector<double> ref_counter_e(N_G);
    for (int p = 0; p < N_G; p++) ref_counter_e[p] = counter_e_xt[p][t_index];

    // 3. Reset state back to initial
    reset_state();
    std::copy(x_e_init.begin(), x_e_init.end(), x_e);
    std::copy(vx_e_init.begin(), vx_e_init.end(), vx_e);
    std::copy(vy_e_init.begin(), vy_e_init.end(), vy_e);
    std::copy(vz_e_init.begin(), vz_e_init.end(), vz_e);
    for (int p = 0; p < N_G; p++) {
        efield[p] = 1000.0 * (R01(MTgen) - 0.5); // restore same efield
    }

    // 4. Run in parallel (with 4 threads)
    omp_set_num_threads(4);
    measurement_mode = true;
    step3_move_electrons(t_index);

    // 5. Verify bit-level equality for independent particle updates
    for (int k = 0; k < N_e; k++) {
        EXPECT_DOUBLE_EQ(x_e[k], ref_x_e[k]) << "Mismatch in position at k = " << k;
        EXPECT_DOUBLE_EQ(vx_e[k], ref_vx_e[k]) << "Mismatch in velocity at k = " << k;
    }

    // Verify reduced scalar diagnostics (with small floating point tolerance due to reordering)
    EXPECT_NEAR(mean_energy_accu_center, ref_mean_energy, 1e-5 * EV_TO_J);
    EXPECT_EQ(mean_energy_counter_center, ref_mean_counter);

    // Verify atomic diagnostic arrays (with small floating point tolerance due to atomic ordering)
    for (int p = 0; p < N_G; p++) {
        EXPECT_NEAR(counter_e_xt[p][t_index], ref_counter_e[p], 1e-9);
    }
}

TEST_F(PushTest, ParallelIonPushEquivalence) {
    // 1. Generate random particles and electric field
    N_i = 20000;
    seed_rng(51);
    for (int k = 0; k < N_i; k++) {
        x_i[k] = L * R01(MTgen);
        vx_i[k] = 1e4 * (R01(MTgen) - 0.5);
        vy_i[k] = 1e4 * (R01(MTgen) - 0.5);
        vz_i[k] = 1e4 * (R01(MTgen) - 0.5);
    }
    for (int p = 0; p < N_G; p++) {
        efield[p] = 1000.0 * (R01(MTgen) - 0.5);
    }

    // Save initial state
    std::vector<double> x_i_init(N_i), vx_i_init(N_i), vy_i_init(N_i), vz_i_init(N_i);
    std::copy(x_i, x_i + N_i, x_i_init.begin());
    std::copy(vx_i, vx_i + N_i, vx_i_init.begin());
    std::copy(vy_i, vy_i + N_i, vy_i_init.begin());
    std::copy(vz_i, vz_i + N_i, vz_i_init.begin());

    // 2. Run sequentially (with 1 thread)
    omp_set_num_threads(1);
    measurement_mode = true;
    int t_index = 5;
    step4_move_ions(t_index, 0); // subcycling trigger (t=0)

    std::vector<double> ref_x_i(N_i), ref_vx_i(N_i);
    std::copy(x_i, x_i + N_i, ref_x_i.begin());
    std::copy(vx_i, vx_i + N_i, ref_vx_i.begin());

    std::vector<double> ref_counter_i(N_G);
    for (int p = 0; p < N_G; p++) ref_counter_i[p] = counter_i_xt[p][t_index];

    // 3. Reset state back to initial
    reset_state();
    std::copy(x_i_init.begin(), x_i_init.end(), x_i);
    std::copy(vx_i_init.begin(), vx_i_init.end(), vx_i);
    std::copy(vy_i_init.begin(), vy_i_init.end(), vy_i);
    std::copy(vz_i_init.begin(), vz_i_init.end(), vz_i);
    for (int p = 0; p < N_G; p++) {
        efield[p] = 1000.0 * (R01(MTgen) - 0.5); // restore same efield
    }

    // 4. Run in parallel (with 4 threads)
    omp_set_num_threads(4);
    measurement_mode = true;
    step4_move_ions(t_index, 0);

    // 5. Verify bit-level equality for independent particle updates
    for (int k = 0; k < N_i; k++) {
        EXPECT_DOUBLE_EQ(x_i[k], ref_x_i[k]) << "Mismatch in position at k = " << k;
        EXPECT_DOUBLE_EQ(vx_i[k], ref_vx_i[k]) << "Mismatch in velocity at k = " << k;
    }

    // Verify atomic diagnostic arrays
    for (int p = 0; p < N_G; p++) {
        EXPECT_NEAR(counter_i_xt[p][t_index], ref_counter_i[p], 1e-9);
    }
}
