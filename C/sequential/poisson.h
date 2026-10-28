#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>

/*
Rozwiązuje jednowymiarowe równanie Poissona (d^2 phi / dx^2 = -rho / epsilon_0)
za pomocą algorytmu Thomasa dla macierzy trójdiagonalnej, a następnie wyznacza
natężenie pola elektrycznego E = -d(phi)/dx w węzłach siatki.
Etapy:
 1. Zastosowanie warunków brzegowych Dirichleta dla potencjału na elektrodach.
 2. Przygotowanie wektora prawej strony układu równań z uwzględnieniem brzegów.
 3. Eliminacja w przód (forward sweep) wyznaczająca współczynniki pomocnicze w i g.
 4. Podstawienie wsteczne (back substitution) wyznaczające potencjał w węzłach wewnętrznych.
 5. Obliczenie natężenia pola elektrycznego metodą różnic centralnych oraz na brzegach.
@param rho1 Wektor gęstości ładunku przestrzennego w węzłach siatki [C/m^3].
@param tt   Aktualny fizyczny czas symulacji służący do obliczenia fazy napięcia RF [s].
*/
inline void solve_Poisson(xvector rho1, double tt) {
    xvector g, w, f;
    int i;

    // 1. Warunki brzegowe Dirichleta dla potencjału na elektrodach (x = 0 oraz x = L)
    pot[0]     = VOLTAGE * cos(OMEGA * tt);
    pot[N_G-1] = 0.0;

    // 2. Przygotowanie prawej strony układu równań
    for (i = 1; i <= N_G-2; i++) {
        f[i] = ALPHA * rho1[i];
    }
    f[1]     -= pot[0];
    f[N_G-2] -= pot[N_G-1];

    // 3. Algorytm Thomasa - faza eliminacji w przód
    w[1] = C / B;
    g[1] = f[1] / B;
    for (i = 2; i <= N_G-2; i++) {
        w[i] = C / (B - A * w[i-1]);
        g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
    }

    // 4. Algorytm Thomasa - faza podstawienia wstecznego
    pot[N_G-2] = g[N_G-2];
    for (i = N_G-3; i > 0; i--) {
        pot[i] = g[i] - w[i] * pot[i+1];
    }

    // 5. Wyznaczenie natężenia pola elektrycznego w węzłach wewnętrznych oraz na elektrodach
    for (i = 1; i <= N_G-2; i++) {
        efield[i] = (pot[i-1] - pot[i+1]) * S;
    }
    efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);
    efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);
}
