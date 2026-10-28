#pragma once
#include "state.h"
#include "poisson.h"
#include "collisions.h"
#include "null_collision.h"
#include <array>
#include <cmath>
#include <omp.h>

/*
Inicjalizuje populację początkową elektronów i jonów w obszarze wyładowczym.
Rozmieszcza zadaną liczbę par makrocząstek jednorodnie w przestrzeni [0, L]
z zerowymi prędkościami początkowymi.
@param nseed Liczba par elektron-jon tworzonych na starcie symulacji.
*/
inline void init(int nseed) {
    for (int i = 0; i < nseed; i++) {
        // Losowanie początkowej pozycji elektronu i wyzerowanie składowych prędkości 3V
        x_e[i]  = L * R01(MTgen);
        vx_e[i] = 0;
        vy_e[i] = 0;
        vz_e[i] = 0;
        // Losowanie początkowej pozycji jonu i wyzerowanie składowych prędkości 3V
        x_i[i]  = L * R01(MTgen);
        vx_i[i] = 0;
        vy_i[i] = 0;
        vz_i[i] = 0;
    }
    N_e = nseed;
    N_i = nseed;
}

/*
Krok 1a: Równoległa depozycja gęstości ładunku elektronów na siatkę (schemat CIC).
Każdy wątek akumuluje wkład ze swojego podzbioru elektronów do prywatnego bufora,
po czym następuje równoległa redukcja do globalnej tablicy e_density z uwzględnieniem
korekty objętości połowicznych komórek brzegowych (mnożnik 2.0 na elektrodach).
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
*/
PIC_STEP void step1_compute_electron_density(int tid, int num_threads) {
    worker_buffers.e_density[tid].fill(0.0);

    int chunk   = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end   = std::min(k_start + chunk, N_e);

    // Depozycja wag liniowych elektronów do prywatnego bufora wątku
    for (int k = k_start; k < k_end; k++) {
        double c0 = x_e[k] * INV_DX;
        int    p  = int(c0);
        double c2 = (c0 - p) * FACTOR_W;
        double c1 = FACTOR_W - c2;
        worker_buffers.e_density[tid][p]   += c1;
        worker_buffers.e_density[tid][p+1] += c2;
    }

    #pragma omp barrier

    // Równoległa redukcja prywatnych buforów dla wewnętrznych węzłów siatki
    #pragma omp for schedule(static) nowait
    for (int p = 1; p < N_G - 1; p++) {
        double sum = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum += worker_buffers.e_density[t][p];
        }
        e_density[p]       = sum;
        cumul_e_density[p] += sum;
    }

    // Redukcja i korekta brzegowa (x2) na elektrodach wykonywana przez wątek główny
    if (tid == 0) {
        double sum0 = 0.0, sumN = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum0 += worker_buffers.e_density[t][0];
            sumN += worker_buffers.e_density[t][N_G - 1];
        }
        double val0 = 2.0 * sum0;
        double valN = 2.0 * sumN;
        e_density[0]           = val0;
        cumul_e_density[0]     += val0;
        e_density[N_G - 1]     = valN;
        cumul_e_density[N_G-1] += valN;
    }
}

/*
Krok 1b: Równoległa depozycja gęstości ładunku jonów na siatkę (subcycling co N_SUB kroków).
W krokach subcyclingu każdy wątek deponuje jony do prywatnego bufora i redukuje wynik do i_density.
W pozostałych krokach czasowych akumulowana jest tylko skumulowana gęstość cumul_i_density.
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
@param t           Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
PIC_STEP void step1_compute_ion_density(int tid, int num_threads, int t) {
    if ((t % N_SUB) == 0) {
        worker_buffers.i_density[tid].fill(0.0);

        int chunk   = (N_i + num_threads - 1) / num_threads;
        int k_start = std::min(tid * chunk, N_i);
        int k_end   = std::min(k_start + chunk, N_i);

        // Depozycja wag liniowych jonów do prywatnego bufora wątku
        for (int k = k_start; k < k_end; k++) {
            double c0 = x_i[k] * INV_DX;
            int    p  = int(c0);
            double c2 = (c0 - p) * FACTOR_W;
            double c1 = FACTOR_W - c2;
            worker_buffers.i_density[tid][p]   += c1;
            worker_buffers.i_density[tid][p+1] += c2;
        }

        #pragma omp barrier

        // Równoległa redukcja prywatnych buforów dla wewnętrznych węzłów siatki
        #pragma omp for schedule(static) nowait
        for (int p = 1; p < N_G - 1; p++) {
            double sum = 0.0;
            for (int t2 = 0; t2 < num_threads; t2++) {
                sum += worker_buffers.i_density[t2][p];
            }
            i_density[p]       = sum;
            cumul_i_density[p] += sum;
        }

        // Redukcja i korekta brzegowa (x2) na elektrodach wykonywana przez wątek główny
        if (tid == 0) {
            double sum0 = 0.0, sumN = 0.0;
            for (int t2 = 0; t2 < num_threads; t2++) {
                sum0 += worker_buffers.i_density[t2][0];
                sumN += worker_buffers.i_density[t2][N_G - 1];
            }
            double val0 = 2.0 * sum0;
            double valN = 2.0 * sumN;
            i_density[0]           = val0;
            i_density[N_G - 1]     = valN;
            cumul_i_density[0]     += val0;
            cumul_i_density[N_G-1] += valN;
        }
    } else {
        // W krokach pomiędzy subcyclingiem jonów dopisujemy ostatni znany rozkład i_density
        #pragma omp for simd schedule(static) nowait
        for (int p = 0; p < N_G; p++) {
            cumul_i_density[p] += i_density[p];
        }
    }
}

/*
Krok 2: Sekwencyjne rozwiązanie równania Poissona w pojedynczym wątku.
Przy siatce N_G = 400 wykonanie algorytmu Thomasa na jednym wątku jest szybsze
niż narzut synchronizacji wielowątkowej.
@param current_time Aktualny fizyczny czas symulacji [s].
*/
PIC_STEP void step2_solve_poisson(double current_time) {
    solve_Poisson(current_time);
}

/*
Krok 3: Równoległe popychanie elektronów (schemat Leap-Frog) oraz gromadzenie diagnostyk.
W trybie bez pomiarów (measurement_mode == false) wykorzystuje ręcznie rozwiniętą (4-krotnie)
pętlę sprzyjającą wektoryzacji SIMD. W trybie pomiarowym zbiera rozkłady XT oraz EEPF
do buforów prywatnych wątku i redukuje je do tablic globalnych.
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
@param t_index     Indeks przedziału czasowego dla macierzy diagnostyk XT (t / N_BIN).
*/
PIC_STEP void step3_move_electrons(int tid, int num_threads, int t_index) {
    // Szybka ścieżka bez diagnostyk z 4-krotnym rozwinięciem pętli (Loop Unrolling)
    if (__builtin_expect(!measurement_mode, 1)) {
        int chunk        = (N_e + num_threads - 1) / num_threads;
        int k_start      = std::min(tid * chunk, N_e);
        int k_end        = std::min(k_start + chunk, N_e);
        int k            = k_start;
        int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;

        #pragma GCC ivdep
        for (; k < k_unroll_end; k += 4) {
            double x0 = x_e[k+0], x1 = x_e[k+1], x2 = x_e[k+2], x3 = x_e[k+3];
            double v0 = vx_e[k+0], v1 = vx_e[k+1], v2 = vx_e[k+2], v3 = vx_e[k+3];

            double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
            int    p0   = int(c0_0),   p1   = int(c0_1),   p2   = int(c0_2),   p3   = int(c0_3);
            double c2_0 = c0_0 - p0,   c2_1 = c0_1 - p1,   c2_2 = c0_2 - p2,   c2_3 = c0_3 - p3;

            double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
            double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
            double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
            double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);

            double vn0 = v0 - ex0 * FACTOR_E;
            double vn1 = v1 - ex1 * FACTOR_E;
            double vn2 = v2 - ex2 * FACTOR_E;
            double vn3 = v3 - ex3 * FACTOR_E;

            vx_e[k+0] = vn0;
            vx_e[k+1] = vn1;
            vx_e[k+2] = vn2;
            vx_e[k+3] = vn3;
            x_e[k+0]  = x0 + vn0 * DT_E;
            x_e[k+1]  = x1 + vn1 * DT_E;
            x_e[k+2]  = x2 + vn2 * DT_E;
            x_e[k+3]  = x3 + vn3 * DT_E;
        }

        // Obsługa pozostałych elementów (ogon pętli)
        for (; k < k_end; k++) {
            double c0  = x_e[k] * INV_DX;
            int    p   = int(c0);
            double c2  = c0 - p;
            double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
            double v   = vx_e[k] - e_x * FACTOR_E;
            vx_e[k]    = v;
            x_e[k]    += v * DT_E;
        }
        return;
    }

    // Ścieżka pomiarowa: wyzerowanie prywatnych buforów diagnostycznych wątku
    worker_buffers.counter_e[tid].fill(0.0);
    worker_buffers.ue[tid].fill(0.0);
    worker_buffers.meanee[tid].fill(0.0);
    worker_buffers.ioniz[tid].fill(0.0);
    worker_buffers.eepf[tid].fill(0.0);
    worker_buffers.thread_counters[tid].accu_center    = 0.0;
    worker_buffers.thread_counters[tid].counter_center = 0;

    int    p, energy_index;
    double c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate;

    #pragma omp for schedule(static)
    for (int k = 0; k < N_e; k++) {
        c0  = x_e[k] * INV_DX;
        p   = int(c0);
        c1  = p + 1.0 - c0;
        c2  = c0 - p;
        e_x = c1 * efield[p] + c2 * efield[p+1];

        mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;

        worker_buffers.counter_e[tid][p]   += c1;
        worker_buffers.counter_e[tid][p+1] += c2;

        worker_buffers.ue[tid][p]   += c1 * mean_v;
        worker_buffers.ue[tid][p+1] += c2 * mean_v;

        v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
        energy = 0.5 * E_MASS * v_sqr / EV_TO_J;

        worker_buffers.meanee[tid][p]   += c1 * energy;
        worker_buffers.meanee[tid][p+1] += c2 * energy;

        energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
        velocity     = sqrt(v_sqr);
        rate         = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;

        worker_buffers.ioniz[tid][p]   += c1 * rate;
        worker_buffers.ioniz[tid][p+1] += c2 * rate;

        if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
            energy_index = (int)(energy / DE_EEPF);
            if (energy_index < N_EEPF) {
                worker_buffers.eepf[tid][energy_index] += 1.0;
            }
            worker_buffers.thread_counters[tid].accu_center += energy;
            worker_buffers.thread_counters[tid].counter_center++;
        }

        vx_e[k] -= e_x * FACTOR_E;
        x_e[k]  += vx_e[k] * DT_E;
    }

    // Równoległa redukcja lokalnych tablic diagnostycznych do globalnych macierzy XT
    #pragma omp for nowait
    for (int p = 0; p < N_G; p++) {
        double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
        for (int t = 0; t < num_threads; t++) {
            c_e += worker_buffers.counter_e[t][p];
            u_e += worker_buffers.ue[t][p];
            m_e += worker_buffers.meanee[t][p];
            iz  += worker_buffers.ioniz[t][p];
        }
        counter_e_xt[p][t_index]  += c_e;
        ue_xt[p][t_index]         += u_e;
        meanee_xt[p][t_index]     += m_e;
        ioniz_rate_xt[p][t_index] += iz;
    }

    // Równoległa redukcja lokalnych histogramów do globalnej tablicy EEPF
    #pragma omp for
    for (int i = 0; i < N_EEPF; i++) {
        double sum_eepf = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum_eepf += worker_buffers.eepf[t][i];
        }
        eepf[i] += sum_eepf;
    }

    // Redukcja skalarnych liczników energii w centrum wykonywana przez pojedynczy wątek
    #pragma omp single
    {
        for (int t = 0; t < num_threads; t++) {
            mean_energy_accu_center    += worker_buffers.thread_counters[t].accu_center;
            mean_energy_counter_center += worker_buffers.thread_counters[t].counter_center;
        }
    }
}

/*
Krok 4: Równoległe popychanie jonów (schemat Leap-Frog, subcycling co N_SUB kroków).
Podobnie jak dla elektronów, posiada szybką ścieżkę z 4-krotnym rozwinięciem pętli
oraz ścieżkę pomiarową redukującą rozkłady prędkości i energii jonów do macierzy XT.
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
@param t_index     Indeks przedziału czasowego dla macierzy diagnostyk XT (t / N_BIN).
@param t           Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
PIC_STEP void step4_move_ions(int tid, int num_threads, int t_index, int t) {
    if ((t % N_SUB) != 0) return;

    // Szybka ścieżka bez diagnostyk z 4-krotnym rozwinięciem pętli (Loop Unrolling)
    if (__builtin_expect(!measurement_mode, 1)) {
        int chunk        = (N_i + num_threads - 1) / num_threads;
        int k_start      = std::min(tid * chunk, N_i);
        int k_end        = std::min(k_start + chunk, N_i);
        int k            = k_start;
        int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;

        #pragma GCC ivdep
        for (; k < k_unroll_end; k += 4) {
            double x0 = x_i[k+0], x1 = x_i[k+1], x2 = x_i[k+2], x3 = x_i[k+3];
            double v0 = vx_i[k+0], v1 = vx_i[k+1], v2 = vx_i[k+2], v3 = vx_i[k+3];

            double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
            int    p0   = int(c0_0),   p1   = int(c0_1),   p2   = int(c0_2),   p3   = int(c0_3);
            double c2_0 = c0_0 - p0,   c2_1 = c0_1 - p1,   c2_2 = c0_2 - p2,   c2_3 = c0_3 - p3;

            double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
            double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
            double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
            double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);

            double vn0 = v0 + ex0 * FACTOR_I;
            double vn1 = v1 + ex1 * FACTOR_I;
            double vn2 = v2 + ex2 * FACTOR_I;
            double vn3 = v3 + ex3 * FACTOR_I;

            vx_i[k+0] = vn0;
            vx_i[k+1] = vn1;
            vx_i[k+2] = vn2;
            vx_i[k+3] = vn3;
            x_i[k+0]  = x0 + vn0 * DT_I;
            x_i[k+1]  = x1 + vn1 * DT_I;
            x_i[k+2]  = x2 + vn2 * DT_I;
            x_i[k+3]  = x3 + vn3 * DT_I;
        }

        // Obsługa pozostałych elementów (ogon pętli)
        for (; k < k_end; k++) {
            double c0  = x_i[k] * INV_DX;
            int    p   = int(c0);
            double c2  = c0 - p;
            double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
            double v   = vx_i[k] + e_x * FACTOR_I;
            vx_i[k]    = v;
            x_i[k]    += v * DT_I;
        }
        return;
    }

    // Ścieżka pomiarowa: wyzerowanie prywatnych buforów diagnostycznych dla jonów
    worker_buffers.counter_i[tid].fill(0.0);
    worker_buffers.ui[tid].fill(0.0);
    worker_buffers.meanei[tid].fill(0.0);

    int    p;
    double c0, c1, c2, e_x, mean_v, v_sqr, energy;

    #pragma omp for schedule(static)
    for (int k = 0; k < N_i; k++) {
        c0  = x_i[k] * INV_DX;
        p   = int(c0);
        c1  = p + 1 - c0;
        c2  = c0 - p;
        e_x = c1 * efield[p] + c2 * efield[p+1];

        mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;

        worker_buffers.counter_i[tid][p]   += c1;
        worker_buffers.counter_i[tid][p+1] += c2;

        worker_buffers.ui[tid][p]   += c1 * mean_v;
        worker_buffers.ui[tid][p+1] += c2 * mean_v;

        v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
        energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;

        worker_buffers.meanei[tid][p]   += c1 * energy;
        worker_buffers.meanei[tid][p+1] += c2 * energy;

        vx_i[k] += e_x * FACTOR_I;
        x_i[k]  += vx_i[k] * DT_I;
    }

    // Równoległa redukcja lokalnych tablic diagnostycznych jonów do macierzy XT
    #pragma omp for
    for (int p = 0; p < N_G; p++) {
        double c_i = 0.0, u_i = 0.0, m_i = 0.0;
        for (int t2 = 0; t2 < num_threads; t2++) {
            c_i += worker_buffers.counter_i[t2][p];
            u_i += worker_buffers.ui[t2][p];
            m_i += worker_buffers.meanei[t2][p];
        }
        counter_i_xt[p][t_index] += c_i;
        ui_xt[p][t_index]        += u_i;
        meanei_xt[p][t_index]    += m_i;
    }
}

/*
Krok 5: Równoległe sprawdzanie warunków brzegowych dla elektronów i kompaktacja tablic.
W pierwszej fazie wątki równolegle identyfikują indeksy elektronów, które opuściły obszar [0, L].
W drugiej fazie pojedynczy wątek zastępuje usunięte elektrony ostatnimi aktywnymi cząstkami z końca tablicy.
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
*/
PIC_STEP void step5_check_boundaries_electrons(int tid, int num_threads) {
    worker_buffers.absorbed_indices[tid].clear();
    worker_buffers.thread_counters[tid].local_abs_pow = 0;
    worker_buffers.thread_counters[tid].local_abs_gnd = 0;

    int chunk   = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end   = std::min(k_start + chunk, N_e);

    // Faza 1: Równoległe wyszukiwanie zaabsorbowanych elektronów w podzbiorze wątku
    for (int k = k_start; k < k_end; k++) {
        if (__builtin_expect(x_e[k] < 0.0, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_pow++;
        } else if (__builtin_expect(x_e[k] > L, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_gnd++;
        }
    }

    #pragma omp barrier

    // Faza 2: Dwuwskaźnikowa kompaktacja in-place wykonywana wyłącznie dla usuniętych cząstek
    #pragma omp single
    {
        int total_abs = 0;
        for (int t = 0; t < num_threads; t++) {
            total_abs   += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
            N_e_abs_pow += worker_buffers.thread_counters[t].local_abs_pow;
            N_e_abs_gnd += worker_buffers.thread_counters[t].local_abs_gnd;
        }

        if (total_abs > 0) {
            int last_valid = N_e - 1;
            for (int t = 0; t < num_threads; t++) {
                for (int dead_idx : worker_buffers.absorbed_indices[t]) {
                    while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
                        last_valid--;
                    }
                    if (last_valid > dead_idx) {
                        x_e[dead_idx]  = x_e[last_valid];
                        vx_e[dead_idx] = vx_e[last_valid];
                        vy_e[dead_idx] = vy_e[last_valid];
                        vz_e[dead_idx] = vz_e[last_valid];
                        last_valid--;
                    }
                }
            }
            N_e -= total_abs;
        }
    }
}

/*
Krok 6: Równoległe sprawdzanie warunków brzegowych dla jonów (subcycling co N_SUB kroków).
Wątki równolegle identyfikują zaabsorbowane jony i akumulują ich energie w lokalnych histogramach IFED,
po czym następuje redukcja histogramów IFED oraz kompaktacja in-place tablic jonowych.
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
@param t           Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
PIC_STEP void step6_check_boundaries_ions(int tid, int num_threads, int t) {
    if ((t % N_SUB) != 0) return;

    worker_buffers.absorbed_indices[tid].clear();
    worker_buffers.thread_counters[tid].local_abs_pow = 0;
    worker_buffers.thread_counters[tid].local_abs_gnd = 0;
    worker_buffers.local_ifed_pow[tid].fill(0);
    worker_buffers.local_ifed_gnd[tid].fill(0);

    int chunk   = (N_i + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_i);
    int k_end   = std::min(k_start + chunk, N_i);

    // Faza 1: Równoległe wyszukiwanie zaabsorbowanych jonów oraz zliczanie rozkładu IFED
    for (int k = k_start; k < k_end; k++) {
        if (__builtin_expect(x_i[k] < 0.0, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_pow++;
            double v_sqr        = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            int    energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
            if (energy_index < N_IFED) {
                worker_buffers.local_ifed_pow[tid][energy_index]++;
            }
        } else if (__builtin_expect(x_i[k] > L, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_gnd++;
            double v_sqr        = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            int    energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
            if (energy_index < N_IFED) {
                worker_buffers.local_ifed_gnd[tid][energy_index]++;
            }
        }
    }

    #pragma omp barrier

    // Równoległa redukcja lokalnych histogramów IFED do tablic globalnych
    #pragma omp for schedule(static) nowait
    for (int e = 0; e < N_IFED; ++e) {
        int sum_pow = 0, sum_gnd = 0;
        for (int t2 = 0; t2 < num_threads; ++t2) {
            sum_pow += worker_buffers.local_ifed_pow[t2][e];
            sum_gnd += worker_buffers.local_ifed_gnd[t2][e];
        }
        ifed_pow[e] += sum_pow;
        ifed_gnd[e] += sum_gnd;
    }

    // Faza 2: Dwuwskaźnikowa kompaktacja in-place tablic jonowych
    #pragma omp single
    {
        int total_abs = 0;
        for (int t2 = 0; t2 < num_threads; ++t2) {
            total_abs   += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
            N_i_abs_pow += worker_buffers.thread_counters[t2].local_abs_pow;
            N_i_abs_gnd += worker_buffers.thread_counters[t2].local_abs_gnd;
        }

        if (total_abs > 0) {
            int last_valid = N_i - 1;
            for (int t2 = 0; t2 < num_threads; t2++) {
                for (int dead_idx : worker_buffers.absorbed_indices[t2]) {
                    while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
                        last_valid--;
                    }
                    if (last_valid > dead_idx) {
                        x_i[dead_idx]  = x_i[last_valid];
                        vx_i[dead_idx] = vx_i[last_valid];
                        vy_i[dead_idx] = vy_i[last_valid];
                        vz_i[dead_idx] = vz_i[last_valid];
                        last_valid--;
                    }
                }
            }
            N_i -= total_abs;
        }
    }
}

/*
Krok 7: Równoległe zderzenia elektronów metodą Null-Collision z rozkładem dwumianowym.
Każdy wątek losuje liczbę kandydatów do zderzenia w swoim podzbiorze z rozkładu Binomial(N_local, P_star_e),
przeprowadza test akceptacji i zapisuje cząstki z jonizacji w swoim buforze prywatnym.
Następnie jeden wątek dopisuje nowe cząstki do globalnych tablic SoA.
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
*/
PIC_STEP void step7_collisions_electrons(int tid, int num_threads) {
    worker_buffers.new_electrons[tid].clear();
    worker_buffers.new_ions[tid].clear();

    int chunk   = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end   = std::min(k_start + chunk, N_e);
    int N_local = k_end - k_start;

    if (N_local > 0) {
        std::binomial_distribution<int> binom_e(N_local, P_star_e);
        int local_N_coll = binom_e(MTgen);
        if (local_N_coll > N_local) {
            local_N_coll = N_local;
        }

        for (int i = 0; i < local_N_coll; ++i) {
            int ki = k_start + (int)(R01(MTgen) * N_local);
            if (ki >= k_end) {
                ki = k_end - 1;
            }

            double v_sqr        = vx_e[ki] * vx_e[ki] + vy_e[ki] * vy_e[ki] + vz_e[ki] * vz_e[ki];
            double velocity     = sqrt(v_sqr);
            int    energy_index = min(int(v_sqr * FACTOR_ENERGY_E + 0.5), CS_RANGES - 1);

            double real_nu  = sigma_tot_e[energy_index] * velocity;
            double p_accept = real_nu / nu_star_e;
            if (p_accept > 1.0) {
                p_accept = 1.0;
            }

            if (R01(MTgen) < p_accept) {
                collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
                                   worker_buffers.new_electrons[tid], worker_buffers.new_ions[tid]);
                worker_buffers.thread_counters[tid].local_coll_e++;
            }
        }
    }

    // Seryjne dopisanie nowo narodzonych cząstek z buforów wątków do tablic globalnych
    #pragma omp barrier
    #pragma omp single
    {
        for (int t = 0; t < num_threads; ++t) {
            N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
            worker_buffers.thread_counters[t].local_coll_e = 0;
            for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
                x_e[N_e]  = worker_buffers.new_electrons[t].x[i];
                vx_e[N_e] = worker_buffers.new_electrons[t].vx[i];
                vy_e[N_e] = worker_buffers.new_electrons[t].vy[i];
                vz_e[N_e] = worker_buffers.new_electrons[t].vz[i];
                N_e++;
            }
            for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
                x_i[N_i]  = worker_buffers.new_ions[t].x[i];
                vx_i[N_i] = worker_buffers.new_ions[t].vx[i];
                vy_i[N_i] = worker_buffers.new_ions[t].vy[i];
                vz_i[N_i] = worker_buffers.new_ions[t].vz[i];
                N_i++;
            }
        }
    }
}

/*
Krok 8: Równoległe zderzenia jonów z atomami tła metodą Null-Collision (subcycling co N_SUB kroków).
Każdy wątek losuje liczbę kandydatów do zderzenia w swoim podzbiorze z rozkładu Binomial(N_local, P_star_i)
i wykonuje test akceptacji z uwzględnieniem losowej prędkości termicznej atomu Ar.
@param tid         Unikalny identyfikator bieżącego wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole OpenMP.
@param t           Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
PIC_STEP void step8_collision_ions(int tid, int num_threads, int t) {
    if ((t % N_SUB) != 0) return;

    int chunk   = (N_i + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_i);
    int k_end   = std::min(k_start + chunk, N_i);
    int N_local = k_end - k_start;

    if (N_local > 0) {
        std::binomial_distribution<int> binom_i(N_local, P_star_i);
        int local_N_coll = binom_i(MTgen);
        if (local_N_coll > N_local) {
            local_N_coll = N_local;
        }

        double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g;
        int    energy_index;

        for (int i = 0; i < local_N_coll; ++i) {
            int ki = k_start + (int)(R01(MTgen) * N_local);
            if (ki >= k_end) {
                ki = k_end - 1;
            }

            vx_a         = RMB(MTgen);
            vy_a         = RMB(MTgen);
            vz_a         = RMB(MTgen);
            gx           = vx_i[ki] - vx_a;
            gy           = vy_i[ki] - vy_a;
            gz           = vz_i[ki] - vz_a;
            g_sqr        = gx * gx + gy * gy + gz * gz;
            g            = sqrt(g_sqr);
            energy_index = min(int(g_sqr * FACTOR_ENERGY_I + 0.5), CS_RANGES - 1);

            double real_nu  = sigma_tot_i[energy_index] * g;
            double p_accept = real_nu / nu_star_i;
            if (p_accept > 1.0) {
                p_accept = 1.0;
            }

            if (R01(MTgen) < p_accept) {
                collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
                worker_buffers.thread_counters[tid].local_coll_i++;
            }
        }
    }

    // Redukcja liczników zderzeń jonów wykonywana przez pojedynczy wątek
    #pragma omp barrier
    #pragma omp single
    {
        for (int t = 0; t < num_threads; ++t) {
            N_i_coll += worker_buffers.thread_counters[t].local_coll_i;
            worker_buffers.thread_counters[t].local_coll_i = 0;
        }
    }
}

/*
Krok 9: Zbieranie chwilowych profili siatkowych do macierzy rozkładów czasoprzestrzennych XT.
Funkcja wywoływana wewnątrz bloku single, gdy aktywny jest tryb pomiarowy.
@param t_index Indeks przedziału czasowego w okresie RF (0 .. N_XT-1).
*/
PIC_STEP void step9_collect_xt_data(int t_index) {
    if (!measurement_mode) return;

    for (int p = 0; p < N_G; p++) {
        pot_xt   [p][t_index] += pot[p];
        efield_xt[p][t_index] += efield[p];
        ne_xt    [p][t_index] += e_density[p];
        ni_xt    [p][t_index] += i_density[p];
    }
}

/*
Wykonuje jeden pełny okres RF symulacji (N_T = 4000 kroków czasowych DT_E).
Tworzy pojedynczy trwały region równoległy OpenMP obejmujący całą pętlę czasową,
dzięki czemu wątki robocze są uruchamiane raz na cykl i synchronizowane wyłącznie barierami.
*/
PIC_STEP void do_one_cycle(void) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    #pragma omp parallel
    {
        int tid      = omp_get_thread_num();
        int nthreads = omp_get_num_threads();

        for (int t = 0; t < N_T; t++) {
            int t_index = t / N_BIN;

            // Krok 1: Równoległa depozycja gęstości ładunku elektronów i jonów na siatkę
            step1_compute_electron_density(tid, nthreads);
            step1_compute_ion_density(tid, nthreads, t);

            #pragma omp barrier

            // Krok 2: Inkrementacja czasu fizycznego i rozwiązanie równania Poissona w jednym wątku
            #pragma omp single
            {
                Time += DT_E;
                step2_solve_poisson(Time);
            }

            // Kroki 3 i 4: Równoległe przesunięcie elektronów i jonów oraz redukcja diagnostyk
            step3_move_electrons(tid, nthreads, t_index);
            step4_move_ions(tid, nthreads, t_index, t);

            // Kroki 5 i 6: Równoległa weryfikacja granic i kompaktacja zaabsorbowanych cząstek
            step5_check_boundaries_electrons(tid, nthreads);
            step6_check_boundaries_ions(tid, nthreads, t);

            // Kroki 7 i 8: Równoległe zderzenia Monte Carlo metodą Null-Collision
            step7_collisions_electrons(tid, nthreads);
            step8_collision_ions(tid, nthreads, t);

            // Krok 9: Zbieranie profili czasoprzestrzennych XT oraz okresowy wydruk postępu
            if (__builtin_expect(measurement_mode || (t % 1000) == 0, 0)) {
                #pragma omp single
                {
                    step9_collect_xt_data(t_index);
                    if ((t % 1000) == 0) {
                        printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", cycle, t, N_e, N_i);
                    }
                }
            }
        }
    }
    fprintf(datafile, "%8d  %8d  %8d\n", cycle, N_e, N_i);
}
