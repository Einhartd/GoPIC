#pragma once

#include <cmath>
#include <vector>
#include <numeric>
#include <algorithm>

#include "state.h"
#include "cross_sections.h"

/*
Oblicza i inicjalizuje stałe parametry metody zderzeń zerowych (Null-Collision).
Wyznacza maksymalne częstości zderzeń (nu_star_e, nu_star_i) oraz odpowiadające im
górne granice prawdopodobieństwa zderzenia w pojedynczym kroku czasowym (P_star_e, P_star_i).
*/
inline void compute_null_collision_params() {
    // Parametry zderzeń zerowych dla elektronów w kroku czasowym DT_E
    nu_star_e = max_electron_coll_freq();
    P_star_e  = 1.0 - exp(-nu_star_e * DT_E);

    // Parametry zderzeń zerowych dla jonów w kroku subcyclingu DT_I
    nu_star_i = max_ion_coll_freq();
    P_star_i  = 1.0 - exp(-nu_star_i * DT_I);

    printf(">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n", nu_star_e, P_star_e);
    printf(">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n", nu_star_i, P_star_i);
}

/*
Losuje bez zwracania podzbiór unikalnych indeksów cząstek z przedziału [0, n)
za pomocą częściowego tasowania Fishera-Yatesa.
@param n     Całkowita liczba dostępnych cząstek danego gatunku.
@param count Liczba kandydatów do wylosowania.
@param out   Wektor wyjściowy, do którego zapisywane są wylosowane indeksy cząstek.
*/
inline void random_sample(int n, int count, std::vector<int> &out) {
    static std::vector<int> pool;

    if (pool.size() < (size_t)n) {
        pool.resize(n);
    }

    std::iota(pool.begin(), pool.begin() + n, 0);

    for (int i = 0; i < count; i++) {
        int j = i + (int)(R01(MTgen) * (n - i));
        std::swap(pool[i], pool[j]);
    }
    out.assign(pool.begin(), pool.begin() + count);
}
