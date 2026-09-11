#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>

// Prekompilowane współczynniki algorytmu Thomasa oraz bufory robocze
inline xvector w_thomas;
inline xvector inv_denom_thomas;
inline xvector g_poisson;
inline xvector f_poisson;

inline void init_poisson_solver() {
    w_thomas[1] = C / B;
    inv_denom_thomas[1] = 1.0 / B;
    for (int i = 2; i <= N_G - 2; i++) {
        double denom = B - A * w_thomas[i - 1];
        inv_denom_thomas[i] = 1.0 / denom;
        w_thomas[i] = C * inv_denom_thomas[i];
    }
}

PIC_STEP void solve_Poisson (double tt){
    // 1. Warunki brzegowe potencjału na elektrodach
    pot[0]     = VOLTAGE * cos(OMEGA * tt);
    pot[N_G-1] = 0.0;
    
    // 2. Przygotowanie prawej strony (fuzja z ładunkiem elementarnym ALPHA_Q)
    for(int i = 1; i <= N_G-2; i++) {
        f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
    }
    f_poisson[1] -= pot[0];
    f_poisson[N_G-2] -= pot[N_G-1];

    // 3. Faza 1 Thomasa – eliminacja w przód (mnożenie przez inv_denom zamiast dzielenia)
    g_poisson[1] = f_poisson[1] * inv_denom_thomas[1];
    for(int i = 2; i <= N_G-2; i++){
        g_poisson[i] = (f_poisson[i] - A * g_poisson[i-1]) * inv_denom_thomas[i];
    }

    // 4. Faza 2 Thomasa – podstawienie wsteczne z prekompilowanym w_thomas
    pot[N_G-2] = g_poisson[N_G-2];
    for (int i = N_G-3; i > 0; i--) {
        pot[i] = g_poisson[i] - w_thomas[i] * pot[i+1];
    }
    
    // 5. Obliczenie natężenia pola elektrycznego
    for(int i = 1; i <= N_G-2; i++) {
        efield[i] = (pot[i-1] - pot[i+1]) * S;
    }
    efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0]     - e_density[0])     * BETA_Q;
    efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + (i_density[N_G-1] - e_density[N_G-1]) * BETA_Q;
}
