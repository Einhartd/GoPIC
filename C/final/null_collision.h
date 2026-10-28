#pragma once
#include <cmath>
#include <vector>
#include <numeric>
#include <algorithm>
#include "state.h"
#include "cross_sections.h"

/*
Oblicza i inicjalizuje globalne parametry metody zderzeń zerowych (Null-Collision).
Wyznacza maksymalne częstości zderzeń (nu_star_e, nu_star_i) oraz odpowiadające im stałe
maksymalne prawdopodobieństwa zderzenia w pojedynczym kroku czasowym (P_star_e dla DT_E
oraz P_star_i dla kroku subcyclingu DT_I).
*/
inline void compute_null_collision_params(void) {
    // Wyznaczenie maksymalnej częstości i prawdopodobieństwa zderzenia dla elektronów
    nu_star_e = max_electron_coll_freq();
    P_star_e  = 1.0 - exp(-nu_star_e * DT_E);

    // Wyznaczenie maksymalnej częstości i prawdopodobieństwa zderzenia dla jonów
    nu_star_i = max_ion_coll_freq();
    P_star_i  = 1.0 - exp(-nu_star_i * DT_I);

    printf(">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n", nu_star_e, P_star_e);
    printf(">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n", nu_star_i, P_star_i);
}
