#pragma once
#include <cmath>

// =============================================================================
// Stałe fizyczne i matematyczne
// =============================================================================

constexpr double PI             = 3.141592653589793;          // mathematical constant Pi
constexpr double TWO_PI         = 2.0 * PI;                   // two times Pi
constexpr double E_CHARGE       = 1.60217662e-19;             // electron charge [C]
constexpr double EV_TO_J        = E_CHARGE;                   // eV <-> Joule conversion factor
constexpr double E_MASS         = 9.10938356e-31;             // mass of electron [kg]
constexpr double AR_MASS        = 6.63352090e-26;             // mass of argon atom [kg]
constexpr double MU_ARAR        = AR_MASS / 2.0;              // reduced mass of two argon atoms [kg]
constexpr double K_BOLTZMANN    = 1.38064852e-23;             // Boltzmann's constant [J/K]
constexpr double EPSILON0       = 8.85418781e-12;             // permittivity of free space [F/m]

// =============================================================================
// Główne parametry symulacji
// =============================================================================

constexpr int    N_G            = 400;                        // number of grid points
constexpr int    N_T            = 4000;                       // time steps within an RF period
constexpr double FREQUENCY      = 13.56e6;                    // driving frequency [Hz]
constexpr double VOLTAGE        = 250.0;                      // voltage amplitude [V]
constexpr double L              = 0.025;                      // electrode gap [m]
constexpr double PRESSURE       = 10.0;                       // gas pressure [Pa]
constexpr double TEMPERATURE    = 350.0;                      // background gas temperature [K]
constexpr double WEIGHT         = 7.0e4;                      // weight of superparticles
constexpr double ELECTRODE_AREA = 1.0e-4;                     // (fictive) electrode area [m^2]
constexpr int    N_INIT         = 1000;                       // number of initial electrons and ions

// =============================================================================
// Stałe pochodne
// =============================================================================

constexpr double PERIOD         = 1.0 / FREQUENCY;                           // RF period length [s]
constexpr double DT_E           = PERIOD / (double)(N_T);                    // electron time step [s]
constexpr int    N_SUB          = 20;                                        // ions move only in these cycles (subcycling)
constexpr double DT_I           = N_SUB * DT_E;                              // ion time step [s]
constexpr double DX             = L / (double)(N_G - 1);                     // spatial grid division [m]
constexpr double INV_DX         = 1.0 / DX;                                  // inverse of spatial grid size [1/m]
constexpr double GAS_DENSITY    = PRESSURE / (K_BOLTZMANN * TEMPERATURE);    // background gas density [1/m^3]
constexpr double OMEGA          = TWO_PI * FREQUENCY;                        // angular frequency [rad/s]

// =============================================================================
// Przekroje czynne i procesy
// =============================================================================

constexpr int    N_CS           = 5;                          // total number of processes / cross sections
constexpr int    E_ELA          = 0;                          // process identifier: electron/elastic
constexpr int    E_EXC          = 1;                          // process identifier: electron/excitation
constexpr int    E_ION          = 2;                          // process identifier: electron/ionization
constexpr int    I_ISO          = 3;                          // process identifier: ion/elastic/isotropic
constexpr int    I_BACK         = 4;                          // process identifier: ion/elastic/backscattering
constexpr double E_EXC_TH       = 11.5;                       // electron impact excitation threshold [eV]
constexpr double E_ION_TH       = 15.8;                       // electron impact ionization threshold [eV]
constexpr int    CS_RANGES      = 1000000;                    // number of entries in cross section arrays
constexpr double DE_CS          = 0.001;                      // energy division in cross section arrays [eV]
typedef float    cross_section[CS_RANGES];                    // cross section array

// =============================================================================
// Koordynaty cząstek i typy wektorowe
// =============================================================================

constexpr int    MAX_N_P        = 1000000;                    // maximum number of particles (electrons / ions)
typedef double   particle_vector[MAX_N_P];                    // array for particle properties
typedef double   xvector[N_G];                                // array for quantities defined at grid points
typedef unsigned long long int Ullong;                        // compact name for 64 bit unsigned integer

// =============================================================================
// Rozkłady EEPF, IFED oraz czasowo-przestrzenne (XT)
// =============================================================================

constexpr int    N_EEPF         = 2000;                       // number of energy bins in EEPF
constexpr double DE_EEPF        = 0.05;                       // resolution of EEPF [eV]
typedef double   eepf_vector[N_EEPF];                         // array for EEPF

constexpr int    N_IFED         = 200;                        // number of energy bins in IFEDs
constexpr double DE_IFED        = 1.0;                        // resolution of IFEDs [eV]
typedef int      ifed_vector[N_IFED];                         // array for IFEDs

constexpr int    N_BIN          = 20;                         // number of time steps binned for the XT distributions
constexpr int    N_XT           = N_T / N_BIN;                // number of spatial bins for the XT distributions
typedef double   xt_distr[N_G][N_XT];                         // array for XT distributions (decimal numbers)

// =============================================================================
// Stałe kinematyki zderzeń (hoisted z collision_electron)
// =============================================================================

constexpr double F1             = E_MASS  / (E_MASS + AR_MASS);
constexpr double F2             = AR_MASS / (E_MASS + AR_MASS);

// =============================================================================
// Współczynniki algorytmu Thomasa i Poissona (hoisted z poisson.h)
// =============================================================================

constexpr double A              =  1.0;
constexpr double B              = -2.0;
constexpr double C              =  1.0;
constexpr double S              = 1.0 / (2.0 * DX);
constexpr double ALPHA          = -DX * DX / EPSILON0;
constexpr double ALPHA_Q        = ALPHA * E_CHARGE;                 // Fuzja: -DX^2 * e / EPSILON0
constexpr double BETA_Q         = E_CHARGE * DX / (2.0 * EPSILON0); // Współczynnik brzegowy pola E

// =============================================================================
// Stałe pętli głównej i diagnostyki (hoisted z do_one_cycle)
// =============================================================================

constexpr double DV             = ELECTRODE_AREA * DX;
constexpr double FACTOR_W       = WEIGHT / DV;
constexpr double FACTOR_E       = DT_E / E_MASS * E_CHARGE;
constexpr double FACTOR_I       = DT_I / AR_MASS * E_CHARGE;
constexpr double MIN_X          = 0.45 * L;
constexpr double MAX_X          = 0.55 * L;