#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>

/*
Realizuje pojedyncze zderzenie elektronu z neutralnym atomem argonu (MCC) w przybliżeniu zimnego gazu.
Wykorzystuje klasyczną parametryzację trygonometryczną kątów Eulera (atan2, acos, sin, cos).
Etapy:
 1. Obliczenie prędkości względnej g oraz prędkości środka masy w.
 2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości przed zderzeniem.
 3. Losowanie rodzaju procesu (rozpraszanie sprężyste, wzbudzenie, jonizacja) na podstawie przekrojów czynnych.
 4. W przypadku jonizacji: utworzenie nowego elektronu wtórnego oraz jonu Ar+ o prędkości termicznej.
 5. Rotacja wektora prędkości elektronu rozproszonego i transformacja do układu laboratoryjnego.
@param xe     Pozycja 1D zderzającego się elektronu [m].
@param vxe    Wskaźnik do składowej prędkości elektronu wzdłuż osi x [m/s].
@param vye    Wskaźnik do składowej prędkości elektronu wzdłuż osi y [m/s].
@param vze    Wskaźnik do składowej prędkości elektronu wzdłuż osi z [m/s].
@param eindex Indeks energii kinetycznej w tablicach przekrojów czynnych.
*/
inline void collision_electron(double xe, double *vxe, double *vye, double *vze, int eindex) {
    double t0, t1, t2, rnd;
    double g, g2, gx, gy, gz, wx, wy, wz, theta, phi;
    double chi, eta, chi2, eta2, sc, cc, se, ce, st, ct, sp, cp, energy, e_sc, e_ej;

    // 1. Obliczenie prędkości względnej przed zderzeniem oraz prędkości środka masy
    gx = (*vxe);
    gy = (*vye);
    gz = (*vze);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = F1 * (*vxe);
    wy = F1 * (*vye);
    wz = F1 * (*vze);

    // 2. Wyznaczenie kątów Eulera (theta, phi) opisujących orientację prędkości przed zderzeniem
    if (gx == 0) {
        theta = 0.5 * PI;
    } else {
        theta = atan2(sqrt(gy * gy + gz * gz), gx);
    }
    if (gy == 0) {
        if (gz > 0) {
            phi = 0.5 * PI;
        } else {
            phi = -0.5 * PI;
        }
    } else {
        phi = atan2(gz, gy);
    }
    st = sin(theta);
    ct = cos(theta);
    sp = sin(phi);
    cp = cos(phi);

    // 3. Wybór procesu zderzeniowego na podstawie skumulowanych przekrojów czynnych
    t0  = sigma[E_ELA][eindex];
    t1  = t0 + sigma[E_EXC][eindex];
    t2  = t1 + sigma[E_ION][eindex];
    rnd = R01(MTgen);

    if (rnd < (t0 / t2)) {
        // Zderzenie sprężyste: izotropowe rozproszenie bez straty energii w układzie COM
        chi = acos(1.0 - 2.0 * R01(MTgen));
        eta = TWO_PI * R01(MTgen);
    } else if (rnd < (t1 / t2)) {
        // Wzbudzenie elektronowe: odjęcie progu energii wzbudzenia E_EXC_TH i izotropowe rozproszenie
        energy = 0.5 * E_MASS * g * g;
        energy = fabs(energy - E_EXC_TH * EV_TO_J);
        g      = sqrt(2.0 * energy / E_MASS);
        chi    = acos(1.0 - 2.0 * R01(MTgen));
        eta    = TWO_PI * R01(MTgen);
    } else {
        // Jonizacja uderzeniowa: odjęcie progu E_ION_TH i podział energii według rozkładu Opla
        energy = 0.5 * E_MASS * g * g;
        energy = fabs(energy - E_ION_TH * EV_TO_J);
        e_ej   = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
        e_sc   = fabs(energy - e_ej);
        g      = sqrt(2.0 * e_sc / E_MASS);
        g2     = sqrt(2.0 * e_ej / E_MASS);
        chi    = acos(sqrt(e_sc / energy));
        chi2   = acos(sqrt(e_ej / energy));
        eta    = TWO_PI * R01(MTgen);
        eta2   = eta + PI;

        // 4. Obliczenie prędkości i dodanie nowego elektronu wtórnego oraz jonu Ar+ do tablic globalnych
        sc = sin(chi2);
        cc = cos(chi2);
        se = sin(eta2);
        ce = cos(eta2);
        gx = g2 * (ct * cc - st * sc * ce);
        gy = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
        gz = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);

        x_e[N_e]  = xe;
        vx_e[N_e] = wx + F2 * gx;
        vy_e[N_e] = wy + F2 * gy;
        vz_e[N_e] = wz + F2 * gz;
        N_e++;

        x_i[N_i]  = xe;
        vx_i[N_i] = RMB(MTgen);
        vy_i[N_i] = RMB(MTgen);
        vz_i[N_i] = RMB(MTgen);
        N_i++;
    }

    // 5. Transformacja kątowa prędkości elektronu pierwotnego po zderzeniu
    sc = sin(chi);
    cc = cos(chi);
    se = sin(eta);
    ce = cos(eta);

    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);

    (*vxe) = wx + F2 * gx;
    (*vye) = wy + F2 * gy;
    (*vze) = wz + F2 * gz;
}

/*
Realizuje pojedyncze zderzenie jonu argonu Ar+ z neutralnym atomem tła Ar (MCC).
Uwzględnia losową prędkość termiczną atomu tła oraz rozróżnia rozpraszanie izotropowe i wsteczne.
Etapy:
 1. Obliczenie prędkości względnej g oraz prędkości środka masy w dla cząstek o równych masach.
 2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości względnej przed zderzeniem.
 3. Losowanie rodzaju procesu: izotropowe rozpraszanie sprężyste (I_ISO) lub wsteczne (I_BACK, chi = PI).
 4. Rotacja wektora prędkości względnej i wyznaczenie nowej prędkości jonu w układzie laboratoryjnym.
@param vx_1    Wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi x [m/s].
@param vy_1    Wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi y [m/s].
@param vz_1    Wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi z [m/s].
@param vx_2    Wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi x [m/s].
@param vy_2    Wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi y [m/s].
@param vz_2    Wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi z [m/s].
@param e_index Indeks energii zderzenia w układzie środka masy w tablicach przekrojów czynnych.
*/
inline void collision_ion(double *vx_1, double *vy_1, double *vz_1,
                          double *vx_2, double *vy_2, double *vz_2, int e_index) {
    double g, gx, gy, gz, wx, wy, wz, rnd;
    double theta, phi, chi, eta, st, ct, sp, cp, sc, cc, se, ce, t1, t2;

    // 1. Obliczenie prędkości względnej oraz prędkości środka masy
    gx = (*vx_1) - (*vx_2);
    gy = (*vy_1) - (*vy_2);
    gz = (*vz_1) - (*vz_2);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = 0.5 * ((*vx_1) + (*vx_2));
    wy = 0.5 * ((*vy_1) + (*vy_2));
    wz = 0.5 * ((*vz_1) + (*vz_2));

    // 2. Wyznaczenie kątów Eulera (theta, phi)
    if (gx == 0) {
        theta = 0.5 * PI;
    } else {
        theta = atan2(sqrt(gy * gy + gz * gz), gx);
    }
    if (gy == 0) {
        if (gz > 0) {
            phi = 0.5 * PI;
        } else {
            phi = -0.5 * PI;
        }
    } else {
        phi = atan2(gz, gy);
    }

    // 3. Wybór typu zderzenia (rozpraszanie izotropowe lub wsteczne) i losowanie kątów rozproszenia
    t1  = sigma[I_ISO][e_index];
    t2  = t1 + sigma[I_BACK][e_index];
    rnd = R01(MTgen);
    if (rnd < (t1 / t2)) {
        chi = acos(1.0 - 2.0 * R01(MTgen));
    } else {
        chi = PI;
    }
    eta = TWO_PI * R01(MTgen);
    sc  = sin(chi);
    cc  = cos(chi);
    se  = sin(eta);
    ce  = cos(eta);
    st  = sin(theta);
    ct  = cos(theta);
    sp  = sin(phi);
    cp  = cos(phi);

    // 4. Obliczenie nowej prędkości względnej oraz prędkości jonu po zderzeniu
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);

    (*vx_1) = wx + 0.5 * gx;
    (*vy_1) = wy + 0.5 * gy;
    (*vz_1) = wz + 0.5 * gz;
}
