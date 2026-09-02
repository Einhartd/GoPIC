#pragma once

#include <math.h>
#include <vector>
#include <numeric>
#include <algorithm>

#include "state.h"
#include "cross_sections.h"


/*
Obliczanie parametrów metody zderzeń zerowych (Null-Collision).
Wyznacza maksymalną częstość zderzeń nu* oraz maksymalne prawdopodobieństwo zderzenia P*
dla elektronów (w kroku DT_E) oraz jonów (w kroku subcyclingu DT_I).
*/
inline void compute_null_collision_params(void) {
    // Parametry dla elektronów
    nu_star_e = max_electron_coll_freq();
    P_star_e = 1.0 - exp(-nu_star_e * DT_E);

    // Parametry dla jonów (uwzględniają krok czasowy subcyclingu DT_I)
    nu_star_i = max_ion_coll_freq();
    P_star_i = 1.0 - exp(-nu_star_i * DT_I);

    printf(">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n", nu_star_e, P_star_e);
    printf(">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n", nu_star_i, P_star_i);
}