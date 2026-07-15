import sys
import os
import importlib

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

class SimulationAdapter:
    """Adapter ujednolicający wywołania funkcji pętli głównej dla wszystkich wersji"""
    def __init__(self, version: str):
        self.version = version
        
        # 1. Wyczyszczenie sys.modules z poprzednich wersji, aby uniknąć problemów z cache
        for mod_name in ["constants", "state", "simulation", "poisson", "collisions", "cross_sections", "io_manager"]:
            if mod_name in sys.modules:
                del sys.modules[mod_name]
                
        # 2. Oczyszczenie sys.path z innych wersji
        for path in list(sys.path):
            if any(path.endswith(v) for v in ["native_version", "numpy_version", "numba_version"]):
                sys.path.remove(path)
                
        # 3. Dodanie aktualnej wersji na początek sys.path
        version_dir = os.path.join(ROOT_DIR, version)
        sys.path.insert(0, version_dir)
        
        # 4. Import modułów specyficznych dla danej wersji
        self.state_mod = importlib.import_module("state")
        self.sim_mod = importlib.import_module("simulation")
        self.cs_mod = importlib.import_module("constants")
        self.poisson_mod = importlib.import_module("poisson")
        self.cross_mod = importlib.import_module("cross_sections")

    def create_state(self):
        return self.state_mod.SimulationState()

    def solve_poisson(self, sim, rho, tt: float):
        self.poisson_mod.solve_poisson(sim, rho, tt)

    def setup_cross_sections(self, sim):
        self.cross_mod.set_electron_cross_sections_ar(sim)
        self.cross_mod.set_ion_cross_sections_ar(sim)
        self.cross_mod.calc_total_cross_sections(sim)

    def step1_compute_electron_density(self, sim):
        if self.version == "numba_version":
            self.sim_mod.step1_compute_electron_density(
                sim.x_e, sim.N_e, sim.e_density, sim.cumul_e_density,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_W, self.cs_mod.N_G
            )
        else:
            self.sim_mod.step1_compute_electron_density(sim)

    def step1_compute_ion_density(self, sim, t: int):
        if self.version == "numba_version":
            self.sim_mod.step1_compute_ion_density(
                sim.x_i, sim.N_i, sim.i_density, sim.cumul_i_density,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_W, self.cs_mod.N_G,
                t, self.cs_mod.N_SUB
            )
        else:
            self.sim_mod.step1_compute_ion_density(sim, t)

    def step3_move_electrons(self, sim, t_index: int):
        if self.version == "numba_version":
            self.sim_mod.step3_move_electrons(
                sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, sim.efield,
                sim.counter_e_xt, sim.ue_xt, sim.meanee_xt, sim.ioniz_rate_xt,
                sim.eepf, sim.sigma,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_E, self.cs_mod.DT_E, self.cs_mod.N_G,
                self.cs_mod.E_MASS, self.cs_mod.EV_TO_J, self.cs_mod.DE_CS, self.cs_mod.DE_EEPF,
                self.cs_mod.N_EEPF, self.cs_mod.CS_RANGES, self.cs_mod.GAS_DENSITY,
                self.cs_mod.MIN_X, self.cs_mod.MAX_X, self.cs_mod.E_ION,
                t_index, sim.measurement_mode
            )
        else:
            self.sim_mod.step3_move_electrons(sim, t_index)

    def step4_move_ions(self, sim, t_index: int, t: int):
        if self.version == "numba_version":
            self.sim_mod.step4_move_ions(
                sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, sim.efield,
                sim.counter_i_xt, sim.ui_xt, sim.meanei_xt,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_I, self.cs_mod.DT_I, self.cs_mod.N_G,
                self.cs_mod.AR_MASS, self.cs_mod.EV_TO_J,
                t_index, sim.measurement_mode, t, self.cs_mod.N_SUB
            )
        else:
            self.sim_mod.step4_move_ions(sim, t_index, t)

    def step5_check_boundaries_electrons(self, sim):
        if self.version == "numba_version":
            sim.N_e, abs_pow, abs_gnd = self.sim_mod.step5_check_boundaries_electrons(
                sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, self.cs_mod.L
            )
            sim.N_e_abs_pow += abs_pow
            sim.N_e_abs_gnd += abs_gnd
        else:
            self.sim_mod.step5_check_boundaries_electrons(sim)

    def step6_check_boundaries_ions(self, sim, t: int):
        if self.version == "numba_version":
            sim.N_i, abs_pow, abs_gnd = self.sim_mod.step6_check_boundaries_ions(
                sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, self.cs_mod.L,
                sim.ifed_pow, sim.ifed_gnd,
                self.cs_mod.AR_MASS, self.cs_mod.EV_TO_J, self.cs_mod.DE_IFED, self.cs_mod.N_IFED,
                t, self.cs_mod.N_SUB
            )
            sim.N_i_abs_pow += abs_pow
            sim.N_i_abs_gnd += abs_gnd
        else:
            self.sim_mod.step6_check_boundaries_ions(sim, t)