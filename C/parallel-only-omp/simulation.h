#pragma once
#include "state.h"
#include "poisson.h"
#include "collisions.h"
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


    // move all electrons in every time step
    #pragma omp parallel for reduction(+:mean_energy_accu_center, mean_energy_counter_center)
    for(int k=0; k<N_e; k++){
        int p, energy_index;
        double c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate;

        //  Interpolacja pola E na pozycje elektronu
        c0  = x_e[k] * INV_DX;
        p   = int(c0);
        c1  = p + 1.0 - c0;
        c2  = c0 - p;
        e_x = c1 * efield[p] + c2 * efield[p+1];
    
        //  Diagnostyki
        if (measurement_mode) {
            
            // measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
            mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
            
            #pragma omp atomic
            counter_e_xt[p][t_index]   += c1;
            #pragma omp atomic
            counter_e_xt[p+1][t_index] += c2;
            
            #pragma omp atomic
            ue_xt[p][t_index]   += c1 * mean_v;
            #pragma omp atomic
            ue_xt[p+1][t_index] += c2 * mean_v;

            v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
            energy = 0.5 * E_MASS * v_sqr / EV_TO_J;

            #pragma omp atomic
            meanee_xt[p][t_index]   += c1 * energy;
            #pragma omp atomic
            meanee_xt[p+1][t_index] += c2 * energy;

            energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
            velocity = sqrt(v_sqr);
            rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;

            #pragma omp atomic
            ioniz_rate_xt[p][t_index]   += c1 * rate;
            #pragma omp atomic
            ioniz_rate_xt[p+1][t_index] += c2 * rate;

            // measure EEPF in the center
            if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
                energy_index = (int)(energy / DE_EEPF);
                if (energy_index < N_EEPF) {
                    #pragma omp atomic
                    eepf[energy_index] += 1.0;
                }
                mean_energy_accu_center += energy;
                mean_energy_counter_center++;
            }
        }
        
        // update velocity and position
        vx_e[k] -= e_x * FACTOR_E;
        x_e[k]  += vx_e[k] * DT_E;
    }
}

inline void step4_move_ions(int t_index, int t){
    if ((t % N_SUB) != 0) return;

    #pragma omp parallel for
    for(int k=0; k<N_i; k++){
        int p;
        double c0, c1, c2, e_x, mean_v, v_sqr, energy;

        c0  = x_i[k] * INV_DX;
        p   = int(c0);
        c1  = p + 1 - c0;
        c2  = c0 - p;
        e_x = c1 * efield[p] + c2 * efield[p+1];
    
        if (measurement_mode) {
            // measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
            mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
            #pragma omp atomic
            counter_i_xt[p][t_index]   += c1;
            #pragma omp atomic
            counter_i_xt[p+1][t_index] += c2;

            #pragma omp atomic
            ui_xt[p][t_index]   += c1 * mean_v;
            #pragma omp atomic
            ui_xt[p+1][t_index] += c2 * mean_v;

            v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;

            #pragma omp atomic
            meanei_xt[p][t_index]   += c1 * energy;
            #pragma omp atomic
            meanei_xt[p+1][t_index] += c2 * energy;
        }
    
        // update velocity and position and accumulate absorbed energy
        vx_i[k] += e_x * FACTOR_I;
        x_i[k]  += vx_i[k] * DT_I;
    }
}

inline void step5_check_boundaries_electrons(){

    int num_threads = omp_get_max_threads();
    static std::vector<int> thread_counts;
    static std::vector<int> thread_offsets;
    static std::vector<std::vector<int>> thread_local_indices;

    static std::vector<double> temp_x_e;
    static std::vector<double> temp_vx_e;
    static std::vector<double> temp_vy_e;
    static std::vector<double> temp_vz_e;

    if (thread_counts.size() < (size_t)num_threads) {
        thread_counts.resize(num_threads, 0);
        thread_offsets.resize(num_threads, 0);
        thread_local_indices.resize(num_threads);
    }
    for (int t = 0; t < num_threads; ++t) {
        thread_local_indices[t].clear();
        thread_counts[t] = 0;
        thread_offsets[t] = 0;
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
                #pragma omp atomic
                N_e_abs_pow++;
            } else if (x_e[k] > L) {
                #pragma omp atomic
                N_e_abs_gnd++;
            } else {
                thread_local_indices[tid].push_back(k);
            }
        }
        //  Zapis ocalalej czastki
        thread_counts[tid] = thread_local_indices[tid].size();
    }

    int total_survived = 0;
    for (int t = 0; t < num_threads; ++t) {
        thread_offsets[t] = total_survived;
        total_survived += thread_counts[t];
    }

    temp_x_e.resize(total_survived);
    temp_vx_e.resize(total_survived);
    temp_vy_e.resize(total_survived);
    temp_vz_e.resize(total_survived);

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int write_idx = thread_offsets[tid];
        for (int idx : thread_local_indices[tid]) {
            temp_x_e[write_idx]     =   x_e[idx];
            temp_vx_e[write_idx]    =   vx_e[idx];
            temp_vy_e[write_idx]    =   vy_e[idx];
            temp_vz_e[write_idx]    =   vz_e[idx];
            write_idx++;
        }
    }

    N_e = total_survived;
    std::copy(temp_x_e.begin(), temp_x_e.end(), x_e);
    std::copy(temp_vx_e.begin(), temp_vx_e.end(), vx_e);
    std::copy(temp_vy_e.begin(), temp_vy_e.end(), vy_e);
    std::copy(temp_vz_e.begin(), temp_vz_e.end(), vz_e);
}

inline void step6_check_boundaries_ions(int t){
    if ((t % N_SUB) != 0) return;

    int num_threads = omp_get_max_threads();
    static std::vector<int> thread_counts;
    static std::vector<int> thread_offsets;
    static std::vector<std::vector<int>> thread_local_indices;

    static std::vector<double> temp_x_i;
    static std::vector<double> temp_vx_i;
    static std::vector<double> temp_vy_i;
    static std::vector<double> temp_vz_i;

    if (thread_counts.size() < (size_t)num_threads) {
        thread_counts.resize(num_threads, 0);
        thread_offsets.resize(num_threads, 0);
        thread_local_indices.resize(num_threads);
    }
    for (int t = 0; t < num_threads; ++t) {
        thread_local_indices[t].clear();
        thread_counts[t] = 0;
        thread_offsets[t] = 0;
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
                #pragma omp atomic
                N_i_abs_pow++;
                v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
                energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
                energy_index = (int)(energy / DE_IFED);
                if (energy_index < N_IFED) {
                    #pragma omp atomic
                    ifed_pow[energy_index]++;
                }
            } else if (x_i[k] > L) {
                #pragma omp atomic
                N_i_abs_gnd++;
                v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
                energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
                energy_index = (int)(energy / DE_IFED);
                if (energy_index < N_IFED) {
                    #pragma omp atomic
                    ifed_gnd[energy_index]++;
                }
            } else {
                thread_local_indices[tid].push_back(k);
            }
        }
        //  Zapis ocalalej czastki
        thread_counts[tid] = thread_local_indices[tid].size();
    }

    int total_survived = 0;
    for (int t = 0; t < num_threads; ++t) {
        thread_offsets[t] = total_survived;
        total_survived += thread_counts[t];
    }

    temp_x_i.resize(total_survived);
    temp_vx_i.resize(total_survived);
    temp_vy_i.resize(total_survived);
    temp_vz_i.resize(total_survived);

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int write_idx = thread_offsets[tid];
        for (int idx : thread_local_indices[tid]) {
            temp_x_i[write_idx]     =   x_i[idx];
            temp_vx_i[write_idx]    =   vx_i[idx];
            temp_vy_i[write_idx]    =   vy_i[idx];
            temp_vz_i[write_idx]    =   vz_i[idx];
            write_idx++;
        }
    }

    N_i = total_survived;
    std::copy(temp_x_i.begin(), temp_x_i.end(), x_i);
    std::copy(temp_vx_i.begin(), temp_vx_i.end(), vx_i);
    std::copy(temp_vy_i.begin(), temp_vy_i.end(), vy_i);
    std::copy(temp_vz_i.begin(), temp_vz_i.end(), vz_i);
}

inline void step7_collisions_electrons(){

    //  deklaracje buforow
    int num_threads = omp_get_max_threads();
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
        std::vector<int> candidates_e;
        random_sample(N_e, N_coll_star_e, candidates_e);

        #pragma omp parallel
        {
            int tid = omp_get_thread_num();
            
            #pragma omp for
            for (size_t i = 0; i < candidates_e.size(); ++i) {
                int ki = candidates_e[i];

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
        // checking for occurrence of a collision for all electrons in every time step
        #pragma omp for
        for (k=0; k<N_e; k++){
            v_sqr = vx_e[k] * vx_e[k] + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
            velocity = sqrt(v_sqr);
            energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
            energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
            nu = sigma_tot_e[energy_index] * velocity;
            // collision probability for electrons
            p_coll = 1 - exp(- nu * DT_E);
            // electron collision takes place
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

#ifdef USE_NULL_COLLISION
    std::binomial_distribution<int> binom_i(N_i, P_star_i);
    int N_coll_star_i = binom_i(MTgen);
    if (N_coll_star_i > N_i) N_coll_star_i = N_i;
    
    if (N_coll_star_i > 0) {
        std::vector<int> candidates_i;
        random_sample(N_i, N_coll_star_i, candidates_i);
        
        #pragma omp parallel
        {
            double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy;
            int energy_index;

            #pragma omp for
            for (size_t i = 0; i < candidates_i.size(); ++i) {
                int ki = candidates_i[i];

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
            // pick velocity components of a random target gas atom
            vx_a = RMB(MTgen);
            vy_a = RMB(MTgen);
            vz_a = RMB(MTgen);
            // compute the relative velocity of the collision partners
            gx   = vx_i[k] - vx_a;
            gy   = vy_i[k] - vy_a;
            gz   = vz_i[k] - vz_a;
            g_sqr = gx * gx + gy * gy + gz * gz;
            g = sqrt(g_sqr);
            energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
            energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
            nu = sigma_tot_i[energy_index] * g;
            // collision probability for ions
            p_coll = 1 - exp(- nu * DT_I);
            // ion collision takes place
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
