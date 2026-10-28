#pragma once
#include "state.h"
#include <cmath>

/*
Oblicza i tabelaryzuje mikroskopowe przekroje czynne zderzeń elektronów z atomami argonu (e- + Ar).
Wykorzystuje dopasowania analityczne z pracy:
A.V. Phelps, Z.Lj. Petrovic, Plasma Sources Sci. Technol. 8, R21 (1999).
Wypełnia tablice sigma[E_ELA] (zderzenia sprężyste), sigma[E_EXC] (wzbudzenie, próg 11.5 eV)
oraz sigma[E_ION] (jonizacja uderzeniowa, próg 15.8 eV) w jednostkach [m^2].
*/
inline void set_electron_cross_sections_ar(void) {
    int    i;
    double en, qmel, qexc, qion;

    printf(">> eduPIC: Setting e- / Ar cross sections\n");
    for (i = 0; i < CS_RANGES; i++) {
        // Energia kinetyczna elektronu dla danego przedziału tabeli [eV]
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
        // Zapis przekrojów czynnych przeliczonych na jednostki SI [m^2]
        sigma[E_ELA][i] = qmel * 1.0e-20;
        sigma[E_EXC][i] = qexc * 1.0e-20;
        sigma[E_ION][i] = qion * 1.0e-20;
    }
}

/*
Oblicza i tabelaryzuje mikroskopowe przekroje czynne zderzeń jonów argonu z atomami tła (Ar+ + Ar).
Wykorzystuje dopasowania analityczne z pracy:
A.V. Phelps, J. Phys. Chem. Ref. Data 23, 847 (1994).
Wypełnia tablice sigma[I_ISO] (rozpraszanie izotropowe) oraz sigma[I_BACK] (rozpraszanie wsteczne /
rezonansowa wymiana ładunku) w jednostkach [m^2].
*/
inline void set_ion_cross_sections_ar(void) {
    int    i;
    double e_com, e_lab, qmom, qback, qiso;

    printf(">> eduPIC: Setting Ar+ / Ar cross sections\n");
    for (i = 0; i < CS_RANGES; i++) {
        // Energia zderzenia w układzie środka masy [eV] oraz w układzie laboratoryjnym [eV]
        if (i == 0) {
            e_com = DE_CS;
        } else {
            e_com = DE_CS * i;
        }
        e_lab = 2.0 * e_com;
        qmom  = 1.15e-18 * pow(e_lab, -0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
        qiso  = 2e-19 * pow(e_lab, -0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
        qback = (qmom - qiso) / 2.0;
        // Zapis przekrojów czynnych dla rozpraszania izotropowego oraz wstecznego [m^2]
        sigma[I_ISO][i]  = qiso;
        sigma[I_BACK][i] = qback;
    }
}

/*
Oblicza całkowite makroskopowe przekroje czynne dla elektronów (sigma_tot_e) oraz jonów (sigma_tot_i).
Mnoży sumę mikroskopowych przekrojów czynnych dla danej cząstki przez gęstość liczbową gazu tła GAS_DENSITY,
dając wynik w jednostkach odwrotności drogi swobodnej [1/m].
*/
inline void calc_total_cross_sections(void) {
    int i;

    for (i = 0; i < CS_RANGES; i++) {
        // Całkowity makroskopowy przekrój czynny dla elektronów [1/m]
        sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
        // Całkowity makroskopowy przekrój czynny dla jonów [1/m]
        sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
    }
}

/*
Zapisuje wszystkie stabelaryzowane przekroje czynne do pliku tekstowego cross_sections.dat w celach kontrolnych.
Kolejne kolumny pliku: Energia [eV], sigma_E_ELA, sigma_E_EXC, sigma_E_ION, sigma_I_ISO, sigma_I_BACK [m^2].
*/
inline void test_cross_sections(void) {
    FILE *f;
    int  i, j;

    f = fopen("cross_sections.dat", "w");
    for (i = 0; i < CS_RANGES; i++) {
        fprintf(f, "%12.4f ", i * DE_CS);
        for (j = 0; j < N_CS; j++) {
            fprintf(f, "%14e ", sigma[j][i]);
        }
        fprintf(f, "\n");
    }
    fclose(f);
}

/*
Wyznacza maksymalną częstość zderzeń elektronów z atomami gazu tła w całym rozważanym zakresie energii.
Oblicza maksimum iloczynu prędkości elektronu v(E) i makroskopowego przekroju czynnego sigma_tot_e(E).
Wartość ta jest używana w metodzie Null-Collision oraz podczas weryfikacji warunków stabilności.
@return Maksymalna częstość zderzeń elektronów nu*_e [1/s].
*/
inline double max_electron_coll_freq(void) {
    int    i;
    double e, v, nu, nu_max;

    nu_max = 0;
    for (i = 0; i < CS_RANGES; i++) {
        e  = i * DE_CS;
        v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
        nu = v * sigma_tot_e[i];
        if (nu > nu_max) {
            nu_max = nu;
        }
    }
    return nu_max;
}

/*
Wyznacza maksymalną częstość zderzeń jonów z atomami gazu tła w całym rozważanym zakresie energii.
Oblicza maksimum iloczynu prędkości względnej g(E) (dla masy zredukowanej MU_ARAR) i makroskopowego
przekroju czynnego sigma_tot_i(E). Wartość używana w metodzie Null-Collision i teście stabilności.
@return Maksymalna częstość zderzeń jonów nu*_i [1/s].
*/
inline double max_ion_coll_freq(void) {
    int    i;
    double e, g, nu, nu_max;

    nu_max = 0;
    for (i = 0; i < CS_RANGES; i++) {
        e  = i * DE_CS;
        g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
        nu = g * sigma_tot_i[i];
        if (nu > nu_max) {
            nu_max = nu;
        }
    }
    return nu_max;
}
