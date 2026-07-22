#pragma once
#include "state.h"
#include "poisson.h"
#include "collisions.h"
#include <array>
#include <cmath>
#include <omp.h>

#ifdef USE_NULL_COLLISION
#include "null_collision.h"
#endif

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

inline void step1_compute_electron_density(void){
    int k, p;
    double c0;

    //  Zerowanie tablicy gestosci
    for(p=0; p<N_G; p++) e_density[p] = 0;

    //  Depozycja: kazdy elektron dodaje ladunek do dwoch sasiednich wezlow
    #pragma omp parallel for reduction(+:e_density[0:N_G]) private(k, p, c0)
    for(k=0; k<N_e; k++){
        c0 = x_e[k] * INV_DX;
        p  = int(c0);
        e_density[p]   += (p + 1 - c0) * FACTOR_W;
        e_density[p+1] += (c0 - p) * FACTOR_W;
    }
    //  Korekcja brzegowa
    e_density[0]     *= 2.0;
    e_density[N_G-1] *= 2.0;

    //  Akumulacja dla usredniania
    for(p=0; p<N_G; p++) cumul_e_density[p] += e_density[p];
}

inline void step1_compute_ion_density(int t){    
    int k, p;
    double c0;
    // ion density - computed in every N_SUB-th time steps (subcycling)
    if ((t % N_SUB) == 0) {
        for(p=0; p<N_G; p++) i_density[p] = 0;

        #pragma omp parallel for reduction(+:i_density[0:N_G]) private(k, p, c0)
        for(k=0; k<N_i; k++){
            c0 = x_i[k] * INV_DX;
            p  = int(c0);
            i_density[p]   += (p + 1 - c0) * FACTOR_W;  
            i_density[p+1] += (c0 - p) * FACTOR_W;
        }

        i_density[0]     *= 2.0;
        i_density[N_G-1] *= 2.0;
    }

    for(p=0; p<N_G; p++) cumul_i_density[p] += i_density[p];
}

inline void step2_solve_poisson(double current_time){
    xvector rho;
    // step 2: solve Poisson equation
    for(int p=0; p<N_G; p++){
        rho[p] = E_CHARGE * (i_density[p] - e_density[p]);  // get charge density
    }
    // compute potential and electric field
    solve_Poisson(rho,Time);
}

inline void step3_move_electrons(int t_index){
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();

        worker_buffers.counter_e[tid].fill(0.0);
        worker_buffers.ue[tid].fill(0.0);
        worker_buffers.meanee[tid].fill(0.0);
        worker_buffers.ioniz[tid].fill(0.0);
        worker_buffers.eepf[tid].fill(0.0);
        worker_buffers.accu_center[tid]   = 0.0;
        worker_buffers.counter_center[tid] = 0;

        int p, energy_index;
        double c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate;

        #pragma omp for nowait
        for(int k=0; k<N_e; k++){
            c0  = x_e[k] * INV_DX;
            p   = int(c0);
            c1  = p + 1.0 - c0;
            c2  = c0 - p;
            e_x = c1 * efield[p] + c2 * efield[p+1];

            if (measurement_mode) {
                mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;

                worker_buffers.counter_e[tid][p]   += c1;
                worker_buffers.counter_e[tid][p+1] += c2;

                worker_buffers.ue[tid][p]   += c1 * mean_v;
                worker_buffers.ue[tid][p+1] += c2 * mean_v;

                v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
                energy = 0.5 * E_MASS * v_sqr / EV_TO_J;

                worker_buffers.meanee[tid][p]   += c1 * energy;
                worker_buffers.meanee[tid][p+1] += c2 * energy;

                energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
                velocity = sqrt(v_sqr);
                rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;

                worker_buffers.ioniz[tid][p]   += c1 * rate;
                worker_buffers.ioniz[tid][p+1] += c2 * rate;

                if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
                    energy_index = (int)(energy / DE_EEPF);
                    if (energy_index < N_EEPF) {
                        worker_buffers.eepf[tid][energy_index] += 1.0;
                    }
                    worker_buffers.accu_center[tid]   += energy;
                    worker_buffers.counter_center[tid]++;
                }
            }

            vx_e[k] -= e_x * FACTOR_E;
            x_e[k]  += vx_e[k] * DT_E;
        }
    }

    if (measurement_mode) {
        for (int t = 0; t < num_threads; t++) {
            for (int p = 0; p < N_G; p++) {
                counter_e_xt[p][t_index]   += worker_buffers.counter_e[t][p];
                ue_xt[p][t_index]          += worker_buffers.ue[t][p];
                meanee_xt[p][t_index]      += worker_buffers.meanee[t][p];
                ioniz_rate_xt[p][t_index]  += worker_buffers.ioniz[t][p];
            }
            for (int i = 0; i < N_EEPF; i++) {
                eepf[i] += worker_buffers.eepf[t][i];
            }
            mean_energy_accu_center    += worker_buffers.accu_center[t];
            mean_energy_counter_center += worker_buffers.counter_center[t];
        }
    }
}

inline void step4_move_ions(int t_index, int t){
    if ((t % N_SUB) != 0) return;

    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();

        worker_buffers.counter_i[tid].fill(0.0);
        worker_buffers.ui[tid].fill(0.0);
        worker_buffers.meanei[tid].fill(0.0);

        int p;
        double c0, c1, c2, e_x, mean_v, v_sqr, energy;

        #pragma omp for nowait
        for(int k=0; k<N_i; k++){
            c0  = x_i[k] * INV_DX;
            p   = int(c0);
            c1  = p + 1 - c0;
            c2  = c0 - p;
            e_x = c1 * efield[p] + c2 * efield[p+1];

            if (measurement_mode) {
                mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;

                worker_buffers.counter_i[tid][p]   += c1;
                worker_buffers.counter_i[tid][p+1] += c2;

                worker_buffers.ui[tid][p]   += c1 * mean_v;
                worker_buffers.ui[tid][p+1] += c2 * mean_v;

                v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
                energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;

                worker_buffers.meanei[tid][p]   += c1 * energy;
                worker_buffers.meanei[tid][p+1] += c2 * energy;
            }

            vx_i[k] += e_x * FACTOR_I;
            x_i[k]  += vx_i[k] * DT_I;
        }
    }

    if (measurement_mode) {
        for (int t2 = 0; t2 < num_threads; t2++) {
            for (int p = 0; p < N_G; p++) {
                counter_i_xt[p][t_index] += worker_buffers.counter_i[t2][p];
                ui_xt[p][t_index]        += worker_buffers.ui[t2][p];
                meanei_xt[p][t_index]    += worker_buffers.meanei[t2][p];
            }
        }
    }
}

inline void step5_check_boundaries_electrons(){
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    for (int t = 0; t < num_threads; ++t) {
        worker_buffers.thread_local_indices[t].clear();
        worker_buffers.thread_counts[t] = 0;
        worker_buffers.thread_offsets[t] = 0;
        worker_buffers.local_abs_pow[t] = 0;
        worker_buffers.local_abs_gnd[t] = 0;
    }

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int n_threads = omp_get_num_threads();

        int chunk_size = N_e / n_threads;
        int start = tid * chunk_size;
        int end = (tid == n_threads - 1) ? N_e : start + chunk_size;

        for (int k = start; k < end; ++k) {
            if (x_e[k] < 0) {
                worker_buffers.local_abs_pow[tid]++;
            } else if (x_e[k] > L) {
                worker_buffers.local_abs_gnd[tid]++;
            } else {
                worker_buffers.thread_local_indices[tid].push_back(k);
            }
        }
        worker_buffers.thread_counts[tid] = worker_buffers.thread_local_indices[tid].size();
    }

    int total_survived = 0;
    for (int t = 0; t < num_threads; ++t) {
        worker_buffers.thread_offsets[t] = total_survived;
        total_survived += worker_buffers.thread_counts[t];
        N_e_abs_pow += worker_buffers.local_abs_pow[t];
        N_e_abs_gnd += worker_buffers.local_abs_gnd[t];
    }

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int write_idx = worker_buffers.thread_offsets[tid];
        for (int idx : worker_buffers.thread_local_indices[tid]) {
            worker_buffers.temp_x[write_idx]  = x_e[idx];
            worker_buffers.temp_vx[write_idx] = vx_e[idx];
            worker_buffers.temp_vy[write_idx] = vy_e[idx];
            worker_buffers.temp_vz[write_idx] = vz_e[idx];
            write_idx++;
        }
    }

    N_e = total_survived;
    std::copy(worker_buffers.temp_x.begin(), worker_buffers.temp_x.begin() + total_survived, x_e);
    std::copy(worker_buffers.temp_vx.begin(), worker_buffers.temp_vx.begin() + total_survived, vx_e);
    std::copy(worker_buffers.temp_vy.begin(), worker_buffers.temp_vy.begin() + total_survived, vy_e);
    std::copy(worker_buffers.temp_vz.begin(), worker_buffers.temp_vz.begin() + total_survived, vz_e);
}

inline void step6_check_boundaries_ions(int t){
    if ((t % N_SUB) != 0) return;

    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    for (int t = 0; t < num_threads; ++t) {
        worker_buffers.thread_local_indices[t].clear();
        worker_buffers.thread_counts[t] = 0;
        worker_buffers.thread_offsets[t] = 0;
        worker_buffers.local_abs_pow[t] = 0;
        worker_buffers.local_abs_gnd[t] = 0;
        worker_buffers.local_ifed_pow[t].fill(0);
        worker_buffers.local_ifed_gnd[t].fill(0);
    }

    #pragma omp parallel
    {
        double v_sqr, energy;
        int energy_index;

        int tid = omp_get_thread_num();
        int n_threads = omp_get_num_threads();

        int chunk_size = N_i / n_threads;
        int start = tid * chunk_size;
        int end = (tid == n_threads - 1) ? N_i : start + chunk_size;

        for (int k = start; k < end; ++k) {
            if (x_i[k] < 0) {
                worker_buffers.local_abs_pow[tid]++;
                v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
                energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
                energy_index = (int)(energy / DE_IFED);
                if (energy_index < N_IFED) {
                    worker_buffers.local_ifed_pow[tid][energy_index]++;
                }
            } else if (x_i[k] > L) {
                worker_buffers.local_abs_gnd[tid]++;
                v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
                energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
                energy_index = (int)(energy / DE_IFED);
                if (energy_index < N_IFED) {
                    worker_buffers.local_ifed_gnd[tid][energy_index]++;
                }
            } else {
                worker_buffers.thread_local_indices[tid].push_back(k);
            }
        }
        worker_buffers.thread_counts[tid] = worker_buffers.thread_local_indices[tid].size();
    }

    int total_survived = 0;
    for (int t = 0; t < num_threads; ++t) {
        worker_buffers.thread_offsets[t] = total_survived;
        total_survived += worker_buffers.thread_counts[t];
        N_i_abs_pow += worker_buffers.local_abs_pow[t];
        N_i_abs_gnd += worker_buffers.local_abs_gnd[t];
        for (int e = 0; e < N_IFED; ++e) {
            ifed_pow[e] += worker_buffers.local_ifed_pow[t][e];
            ifed_gnd[e] += worker_buffers.local_ifed_gnd[t][e];
        }
    }

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int write_idx = worker_buffers.thread_offsets[tid];
        for (int idx : worker_buffers.thread_local_indices[tid]) {
            worker_buffers.temp_x[write_idx]  = x_i[idx];
            worker_buffers.temp_vx[write_idx] = vx_i[idx];
            worker_buffers.temp_vy[write_idx] = vy_i[idx];
            worker_buffers.temp_vz[write_idx] = vz_i[idx];
            write_idx++;
        }
    }

    N_i = total_survived;
    std::copy(worker_buffers.temp_x.begin(), worker_buffers.temp_x.begin() + total_survived, x_i);
    std::copy(worker_buffers.temp_vx.begin(), worker_buffers.temp_vx.begin() + total_survived, vx_i);
    std::copy(worker_buffers.temp_vy.begin(), worker_buffers.temp_vy.begin() + total_survived, vy_i);
    std::copy(worker_buffers.temp_vz.begin(), worker_buffers.temp_vz.begin() + total_survived, vz_i);
}

inline void step7_collisions_electrons(){
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    static std::vector<NewParticles> new_electrons;
    static std::vector<NewParticles> new_ions;

    if (new_electrons.size() < (size_t)num_threads) {
        new_electrons.resize(num_threads);
        new_ions.resize(num_threads);
    }
    for (int t = 0; t < num_threads; ++t) {
        new_electrons[t].x.clear();
        new_electrons[t].vx.clear();
        new_electrons[t].vy.clear();
        new_electrons[t].vz.clear();
        new_ions[t].x.clear();
        new_ions[t].vx.clear();
        new_ions[t].vy.clear();
        new_ions[t].vz.clear();
    }

#ifdef USE_NULL_COLLISION
    std::binomial_distribution<int> binom_e(N_e, P_star_e);
    int N_coll_star_e = binom_e(MTgen);
    if (N_coll_star_e > N_e) N_coll_star_e = N_e;
    
    if (N_coll_star_e > 0) {
        random_sample(N_e, N_coll_star_e, worker_buffers.candidates_e);

        #pragma omp parallel
        {
            int tid = omp_get_thread_num();
            
            #pragma omp for
            for (int i = 0; i < N_coll_star_e; ++i) {
                int ki = worker_buffers.candidates_e[i];

                double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
                double velocity = sqrt(v_sqr);
                double energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
                int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
                
                double real_nu = sigma_tot_e[energy_index] * velocity;
                double p_accept = real_nu / nu_star_e;
                if (p_accept > 1.0) p_accept = 1.0;
                
                if (R01(MTgen) < p_accept) {
                    collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
                                        new_electrons[tid], new_ions[tid]);
                    #pragma omp atomic
                    N_e_coll++;
                }
            }
        }
    }
#else
    #pragma omp parallel
    {
        int k, energy_index;
        double v_sqr, velocity, energy, nu, p_coll;
        int tid = omp_get_thread_num();
        #pragma omp for
        for (k=0; k<N_e; k++){
            v_sqr = vx_e[k] * vx_e[k] + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
            velocity = sqrt(v_sqr);
            energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
            energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
            nu = sigma_tot_e[energy_index] * velocity;
            p_coll = 1 - exp(- nu * DT_E);
            if (R01(MTgen) < p_coll) {
                collision_electron(x_e[k], &vx_e[k], &vy_e[k], &vz_e[k], energy_index,
                                    new_electrons[tid], new_ions[tid]);
                #pragma omp atomic
                N_e_coll++;
            }
        }
    }
#endif

    for (int t = 0; t < num_threads; ++t) {
        for (size_t i = 0; i < new_electrons[t].x.size(); ++i) {
            x_e[N_e]    = new_electrons[t].x[i];
            vx_e[N_e]   = new_electrons[t].vx[i];
            vy_e[N_e]   = new_electrons[t].vy[i];
            vz_e[N_e]   = new_electrons[t].vz[i];
            N_e++;
        }
        for (size_t i = 0; i < new_ions[t].x.size(); ++i) {
            x_i[N_i]    = new_ions[t].x[i];
            vx_i[N_i]   = new_ions[t].vx[i];
            vy_i[N_i]   = new_ions[t].vy[i];
            vz_i[N_i]   = new_ions[t].vz[i];
            N_i++;   
        }
    }
}

inline void step8_collision_ions(int t){
    if ((t % N_SUB) != 0) return;

    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

#ifdef USE_NULL_COLLISION
    std::binomial_distribution<int> binom_i(N_i, P_star_i);
    int N_coll_star_i = binom_i(MTgen);
    if (N_coll_star_i > N_i) N_coll_star_i = N_i;
    
    if (N_coll_star_i > 0) {
        random_sample(N_i, N_coll_star_i, worker_buffers.candidates_i);
        
        #pragma omp parallel
        {
            double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy;
            int energy_index;

            #pragma omp for
            for (int i = 0; i < N_coll_star_i; ++i) {
                int ki = worker_buffers.candidates_i[i];

                vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
                gx = vx_i[ki] - vx_a;
                gy = vy_i[ki] - vy_a;
                gz = vz_i[ki] - vz_a;
                g_sqr = gx*gx + gy*gy + gz*gz;
                g = sqrt(g_sqr);
                energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
                energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
                
                double real_nu = sigma_tot_i[energy_index] * g;
                double p_accept = real_nu / nu_star_i;
                if (p_accept > 1.0) p_accept = 1.0;
                
                if (R01(MTgen) < p_accept) {
                    collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
                    #pragma omp atomic
                    N_i_coll++;
                }
            }
        }
    }
#else
    #pragma omp parallel
    {
        int k, energy_index;
        double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy, nu, p_coll;
        #pragma omp for
        for (k=0; k<N_i; k++){
            vx_a = RMB(MTgen);
            vy_a = RMB(MTgen);
            vz_a = RMB(MTgen);
            gx   = vx_i[k] - vx_a;
            gy   = vy_i[k] - vy_a;
            gz   = vz_i[k] - vz_a;
            g_sqr = gx * gx + gy * gy + gz * gz;
            g = sqrt(g_sqr);
            energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
            energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
            nu = sigma_tot_i[energy_index] * g;
            p_coll = 1 - exp(- nu * DT_I);
            if (R01(MTgen)< p_coll) {
                collision_ion(&vx_i[k], &vy_i[k], &vz_i[k], &vx_a, &vy_a, &vz_a, energy_index);
                #pragma omp atomic
                N_i_coll++;
            }
        }
    }
#endif
}

inline void step9_collect_xt_data(int t_index){
    if(!measurement_mode) return;

    for (int p = 0; p < N_G; p++){
        pot_xt   [p][t_index] += pot[p];
        efield_xt[p][t_index] += efield[p];
        ne_xt    [p][t_index] += e_density[p];
        ni_xt    [p][t_index] += i_density[p];
    }
}

inline void do_one_cycle (void){
    int      t;
    int      t_index;
    
    for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
        Time += DT_E;               // update of the total simulated time
        t_index = t / N_BIN;        // index for XT distributions        

        step1_compute_electron_density();
        step1_compute_ion_density(t);
        step2_solve_poisson(Time);

        step3_move_electrons(t_index);
        step4_move_ions(t_index, t);

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
