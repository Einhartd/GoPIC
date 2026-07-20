#include <gtest/gtest.h>
#include <mpi.h>
#include "test_helpers.h"

// Pomocnicze funkcje sekwencyjne do weryfikacji poprawności algorytmów
namespace reference {
    // Sekwencyjna depozycja elektronów
    void density_deposition(const double* x, int N, double* density) {
        std::fill(density, density + N_G, 0.0);
        for (int k = 0; k < N; k++) {
            double c0 = x[k] * INV_DX;
            int p = int(c0);
            density[p]   += (p + 1 - c0) * FACTOR_W;
            density[p+1] += (c0 - p) * FACTOR_W;
        }
        density[0]     *= 2.0;
        density[N_G-1] *= 2.0;
    }

    // Sekwencyjne pchnięcie elektronów
    void move_electrons(double* x, double* vx, double* vy, double* vz, int N) {
        for (int k = 0; k < N; k++) {
            double c0 = x[k] * INV_DX;
            int p = int(c0);
            double c1 = c0 - p;
            double E_part = efield[p] * (1.0 - c1) + efield[p+1] * c1;

            vx[k] -= FACTOR_E * E_part;
            x[k]  += vx[k] * DT_E;
        }
    }

    // Sekwencyjne sprawdzenie granic elektronów (Fast-Swap / In-Place filter)
    int check_boundaries(double* x, double* vx, double* vy, double* vz, int N, int& abs_pow, int& abs_gnd) {
        int k = 0;
        while (k < N) {
            if (x[k] < 0) {
                abs_pow++;
                x[k]  = x[N - 1];
                vx[k] = vx[N - 1];
                vy[k] = vy[N - 1];
                vz[k] = vz[N - 1];
                N--;
            } else if (x[k] > L) {
                abs_gnd++;
                x[k]  = x[N - 1];
                vx[k] = vx[N - 1];
                vy[k] = vy[N - 1];
                vz[k] = vz[N - 1];
                N--;
            } else {
                k++;
            }
        }
        return N;
    }
}

// 1. Test równoważności depozycji gęstości (Hybrid vs Sequential Reference)
TEST(HybridEquivalenceTest, DensityDeposition) {
    reset_state();

    int total_N = 1000;
    std::vector<double> ref_x_e(total_N);
    double expected_density[N_G];

    if (mpi_rank == 0) {
        // Master generuje testowe położenia cząstek
        for (int i = 0; i < total_N; i++) {
            ref_x_e[i] = L * (0.1 + 0.8 * (double)i / total_N);
        }
        // Obliczamy oczekiwaną gęstość referencyjną
        reference::density_deposition(ref_x_e.data(), total_N, expected_density);
    }

    // Rozsyłamy cząstki do procesów MPI (distribute)
    int local_N = total_N / mpi_size;
    int remainder = total_N % mpi_size;
    int my_N = local_N + (mpi_rank == 0 ? remainder : 0);

    if (mpi_rank == 0) {
        // Kopiujemy lokalną część Mastera
        std::copy(ref_x_e.begin(), ref_x_e.begin() + my_N, x_e);
        // Wysyłamy resztę
        for (int i = 1; i < mpi_size; ++i) {
            int count = local_N;
            int offset = remainder + i * count;
            MPI_Send(&ref_x_e[offset], count, MPI_DOUBLE, i, 100, MPI_COMM_WORLD);
        }
    } else {
        MPI_Recv(x_e, my_N, MPI_DOUBLE, 0, 100, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }
    N_e = my_N;

    // Każdy proces wykonuje depozycję hybrydową (step1_compute_electron_density)
    step1_compute_electron_density();

    // Porównujemy wynik z oczekiwaną gęstością referencyjną na Masterze
    if (mpi_rank == 0) {
        for (int i = 0; i < N_G; i++) {
            EXPECT_DOUBLE_EQ(e_density[i], expected_density[i]) 
                << "Blad depozycji na wezle " << i;
        }
    }
}

// 2. Test równoważności ruchu cząstek (Hybrid vs Sequential Reference)
TEST(HybridEquivalenceTest, ParticlePush) {
    reset_state();

    int total_N = 100;
    std::vector<double> init_x(total_N), init_vx(total_N);
    std::vector<double> ref_x(total_N), ref_vx(total_N), ref_vy(total_N), ref_vz(total_N);

    // Inicjujemy przykładowe pole elektryczne na siatce
    for (int i = 0; i < N_G; i++) {
        efield[i] = 1000.0 * sin(2.0 * M_PI * i / N_G);
    }

    if (mpi_rank == 0) {
        for (int i = 0; i < total_N; i++) {
            ref_x[i]  = L * (0.1 + 0.8 * (double)i / total_N);
            ref_vx[i] = 1000.0;
            ref_vy[i] = 0.0;
            ref_vz[i] = 0.0;
        }
        // Zachowujemy stan początkowy do wysłania
        init_x = ref_x;
        init_vx = ref_vx;
        
        // Obliczamy referencyjne położenia po pchnięciu
        reference::move_electrons(ref_x.data(), ref_vx.data(), ref_vy.data(), ref_vz.data(), total_N);
    }

    // Rozsyłamy początkowe cząstki (init_x, init_vx) do procesów MPI
    int local_N = total_N / mpi_size;
    int remainder = total_N % mpi_size;
    int my_N = local_N + (mpi_rank == 0 ? remainder : 0);

    if (mpi_rank == 0) {
        std::copy(init_x.begin(), init_x.begin() + my_N, x_e);
        std::copy(init_vx.begin(), init_vx.begin() + my_N, vx_e);
        std::fill(vy_e, vy_e + my_N, 0.0);
        std::fill(vz_e, vz_e + my_N, 0.0);
        for (int i = 1; i < mpi_size; ++i) {
            int count = local_N;
            int offset = remainder + i * count;
            MPI_Send(&init_x[offset], count, MPI_DOUBLE, i, 110, MPI_COMM_WORLD);
            MPI_Send(&init_vx[offset], count, MPI_DOUBLE, i, 111, MPI_COMM_WORLD);
        }
    } else {
        MPI_Recv(x_e, my_N, MPI_DOUBLE, 0, 110, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(vx_e, my_N, MPI_DOUBLE, 0, 111, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        std::fill(vy_e, vy_e + my_N, 0.0);
        std::fill(vz_e, vz_e + my_N, 0.0);
    }
    N_e = my_N;

    // Kopiujemy pole elektryczne do procesów roboczych
    MPI_Bcast(efield, N_G, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    // Wykonujemy hybrydowe pchnięcie
    step3_move_electrons(0);

    // Zbieramy (Gather) cząstki do Mastera w celu weryfikacji
    std::vector<int> recv_counts(mpi_size);
    MPI_Gather(&N_e, 1, MPI_INT, recv_counts.data(), 1, MPI_INT, 0, MPI_COMM_WORLD);

    if (mpi_rank == 0) {
        std::vector<double> gathered_x(total_N), gathered_vx(total_N);
        std::copy(x_e, x_e + recv_counts[0], gathered_x.begin());
        std::copy(vx_e, vx_e + recv_counts[0], gathered_vx.begin());

        int offset = recv_counts[0];
        for (int r = 1; r < mpi_size; ++r) {
            MPI_Recv(&gathered_x[offset], recv_counts[r], MPI_DOUBLE, r, 120, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            MPI_Recv(&gathered_vx[offset], recv_counts[r], MPI_DOUBLE, r, 121, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            offset += recv_counts[r];
        }

        // Porównujemy zebrany wynik z oczekiwanym sekwencyjnym
        for (int i = 0; i < total_N; i++) {
            EXPECT_NEAR(gathered_x[i], ref_x[i], 1e-9);
            EXPECT_NEAR(gathered_vx[i], ref_vx[i], 1e-9);
        }
    } else {
        MPI_Send(x_e, N_e, MPI_DOUBLE, 0, 120, MPI_COMM_WORLD);
        MPI_Send(vx_e, N_e, MPI_DOUBLE, 0, 121, MPI_COMM_WORLD);
    }
}

// 3. Test równoważności sprawdzania granic i kompresji tablicy
TEST(HybridEquivalenceTest, BoundaryCheck) {
    reset_state();

    int total_N = 10;
    std::vector<double> ref_x(total_N), ref_vx(total_N);
    int expected_abs_pow = 0;
    int expected_abs_gnd = 0;
    int expected_survived = 0;

    if (mpi_rank == 0) {
        // Cząstki testowe: część w środku, część poza granicami
        ref_x = { -0.1, 0.1 * L, 0.2 * L, 1.5 * L, 0.5 * L, -0.5, 0.6 * L, 0.7 * L, 2.0 * L, 0.8 * L };
        ref_vx = { 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0 };

        std::vector<double> seq_x = ref_x;
        std::vector<double> seq_vx = ref_vx;
        std::vector<double> seq_vy(total_N, 0.0);
        std::vector<double> seq_vz(total_N, 0.0);
        expected_survived = reference::check_boundaries(seq_x.data(), seq_vx.data(), seq_vy.data(), seq_vz.data(), total_N, expected_abs_pow, expected_abs_gnd);
    }

    // Rozpraszamy cząstki
    int local_N = total_N / mpi_size;
    int remainder = total_N % mpi_size;
    int my_N = local_N + (mpi_rank == 0 ? remainder : 0);

    if (mpi_rank == 0) {
        std::copy(ref_x.begin(), ref_x.begin() + my_N, x_e);
        std::copy(ref_vx.begin(), ref_vx.begin() + my_N, vx_e);
        std::fill(vy_e, vy_e + my_N, 0.0);
        std::fill(vz_e, vz_e + my_N, 0.0);
        for (int i = 1; i < mpi_size; ++i) {
            int count = local_N;
            int offset = remainder + i * count;
            MPI_Send(&ref_x[offset], count, MPI_DOUBLE, i, 130, MPI_COMM_WORLD);
            MPI_Send(&ref_vx[offset], count, MPI_DOUBLE, i, 131, MPI_COMM_WORLD);
        }
    } else {
        MPI_Recv(x_e, my_N, MPI_DOUBLE, 0, 130, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(vx_e, my_N, MPI_DOUBLE, 0, 131, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        std::fill(vy_e, vy_e + my_N, 0.0);
        std::fill(vz_e, vz_e + my_N, 0.0);
    }
    N_e = my_N;

    // Wykonujemy hybrydowy test granic (Stream Compaction)
    step5_check_boundaries_electrons();

    // Redukujemy liczby zaabsorbowanych cząstek
    Ullong global_abs_pow = 0, global_abs_gnd = 0;
    MPI_Reduce(&N_e_abs_pow, &global_abs_pow, 1, MPI_UNSIGNED_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&N_e_abs_gnd, &global_abs_gnd, 1, MPI_UNSIGNED_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);

    int global_survived = 0;
    MPI_Reduce(&N_e, &global_survived, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if (mpi_rank == 0) {
        EXPECT_EQ(global_survived, expected_survived) << "Niezgodnosc liczby ocalalych czastek!";
        EXPECT_EQ(global_abs_pow, expected_abs_pow) << "Niezgodnosc absorpcji na elektrodzie powered!";
        EXPECT_EQ(global_abs_gnd, expected_abs_gnd) << "Niezgodnosc absorpcji na elektrodzie grounded!";
    }
}

// 4. Testy podstawowej komunikacji (Splitting, Gather/Scatter i Redukcje Diagnostyk)
TEST(HybridCommTest, InitializationSplitting) {
    reset_state();
    int local_N_INIT = N_INIT / mpi_size;
    if (mpi_rank == 0) {
        local_N_INIT += N_INIT % mpi_size;
    }
    init(local_N_INIT);
    EXPECT_EQ(N_e, local_N_INIT);
    EXPECT_EQ(N_i, local_N_INIT);
    int global_N_e = 0;
    MPI_Reduce(&N_e, &global_N_e, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    if (mpi_rank == 0) {
        EXPECT_EQ(global_N_e, N_INIT);
    }
}

TEST(HybridCommTest, DiagnosticsReduction) {
    reset_state();
    N_e_abs_pow = mpi_rank + 1;
    mean_energy_accu_center = 10.5 * (mpi_rank + 1);
    mean_energy_counter_center = 1;
    
    Ullong global_N_e_abs_pow = 0;
    MPI_Reduce(&N_e_abs_pow, &global_N_e_abs_pow, 1, MPI_UNSIGNED_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);
    
    double global_mean_energy_accu_center = 0.0;
    Ullong global_mean_energy_counter_center = 0;
    MPI_Reduce(&mean_energy_accu_center, &global_mean_energy_accu_center, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&mean_energy_counter_center, &global_mean_energy_counter_center, 1, MPI_UNSIGNED_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);
    
    if (mpi_rank == 0) {
        Ullong expected_abs = 0;
        double expected_energy = 0.0;
        for (int r = 0; r < mpi_size; ++r) {
            expected_abs += (r + 1);
            expected_energy += 10.5 * (r + 1);
        }
        EXPECT_EQ(global_N_e_abs_pow, expected_abs);
        EXPECT_DOUBLE_EQ(global_mean_energy_accu_center, expected_energy);
        EXPECT_EQ(global_mean_energy_counter_center, mpi_size);
    }
}

TEST(HybridCommTest, ParticleGatherScatter) {
    reset_state();
    N_e = 2;
    for (int i = 0; i < N_e; i++) {
        x_e[i] = (mpi_rank * 10.0 + i) * 0.001;
        vx_e[i] = mpi_rank * 100.0 + i;
        vy_e[i] = 0; vz_e[i] = 0;
    }
    N_i = 1;
    x_i[0] = (mpi_rank * 20.0) * 0.001;
    vx_i[0] = mpi_rank * 200.0;
    vy_i[0] = 0; vz_i[0] = 0;
    
    save_particle_data();
    
    int old_N_e = N_e;
    int old_N_i = N_i;
    double old_x_e[2], old_vx_e[2];
    std::copy(x_e, x_e + 2, old_x_e);
    std::copy(vx_e, vx_e + 2, old_vx_e);
    
    N_e = 0; N_i = 0;
    load_particle_data();
    
    EXPECT_EQ(N_e, old_N_e);
    EXPECT_EQ(N_i, old_N_i);
    for (int i = 0; i < N_e; i++) {
        EXPECT_DOUBLE_EQ(x_e[i], old_x_e[i]);
        EXPECT_DOUBLE_EQ(vx_e[i], old_vx_e[i]);
    }
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    int required = MPI_THREAD_FUNNELED;
    int provided;
    MPI_Init_thread(&argc, &argv, required, &provided);
    MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

    if (mpi_rank != 0) {
        ::testing::UnitTest::GetInstance()->listeners().Release(
            ::testing::UnitTest::GetInstance()->listeners().default_result_printer()
        );
    }

    int result = RUN_ALL_TESTS();

    MPI_Finalize();
    return result;
}
