#include <gtest/gtest.h>
#include "test_helpers.h"

class HybridIonTest : public ::testing::Test {
protected:
    void SetUp() override { reset_state(); }
};

// Test A: Subcycling depozycji i ruchu jonów (tylko dla t % N_SUB == 0)
TEST_F(HybridIonTest, SubcyclingGating) {
    reset_state();
    int local_N = 50;
    N_i = local_N;
    for (int i = 0; i < local_N; i++) {
        x_i[i] = 0.5 * L;
        vx_i[i] = 0.0; vy_i[i] = 0.0; vz_i[i] = 0.0;
    }
    for (int i = 0; i < N_G; i++) efield[i] = 100.0;

    // t = 1 (brak subcycling)
    step1_compute_ion_density(1);
    EXPECT_DOUBLE_EQ(i_density[0], 0.0);

    step4_move_ions(0, 1); // t = 1 -> brak ruchu
    EXPECT_DOUBLE_EQ(vx_i[0], 0.0);

    // t = 0 (subcycling aktywny)
    step1_compute_ion_density(0);
    EXPECT_GT(i_density[N_G / 2], 0.0);

    step4_move_ions(0, 0); // t = 0 -> ruch aktywny (+FACTOR_I * E)
    double expected_v = 100.0 * FACTOR_I; // Siła jonowa jest dodatnia (+e)
    EXPECT_NEAR(vx_i[0], expected_v, 1e-9);
}

// Test B: Obliczanie IFED przy absorpcji jonów na elektrodach
TEST_F(HybridIonTest, IonBoundaryIFEDAccumulation) {
    reset_state();

    if (mpi_rank == 0) {
        N_i = 2;
        x_i[0] = -0.001;  // lewa elektroda (powered)
        vx_i[0] = -1000.0; vy_i[0] = 0.0; vz_i[0] = 0.0;
        
        x_i[1] = L + 0.001; // prawa elektroda (grounded)
        vx_i[1] = 2000.0; vy_i[1] = 0.0; vz_i[1] = 0.0;
    } else {
        N_i = 0;
    }

    step6_check_boundaries_ions(0); // t = 0

    Ullong global_abs_pow = 0, global_abs_gnd = 0;
    MPI_Reduce(&N_i_abs_pow, &global_abs_pow, 1, MPI_UNSIGNED_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&N_i_abs_gnd, &global_abs_gnd, 1, MPI_UNSIGNED_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);

    int global_survived = 0;
    MPI_Reduce(&N_i, &global_survived, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if (mpi_rank == 0) {
        EXPECT_EQ(global_survived, 0);
        EXPECT_EQ(global_abs_pow, 1);
        EXPECT_EQ(global_abs_gnd, 1);
    }
}
