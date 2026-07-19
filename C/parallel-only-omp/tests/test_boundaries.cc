#include <gtest/gtest.h>
#include "test_helpers.h"
#include <omp.h>
#include <vector>

class BoundaryTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

TEST_F(BoundaryTest, ParallelElectronBoundaryEquivalence) {
    // 1. Generate random particles (some inside, some outside)
    N_e = 50000;
    seed_rng(60);
    for (int k = 0; k < N_e; k++) {
        // Position range [-0.2 * L, 1.2 * L] to ensure some are outside boundaries
        x_e[k] = L * (1.4 * R01(MTgen) - 0.2);
        vx_e[k] = 1e5 * (R01(MTgen) - 0.5);
        vy_e[k] = 1e5 * (R01(MTgen) - 0.5);
        vz_e[k] = 1e5 * (R01(MTgen) - 0.5);
    }

    // Save initial state
    std::vector<double> x_e_init(N_e), vx_e_init(N_e), vy_e_init(N_e), vz_e_init(N_e);
    std::copy(x_e, x_e + N_e, x_e_init.begin());
    std::copy(vx_e, vx_e + N_e, vx_e_init.begin());
    std::copy(vy_e, vy_e + N_e, vy_e_init.begin());
    std::copy(vz_e, vz_e + N_e, vz_e_init.begin());

    // 2. Run sequentially (with 1 thread)
    omp_set_num_threads(1);
    step5_check_boundaries_electrons();

    int ref_N_e = N_e;
    std::vector<double> ref_x_e(ref_N_e), ref_vx_e(ref_N_e), ref_vy_e(ref_N_e), ref_vz_e(ref_N_e);
    std::copy(x_e, x_e + ref_N_e, ref_x_e.begin());
    std::copy(vx_e, vx_e + ref_N_e, ref_vx_e.begin());
    std::copy(vy_e, vy_e + ref_N_e, ref_vy_e.begin());
    std::copy(vz_e, vz_e + ref_N_e, ref_vz_e.begin());

    Ullong ref_abs_pow = N_e_abs_pow;
    Ullong ref_abs_gnd = N_e_abs_gnd;

    // 3. Reset state back to initial
    reset_state();
    N_e = x_e_init.size();
    std::copy(x_e_init.begin(), x_e_init.end(), x_e);
    std::copy(vx_e_init.begin(), vx_e_init.end(), vx_e);
    std::copy(vy_e_init.begin(), vy_e_init.end(), vy_e);
    std::copy(vz_e_init.begin(), vz_e_init.end(), vz_e);

    // 4. Run in parallel (with 4 threads)
    omp_set_num_threads(4);
    step5_check_boundaries_electrons();

    // 5. Assert equality co do bitu
    EXPECT_EQ(N_e, ref_N_e);
    EXPECT_EQ(N_e_abs_pow, ref_abs_pow);
    EXPECT_EQ(N_e_abs_gnd, ref_abs_gnd);

    for (int k = 0; k < N_e; k++) {
        EXPECT_DOUBLE_EQ(x_e[k], ref_x_e[k]) << "Mismatch in position at k = " << k;
        EXPECT_DOUBLE_EQ(vx_e[k], ref_vx_e[k]) << "Mismatch in velocity vx at k = " << k;
        EXPECT_DOUBLE_EQ(vy_e[k], ref_vy_e[k]) << "Mismatch in velocity vy at k = " << k;
        EXPECT_DOUBLE_EQ(vz_e[k], ref_vz_e[k]) << "Mismatch in velocity vz at k = " << k;
    }
}

TEST_F(BoundaryTest, ParallelIonBoundaryEquivalence) {
    // 1. Generate random particles
    N_i = 50000;
    seed_rng(61);
    for (int k = 0; k < N_i; k++) {
        x_i[k] = L * (1.4 * R01(MTgen) - 0.2);
        vx_i[k] = 1e4 * (R01(MTgen) - 0.5);
        vy_i[k] = 1e4 * (R01(MTgen) - 0.5);
        vz_i[k] = 1e4 * (R01(MTgen) - 0.5);
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
    step6_check_boundaries_ions(0); // t = 0 (subcycling trigger)

    int ref_N_i = N_i;
    std::vector<double> ref_x_i(ref_N_i), ref_vx_i(ref_N_i), ref_vy_i(ref_N_i), ref_vz_i(ref_N_i);
    std::copy(x_i, x_i + ref_N_i, ref_x_i.begin());
    std::copy(vx_i, vx_i + ref_N_i, ref_vx_i.begin());
    std::copy(vy_i, vy_i + ref_N_i, ref_vy_i.begin());
    std::copy(vz_i, vz_i + ref_N_i, ref_vz_i.begin());

    Ullong ref_abs_pow = N_i_abs_pow;
    Ullong ref_abs_gnd = N_i_abs_gnd;

    std::vector<int> ref_ifed_pow(N_IFED), ref_ifed_gnd(N_IFED);
    std::copy(ifed_pow, ifed_pow + N_IFED, ref_ifed_pow.begin());
    std::copy(ifed_gnd, ifed_gnd + N_IFED, ref_ifed_gnd.begin());

    // 3. Reset state back to initial
    reset_state();
    N_i = x_i_init.size();
    std::copy(x_i_init.begin(), x_i_init.end(), x_i);
    std::copy(vx_i_init.begin(), vx_i_init.end(), vx_i);
    std::copy(vy_i_init.begin(), vy_i_init.end(), vy_i);
    std::copy(vz_i_init.begin(), vz_i_init.end(), vz_i);

    // 4. Run in parallel (with 4 threads)
    omp_set_num_threads(4);
    measurement_mode = true;
    step6_check_boundaries_ions(0);

    // 5. Assert equality co do bitu
    EXPECT_EQ(N_i, ref_N_i);
    EXPECT_EQ(N_i_abs_pow, ref_abs_pow);
    EXPECT_EQ(N_i_abs_gnd, ref_abs_gnd);

    for (int k = 0; k < N_i; k++) {
        EXPECT_DOUBLE_EQ(x_i[k], ref_x_i[k]) << "Mismatch in position at k = " << k;
        EXPECT_DOUBLE_EQ(vx_i[k], ref_vx_i[k]) << "Mismatch in velocity vx at k = " << k;
        EXPECT_DOUBLE_EQ(vy_i[k], ref_vy_i[k]) << "Mismatch in velocity vy at k = " << k;
        EXPECT_DOUBLE_EQ(vz_i[k], ref_vz_i[k]) << "Mismatch in velocity vz at k = " << k;
    }

    // Verify IFED histograms (since threads increment atomically, final histograms must match exactly)
    for (int i = 0; i < N_IFED; i++) {
        EXPECT_EQ(ifed_pow[i], ref_ifed_pow[i]) << "Mismatch in ifed_pow at index " << i;
        EXPECT_EQ(ifed_gnd[i], ref_ifed_gnd[i]) << "Mismatch in ifed_gnd at index " << i;
    }
}

TEST_F(BoundaryTest, DeterministicStreamCompactionElectrons) {
    N_e = 5;
    // index 0: stays
    x_e[0] = L * 0.25;  vx_e[0] = 10.0; vy_e[0] = 11.0; vz_e[0] = 12.0;
    // index 1: out (left)
    x_e[1] = -0.001;    vx_e[1] = 20.0; vy_e[1] = 21.0; vz_e[1] = 22.0;
    // index 2: stays
    x_e[2] = L * 0.5;   vx_e[2] = 30.0; vy_e[2] = 31.0; vz_e[2] = 32.0;
    // index 3: out (right)
    x_e[3] = L + 0.001; vx_e[3] = 40.0; vy_e[3] = 41.0; vz_e[3] = 42.0;
    // index 4: stays
    x_e[4] = L * 0.75;  vx_e[4] = 50.0; vy_e[4] = 51.0; vz_e[4] = 52.0;

    omp_set_num_threads(2); // test with multiple threads
    step5_check_boundaries_electrons();

    EXPECT_EQ(N_e, 3);
    EXPECT_EQ(N_e_abs_pow, 1);
    EXPECT_EQ(N_e_abs_gnd, 1);

    // Surviving: 0, 2, 4. In stable compaction, they end up at 0, 1, 2
    EXPECT_NEAR(x_e[0],  L * 0.25, 1e-12);
    EXPECT_NEAR(vx_e[0], 10.0,    1e-12);

    EXPECT_NEAR(x_e[1],  L * 0.5,  1e-12);
    EXPECT_NEAR(vx_e[1], 30.0,    1e-12);

    EXPECT_NEAR(x_e[2],  L * 0.75, 1e-12);
    EXPECT_NEAR(vx_e[2], 50.0,    1e-12);
}

TEST_F(BoundaryTest, DeterministicIonFluxEnergyDistribution) {
    N_i = 1;
    x_i[0] = L + 0.001; // out (right)
    
    double target_energy_eV = 50.5;
    double v_x = sqrt(2.0 * target_energy_eV * E_CHARGE / AR_MASS);
    vx_i[0] = v_x; vy_i[0] = 0.0; vz_i[0] = 0.0;
    
    omp_set_num_threads(2);
    measurement_mode = true;
    step6_check_boundaries_ions(0); // t = 0 (subcycling)
    
    EXPECT_EQ(N_i, 0);
    EXPECT_EQ(N_i_abs_gnd, 1);
    
    EXPECT_EQ(ifed_gnd[50], 1);
    EXPECT_EQ(ifed_gnd[51], 0);
}

