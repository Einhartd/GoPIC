
#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>

/*
Rozwiązanie 1D równania Poissona (d^2 phi / dx^2 = -rho / epsilon_0).
Wykorzystuje algorytm Thomasa dla układu trójdiagonalnego (A=1, B=-2, C=1).
Następnie oblicza rozkład natężenia pola elektrycznego E = -d(phi)/dx z uwzględnieniem
warunków brzegowych Dirichleta na elektrodach.
Etapy:
 1. Zastosowanie warunków brzegowych Dirichleta dla potencjału na elektrodach.
 2. Przygotowanie prawej strony układu równań z poprawkami brzegowymi.
 3. Eliminacja w przód algorytmu Thomasa (forward elimination).
 4. Podstawienie wsteczne (back substitution) i wyznaczenie potencjału w węzłach.
 5. Obliczenie natężenia pola elektrycznego wewnątrz i na brzegach komórek.
@param rho1 Wektor gęstości ładunku przestrzennego na siatce [C/m^3].
@param tt   Aktualny fizyczny czas symulacji [s] (do wyznaczenia napięcia RF).
*/
inline void solve_Poisson (xvector rho1, double tt){

    xvector      g, w, f;
    int          i;
    
    // -------------------------------------------------------------------------
    // 1. Warunki brzegowe Dirichleta dla potencjału na elektrodach
    // -------------------------------------------------------------------------
    pot[0]     = VOLTAGE * cos(OMEGA * tt);         // Potencjał na elektrodzie zasilanej RF (x = 0)
    pot[N_G-1] = 0.0;                               // Potencjał na elektrodzie uziemionej (x = L)
    
    // -------------------------------------------------------------------------
    // 2. Rozwiązanie równania Poissona: Przygotowanie prawej strony układu równań
    // f[i] = -DX^2 / EPSILON0 * rho[i] z uwzględnieniem warunków brzegowych
    // -------------------------------------------------------------------------
    for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
    f[1] -= pot[0];
    f[N_G-2] -= pot[N_G-1];

    // -------------------------------------------------------------------------
    // 3. Algorytm Thomasa — Faza 1: Eliminacja w przód (Forward elimination)
    // -------------------------------------------------------------------------
    w[1] = C / B;
    g[1] = f[1] / B;
    for(i=2; i<=N_G-2; i++){
        w[i] = C / (B - A * w[i-1]);
        g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
    }

    // -------------------------------------------------------------------------
    // 4. Algorytm Thomasa — Faza 2: Podstawienie wsteczne (Back substitution)
    // Wyznacza potencjał w wewnętrznych węzłach siatki
    // -------------------------------------------------------------------------
    pot[N_G-2] = g[N_G-2];
    for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];
    
    // -------------------------------------------------------------------------
    // 5. Obliczanie natężenia pola elektrycznego E = -grad(pot)
    // Schemat różnic centralnych wewnątrz + korekta ładunku na granicach komórek
    // -------------------------------------------------------------------------
    for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
    efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // Elektroda zasilana
    efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // Elektroda uziemiona
}
