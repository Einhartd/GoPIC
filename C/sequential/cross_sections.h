#pragma once
#include "state.h"
#include <cmath>

/*
Oblicza i tabelaryzuje mikroskopowe przekroje czynne zderzeń elektronów z neutralnym argonem (e- + Ar).
Wykorzystuje analityczną parametryzację A.V. Phelps, Z.Lj. Petrovic, Plasma Sources Sci. Technol. 8, R21 (1999).
Uwzględnia zderzenia sprężyste (E_ELA), wzbudzenie (E_EXC, próg 11.5 eV) oraz jonizację (E_ION, próg 15.8 eV).
*/
inline void set_electron_cross_sections_ar(void) {
    int i;
    double en, qmel, qexc, qion;

    printf(">> eduPIC: Setting e- / Ar cross sections\n");
    for (i = 0; i < CS_RANGES; i++) {
        // Energia kinetyczna elektronu odpowiadająca indeksowi tabeli [eV]
        if (i == 0) {
            en = DE_CS;
        } else {
            en = DE_CS * i;
        }

        qmel = fabs(6.0 / pow(1.0 + (en / 0.1) + pow(en / 0.6, 2.0), 3.3)
                    - 1.1 * pow(en, 1.4) / (1.0 + pow(en / 15.0, 1.2)) / sqrt(1.0 + pow(en / 5.5, 2.5) + pow(en / 60.0, 4.1)))
               + 0.05 / pow(1.0 + en / 10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en / 12.0, 6.0));

        if (en > E_EXC_TH) {
            qexc = 0.034 * pow(en - 11.5, 1.1) * (1.0 + pow(en / 15.0, 2.8)) / (1.0 + pow(en / 23.0, 5.5))
                   + 0.023 * (en - 11.5) / pow(1.0 + en / 80.0, 1.9);
        } else {
            qexc = 0;
        }

        if (en > E_ION_TH) {
            qion = 970.0 * (en - 15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en - 15.8, 2.0) * exp(-en / 9);
        } else {
            qion = 0;
        }

        // Zapis przekrojów czynnych przeliczonych na jednostki układu SI [m^2]
        sigma[E_ELA][i] = qmel * 1.0e-20;
        sigma[E_EXC][i] = qexc * 1.0e-20;
        sigma[E_ION][i] = qion * 1.0e-20;
    }
}

/*
Oblicza i tabelaryzuje mikroskopowe przekroje czynne zderzeń jonów argonu z atomami tła (Ar+ + Ar).
Wykorzystuje analityczną parametryzację A.V. Phelps, J. Appl. Phys. 76, 747 (1994).
Uwzględnia sprężyste rozpraszanie izotropowe (I_ISO) oraz rozpraszanie wsteczne / wymianę ładunku (I_BACK).
*/
inline void set_ion_cross_sections_ar(void) {
    int i;
    double e_com, e_lab, qmom, qback, qiso;

    printf(">> eduPIC: Setting Ar+ / Ar cross sections\n");
    for (i = 0; i < CS_RANGES; i++) {
        // Energia zderzenia w układzie środka masy (COM) [eV]
        if (i == 0) {
            e_com = DE_CS;
        } else {
            e_com = DE_CS * i;
        }

        // Energia jonu w układzie laboratoryjnym [eV]
        e_lab = 2.0 * e_com;
        qmom  = 1.15e-18 * pow(e_lab, -0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
        qiso  = 2e-19 * pow(e_lab, -0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
        qback = (qmom - qiso) / 2.0;

        // Zapis przekrojów czynnych dla części izotropowej oraz wstecznej [m^2]
        sigma[I_ISO][i]  = qiso;
        sigma[I_BACK][i] = qback;
    }
}

/*
Wyznacza całkowite makroskopowe przekroje czynne dla elektronów (sigma_tot_e) oraz jonów (sigma_tot_i).
Mnoży sumę przekrojów mikroskopowych poszczególnych procesów przez gęstość liczbową gazu neutralnego GAS_DENSITY.
*/
inline void calc_total_cross_sections(void) {
    for (int i = 0; i < CS_RANGES; i++) {
        sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
        sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
    }
}

/*
Zapisuje stabelaryzowane przekroje czynne wszystkich procesów do pliku tekstowego cross_sections.dat
w celu weryfikacji poprawności parametryzacji.
*/
inline void test_cross_sections(void) {
    FILE *f = fopen("cross_sections.dat", "w");
    for (int i = 0; i < CS_RANGES; i++) {
        fprintf(f, "%12.4f ", i * DE_CS);
        for (int j = 0; j < N_CS; j++) {
            fprintf(f, "%14e ", sigma[j][i]);
        }
        fprintf(f, "\n");
    }
    fclose(f);
}

/*
Wyznacza maksymalną częstość zderzeń elektronów nu*_e = max(v * sigma_tot_e) w całym zakresie energii.
Służy do weryfikacji warunku dokładności MCC oraz parametryzacji metody Null-Collision.
@return Maksymalna częstość zderzeń elektronów [1/s].
*/
inline double max_electron_coll_freq(void) {
    double nu_max = 0.0;
    for (int i = 0; i < CS_RANGES; i++) {
        double e  = i * DE_CS;
        double v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
        double nu = v * sigma_tot_e[i];
        if (nu > nu_max) {
            nu_max = nu;
        }
    }
    return nu_max;
}

/*
Wyznacza maksymalną częstość zderzeń jonów nu*_i = max(g * sigma_tot_i) w całym zakresie energii.
Służy do weryfikacji warunku dokładności MCC oraz parametryzacji metody Null-Collision.
@return Maksymalna częstość zderzeń jonów [1/s].
*/
inline double max_ion_coll_freq(void) {
    double nu_max = 0.0;
    for (int i = 0; i < CS_RANGES; i++) {
        double e  = i * DE_CS;
        double g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
        double nu = g * sigma_tot_i[i];
        if (nu > nu_max) {
            nu_max = nu;
        }
    }
    return nu_max;
}
