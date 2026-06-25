import constants as cs
import random


class SimulationState:
    def __init__(self):

        #   CROSS SECTIONS ARRAYS
        self.sigma: list[cs.cross_section] = [
            [0.0] * cs.CS_RANGES for _ in range(cs.N_CS)]
        """set of cross section arrays"""
        self.sigma_tot_e: cs.cross_section = [0.0] * cs.CS_RANGES
        """total macroscopic cross section of electrons"""
        self.sigma_tot_i: cs.cross_section = [0.0] * cs.CS_RANGES
        """total macroscopic cross section of ions"""

        #   PARTICLE COUNTERS
        self.N_e: int = 0
        """number of electrons"""
        self.N_i: int = 0
        """number of ions"""

        #   ELECTRON COORDINATES
        self.x_e: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of electrons (one spatial, three velocity components)"""
        self.vx_e: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of electrons (one spatial, three velocity components)"""
        self.vy_e: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of electrons (one spatial, three velocity components)"""
        self.vz_e: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of electrons (one spatial, three velocity components)"""

        #   ION COORDINATES
        self.x_i: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of ions (one spatial, three velocity components)"""
        self.vx_i: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of ions (one spatial, three velocity components)"""
        self.vy_i: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of ions (one spatial, three velocity components)"""
        self.vz_i: cs.particle_vector = [0.0] * cs.MAX_N_P
        """coordinates of ions (one spatial, three velocity components)"""

        #   GRID QUANTITIES
        self.efield: cs.xvector = [0.0] * cs.N_G
        """electric field"""
        self.pot: cs.xvector = [0.0] * cs.N_G
        """potential"""
        self.e_density: cs.xvector = [0.0] * cs.N_G
        """electron densities"""
        self.i_density: cs.xvector = [0.0] * cs.N_G
        """ion densities"""
        self.cumul_e_density: cs.xvector = [0.0] * cs.N_G
        """cumulative electron densities"""
        self.cumul_i_density: cs.xvector = [0.0] * cs.N_G
        """cumulative ion densities"""

        #   ABSORPTION COUNTERS
        self.N_e_abs_pow: int = 0
        """counter for electrons absorbed at the powered electrode"""
        self.N_e_abs_gnd: int = 0
        """counter for electrons absorbed at the grounded electrode"""
        self.N_i_abs_pow: int = 0
        """counter for ions absorbed at the powered electrode"""
        self.N_i_abs_gnd: int = 0
        """counter for ions absorbed at the grounded electrode"""

        #   EEPF & IFED
        self.eepf: cs.eepf_vector = [0.0] * cs.N_EEPF
        """time integrated EEPF in the center of the plasma"""
        self.ifed_pow: cs.ifed_vector = [0] * cs.N_IFED
        """IFED at the powered electrode"""
        self.ifed_gnd: cs.ifed_vector = [0] * cs.N_IFED
        """IFED at the grounded electrode"""
        self.mean_i_energy_pow: float = 0
        """mean ion energy at the powered electrode"""
        self.mean_i_energy_gnd: float = 0
        """mean ion energy at the grounded electrode"""

        #   SPATIO-TEMPORAL (XT) DISTRIBUTIONS
        self.pot_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the potential"""
        self.efield_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the electric field"""
        self.ne_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the electron density"""
        self.ni_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the ion density"""
        self.ue_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the mean electron velocity"""
        self.ui_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the mean ion velocity"""
        self.je_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the electron current density"""
        self.ji_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the ion current density"""
        self.powere_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the electron powering (power absorption) rate"""
        self.poweri_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the ion powering (power absorption) rate"""
        self.meanee_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the mean electron energy"""
        self.meanei_xt: cs.xt_distr = [[0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the mean ion energy"""
        self.counter_e_xt: cs.xt_distr = [
            [0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT counter for electron properties"""
        self.counter_i_xt: cs.xt_distr = [
            [0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT counter for ion properties"""
        self.ioniz_rate_xt: cs.xt_distr = [
            [0.0] * cs.N_XT for _ in range(cs.N_G)]
        """XT distribution of the ionisation rate"""

        #   GLOBAL COUNTERS & TIME
        self.mean_energy_accu_center: float = 0.0
        """mean electron energy accumulator in the center of the gap"""
        self.mean_energy_counter_center: int = 0
        """mean electron energy counter in the center of the gap"""
        self.N_e_coll: int = 0
        """counter for electron collisions"""
        self.N_i_coll: int = 0
        """counter for ion collisions"""

        self.Time: float = 0.0
        """total simulated time (from the beginning of the simulation)"""
        self.cycle: int = 0
        """current cycle"""
        self.no_of_cycles: int = 0
        """total cycles in the run"""
        self.cycles_done: int = 0
        """cycles completed"""
        self.measurement_mode: bool = False
        """flag that controls measurements and data saving"""

        self.rng = random.Random()
