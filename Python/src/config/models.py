from pydantic import BaseModel, Field, computed_field
import math


class PhysicalConstants(BaseModel):
    """Universal physical constants used in the simulation."""

    PI: float = math.pi
    E_CHARGE: float = 1.60217662e-19  # Electron charge [C]
    E_MASS: float = 9.10938356e-31  # Mass of electron [kg]
    AR_MASS: float = 6.63352090e-26  # Mass of argon atom [kg]
    K_BOLTZMANN: float = 1.38064852e-23  # Boltzmann's constant [J/K]
    EPSILON0: float = 8.85418781e-12  # Permittivity of free space [F/m]

    @computed_field
    @property
    def TWO_PI(self) -> float:
        return 2.0 * self.PI

    @computed_field
    @property
    def EV_TO_J(self) -> float:
        return self.E_CHARGE

    @computed_field
    @property
    def MU_ARAR(self) -> float:
        """Reduced mass of two argon atoms [kg]"""
        return self.AR_MASS / 2.0


class SimulationParams(BaseModel):
    """Primary simulation control parameters."""

    N_G: int = Field(default=400, gt=0, description="Number of grid points")
    N_T: int = Field(default=4000, gt=0, description="Time steps within an RF period")
    FREQUENCY: float = Field(
        default=13.56e6, gt=0.0, description="Driving frequency [Hz]"
    )
    VOLTAGE: float = Field(default=250.0, gt=0.0, description="Voltage amplitude [V]")
    L: float = Field(default=0.025, gt=0.0, description="Electrode gap [m]")
    PRESSURE: float = Field(default=10.0, gt=0.0, description="Gas pressure [Pa]")
    TEMPERATURE: float = Field(
        default=350.0, gt=0.0, description="Background gas temperature [K]"
    )
    WEIGHT: float = Field(
        default=7.0e4, gt=0.0, description="Weight/count of superparticles"
    )
    ELECTRODE_AREA: float = Field(
        default=1.0e-4, gt=0.0, description="(fictive) electrode area [m^2]"
    )
    N_INIT: int = Field(
        default=1000, gt=0, description="Number of initial electrons and ions"
    )
    N_SUB: int = Field(default=20, gt=0, description="Ion subcycling factor")
    MAX_N_P: int = Field(
        default=1000000, gt=0, description="Maximum number of particles"
    )


class CrossSectionParams(BaseModel):
    """Parameters for collision cross-section calculations."""

    N_CS: int = 5
    E_EXC_TH: float = 11.5  # [eV]
    E_ION_TH: float = 15.8  # [eV]
    CS_RANGES: int = 1000000
    DE_CS: float = 0.001  # [eV]


class DiagnosticParams(BaseModel):
    """Configuration for data collection and diagnostics."""

    N_EEPF: int = 2000
    DE_EEPF: float = 0.05  # [eV]
    N_IFED: int = 200
    DE_IFED: float = 1.0  # [eV]
    N_BIN: int = 20  # Time steps binned for XT distributions


class AppConfig(BaseModel):
    """Aggregated application configuration with derived constants."""

    const: PhysicalConstants = PhysicalConstants()
    sim: SimulationParams = SimulationParams()
    cs: CrossSectionParams = CrossSectionParams()
    diag: DiagnosticParams = DiagnosticParams()

    measurement_mode: bool = True

    @computed_field
    @property
    def PERIOD(self) -> float:
        return 1.0 / self.sim.FREQUENCY

    @computed_field
    @property
    def DT_E(self) -> float:
        return self.PERIOD / float(self.sim.N_T)

    @computed_field
    @property
    def DT_I(self) -> float:
        return float(self.sim.N_SUB) * self.DT_E

    @computed_field
    @property
    def DX(self) -> float:
        return self.sim.L / float(self.sim.N_G - 1)

    @computed_field
    @property
    def INV_DX(self) -> float:
        return 1.0 / self.DX

    @computed_field
    @property
    def GAS_DENSITY(self) -> float:
        return self.sim.PRESSURE / (self.const.K_BOLTZMANN * self.sim.TEMPERATURE)

    @computed_field
    @property
    def OMEGA(self) -> float:
        return self.const.TWO_PI * self.sim.FREQUENCY

    @computed_field
    @property
    def N_XT(self) -> int:
        return self.sim.N_T // self.diag.N_BIN
