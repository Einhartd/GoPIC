#pragma once
#include "constants.h"
#include <random>
#include <cstdio>
#include <algorithm>
#include <vector>
#include <array>
#include <immintrin.h>
#include <omp.h>

// Makro określające sposób rozwijania (inlinowania) funkcji pojedynczego kroku PIC.
// W trybie profilowania (PROFILE_RECORD) wyłączamy inlining za pomocą atrybutu noinline,
// aby każda funkcja kroku była osobno widoczna w raportach narzędzia perf.
#ifdef PROFILE_RECORD
    #define PIC_STEP inline __attribute__((noinline))
#else
    #define PIC_STEP inline
#endif

using namespace std;

// Zestaw stabelaryzowanych przekrojów czynnych dla wszystkich 5 procesów zderzeniowych [m^2]
alignas(64) inline cross_section sigma[N_CS];
// Całkowity makroskopowy przekrój czynny dla elektronów (sigma_tot * n_gaz) [1/m]
alignas(64) inline cross_section sigma_tot_e;
// Całkowity makroskopowy przekrój czynny dla jonów (sigma_tot * n_gaz) [1/m]
alignas(64) inline cross_section sigma_tot_i;

// Aktualna liczba aktywnych makrocząstek elektronowych w symulacji
inline int N_e = 0;
// Aktualna liczba aktywnych makrocząstek jonowych w symulacji
inline int N_i = 0;
// Pozycje 1D [m] oraz składowe prędkości 3V [m/s] elektronów (układ SoA wyrównany do 64 B)
alignas(64) inline particle_vector x_e, vx_e, vy_e, vz_e;
// Pozycje 1D [m] oraz składowe prędkości 3V [m/s] jonów (układ SoA wyrównany do 64 B)
alignas(64) inline particle_vector x_i, vx_i, vy_i, vz_i;

// Natężenie pola elektrycznego [V/m] oraz potencjał elektrostatyczny [V] w węzłach siatki
alignas(64) inline xvector efield, pot;
// Chwilowe gęstości liczbowe elektronów i jonów w węzłach siatki [1/m^3]
alignas(64) inline xvector e_density, i_density;
// Skumulowane w czasie gęstości elektronów i jonów do uśrednień diagnostycznych [1/m^3]
alignas(64) inline xvector cumul_e_density, cumul_i_density;

// Liczba makrocząstek elektronowych zaabsorbowanych na elektrodzie zasilanej (x = 0)
inline Ullong N_e_abs_pow = 0;
// Liczba makrocząstek elektronowych zaabsorbowanych na elektrodzie uziemionej (x = L)
inline Ullong N_e_abs_gnd = 0;
// Liczba makrocząstek jonowych zaabsorbowanych na elektrodzie zasilanej (x = 0)
inline Ullong N_i_abs_pow = 0;
// Liczba makrocząstek jonowych zaabsorbowanych na elektrodzie uziemionej (x = L)
inline Ullong N_i_abs_gnd = 0;

// Histogram funkcji rozkładu prawdopodobieństwa energii elektronów (EEPF) w środku układu
inline eepf_vector eepf     = {0.0};
// Histogram rozkładu energetycznego jonów (IFED) uderzających w elektrodę zasilaną (x = 0)
inline ifed_vector ifed_pow = {0};
// Histogram rozkładu energetycznego jonów (IFED) uderzających w elektrodę uziemioną (x = L)
inline ifed_vector ifed_gnd = {0};
// Średnia energia jonów docierających do elektrody zasilanej [eV]
inline double mean_i_energy_pow;
// Średnia energia jonów docierających do elektrody uziemionej [eV]
inline double mean_i_energy_gnd;

// Rozkład czasoprzestrzenny potencjału elektrostatycznego [V]
inline xt_distr pot_xt        = {0.0};
// Rozkład czasoprzestrzenny natężenia pola elektrycznego [V/m]
inline xt_distr efield_xt     = {0.0};
// Rozkład czasoprzestrzenny gęstości elektronów [1/m^3]
inline xt_distr ne_xt         = {0.0};
// Rozkład czasoprzestrzenny gęstości jonów [1/m^3]
inline xt_distr ni_xt         = {0.0};
// Rozkład czasoprzestrzenny średniej prędkości kierunkowej elektronów [m/s]
inline xt_distr ue_xt         = {0.0};
// Rozkład czasoprzestrzenny średniej prędkości kierunkowej jonów [m/s]
inline xt_distr ui_xt         = {0.0};
// Rozkład czasoprzestrzenny gęstości prądu elektronowego [A/m^2]
inline xt_distr je_xt         = {0.0};
// Rozkład czasoprzestrzenny gęstości prądu jonowego [A/m^2]
inline xt_distr ji_xt         = {0.0};
// Rozkład czasoprzestrzenny gęstości mocy pochłanianej przez elektrony [W/m^3]
inline xt_distr powere_xt     = {0.0};
// Rozkład czasoprzestrzenny gęstości mocy pochłanianej przez jony [W/m^3]
inline xt_distr poweri_xt     = {0.0};
// Rozkład czasoprzestrzenny średniej energii elektronów [eV]
inline xt_distr meanee_xt     = {0.0};
// Rozkład czasoprzestrzenny średniej energii jonów [eV]
inline xt_distr meanei_xt     = {0.0};
// Licznik próbek elektronowych w komórkach siatki czasoprzestrzennej XT
inline xt_distr counter_e_xt  = {0.0};
// Licznik próbek jonowych w komórkach siatki czasoprzestrzennej XT
inline xt_distr counter_i_xt  = {0.0};
// Rozkład czasoprzestrzenny szybkości jonizacji [1/(m^3 s)]
inline xt_distr ioniz_rate_xt = {0.0};

// Akumulator energii elektronów w centralnym obszarze wyładowania [eV]
inline double mean_energy_accu_center    = 0;
// Licznik zliczeń elektronów w centralnym obszarze wyładowania
inline Ullong mean_energy_counter_center = 0;
// Całkowita liczba zderzeń elektronów w przebiegu pomiarowym
inline Ullong N_e_coll                   = 0;
// Całkowita liczba zderzeń jonów w przebiegu pomiarowym
inline Ullong N_i_coll                   = 0;
// Aktualny fizyczny czas symulacji [s]
inline double Time;
// Bieżący numer cyklu RF, zadana liczba cykli do wykonania oraz liczba cykli ukończonych wcześniej
inline int    cycle, no_of_cycles, cycles_done;
// Sparowany pierwszy argument wiersza poleceń określający liczbę cykli do uruchomienia
inline int    arg1;
// Bufor tekstowy na pierwszy argument wiersza poleceń
inline char   st0[80];
// Uchwyt do pliku zbieżności conv.dat
inline FILE   *datafile;
// Flaga aktywująca tryb pomiarowy (zbieranie i zapis diagnostyk)
inline bool   measurement_mode;

// Maksymalna częstość zderzeń dla elektronów w metodzie Null-Collision [1/s]
inline double nu_star_e = 0.0;
// Maksymalne prawdopodobieństwo zderzenia elektronu w jednym kroku czasowym DT_E
inline double P_star_e  = 0.0;
// Maksymalna częstość zderzeń dla jonów w metodzie Null-Collision [1/s]
inline double nu_star_i = 0.0;
// Maksymalne prawdopodobieństwo zderzenia jonu w jednym kroku subcyclingu DT_I
inline double P_star_i  = 0.0;

/*
Struktura skalarnych liczników prywatnych wątku OpenMP wyrównana do linii pamięci podręcznej (64 B).
Eliminuje zjawisko fałszywego współdzielenia (False Sharing) pomiędzy rdzeniami procesora,
gwarantując, że każdy wątek modyfikuje wyłącznie własną linię pamięci L1/L2.
*/
struct alignas(64) AlignedThreadCounters {
    // Lokalny akumulator energii elektronów w środkowym obszarze szczeliny [eV]
    double accu_center    = 0.0;
    // Lokalny licznik próbek energii elektronów w środkowym obszarze szczeliny
    Ullong counter_center = 0;
    // Lokalny licznik cząstek zaabsorbowanych na elektrodzie zasilanej (x = 0)
    Ullong local_abs_pow  = 0;
    // Lokalny licznik cząstek zaabsorbowanych na elektrodzie uziemionej (x = L)
    Ullong local_abs_gnd  = 0;
    // Lokalny licznik zderzeń elektronów w bieżącym kroku czasowym
    Ullong local_coll_e   = 0;
    // Lokalny licznik zderzeń jonów w bieżącym kroku subcyclingu
    Ullong local_coll_i   = 0;
};

/*
Prywatny bufor wątku na nowo utworzone makrocząstki (elektrony wtórne i jony z jonizacji).
Wykorzystuje statyczną tablicę w układzie SoA wyrównaną do 64 B, co zapewnia dodawanie
cząstek w czasie stałym O(1) bez dynamicznych alokacji na stercie wewnątrz pętli czasowej.
*/
struct alignas(64) NewParticles {
    // Maksymalna pojemność bufora nowych cząstek na jeden wątek w pojedynczym kroku czasowym
    static constexpr size_t CAPACITY = 4096;
    // Tablica położeń 1D nowo utworzonych cząstek [m]
    alignas(64) std::array<double, CAPACITY> x;
    // Tablica składowych prędkości vx nowo utworzonych cząstek [m/s]
    alignas(64) std::array<double, CAPACITY> vx;
    // Tablica składowych prędkości vy nowo utworzonych cząstek [m/s]
    alignas(64) std::array<double, CAPACITY> vy;
    // Tablica składowych prędkości vz nowo utworzonych cząstek [m/s]
    alignas(64) std::array<double, CAPACITY> vz;
    // Aktualna liczba cząstek zapisanych w buforze
    int count = 0;

    /*
    Dodaje pojedynczą nowo wygenerowaną cząstkę do bufora lokalnego wątku w czasie O(1).
    @param px  Pozycja początkowa nowej cząstki [m].
    @param pvx Składowa prędkości wzdłuż osi x [m/s].
    @param pvy Składowa prędkości wzdłuż osi y [m/s].
    @param pvz Składowa prędkości wzdłuż osi z [m/s].
    */
    void push(double px, double pvx, double pvy, double pvz) {
        if (__builtin_expect(count < (int)CAPACITY, 1)) {
            x[count]  = px;
            vx[count] = pvx;
            vy[count] = pvy;
            vz[count] = pvz;
            count++;
        }
    }

    /*
    Zeruje licznik cząstek w buforze przed kolejnym krokiem czasowym.
    */
    void clear() { count = 0; }

    /*
    Zwraca aktualną liczbę cząstek zgromadzonych w buforze.
    @return Liczba nowych cząstek w buforze.
    */
    size_t size() const { return (size_t)count; }
};

/*
Szablon pomocniczy opakowujący std::array z wymuszonym wyrównaniem do 64 bajtów (linii cache).
Zapobiega współdzieleniu linii pamięci podręcznej pomiędzy sąsiednimi elementami w std::vector.
*/
template <typename T, size_t N>
struct alignas(64) AlignedArray : std::array<T, N> {};

/*
Zestaw prealokowanych buforów prywatnych dla wszystkich wątków roboczych OpenMP.
Pozwala wyeliminować alokacje pamięci wewnątrz głównej pętli czasowej oraz uniknąć
konfliktów zapisu (atomików i blokad) poprzez pracę każdego wątku na własnych tablicach
i późniejszą równoległą redukcję do struktur globalnych.
*/
struct WorkerBuffers {
    // Prywatne bufory depozycji gęstości elektronów i jonów (z zapasem pod wektoryzację SIMD)
    std::vector<AlignedArray<double, N_G + 16>> e_density;
    std::vector<AlignedArray<double, N_G + 16>> i_density;

    // Prywatne bufory diagnostyk czasoprzestrzennych oraz EEPF dla elektronów
    std::vector<AlignedArray<double, N_G>>    counter_e;
    std::vector<AlignedArray<double, N_G>>    ue;
    std::vector<AlignedArray<double, N_G>>    meanee;
    std::vector<AlignedArray<double, N_G>>    ioniz;
    std::vector<AlignedArray<double, N_EEPF>> eepf;

    // Wyrównane do linii cache liczniki skalarne dla każdego wątku
    std::vector<AlignedThreadCounters> thread_counters;

    // Prywatne bufory diagnostyk czasoprzestrzennych dla jonów
    std::vector<AlignedArray<double, N_G>> counter_i;
    std::vector<AlignedArray<double, N_G>> ui;
    std::vector<AlignedArray<double, N_G>> meanei;

    // Prywatne listy indeksów cząstek zaabsorbowanych na elektrodach oraz lokalne histogramy IFED
    std::vector<std::vector<int>>          absorbed_indices;
    std::vector<AlignedArray<int, N_IFED>> local_ifed_pow;
    std::vector<AlignedArray<int, N_IFED>> local_ifed_gnd;

    // Prywatne bufory cząstek wtórnych wygenerowanych w zderzeniach jonizacyjnych
    std::vector<NewParticles> new_electrons;
    std::vector<NewParticles> new_ions;

    /*
    Inicjalizuje i prealokuje wszystkie bufory prywatne dla zadanej liczby wątków OpenMP.
    Wykonuje równoległe zerowanie pamięci (First-Touch), aby strony pamięci zostały przypisane
    do odpowiednich węzłów NUMA poszczególnych wątków.
    @param num_threads Liczba aktywnych wątków roboczych OpenMP.
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

        absorbed_indices.resize(num_threads);
        local_ifed_pow.resize(num_threads);
        local_ifed_gnd.resize(num_threads);

        new_electrons.resize(num_threads);
        new_ions.resize(num_threads);

        for (int t = 0; t < num_threads; ++t) {
            absorbed_indices[t].reserve(2000);
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

// Globalna instancja buforów prywatnych współdzielona przez zespół wątków OpenMP
inline WorkerBuffers worker_buffers;

// Lokalny dla wątku (thread_local) sprzętowy generator ziarna losowego
inline thread_local std::random_device rd{};
// Lokalny dla wątku (thread_local) generator liczb pseudolosowych Mersenne Twister MT19937
inline thread_local std::mt19937 MTgen(rd());
// Lokalny dla wątku rozkład jednorodny na przedziale [0, 1)
inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
// Lokalny dla wątku rozkład normalny (Maxwella-Boltzmanna) dla prędkości termicznych atomów Ar [m/s]
inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
