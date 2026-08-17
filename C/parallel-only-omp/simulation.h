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

// Simulation Initialization
inline void init(int nseed) {
    for (int i = 0; i < nseed; i++) {
        x_e[i]  = L * R01(MTgen);               // Initial electron position
        vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // Initial electron 3V velocity
        x_i[i]  = L * R01(MTgen);               // Initial ion position
        vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Initial ion 3V velocity
    }
    N_e = nseed;    // Initial electron count
    N_i = nseed;    // Initial ion count
}

// -----------------------------------------------------------------------------
// OpenMP optimization pattern used throughout this file:
//  1) each thread works on its own local buffers (worker_buffers.e_density[tid],
//     worker_buffers.counter_e[tid], ...)
//  2) after the parallel work, one phase aggregates the local results into shared
//     arrays (e_density, efield, ifed_pow, etc.)
//  3) barriers/single blocks are used only at points where global consistency is
//     required (e.g. before merging, boundary removal, or updating the global state)
//
// Why this matters:
// - avoids a lot of expensive atomic updates to shared arrays;
// - reduces contention on cache lines and memory;
// - keeps the parallel work local and the serial merge compact.
//
// OpenMP directives used here:
// - #pragma omp parallel       : start a team of threads
// - #pragma omp for            : split a loop over iterations between threads
// - #pragma omp for nowait     : same as for, but threads do not wait immediately
// - #pragma omp barrier        : all threads wait until everyone reaches this point
// - #pragma omp single         : only one thread executes this block
// - #pragma omp atomic         : protect a single shared variable update
// -----------------------------------------------------------------------------

// STEP 1a: Compute Electron Charge Density (Scatter-Add / Deposition)
inline void step1_compute_electron_density_body(int tid, int num_threads) {
    // Every thread owns its own local density buffer.
    // This is the key OMP optimization: no two threads write to the same array cell.
    worker_buffers.e_density[tid].fill(0.0);

    int p;
    double c0;
    // #pragma omp for nowait:
    // - split the particle loop over threads,
    // - each thread processes only its chunk of particles,
    // - no immediate wait: threads can continue to the reduction phase once done.
    #pragma omp for simd nowait
    for (int k = 0; k < N_e; k++) {
        c0 = x_e[k] * INV_DX;
        p  = int(c0);
        worker_buffers.e_density[tid][p]   += (p + 1 - c0) * FACTOR_W;
        worker_buffers.e_density[tid][p+1] += (c0 - p) * FACTOR_W;
    }

    // All threads must finish the local deposition before a global reduction starts.
    #pragma omp barrier

    // Reduce all thread-local densities into one global grid field.
    // This is a classic "local work + reduction" pattern in parallel PIC.
    #pragma omp for schedule(static)
    for (int p = 0; p < N_G; p++) {
        double sum = 0.0;
        for (int t = 0; t < num_threads; t++) {
            sum += worker_buffers.e_density[t][p];
        }
        e_density[p] = sum;
    }

    // This block is executed only once, not by every thread.
    #pragma omp single
    {
        e_density[0]     *= 2.0;
        e_density[N_G-1] *= 2.0;
    }

    // Accumulate the time-integrated electron density for diagnostics.
    #pragma omp for schedule(static)
    for (int p = 0; p < N_G; p++) cumul_e_density[p] += e_density[p];
}

inline void step1_compute_electron_density(void) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step1_compute_electron_density_body(tid, nthreads);
    }
}

// STEP 1b: Compute Ion Charge Density (Subcycled)
inline void step1_compute_ion_density_body(int tid, int num_threads, int t) {
    if ((t % N_SUB) == 0) {
        // Ion density is updated less frequently than electron density.
        // The local-deposition + reduction pattern is identical to electrons,
        // but only on subcycled ion steps.
        worker_buffers.i_density[tid].fill(0.0);

        int p;
        double c0;
        #pragma omp for simd nowait
        for (int k = 0; k < N_i; k++) {
            c0 = x_i[k] * INV_DX;
            p  = int(c0);
            worker_buffers.i_density[tid][p]   += (p + 1 - c0) * FACTOR_W;
            worker_buffers.i_density[tid][p+1] += (c0 - p) * FACTOR_W;
        }

        #pragma omp barrier

        #pragma omp for schedule(static)
        for (int p = 0; p < N_G; p++) {
            double sum = 0.0;
            for (int t2 = 0; t2 < num_threads; t2++) {
                sum += worker_buffers.i_density[t2][p];
            }
            i_density[p] = sum;
        }

        #pragma omp single
        {
            i_density[0]     *= 2.0;
            i_density[N_G-1] *= 2.0;
        }
    }

    // This reduction is done for the cumulative ion density history.
    #pragma omp for schedule(static)
    for (int p = 0; p < N_G; p++) cumul_i_density[p] += i_density[p];
}

inline void step1_compute_ion_density(int t) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step1_compute_ion_density_body(tid, nthreads, t);
    }
}

// STEP 2: Solve Poisson Equation (1D Field Solver)
inline void step2_solve_poisson(double current_time) {
    xvector rho;
    for (int p = 0; p < N_G; p++) {
        rho[p] = E_CHARGE * (i_density[p] - e_density[p]);
    }
    solve_Poisson(rho, Time);
}

// STEP 3: Push Electrons & Accumulate Diagnostics
inline void step3_move_electrons_body(int tid, int num_threads, int t_index) {
    if (measurement_mode) {
        // Reset the local diagnostic buffers for this thread before it starts processing particles.
        // This keeps all thread-local statistics independent and avoids writing into shared arrays.
        worker_buffers.counter_e[tid].fill(0.0);
        worker_buffers.ue[tid].fill(0.0);
        worker_buffers.meanee[tid].fill(0.0);
        worker_buffers.ioniz[tid].fill(0.0);
        worker_buffers.eepf[tid].fill(0.0);
        worker_buffers.thread_counters[tid].accu_center   = 0.0;
        worker_buffers.thread_counters[tid].counter_center = 0;
    }

    int p, energy_index;
    double c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate;

    // Parallel particle push. Each thread advances a subset of electrons.
    // The local diagnostics are accumulated into worker_buffers.<...>[tid].
    #pragma omp for nowait
    for (int k = 0; k < N_e; k++) {
        c0  = x_e[k] * INV_DX;
        p   = int(c0);
        c1  = p + 1.0 - c0;
        c2  = c0 - p;
        e_x = c1 * efield[p] + c2 * efield[p+1];

        if (measurement_mode) {
            mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;

            // Local density / velocity / energy accumulation for this thread only.
            worker_buffers.counter_e[tid][p]   += c1;
            worker_buffers.counter_e[tid][p+1] += c2;

            worker_buffers.ue[tid][p]   += c1 * mean_v;
            worker_buffers.ue[tid][p+1] += c2 * mean_v;

            v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
            energy = 0.5 * E_MASS * v_sqr / EV_TO_J;

            worker_buffers.meanee[tid][p]   += c1 * energy;
            worker_buffers.meanee[tid][p+1] += c2 * energy;

            energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
            velocity = sqrt(v_sqr);
            rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;

            worker_buffers.ioniz[tid][p]   += c1 * rate;
            worker_buffers.ioniz[tid][p+1] += c2 * rate;

            if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
                energy_index = (int)(energy / DE_EEPF);
                if (energy_index < N_EEPF) {
                    worker_buffers.eepf[tid][energy_index] += 1.0;
                }
                worker_buffers.thread_counters[tid].accu_center   += energy;
                worker_buffers.thread_counters[tid].counter_center++;
            }
        }

        vx_e[k] -= e_x * FACTOR_E;
        x_e[k]  += vx_e[k] * DT_E;
    }

    // Now all threads have finished their local particle updates.
    // The next phase merges the thread-local arrays into the shared XT/diagnostic arrays.
    #pragma omp barrier

    if (measurement_mode) {
        // Merge all local density-like diagnostics into the global arrays.
        #pragma omp for nowait schedule(static)
        for (int p = 0; p < N_G; p++) {
            double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
            for (int t = 0; t < num_threads; t++) {
                c_e += worker_buffers.counter_e[t][p];
                u_e += worker_buffers.ue[t][p];
                m_e += worker_buffers.meanee[t][p];
                iz  += worker_buffers.ioniz[t][p];
            }
            counter_e_xt[p][t_index]   += c_e;
            ue_xt[p][t_index]          += u_e;
            meanee_xt[p][t_index]      += m_e;
            ioniz_rate_xt[p][t_index]  += iz;
        }

        // Merge the EEPF bins accumulated by all threads.
        #pragma omp for schedule(static)
        for (int i = 0; i < N_EEPF; i++) {
            double sum_eepf = 0.0;
            for (int t = 0; t < num_threads; t++) {
                sum_eepf += worker_buffers.eepf[t][i];
            }
            eepf[i] += sum_eepf;
        }

        // Only one thread sums the per-thread energy accumulators into the global counters.
        #pragma omp single
        {
            for (int t = 0; t < num_threads; t++) {
                mean_energy_accu_center    += worker_buffers.thread_counters[t].accu_center;
                mean_energy_counter_center += worker_buffers.thread_counters[t].counter_center;
            }
        }
    }
}

inline void step3_move_electrons(int t_index) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step3_move_electrons_body(tid, nthreads, t_index);
    }
}

// STEP 4: Push Ions & Accumulate Diagnostics (Subcycled)
inline void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
    if ((t % N_SUB) != 0) return;

    if (measurement_mode) {
        worker_buffers.counter_i[tid].fill(0.0);
        worker_buffers.ui[tid].fill(0.0);
        worker_buffers.meanei[tid].fill(0.0);
    }

    int p;
    double c0, c1, c2, e_x, mean_v, v_sqr, energy;

    #pragma omp for nowait
    for (int k = 0; k < N_i; k++) {
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

    #pragma omp barrier

    if (measurement_mode) {
        #pragma omp for schedule(static)
        for (int p = 0; p < N_G; p++) {
            double c_i = 0.0, u_i = 0.0, m_i = 0.0;
            for (int t2 = 0; t2 < num_threads; t2++) {
                c_i += worker_buffers.counter_i[t2][p];
                u_i += worker_buffers.ui[t2][p];
                m_i += worker_buffers.meanei[t2][p];
            }
            counter_i_xt[p][t_index] += c_i;
            ui_xt[p][t_index]        += u_i;
            meanei_xt[p][t_index]    += m_i;
        }
    }
}

inline void step4_move_ions(int t_index, int t) {
    if ((t % N_SUB) != 0) return;
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step4_move_ions_body(tid, nthreads, t_index, t);
    }
}

// STEP 5: Electron Boundary Checks (Parallel Flag + Serial Swap)
inline void step5_check_boundaries_electrons_body(int tid, int num_threads) {
    // The absorbed[] flag array is shared because it holds the state of each particle,
    // but it is initialized only once in the single block.
    static std::vector<uint8_t> absorbed;
    #pragma omp single
    {
        if (absorbed.size() < (size_t)MAX_N_P) absorbed.resize(MAX_N_P, 0);
    }

    // Local counters are used here to avoid a race on the global absorption totals.
    worker_buffers.thread_counters[tid].local_abs_pow = 0;
    worker_buffers.thread_counters[tid].local_abs_gnd = 0;

    Ullong local_pow = 0, local_gnd = 0;

    // Each thread scans a subset of the electron array and marks absorbed particles.
    // This is safe because each thread writes only to its own local counts and to the
    // already-private absorbed[k] positions corresponding to the particle subset.
    #pragma omp for
    for (int k = 0; k < N_e; k++) {
        if (x_e[k] < 0) {
            absorbed[k] = 1;
            local_pow++;
        } else if (x_e[k] > L) {
            absorbed[k] = 2;
            local_gnd++;
        } else {
            absorbed[k] = 0;
        }
    }

    worker_buffers.thread_counters[tid].local_abs_pow = local_pow;
    worker_buffers.thread_counters[tid].local_abs_gnd = local_gnd;

    #pragma omp barrier

    // The actual particle compaction is serial because it rewrites the arrays in-place.
    // This is one of the natural serial bottlenecks in the PIC loop.
    #pragma omp single
    {
        for (int t = 0; t < num_threads; t++) {
            N_e_abs_pow += worker_buffers.thread_counters[t].local_abs_pow;
            N_e_abs_gnd += worker_buffers.thread_counters[t].local_abs_gnd;
        }

        int k = 0;
        while (k < N_e) {
            if (absorbed[k]) {
                N_e--;
                x_e[k]  = x_e[N_e];   vx_e[k] = vx_e[N_e];
                vy_e[k] = vy_e[N_e];  vz_e[k] = vz_e[N_e];
                absorbed[k] = absorbed[N_e];
            } else {
                k++;
            }
        }
    }
}

inline void step5_check_boundaries_electrons() {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step5_check_boundaries_electrons_body(tid, nthreads);
    }
}

// STEP 6: Ion Boundary Checks (Parallel Flag + Serial Swap, Subcycled)
inline void step6_check_boundaries_ions_body(int tid, int num_threads, int t) {
    if ((t % N_SUB) != 0) return;

    static std::vector<uint8_t> absorbed;
    #pragma omp single
    {
        if (absorbed.size() < (size_t)MAX_N_P) absorbed.resize(MAX_N_P, 0);
    }

    worker_buffers.thread_counters[tid].local_abs_pow = 0;
    worker_buffers.thread_counters[tid].local_abs_gnd = 0;
    worker_buffers.local_ifed_pow[tid].fill(0);
    worker_buffers.local_ifed_gnd[tid].fill(0);

    Ullong local_pow = 0, local_gnd = 0;

    #pragma omp for
    for (int k = 0; k < N_i; k++) {
        if (x_i[k] < 0) {
            absorbed[k] = 1;
            local_pow++;
            double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            double energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
            int energy_index = (int)(energy / DE_IFED);
            if (energy_index < N_IFED) {
                worker_buffers.local_ifed_pow[tid][energy_index]++;
            }
        } else if (x_i[k] > L) {
            absorbed[k] = 2;
            local_gnd++;
            double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
            double energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
            int energy_index = (int)(energy / DE_IFED);
            if (energy_index < N_IFED) {
                worker_buffers.local_ifed_gnd[tid][energy_index]++;
            }
        } else {
            absorbed[k] = 0;
        }
    }

    worker_buffers.thread_counters[tid].local_abs_pow = local_pow;
    worker_buffers.thread_counters[tid].local_abs_gnd = local_gnd;

    #pragma omp barrier

    #pragma omp single
    {
        for (int t2 = 0; t2 < num_threads; ++t2) {
            N_i_abs_pow += worker_buffers.thread_counters[t2].local_abs_pow;
            N_i_abs_gnd += worker_buffers.thread_counters[t2].local_abs_gnd;
            for (int e = 0; e < N_IFED; ++e) {
                ifed_pow[e] += worker_buffers.local_ifed_pow[t2][e];
                ifed_gnd[e] += worker_buffers.local_ifed_gnd[t2][e];
            }
        }

        int k = 0;
        while (k < N_i) {
            if (absorbed[k]) {
                N_i--;
                x_i[k]  = x_i[N_i];   vx_i[k] = vx_i[N_i];
                vy_i[k] = vy_i[N_i];  vz_i[k] = vz_i[N_i];
                absorbed[k] = absorbed[N_i];
            } else {
                k++;
            }
        }
    }
}

inline void step6_check_boundaries_ions(int t) {
    if ((t % N_SUB) != 0) return;
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step6_check_boundaries_ions_body(tid, nthreads, t);
    }
}

// STEP 7: Electron Collisions & Ionization
inline void step7_collisions_electrons_body(int tid, int num_threads) {
    // Each thread owns its own temporary lists of newly created particles.
    // This avoids concurrent writes to a single global list of "new particles".
    static std::vector<NewParticles> new_electrons;
    static std::vector<NewParticles> new_ions;

    #pragma omp single
    {
        if (new_electrons.size() < (size_t)num_threads) {
            new_electrons.resize(num_threads);
            new_ions.resize(num_threads);
        }
    }

    // Clear the per-thread result buffers before reusing them.
    new_electrons[tid].x.clear();
    new_electrons[tid].vx.clear();
    new_electrons[tid].vy.clear();
    new_electrons[tid].vz.clear();
    new_ions[tid].x.clear();
    new_ions[tid].vx.clear();
    new_ions[tid].vy.clear();
    new_ions[tid].vz.clear();

#ifdef USE_NULL_COLLISION
    // Each thread owns its own candidate list. This removes shared mutable state
    // from the null-collision sampling path and avoids serializing the candidate
    // generation step.
    int local_N_coll_star_e = 0;
    auto &candidates_e_tid = worker_buffers.candidates_e[tid];

    {
        std::binomial_distribution<int> binom_e(N_e, P_star_e);
        local_N_coll_star_e = binom_e(MTgen);
        if (local_N_coll_star_e > N_e) local_N_coll_star_e = N_e;
        if (local_N_coll_star_e > 0) {
            random_sample(N_e, local_N_coll_star_e, candidates_e_tid);
        }
    }

    if (local_N_coll_star_e > 0) {
        for (int i = 0; i < local_N_coll_star_e; ++i) {
            int ki = candidates_e_tid[i];

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
#else
    // Standard direct collision sampling. Each thread checks its subset of electrons.
    int k, energy_index;
    double v_sqr, velocity, energy, nu, p_coll;
    #pragma omp for
    for (k = 0; k < N_e; k++) {
        v_sqr = vx_e[k] * vx_e[k] + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
        velocity = sqrt(v_sqr);
        energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
        energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
        nu = sigma_tot_e[energy_index] * velocity;
        p_coll = 1 - exp(- nu * DT_E);
        if (R01(MTgen) < p_coll) {
            collision_electron(x_e[k], &vx_e[k], &vy_e[k], &vz_e[k], energy_index,
                                new_electrons[tid], new_ions[tid]);
            #pragma omp atomic
            N_e_coll++;
        }
    }
#endif

    // Finally, merge all per-thread created particles back into the global arrays.
    // This is a serial finalization step: it adjusts the shared particle count N_e / N_i.
    #pragma omp single
    {
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
}

inline void step7_collisions_electrons() {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step7_collisions_electrons_body(tid, nthreads);
    }
}

// STEP 8: Ion Collisions (Subcycled)
inline void step8_collision_ions_body(int tid, int num_threads, int t) {
    if ((t % N_SUB) != 0) return;

#ifdef USE_NULL_COLLISION
    int local_N_coll_star_i = 0;
    auto &candidates_i_tid = worker_buffers.candidates_i[tid];

    {
        std::binomial_distribution<int> binom_i(N_i, P_star_i);
        local_N_coll_star_i = binom_i(MTgen);
        if (local_N_coll_star_i > N_i) local_N_coll_star_i = N_i;
        if (local_N_coll_star_i > 0) {
            random_sample(N_i, local_N_coll_star_i, candidates_i_tid);
        }
    }
    
    if (local_N_coll_star_i > 0) {
        double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy;
        int energy_index;

        for (int i = 0; i < local_N_coll_star_i; ++i) {
            int ki = candidates_i_tid[i];

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
#else
    int k, energy_index;
    double vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy, nu, p_coll;
    #pragma omp for
    for (k = 0; k < N_i; k++) {
        vx_a = RMB(MTgen);
        vy_a = RMB(MTgen);
        vz_a = RMB(MTgen);
        gx   = vx_i[k] - vx_a;
        gy   = vy_i[k] - vy_a;
        gz   = vz_i[k] - vz_a;
        g_sqr = gx * gx + gy * gy + gz * gz;
        g = sqrt(g_sqr);
        energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
        energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
        nu = sigma_tot_i[energy_index] * g;
        p_coll = 1 - exp(- nu * DT_I);
        if (R01(MTgen) < p_coll) {
            collision_ion(&vx_i[k], &vy_i[k], &vz_i[k], &vx_a, &vy_a, &vz_a, energy_index);
            #pragma omp atomic
            N_i_coll++;
        }
    }
#endif
}

inline void step8_collision_ions(int t) {
    if ((t % N_SUB) != 0) return;
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();
        step8_collision_ions_body(tid, nthreads, t);
    }
}

// STEP 9: Collect XT Diagnostic Arrays
inline void step9_collect_xt_data(int t_index) {
    if (!measurement_mode) return;

    for (int p = 0; p < N_G; p++) {
        pot_xt   [p][t_index] += pot[p];
        efield_xt[p][t_index] += efield[p];
        ne_xt    [p][t_index] += e_density[p];
        ni_xt    [p][t_index] += i_density[p];
    }
}

// Main Time Loop (RF Cycle Executor with Persistent Parallel Region)
inline void do_one_cycle(void) {
    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    // One persistent OpenMP region is created for the whole cycle.
    // This avoids repeated thread startup/shutdown overhead for each PIC step.
    // -- To jest punkt startowy, gdzie tworzone sa watki, ktore potem pracuja
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();

        for (int t = 0; t < N_T; t++) {
            // Time is updated once per step, but it is a shared global value.
            #pragma omp single
            {
                Time += DT_E;
            }

            int t_index = t / N_BIN;

            // Local deposition + reduction for electron and ion densities.
            step1_compute_electron_density_body(tid, nthreads);
            step1_compute_ion_density_body(tid, nthreads, t);

            // Poisson solve is inherently global and therefore executed in a single block.
            #pragma omp single
            {
                step2_solve_poisson(Time);
            }

            // Particle push and local diagnostics are parallelized per thread.
            step3_move_electrons_body(tid, nthreads, t_index);
            step4_move_ions_body(tid, nthreads, t_index, t);

            // Boundary handling is partly parallelized, but the final compaction is serial.
            step5_check_boundaries_electrons_body(tid, nthreads);
            step6_check_boundaries_ions_body(tid, nthreads, t);

            // Collision processing is parallelized per particle subset, but also creates
            // per-thread temporary particles that are merged later.
            step7_collisions_electrons_body(tid, nthreads);
            step8_collision_ions_body(tid, nthreads, t);

            // XT diagnostic collection and periodic prints are global operations.
            #pragma omp single
            {
                step9_collect_xt_data(t_index);
                if ((t % 1000) == 0) {
                    printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", cycle, t, N_e, N_i);
                }
            }
        }
    }
    fprintf(datafile, "%8d  %8d  %8d\n", cycle, N_e, N_i);
}
