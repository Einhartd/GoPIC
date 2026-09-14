#pragma once
#include "state.h"
#include "poisson.h"
#include "null_collision.h"
#include "collisions.h"
#include <cmath>

inline void init(int nseed){
    int i;
    
    for (i=0; i<nseed; i++){
        x_e[i]  = L * R01(MTgen);               // initial random position of the electron
        vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // initial velocity components of the electron
        x_i[i]  = L * R01(MTgen);               // initial random position of the ion
        vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
    }
    N_e = nseed;    // initial number of electrons
    N_i = nseed;    // initial number of ions
}

PIC_STEP void step1_compute_electron_density(double factor_w){
    int k, p;
    double c0;

    // step 1a: compute electron density at grid points - computed in every time step
    for(p=0; p<N_G; p++) e_density[p] = 0;

    for(k=0; k<N_e; k++){
        c0 = x_e[k] * INV_DX;
        p  = int(c0);
        double c2 = c0 - p;
        double w2 = c2 * factor_w;
        e_density[p]   += (factor_w - w2);
        e_density[p+1] += w2;
    }
    e_density[0]     *= 2.0;
    e_density[N_G-1] *= 2.0;
    for(p=0; p<N_G; p++) cumul_e_density[p] += e_density[p];
}

PIC_STEP void step1_compute_ion_density(int t, double factor_w){    
    int k, p;
    double c0;

    if ((t % N_SUB) == 0) {                                            // ion density - computed in every N_SUB-th time steps (subcycling)
        for(p=0; p<N_G; p++) i_density[p] = 0;
        for(k=0; k<N_i; k++){
            c0 = x_i[k] * INV_DX;
            p  = int(c0);
            double c2 = c0 - p;
            double w2 = c2 * factor_w;
            i_density[p]   += (factor_w - w2);  
            i_density[p+1] += w2;
        }
        i_density[0]     *= 2.0;
        i_density[N_G-1] *= 2.0;
    }
    for(p=0; p<N_G; p++) cumul_i_density[p] += i_density[p];
}

PIC_STEP void step2_solve_poisson(double current_time){
    // step 2: solve Poisson equation
    solve_Poisson(current_time);                            // compute potential and electric field
}

PIC_STEP void step3_move_electrons(int t_index, double factor_e, double min_x, double max_x){
    if (__builtin_expect(!measurement_mode, 1)) {
        // Fast-path dla krokow produkcyjnych (4-way unrolling + FMA)
        int k = 0;
        int k_unroll_end = (N_e / 4) * 4;

        #pragma GCC ivdep
        for (; k < k_unroll_end; k += 4) {
            double x0 = x_e[k+0], x1 = x_e[k+1], x2 = x_e[k+2], x3 = x_e[k+3];
            double v0 = vx_e[k+0], v1 = vx_e[k+1], v2 = vx_e[k+2], v3 = vx_e[k+3];

            double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
            int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
            double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;

            double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
            double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
            double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
            double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);

            double vn0 = v0 - ex0 * factor_e;
            double vn1 = v1 - ex1 * factor_e;
            double vn2 = v2 - ex2 * factor_e;
            double vn3 = v3 - ex3 * factor_e;

            vx_e[k+0] = vn0; vx_e[k+1] = vn1; vx_e[k+2] = vn2; vx_e[k+3] = vn3;
            x_e[k+0] = x0 + vn0 * DT_E;
            x_e[k+1] = x1 + vn1 * DT_E;
            x_e[k+2] = x2 + vn2 * DT_E;
            x_e[k+3] = x3 + vn3 * DT_E;
        }

        for (; k < N_e; k++) {
            double c0  = x_e[k] * INV_DX;
            int p      = int(c0);
            double c2  = c0 - p;
            double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
            double v   = vx_e[k] - e_x * factor_e;
            vx_e[k]    = v;
            x_e[k]    += v * DT_E;
        }
    } else {
        int k, p, energy_index;
        double c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate;

        for(k=0; k<N_e; k++){                       // move all electrons in every time step
            c0  = x_e[k] * INV_DX;
            p   = int(c0);
            c2  = c0 - p;
            c1  = 1.0 - c2;
            e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
        
            // measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
            mean_v = vx_e[k] - 0.5 * e_x * factor_e;
            counter_e_xt[p][t_index]   += c1;
            counter_e_xt[p+1][t_index] += c2;
            ue_xt[p][t_index]   += c1 * mean_v;
            ue_xt[p+1][t_index] += c2 * mean_v;
            v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
            energy = 0.5 * E_MASS * v_sqr * INV_EV_TO_J;
            meanee_xt[p][t_index]   += c1 * energy;
            meanee_xt[p+1][t_index] += c2 * energy;
            energy_index = min( int(v_sqr * FACTOR_ENERGY_E + 0.5), CS_RANGES-1);
            velocity = sqrt(v_sqr);
            rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
            ioniz_rate_xt[p][t_index]   += c1 * rate;
            ioniz_rate_xt[p+1][t_index] += c2 * rate;

            // measure EEPF in the center
            if ((min_x < x_e[k]) && (x_e[k] < max_x)){
                energy_index = (int)(energy * INV_DE_EEPF);
                if (energy_index < N_EEPF) {eepf[energy_index] += 1.0;}
                mean_energy_accu_center += energy;
                mean_energy_counter_center++;
            }
            
            // update velocity and position
            vx_e[k] -= e_x * factor_e;
            x_e[k]  += vx_e[k] * DT_E;
        }
    }
}

PIC_STEP void step4_move_ions(int t_index, int t, double factor_i){
    if ((t % N_SUB) != 0) return;

    if (__builtin_expect(!measurement_mode, 1)) {
        // Fast-path dla jonow bez diagnostyki (4-way unrolling + FMA)
        int k = 0;
        int k_unroll_end = (N_i / 4) * 4;

        #pragma GCC ivdep
        for (; k < k_unroll_end; k += 4) {
            double x0 = x_i[k+0], x1 = x_i[k+1], x2 = x_i[k+2], x3 = x_i[k+3];
            double v0 = vx_i[k+0], v1 = vx_i[k+1], v2 = vx_i[k+2], v3 = vx_i[k+3];

            double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
            int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
            double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;

            double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
            double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
            double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
            double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);

            double vn0 = v0 + ex0 * factor_i;
            double vn1 = v1 + ex1 * factor_i;
            double vn2 = v2 + ex2 * factor_i;
            double vn3 = v3 + ex3 * factor_i;

            vx_i[k+0] = vn0; vx_i[k+1] = vn1; vx_i[k+2] = vn2; vx_i[k+3] = vn3;
            x_i[k+0] = x0 + vn0 * DT_I;
            x_i[k+1] = x1 + vn1 * DT_I;
            x_i[k+2] = x2 + vn2 * DT_I;
            x_i[k+3] = x3 + vn3 * DT_I;
        }

        for (; k < N_i; k++) {
            double c0  = x_i[k] * INV_DX;
            int p      = int(c0);
            double c2  = c0 - p;
            double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
            double v   = vx_i[k] + e_x * factor_i;
            vx_i[k]    = v;
            x_i[k]    += v * DT_I;
        }
    } else {
        int k, p;
        double c0, c1, c2, e_x, mean_v, v_sqr, energy;

        for(k=0; k<N_i; k++){
            c0  = x_i[k] * INV_DX;
            p   = int(c0);
            c2  = c0 - p;
            c1  = 1.0 - c2;
            e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
        
            // measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
            mean_v = vx_i[k] + 0.5 * e_x * factor_i;
            counter_i_xt[p][t_index]   += c1;
            counter_i_xt[p+1][t_index] += c2;
            ui_xt[p][t_index]   += c1 * mean_v;
            ui_xt[p+1][t_index] += c2 * mean_v;
            v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            energy = 0.5 * AR_MASS * v_sqr * INV_EV_TO_J;
            meanei_xt[p][t_index]   += c1 * energy;
            meanei_xt[p+1][t_index] += c2 * energy;
        
            // update velocity and position
            vx_i[k] += e_x * factor_i;
            x_i[k]  += vx_i[k] * DT_I;
        }
    }
}

PIC_STEP void step5_check_boundaries_electrons(){
    static std::vector<int> dead_e;
    dead_e.clear();

    for (int k = 0; k < N_e; k++) {
        if (__builtin_expect(x_e[k] < 0.0, 0)) {
            dead_e.push_back(k);
            N_e_abs_pow++;
        } else if (__builtin_expect(x_e[k] > L, 0)) {
            dead_e.push_back(k);
            N_e_abs_gnd++;
        }
    }

    if (!dead_e.empty()) {
        int last_valid = N_e - 1;
        for (int dead_idx : dead_e) {
            while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
                last_valid--;
            }
            if (last_valid > dead_idx) {
                x_e[dead_idx]  = x_e[last_valid];
                vx_e[dead_idx] = vx_e[last_valid];
                vy_e[dead_idx] = vy_e[last_valid];
                vz_e[dead_idx] = vz_e[last_valid];
                last_valid--;
            }
        }
        N_e -= dead_e.size();
    }
}

PIC_STEP void step6_check_boundaries_ions(int t){
    if ((t % N_SUB) != 0) return;

    static std::vector<int> dead_i;
    dead_i.clear();

    for (int k = 0; k < N_i; k++) {
        if (__builtin_expect(x_i[k] < 0.0, 0)) {
            dead_i.push_back(k);
            N_i_abs_pow++;
            double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            int energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
            if (energy_index < N_IFED) ifed_pow[energy_index]++;
        } else if (__builtin_expect(x_i[k] > L, 0)) {
            dead_i.push_back(k);
            N_i_abs_gnd++;
            double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            int energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
            if (energy_index < N_IFED) ifed_gnd[energy_index]++;
        }
    }

    if (!dead_i.empty()) {
        int last_valid = N_i - 1;
        for (int dead_idx : dead_i) {
            while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
                last_valid--;
            }
            if (last_valid > dead_idx) {
                x_i[dead_idx]  = x_i[last_valid];
                vx_i[dead_idx] = vx_i[last_valid];
                vy_i[dead_idx] = vy_i[last_valid];
                vz_i[dead_idx] = vz_i[last_valid];
                last_valid--;
            }
        }
        N_i -= dead_i.size();
    }
}

PIC_STEP void step7_collisions_electrons(){
    std::binomial_distribution<int> binom_e(N_e, P_star_e);
    int N_coll_star_e = binom_e(MTgen);
    if (N_coll_star_e > N_e) N_coll_star_e = N_e;

    if (N_coll_star_e > 0) {
        std::vector<int> candidates_e;
        random_sample(N_e, N_coll_star_e, candidates_e);

        for (int ki : candidates_e){
            double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
            double velocity = sqrt(v_sqr);
            int energy_index = min(int(v_sqr * FACTOR_ENERGY_E + 0.5), CS_RANGES - 1);
            
            double real_nu = sigma_tot_e[energy_index] * velocity;
            double p_accept = real_nu * inv_nu_star_e;
            if (p_accept > 1.0) p_accept = 1.0;
            
            if (R01(MTgen) < p_accept) {
                collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index);
                N_e_coll++;
            }
        }
    }
}

PIC_STEP void step8_collision_ions(int t){
    if ((t % N_SUB) != 0) return;

    std::binomial_distribution<int> binom_i(N_i, P_star_i);
    int N_coll_star_i = binom_i(MTgen);
    if (N_coll_star_i > N_i) N_coll_star_i = N_i;
    
    if (N_coll_star_i > 0) {
        std::vector<int> candidates_i;
        random_sample(N_i, N_coll_star_i, candidates_i);
        
        double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g;
        int energy_index;
        for (int ki : candidates_i) {
            vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
            gx = vx_i[ki] - vx_a;
            gy = vy_i[ki] - vy_a;
            gz = vz_i[ki] - vz_a;
            g_sqr = gx*gx + gy*gy + gz*gz;
            g = sqrt(g_sqr);
            energy_index = min(int(g_sqr * FACTOR_ENERGY_I + 0.5), CS_RANGES - 1);
            
            double real_nu = sigma_tot_i[energy_index] * g;
            double p_accept = real_nu * inv_nu_star_i;
            if (p_accept > 1.0) p_accept = 1.0;
            
            if (R01(MTgen) < p_accept) {
                collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
                N_i_coll++;
            }
        }
    }
}

PIC_STEP void step9_collect_xt_data(int t_index){
    if(!measurement_mode) return;

    for (int p = 0; p < N_G; p++){
        pot_xt   [p][t_index] += pot[p];
        efield_xt[p][t_index] += efield[p];
        ne_xt    [p][t_index] += e_density[p];
        ni_xt    [p][t_index] += i_density[p];
    }
}

PIC_STEP void do_one_cycle (void){
    int      t;
    int      t_index;
    
    for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
        Time += DT_E;               // update of the total simulated time
        t_index = t / N_BIN;        // index for XT distributions        

        step1_compute_electron_density(FACTOR_W);
        step1_compute_ion_density(t, FACTOR_W);
        step2_solve_poisson(Time);

        step3_move_electrons(t_index, FACTOR_E, MIN_X, MAX_X);
        step4_move_ions(t_index, t, FACTOR_I);

        step5_check_boundaries_electrons();
        step6_check_boundaries_ions(t);
        
        step7_collisions_electrons();
        step8_collision_ions(t);

        step9_collect_xt_data(t_index);
        
        if ((t % 1000) == 0){
            printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", cycle,t,N_e,N_i);
        } 
    }
    fprintf(datafile,"%8d  %8d  %8d\n",cycle,N_e,N_i);
}
