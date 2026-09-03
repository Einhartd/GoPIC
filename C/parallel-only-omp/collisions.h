#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>
#include <algorithm>
#include <vector>
#include <omp.h>

/*
Obsługa pojedynczego zderzenia elektronu z neutralnym atomem argonu (MCC).
Zoptymalizowana wersja algebraiczna (eliminacja funkcji trygonometrycznych atan2/acos/sin/cos).
*/
PIC_STEP void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex,
                                 NewParticles& new_e, NewParticles& new_i) {

    double t0, t1, t2, rnd;
    double g, g2, gx, gy, gz, wx, wy, wz;
    double sc, cc, se, ce, st, ct, sp, cp, energy, e_sc, e_ej;
    
    // -------------------------------------------------------------------------
    // 1. Prędkość względna przed zderzeniem oraz prędkość środka masy (COM)
    // -------------------------------------------------------------------------
    gx = (*vxe);
    gy = (*vye);
    gz = (*vze);
    double g_perp_sq = gy * gy + gz * gz;
    double g_sq      = gx * gx + g_perp_sq;
    g  = sqrt(g_sq);
    double g_perp    = sqrt(g_perp_sq);

    wx = F1 * (*vxe);
    wy = F1 * (*vye);
    wz = F1 * (*vze);
    
    // -------------------------------------------------------------------------
    // 2. Kąty Eulera — czysta algebra wektorowa (zamiast atan2, sin, cos)
    // -------------------------------------------------------------------------
    if (g > 0.0) {
        ct = gx / g;
        st = g_perp / g;
    } else {
        ct = 1.0;
        st = 0.0;
    }

    if (g_perp > 0.0) {
        cp = gy / g_perp;
        sp = gz / g_perp;
    } else {
        cp = 1.0;
        sp = 0.0;
    }
    
    // -------------------------------------------------------------------------
    // 3. Wybór typu zderzenia na podstawie skumulowanych przekrojów czynnych
    // -------------------------------------------------------------------------
    t0   =     sigma[E_ELA][eindex];
    t1   = t0 +sigma[E_EXC][eindex];
    t2   = t1 +sigma[E_ION][eindex];
    rnd  = R01(MTgen);
    double r_t2 = rnd * t2;

    double eta = TWO_PI * R01(MTgen);
    se = sin(eta);
    ce = cos(eta);

    if (r_t2 < t0) {                                    // Zderzenie sprężyste (izotropowe)
        cc = 1.0 - 2.0 * R01(MTgen);                    // cos(chi)
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));        // sin(chi)
    } else if (r_t2 < t1) {                             // Wzbudzenie (niesprężyste, izotropowe)
        energy = HALF_E_MASS * g_sq;
        energy = fabs(energy - E_EXC_TH * EV_TO_J);
        g   = sqrt(energy * TWO_OVER_E_MASS);
        cc  = 1.0 - 2.0 * R01(MTgen);                   // cos(chi)
        sc  = sqrt(std::max(0.0, 1.0 - cc * cc));       // sin(chi)
    } else {                                            // Jonizacja (niesprężysta)
        energy = HALF_E_MASS * g_sq;
        energy = fabs(energy - E_ION_TH * EV_TO_J);

        // Energia wybitego elektronu wtórnego (rozkład wg formy różniczkowej Opla)
        e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
        e_sc = fabs(energy - e_ej);

        g    = sqrt(e_sc * TWO_OVER_E_MASS);
        g2   = sqrt(e_ej * TWO_OVER_E_MASS);

        cc   = sqrt(e_sc / energy);                     // cos(chi) dla elektronu rozproszonego
        sc   = sqrt(std::max(0.0, 1.0 - cc * cc));      // sin(chi)

        double cc2 = sqrt(e_ej / energy);               // cos(chi2) dla elektronu wybitego
        double sc2 = sqrt(std::max(0.0, 1.0 - cc2 * cc2)); // sin(chi2)

        // Dla elektronu wybitego kąt azymutalny to eta + PI -> sin/cos zmieniają znak
        double se2 = -se;
        double ce2 = -ce;

        double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
        double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
        double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
        
        // Dodanie nowego elektronu wtórnego oraz jonu Ar+ do lokalnych buforów
        new_e.push(xe, wx + F2 * gx2, wy + F2 * gy2, wz + F2 * gz2);
        new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
    }
    
    // -------------------------------------------------------------------------
    // 4. Rozproszenie elektronu pierwotnego (rotacja wektora prędkości)
    // -------------------------------------------------------------------------
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    (*vxe) = wx + F2 * gx;
    (*vye) = wy + F2 * gy;
    (*vze) = wz + F2 * gz;
}

/*
Obsługa pojedynczego zderzenia jonu Ar+ z neutralnym atomem argonu (MCC).
Zoptymalizowana wersja algebraiczna (eliminacja funkcji trygonometrycznych).
*/
PIC_STEP void collision_ion (double *vx_1, double *vy_1, double *vz_1,
                    double *vx_2, double *vy_2, double *vz_2, int e_index){
    // -------------------------------------------------------------------------
    // 1. Wybór procesu: rozpraszanie izotropowe vs wsteczne (wymiana ładunku)
    // -------------------------------------------------------------------------
    double t1 = sigma[I_ISO][e_index];
    double t2 = t1 + sigma[I_BACK][e_index];
    double rnd = R01(MTgen);

    if (rnd * t2 >= t1) {
        // Wymiana ładunku (Charge Exchange, I_BACK) - ~80% zderzeń jonów:
        // Szybki jon przejmuje elektron od neutralnego atomu argonu bez wymiany pędu jądrowego (chi = PI).
        // Nowa prędkość jonu jest tożsama z prędkością termiczną atomu tła (vx_2, vy_2, vz_2).
        *vx_1 = *vx_2;
        *vy_1 = *vy_2;
        *vz_1 = *vz_2;
        return;
    }

    // -------------------------------------------------------------------------
    // 2. Rozpraszanie sprężyste izotropowe (I_ISO) - ~20% zderzeń jonów
    // -------------------------------------------------------------------------
    double gx = (*vx_1) - (*vx_2);
    double gy = (*vy_1) - (*vy_2);
    double gz = (*vz_1) - (*vz_2);
    double g_perp_sq = gy * gy + gz * gz;
    double g_sq      = gx * gx + g_perp_sq;
    double g         = sqrt(g_sq);
    double g_perp    = sqrt(g_perp_sq);

    double wx = 0.5 * ((*vx_1) + (*vx_2));
    double wy = 0.5 * ((*vy_1) + (*vy_2));
    double wz = 0.5 * ((*vz_1) + (*vz_2));
    
    double ct = (g > 0.0) ? (gx / g) : 1.0;
    double st = (g > 0.0) ? (g_perp / g) : 0.0;
    double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
    double sp = (g_perp > 0.0) ? (gz / g_perp) : 0.0;

    double cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
    double sc = sqrt(std::max(0.0, 1.0 - cc * cc));  // sin(chi)

    double eta = TWO_PI * R01(MTgen);
    double se = sin(eta);
    double ce = cos(eta);
    
    // Transformacja wektora prędkości względnej
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    (*vx_1) = wx + 0.5 * gx;
    (*vy_1) = wy + 0.5 * gy;
    (*vz_1) = wz + 0.5 * gz;
}
