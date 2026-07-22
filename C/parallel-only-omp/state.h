#pragma once
#include "constants.h"
#include <random>
#include <cstdio>
#include <algorithm>
using namespace std;

inline cross_section    sigma[N_CS];                                 // set of cross section arrays
inline cross_section    sigma_tot_e;                                 // total macroscopic cross section of electrons
inline cross_section    sigma_tot_i;                                 // total macroscopic cross section of ions

inline int              N_e = 0;                                     // number of electrons
inline int              N_i = 0;                                     // number of ions
inline particle_vector  x_e, vx_e, vy_e, vz_e;                       // coordinates of electrons (one spatial, three velocity components)
inline particle_vector  x_i, vx_i, vy_i, vz_i;                       // coordinates of ions (one spatial, three velocity components)

inline xvector          efield, pot;                                 // electric field and potential
inline xvector          e_density, i_density;                        // electron and ion densities
inline xvector          cumul_e_density, cumul_i_density;            // cumulative densities

inline Ullong       N_e_abs_pow  = 0;                                // counter for electrons absorbed at the powered electrode
inline Ullong       N_e_abs_gnd  = 0;                                // counter for electrons absorbed at the grounded electrode
inline Ullong       N_i_abs_pow  = 0;                                // counter for ions absorbed at the powered electrode
inline Ullong       N_i_abs_gnd  = 0;                                // counter for ions absorbed at the grounded electrode

inline eepf_vector eepf     = {0.0};                                 // time integrated EEPF in the center of the plasma

inline ifed_vector  ifed_pow = {0};                                 // IFED at the powered electrode
inline ifed_vector  ifed_gnd = {0};                                 // IFED at the grounded electrode
inline double       mean_i_energy_pow;                              // mean ion energy at the powered electrode
inline double       mean_i_energy_gnd;                              // mean ion energy at the grounded electrode

inline xt_distr pot_xt                     = {0.0};                 // XT distribution of the potential
inline xt_distr efield_xt                  = {0.0};                 // XT distribution of the electric field
inline xt_distr ne_xt                      = {0.0};                 // XT distribution of the electron density
inline xt_distr ni_xt                      = {0.0};                 // XT distribution of the ion density
inline xt_distr ue_xt                      = {0.0};                 // XT distribution of the mean electron velocity
inline xt_distr ui_xt                      = {0.0};                 // XT distribution of the mean ion velocity
inline xt_distr je_xt                      = {0.0};                 // XT distribution of the electron current density
inline xt_distr ji_xt                      = {0.0};                 // XT distribution of the ion current density
inline xt_distr powere_xt                  = {0.0};                 // XT distribution of the electron powering (power absorption) rate
inline xt_distr poweri_xt                  = {0.0};                 // XT distribution of the ion powering (power absorption) rate
inline xt_distr meanee_xt                  = {0.0};                 // XT distribution of the mean electron energy
inline xt_distr meanei_xt                  = {0.0};                 // XT distribution of the mean ion energy
inline xt_distr counter_e_xt               = {0.0};                 // XT counter for electron properties
inline xt_distr counter_i_xt               = {0.0};                 // XT counter for ion properties
inline xt_distr ioniz_rate_xt              = {0.0};                 // XT distribution of the ionisation rate

inline double   mean_energy_accu_center    = 0;                     // mean electron energy accumulator in the center of the gap
inline Ullong   mean_energy_counter_center = 0;                     // mean electron energy counter in the center of the gap
inline Ullong   N_e_coll                   = 0;                     // counter for electron collisions
inline Ullong   N_i_coll                   = 0;                     // counter for ion collisions
inline double   Time;                                               // total simulated time (from the beginning of the simulation)
inline int      cycle, no_of_cycles, cycles_done;                   // current cycle and total cycles in the run, cycles completed
inline int      arg1;                                               // used for reading command line arguments
inline char     st0[80];                                            // used for reading command line arguments
inline FILE     *datafile;                                          // used for saving data
inline bool     measurement_mode;                                   // flag that controls measurements and data saving

// null-collision precomputed parameters
inline double nu_star_e = 0.0;
inline double P_star_e  = 0.0;
inline double nu_star_i = 0.0;
inline double P_star_i  = 0.0;

#include <vector>
#include <array>
#include <omp.h>

struct WorkerBuffers {
    std::vector<std::array<double, N_G>> e_density;
    std::vector<std::array<double, N_G>> i_density;

    std::vector<std::array<double, N_G>> counter_e;
    std::vector<std::array<double, N_G>> ue;
    std::vector<std::array<double, N_G>> meanee;
    std::vector<std::array<double, N_G>> ioniz;
    std::vector<std::array<double, N_EEPF>> eepf;
    std::vector<double> accu_center;
    std::vector<Ullong> counter_center;

    std::vector<std::array<double, N_G>> counter_i;
    std::vector<std::array<double, N_G>> ui;
    std::vector<std::array<double, N_G>> meanei;

    std::vector<int> thread_counts;
    std::vector<int> thread_offsets;
    std::vector<std::vector<int>> thread_local_indices;
    std::vector<Ullong> local_abs_pow;
    std::vector<Ullong> local_abs_gnd;
    std::vector<std::array<int, N_IFED>> local_ifed_pow;
    std::vector<std::array<int, N_IFED>> local_ifed_gnd;

    std::vector<double> temp_x;
    std::vector<double> temp_vx;
    std::vector<double> temp_vy;
    std::vector<double> temp_vz;

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

inline thread_local std::random_device rd{}; 
inline thread_local std::mt19937 MTgen(rd());
inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));

