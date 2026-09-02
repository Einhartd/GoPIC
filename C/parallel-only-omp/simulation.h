#pragma once

#include "state.h"
#include "poisson.h"
#include <array>
#include <cmath>
#include <omp.h>
#include "collisions.h"

#include "null_collision.h"
   

/*
Inicjalizacja cząstek początkowych.
Losuje pozycje 1D z rozkładu jednorodnego w [0, L] oraz zeruje prędkości 3V dla par elektron-jon.
@param nseed Liczba początkowych par elektronów i jonów do zainicjalizowania.
*/
inline void init(int nseed) {
    for (int i = 0; i < nseed; i++) {
        x_e[i]  = L * R01(MTgen);               // Początkowa pozycja elektronu
        vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // Początkowa prędkość 3V elektronu
        x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
        vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Początkowa prędkość 3V jonu
    }
    N_e = nseed;    // Początkowa liczba elektronów
    N_i = nseed;    // Początkowa liczba jonów
}

// -----------------------------------------------------------------------------
// Wzorzec optymalizacji OpenMP stosowany w całej symulacji:
//  1) Każdy wątek operuje wyłącznie na swoich prywatnych buforach
//     (worker_buffers.e_density[tid], worker_buffers.counter_e[tid], ...).
//  2) Po zakończeniu fazy równoległej następuje faza redukcji, w której lokalne
//     wyniki są sumowane do tablic globalnych (e_density, efield, ifed_pow itp.).
//  3) Bariery synchronizacyjne (#pragma omp barrier) oraz bloki pojedyncze
//     (#pragma omp single) są stosowane tylko w punktach wymagających spójności
//     globalnego stanu (przed redukcją, usuwaniem cząstek z granic lub scalaniem).
// -----------------------------------------------------------------------------

/*
KROK 1a: Obliczanie gęstości ładunku elektronów (Depozycja CIC / Scatter-Add).
Ciało funkcji wykonywane równolegle wewnątrz zespołu wątków OpenMP.
Etapy:
 1. Wyzerowanie lokalnego bufora gęstości elektronów w worker_buffers.
 2. Równoległa depozycja wagowa metodą Cloud-in-Cell (CIC) cząstek do siatki lokalnej.
 3. Bariera synchronizacyjna przed rozpoczęciem redukcji.
 4. Równoległa redukcja (sumowanie) buforów wątków do tablicy globalnej e_density.
 5. Korekta gęstości w skrajnych półkomórkach (węzły 0 i N_G-1) mnożona x2 (wykonuje 1 wątek).
 6. Akumulacja do skumulowanej gęstości cumul_e_density.
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
*/
PIC_STEP void step1_compute_electron_density_body(int tid, int num_threads) {
    worker_buffers.e_density[tid].fill(0.0);

    int chunk = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end   = std::min(k_start + chunk, N_e);

    for (int k = k_start; k < k_end; k++) {
        __builtin_prefetch(&x_e[k+16], 0, 1);

        double c0 = x_e[k] * INV_DX;
        int p     = int(c0);
        double c2 = (c0 - p) * FACTOR_W;
        double c1 = FACTOR_W - c2;
        worker_buffers.e_density[tid][p]   += c1;
        worker_buffers.e_density[tid][p+1] += c2;
    }

    #pragma omp barrier

    // Zintegrowana redukcja prywatnych buforów, korekta brzegowa x2 oraz akumulacja cumul_e_density
    #pragma omp for schedule(static) nowait
    for (int p = 1; p < N_G-1; p++) {
        double sum = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum += worker_buffers.e_density[t][p];
        }
        e_density[p] = sum;
        cumul_e_density[p] += sum;
    }

    if (tid == 0) {
        double sum0 = 0.0, sumN = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum0 += worker_buffers.e_density[t][0];
            sumN += worker_buffers.e_density[t][N_G - 1];
        }
        double val0 = 2.0 * sum0;
        double valN = 2.0 * sumN;
        e_density[0] = val0;
        cumul_e_density[0] += val0;
        e_density[N_G - 1] = valN;
        cumul_e_density[N_G - 1] += valN;
    }
}

/*
Wrapper uruchamiający Krok 1a w niezależnej sekcji równoległej (używany np. w testach).
*/
PIC_STEP void step1_compute_electron_density(void) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step1_compute_electron_density_body(tid, nthreads);
    }
}

/*
KROK 1b: Obliczanie gęstości ładunku jonów (Subcycling co N_SUB kroków).
Ciało funkcji wykonywane równolegle wewnątrz zespołu wątków OpenMP.
Etapy:
 1. Jeśli (t % N_SUB == 0): wyzerowanie lokalnego bufora jonów i depozycja CIC do i_density.
 2. Zintegrowana redukcja, korekta brzegowa x2 i akumulacja cumul_i_density.
 3. W pozostałych krokach: akumulacja do cumul_i_density (niezmiennik subcyclingu).
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
@param t           Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
PIC_STEP void step1_compute_ion_density_body(int tid, int num_threads, int t) {
    if ((t % N_SUB) == 0) {
        worker_buffers.i_density[tid].fill(0.0);

        int chunk = (N_i + num_threads - 1) / num_threads;
        int k_start = std::min(tid * chunk, N_i);
        int k_end   = std::min(k_start + chunk, N_i);

        for (int k = k_start; k < k_end; k++) {
            __builtin_prefetch(&x_i[k+16], 0, 1);

            double c0 = x_i[k] * INV_DX;
            int p     = int(c0);
            double c2 = (c0 - p) * FACTOR_W;
            double c1 = FACTOR_W - c2;
            worker_buffers.i_density[tid][p]   += c1;
            worker_buffers.i_density[tid][p+1] += c2;
        }

        #pragma omp barrier

        #pragma omp for schedule(static) nowait
        for (int p = 1; p < N_G - 1; p++) {
            double sum = 0.0;
            for (int t2 = 0; t2 < num_threads; t2++) {
                sum += worker_buffers.i_density[t2][p];
            }
            i_density[p] = sum;
            cumul_i_density[p] += sum;
        }

        if (tid == 0) {
            double sum0 = 0.0, sumN = 0.0;
            for (int t2 = 0; t2 < num_threads; t2++) {
                sum0 += worker_buffers.i_density[t2][0];
                sumN += worker_buffers.i_density[t2][N_G - 1];
            }
            double val0 = 2.0 * sum0;
            double valN = 2.0 * sumN;
            i_density[0] = val0;
            i_density[N_G - 1] = valN;
            cumul_i_density[0] += val0;
            cumul_i_density[N_G - 1] += valN;
        }

    } else {
        // Ważny niezmiennik fizyczny: cumul_i_density akumuluje się w KAŻDYM kroku czasowym
        #pragma omp for simd schedule(static) nowait
        for (int p = 0; p < N_G; p++) cumul_i_density[p] += i_density[p];
    }
}

/*
Wrapper uruchamiający Krok 1b w niezależnej sekcji równoległej.
@param t Indeks bieżącego podkroku czasowego w cyklu RF.
*/
PIC_STEP void step1_compute_ion_density(int t) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step1_compute_ion_density_body(tid, nthreads, t);
    }
}

/*
KROK 2: Rozwiązanie równania Poissona (1D Field Solver).
Oblicza gęstość ładunku wypadkowego rho = e * (n_i - n_e) i wywołuje solver trójdiagonalny.
Wykonywane sekwencyjnie w pojedynczym wątku (N_G=400 jest zbyt małe na zysk z paralelizacji).
@param current_time Aktualny fizyczny czas symulacji [s].
*/
PIC_STEP void step2_solve_poisson(double current_time) {
    solve_Poisson(Time);
}

/*
KROK 3: Popychanie elektronów (Push / Leap-Frog) i akumulacja diagnostyk.
Ciało funkcji wykonywane równolegle wewnątrz zespołu wątków OpenMP.
Etapy:
 1. W trybie pomiarowym: wyzerowanie prywatnych buforów diagnostycznych danego wątku.
 2. Równoległa interpolacja pola elektrycznego (CIC) do pozycji cząstek.
 3. Akumulacja lokalnych wielkości (prędkość unoszenia, energia, jonizacja, EEPF w centrum).
 4. Integracja równań ruchu schematem Leap-Frog (aktualizacja vx_e i x_e).
 5. Bariera synchronizacyjna i równoległa redukcja diagnostyk do tablic globalnych XT i EEPF.
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
@param t_index     Indeks przedziału czasowego dla diagnostyk XT (t / N_BIN).
*/
PIC_STEP void step3_move_electrons_body(int tid, int num_threads, int t_index) {
    if (__builtin_expect(!measurement_mode, 1)) {
        int chunk = (N_e + num_threads - 1) / num_threads;
        int k_start = std::min(tid * chunk, N_e);
        int k_end   = std::min(k_start + chunk, N_e);

        #pragma omp simd simdlen(8) aligned(x_e, vx_e: 64)
        for (int k = k_start; k < k_end; k++) {
            __builtin_prefetch(&x_e[k+16], 0, 1);
            __builtin_prefetch(&vx_e[k+16], 1, 1);

            double c0 = x_e[k] * INV_DX;
            int p     = int(c0);
            double c2 = c0 - p;
            double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
            double v   = vx_e[k] - e_x * FACTOR_E;
            vx_e[k]    = v;
            x_e[k]    += v * DT_E;
        }
        return;
    }

    if (measurement_mode) {
        // Czyszczenie lokalnych buforów diagnostycznych wątku przed pętlą cząstkową.
        // Każdy wątek gromadzi własne statystyki niezależnie, bez konfliktów zapisu.
        worker_buffers.counter_e[tid].fill(0.0);
        worker_buffers.ue[tid].fill(0.0);
        worker_buffers.meanee[tid].fill(0.0);
        worker_buffers.ioniz[tid].fill(0.0);
        worker_buffers.eepf[tid].fill(0.0);
        worker_buffers.thread_counters[tid].accu_center   = 0.0;
        worker_buffers.thread_counters[tid].counter_center = 0;
    }

    int p, energy_index;
    double c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate;

    // Równoległe popychanie elektronów. Każdy wątek przetwarza swój podzbiór cząstek.
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

        energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
        velocity = sqrt(v_sqr);
        rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;

        worker_buffers.ioniz[tid][p]   += c1 * rate;
        worker_buffers.ioniz[tid][p+1] += c2 * rate;

        // Zliczanie funkcji EEPF w centralnym obszarze szczeliny [0.45*L, 0.55*L]
        if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
            energy_index = (int)(energy / DE_EEPF);
            if (energy_index < N_EEPF) {
                worker_buffers.eepf[tid][energy_index] += 1.0;
            }
            worker_buffers.thread_counters[tid].accu_center   += energy;
            worker_buffers.thread_counters[tid].counter_center++;
        }

        // Integracja równań ruchu (schemat Leap-Frog)
        vx_e[k] -= e_x * FACTOR_E;
        x_e[k]  += vx_e[k] * DT_E;
    }

    if (measurement_mode) {
        // Redukcja lokalnych tablic diagnostycznych do globalnych macierzy czasoprzestrzennych XT
        #pragma omp for nowait
        for (int p = 0; p < N_G; p++) {
            double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
            for (int t = 0; t < num_threads; t++) {
                c_e += worker_buffers.counter_e[t][p];
                u_e += worker_buffers.ue[t][p];
                m_e += worker_buffers.meanee[t][p];
                iz  += worker_buffers.ioniz[t][p];
            }
            counter_e_xt[p][t_index]   += c_e;
            ue_xt[p][t_index]          += u_e;
            meanee_xt[p][t_index]      += m_e;
            ioniz_rate_xt[p][t_index]  += iz;
        }

        // Redukcja histogramu EEPF
        #pragma omp for
        for (int i = 0; i < N_EEPF; i++) {
            double sum_eepf = 0.0;
            for (int t = 0; t < num_threads; t++) {
                sum_eepf += worker_buffers.eepf[t][i];
            }
            eepf[i] += sum_eepf;
        }

        // Jeden wątek sumuje skalarne zbieracze energii w centrum
        #pragma omp single
        {
            for (int t = 0; t < num_threads; t++) {
                mean_energy_accu_center    += worker_buffers.thread_counters[t].accu_center;
                mean_energy_counter_center += worker_buffers.thread_counters[t].counter_center;
            }
        }
    }
}

/*
Wrapper uruchamiający Krok 3 w niezależnej sekcji równoległej.
Używamy do testów.
@param t_index Indeks przedziału czasowego dla diagnostyk XT.
*/
PIC_STEP void step3_move_electrons(int t_index) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step3_move_electrons_body(tid, nthreads, t_index);
    }
}

/*
KROK 4: Popychanie jonów (Push / Leap-Frog, Subcycling co N_SUB kroków).
Ciało funkcji wykonywane równolegle wewnątrz zespołu wątków OpenMP.
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. W trybie pomiarowym: zerowanie buforów diagnostycznych i interpolacja pola E.
 3. Popychanie cząstek schematem Leap-Frog z uwzględnieniem dodatniego ładunku jonów (+e).
 4. Bariera synchronizacyjna i redukcja diagnostyk jonowych do macierzy XT.
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
@param t_index     Indeks przedziału czasowego dla diagnostyk XT (t / N_BIN).
@param t           Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
    if ((t % N_SUB) != 0) return;

    if (__builtin_expect(!measurement_mode, 1)) {
        int chunk = (N_i + num_threads - 1) / num_threads;
        int k_start = std::min(tid * chunk, N_i);
        int k_end   = std::min(k_start + chunk, N_i);

        #pragma omp simd simdlen(8) aligned(x_i, vx_i: 64)
        for (int k = k_start; k < k_end; k++) {
            __builtin_prefetch(&x_i[k+16], 0, 1);
            __builtin_prefetch(&vx_i[k+16], 1, 1);

            double c0 = x_i[k] * INV_DX;
            int p     = int(c0);
            double c2 = c0 - p;
            double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
            double v   = vx_i[k] + e_x * FACTOR_I;
            vx_i[k]    = v;
            x_i[k]    += v * DT_I;
        }
        return;
    }

    if (measurement_mode) {
        worker_buffers.counter_i[tid].fill(0.0);
        worker_buffers.ui[tid].fill(0.0);
        worker_buffers.meanei[tid].fill(0.0);
    }

    int p;
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

        // Jony mają ładunek dodatni (+e), więc przyspieszenie ma znak plus
        vx_i[k] += e_x * FACTOR_I;
        x_i[k]  += vx_i[k] * DT_I;
    }

    if (measurement_mode) {
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
}

/*
Wrapper uruchamiający Krok 4 w niezależnej sekcji równoległej.
@param t_index Indeks przedziału czasowego dla diagnostyk XT.
@param t       Indeks bieżącego podkroku czasowego w cyklu RF.
*/
PIC_STEP void step4_move_ions(int t_index, int t) {
    if ((t % N_SUB) != 0) return;
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step4_move_ions_body(tid, nthreads, t_index, t);
    }
}

/*
KROK 5: Sprawdzanie granic dla elektronów (Równoległe oznaczanie + Dwuwskanikowa kompaktacja in-place).
Ciało funkcji wykonywane wewnątrz zespołu wątków OpenMP.
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
*/
PIC_STEP void step5_check_boundaries_electrons_body(int tid, int num_threads) {
    worker_buffers.absorbed_indices[tid].clear();
    worker_buffers.thread_counters[tid].local_abs_pow = 0;
    worker_buffers.thread_counters[tid].local_abs_gnd = 0;

    int chunk = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end = std::min(k_start + chunk, N_e);

    // Faza 1: Równoległe sprawdzanie i zbieranie indeksów pochłoniętych elektronów
    for (int k = k_start; k < k_end; k++) {
        __builtin_prefetch(&x_e[k+16], 0, 1);

        if (__builtin_expect(x_e[k] < 0.0, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_pow++;
        } else if (__builtin_expect(x_e[k] > L, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_gnd++;
        }
    }

    #pragma omp barrier

    // Faza 2: Błyskawiczna kompaktacja - tylko dla usuniętych cząstek
    #pragma omp single
    {
        int total_abs = 0;
        for (int t = 0; t < num_threads; t++) {
            total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
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
Wrapper uruchamiający Krok 5 w niezależnej sekcji równoległej (dla testów jednostkowych).
*/
PIC_STEP void step5_check_boundaries_electrons() {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step5_check_boundaries_electrons_body(tid, nthreads);
    }
}

/*
KROK 6: Sprawdzanie granic dla jonów (Subcycling co N_SUB kroków).
Ciało funkcji wykonywane wewnątrz zespołu wątków OpenMP.
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
@param t           Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
PIC_STEP void step6_check_boundaries_ions_body(int tid, int num_threads, int t) {
    if ((t % N_SUB) != 0) return;

    worker_buffers.absorbed_indices[tid].clear();
    worker_buffers.thread_counters[tid].local_abs_pow = 0;
    worker_buffers.thread_counters[tid].local_abs_gnd = 0;
    worker_buffers.local_ifed_pow[tid].fill(0);
    worker_buffers.local_ifed_gnd[tid].fill(0);

    int chunk = (N_i + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_i);
    int k_end = std::min(k_start + chunk, N_i);

    for (int k = k_start; k < k_end; k++) {
        __builtin_prefetch(&x_i[k+16], 0, 1);

        if (__builtin_expect(x_i[k] < 0.0, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_pow++;
            double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            double energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
            int energy_index = (int)(energy / DE_IFED);
            if (energy_index < N_IFED) {
                worker_buffers.local_ifed_pow[tid][energy_index]++;
            }
        } else if (__builtin_expect(x_i[k] > L, 0)) {
            worker_buffers.absorbed_indices[tid].push_back(k);
            worker_buffers.thread_counters[tid].local_abs_gnd++;
            double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            double energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
            int energy_index = (int)(energy / DE_IFED);
            if (energy_index < N_IFED) {
                worker_buffers.local_ifed_gnd[tid][energy_index]++;
            }
        }
    }

    #pragma omp barrier
    // Równoległa redukcja histogramu IFED (N_IFED = 200)
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

    #pragma omp single
    {
        int total_abs = 0;
        for (int t2 = 0; t2 < num_threads; ++t2) {
            total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
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
Wrapper uruchamiający Krok 6 w niezależnej sekcji równoległej (dla testów jednostkowych).
@param t Indeks bieżącego podkroku czasowego w cyklu RF.
*/
PIC_STEP void step6_check_boundaries_ions(int t) {
    if ((t % N_SUB) != 0) return;
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step6_check_boundaries_ions_body(tid, nthreads, t);
    }
}

/*
KROK 7: Zderzenia elektronów i procesy jonizacji (Monte Carlo Collisions - Null-Collision).
Ciało funkcji wykonywane równolegle wewnątrz zespołu wątków OpenMP.
Etapy:
 1. Jeden wątek (single) losuje liczbę zderzeń N*_coll ~ Binomial(N_e, P*_e) i tworzy listę próbki.
 2. Wątki dzielą listę równomiernie i sprawdzają warunek akceptacji P_accept = nu / nu*_e.
 3. Akceptowane zderzenia zapisują nowe elektrony/jony do prywatnych buforów new_electrons/new_ions.
 4. Bariera synchronizacyjna i sekwencyjne scalenie nowych cząstek na koniec tablic SoA.
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
*/
PIC_STEP void step7_collisions_electrons_body(int tid, int num_threads) {

    // Czyszczenie lokalnych buforów cząstek przed kolejnym krokiem
    worker_buffers.new_electrons[tid].clear();
    worker_buffers.new_ions[tid].clear();

    int chunk = (N_e + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_e);
    int k_end = std::min(k_start + chunk, N_e);
    int N_local = k_end - k_start;

    if (N_local > 0) {
        // Równomierny podział listy kandydatów pomiędzy wątki
        std::binomial_distribution<int> binom_e(N_local, P_star_e);
        int local_N_coll = binom_e(MTgen);
        if (local_N_coll > N_local) local_N_coll = N_local;

        for (int i = 0; i < local_N_coll; ++i) {
            int ki = k_start + (int)(R01(MTgen) * N_local);
            if (ki >= k_end) ki = k_end - 1;

            double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
            double velocity  = sqrt(v_sqr);
            double energy    = 0.5 * E_MASS * v_sqr / EV_TO_J;
            int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);

            double real_nu  = sigma_tot_e[energy_index] * velocity;
            double p_accept = real_nu / nu_star_e;
            if (p_accept > 1.0) p_accept = 1.0;

            // Metoda akceptacji-odrzucenia (Rejection sampling)
            if (R01(MTgen) < p_accept) {
                collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
                                   worker_buffers.new_electrons[tid], worker_buffers.new_ions[tid]);
                worker_buffers.thread_counters[tid].local_coll_e++;
            }
        }
    }

    // Seryjne przepisanie nowo utworzonych cząstek do globalnych tablic SoA oraz akumulacja liczników
    #pragma omp barrier
    #pragma omp single
    {
        for (int t = 0; t < num_threads; ++t) {
            N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
            worker_buffers.thread_counters[t].local_coll_e = 0;
            for (size_t i = 0; i < worker_buffers.new_electrons[t].x.size(); ++i) {
                x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
                vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
                vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
                vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
                N_e++;
            }
            for (size_t i = 0; i < worker_buffers.new_ions[t].x.size(); ++i) {
                x_i[N_i]    = worker_buffers.new_ions[t].x[i];
                vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
                vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
                vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
                N_i++;
            }
        }
    }
}

/*
Wrapper uruchamiający Krok 7 w niezależnej sekcji równoległej.
*/
PIC_STEP void step7_collisions_electrons() {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step7_collisions_electrons_body(tid, nthreads);
    }
}

/*
KROK 8: Zderzenia jonów z neutralnymi atomami gazu (Null-Collision, Subcycling co N_SUB kroków).
Ciało funkcji wykonywane równolegle wewnątrz zespołu wątków OpenMP.
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Losowanie liczby kandydatów N*_coll,i i równomierny podział pomiędzy wątki.
 3. Losowanie prędkości termicznej neutralnego atomu argonu z rozkładu Maxwella-Boltzmanna RMB.
 4. Sprawdzenie warunku akceptacji zderzenia i wywołanie collision_ion.
@param tid         Unikalny identyfikator wątku OpenMP (0 .. num_threads-1).
@param num_threads Całkowita liczba wątków w zespole.
@param t           Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
PIC_STEP void step8_collision_ions_body(int tid, int num_threads, int t) {
    if ((t % N_SUB) != 0) return;

    // Podział tablicy jonów na lokalne wycinki wątków
    int chunk = (N_i + num_threads - 1) / num_threads;
    int k_start = std::min(tid * chunk, N_i);
    int k_end = std::min(k_start + chunk, N_i);
    int N_local = k_end - k_start;

    if (N_local > 0) {
        std::binomial_distribution<int> binom_i(N_local, P_star_i);
        int local_N_coll = binom_i(MTgen);
        if (local_N_coll > N_local) local_N_coll = N_local;

        double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy;
        int energy_index;

        for (int i = 0; i < local_N_coll; ++i) {
            int ki = k_start + (int)(R01(MTgen) * N_local);
            if (ki >= k_end) ki = k_end - 1;

            // Prędkość termiczna neutralnego atomu tła losowana z rozkładu Maxwella-Boltzmanna
            vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
            gx = vx_i[ki] - vx_a;
            gy = vy_i[ki] - vy_a;
            gz = vz_i[ki] - vz_a;
            g_sqr = gx*gx + gy*gy + gz*gz;
            g = sqrt(g_sqr);
            energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
            energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);

            double real_nu = sigma_tot_i[energy_index] * g;
            double p_accept = real_nu / nu_star_i;
            if (p_accept > 1.0) p_accept = 1.0;

            if (R01(MTgen) < p_accept) {
                collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
                worker_buffers.thread_counters[tid].local_coll_i++;
            }
        }
    }

    #pragma omp single
    {
        for (int t = 0; t < num_threads; ++t) {
            N_i_coll += worker_buffers.thread_counters[t].local_coll_i;
            worker_buffers.thread_counters[t].local_coll_i = 0;
        }
    }
}

/*
Wrapper uruchamiający Krok 8 w niezależnej sekcji równoległej.
@param t Indeks bieżącego podkroku czasowego w cyklu RF.
*/
PIC_STEP void step8_collision_ions(int t) {
    if ((t % N_SUB) != 0) return;
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step8_collision_ions_body(tid, nthreads, t);
    }
}

/*
KROK 9: Zbieranie danych diagnostycznych XT (Rozkłady czasoprzestrzenne).
Kopiuje chwilowe profile siatki do macierzy czasoprzestrzennych N_G x N_XT.
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
Główna pętla czasowa jednego pełnego okresu RF (4000 podkroków czasowych DT_E).
Wykorzystuje jeden trwały zespół wątków OpenMP (#pragma omp parallel) obejmujący
całą pętlę podkroków, eliminując narzut ciągłego tworzenia i niszczenia wątków.
Etapy w każdym podkroku t (0 .. N_T-1):
 1. Inkrementacja czasu fizycznego (blok single).
 2. Depozycja gęstości ładunku elektronów i jonów (Krok 1a i 1b).
 3. Rozwiązanie równania Poissona dla potencjału i pola elektrycznego (Krok 2).
 4. Popychanie elektronów i jonów schematem Leap-Frog oraz pomiar wielkości XT (Krok 3 i 4).
 5. Absorpcja cząstek na elektrodach i kompaktacja tablic (Krok 5 i 6).
 6. Zderzenia kinetyczne Monte Carlo MCC (Krok 7 i 8).
 7. Diagnostyka czasoprzestrzenna XT (Krok 9).
*/
PIC_STEP void do_one_cycle(void) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    // Utworzenie trwałego zespołu wątków na cały okres RF
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();

        for (int t = 0; t < N_T; t++) {
            int t_index = t / N_BIN;

            // Krok 1: Depozycja gęstości ładunku elektronów i jonów (równoległa + redukcja)
            step1_compute_electron_density_body(tid, nthreads);
            step1_compute_ion_density_body(tid, nthreads, t);

            // Krok 2: Inkrementacja czasu i rozwiązanie równania Poissona (sekwencyjnie w 1 bloku single)
            #pragma omp single
            {
                Time += DT_E;
                step2_solve_poisson(Time);
            }

            // Krok 3 & 4: Popychanie elektronów i jonów (równoległe + redukcja diagnostyk)
            step3_move_electrons_body(tid, nthreads, t_index);
            step4_move_ions_body(tid, nthreads, t_index, t);

            // Krok 5 & 6: Warunki brzegowe (równoległe oznaczanie + seryjna kompaktacja)
            step5_check_boundaries_electrons_body(tid, nthreads);
            step6_check_boundaries_ions_body(tid, nthreads, t);

            // Krok 7 & 8: Zderzenia kinetyczne MCC (równoległe + seryjne scalenie nowych cząstek)
            step7_collisions_electrons_body(tid, nthreads);
            step8_collision_ions_body(tid, nthreads, t);

            // Krok 9: Diagnostyka czasoprzestrzenna XT oraz okresowe wypisywanie stanu
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
    // Zapis liczby cząstek po zakończeniu cyklu do pliku zbieżności conv.dat
    fprintf(datafile, "%8d  %8d  %8d\n", cycle, N_e, N_i);
}
