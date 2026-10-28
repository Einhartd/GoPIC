#pragma once
#include "constants.h"
#include <random>
#include <cstdio>
#include <algorithm>

using namespace std;

// Tablice mikroskopowych przekrojów czynnych dla wszystkich modelowanych procesów [m^2]
inline cross_section   sigma[N_CS];
// Całkowity makroskopowy przekrój czynny dla elektronów (sigma_tot * n_gaz) [1/m]
inline cross_section   sigma_tot_e;
// Całkowity makroskopowy przekrój czynny dla jonów (sigma_tot * n_gaz) [1/m]
inline cross_section   sigma_tot_i;

// Aktualna liczba elektronów w układzie
inline int             N_e = 0;
// Aktualna liczba jonów w układzie
inline int             N_i = 0;
// Pozycje 1D [m] oraz składowe prędkości 3V [m/s] elektronów
inline particle_vector x_e, vx_e, vy_e, vz_e;
// Pozycje 1D [m] oraz składowe prędkości 3V [m/s] jonów
inline particle_vector x_i, vx_i, vy_i, vz_i;

// Natężenie pola elektrycznego [V/m] oraz potencjał elektrostatyczny [V] w węzłach siatki
inline xvector         efield, pot;
// Chwilowa gęstość liczbowa elektronów i jonów w węzłach siatki [1/m^3]
inline xvector         e_density, i_density;
// Skumulowana w czasie gęstość elektronów i jonów do wyznaczenia profili średnich
inline xvector         cumul_e_density, cumul_i_density;

// Licznik elektronów zaabsorbowanych na elektrodzie zasilanej (x = 0)
inline Ullong          N_e_abs_pow = 0;
// Licznik elektronów zaabsorbowanych na elektrodzie uziemionej (x = L)
inline Ullong          N_e_abs_gnd = 0;
// Licznik jonów zaabsorbowanych na elektrodzie zasilanej (x = 0)
inline Ullong          N_i_abs_pow = 0;
// Licznik jonów zaabsorbowanych na elektrodzie uziemionej (x = L)
inline Ullong          N_i_abs_gnd = 0;

// Całkowany w czasie histogram energii elektronów (EEPF) w centrum wyładowania
inline eepf_vector     eepf = {0.0};

// Histogram rozkładu energii jonów (IFED) docierających do elektrody zasilanej
inline ifed_vector     ifed_pow = {0};
// Histogram rozkładu energii jonów (IFED) docierających do elektrody uziemionej
inline ifed_vector     ifed_gnd = {0};
// Średnia energia jonów uderzających w elektrodę zasilaną [eV]
inline double          mean_i_energy_pow;
// Średnia energia jonów uderzających w elektrodę uziemioną [eV]
inline double          mean_i_energy_gnd;

// Rozkład czasoprzestrzenny (XT) potencjału elektrostatycznego
inline xt_distr        pot_xt        = {0.0};
// Rozkład czasoprzestrzenny (XT) natężenia pola elektrycznego
inline xt_distr        efield_xt     = {0.0};
// Rozkład czasoprzestrzenny (XT) gęstości elektronów
inline xt_distr        ne_xt         = {0.0};
// Rozkład czasoprzestrzenny (XT) gęstości jonów
inline xt_distr        ni_xt         = {0.0};
// Rozkład czasoprzestrzenny (XT) średniej prędkości unoszenia elektronów
inline xt_distr        ue_xt         = {0.0};
// Rozkład czasoprzestrzenny (XT) średniej prędkości unoszenia jonów
inline xt_distr        ui_xt         = {0.0};
// Rozkład czasoprzestrzenny (XT) gęstości prądu elektronowego
inline xt_distr        je_xt         = {0.0};
// Rozkład czasoprzestrzenny (XT) gęstości prądu jonowego
inline xt_distr        ji_xt         = {0.0};
// Rozkład czasoprzestrzenny (XT) gęstości mocy pochłanianej przez elektrony
inline xt_distr        powere_xt     = {0.0};
// Rozkład czasoprzestrzenny (XT) gęstości mocy pochłanianej przez jony
inline xt_distr        poweri_xt     = {0.0};
// Rozkład czasoprzestrzenny (XT) średniej energii elektronów
inline xt_distr        meanee_xt     = {0.0};
// Rozkład czasoprzestrzenny (XT) średniej energii jonów
inline xt_distr        meanei_xt     = {0.0};
// Licznik wagowy zliczeń elektronów w komórkach siatki czasoprzestrzennej XT
inline xt_distr        counter_e_xt  = {0.0};
// Licznik wagowy zliczeń jonów w komórkach siatki czasoprzestrzennej XT
inline xt_distr        counter_i_xt  = {0.0};
// Rozkład czasoprzestrzenny (XT) szybkości jonizacji
inline xt_distr        ioniz_rate_xt = {0.0};

// Akumulator sumarycznej energii elektronów w środkowym obszarze szczeliny [eV]
inline double          mean_energy_accu_center    = 0;
// Licznik próbek energii elektronów w środkowym obszarze szczeliny
inline Ullong          mean_energy_counter_center = 0;
// Sumaryczny licznik zderzeń elektronów w bieżącym uruchomieniu
inline Ullong          N_e_coll                   = 0;
// Sumaryczny licznik zderzeń jonów w bieżącym uruchomieniu
inline Ullong          N_i_coll                   = 0;
// Całkowity fizyczny czas symulacji od jej rozpoczęcia [s]
inline double          Time;
// Numer bieżącego cyklu RF, liczba cykli w uruchomieniu oraz łączna liczba ukończonych cykli
inline int             cycle, no_of_cycles, cycles_done;
// Wartość pierwszego argumentu wiersza poleceń (liczba cykli do wykonania)
inline int             arg1;
// Bufor znakowy do parsowania pierwszego argumentu wiersza poleceń
inline char            st0[80];
// Uchwyt do pliku zbieżności conv.dat
inline FILE            *datafile;
// Flaga aktywująca gromadzenie i zapis danych diagnostycznych w trybie pomiarowym
inline bool            measurement_mode;

// Maksymalna częstość zderzeń elektronów w metodzie Null-Collision [1/s]
inline double          nu_star_e = 0.0;
// Maksymalne prawdopodobieństwo zderzenia elektronu w kroku DT_E w metodzie Null-Collision
inline double          P_star_e  = 0.0;
// Maksymalna częstość zderzeń jonów w metodzie Null-Collision [1/s]
inline double          nu_star_i = 0.0;
// Maksymalne prawdopodobieństwo zderzenia jonu w kroku DT_I w metodzie Null-Collision
inline double          P_star_i  = 0.0;

// Urządzenie losowe służące do inicjalizacji ziarna generatora
inline std::random_device rd{};
// Generator liczb pseudolosowych Mersenne Twister (MT19937)
inline std::mt19937 MTgen(rd());
// Rozkład jednorodny na przedziale [0, 1)
inline std::uniform_real_distribution<> R01(0.0, 1.0);
// Rozkład normalny Maxwella-Boltzmanna dla składowych prędkości termicznej atomów tła Ar [m/s]
inline std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
