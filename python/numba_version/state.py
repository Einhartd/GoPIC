import numpy as np
import constants as cs


class SimulationState:
    def __init__(self):
        # Cross sections
        self.sigma       = np.zeros((cs.N_CS, cs.CS_RANGES), dtype=np.float64)
        self.sigma_tot_e = np.zeros(cs.CS_RANGES, dtype=np.float64)
        self.sigma_tot_i = np.zeros(cs.CS_RANGES, dtype=np.float64)

        # Particle counts
        self.N_e = 0
        self.N_i = 0

        # Particle arrays (electron)
        self.x_e  = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vx_e = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vy_e = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vz_e = np.empty(cs.MAX_N_P, dtype=np.float64)

        # Particle arrays (ion)
        self.x_i  = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vx_i = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vy_i = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vz_i = np.empty(cs.MAX_N_P, dtype=np.float64)

        # Grid quantities
        self.efield          = np.zeros(cs.N_G, dtype=np.float64)
        self.pot             = np.zeros(cs.N_G, dtype=np.float64)
        self.e_density       = np.zeros(cs.N_G, dtype=np.float64)
        self.i_density       = np.zeros(cs.N_G, dtype=np.float64)
        self.cumul_e_density = np.zeros(cs.N_G, dtype=np.float64)
        self.cumul_i_density = np.zeros(cs.N_G, dtype=np.float64)

        # Absorption counters
        self.N_e_abs_pow = 0
        self.N_e_abs_gnd = 0
        self.N_i_abs_pow = 0
        self.N_i_abs_gnd = 0

        # EEPF & IFED
        self.eepf     = np.zeros(cs.N_EEPF, dtype=np.float64)
        self.ifed_pow = np.zeros(cs.N_IFED, dtype=np.int64)
        self.ifed_gnd = np.zeros(cs.N_IFED, dtype=np.int64)
        self.mean_i_energy_pow = 0.0
        self.mean_i_energy_gnd = 0.0

        # XT distributions — shape (N_G, N_XT)
        self.pot_xt        = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.efield_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ne_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ni_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ue_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ui_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.je_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ji_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.powere_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.poweri_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.meanee_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.meanei_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.counter_e_xt  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.counter_i_xt  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ioniz_rate_xt = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)

        # Global counters & time
        self.mean_energy_accu_center    = 0.0
        self.mean_energy_counter_center = 0
        self.N_e_coll = 0
        self.N_i_coll = 0
        self.Time         = 0.0
        self.cycle        = 0
        self.no_of_cycles = 0
        self.cycles_done  = 0
        self.measurement_mode = False
