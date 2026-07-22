#pragma once
#include "state.h"
#include "constants.h"
#include <cmath>

inline void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex){

    double t0,t1,t2,rnd;
    double g,g2,gx,gy,gz,wx,wy,wz,theta,phi;
    double chi,eta,chi2,eta2,sc,cc,se,ce,st,ct,sp,cp,energy,e_sc,e_ej;
    
    // calculate relative velocity before collision & velocity of the centre of mass
    
    gx = (*vxe);
    gy = (*vye);
    gz = (*vze);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = F1 * (*vxe);
    wy = F1 * (*vye);
    wz = F1 * (*vze);
    
    // find Euler angles
    
    if (gx == 0) {theta = 0.5 * PI;}
    else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
    if (gy == 0) {
        if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
    } else {phi = atan2(gz, gy);}
    st  = sin(theta);
    ct  = cos(theta);
    sp  = sin(phi);
    cp  = cos(phi);
    
    // choose the type of collision based on the cross sections
    // take into account energy loss in inelastic collisions
    // generate scattering and azimuth angles
    // in case of ionization handle the 'new' electron
    
    t0   =     sigma[E_ELA][eindex];
    t1   = t0 +sigma[E_EXC][eindex];
    t2   = t1 +sigma[E_ION][eindex];
    rnd  = R01(MTgen);
    if (rnd < (t0/t2)){                              // elastic scattering
        chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
        eta = TWO_PI * R01(MTgen);                   // azimuthal angle
    } else if (rnd < (t1/t2)){                       // excitation
        energy = 0.5 * E_MASS * g * g;               // electron energy
        energy = fabs(energy - E_EXC_TH * EV_TO_J);  // subtract energy loss for excitation
        g   = sqrt(2.0 * energy / E_MASS);           // relative velocity after energy loss
        chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
        eta = TWO_PI * R01(MTgen);                   // azimuthal angle
    } else {                                         // ionization
        energy = 0.5 * E_MASS * g * g;               // electron energy
        energy = fabs(energy - E_ION_TH * EV_TO_J);  // subtract energy loss of ionization
        e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
        e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
        g    = sqrt(2.0 * e_sc / E_MASS);            // relative velocity of scattered electron
        g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
        chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
        chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
        eta  = TWO_PI * R01(MTgen);                  // azimuthal angle for scattered electron
        eta2 = eta + PI;                             // azimuthal angle for ejected electron
        sc  = sin(chi2);
        cc  = cos(chi2);
        se  = sin(eta2);
        ce  = cos(eta2);
        gx  = g2 * (ct * cc - st * sc * ce);
        gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
        gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
        x_e[N_e]  = xe;                              // add new electron
        vx_e[N_e] = wx + F2 * gx;
        vy_e[N_e] = wy + F2 * gy;
        vz_e[N_e] = wz + F2 * gz;
        N_e++;
        x_i[N_i]  = xe;                              // add new ion
        vx_i[N_i] = RMB(MTgen);                      // velocity is sampled from background thermal distribution
        vy_i[N_i] = RMB(MTgen);
        vz_i[N_i] = RMB(MTgen);
        N_i++;
    }
    
    // scatter the primary electron
    
    sc = sin(chi);
    cc = cos(chi);
    se = sin(eta);
    ce = cos(eta);
    
    // compute new relative velocity:
    
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    // post-collision velocity of the colliding electron
    
    (*vxe) = wx + F2 * gx;
    (*vye) = wy + F2 * gy;
    (*vze) = wz + F2 * gz;
}

inline void collision_ion (double *vx_1, double *vy_1, double *vz_1,
                    double *vx_2, double *vy_2, double *vz_2, int e_index){
    double   g,gx,gy,gz,wx,wy,wz,rnd;
    double   theta,phi,chi,eta,st,ct,sp,cp,sc,cc,se,ce,t1,t2;
    
    // calculate relative velocity before collision
    // random Maxwellian target atom already selected (vx_2,vy_2,vz_2 velocity components of target atom come with the call)
    
    gx = (*vx_1)-(*vx_2);
    gy = (*vy_1)-(*vy_2);
    gz = (*vz_1)-(*vz_2);
    g  = sqrt(gx * gx + gy * gy + gz * gz);
    wx = 0.5 * ((*vx_1) + (*vx_2));
    wy = 0.5 * ((*vy_1) + (*vy_2));
    wz = 0.5 * ((*vz_1) + (*vz_2));
    
    // find Euler angles
    
    if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
    if (gy == 0) {
        if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
    } else {phi = atan2(gz, gy);}
    
    // determine the type of collision based on cross sections and generate scattering angle
    
    t1  =      sigma[I_ISO][e_index];
    t2  = t1 + sigma[I_BACK][e_index];
    rnd = R01(MTgen);
    if  (rnd < (t1 /t2)){                        // isotropic scattering
        chi = acos(1.0 - 2.0 * R01(MTgen));      // scattering angle
    } else {                                     // backward scattering
        chi = PI;                                // scattering angle
    }
    eta = TWO_PI * R01(MTgen);                   // azimuthal angle
    sc  = sin(chi);
    cc  = cos(chi);
    se  = sin(eta);
    ce  = cos(eta);
    st  = sin(theta);
    ct  = cos(theta);
    sp  = sin(phi);
    cp  = cos(phi);
    
    // compute new relative velocity
    
    gx = g * (ct * cc - st * sc * ce);
    gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
    gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
    
    // post-collision velocity of the ion
    
    (*vx_1) = wx + 0.5 * gx;
    (*vy_1) = wy + 0.5 * gy;
    (*vz_1) = wz + 0.5 * gz;
}
