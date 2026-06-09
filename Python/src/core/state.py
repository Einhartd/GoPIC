import numpy as np
from config.models import AppConfig


class SimulationState:
    """
    Manages the dynamic state of the PIC simulation using NumPy arrays for performance.
    All arrays are pre-allocated to avoid dynamic resizing.
    """

    def __init__(self, cfg: AppConfig):
        self.cfg = cfg

        # --- Particle Data ---
        max_p: int = cfg.sim.MAX_N_P
        self.n_e = 0
        self.n_i = 0

        # Electrons (x spatial, 3 velocity components)
        self.x_e = np.zeros(max_p, dtype=np.float64)
        self.vx_e = np.zeros(max_p, dtype=np.float64)
        self.vy_e = np.zeros(max_p, dtype=np.float64)
        self.vz_e = np.zeros(max_p, dtype=np.float64)

        # Ions (x spatial, 3 velocity components)
        self.x_i = np.zeros(max_p, dtype=np.float64)
        self.vx_i = np.zeros(max_p, dtype=np.float64)
        self.vy_i = np.zeros(max_p, dtype=np.float64)
        self.vz_i = np.zeros(max_p, dtype=np.float64)

        # --- Grid Quantities ---
        n_g = cfg.sim.N_G
        self.efield = np.zeros(n_g, dtype=np.float64)
        self.pot = np.zeros(n_g, dtype=np.float64)
        self.e_density = np.zeros(n_g, dtype=np.float64)
        self.i_density = np.zeros(n_g, dtype=np.float64)
        self.cumul_e_density = np.zeros(n_g, dtype=np.float64)
        self.cumul_i_density = np.zeros(n_g, dtype=np.float64)

        # --- Absorption Counters ---
        self.n_e_abs_pow = 0
        self.n_e_abs_gnd = 0
        self.n_i_abs_pow = 0
        self.n_i_abs_gnd = 0

        # --- Diagnostic Data ---
        self.eepf = np.zeros(cfg.diag.N_EEPF, dtype=np.float64)
        self.ifed_pow = np.zeros(cfg.diag.N_IFED, dtype=np.int32)
        self.ifed_gnd = np.zeros(cfg.diag.N_IFED, dtype=np.int32)

        # Spatio-temporal (XT) distributions
        n_xt = cfg.N_XT
        xt_shape = (n_g, n_xt)
        self.pot_xt = np.zeros(xt_shape, dtype=np.float64)
        self.efield_xt = np.zeros(xt_shape, dtype=np.float64)
        self.ne_xt = np.zeros(xt_shape, dtype=np.float64)
        self.ni_xt = np.zeros(xt_shape, dtype=np.float64)
        self.ue_xt = np.zeros(xt_shape, dtype=np.float64)
        self.ui_xt = np.zeros(xt_shape, dtype=np.float64)
        self.je_xt = np.zeros(xt_shape, dtype=np.float64)
        self.ji_xt = np.zeros(xt_shape, dtype=np.float64)
        self.powere_xt = np.zeros(xt_shape, dtype=np.float64)
        self.poweri_xt = np.zeros(xt_shape, dtype=np.float64)
        self.meanee_xt = np.zeros(xt_shape, dtype=np.float64)
        self.meanei_xt = np.zeros(xt_shape, dtype=np.float64)
        self.counter_e_xt = np.zeros(xt_shape, dtype=np.float64)
        self.counter_i_xt = np.zeros(xt_shape, dtype=np.float64)
        self.ioniz_rate_xt = np.zeros(xt_shape, dtype=np.float64)

        # --- Accumulators for Info ---
        self.mean_energy_accu_center = 0.0
        self.mean_energy_counter_center = 0
        self.n_e_coll = 0
        self.n_i_coll = 0

        # --- Simulation Progress ---
        self.time = 0.0
        self.cycle = 0
        self.cycles_done = 0
