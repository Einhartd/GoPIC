#pragma once

#include "constants.h"
#include <random>
#include <cstdio>
#include <algorithm>
#include <vector>
#include <array>
#include <immintrin.h>
#include <omp.h>

// Makro określające sposób inlinowania funkcji pojedynczego kroku PIC.
// W trybie profilowania (PROFILE_RECORD) wyłączamy inlining (__attribute__((noinline))),
// aby każda funkcja kroku była wyraźnie widoczna w raportach narzędzia perf.
#ifdef PROFILE_RECORD                                                                                                                                                               
    #define PIC_STEP inline __attribute__((noinline))                                                                                                                               
#else                                                                                                                                                                               
    #define PIC_STEP inline                                                                                                                                                         
#endif  

using namespace std;

// =============================================================================
// Przekroje czynne i parametry makroskopowe
// =============================================================================

// Zestaw tabel przekrojów czynnych dla wszystkich procesów
inline cross_section    sigma[N_CS];
// Całkowity makroskopowy przekrój czynny dla elektronów (sigma * n_gaz)         
inline cross_section    sigma_tot_e;
// Całkowity makroskopowy przekrój czynny dla jonów (sigma * n_gaz)
inline cross_section    sigma_tot_i;

// =============================================================================
// Koordynaty i liczniki cząstek
// =============================================================================

// Aktualna liczba aktywnych elektronów w symulacji
inline int              N_e = 0;
// Aktualna liczba aktywnych jonów w symulacji
inline int              N_i = 0;
// Pozycje 1D oraz składowe prędkości 3V dla elektronów
alignas(64) inline particle_vector  x_e, vx_e, vy_e, vz_e;
// Pozycje 1D oraz składowe prędkości 3V dla jonów
alignas(64) inline particle_vector  x_i, vx_i, vy_i, vz_i;

// =============================================================================
// Wielkości na siatce przestrzennej (Pole elektryczne, potencjał, gęstości)
// =============================================================================

// Pole elektryczne i potencjał elektrostatyczny w węzłach siatki
alignas(64) inline xvector          efield, pot;
// Chwilowe gęstości ładunku elektronów i jonów na siatce
alignas(64) inline xvector          e_density, i_density;
// Skumulowane w czasie gęstości do uśrednień diagnostycznych
alignas(64) inline xvector          cumul_e_density, cumul_i_density;

// =============================================================================
// Liczniki absorpcji na elektrodach i rozkłady energetyczne
// =============================================================================

// Liczba elektronów zaabsorbowanych na elektrodzie zasilanej (x=0)
inline Ullong           N_e_abs_pow = 0;
// Liczba elektronów zaabsorbowanych na elektrodzie uziemionej (x=L)
inline Ullong           N_e_abs_gnd = 0;
// Liczba jonów zaabsorbowanych na elektrodzie zasilanej (x=0)
inline Ullong           N_i_abs_pow = 0;
// Liczba jonów zaabsorbowanych na elektrodzie uziemionej (x=L)
inline Ullong           N_i_abs_gnd = 0;

// Całkowany w czasie rozkład EEPF w centralnym obszarze szczeliny
inline eepf_vector      eepf     = {0.0};
// Rozkład strumieniowo-energetyczny jonów (IFED) na elektrodzie zasilanej
inline ifed_vector      ifed_pow = {0};
// Rozkład strumieniowo-energetyczny jonów (IFED) na elektrodzie uziemionej
inline ifed_vector      ifed_gnd = {0};
// Średnia energia jonów uderzających w elektrodę zasilaną [eV]
inline double           mean_i_energy_pow;
// Średnia energia jonów uderzających w elektrodę uziemioną [eV]
inline double           mean_i_energy_gnd;

// =============================================================================
// Tablice diagnostyk czasoprzestrzennych (XT)
// =============================================================================

inline xt_distr pot_xt                     = {0.0}; // Rozkład czasoprzestrzenny potencjału
inline xt_distr efield_xt                  = {0.0}; // Rozkład czasoprzestrzenny pola elektrycznego
inline xt_distr ne_xt                      = {0.0}; // Rozkład czasoprzestrzenny gęstości elektronów
inline xt_distr ni_xt                      = {0.0}; // Rozkład czasoprzestrzenny gęstości jonów
inline xt_distr ue_xt                      = {0.0}; // Rozkład czasoprzestrzenny średniej prędkości elektronów
inline xt_distr ui_xt                      = {0.0}; // Rozkład czasoprzestrzenny średniej prędkości jonów
inline xt_distr je_xt                      = {0.0}; // Rozkład czasoprzestrzenny gęstości prądu elektronowego
inline xt_distr ji_xt                      = {0.0}; // Rozkład czasoprzestrzenny gęstości prądu jonowego
inline xt_distr powere_xt                  = {0.0}; // Rozkład czasoprzestrzenny mocy pochłanianej przez elektrony (j_e * E)
inline xt_distr poweri_xt                  = {0.0}; // Rozkład czasoprzestrzenny mocy pochłanianej przez jony (j_i * E)
inline xt_distr meanee_xt                  = {0.0}; // Rozkład czasoprzestrzenny średniej energii elektronów
inline xt_distr meanei_xt                  = {0.0}; // Rozkład czasoprzestrzenny średniej energii jonów
inline xt_distr counter_e_xt               = {0.0}; // Licznik próbek elektronów dla uśrednień XT
inline xt_distr counter_i_xt               = {0.0}; // Licznik próbek jonów dla uśrednień XT
inline xt_distr ioniz_rate_xt              = {0.0}; // Rozkład czasoprzestrzenny częstości jonizacji

// =============================================================================
// Zmienne sterujące symulacją i liczniki globalne
// =============================================================================

inline double   mean_energy_accu_center    = 0;     // Akumulator energii elektronów w środku szczeliny
inline Ullong   mean_energy_counter_center = 0;     // Licznik próbek energii elektronów w środku szczeliny
inline Ullong   N_e_coll                   = 0;     // Całkowity licznik zderzeń elektronów
inline Ullong   N_i_coll                   = 0;     // Całkowity licznik zderzeń jonów
inline double   Time;                               // Całkowity fizyczny czas symulacji [s]
inline int      cycle, no_of_cycles, cycles_done;   // Zmienne śledzenia cykli RF
inline int      arg1;                               // Pierwszy argument linii poleceń (liczba cykli)
inline char     st0[80];                            // Bufor tekstowy na argumenty
inline FILE     *datafile;                          // Uchwyt do pliku wyjściowego conv.dat
inline bool     measurement_mode;                   // Flaga aktywacji trybu pomiarowego / diagnostyk

// =============================================================================
// Wstępnie obliczone parametry metody zderzeń zerowych (Null-Collision)
// =============================================================================

inline double nu_star_e = 0.0;                       // Maksymalna częstość zderzeń dla elektronów nu*_e
inline double P_star_e  = 0.0;                       // Maksymalne prawdopodobieństwo zderzenia elektronu P*_e
inline double nu_star_i = 0.0;                       // Maksymalna częstość zderzeń dla jonów nu*_i
inline double P_star_i  = 0.0;                       // Maksymalne prawdopodobieństwo zderzenia jonu P*_i

// =============================================================================
// Struktury pamięci lokalnej dla wątków OpenMP (Eliminacja False Sharing)
// =============================================================================

// Struktura skalarów wątku wyrównana do linii pamięci podręcznej (64 bajty).
// Zapobiega zjawisku False Sharing (unieważnianiu linii cache między rdzeniami),
// ponieważ każdy wątek operuje na własnej, niezależnej linii pamięci L1/L2.
struct alignas(64) AlignedThreadCounters {
    double accu_center = 0.0;                        // Lokalny akumulator energii w centrum
    Ullong counter_center = 0;                       // Lokalny licznik próbek energii w centrum
    Ullong local_abs_pow = 0;                        // Licznik cząstek zaabsorbowanych na elektrodzie zasilanej
    Ullong local_abs_gnd = 0;                        // Licznik cząstek zaabsorbowanych na elektrodzie uziemionej
    Ullong local_coll_e = 0;                         // Lokalny licznik zderzeń elektronów (lock-free)
    Ullong local_coll_i = 0;                         // Lokalny licznik zderzeń jonów (lock-free)
};


/*
Bufor na nowo utworzone cząstki (elektrony i jony z procesów jonizacji).
Wątki zapisują nowo powstałe cząstki do własnych lokalnych instancji,
unikając konfliktów zapisu (data races).
*/
struct NewParticles {
    std::vector<double> x;
    std::vector<double> vx;
    std::vector<double> vy;
    std::vector<double> vz;

    /*
    Dodanie nowej cząstki do bufora.
    @param px  Pozycja 1D nowej cząstki [m].
    @param pvx Składowa X prędkości [m/s].
    @param pvy Składowa Y prędkości [m/s].
    @param pvz Składowa Z prędkości [m/s].
    */
    void push(double px, double pvx, double pvy, double pvz) {
        x.push_back(px);
        vx.push_back(pvx);
        vy.push_back(pvy);
        vz.push_back(pvz);
    }

    void reserve(size_t cap) {
        x.reserve(cap);
        vx.reserve(cap);
        vy.reserve(cap);
        vz.reserve(cap);
    }

    void clear() {
        x.clear();
        vx.clear();
        vy.clear();
        vz.clear();
    }
};


// WorkerBuffers: Wstępnie zaalokowane bufory robocze dla wątków OpenMP.
// Kluczowy wzorzec optymalizacji:
// 1. Zero alokacji pamięci wewnątrz głównej pętli czasowej (4000 kroków / cykl).
// 2. Każdy wątek pisze wyłącznie do swoich prywatnych tablic o rozmiarze N_G / N_EEPF / N_IFED.
// 3. Po zakończeniu fazy równoległej następuje szybka redukcja do tablic globalnych.
struct WorkerBuffers {
    // Prywatne bufory depozycji gęstości ładunku (Krok 1) (z buforem SIMD)
    std::vector<std::array<double, N_G + 16>> e_density;
    std::vector<std::array<double, N_G + 16>> i_density;

    // Prywatne bufory diagnostyk elektronowych (Krok 3)
    std::vector<std::array<double, N_G>> counter_e;
    std::vector<std::array<double, N_G>> ue;
    std::vector<std::array<double, N_G>> meanee;
    std::vector<std::array<double, N_G>> ioniz;
    std::vector<std::array<double, N_EEPF>> eepf;

    // Wyrównane do linii cache liczniki skalarne na wątek
    std::vector<AlignedThreadCounters> thread_counters;

    // Prywatne bufory diagnostyk jonowych (Krok 4)
    std::vector<std::array<double, N_G>> counter_i;
    std::vector<std::array<double, N_G>> ui;
    std::vector<std::array<double, N_G>> meanei;

    // Bufory dla filtracji granic i kompaktacji tablic cząstek (Kroki 5 i 6)
    std::vector<int> thread_counts;
    std::vector<int> thread_offsets;
    std::vector<std::vector<int>> thread_local_indices;
    std::vector<std::vector<int>> absorbed_indices;
    std::vector<std::array<int, N_IFED>> local_ifed_pow;
    std::vector<std::array<int, N_IFED>> local_ifed_gnd;

    // Wstępnie zaalokowane tablice tymczasowe dla ocalałych cząstek
    std::vector<double> temp_x;
    std::vector<double> temp_vx;
    std::vector<double> temp_vy;
    std::vector<double> temp_vz;

    // Prywatne bufory nowo narodzonych cząstek dla każdego wątku (Krok 7)
    std::vector<NewParticles> new_electrons;
    std::vector<NewParticles> new_ions;

    // Prywatne bufory indeksów kandydatów dla metody Null-Collision (Kroki 7 i 8)
    std::vector<std::vector<int>> candidates_e;
    std::vector<std::vector<int>> candidates_i;

    /*
    Inicjalizacja i prealokacja wszystkich prywatnych buforów wątków.
    Wywoływana przed rozpoczęciem faz równoległych w celu zapewnienia,
    że wektory mają odpowiedni rozmiar dla zadanej liczby wątków num_threads.
    @param num_threads Liczba aktywnych wątków OpenMP w zespole.
    */
    void init_buffers(int num_threads) {
        if ((int)e_density.size() >= num_threads) return;

        e_density.resize(num_threads);
        i_density.resize(num_threads);

        counter_e.resize(num_threads);
        ue.resize(num_threads);
        meanee.resize(num_threads);
        ioniz.resize(num_threads);
        eepf.resize(num_threads);
        thread_counters.resize(num_threads);

        counter_i.resize(num_threads);
        ui.resize(num_threads);
        meanei.resize(num_threads);

        thread_counts.resize(num_threads, 0);
        thread_offsets.resize(num_threads, 0);
        thread_local_indices.resize(num_threads);
        absorbed_indices.resize(num_threads);
        local_ifed_pow.resize(num_threads);
        local_ifed_gnd.resize(num_threads);

        new_electrons.resize(num_threads);
        new_ions.resize(num_threads);
        for (int t = 0; t < num_threads; ++t) {
            new_electrons[t].reserve(2048);
            new_ions[t].reserve(2048);
        }

        candidates_e.resize(num_threads);
        candidates_i.resize(num_threads);

        for (int t = 0; t < num_threads; ++t) {
            thread_local_indices[t].reserve(MAX_N_P / num_threads);
            absorbed_indices[t].reserve(2000);
            candidates_e[t].resize(MAX_N_P);
            candidates_i[t].resize(MAX_N_P);
        }

        temp_x.resize(MAX_N_P);
        temp_vx.resize(MAX_N_P);
        temp_vy.resize(MAX_N_P);
        temp_vz.resize(MAX_N_P);

        #pragma omp parallel for schedule(static)
        for (int i = 0; i < MAX_N_P; i++) {
            temp_x[i] = 0.0;
            temp_vx[i] = 0.0;
            temp_vy[i] = 0.0;
            temp_vz[i] = 0.0;
        }

        #pragma omp parallel for schedule(static)
        for (int i = 0; i < num_threads; ++i) {
            e_density[i].fill(0.0);
            i_density[i].fill(0.0);
            counter_e[i].fill(0.0);
            counter_i[i].fill(0.0);
        }
    }
};

inline WorkerBuffers worker_buffers;

// =============================================================================
// Niezależne generatory liczb pseudolosowych na poziomie wątku (thread_local)
// Każdy wątek OpenMP posiada własny stan generatora Mersenne Twister,
// co zapewnia w 100% bezblokadowe (lock-free) losowanie liczb.
// =============================================================================

inline thread_local std::random_device rd{}; 
inline thread_local std::mt19937 MTgen(rd());
inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));

