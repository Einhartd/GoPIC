import numpy as np
import constants as cs


class SimulationState:
    def __init__(self):
        # Cross sections
        self.sigma: cs.cross_section       = np.zeros((cs.N_CS, cs.CS_RANGES), dtype=np.float64)
        """set of cross section arrays"""
        self.sigma_tot_e: cs.cross_section = np.zeros(cs.CS_RANGES, dtype=np.float64)
        """total macroscopic cross section of electrons"""
        self.sigma_tot_i: cs.cross_section = np.zeros(cs.CS_RANGES, dtype=np.float64)
        """total macroscopic cross section of ions"""

        # Particle counts
        self.N_e: int = 0
        """number of electrons"""
        self.N_i: int = 0
        """number of ions"""

        # Particle arrays (electron)
        self.x_e  = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components)"""
        self.vx_e = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components)"""
        self.vy_e = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components)"""
        self.vz_e = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components)"""

        # Particle arrays (ion)
        self.x_i  = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components)"""
        self.vx_i = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components)"""
        self.vy_i = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components)"""
        self.vz_i = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components)"""

        # Grid quantities
        self.efield          = np.zeros(cs.N_G, dtype=np.float64)
        """electric field"""
        self.pot             = np.zeros(cs.N_G, dtype=np.float64)
        """potential"""
        self.e_density       = np.zeros(cs.N_G, dtype=np.float64)
        """electron densities"""
        self.i_density       = np.zeros(cs.N_G, dtype=np.float64)
        """ion densities"""
        self.cumul_e_density = np.zeros(cs.N_G, dtype=np.float64)
        """cumulative electron densities"""
        self.cumul_i_density = np.zeros(cs.N_G, dtype=np.float64)
        """cumulative ion densities"""

        # Absorption counters
        self.N_e_abs_pow = 0
        """counter for electrons absorbed at the powered electrode"""
        self.N_e_abs_gnd = 0
        """counter for electrons absorbed at the grounded electrode"""
        self.N_i_abs_pow = 0
        """counter for ions absorbed at the powered electrode"""
        self.N_i_abs_gnd = 0
        """counter for ions absorbed at the grounded electrode"""

        # EEPF & IFED
        self.eepf     = np.zeros(cs.N_EEPF, dtype=np.float64)
        """time integrated EEPF in the center of the plasma"""
        self.ifed_pow = np.zeros(cs.N_IFED, dtype=np.int64)
        """IFED at the powered electrode"""
        self.ifed_gnd = np.zeros(cs.N_IFED, dtype=np.int64)
        """IFED at the grounded electrode"""
        self.mean_i_energy_pow = 0.0
        """mean ion energy at the powered electrode"""
        self.mean_i_energy_gnd = 0.0
        """mean ion energy at the grounded electrode"""

        # XT distributions — shape (N_G, N_XT)
        self.pot_xt: cs.xt_distr        = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the potential"""
        self.efield_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electric field"""
        self.ne_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electron density"""
        self.ni_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ion density"""
        self.ue_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean electron velocity"""
        self.ui_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean ion velocity"""
        self.je_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electron current density"""
        self.ji_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ion current density"""
        self.powere_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electron powering (power absorption) rate"""
        self.poweri_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ion powering (power absorption) rate"""
        self.meanee_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean electron energy"""
        self.meanei_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean ion energy"""
        self.counter_e_xt  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT counter for electron properties"""
        self.counter_i_xt  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT counter for ion properties"""
        self.ioniz_rate_xt = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ionisation rate"""

        # Global counters & time
        self.mean_energy_accu_center: float  = 0.0
        """mean electron energy accumulator in the center of the gap"""
        self.mean_energy_counter_center: int = 0
        """mean electron energy counter in the center of the gap"""
        self.N_e_coll: int = 0
        """counter for electron collisions"""
        self.N_i_coll: int = 0
        """counter for ion collisions"""
        
        self.Time: float       = 0.0
        """total simulated time (from the beginning of the simulation)"""
        self.cycle: int        = 0
        """current cycle"""
        self.no_of_cycles: int = 0
        """total cycles in the run"""
        self.cycles_done: int  = 0
        """cycles completed"""
        self.measurement_mode: bool = False
        """flag that controls measurements and data saving"""