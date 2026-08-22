#pragma once

#include <math.h>
#include <vector>
#include <numeric>
#include <algorithm>

#include "state.h"
#include "cross_sections.h"


inline void compute_null_collision_params() {
    // elektrony
    nu_star_e = max_electron_coll_freq();
    P_star_e = 1.0 - exp(-nu_star_e * DT_E);

    // jony
    nu_star_i = max_ion_coll_freq();
    P_star_i = 1.0 - exp(-nu_star_i * DT_I);

    printf(">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n", nu_star_e, P_star_e);
    printf(">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n", nu_star_i, P_star_i);
}

// losuje 'count' unikalnych indeksow z zakresu [0, n) i zapisuje je
// bezposrednio do lokalnego bufora danego watku.
PIC_STEP void random_sample(int n, int count, std::vector<int> &buffer) {
    if (buffer.size() < (size_t)n) {
        buffer.resize(n);
    }

    std::iota(buffer.begin(), buffer.begin() + n, 0);

    for (int i = 0; i < count; i++) {
        int j = i + (int)(R01(MTgen) * (n - i));
        std::swap(buffer[i], buffer[j]);
    }
}