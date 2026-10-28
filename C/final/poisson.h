#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>

// Prekalkulowane współczynniki eliminacji w przód algorytmu Thomasa oraz bufory robocze solvera Poissona
inline xvector w_thomas;
inline xvector inv_denom_thomas;
inline xvector g_poisson;
inline xvector f_poisson;

/*
Jednorazowo wyznacza stałe współczynniki macierzy trójdiagonalnej dla algorytmu Thomasa.
Zastępuje operacje dzielenia w każdym kroku czasowym mnożeniem przez odwrotności inv_denom_thomas.
*/
inline void init_poisson_solver() {
    w_thomas[1]         = C / B;
    inv_denom_thomas[1] = 1.0 / B;
    for (int i = 2; i <= N_G - 2; i++) {
        double denom        = B - A * w_thomas[i - 1];
        inv_denom_thomas[i] = 1.0 / denom;
        w_thomas[i]         = C * inv_denom_thomas[i];
    }
}

/*
Rozwiązuje jednowymiarowe równanie Poissona (d^2 phi / dx^2 = -rho / epsilon_0)
za pomocą zoptymalizowanego algorytmu Thomasa z prekalkulowanymi współczynnikami,
a następnie wyznacza natężenie pola elektrycznego E = -d(phi)/dx w węzłach siatki.
Etapy:
 1. Zastosowanie warunków brzegowych Dirichleta dla potencjału na elektrodach.
 2. Przygotowanie prawej strony układu równań bezpośrednio z gęstości jonów i elektronów.
 3. Eliminacja w przód (forward elimination) z wykorzystaniem tablicy inv_denom_thomas.
 4. Podstawienie wsteczne (back substitution) wyznaczające potencjał w węzłach wewnętrznych.
 5. Obliczenie natężenia pola elektrycznego metodą różnic centralnych oraz na brzegach.
@param tt Aktualny fizyczny czas symulacji służący do obliczenia fazy napięcia RF [s].
*/
inline void solve_Poisson(double tt) {
    int i;

    // 1. Warunki brzegowe Dirichleta dla potencjału na elektrodzie zasilanej (x = 0) i uziemionej (x = L)
    pot[0]     = VOLTAGE * cos(OMEGA * tt);
    pot[N_G-1] = 0.0;

    // 2. Przygotowanie prawej strony układu równań z poprawkami brzegowymi
    for (i = 1; i <= N_G - 2; i++) {
        f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
    }
    f_poisson[1]     -= pot[0];
    f_poisson[N_G-2] -= pot[N_G-1];

    // 3. Algorytm Thomasa - faza eliminacji w przód (bez operacji dzielenia)
    g_poisson[1] = f_poisson[1] * inv_denom_thomas[1];
    for (i = 2; i <= N_G - 2; i++) {
        g_poisson[i] = (f_poisson[i] - A * g_poisson[i - 1]) * inv_denom_thomas[i];
    }

    // 4. Algorytm Thomasa - faza podstawienia wstecznego wyznaczająca potencjał w węzłach
    pot[N_G-2] = g_poisson[N_G-2];
    for (i = N_G - 3; i > 0; i--) {
        pot[i] = g_poisson[i] - w_thomas[i] * pot[i + 1];
    }

    // 5. Wyznaczenie natężenia pola elektrycznego w węzłach wewnętrznych oraz na elektrodach
    for (i = 1; i <= N_G - 2; i++) {
        efield[i] = (pot[i-1] - pot[i+1]) * S;
    }
    efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0]     - e_density[0])     * BETA_Q;
    efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + (i_density[N_G-1] - e_density[N_G-1]) * BETA_Q;
}
