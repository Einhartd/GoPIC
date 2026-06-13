from typing import Final, TypeAlias
import math


#   CONSTANTS

PI              = math.pi               #   mathematical constant Pi
TWO_PI          = 2.0 * PI              #   two times Pi
E_CHARGE        = 1.60217662e-19        #   electron charge [C]
EV_TO_J         = E_CHARGE              #   eV <-> Joule conversion factor
E_MASS          = 9.10938356e-31        #   mass of electron [kg]
AR_MASS         = 6.63352090e-26        #   mass of argon atom [kg]
MU_ARAR         = AR_MASS / 2.0         #   reduced mass of two argon atoms [kg]
K_BOLTZMANN     = 1.38064852e-23        #   Boltzmann's constant [J/K]
EPSILON0        = 8.85418781e-12        #   permittivity of free space [F/m]

#   SIMULATION PARAMETERS

N_G             = 400                   #   number of grid points
N_T             = 4000                  #   time steps within an RF period
FREQUENCY       = 13.56e6               #   driving frequency [Hz]
VOLTAGE         = 250.0                 #   voltage amplitude [V]
L               = 0.025                 #   electrode gap [m]
PRESSURE        = 10.0                  #   gas pressure [Pa]
TEMPERATURE     = 350.0                 #   background gas temperature [K]
WEIGHT          = 7.0e4                 #   weight of superparticles
ELECTRODE_AREA  = 1.0e-4                #   (fictive) electrode area [m^2]
N_INIT          = 1000                  #   number of initial electrons and ions

#   ADDITIONAL DERIVED CONSTANTS

PERIOD          = 1.0 / FREQUENCY                           #   RF period length [s]
DT_E            = PERIOD / N_T                              #   electron time step [s]
N_SUB           = 20                                        #   ions move only in these cycles (subcycling)       
DT_I            = N_SUB * DT_E                              #   ion time step [s]
DX              = L / (N_G - 1)                             #   spatial grid division [m]
INV_DX          = 1.0 / DX                                  #   inverse of spatial grid size [1/m]
GAS_DENSITY     = PRESSURE / (K_BOLTZMANN * TEMPERATURE)    #   background gas density [1/m^3]
OMEGA           = TWO_PI * FREQUENCY                        #   angular frequency [rad/s]

#   ELECTRON AND ION CROSS SECTIONS

N_CS                            = 5                                             #   total number of processes / cross sections
E_ELA                           = 0                                             #   process identifier: electron/elastic
E_EXC                           = 1                                             #   process identifier: electron/excitation
E_ION                           = 2                                             #   process identifier: electron/ionization
I_ISO                           = 3                                             #   process identifier: ion/elastic/isotropic
I_BACK                          = 4                                             #   process identifier: ion/elastic/backscattering
E_EXC_TH                        = 11.5                                          #   electron impact excitation threshold [eV]
E_ION_TH                        = 15.8                                          #   electron impact ionization threshold [eV]
CS_RANGES                       = 1000000                                       #   number of entries in cross section arrays
DE_CS                           = 0.001                                         #   energy division in cross section arrays [eV]
type cross_section              = list[float]                                   #   cross section array
sigma: list[cross_section]      = [[0.0] * CS_RANGES for _ in range(N_CS)]      #   set of cross section arrays
sigma_tot_e: cross_section      = [0.0] * CS_RANGES                             #   total macroscopic cross section of electrons
sigma_tot_i: cross_section      = [0.0] * CS_RANGES                             #   total macroscopic cross section of ions

#   PARTICLE COORDINATES

MAX_N_P                         = 1000000                   #   maximum number of particles (electrons / ions)
type particle_vector            = list[float]               #   array for particle properties

N_e                             = 0                         #   number of electrons
N_i                             = 0                         #   number of ions

x_e: particle_vector            = [0.0] * MAX_N_P           #   coordinates of electrons (one spatial, three velocity components)
vx_e: particle_vector           = [0.0] * MAX_N_P           #   coordinates of electrons (one spatial, three velocity components)
vy_e: particle_vector           = [0.0] * MAX_N_P           #   coordinates of electrons (one spatial, three velocity components)
vz_e: particle_vector           = [0.0] * MAX_N_P           #   coordinates of electrons (one spatial, three velocity components)

x_i: particle_vector            = [0.0] * MAX_N_P           #   coordinates of ions (one spatial, three velocity components)
vx_i: particle_vector           = [0.0] * MAX_N_P           #   coordinates of ions (one spatial, three velocity components)
vy_i: particle_vector           = [0.0] * MAX_N_P           #   coordinates of ions (one spatial, three velocity components)
vz_i: particle_vector           = [0.0] * MAX_N_P           #   coordinates of ions (one spatial, three velocity components)

type xvector                    = list[float]               #   array for quantities defined at gird points
efield                          = [0.0] * N_G               #   electric field
pot                             = [0.0] * N_G               #   potential
e_density                       = [0.0] * N_G               #   electron densities
i_density                       = [0.0] * N_G               #   ion densities
cumul_e_density                 = [0.0] * N_G               #   cumulative electron densities
cumul_i_density                 = [0.0] * N_G               #   cumulative ion densities

N_e_abs_pow                     = 0                         #   counter for electrons absorbed at the powered electrode
N_e_abs_gnd                     = 0                         #   counter for electrons absorbed at the grounded electrode
N_i_abs_pow                     = 0                         #   counter for ions absorbed at the powered electrode
N_i_abs_gnd                     = 0                         #   counter for ions absorbed at the grounded electrode

#   ELECTRON ENERGY PROBABILITY FUNCTION

N_EEPF                          = 2000                      #   number of energy bins in Electron Energy Probability Function (EEPF)
DE_EEPF                         = 0.05                      #   resolution of EEPF [eV]
type eepf_vector                = list[float]               #   array for EEPF
eepf: eepf_vector               = [0.0] * N_EEPF            #   time integrated EEPF in the center of the plasma