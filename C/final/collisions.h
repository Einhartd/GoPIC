#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>
#include <algorithm>
#include <vector>
#include <omp.h>

/*
Realizuje pojedyncze zderzenie elektronu z neutralnym atomem argonu (MCC) w przybliżeniu zimnego gazu.
Wykorzystuje zoptymalizowaną parametryzację algebraiczną (bez wywołań funkcji trygonometrycznych
atan2 i acos) oraz zapisuje cząstki wtórne z jonizacji do prywatnych buforów wątku OpenMP.
Etapy:
 1. Obliczenie prędkości względnej g, składowej prostopadłej g_perp oraz prędkości środka masy w.
 2. Algebraiczne wyznaczenie sinusów i cosinusów kątów orientacji (ct, st, cp, sp) z ułamków składowych prędkości.
 3. Losowanie rodzaju procesu (rozpraszanie sprężyste, wzbudzenie, jonizacja) na podstawie przekrojów czynnych.
 4. W przypadku jonizacji: utworzenie nowego elektronu wtórnego oraz jonu Ar+ w lokalnych buforach wątku.
 5. Rotacja wektora prędkości elektronu rozproszonego i transformacja do układu laboratoryjnego.
@param xe     Pozycja 1D zderzającego się elektronu [m].
@param vxe    Wskaźnik do składowej prędkości elektronu wzdłuż osi x [m/s].
@param vye    Wskaźnik do składowej prędkości elektronu wzdłuż osi y [m/s].
@param vze    Wskaźnik do składowej prędkości elektronu wzdłuż osi z [m/s].
@param eindex Indeks energii kinetycznej w tablicach przekrojów czynnych.
@param new_e  Referencja do prywatnego bufora wątku na nowo utworzone elektrony wtórne.
@param new_i  Referencja do prywatnego bufora wątku na nowo utworzone jony Ar+.
*/
PIC_STEP void collision_electron(double xe, double *vxe, double *vye, double *vze, int eindex,
                                 NewParticles& new_e, NewParticles& new_i) {
    double t0, t1, t2, rnd;
    double g, g2, gx, gy, gz, wx, wy, wz;
    double sc, cc, se, ce, st, ct, sp, cp, energy, e_sc, e_ej;

    // 1. Obliczenie prędkości względnej przed zderzeniem oraz prędkości środka masy (COM)
    gx               = (*vxe);
    gy               = (*vye);
    gz               = (*vze);
    double g_perp_sq = gy * gy + gz * gz;
    double g_sq      = gx * gx + g_perp_sq;
    g                = sqrt(g_sq);
    double g_perp    = sqrt(g_perp_sq);

    wx = F1 * (*vxe);
    wy = F1 * (*vye);
    wz = F1 * (*vze);

    // 2. Algebraiczne wyznaczenie funkcji trygonometrycznych kątów Eulera (zamiast atan2, sin, cos)
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

    // 3. Wybór procesu zderzeniowego na podstawie skumulowanych przekrojów czynnych
    t0          = sigma[E_ELA][eindex];
    t1          = t0 + sigma[E_EXC][eindex];
    t2          = t1 + sigma[E_ION][eindex];
    rnd         = R01(MTgen);
    double r_t2 = rnd * t2;

    double eta = TWO_PI * R01(MTgen);
    se         = sin(eta);
    ce         = cos(eta);

    if (r_t2 < t0) {
        // Zderzenie sprężyste: bezpośrednie losowanie cos(chi) oraz algebraiczne wyznaczenie sin(chi)
        cc = 1.0 - 2.0 * R01(MTgen);
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));
    } else if (r_t2 < t1) {
        // Wzbudzenie elektronowe: pomniejszenie energii o próg E_EXC_TH i izotropowe rozproszenie
        energy = HALF_E_MASS * g_sq;
        energy = fabs(energy - E_EXC_TH * EV_TO_J);
        g      = sqrt(energy * TWO_OVER_E_MASS);
        cc     = 1.0 - 2.0 * R01(MTgen);
        sc     = sqrt(std::max(0.0, 1.0 - cc * cc));
    } else {
        // Jonizacja uderzeniowa: pomniejszenie energii o próg E_ION_TH i podział energii wg rozkładu Opla
        energy = HALF_E_MASS * g_sq;
        energy = fabs(energy - E_ION_TH * EV_TO_J);

        e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
        e_sc = fabs(energy - e_ej);

        g  = sqrt(e_sc * TWO_OVER_E_MASS);
        g2 = sqrt(e_ej * TWO_OVER_E_MASS);

        // Cosinus i sinus kąta rozproszenia dla elektronu rozproszonego oraz wybitego
        cc = sqrt(e_sc / energy);
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));

        double cc2 = sqrt(e_ej / energy);
        double sc2 = sqrt(std::max(0.0, 1.0 - cc2 * cc2));

        // Dla elektronu wybitego kąt azymutalny wynosi eta + PI, więc sin i cos zmieniają znak
        double se2 = -se;
        double ce2 = -ce;

        double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
        double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
        double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);

        // 4. Zapis nowego elektronu wtórnego oraz jonu Ar+ do prywatnych buforów wątku
        new_e.push(xe, wx + F2 * gx2, wy + F2 * gy2, wz + F2 * gz2);
        new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
    }

    // 5. Transformacja kątowa prędkości elektronu pierwotnego po zderzeniu
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);

    (*vxe) = wx + F2 * gx;
    (*vye) = wy + F2 * gy;
    (*vze) = wz + F2 * gz;
}

/*
Realizuje pojedyncze zderzenie jonu argonu Ar+ z neutralnym atomem tła Ar (MCC).
Wykorzystuje szybki skrót dla wymiany ładunku (I_BACK) oraz algebraiczną transformację
kątową bez funkcji trygonometrycznych atan2 i acos dla rozpraszania izotropowego (I_ISO).
Etapy:
 1. Losowanie typu procesu: wymiana ładunku (I_BACK) lub rozpraszanie izotropowe (I_ISO).
 2. W przypadku wymiany ładunku: bezpośrednie przypisanie prędkości termicznej atomu tła do jonu.
 3. W przypadku rozpraszania izotropowego: algebraiczny obrót wektora prędkości względnej w układzie COM.
@param vx_1    Wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi x [m/s].
@param vy_1    Wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi y [m/s].
@param vz_1    Wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi z [m/s].
@param vx_2    Wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi x [m/s].
@param vy_2    Wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi y [m/s].
@param vz_2    Wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi z [m/s].
@param e_index Indeks energii zderzenia w układzie środka masy w tablicach przekrojów czynnych.
*/
PIC_STEP void collision_ion(double *vx_1, double *vy_1, double *vz_1,
                            double *vx_2, double *vy_2, double *vz_2, int e_index) {
    // 1. Wybór procesu: rozpraszanie izotropowe (I_ISO) lub wsteczne / wymiana ładunku (I_BACK)
    double t1  = sigma[I_ISO][e_index];
    double t2  = t1 + sigma[I_BACK][e_index];
    double rnd = R01(MTgen);

    // 2. Wymiana ładunku (chi = PI): jon przejmuje prędkość termiczną neutralnego atomu tła
    if (rnd * t2 >= t1) {
        *vx_1 = *vx_2;
        *vy_1 = *vy_2;
        *vz_1 = *vz_2;
        return;
    }

    // 3. Rozpraszanie sprężyste izotropowe: algebraiczne wyznaczenie kątów i rotacja prędkości względnej
    double gx        = (*vx_1) - (*vx_2);
    double gy        = (*vy_1) - (*vy_2);
    double gz        = (*vz_1) - (*vz_2);
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

    double cc = 1.0 - 2.0 * R01(MTgen);
    double sc = sqrt(std::max(0.0, 1.0 - cc * cc));

    double eta = TWO_PI * R01(MTgen);
    double se  = sin(eta);
    double ce  = cos(eta);

    // Transformacja wektora prędkości względnej i wyznaczenie nowej prędkości jonu w układzie laboratoryjnym
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);

    (*vx_1) = wx + 0.5 * gx;
    (*vy_1) = wy + 0.5 * gy;
    (*vz_1) = wz + 0.5 * gz;
}
