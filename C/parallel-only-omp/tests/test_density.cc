#include <gtest/gtest.h>
#include "test_helpers.h"
#include <omp.h>
#include <vector>

class DensityTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

TEST_F(DensityTest, ParallelElectronDensityEquivalence) {
    // 1. Generate random particles
    N_e = 50000;
    seed_rng(42);
    for (int k = 0; k < N_e; k++) {
        x_e[k] = L * R01(MTgen);
    }

    // Save particles configuration
    std::vector<double> x_e_copy(N_e);
    std::copy(x_e, x_e + N_e, x_e_copy.begin());

    // 2. Run sequentially (with 1 thread)
    omp_set_num_threads(1);
    step1_compute_electron_density();

    std::vector<double> ref_density(N_G);
    std::copy(e_density, e_density + N_G, ref_density.begin());

    // 3. Reset density arrays, keeping particles
    for (int i = 0; i < N_G; i++) {
        e_density[i] = 0.0;
        cumul_e_density[i] = 0.0;
    }
    std::copy(x_e_copy.begin(), x_e_copy.end(), x_e);

    // 4. Run in parallel (with 4 threads)
    omp_set_num_threads(4);
    step1_compute_electron_density();

    // 5. Assert equality (accounting for floating-point reordering)
    for (int i = 0; i < N_G; i++) {
        EXPECT_NEAR(e_density[i], ref_density[i], 1e-5 * FACTOR_W) << "Mismatch at node " << i;
    }
}

TEST_F(DensityTest, ParallelIonDensityEquivalence) {
    // 1. Generate random particles
    N_i = 50000;
    seed_rng(43);
    for (int k = 0; k < N_i; k++) {
        x_i[k] = L * R01(MTgen);
    }

    // Save particles configuration
    std::vector<double> x_i_copy(N_i);
    std::copy(x_i, x_i + N_i, x_i_copy.begin());

    // 2. Run sequentially (with 1 thread)
    omp_set_num_threads(1);
    step1_compute_ion_density(0); // t = 0 (so it computes the density)

    std::vector<double> ref_density(N_G);
    std::copy(i_density, i_density + N_G, ref_density.begin());

    // 3. Reset density arrays, keeping particles
    for (int i = 0; i < N_G; i++) {
        i_density[i] = 0.0;
        cumul_i_density[i] = 0.0;
    }
    std::copy(x_i_copy.begin(), x_i_copy.end(), x_i);

    // 4. Run in parallel (with 4 threads)
    omp_set_num_threads(4);
    step1_compute_ion_density(0);

    // 5. Assert equality (accounting for floating-point reordering)
    for (int i = 0; i < N_G; i++) {
        EXPECT_NEAR(i_density[i], ref_density[i], 1e-5 * FACTOR_W) << "Mismatch at node " << i;
    }
}
