#pragma once
#include <cmath>

// =============================================================================
// Stałe fizyczne i matematyczne
// =============================================================================

constexpr double PI                 = 3.141592653589793;          // Stała matematyczna Pi
constexpr double TWO_PI             = 2.0 * PI;                   // 2 * Pi
constexpr double E_CHARGE           = 1.60217662e-19;             // Ładunek elementarny elektronu [C]
constexpr double EV_TO_J            = E_CHARGE;                   // Współczynnik konwersji eV <-> Dżule
constexpr double INV_EV_TO_J        = 1.0 / EV_TO_J;              // Odwrotność EV_TO_J (Dżule -> eV)
constexpr double E_MASS             = 9.10938356e-31;             // Masa spoczynkowa elektronu [kg]
constexpr double INV_E_MASS         = 1.0 / E_MASS;               // Odwrotność masy elektronu [1/kg]
constexpr double TWO_OVER_E_MASS     = 2.0 / E_MASS;               // 2.0 / m_e (dla wyznaczania prędkości ze straty energii)
constexpr double HALF_E_MASS        = 0.5 * E_MASS;               // 0.5 * m_e (dla wyznaczania energii kinetycznej)
constexpr double AR_MASS            = 6.63352090e-26;             // Masa atomu argonu [kg]
constexpr double INV_AR_MASS        = 1.0 / AR_MASS;              // Odwrotność masy argonu [1/kg]
constexpr double HALF_AR_MASS       = 0.5 * AR_MASS;              // 0.5 * m_Ar (dla energii jonu)
constexpr double MU_ARAR            = AR_MASS / 2.0;              // Masa zredukowana układu dwóch atomów argonu [kg]
constexpr double K_BOLTZMANN        = 1.38064852e-23;             // Stała Boltzmanna [J/K]
constexpr double EPSILON0           = 8.85418781e-12;             // Przenikalność elektryczna próżni [F/m]

// =============================================================================
// Główne parametry symulacji
// =============================================================================

constexpr int    N_G                = 400;                        // Liczba punktów siatki przestrzennej
constexpr int    N_T                = 4000;                       // Liczba kroków czasowych w jednym okresie RF
constexpr double FREQUENCY          = 13.56e6;                    // Częstotliwość napięcia zasilającego RF [Hz]
constexpr double VOLTAGE            = 250.0;                      // Amplituda napięcia zasilającego [V]
constexpr double L                  = 0.025;                      // Odległość między elektrodami [m]
constexpr double PRESSURE           = 10.0;                       // Ciśnienie gazu neutralnego (argon) [Pa]
constexpr double TEMPERATURE        = 350.0;                      // Temperatura gazu tła [K]
constexpr double WEIGHT             = 7.0e4;                      // Waga supercząstki (liczba realnych cząstek na makrocząstkę)
constexpr double ELECTRODE_AREA     = 1.0e-4;                     // Fikcyjna powierzchnia elektrod [m^2]
constexpr int    N_INIT             = 1000;                       // Początkowa liczba par elektron-jon przy inicjalizacji

// =============================================================================
// Stałe pochodne (wyliczane na podstawie parametrów głównych)
// =============================================================================

constexpr double PERIOD             = 1.0 / FREQUENCY;                           // Czas trwania jednego okresu RF [s]
constexpr double DT_E               = PERIOD / (double)(N_T);                    // Krok czasowy dla elektronów [s]
constexpr int    N_SUB              = 20;                                        // Współczynnik subcyclingu jonów
constexpr double DT_I               = N_SUB * DT_E;                              // Krok czasowy dla jonów [s]
constexpr double DX                 = L / (double)(N_G - 1);                     // Krok siatki przestrzennej [m]
constexpr double INV_DX             = 1.0 / DX;                                  // Odwrotność kroku siatki [1/m]
constexpr double GAS_DENSITY        = PRESSURE / (K_BOLTZMANN * TEMPERATURE);    // Gęstość liczbowa gazu tła [1/m^3]
constexpr double OMEGA              = TWO_PI * FREQUENCY;                        // Częstość kołowa napięcia RF [rad/s]

// =============================================================================
// Przekroje czynne zderzeń elektronów i jonów z argonem
// =============================================================================

constexpr int    N_CS               = 5;                          // Całkowita liczba typów procesów zderzeniowych
constexpr int    E_ELA              = 0;                          // Identyfikator procesu: elektron / sprężyste
constexpr int    E_EXC              = 1;                          // Identyfikator procesu: elektron / wzbudzenie
constexpr int    E_ION              = 2;                          // Identyfikator procesu: elektron / jonizacja
constexpr int    I_ISO              = 3;                          // Identyfikator procesu: jon / sprężyste izotropowe
constexpr int    I_BACK             = 4;                          // Identyfikator procesu: jon / sprężyste wsteczne (wymiana ładunku)
constexpr double E_EXC_TH           = 11.5;                       // Próg energii dla wzbudzenia argonu przez elektron [eV]
constexpr double E_ION_TH           = 15.8;                       // Próg energii dla jonizacji argonu przez elektron [eV]
constexpr int    CS_RANGES          = 1000000;                    // Liczba przedziałów w tabelach przekrojów czynnych
constexpr double DE_CS              = 0.001;                      // Krok dyskretyzacji energii w tabelach [eV]
constexpr double INV_DE_CS          = 1.0 / DE_CS;                // 1000.0 [1/eV] (zamiana dzielenia na mnożenie)
constexpr double FACTOR_ENERGY_E    = (0.5 * E_MASS * INV_EV_TO_J) * INV_DE_CS; // Konwersja v^2 -> indeks energii e- (eliminuje 2x dzielenie)
constexpr double FACTOR_ENERGY_I    = (0.5 * MU_ARAR * INV_EV_TO_J) * INV_DE_CS; // Konwersja g^2 -> indeks energii jonu (eliminuje 2x dzielenie)
constexpr double OPAL_FACTOR        = (1.0 / EV_TO_J) / 20.0;     // Prekompilowany współczynnik dla rozkładu Opla (eliminuje 2x vdivsd)
typedef double   cross_section[CS_RANGES];                        // Tablica przekroju czynnego w funkcji energii

// =============================================================================
// Współrzędne cząstek i typy wektorowe
// =============================================================================

constexpr int    MAX_N_P            = 1000000;                    // Maksymalna pojemność tablic cząstek
typedef double __attribute__((aligned(64)))   particle_vector[MAX_N_P]; // Tablica właściwości cząstek (AVX-512)
typedef double __attribute__((aligned(64)))   xvector[N_G + 16];        // Tablica siatkowa z buforem SIMD
typedef unsigned long long int Ullong;                                 // 64-bitowa liczba całkowita bez znaku

// =============================================================================
// Funkcja rozkładu prawdopodobieństwa energii elektronów (EEPF)
// =============================================================================

constexpr int    N_EEPF             = 2000;                       // Liczba przedziałów energii dla diagnostyki EEPF
constexpr double DE_EEPF            = 0.05;                       // Rozdzielczość energetyczna EEPF [eV]
constexpr double INV_DE_EEPF        = 1.0 / DE_EEPF;              // 20.0 [1/eV]
typedef double eepf_vector[N_EEPF];                               // Tablica rozkładu EEPF

// =============================================================================
// Współczynniki pomocnicze dla pętli do_one_cycle()
// =============================================================================

constexpr double MIN_X              = 0.45 * L;                   // Dolna granica przestrzenna dla zliczania EEPF
constexpr double MAX_X              = 0.55 * L;                   // Górna granica przestrzenna dla zliczania EEPF
constexpr double DV                 = ELECTRODE_AREA * DX;        // Objętość komórki siatki [m^3]
constexpr double FACTOR_W           = WEIGHT / DV;                // Współczynnik wagi dla depozycji gęstości ładunku
constexpr double FACTOR_I           = DT_I / AR_MASS * E_CHARGE;  // Współczynnik przyspieszenia jonów w polu E
constexpr double FACTOR_E           = DT_E / E_MASS * E_CHARGE;   // Współczynnik przyspieszenia elektronów w polu E

// =============================================================================
// Rozkłady strumieniowo-energetyczne jonów docierających do elektrod (IFED)
// =============================================================================

constexpr int    N_IFED             = 200;                        // Liczba przedziałów energii dla IFED
constexpr double DE_IFED            = 1.0;                        // Rozdzielczość energetyczna IFED [eV]
constexpr double INV_DE_IFED        = 1.0 / DE_IFED;              // 1.0 [1/eV]
constexpr double FACTOR_ENERGY_IFED = (0.5 * AR_MASS * INV_EV_TO_J) * INV_DE_IFED; // Konwersja v^2 -> indeks energii IFED (eliminuje 2x dzielenie)
typedef int      ifed_vector[N_IFED];                             // Tablica rozkładu IFED (histogram)

// =============================================================================
// Rozkłady czasoprzestrzenne (XT)
// =============================================================================

constexpr int    N_BIN              = 20;                         // Krok uśredniania XT
constexpr int    N_XT               = N_T / N_BIN;                // Liczba przedziałów czasowych XT (200)
typedef double   xt_distr[N_G][N_XT];                             // Macierz dla rozkładów czasoprzestrzennych

// =============================================================================
// Współczynniki kinematyki zderzeń (collision_electron)
// =============================================================================

constexpr double F1                 = E_MASS  / (E_MASS + AR_MASS); // Ułamek masy środek masy / elektron
constexpr double F2                 = AR_MASS / (E_MASS + AR_MASS); // Ułamek masy środek masy / atom argonu

// =============================================================================
// Współczynniki dla algorytmu Thomasa (solver Poissona)
// =============================================================================

constexpr double A                  =  1.0;                       // Poddiagonala macierzy trójdiagonalnej
constexpr double B                  = -2.0;                       // Główna przekątna
constexpr double C                  =  1.0;                       // Naddiagonala
constexpr double S                  = 1.0 / (2.0 * DX);           // Współczynnik różnicowy dla pola E
constexpr double ALPHA              = -DX * DX / EPSILON0;        // Współczynnik prawej strony Poissona
constexpr double ALPHA_Q            = ALPHA * E_CHARGE;           // -DX^2 * e / EPSILON0
constexpr double BETA_Q             = E_CHARGE * DX / (2.0 * EPSILON0); // Współczynnik brzegowy pola E
