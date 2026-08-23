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

/*
Losowanie unikalnych indeksów cząstek bez powtórzeń ze zbioru [0, n).
Wykorzystuje częściowy algorytm tasowania Fishera-Yatesa o złożoności O(count).
Wylosowane indeksy zapisywane są bezpośrednio na początku wektora bufora.
@param n      Całkowita liczba dostępnych cząstek w puli (N_e lub N_i).
@param count  Liczba unikalnych indeksów cząstek do wylosowania (N_coll_star).
@param buffer Bufor roboczy wątku, do którego zapisywane są wylosowane indeksy.
*/
PIC_STEP void random_sample(int n, int count, std::vector<int> &buffer) {
    if (buffer.size() < (size_t)n) {
        buffer.resize(n);
    }

    // Wypełnienie indeksami początkowymi 0, 1, 2, ..., n-1
    std::iota(buffer.begin(), buffer.begin() + n, 0);

    // Częściowe tasowanie Fishera-Yatesa dla pierwszych 'count' elementów
    for (int i = 0; i < count; i++) {
        int j = i + (int)(R01(MTgen) * (n - i));
        std::swap(buffer[i], buffer[j]);
    }
}