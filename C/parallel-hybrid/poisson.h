#pragma once
#include "state.h"
#include <cmath>

inline void solve_Poisson (xvector rho1, double tt){
    const double A =  1.0;
    const double B = -2.0;
    const double C =  1.0;
    const double S = 1.0 / (2.0 * DX);
    const double ALPHA = -DX * DX / EPSILON0;
    xvector      g, w, f;
    int          i;
    
    // apply potential to the electrodes - boundary conditions
    
    pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
    pot[N_G-1] = 0.0;                               // potential at the grounded electrode
    
    // solve Poisson equation
    //  Przygotowanie prawej strony ukladu rownan
    for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
    f[1] -= pot[0];
    f[N_G-2] -= pot[N_G-1];

    //  Faza 1 - eliminacja w przod
    w[1] = C/B;
    g[1] = f[1]/B;
    for(i=2; i<=N_G-2; i++){
        w[i] = C / (B - A * w[i-1]);
        g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
    }

    //  Faza 2 - podstawienie wsteczne
    pot[N_G-2] = g[N_G-2];
    for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];            // potential at the grid points between the electrodes
    
    // compute electric field
    
    for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
    efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
    efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
}
