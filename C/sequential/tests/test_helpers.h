#pragma once

#include "../collisions.h"
#include "../constants.h"
#include "../cross_sections.h"
#include "../io_manager.h"
#include "../poisson.h"
#include "../simulation.h"
#include "../state.h"
#include <algorithm>
#include <fstream>
#include <cstdio>
#include <cstring>
#include <cstdlib>

inline void reset_state() {
    N_e = 0; N_i = 0;
    N_e_abs_pow = 0; N_e_abs_gnd = 0;
    N_i_abs_pow = 0; N_i_abs_gnd = 0;
    N_e_coll = 0;    N_i_coll = 0;
    Time = 0.0;
    measurement_mode = false;
    for (int i = 0; i < N_G; i++) {
        e_density[i] = 0.0; i_density[i] = 0.0;
        cumul_e_density[i] = 0.0; cumul_i_density[i] = 0.0;
        efield[i] = 0.0; pot[i] = 0.0;
    }
    std::fill(std::begin(eepf),     std::end(eepf),     0.0);
    std::fill(std::begin(ifed_pow), std::end(ifed_pow), 0);
    std::fill(std::begin(ifed_gnd), std::end(ifed_gnd), 0);
}

inline void seed_rng(uint64_t seed = 67) {
    MTgen.seed(seed);
}

inline void save_rng_state() {
    std::ofstream f("rng_state.bin");
    if (!f) {
        printf(">> eduPIC_reg: ERROR: cannot write rng_state.bin\n");
        exit(1);
    }
    f << MTgen;
}

inline void load_rng_state() {
    std::ifstream f("rng_state.bin");
    if (!f) {
        printf(">> eduPIC_reg: ERROR: rng_state.bin not found — run with '0' first\n");
        exit(1);
    }
    f >> MTgen;
}