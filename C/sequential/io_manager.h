#pragma once
#include "state.h"
#include "cross_sections.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>

/*
Zapisuje bieżący stan cząstek oraz czas symulacji do binarnego pliku kontrolnego picdata.bin.
Umożliwia wznowienie obliczeń w kolejnych uruchomieniach programu.
*/
inline void save_particle_data() {
    double d;
    FILE *f = fopen("picdata.bin", "wb");

    fwrite(&Time, sizeof(double), 1, f);
    d = (double)(cycles_done);
    fwrite(&d, sizeof(double), 1, f);

    // Zapis współrzędnych położenia i prędkości elektronów
    d = (double)(N_e);
    fwrite(&d, sizeof(double), 1, f);
    fwrite(x_e,  sizeof(double), N_e, f);
    fwrite(vx_e, sizeof(double), N_e, f);
    fwrite(vy_e, sizeof(double), N_e, f);
    fwrite(vz_e, sizeof(double), N_e, f);

    // Zapis współrzędnych położenia i prędkości jonów
    d = (double)(N_i);
    fwrite(&d, sizeof(double), 1, f);
    fwrite(x_i,  sizeof(double), N_i, f);
    fwrite(vx_i, sizeof(double), N_i, f);
    fwrite(vy_i, sizeof(double), N_i, f);
    fwrite(vz_i, sizeof(double), N_i, f);

    fclose(f);
    printf(">> eduPIC: data saved : %d electrons %d ions, %d cycles completed, time is %e [s]\n", N_e, N_i, cycles_done, Time);
}

/*
Wczytuje stan cząstek oraz czas symulacji z binarnego pliku kontrolnego picdata.bin.
W przypadku braku pliku kończy działanie programu komunikatem o konieczności inicjalizacji.
*/
inline void load_particle_data() {
    double d;
    FILE *f = fopen("picdata.bin", "rb");
    if (f == NULL) {
        printf(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n");
        exit(0);
    }

    size_t r = 0;
    r += fread(&Time, sizeof(double), 1, f);
    r += fread(&d, sizeof(double), 1, f);
    cycles_done = int(d);

    // Odczyt współrzędnych położenia i prędkości elektronów
    r += fread(&d, sizeof(double), 1, f);
    N_e = int(d);
    r += fread(x_e,  sizeof(double), N_e, f);
    r += fread(vx_e, sizeof(double), N_e, f);
    r += fread(vy_e, sizeof(double), N_e, f);
    r += fread(vz_e, sizeof(double), N_e, f);

    // Odczyt współrzędnych położenia i prędkości jonów
    r += fread(&d, sizeof(double), 1, f);
    N_i = int(d);
    r += fread(x_i,  sizeof(double), N_i, f);
    r += fread(vx_i, sizeof(double), N_i, f);
    r += fread(vy_i, sizeof(double), N_i, f);
    r += fread(vz_i, sizeof(double), N_i, f);
    (void)r;

    fclose(f);
    printf(">> eduPIC: data loaded : %d electrons %d ions, %d cycles completed before, time is %e [s]\n", N_e, N_i, cycles_done, Time);
}

/*
Zapisuje uśrednione w czasie profile przestrzenne gęstości elektronów i jonów do pliku density.dat.
Kolumny wyjściowe: położenie x [m], gęstość elektronów [m^-3], gęstość jonów [m^-3].
*/
inline void save_density(void) {
    FILE *f  = fopen("density.dat", "w");
    double c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
    for (int m = 0; m < N_G; m++) {
        fprintf(f, "%8.5f  %12e  %12e\n", m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
    }
    fclose(f);
}

/*
Normalizuje i zapisuje funkcję rozkładu prawdopodobieństwa energii elektronów (EEPF) do pliku eepf.dat.
Kolumny wyjściowe: energia kinetyczna E [eV], wartość rozkładu f_EEPF(E) [eV^-3/2].
*/
inline void save_eepf(void) {
    double h = 0.0;
    for (int i = 0; i < N_EEPF; i++) {
        h += eepf[i];
    }
    h *= DE_EEPF;

    FILE *f = fopen("eepf.dat", "w");
    for (int i = 0; i < N_EEPF; i++) {
        double energy = (i + 0.5) * DE_EEPF;
        fprintf(f, "%e  %e\n", energy, eepf[i] / h / sqrt(energy));
    }
    fclose(f);
}

/*
Normalizuje i zapisuje rozkłady energetyczne strumienia jonów na elektrodach (IFED) do pliku ifed.dat
oraz wyznacza średnią energię jonów uderzających w elektrodę zasilaną i uziemioną.
*/
inline void save_ifed(void) {
    double h_pow = 0.0;
    double h_gnd = 0.0;
    for (int i = 0; i < N_IFED; i++) {
        h_pow += ifed_pow[i];
        h_gnd += ifed_gnd[i];
    }
    h_pow *= DE_IFED;
    h_gnd *= DE_IFED;
    mean_i_energy_pow = 0.0;
    mean_i_energy_gnd = 0.0;

    FILE *f = fopen("ifed.dat", "w");
    for (int i = 0; i < N_IFED; i++) {
        double energy = (i + 0.5) * DE_IFED;
        fprintf(f, "%6.2f %10.6f %10.6f\n", energy, (double)(ifed_pow[i]) / h_pow, (double)(ifed_gnd[i]) / h_gnd);
        mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
        mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
    }
    fclose(f);
}

/*
Zapisuje pojedynczą dwuwymiarową macierz rozkładu czasoprzestrzennego XT (N_G x N_XT) do pliku tekstowego.
@param distr Macierz rozkładu czasoprzestrzennego XT.
@param fname Ścieżka do pliku wyjściowego.
*/
inline void save_xt_1(xt_distr distr, const char *fname) {
    FILE *f = fopen(fname, "w");
    for (int i = 0; i < N_G; i++) {
        for (int j = 0; j < N_XT; j++) {
            fprintf(f, "%e  ", distr[i][j]);
        }
        fprintf(f, "\n");
    }
    fclose(f);
}

/*
Normalizuje wszystkie zgromadzone rozkłady czasoprzestrzenne XT oraz wyznacza wielkości pochodne:
gęstości prądów (je_xt, ji_xt) oraz gęstości mocy pochłanianej przez elektrony i jony (powere_xt, poweri_xt).
*/
inline void norm_all_xt(void) {
    // Współczynniki normalizacyjne dla uśredniania po cyklach i podkrokach czasowych
    double f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
    double f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));

    for (int i = 0; i < N_G; i++) {
        for (int j = 0; j < N_XT; j++) {
            pot_xt[i][j]    *= f1;
            efield_xt[i][j] *= f1;
            ne_xt[i][j]     *= f1;
            ni_xt[i][j]     *= f1;
            if (counter_e_xt[i][j] > 0) {
                ue_xt[i][j]         = ue_xt[i][j] / counter_e_xt[i][j];
                je_xt[i][j]         = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
                meanee_xt[i][j]     = meanee_xt[i][j] / counter_e_xt[i][j];
                ioniz_rate_xt[i][j] *= f2;
            } else {
                ue_xt[i][j]         = 0.0;
                je_xt[i][j]         = 0.0;
                meanee_xt[i][j]     = 0.0;
                ioniz_rate_xt[i][j] = 0.0;
            }
            if (counter_i_xt[i][j] > 0) {
                ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
                ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
                meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
            } else {
                ui_xt[i][j]     = 0.0;
                ji_xt[i][j]     = 0.0;
                meanei_xt[i][j] = 0.0;
            }
            powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
            poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j];
        }
    }
}

/*
Zapisuje komplet 11 macierzy rozkładów czasoprzestrzennych XT do odpowiednich plików .dat.
*/
inline void save_all_xt(void) {
    save_xt_1(pot_xt,        "pot_xt.dat");
    save_xt_1(efield_xt,     "efield_xt.dat");
    save_xt_1(ne_xt,         "ne_xt.dat");
    save_xt_1(ni_xt,         "ni_xt.dat");
    save_xt_1(je_xt,         "je_xt.dat");
    save_xt_1(ji_xt,         "ji_xt.dat");
    save_xt_1(powere_xt,     "powere_xt.dat");
    save_xt_1(poweri_xt,     "poweri_xt.dat");
    save_xt_1(meanee_xt,     "meanee_xt.dat");
    save_xt_1(meanei_xt,     "meanei_xt.dat");
    save_xt_1(ioniz_rate_xt, "ioniz_xt.dat");
}

/*
Weryfikuje warunki stabilności i dokładności numerycznej symulacji PIC/MCC, zapisuje pliki diagnostyczne
oraz generuje podsumowujący raport fizyczny w pliku info.txt.
Sprawdzane kryteria:
 1. omega_pe * DT_E < 0.20 (rozdzielczość czasowa drgań plazmowych).
 2. DX / lambda_D < 1.00 (rozdzielczość przestrzenna długości Debye'a).
 3. nu*_e * DT_E < 0.05 (dokładność całkowania zderzeń elektronów).
 4. nu*_i * DT_I < 0.05 (dokładność całkowania zderzeń jonów).
 5. Kryterium Couranta-Friedrichsa-Lewy'ego (CFL) dla elektronów.
*/
inline void check_and_save_info(void) {
    FILE   *f;
    double plas_freq, meane, kT, debye_length, density, ecoll_freq, icoll_freq, sim_time, e_max, v_max, power_e, power_i, c;
    int    i, j;
    bool   conditions_OK;

    // Wyznaczenie parametrów plazmy w centrum wyładowania (x = L / 2)
    density      = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);
    plas_freq    = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);
    meane        = mean_energy_accu_center / (double)(mean_energy_counter_center);
    kT           = 2.0 * meane * EV_TO_J / 3.0;
    sim_time     = (double)(no_of_cycles) / FREQUENCY;
    ecoll_freq   = (double)(N_e_coll) / sim_time / (double)(N_e);
    icoll_freq   = (double)(N_i_coll) / sim_time / (double)(N_i);
    debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;

    f = fopen("info.txt", "w");
    fprintf(f, "########################## eduPIC simulation report ############################\n");
    fprintf(f, "Simulation parameters:\n");
    fprintf(f, "Gap distance                          = %12.3e [m]\n",  L);
    fprintf(f, "# of grid divisions                   = %12d\n",      N_G);
    fprintf(f, "Frequency                             = %12.3e [Hz]\n", FREQUENCY);
    fprintf(f, "# of time steps / period              = %12d\n",      N_T);
    fprintf(f, "# of electron / ion time steps        = %12d\n",      N_SUB);
    fprintf(f, "Voltage amplitude                     = %12.3e [V]\n",  VOLTAGE);
    fprintf(f, "Pressure (Ar)                         = %12.3e [Pa]\n", PRESSURE);
    fprintf(f, "Temperature                           = %12.3e [K]\n",  TEMPERATURE);
    fprintf(f, "Superparticle weight                  = %12.3e\n",      WEIGHT);
    fprintf(f, "# of simulation cycles in this run    = %12d\n",      no_of_cycles);
    fprintf(f, "--------------------------------------------------------------------------------\n");
    fprintf(f, "Plasma characteristics:\n");
    fprintf(f, "Electron density @ center             = %12.3e [m^{-3}]\n", density);
    fprintf(f, "Plasma frequency @ center             = %12.3e [rad/s]\n",  plas_freq);
    fprintf(f, "Debye length @ center                 = %12.3e [m]\n",      debye_length);
    fprintf(f, "Electron collision frequency          = %12.3e [1/s]\n",    ecoll_freq);
    fprintf(f, "Ion collision frequency               = %12.3e [1/s]\n",    icoll_freq);
    fprintf(f, "--------------------------------------------------------------------------------\n");
    fprintf(f, "Stability and accuracy conditions:\n");
    conditions_OK = true;
    c = plas_freq * DT_E;
    fprintf(f, "Plasma frequency @ center * DT_E      = %12.3f (OK if less than 0.20)\n", c);
    if (c > 0.2) { conditions_OK = false; }
    c = DX / debye_length;
    fprintf(f, "DX / Debye length @ center            = %12.3f (OK if less than 1.00)\n", c);
    if (c > 1.0) { conditions_OK = false; }
    c = max_electron_coll_freq() * DT_E;
    fprintf(f, "Max. electron coll. frequency * DT_E  = %12.3f (OK if less than 0.05)\n", c);
    if (c > 0.05) { conditions_OK = false; }
    c = max_ion_coll_freq() * DT_I;
    fprintf(f, "Max. ion coll. frequency * DT_I       = %12.3f (OK if less than 0.05)\n", c);
    if (c > 0.05) { conditions_OK = false; }
    if (!conditions_OK) {
        fprintf(f, "--------------------------------------------------------------------------------\n");
        fprintf(f, "** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **\n");
        fprintf(f, "--------------------------------------------------------------------------------\n");
        fclose(f);
        printf(">> eduPIC: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!\n");
        printf(">> eduPIC: for details see 'info.txt' and refine simulation settings!\n");
    } else {
        // Maksymalna energia elektronu spełniająca warunek Couranta-Friedrichsa-Lewy'ego (v_max = DX / DT_E)
        v_max = DX / DT_E;
        e_max = 0.5 * E_MASS * v_max * v_max / EV_TO_J;
        fprintf(f, "Max e- energy for CFL condition       = %12.3f [eV]\n", e_max);
        fprintf(f, "Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!\n");
        fprintf(f, "--------------------------------------------------------------------------------\n");

        // Zapis i normalizacja wszystkich plików diagnostycznych
        printf(">> eduPIC: saving diagnostics data\n");
        save_density();
        save_eepf();
        save_ifed();
        norm_all_xt();
        save_all_xt();
        fprintf(f, "Particle characteristics at the electrodes:\n");
        fprintf(f, "Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
        fprintf(f, "Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
        fprintf(f, "Mean ion energy at powered electrode  = %12.3e [eV]\n", mean_i_energy_pow);
        fprintf(f, "Mean ion energy at grounded electrode = %12.3e [eV]\n", mean_i_energy_gnd);
        fprintf(f, "Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
        fprintf(f, "Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
        fprintf(f, "--------------------------------------------------------------------------------\n");

        // Obliczenie średniej gęstości mocy absorbowanej przez elektrony i jony <j * E>
        power_e = 0.0;
        power_i = 0.0;
        for (i = 0; i < N_G; i++) {
            for (j = 0; j < N_XT; j++) {
                power_e += powere_xt[i][j];
                power_i += poweri_xt[i][j];
            }
        }
        power_e /= (double)(N_XT * N_G);
        power_i /= (double)(N_XT * N_G);
        fprintf(f, "Absorbed power calculated as <j*E>:\n");
        fprintf(f, "Electron power density (average)      = %12.3e [W m^{-3}]\n", power_e);
        fprintf(f, "Ion power density (average)           = %12.3e [W m^{-3}]\n", power_i);
        fprintf(f, "Total power density(average)          = %12.3e [W m^{-3}]\n", power_e + power_i);
        fprintf(f, "--------------------------------------------------------------------------------\n");
        fclose(f);
    }
}
