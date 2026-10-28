#pragma once
#include "state.h"
#include "poisson.h"
#include "collisions.h"
#include <cmath>

#ifdef USE_NULL_COLLISION
#include "null_collision.h"
#endif

/*
Inicjalizuje początkowy stan plazmy poprzez jednorodne rozmieszczenie zadanej liczby
par elektron-jon na odcinku [0, L] z zerowymi prędkościami początkowymi.
@param nseed Liczba początkowych par makrocząstek do wygenerowania.
*/
inline void init(int nseed) {
    for (int i = 0; i < nseed; i++) {
        // Losowa pozycja początkowa oraz zerowa prędkość elektronu
        x_e[i]  = L * R01(MTgen);
        vx_e[i] = 0;
        vy_e[i] = 0;
        vz_e[i] = 0;

        // Losowa pozycja początkowa oraz zerowa prędkość jonu
        x_i[i]  = L * R01(MTgen);
        vx_i[i] = 0;
        vy_i[i] = 0;
        vz_i[i] = 0;
    }
    N_e = nseed;
    N_i = nseed;
}

/*
KROK 1a: Oblicza gęstość liczbową elektronów w węzłach siatki metodą Cloud-in-Cell (CIC).
Etapy:
 1. Wyzerowanie bieżącej tablicy gęstości elektronów.
 2. Liniowa depozycja ładunku każdego elektronu do dwóch sąsiednich węzłów siatki.
 3. Podwojenie gęstości w skrajnych węzłach brzegowych (półkomórki przy elektrodach).
 4. Dodanie gęstości chwilowej do akumulatora średniego profilu przestrzennego.
*/
inline void step1_compute_electron_density(void) {
    int k, p;
    double c0;

    // 1. Wyzerowanie tablicy gęstości elektronów
    for (p = 0; p < N_G; p++) {
        e_density[p] = 0;
    }

    // 2. Depozycja wagowa ładunku elektronów na siatkę (schemat CIC)
    for (k = 0; k < N_e; k++) {
        c0 = x_e[k] * INV_DX;
        p  = int(c0);
        e_density[p]   += (p + 1 - c0) * FACTOR_W;
        e_density[p+1] += (c0 - p) * FACTOR_W;
    }

    // 3. Korekcja objętości półkomórek na granicach siatki (x = 0 oraz x = L)
    e_density[0]     *= 2.0;
    e_density[N_G-1] *= 2.0;

    // 4. Akumulacja gęstości elektronów do uśredniania czasowego
    for (p = 0; p < N_G; p++) {
        cumul_e_density[p] += e_density[p];
    }
}

/*
KROK 1b: Oblicza gęstość liczbową jonów w węzłach siatki metodą CIC z uwzględnieniem subcyclingu.
Depozycja jonów wykonywana jest raz na N_SUB kroków elektronowych, natomiast akumulacja
do profilu średniego odbywa się w każdym kroku czasowym.
@param t Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
inline void step1_compute_ion_density(int t) {
    int k, p;
    double c0;

    // 1. Przeliczenie gęstości jonów w krokach subcyclingu (co N_SUB kroków czasowych)
    if ((t % N_SUB) == 0) {
        for (p = 0; p < N_G; p++) {
            i_density[p] = 0;
        }
        for (k = 0; k < N_i; k++) {
            c0 = x_i[k] * INV_DX;
            p  = int(c0);
            i_density[p]   += (p + 1 - c0) * FACTOR_W;
            i_density[p+1] += (c0 - p) * FACTOR_W;
        }
        i_density[0]     *= 2.0;
        i_density[N_G-1] *= 2.0;
    }

    // 2. Akumulacja gęstości jonów do uśredniania czasowego
    for (p = 0; p < N_G; p++) {
        cumul_i_density[p] += i_density[p];
    }
}

/*
KROK 2: Wyznacza gęstość ładunku przestrzennego rho = e * (n_i - n_e) i rozwiązuje równanie Poissona.
@param current_time Aktualny fizyczny czas symulacji [s].
*/
inline void step2_solve_poisson(double current_time) {
    xvector rho;

    // Obliczenie wypadkowej gęstości ładunku w węzłach siatki
    for (int p = 0; p < N_G; p++) {
        rho[p] = E_CHARGE * (i_density[p] - e_density[p]);
    }
    solve_Poisson(rho, current_time);
}

/*
KROK 3: Przemieszcza wszystkie elektrony zgodnie ze schematem Leap-Frog oraz gromadzi diagnostyki elektronowe.
Etapy:
 1. Interpolacja liniowa natężenia pola elektrycznego z węzłów siatki do położenia cząstki.
 2. W trybie pomiarowym: obliczenie prędkości i energii w chwili całkowitej t oraz akumulacja rozkładów XT i EEPF.
 3. Aktualizacja prędkości i położenia elektronu w kroku czasowym DT_E.
@param t_index Indeks przedziału czasowego w macierzach czasoprzestrzennych XT (t / N_BIN).
*/
inline void step3_move_electrons(int t_index) {
    int k, p, energy_index;
    double c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate;

    for (k = 0; k < N_e; k++) {
        // 1. Interpolacja pola elektrycznego E do pozycji elektronu
        c0  = x_e[k] * INV_DX;
        p   = int(c0);
        c1  = p + 1.0 - c0;
        c2  = c0 - p;
        e_x = c1 * efield[p] + c2 * efield[p+1];

        // 2. Gromadzenie diagnostyk czasoprzestrzennych XT oraz rozkładu EEPF
        if (measurement_mode) {
            mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
            counter_e_xt[p][t_index]   += c1;
            counter_e_xt[p+1][t_index] += c2;
            ue_xt[p][t_index]          += c1 * mean_v;
            ue_xt[p+1][t_index]        += c2 * mean_v;
            v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
            energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
            meanee_xt[p][t_index]      += c1 * energy;
            meanee_xt[p+1][t_index]    += c2 * energy;
            energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
            velocity     = sqrt(v_sqr);
            rate         = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
            ioniz_rate_xt[p][t_index]   += c1 * rate;
            ioniz_rate_xt[p+1][t_index] += c2 * rate;

            // Zliczanie histogramu EEPF w centralnym obszarze wyładowania [MIN_X, MAX_X]
            if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
                energy_index = (int)(energy / DE_EEPF);
                if (energy_index < N_EEPF) {
                    eepf[energy_index] += 1.0;
                }
                mean_energy_accu_center += energy;
                mean_energy_counter_center++;
            }
        }

        // 3. Całkowanie równań ruchu metodą Leap-Frog
        vx_e[k] -= e_x * FACTOR_E;
        x_e[k]  += vx_e[k] * DT_E;
    }
}

/*
KROK 4: Przemieszcza jony zgodnie ze schematem Leap-Frog (co N_SUB kroków) oraz gromadzi diagnostyki jonowe.
@param t_index Indeks przedziału czasowego w macierzach czasoprzestrzennych XT (t / N_BIN).
@param t       Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
inline void step4_move_ions(int t_index, int t) {
    if ((t % N_SUB) != 0) return;

    int k, p;
    double c0, c1, c2, e_x, mean_v, v_sqr, energy;

    for (k = 0; k < N_i; k++) {
        // 1. Interpolacja pola elektrycznego E do pozycji jonu
        c0  = x_i[k] * INV_DX;
        p   = int(c0);
        c1  = p + 1 - c0;
        c2  = c0 - p;
        e_x = c1 * efield[p] + c2 * efield[p+1];

        // 2. Gromadzenie diagnostyk czasoprzestrzennych XT dla jonów
        if (measurement_mode) {
            mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
            counter_i_xt[p][t_index]   += c1;
            counter_i_xt[p+1][t_index] += c2;
            ui_xt[p][t_index]          += c1 * mean_v;
            ui_xt[p+1][t_index]        += c2 * mean_v;
            v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
            meanei_xt[p][t_index]      += c1 * energy;
            meanei_xt[p+1][t_index]    += c2 * energy;
        }

        // 3. Całkowanie równań ruchu jonu w kroku DT_I
        vx_i[k] += e_x * FACTOR_I;
        x_i[k]  += vx_i[k] * DT_I;
    }
}

/*
KROK 5: Sprawdza warunki brzegowe dla elektronów i usuwa cząstki zaabsorbowane na elektrodach.
Zlicza elektrony pochłonięte na elektrodzie zasilanej (x < 0) oraz uziemionej (x > L),
usuwając je z tablic przez nadpisanie ostatnim aktywnym elektronem.
*/
inline void step5_check_boundaries_electrons() {
    int k = 0;
    bool out;

    while (k < N_e) {
        out = false;
        if (x_e[k] < 0) {
            N_e_abs_pow++;
            out = true;
        }
        if (x_e[k] > L) {
            N_e_abs_gnd++;
            out = true;
        }
        if (out) {
            // Zastąpienie usuniętego elektronu ostatnią cząstką z końca tablicy
            x_e[k]  = x_e[N_e-1];
            vx_e[k] = vx_e[N_e-1];
            vy_e[k] = vy_e[N_e-1];
            vz_e[k] = vz_e[N_e-1];
            N_e--;
        } else {
            k++;
        }
    }
}

/*
KROK 6: Sprawdza warunki brzegowe dla jonów (co N_SUB kroków), rejestruje rozkład energii IFED
i usuwa jony zaabsorbowane na elektrodach.
@param t Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
inline void step6_check_boundaries_ions(int t) {
    if ((t % N_SUB) != 0) return;

    int k = 0;
    bool out;
    double v_sqr, energy;
    int energy_index;

    while (k < N_i) {
        out = false;
        // Sprawdzenie absorpcji jonu na elektrodzie zasilanej (x < 0)
        if (x_i[k] < 0) {
            N_i_abs_pow++;
            out          = true;
            v_sqr        = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            energy       = 0.5 * AR_MASS * v_sqr / EV_TO_J;
            energy_index = (int)(energy / DE_IFED);
            if (energy_index < N_IFED) {
                ifed_pow[energy_index]++;
            }
        }
        // Sprawdzenie absorpcji jonu na elektrodzie uziemionej (x > L)
        if (x_i[k] > L) {
            N_i_abs_gnd++;
            out          = true;
            v_sqr        = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            energy       = 0.5 * AR_MASS * v_sqr / EV_TO_J;
            energy_index = (int)(energy / DE_IFED);
            if (energy_index < N_IFED) {
                ifed_gnd[energy_index]++;
            }
        }
        if (out) {
            // Zastąpienie usuniętego jonu ostatnią cząstką z końca tablicy
            x_i[k]  = x_i[N_i-1];
            vx_i[k] = vx_i[N_i-1];
            vy_i[k] = vy_i[N_i-1];
            vz_i[k] = vz_i[N_i-1];
            N_i--;
        } else {
            k++;
        }
    }
}

/*
KROK 7: Przeprowadza losowanie i obsługę zderzeń elektronów z atomami argonu (MCC).
W zależności od flagi kompilacji USE_NULL_COLLISION wykorzystuje metodę zderzeń zerowych
lub klasyczny algorytm bezpośredniego sprawdzania każdej cząstki.
*/
inline void step7_collisions_electrons() {
#ifdef USE_NULL_COLLISION
    // Losowanie liczby kandydatów do zderzenia z rozkładu dwumianowego
    std::binomial_distribution<int> binom_e(N_e, P_star_e);
    int N_coll_star_e = binom_e(MTgen);
    if (N_coll_star_e > N_e) {
        N_coll_star_e = N_e;
    }

    if (N_coll_star_e > 0) {
        std::vector<int> candidates_e;
        random_sample(N_e, N_coll_star_e, candidates_e);

        for (int ki : candidates_e) {
            double v_sqr     = vx_e[ki] * vx_e[ki] + vy_e[ki] * vy_e[ki] + vz_e[ki] * vz_e[ki];
            double velocity  = sqrt(v_sqr);
            double energy    = 0.5 * E_MASS * v_sqr / EV_TO_J;
            int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);

            double real_nu  = sigma_tot_e[energy_index] * velocity;
            double p_accept = real_nu / nu_star_e;
            if (p_accept > 1.0) {
                p_accept = 1.0;
            }

            if (R01(MTgen) < p_accept) {
                collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index);
                N_e_coll++;
            }
        }
    }
#else
    int k, energy_index;
    double v_sqr, velocity, energy, nu, p_coll;

    // Bezpośrednie wyznaczenie prawdopodobieństwa zderzenia P = 1 - exp(-nu * DT_E) dla każdego elektronu
    for (k = 0; k < N_e; k++) {
        v_sqr        = vx_e[k] * vx_e[k] + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
        velocity     = sqrt(v_sqr);
        energy       = 0.5 * E_MASS * v_sqr / EV_TO_J;
        energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
        nu           = sigma_tot_e[energy_index] * velocity;
        p_coll       = 1 - exp(-nu * DT_E);
        if (R01(MTgen) < p_coll) {
            collision_electron(x_e[k], &vx_e[k], &vy_e[k], &vz_e[k], energy_index);
            N_e_coll++;
        }
    }
#endif
}

/*
KROK 8: Przeprowadza losowanie i obsługę zderzeń jonów z atomami argonu (MCC, co N_SUB kroków).
Uwzględnia losowanie prędkości termicznej atomu tła z rozkładu Maxwella-Boltzmanna.
@param t Indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
*/
inline void step8_collision_ions(int t) {
    if ((t % N_SUB) != 0) return;

#ifdef USE_NULL_COLLISION
    // Losowanie liczby kandydatów do zderzenia jonowego z rozkładu dwumianowego
    std::binomial_distribution<int> binom_i(N_i, P_star_i);
    int N_coll_star_i = binom_i(MTgen);
    if (N_coll_star_i > N_i) {
        N_coll_star_i = N_i;
    }

    if (N_coll_star_i > 0) {
        std::vector<int> candidates_i;
        random_sample(N_i, N_coll_star_i, candidates_i);

        double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy;
        int energy_index;
        for (int ki : candidates_i) {
            vx_a         = RMB(MTgen);
            vy_a         = RMB(MTgen);
            vz_a         = RMB(MTgen);
            gx           = vx_i[ki] - vx_a;
            gy           = vy_i[ki] - vy_a;
            gz           = vz_i[ki] - vz_a;
            g_sqr        = gx * gx + gy * gy + gz * gz;
            g            = sqrt(g_sqr);
            energy       = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
            energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);

            double real_nu  = sigma_tot_i[energy_index] * g;
            double p_accept = real_nu / nu_star_i;
            if (p_accept > 1.0) {
                p_accept = 1.0;
            }

            if (R01(MTgen) < p_accept) {
                collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
                N_i_coll++;
            }
        }
    }
#else
    int k, energy_index;
    double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy, nu, p_coll;

    // Bezpośrednie wyznaczenie prawdopodobieństwa zderzenia P = 1 - exp(-nu * DT_I) dla każdego jonu
    for (k = 0; k < N_i; k++) {
        vx_a         = RMB(MTgen);
        vy_a         = RMB(MTgen);
        vz_a         = RMB(MTgen);
        gx           = vx_i[k] - vx_a;
        gy           = vy_i[k] - vy_a;
        gz           = vz_i[k] - vz_a;
        g_sqr        = gx * gx + gy * gy + gz * gz;
        g            = sqrt(g_sqr);
        energy       = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
        energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
        nu           = sigma_tot_i[energy_index] * g;
        p_coll       = 1 - exp(-nu * DT_I);
        if (R01(MTgen) < p_coll) {
            collision_ion(&vx_i[k], &vy_i[k], &vz_i[k], &vx_a, &vy_a, &vz_a, energy_index);
            N_i_coll++;
        }
    }
#endif
}

/*
KROK 9: Akumuluje chwilowe rozkłady wielkości siatkowych (potencjału, pola elektrycznego i gęstości)
do macierzy czasoprzestrzennych XT w trybie pomiarowym.
@param t_index Indeks przedziału czasowego w macierzach czasoprzestrzennych XT (t / N_BIN).
*/
inline void step9_collect_xt_data(int t_index) {
    if (!measurement_mode) return;

    for (int p = 0; p < N_G; p++) {
        pot_xt   [p][t_index] += pot[p];
        efield_xt[p][t_index] += efield[p];
        ne_xt    [p][t_index] += e_density[p];
        ni_xt    [p][t_index] += i_density[p];
    }
}

/*
Wykonuje jeden pełny cykl napięcia RF podzielony na N_T kroków czasowych DT_E.
Realizuje kolejno kroki 1-9 algorytmu PIC/MCC oraz zapisuje liczbę cząstek na koniec cyklu.
*/
inline void do_one_cycle(void) {
    for (int t = 0; t < N_T; t++) {
        // Aktualizacja czasu fizycznego oraz indeksu przedziału czasoprzestrzennego XT
        Time += DT_E;
        int t_index = t / N_BIN;

        step1_compute_electron_density();
        step1_compute_ion_density(t);
        step2_solve_poisson(Time);

        step3_move_electrons(t_index);
        step4_move_ions(t_index, t);

        step5_check_boundaries_electrons();
        step6_check_boundaries_ions(t);

        step7_collisions_electrons();
        step8_collision_ions(t);

        step9_collect_xt_data(t_index);

        if ((t % 1000) == 0) {
            printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", cycle, t, N_e, N_i);
        }
    }
    fprintf(datafile, "%8d  %8d  %8d\n", cycle, N_e, N_i);
}
