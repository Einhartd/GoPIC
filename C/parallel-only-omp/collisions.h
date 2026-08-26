#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>
#include <vector>
#include <omp.h>

/*
Bufor na nowo utworzone cząstki (elektrony i jony z procesów jonizacji).
Wątki zapisują nowo powstałe cząstki do własnych lokalnych instancji,
unikając konfliktów zapisu (data races).
*/
struct NewParticles {
    std::vector<double> x;
    std::vector<double> vx;
    std::vector<double> vy;
    std::vector<double> vz;

    /*
    Dodanie nowej cząstki do bufora.
    @param px  Pozycja 1D nowej cząstki [m].
    @param pvx Składowa X prędkości [m/s].
    @param pvy Składowa Y prędkości [m/s].
    @param pvz Składowa Z prędkości [m/s].
    */
    void push(double px, double pvx, double pvy, double pvz) {
        x.push_back(px);
        vx.push_back(pvx);
        vy.push_back(pvy);
        vz.push_back(pvz);
    }
};

/*
Obsługa pojedynczego zderzenia elektronu z neutralnym atomem argonu (MCC).
Przybliżenie zimnego gazu (prędkość atomu argonu pomijana w porównaniu z elektronem).
Etapy:
 1. Obliczenie prędkości względnej g oraz prędkości środka masy w.
 2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości przed zderzeniem.
 3. Losowanie typu procesu (sprężyste, wzbudzenie, jonizacja) na podstawie przekrojów czynnych.
 4. Obliczenie strat energii dla procesów niesprężystych i kątów rozproszenia (chi, eta).
 5. W przypadku jonizacji: dodanie elektronu wtórnego i jonu Ar+ do lokalnych buforów.
 6. Transformacja kątowa prędkości elektronu pierwotnego po zderzeniu.
@param xe     Pozycja 1D zderzającego się elektronu.
@param vxe, vye, vze  Wskaźniki do składowych prędkości elektronu (modyfikowane in-place).
@param eindex Indeks przedziału energii w tabelach przekrojów czynnych.
@param new_e  Lokalny bufor na nowe elektrony.
@param new_i  Lokalny bufor na nowe jony.
*/
PIC_STEP void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex,
                                NewParticles& new_e, NewParticles& new_i) {

    double t0,t1,t2,rnd;
    double g,g2,gx,gy,gz,wx,wy,wz,theta,phi;
    double chi,eta,chi2,eta2,sc,cc,se,ce,st,ct,sp,cp,energy,e_sc,e_ej;
    
    // -------------------------------------------------------------------------
    // 1. Prędkość względna przed zderzeniem oraz prędkość środka masy (COM)
    // -------------------------------------------------------------------------
    gx = (*vxe);
    gy = (*vye);
    gz = (*vze);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = F1 * (*vxe);
    wy = F1 * (*vye);
    wz = F1 * (*vze);
    
    // -------------------------------------------------------------------------
    // 2. Kąty Eulera układu odniesienia cząstki
    // -------------------------------------------------------------------------
    if (gx == 0) {theta = 0.5 * PI;}
    else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
    if (gy == 0) {
        if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
    } else {phi = atan2(gz, gy);}
    st  = sin(theta);
    ct  = cos(theta);
    sp  = sin(phi);
    cp  = cos(phi);
    
    // -------------------------------------------------------------------------
    // 3. Wybór typu zderzenia na podstawie skumulowanych przekrojów czynnych
    // -------------------------------------------------------------------------
    t0   =     sigma[E_ELA][eindex];
    t1   = t0 +sigma[E_EXC][eindex];
    t2   = t1 +sigma[E_ION][eindex];
    rnd  = R01(MTgen);

    if (rnd < (t0/t2)){                              // Zderzenie sprężyste
        chi = acos(1.0 - 2.0 * R01(MTgen));          // Rozpraszanie izotropowe
        eta = TWO_PI * R01(MTgen);                   // Kąt azymutalny
    } else if (rnd < (t1/t2)){                       // Wzbudzenie (niesprężyste)
        energy = 0.5 * E_MASS * g * g;               // Energia kinetyczna przed zderzeniem
        energy = fabs(energy - E_EXC_TH * EV_TO_J);  // Odjęcie progu wzbudzenia (11.5 eV)
        g   = sqrt(2.0 * energy / E_MASS);           // Prędkość względna po stracie energii
        chi = acos(1.0 - 2.0 * R01(MTgen));          // Rozpraszanie izotropowe
        eta = TWO_PI * R01(MTgen);                   // Kąt azymutalny
    } else {                                         // Jonizacja (niesprężysta)
        energy = 0.5 * E_MASS * g * g;               // Energia kinetyczna przed zderzeniem
        energy = fabs(energy - E_ION_TH * EV_TO_J);  // Odjęcie progu jonizacji (15.8 eV)

        // Energia wybitego elektronu wtórnego (rozkład wg formy różniczkowej Opla)
        e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J;

        e_sc = fabs(energy - e_ej);                  // Pozostała energia elektronu rozproszonego
        g    = sqrt(2.0 * e_sc / E_MASS);            // Prędkość elektronu rozproszonego
        g2   = sqrt(2.0 * e_ej / E_MASS);            // Prędkość elektronu wybitego
        chi  = acos(sqrt(e_sc / energy));            // Kąt rozproszenia dla elektronu rozproszonego
        chi2 = acos(sqrt(e_ej / energy));            // Kąt rozproszenia dla elektronu wybitego
        eta  = TWO_PI * R01(MTgen);                  // Kąt azymutalny elektronu rozproszonego
        eta2 = eta + PI;                             // Kąt azymutalny elektronu wybitego (w przeciwną stronę)
        sc  = sin(chi2);
        cc  = cos(chi2);
        se  = sin(eta2);
        ce  = cos(eta2);
        gx  = g2 * (ct * cc - st * sc * ce);
        gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
        gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
        
        // Dodanie nowego elektronu wtórnego do lokalnego bufora
        new_e.push(xe, wx + F2 * gx, wy + F2* gy, wz + F2 * gz);
        // Dodanie nowego jonu Ar+ (prędkość losowana z termicznego rozkładu Maxwella-Boltzmanna tła)
        new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
    }
    
    // -------------------------------------------------------------------------
    // 4. Rozproszenie elektronu pierwotnego (rotacja wektora prędkości)
    // -------------------------------------------------------------------------
    sc = sin(chi);
    cc = cos(chi);
    se = sin(eta);
    ce = cos(eta);
    
    // Obliczenie nowego wektora prędkości względnej
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    // Końcowa prędkość elektronu po zderzeniu (w układzie laboratoryjnym)
    (*vxe) = wx + F2 * gx;
    (*vye) = wy + F2 * gy;
    (*vze) = wz + F2 * gz;
}

/*
Obsługa pojedynczego zderzenia jonu Ar+ z neutralnym atomem argonu (MCC).
Uwzględnia prędkość termiczną tła atomowego (przekazaną w parametrach vx_2..vz_2).
Etapy:
 1. Obliczenie prędkości względnej g oraz prędkości środka masy w (masy obu cząstek równe).
 2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości względnej.
 3. Wybór typu zderzenia na podstawie przekrojów czynnych (izotropowe vs wsteczna wymiana ładunku).
 4. Transformacja kątowa i wyznaczenie nowej prędkości jonu w układzie laboratoryjnym.
@param vx_1, vy_1, vz_1  Wskaźniki do składowych prędkości jonu (modyfikowane in-place).
@param vx_2, vy_2, vz_2  Wylosowane składowe prędkości atomu tła (z rozkładu RMB).
@param e_index           Indeks energii w układzie środka masy w tabelach przekrojów.
*/
PIC_STEP void collision_ion (double *vx_1, double *vy_1, double *vz_1,
                    double *vx_2, double *vy_2, double *vz_2, int e_index){
    double   g,gx,gy,gz,wx,wy,wz,rnd;
    double   theta,phi,chi,eta,st,ct,sp,cp,sc,cc,se,ce,t1,t2;
    
    // -------------------------------------------------------------------------
    // 1. Prędkość względna g oraz prędkość środka masy w (masy obu cząstek równe)
    // -------------------------------------------------------------------------
    gx = (*vx_1)-(*vx_2);
    gy = (*vy_1)-(*vy_2);
    gz = (*vz_1)-(*vz_2);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = 0.5 * ((*vx_1) + (*vx_2));
    wy = 0.5 * ((*vy_1) + (*vy_2));
    wz = 0.5 * ((*vz_1) + (*vz_2));
    
    // -------------------------------------------------------------------------
    // 2. Kąty Eulera
    // -------------------------------------------------------------------------
    if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
    if (gy == 0) {
        if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
    } else {phi = atan2(gz, gy);}
    
    // -------------------------------------------------------------------------
    // 3. Wybór procesu: rozpraszanie izotropowe vs wsteczne (wymiana ładunku)
    // -------------------------------------------------------------------------
    t1  =      sigma[I_ISO][e_index];
    t2  = t1 + sigma[I_BACK][e_index];
    rnd = R01(MTgen);
    if  (rnd < (t1 /t2)){                        // Rozpraszanie izotropowe
        chi = acos(1.0 - 2.0 * R01(MTgen));      // Kąt rozproszenia chi
    } else {                                     // Rozpraszanie wsteczne (Charge Exchange)
        chi = PI;                                // Kąt rozproszenia chi = 180 stopni
    }
    eta = TWO_PI * R01(MTgen);                   // Kąt azymutalny
    sc  = sin(chi);
    cc  = cos(chi);
    se  = sin(eta);
    ce  = cos(eta);
    st  = sin(theta);
    ct  = cos(theta);
    sp  = sin(phi);
    cp  = cos(phi);
    
    // -------------------------------------------------------------------------
    // 4. Transformacja prędkości i wyznaczenie nowej prędkości jonu
    // -------------------------------------------------------------------------
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    // Nowa prędkość jonu w układzie laboratoryjnym
    (*vx_1) = wx + 0.5 * gx;
    (*vy_1) = wy + 0.5 * gy;
    (*vz_1) = wz + 0.5 * gz;
}
