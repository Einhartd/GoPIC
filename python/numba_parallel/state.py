import numpy as np
import constants as cs
import numba as nb
import numpy.typing as npt


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
        self.x_e: np.ndarray  = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components) (MAX_N_P)"""
        self.vx_e: np.ndarray = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components) (MAX_N_P)"""
        self.vy_e: np.ndarray = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components) (MAX_N_P)"""
        self.vz_e: np.ndarray = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of electrons (one spatial, three velocity components) (MAX_N_P)"""

        # Particle arrays (ion)
        self.x_i: np.ndarray  = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components) (MAX_N_P)"""
        self.vx_i: np.ndarray = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components) (MAX_N_P)"""
        self.vy_i: np.ndarray = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components) (MAX_N_P)"""
        self.vz_i: np.ndarray = np.empty(cs.MAX_N_P, dtype=np.float64)
        """coordinates of ions (one spatial, three velocity components) (MAX_N_P)"""

        # Grid quantities
        self.efield: np.ndarray          = np.zeros(cs.N_G, dtype=np.float64)
        """electric field (N_G)"""
        self.pot: np.ndarray             = np.zeros(cs.N_G, dtype=np.float64)
        """potential (N_G)"""
        self.e_density: np.ndarray       = np.zeros(cs.N_G, dtype=np.float64)
        """electron densities (N_G)"""
        self.i_density: np.ndarray       = np.zeros(cs.N_G, dtype=np.float64)
        """ion densities (N_G)"""
        self.cumul_e_density: np.ndarray = np.zeros(cs.N_G, dtype=np.float64)
        """cumulative electron densities (N_G)"""
        self.cumul_i_density: np.ndarray = np.zeros(cs.N_G, dtype=np.float64)
        """cumulative ion densities (N_G)"""

        # Absorption counters
        self.N_e_abs_pow: int = 0
        """counter for electrons absorbed at the powered electrode"""
        self.N_e_abs_gnd: int = 0
        """counter for electrons absorbed at the grounded electrode"""
        self.N_i_abs_pow: int = 0
        """counter for ions absorbed at the powered electrode"""
        self.N_i_abs_gnd: int = 0
        """counter for ions absorbed at the grounded electrode"""

        # EEPF & IFED
        self.eepf: np.ndarray     = np.zeros(cs.N_EEPF, dtype=np.float64)
        """time integrated EEPF in the center of the plasma (N_EEPF)"""
        self.ifed_pow: np.ndarray = np.zeros(cs.N_IFED, dtype=np.int64)
        """IFED at the powered electrode (N_IFED)"""
        self.ifed_gnd: np.ndarray = np.zeros(cs.N_IFED, dtype=np.int64)
        """IFED at the grounded electrode (N_IFED)"""

        self.mean_i_energy_pow: float = 0.0
        """mean ion energy at the powered electrode"""
        self.mean_i_energy_gnd: float = 0.0
        """mean ion energy at the grounded electrode"""

        # XT distributions — shape (N_G, N_XT)
        self.pot_xt: cs.xt_distr        = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the potential (N_G, N_XT)"""
        self.efield_xt: cs.xt_distr     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electric field (N_G, N_XT)"""
        self.ne_xt: cs.xt_distr         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electron density (N_G, N_XT)"""
        self.ni_xt: cs.xt_distr         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ion density (N_G, N_XT)"""
        self.ue_xt: cs.xt_distr         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean electron velocity (N_G, N_XT)"""
        self.ui_xt : cs.xt_distr        = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean ion velocity (N_G, N_XT)"""
        self.je_xt: cs.xt_distr         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electron current density (N_G, N_XT)"""
        self.ji_xt: cs.xt_distr         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ion current density (N_G, N_XT)"""
        self.powere_xt: cs.xt_distr     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the electron powering (power absorption) rate (N_G, N_XT)"""
        self.poweri_xt: cs.xt_distr     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ion powering (power absorption) rate (N_G, N_XT)"""
        self.meanee_xt: cs.xt_distr     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean electron energy (N_G, N_XT)"""
        self.meanei_xt: cs.xt_distr     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the mean ion energy (N_G, N_XT)"""
        self.counter_e_xt: cs.xt_distr  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT counter for electron properties (N_G, N_XT)"""
        self.counter_i_xt: cs.xt_distr  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT counter for ion properties (N_G, N_XT)"""
        self.ioniz_rate_xt: cs.xt_distr = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        """XT distribution of the ionisation rate (N_G, N_XT)"""

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

        # Null-collision precomputed parameters
        self.nu_star_e: float = 0.0
        self.P_star_e:  float = 0.0
        self.nu_star_i: float = 0.0
        self.P_star_i:  float = 0.0

        #   PARALLEL IMPLEMENTATION
        self.num_threads: int = nb.get_num_threads()
        """Number of allocated threads for parallel simulation"""

        # Pre-allocated rho buffer
        self.rho: np.ndarray = np.zeros(cs.N_G, dtype=np.float64)

        # electron and ion density buffers for threads
        self.local_e_density: np.ndarray  = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        """Buffer for electron density (num_threads x N_G)"""
        self.local_i_density: np.ndarray = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        """Buffer for ion density (num_threads x N_G)"""

        # Thread-local buffers for XT and EEPF measurement reduction (data-race free)
        self.local_counter_e_xt: np.ndarray   = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        self.local_ue_xt: np.ndarray          = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        self.local_meanee_xt: np.ndarray      = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        self.local_ioniz_rate_xt: np.ndarray  = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        self.local_eepf: np.ndarray           = np.zeros((self.num_threads, cs.N_EEPF), dtype=np.float64)
        self.local_accu_center: np.ndarray    = np.zeros(self.num_threads, dtype=np.float64)
        self.local_counter_center: np.ndarray = np.zeros(self.num_threads, dtype=np.int64)

        self.local_counter_i_xt: np.ndarray   = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        self.local_ui_xt: np.ndarray          = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)
        self.local_meanei_xt: np.ndarray      = np.zeros((self.num_threads, cs.N_G), dtype=np.float64)

        # Thread buffers for 2-phase parallel collision selection and zero-alloc null collision sampling
        self.thread_coll_indices_e: np.ndarray = np.zeros((self.num_threads, cs.MAX_N_P), dtype=np.int64)
        self.thread_coll_counts_e: np.ndarray  = np.zeros(self.num_threads, dtype=np.int64)
        self.thread_coll_indices_i: np.ndarray = np.zeros((self.num_threads, cs.MAX_N_P), dtype=np.int64)
        self.thread_coll_counts_i: np.ndarray  = np.zeros(self.num_threads, dtype=np.int64)
        self.null_coll_buffer: np.ndarray      = np.zeros(cs.MAX_N_P, dtype=np.int64)

        self.thread_coll_vxa_i: np.ndarray = np.zeros((self.num_threads, cs.MAX_N_P), dtype=np.float64)
        self.thread_coll_vya_i: np.ndarray = np.zeros((self.num_threads, cs.MAX_N_P), dtype=np.float64)
        self.thread_coll_vza_i: np.ndarray = np.zeros((self.num_threads, cs.MAX_N_P), dtype=np.float64)
