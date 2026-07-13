#pragma once
#include <cmath>

// constants

const double     PI             = 3.141592653589793;          // mathematical constant Pi
const double     TWO_PI         = 2.0 * PI;                   // two times Pi
const double     E_CHARGE       = 1.60217662e-19;             // electron charge [C]
const double     EV_TO_J        = E_CHARGE;                   // eV <-> Joule conversion factor
const double     E_MASS         = 9.10938356e-31;             // mass of electron [kg]
const double     AR_MASS        = 6.63352090e-26;             // mass of argon atom [kg]
const double     MU_ARAR        = AR_MASS / 2.0;              // reduced mass of two argon atoms [kg]
const double     K_BOLTZMANN    = 1.38064852e-23;             // Boltzmann's constant [J/K]
const double     EPSILON0       = 8.85418781e-12;             // permittivity of free space [F/m]

// simulation parameters

const int        N_G            = 400;                        // number of grid points
const int        N_T            = 4000;                       // time steps within an RF period
const double     FREQUENCY      = 13.56e6;                    // driving frequency [Hz]
const double     VOLTAGE        = 250.0;                      // voltage amplitude [V]
const double     L              = 0.025;                      // electrode gap [m]
const double     PRESSURE       = 10.0;                       // gas pressure [Pa]
const double     TEMPERATURE    = 350.0;                      // background gas temperature [K]
const double     WEIGHT         = 7.0e4;                      // weight of superparticles
const double     ELECTRODE_AREA = 1.0e-4;                     // (fictive) electrode area [m^2]
const int        N_INIT         = 1000;                       // number of initial electrons and ions

// additional (derived) constants

const double     PERIOD         = 1.0 / FREQUENCY;                           // RF period length [s]
const double     DT_E           = PERIOD / (double)(N_T);                    // electron time step [s]
const int        N_SUB          = 20;                                        // ions move only in these cycles (subcycling)
const double     DT_I           = N_SUB * DT_E;                              // ion time step [s]
const double     DX             = L / (double)(N_G - 1);                     // spatial grid division [m]
const double     INV_DX         = 1.0 / DX;                                  // inverse of spatial grid size [1/m]
const double     GAS_DENSITY    = PRESSURE / (K_BOLTZMANN * TEMPERATURE);    // background gas density [1/m^3]
const double     OMEGA          = TWO_PI * FREQUENCY;                        // angular frequency [rad/s]

// electron and ion cross sections

const int        N_CS           = 5;                          // total number of processes / cross sections
const int        E_ELA          = 0;                          // process identifier: electron/elastic
const int        E_EXC          = 1;                          // process identifier: electron/excitation
const int        E_ION          = 2;                          // process identifier: electron/ionization
const int        I_ISO          = 3;                          // process identifier: ion/elastic/isotropic
const int        I_BACK         = 4;                          // process identifier: ion/elastic/backscattering
const double     E_EXC_TH       = 11.5;                       // electron impact excitation threshold [eV]
const double     E_ION_TH       = 15.8;                       // electron impact ionization threshold [eV]
const int        CS_RANGES      = 1000000;                    // number of entries in cross section arrays
const double     DE_CS          = 0.001;                      // energy division in cross section arrays [eV]
typedef float    cross_section[CS_RANGES];                    // cross section array

// particle coordinates

const int        MAX_N_P = 1000000;                           // maximum number of particles (electrons / ions)
typedef double   particle_vector[MAX_N_P];                    // array for particle properties
typedef double   xvector[N_G];                                // array for quantities defined at gird points
typedef unsigned long long int Ullong;                        // compact name for 64 bit unsigned integer

// electron energy probability function

const int    N_EEPF  = 2000;                                 // number of energy bins in Electron Energy Probability Function (EEPF)
const double DE_EEPF = 0.05;                                 // resolution of EEPF [eV]
typedef double eepf_vector[N_EEPF];                          // array for EEPF

// do_one_cycle() constants

const double MIN_X    = 0.45 * L;                       // min. position for EEPF collection
const double MAX_X    = 0.55 * L;                       // max. position for EEPF collection
const double DV       = ELECTRODE_AREA * DX;
const double FACTOR_W = WEIGHT / DV;
const double FACTOR_I = DT_I / AR_MASS * E_CHARGE;
const double FACTOR_E = DT_E / E_MASS * E_CHARGE;

// ion flux-energy distributions

const int    N_IFED   = 200;                                 // number of energy bins in Ion Flux-Energy Distributions (IFEDs)
const double DE_IFED  = 1.0;                                 // resolution of IFEDs [eV]
typedef int  ifed_vector[N_IFED];                            // array for IFEDs

// spatio-temporal (XT) distributions

const int N_BIN                     = 20;                    // number of time steps binned for the XT distributions
const int N_XT                      = N_T / N_BIN;           // number of spatial bins for the XT distributions
typedef double xt_distr[N_G][N_XT];                          // array for XT distributions (decimal numbers)
