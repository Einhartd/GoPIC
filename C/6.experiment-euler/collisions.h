#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>
#include <algorithm>

PIC_STEP void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex){
    double t0,t1,t2,rnd;
    double g,g2,gx,gy,gz,wx,wy,wz;
    double sc,cc,se,ce,st,ct,sp,cp,energy,e_sc,e_ej;
    
    // calculate relative velocity before collision & velocity of the centre of mass
    gx = (*vxe);
    gy = (*vye);
    gz = (*vze);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = F1 * (*vxe);
    wy = F1 * (*vye);
    wz = F1 * (*vze);
    
    // Vector algebra for Euler angles:
    // theta is the angle with x-axis, phi is azimuthal angle around x-axis
    // Eliminates 2x atan2 and 4x sin/cos
    double g_perp = sqrt(gy * gy + gz * gz);
    if (g > 0.0) {
        double inv_g = 1.0 / g;
        ct = gx * inv_g;
        st = g_perp * inv_g;
    } else {
        ct = 1.0;
        st = 0.0;
    }
    if (g_perp > 0.0) {
        double inv_gp = 1.0 / g_perp;
        cp = gy * inv_gp;
        sp = gz * inv_gp;
    } else {
        cp = 1.0;
        sp = 0.0;
    }
    
    // choose the type of collision based on the cross sections
    // take into account energy loss in inelastic collisions
    // generate scattering and azimuth angles via vector algebra
    // in case of ionization handle the 'new' electron
    
    t0   =     sigma[E_ELA][eindex];
    t1   = t0 +sigma[E_EXC][eindex];
    t2   = t1 +sigma[E_ION][eindex];
    rnd  = R01(MTgen);
    double rnd_t2 = rnd * t2;
    if (rnd_t2 < t0){                                // elastic scattering
        // Isotropic scattering: cos(chi) = 1 - 2*R, sin(chi) = sqrt(1 - cos^2)
        // Eliminates acos, sin(chi), cos(chi)
        cc = 1.0 - 2.0 * R01(MTgen);
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));
        double eta = TWO_PI * R01(MTgen);
        se = sin(eta);
        ce = cos(eta);
    } else if (rnd_t2 < t1){                         // excitation
        energy = 0.5 * E_MASS * g * g;               // electron energy
        energy = fabs(energy - E_EXC_TH * EV_TO_J);  // subtract energy loss for excitation
        g   = sqrt(energy * TWO_OVER_E_MASS);        // relative velocity after energy loss
        cc = 1.0 - 2.0 * R01(MTgen);
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));
        double eta = TWO_PI * R01(MTgen);
        se = sin(eta);
        ce = cos(eta);
    } else {                                         // ionization
        energy = 0.5 * E_MASS * g * g;               // electron energy
        energy = fabs(energy - E_ION_TH * EV_TO_J);  // subtract energy loss of ionization
        e_ej  = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J; // energy of the ejected electron
        e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
        g    = sqrt(e_sc * TWO_OVER_E_MASS);         // relative velocity of scattered electron
        g2   = sqrt(e_ej * TWO_OVER_E_MASS);         // relative velocity of ejected electron
        
        // Analytical scattering angles for ionization:
        // cos(chi) = sqrt(e_sc / energy), cos(chi2) = sqrt(e_ej / energy)
        // Eliminates 2x acos, 4x sin/cos!
        double inv_energy = (energy > 0.0) ? (1.0 / energy) : 0.0;
        cc = sqrt(e_sc * inv_energy);                // cos(chi) for primary electron
        sc = sqrt(std::max(0.0, 1.0 - cc * cc));     // sin(chi) = sqrt(e_ej * inv_energy)
        
        double cc2 = sc;                             // cos(chi2) = sin(chi)
        double sc2 = cc;                             // sin(chi2) = cos(chi)
        
        double eta = TWO_PI * R01(MTgen);
        se = sin(eta);
        ce = cos(eta);
        
        // Azimuthal angle symmetry: eta2 = eta + PI -> sin(eta+PI) = -se, cos(eta+PI) = -ce
        double se2 = -se;
        double ce2 = -ce;
        
        double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
        double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
        double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
        
        x_e[N_e]  = xe;                              // add new electron
        vx_e[N_e] = wx + F2 * gx2;
        vy_e[N_e] = wy + F2 * gy2;
        vz_e[N_e] = wz + F2 * gz2;
        N_e++;
        
        x_i[N_i]  = xe;                              // add new ion
        vx_i[N_i] = RMB(MTgen);                      // velocity is sampled from background thermal distribution
        vy_i[N_i] = RMB(MTgen);
        vz_i[N_i] = RMB(MTgen);
        N_i++;
    }
    
    // scatter the primary electron using precalculated cc, sc, se, ce
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    // post-collision velocity of the colliding electron
    (*vxe) = wx + F2 * gx;
    (*vye) = wy + F2 * gy;
    (*vze) = wz + F2 * gz;
}

PIC_STEP void collision_ion (double *vx_1, double *vy_1, double *vz_1,
                    double *vx_2, double *vy_2, double *vz_2, int e_index){
    double   t1,t2,rnd;
    
    // determine the type of collision based on cross sections
    t1  =      sigma[I_ISO][e_index];
    t2  = t1 + sigma[I_BACK][e_index];
    rnd = R01(MTgen);

    // Fast-path dla wymiany ładunku (I_BACK - wsteczny transfer ładunku, ~80% zderzeń jonowych):
    // Na mocy analitycznej tożsamości kinematycznej dla cząstek o równej masie (m1 = m2 = m_Ar)
    // przy rozproszeniu wstecznym (chi = PI), wektor prędkości względnej ulega dokładnemu odwróceniu:
    // g_new = -g_old = v2 - v1. W układzie laboratoryjnym prędkość nowego jonu wynosi dokładnie:
    // v1_new = w + 0.5 * g_new = 0.5*(v1 + v2) + 0.5*(v2 - v1) = v2 (prędkość atomu gazu tła).
    // Pomijamy 100% obliczeń kątów Eulera, 2x atan2, 8x sin/cos oraz transformację 3D!
    if (rnd * t2 >= t1) {
        (*vx_1) = (*vx_2);
        (*vy_1) = (*vy_2);
        (*vz_1) = (*vz_2);
        return;
    }
    
    // Pozostałe zderzenia (~20%): rozpraszanie izotropowe (I_ISO)
    double   g,gx,gy,gz,wx,wy,wz;
    double   st,ct,sp,cp,sc,cc,se,ce;

    // calculate relative velocity before collision
    // random Maxwellian target atom already selected (vx_2,vy_2,vz_2 velocity components of target atom come with the call)
    gx = (*vx_1)-(*vx_2);
    gy = (*vy_1)-(*vy_2);
    gz = (*vz_1)-(*vz_2);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = 0.5 * ((*vx_1) + (*vx_2));
    wy = 0.5 * ((*vy_1) + (*vy_2));
    wz = 0.5 * ((*vz_1) + (*vz_2));
    
    // Euler angles via vector algebra (eliminates 2x atan2 and 4x sin/cos)
    double g_perp = sqrt(gy * gy + gz * gz);
    if (g > 0.0) {
        double inv_g = 1.0 / g;
        ct = gx * inv_g;
        st = g_perp * inv_g;
    } else {
        ct = 1.0;
        st = 0.0;
    }
    if (g_perp > 0.0) {
        double inv_gp = 1.0 / g_perp;
        cp = gy * inv_gp;
        sp = gz * inv_gp;
    } else {
        cp = 1.0;
        sp = 0.0;
    }
    
    // Isotropic scattering via vector algebra (eliminates acos, sin/cos of chi)
    cc  = 1.0 - 2.0 * R01(MTgen);
    sc  = sqrt(std::max(0.0, 1.0 - cc * cc));
    double eta = TWO_PI * R01(MTgen);
    se  = sin(eta);
    ce  = cos(eta);
    
    // compute new relative velocity
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    // post-collision velocity of the ion
    (*vx_1) = wx + 0.5 * gx;
    (*vy_1) = wy + 0.5 * gy;
    (*vz_1) = wz + 0.5 * gz;
}
