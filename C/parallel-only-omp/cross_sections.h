#pragma once
#include "state.h"
#include <cmath>


/*
Obliczanie mikroskopowych przekrojów czynnych zderzeń e- / Ar.
Formuły analityczne na podstawie pracy:
A.V. Phelps, Z.Lj. Petrovic, Plasma Sources Sci. Technol. 8, R21 (1999).
Procesy:
 - E_ELA: zderzenia sprężyste (ze zmodyfikowanym przekrojem pędowym)
 - E_EXC: wzbudzenie poziomu argonu (próg energetyczny 11.5 eV)
 - E_ION: jonizacja uderzeniowa (próg energetyczny 15.8 eV)
Wszystkie przekroje są przeliczane na jednostki [m^2] (* 1e-20) i zapisywane w tablicy sigma.
*/
inline void set_electron_cross_sections_ar(void){
    int    i;
    double en,qmel,qexc,qion;
    
    printf(">> eduPIC: Setting e- / Ar cross sections\n");
    for(i=0; i<CS_RANGES; i++){
        if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
        qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
                    - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
        + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
        if (en > E_EXC_TH)
            qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
            + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
        else
            qexc = 0;
        if (en > E_ION_TH)
            qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
        else
            qion = 0;
        sigma[E_ELA][i] = qmel * 1.0e-20;       // Przekrój czynny na zderzenia sprężyste e- / Ar [m^2]
        sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
        sigma[E_ION][i] = qion * 1.0e-20;       // Przekrój czynny na jonizację e- / Ar [m^2]
    }
}

/*
Obliczanie mikroskopowych przekrojów czynnych zderzeń Ar+ / Ar.
Formuły analityczne na podstawie pracy:
A.V. Phelps, J. Phys. Chem. Ref. Data 23, 847 (1994).
Procesy:
 - I_ISO: sprężyste rozpraszanie izotropowe
 - I_BACK: sprężyste rozpraszanie wsteczne (rezonansowa wymiana ładunku)
Wszystkie przekroje są przeliczane na jednostki [m^2] i zapisywane w tablicy sigma.
*/
inline void set_ion_cross_sections_ar(void){
    int    i;
    double e_com,e_lab,qmom,qback,qiso;
    
    printf(">> eduPIC: Setting Ar+ / Ar cross sections\n");
    for(i=0; i<CS_RANGES; i++){
        if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // Energia jonu w układzie środka masy [eV]
        e_lab = 2.0 * e_com;                                               // Energia jonu w układzie laboratoryjnym [eV]
        qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
        qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
        qback = (qmom-qiso) / 2.0;
        sigma[I_ISO][i]  = qiso;             // Przekrój czynny na izotropową część rozpraszania sprężystego [m^2]
        sigma[I_BACK][i] = qback;            // Przekrój czynny na rozpraszanie wsteczne (wymianę ładunku) [m^2]
    }
}

/*
Obliczanie całkowitych makroskopowych przekrojów czynnych dla elektronów i jonów.
Przelicza sumę mikroskopowych przekrojów procesów na wielkości makroskopowe:
sigma_tot = sum(sigma_procesy) * GAS_DENSITY [1/m].
*/
inline void calc_total_cross_sections(void){
    int i;
    
    for(i=0; i<CS_RANGES; i++){
        // Całkowity makroskopowy przekrój dla elektronów
        sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
        // Całkowity makroskopowy przekrój dla jonów
        sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
    }
}

/*
Funkcja pomocnicza: Eksport tablic przekrojów czynnych do pliku tekstowego cross_sections.dat.
Zapisuje kolumny: Energia [eV], sigma_E_ELA, sigma_E_EXC, sigma_E_ION, sigma_I_ISO, sigma_I_BACK.
*/
inline void test_cross_sections(void){
    FILE  * f;
    int   i,j;
    
    // Zapis do pliku tekstowego: cross_sections.dat
    f = fopen("cross_sections.dat","w");
    for(i=0; i<CS_RANGES; i++){
        fprintf(f,"%12.4f ",i*DE_CS);
        for(j=0; j<N_CS; j++) fprintf(f,"%14e ",sigma[j][i]);
        fprintf(f,"\n");
    }
    fclose(f);
}

/*
Wyznaczenie maksymalnej częstości zderzeń dla elektronów nu*_e.
Oblicza iloczyn prędkości i całkowitego makroskopowego przekroju czynnego:
nu(E) = v(E) * sigma_tot_e(E).
Używane do weryfikacji stabilności oraz metody Null-Collision.
@return Maksymalna częstość zderzeń elektronów [1/s].
*/
inline double max_electron_coll_freq (void){
    int i;
    double e,v,nu,nu_max;
    nu_max = 0;
    for(i=0; i<CS_RANGES; i++){
        e  = i * DE_CS;
        v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
        nu = v * sigma_tot_e[i];
        if (nu > nu_max) {nu_max = nu;}
    }
    return nu_max;
}

/*
Wyznaczenie maksymalnej częstości zderzeń dla jonów nu*_i.
Oblicza iloczyn prędkości względnej i makroskopowego przekroju czynnego:
nu(E) = g(E) * sigma_tot_i(E) (z masą zredukowaną MU_ARAR).
Używane do weryfikacji stabilności oraz metody Null-Collision.
@return Maksymalna częstość zderzeń jonów [1/s].
*/
inline double max_ion_coll_freq (void){
    int i;
    double e,g,nu,nu_max;
    nu_max = 0;
    for(i=0; i<CS_RANGES; i++){
        e  = i * DE_CS;
        g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
        nu = g * sigma_tot_i[i];
        if (nu > nu_max) nu_max = nu;
    }
    return nu_max;
}
