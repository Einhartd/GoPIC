#pragma once

#include "constants.h"
#include <random>
#include <cstdio>
#include <algorithm>
#include <vector>
#include <array>
#include <omp.h>

using namespace std;

// ============================================================================
// Cross Sections & Macroscopic Parameters
// ============================================================================
inline cross_section    sigma[N_CS];         // Set of cross section arrays
inline cross_section    sigma_tot_e;         // Total macroscopic cross section of electrons
inline cross_section    sigma_tot_i;         // Total macroscopic cross section of ions

// ============================================================================
// Particle Coordinates & Counts
// ============================================================================
inline int              N_e = 0;             // Number of active electrons
inline int              N_i = 0;             // Number of active ions
inline particle_vector  x_e, vx_e, vy_e, vz_e;// Electron positions & 3V velocities
inline particle_vector  x_i, vx_i, vy_i, vz_i;// Ion positions & 3V velocities

// ============================================================================
// Grid Quantities (Electric Field, Potential, Densities)
// ============================================================================
inline xvector          efield, pot;         // Electric field and potential on grid
inline xvector          e_density, i_density;// Instantaneous electron and ion densities
inline xvector          cumul_e_density, cumul_i_density; // Time-accumulated densities

// ============================================================================
// Absorption Counters & Energy Distributions
// ============================================================================
inline Ullong           N_e_abs_pow = 0;     // Electrons absorbed at powered electrode
inline Ullong           N_e_abs_gnd = 0;     // Electrons absorbed at grounded electrode
inline Ullong           N_i_abs_pow = 0;     // Ions absorbed at powered electrode
inline Ullong           N_i_abs_gnd = 0;     // Ions absorbed at grounded electrode

inline eepf_vector      eepf     = {0.0};    // Time-integrated EEPF at gap center
inline ifed_vector      ifed_pow = {0};      // IFED at powered electrode
inline ifed_vector      ifed_gnd = {0};      // IFED at grounded electrode
inline double           mean_i_energy_pow;   // Mean ion energy at powered electrode
inline double           mean_i_energy_gnd;   // Mean ion energy at grounded electrode

// ============================================================================
// Spatiotemporal (XT) Diagnostic Arrays
// ============================================================================
inline xt_distr pot_xt                     = {0.0}; // XT distribution of potential
inline xt_distr efield_xt                  = {0.0}; // XT distribution of electric field
inline xt_distr ne_xt                      = {0.0}; // XT distribution of electron density
inline xt_distr ni_xt                      = {0.0}; // XT distribution of ion density
inline xt_distr ue_xt                      = {0.0}; // XT distribution of electron velocity
inline xt_distr ui_xt                      = {0.0}; // XT distribution of ion velocity
inline xt_distr je_xt                      = {0.0}; // XT distribution of electron current
inline xt_distr ji_xt                      = {0.0}; // XT distribution of ion current
inline xt_distr powere_xt                  = {0.0}; // XT distribution of electron power
inline xt_distr poweri_xt                  = {0.0}; // XT distribution of ion power
inline xt_distr meanee_xt                  = {0.0}; // XT distribution of electron energy
inline xt_distr meanei_xt                  = {0.0}; // XT distribution of ion energy
inline xt_distr counter_e_xt               = {0.0}; // XT counter for electrons
inline xt_distr counter_i_xt               = {0.0}; // XT counter for ions
inline xt_distr ioniz_rate_xt              = {0.0}; // XT distribution of ionisation rate

inline double   mean_energy_accu_center    = 0;     // Mean electron energy accumulator (center)
inline Ullong   mean_energy_counter_center = 0;     // Mean electron energy counter (center)
inline Ullong   N_e_coll                   = 0;     // Total electron collisions counter
inline Ullong   N_i_coll                   = 0;     // Total ion collisions counter
inline double   Time;                               // Total simulated physical time
inline int      cycle, no_of_cycles, cycles_done;   // Simulation cycle tracking
inline int      arg1;                               // Command line argument 1
inline char     st0[80];                            // Command line argument string buffer
inline FILE     *datafile;                          // Output data file handle
inline bool     measurement_mode;                   // Measurements & data collection flag

// ============================================================================
// Null-Collision Precomputed Parameters
// ============================================================================
inline double nu_star_e = 0.0;
inline double P_star_e  = 0.0;
inline double nu_star_i = 0.0;
inline double P_star_i  = 0.0;

// ============================================================================
// WorkerBuffers: Pre-allocated thread-local state for zero-allocation OpenMP
// ============================================================================
struct WorkerBuffers {
    // Thread-local density deposition buffers
    std::vector<std::array<double, N_G>> e_density;
    std::vector<std::array<double, N_G>> i_density;

    // Thread-local electron diagnostic buffers
    std::vector<std::array<double, N_G>> counter_e;
    std::vector<std::array<double, N_G>> ue;
    std::vector<std::array<double, N_G>> meanee;
    std::vector<std::array<double, N_G>> ioniz;
    std::vector<std::array<double, N_EEPF>> eepf;
    std::vector<double> accu_center;
    std::vector<Ullong> counter_center;

    // Thread-local ion diagnostic buffers
    std::vector<std::array<double, N_G>> counter_i;
    std::vector<std::array<double, N_G>> ui;
    std::vector<std::array<double, N_G>> meanei;

    // Stream compaction & boundary filtering buffers
    std::vector<int> thread_counts;
    std::vector<int> thread_offsets;
    std::vector<std::vector<int>> thread_local_indices;
    std::vector<Ullong> local_abs_pow;
    std::vector<Ullong> local_abs_gnd;
    std::vector<std::array<int, N_IFED>> local_ifed_pow;
    std::vector<std::array<int, N_IFED>> local_ifed_gnd;

    // Pre-allocated temporary arrays for surviving particles
    std::vector<double> temp_x;
    std::vector<double> temp_vx;
    std::vector<double> temp_vy;
    std::vector<double> temp_vz;

    // Pre-allocated candidate indices for Null-Collision sampling
    std::vector<int> candidates_e;
    std::vector<int> candidates_i;

    void init_buffers(int num_threads) {
        if ((int)e_density.size() >= num_threads) return;

        e_density.resize(num_threads);
        i_density.resize(num_threads);

        counter_e.resize(num_threads);
        ue.resize(num_threads);
        meanee.resize(num_threads);
        ioniz.resize(num_threads);
        eepf.resize(num_threads);
        accu_center.resize(num_threads, 0.0);
        counter_center.resize(num_threads, 0);

        counter_i.resize(num_threads);
        ui.resize(num_threads);
        meanei.resize(num_threads);

        thread_counts.resize(num_threads, 0);
        thread_offsets.resize(num_threads, 0);
        thread_local_indices.resize(num_threads);
        local_abs_pow.resize(num_threads, 0);
        local_abs_gnd.resize(num_threads, 0);
        local_ifed_pow.resize(num_threads);
        local_ifed_gnd.resize(num_threads);

        for (int t = 0; t < num_threads; ++t) {
            thread_local_indices[t].reserve(MAX_N_P / num_threads);
        }

        temp_x.resize(MAX_N_P);
        temp_vx.resize(MAX_N_P);
        temp_vy.resize(MAX_N_P);
        temp_vz.resize(MAX_N_P);

        candidates_e.resize(MAX_N_P);
        candidates_i.resize(MAX_N_P);
    }
};

inline WorkerBuffers worker_buffers;

// ============================================================================
// Thread-Local Random Number Generators
// ============================================================================
inline thread_local std::random_device rd{}; 
inline thread_local std::mt19937 MTgen(rd());
inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
