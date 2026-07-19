#include <gtest/gtest.h>
#include "test_helpers.h"
#include <omp.h>
#include <vector>

class CollisionsTest : public ::testing::Test {
protected:
    void SetUp() override {
        reset_state();
        set_electron_cross_sections_ar();
        set_ion_cross_sections_ar();
        calc_total_cross_sections();
#ifdef USE_NULL_COLLISION
        compute_null_collision_params();
#endif
    }
};

TEST_F(CollisionsTest, NewParticlesBufferCorrectness) {
    NewParticles new_e, new_i;

    // Push dummy particles
    new_e.push(1.0, 2.0, 3.0, 4.0);
    new_i.push(5.0, 6.0, 7.0, 8.0);

    EXPECT_EQ(new_e.x.size(), 1);
    EXPECT_EQ(new_e.vx[0], 2.0);
    EXPECT_EQ(new_i.x.size(), 1);
    EXPECT_EQ(new_i.vy[0], 7.0);
}

TEST_F(CollisionsTest, ParallelElectronCollisionsAndIonization) {
    // 1. Generate electrons with high energy to trigger ionization
    N_e = 1000;
    N_i = 1000;
    seed_rng(70);
    for (int k = 0; k < N_e; k++) {
        x_e[k] = L * R01(MTgen);
        // high velocity (approx 100 eV)
        vx_e[k] = 6e6;
        vy_e[k] = 0.0;
        vz_e[k] = 0.0;
        
        x_i[k] = L * R01(MTgen);
        vx_i[k] = 1e3;
        vy_i[k] = 0.0;
        vz_i[k] = 0.0;
    }

    int init_N_e = N_e;
    int init_N_i = N_i;

    // Run parallel collisions
    omp_set_num_threads(4);
    step7_collisions_electrons();

    // Verify that new electrons and ions were appended
    // Ionization must have occurred, so N_e and N_i should be greater than initial
    EXPECT_GT(N_e, init_N_e);
    EXPECT_GT(N_i, init_N_i);

    // Verify that N_e_coll counter was incremented
    EXPECT_GT(N_e_coll, 0);

    // Verify that new particles are positioned within [0, L] or have valid coordinates
    for (int k = init_N_e; k < N_e; k++) {
        EXPECT_GE(x_e[k], 0.0);
        EXPECT_LE(x_e[k], L);
    }
}

TEST_F(CollisionsTest, ParallelIonCollisions) {
    N_i = 1000;
    seed_rng(71);
    for (int k = 0; k < N_i; k++) {
        x_i[k] = L * R01(MTgen);
        vx_i[k] = 1e4;
        vy_i[k] = 0.0;
        vz_i[k] = 0.0;
    }

    // Run parallel ion collisions (t = 0 triggers subcycling)
    omp_set_num_threads(4);
    step8_collision_ions(0);

    // Since ion collisions do not create new particles, N_i must be unchanged
    EXPECT_EQ(N_i, 1000);
    EXPECT_GT(N_i_coll, 0);
}
