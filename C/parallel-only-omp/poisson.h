
#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>

// Wstępnie wyliczone stałe współczynniki algorytmu Thomasa oraz bufory robocze
inline xvector w_thomas;
inline xvector inv_denom_thomas;
inline xvector g_poisson;
inline xvector f_poisson;

/*
Jednorazowa inicjalizacja współczynników algorytmu Thomasa
Wszystkie dzielenia są zastąpione stałymi mnożnikami inv_denom_thomas
*/
inline void init_poisson_solver() {
    w_thomas[1] = C / B;
    inv_denom_thomas[1] = 1.0 / B;
    for (int i = 2; i <= N_G - 2; i++) {
        double denom = B - A * w_thomas[i - 1];
        inv_denom_thomas[i] = 1.0 / denom;
        w_thomas[i] = C * inv_denom_thomas[i];
    }
}

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

    int i;
    
    // 1. Warunki brzegowe Dirichleta dla potencjału na elektrodach
    pot[0]     = VOLTAGE * cos(OMEGA * tt);         // Potencjał na elektrodzie zasilanej RF (x = 0)
    pot[N_G-1] = 0.0;                               // Potencjał na elektrodzie uziemionej (x = L)
    
    // 2. Rozwiązanie równania Poissona: Przygotowanie prawej strony układu równań
    // f[i] = -DX^2 / EPSILON0 * rho[i] z uwzględnieniem warunków brzegowych
    for(i=1; i<=N_G-2; i++) f_poisson[i] = ALPHA * rho1[i];
    f_poisson[1] -= pot[0];
    f_poisson[N_G-2] -= pot[N_G-1];

    // 3. Algorytm Thomasa — Faza 1: Eliminacja w przód (Forward elimination)
    g_poisson[1] = f_poisson[1] * inv_denom_thomas[1];
    for (i = 2; i <= N_G - 2; i++){
        g_poisson[i] = (f_poisson[i] - A * g_poisson[i - 1]) * inv_denom_thomas[i];
    }

    // 4. Algorytm Thomasa — Faza 2: Podstawienie wsteczne (Back substitution)
    // Wyznacza potencjał w wewnętrznych węzłach siatki
    pot[N_G-2] = g_poisson[N_G-2];
    for (i = N_G - 3; i > 0; i--){
        pot[i] = g_poisson[i] - w_thomas[i] * pot[i + 1];
    }
    
    // 5. Obliczanie natężenia pola elektrycznego E = -grad(pot)
    // Schemat różnic centralnych wewnątrz + korekta ładunku na granicach komórek
    for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
    efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // Elektroda zasilana
    efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // Elektroda uziemiona
}
