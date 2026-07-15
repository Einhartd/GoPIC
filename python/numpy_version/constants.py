from typing import Final
import math
import numpy as np
import numpy.typing as npt


#   CONSTANTS
PI: Final[float]                = math.pi
"""mathematical constant Pi"""
TWO_PI: Final[float]            = 2.0 * PI
"""two times Pi"""
E_CHARGE: Final[float]          = 1.60217662e-19
"""electron charge [C]"""
EV_TO_J: Final[float]           = E_CHARGE  
"""eV <-> Joule conversion factor"""
E_MASS: Final[float]            = 9.10938356e-31
"""mass of electron [kg]"""
AR_MASS: Final[float]           = 6.63352090e-26
"""mass of argon atom [kg]"""
MU_ARAR: Final[float]           = AR_MASS / 2.0
"""reduced mass of two argon atoms [kg]"""
K_BOLTZMANN: Final[float]       = 1.38064852e-23
"""Boltzmann's constant [J/K]"""
EPSILON0: Final[float]          = 8.85418781e-12
"""permittivity of free space [F/m]"""

#   SIMULATION PARAMETERS
N_G: Final[int]                 = 400
"""number of grid points"""
N_T: Final[int]                 = 4000   
"""time steps within an RF period"""
FREQUENCY: Final[float]         = 13.56e6
"""driving frequency [Hz]"""
VOLTAGE: Final[float]           = 250.0
"""voltage amplitude [V]"""
L: Final[float]                 = 0.025  
"""electrode gap [m]"""
PRESSURE: Final[float]          = 10.0   
"""gas pressure [Pa]"""
TEMPERATURE: Final[float]       = 350.0  
"""background gas temperature [K]"""
WEIGHT: Final[float]            = 7.0e4
"""weight of superparticles"""
ELECTRODE_AREA: Final[float]    = 1.0e-4
"""(fictive) electrode area [m^2]"""
N_INIT: Final[int]              = 1000   
"""number of initial electrons and ions"""

#   ADDITIONAL DERIVED CONSTANTS
PERIOD: Final[float]            = 1.0 / FREQUENCY 
"""RF period length [s]"""
DT_E: Final[float]              = PERIOD / N_T
"""electron time step [s]"""
N_SUB: Final[int]               = 20
"""ions move only in these cycles (subcycling)"""
DT_I: Final[float]              = N_SUB * DT_E 
"""ion time step [s]"""
DX: Final[float]                = L / (N_G - 1)
"""spatial grid division [m]"""
INV_DX: Final[float]            = 1.0 / DX
"""inverse of spatial grid size [1/m]"""
GAS_DENSITY: Final[float]       = PRESSURE / (K_BOLTZMANN * TEMPERATURE)
"""background gas density [1/m^3]"""
OMEGA: Final[float]             = TWO_PI * FREQUENCY 
"""angular frequency [rad/s]"""
#   do_one_cycle()
DV: Final[float]                = ELECTRODE_AREA * DX
FACTOR_W: Final[float]          = WEIGHT / DV
FACTOR_E: Final[float]          = DT_E / E_MASS * E_CHARGE
FACTOR_I: Final[float]          = DT_I / AR_MASS * E_CHARGE
MIN_X: Final[float]             = 0.45 * L
MAX_X: Final[float]             = 0.55 * L
#   collision_electron()
F1: Final[float] = E_MASS / (E_MASS + AR_MASS)
F2: Final[float] = AR_MASS / (E_MASS + AR_MASS)
#   solve_poisson()
A: Final[float] = 1.0
B: Final[float] = -2.0
C: Final[float] = 1.0
S: Final[float] = 1.0 / (2.0 * DX)
ALPHA: Final[float] = -DX * DX / EPSILON0

#   ELECTRON AND ION CROSS SECTIONS
N_CS: Final[int]                = 5
"""total number of processes / cross sections"""
E_ELA: Final[int]               = 0
"""process identifier: electron/elastic"""
E_EXC: Final[int]               = 1
"""process identifier: electron/excitation"""
E_ION: Final[int]               = 2
"""process identifier: electron/ionization"""
I_ISO: Final[int]               = 3
"""process identifier: ion/elastic/isotropic"""
I_BACK: Final[int]              = 4
"""process identifier: ion/elastic/backscattering"""
E_EXC_TH: Final[float]          = 11.5
"""electron impact excitation threshold [eV]"""
E_ION_TH: Final[float]          = 15.8
"""electron impact ionization threshold [eV]"""
CS_RANGES: Final[int]           = 1000000
"""number of entries in cross section arrays"""
DE_CS: Final[float]             = 0.001
"""energy division in cross section arrays [eV]"""

#   SIZES & LIMITS
MAX_N_P: Final[int]             = 1000000 
"""maximum number of particles (electrons / ions)"""
N_EEPF: Final[int]              = 2000
"""number of energy bins in Electron Energy Probability Function (EEPF)"""
DE_EEPF: Final[float]           = 0.05
"""resolution of EEPF [eV]"""
N_IFED: Final[int]              = 200
"""number of energy bins in Ion Flux-Energy Distributions (IFEDs)"""
DE_IFED: Final[float]           = 1.0
"""resolution of IFEDs [eV]"""

N_BIN: Final[int]               = 20
"""number of time steps binned for the XT distributions"""
N_XT: Final[int]                = N_T // N_BIN
"""number of spatial bins for the XT distributions"""

NORMAL_DISTRIBUTION: Final[float]      = math.sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)

USE_NULL_COLLISION: Final[bool]        = False
"""flag to switch between standard and null-collision methods"""

#   TYPE ALIASES
type cross_section              = npt.NDArray[np.float64]
"""cross section array"""
type particle_vector            = npt.NDArray[np.float64]
"""array for particle properties"""
type xvector                    = npt.NDArray[np.float64]
"""array for quantities defined at gird points"""
type eepf_vector                = npt.NDArray[np.float64]
"""array for EEPF"""
type ifed_vector                = npt.NDArray[np.int32]
"""array for IFEDs"""
type xt_distr                   = npt.NDArray[np.float64]
"""array for XT distributions (decimal numbers)"""