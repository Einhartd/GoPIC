import math
from pydantic import BaseModel, Field

PI: float = math.pi  # mathematical constant Pi
TWO_PI: float = 2.0 * PI  # two times Pi
E_CHARGE: float = 1.60217662e-19  # electron charge [C]
EV_TO_J: float = E_CHARGE  # eV <-> Joule conversion factor
E_MASS: float = 9.10938356e-31  # mass of electron [kg]
AR_MASS: float = 6.63352090e-26  # mass of argon atom [kg]
MU_ARAR: float = AR_MASS / 2.0  # reduced mass of two argon atoms [kg]
K_BOLTZMANN: float = 1.38064852e-23  # Boltzmann's constant [J/K]
EPSILON0: float = 8.85418781e-12  # permittivity of free space [F/m]


class SimulationParams(BaseModel):
    """
    Base simulation parameters
    """

    N_G: int = Field(default=400, gt=0, description="number of grid points")
    N_T: int = Field(default=4000, gt=0,
                     description="time steps within an RF period")
    FREQUENCY: float = Field(default=13.56e6, gt=0.0,
                             description="driving frequency [Hz]")
    VOLTAGE: float = Field(default=250.0, gt=0.0,
                           description="voltage amplitude [V]")
    L: float = Field(default=0.025, gt=0.0, description="electrode gap [m]")
    PRESSURE: float = Field(default=10.0, gt=0.0,
                            description="gas pressure [Pa]")
    TEMPERATURE: float = Field(
        default=350.0, gt=0.0, description="background gas temperature [K]")
    WEIGHT: float = Field(default=7.0e4, gt=0.0,
                          description="weight/count of superparticles")
    ELECTRODE_AREA: float = Field(
        default=1.0e-4, gt=0.0, description="(fictive) electrode area [m^2]")
    N_INIT: int = Field(default=1000, gt=0,
                        description="number of initial electrons and ions")


cfg = SimulationParams()

#   additional (derived) constants
PERIOD: float = 1.0 / cfg.FREQUENCY  # RF period length [s]
DT_E: float = PERIOD / float(cfg.N_T)  # electron time step [s]
N_SUB: int = 20  # ions move only in these cycles (subcycling)
DT_I: float = float(N_SUB) * DT_E  # ion time step [s]
DX: float = cfg.L / float(cfg.N_G - 1)  # spatial grid division [m]
INV_DX: float = 1.0 / DX  # inverse of spatial grid size [1/m]
GAS_DENSITY: float = cfg.PRESSURE / \
    (K_BOLTZMANN * cfg.TEMPERATURE)  # background gas density [1/m^3]
OMEGA: float = TWO_PI * cfg.FREQUENCY  # angular frequency [rad/s]
