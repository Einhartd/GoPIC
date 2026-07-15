import sys
import os
import importlib
import pickle

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
SEED: int = 67

def get_adapter_and_modules(version: str):
    # Oczyszczenie sys.path i sys.modules
    for mod_name in ["constants", "state", "simulation", "poisson", "collisions", "cross_sections", "io_manager", "main"]:
        if mod_name in sys.modules:
            del sys.modules[mod_name]
    for path in list(sys.path):
        if any(path.endswith(v) for v in ["native_version", "numpy_version", "numba_version"]):
            sys.path.remove(path)
            
    version_dir = os.path.join(ROOT_DIR, version)
    sys.path.insert(0, version_dir)
    
    state_mod = importlib.import_module("state")
    sim_mod = importlib.import_module("simulation")
    cs_mod = importlib.import_module("constants")
    io_mod = importlib.import_module("io_manager")
    cross_mod = importlib.import_module("cross_sections")
    main_mod = importlib.import_module("main")
    
    return state_mod, sim_mod, cs_mod, io_mod, cross_mod, main_mod

def seed_rng(version: str, sim):
    if version == "native_version":
        sim.rng.seed(SEED)
    elif version == "numpy_version":
        import numpy as np
        sim.rng = np.random.default_rng(SEED)
    elif version == "numba_version":
        import numba
        import numpy as np
        # Zasilenie globalnego stanu numpy (dla wywołań w kodzie Pythona, np. w main.init)
        np.random.seed(SEED)
        # Zasilenie generatora wewnątrz kodu skompilowanego JIT Numba
        @numba.njit
        def _seed_numba(seed):
            np.random.seed(seed)
        _seed_numba(SEED)

def save_rng_state(version: str, sim, filepath="rng_state.pkl"):
    if version == "native_version":
        state = sim.rng.getstate()
        with open(filepath, "wb") as f:
            pickle.dump(state, f)
    elif version == "numpy_version":
        state = sim.rng.bit_generator.state
        with open(filepath, "wb") as f:
            pickle.dump(state, f)
    elif version == "numba_version":
        with open(filepath, "wb") as f:
            f.write(b"")

def load_rng_state(version: str, sim, filepath="rng_state.pkl"):
    if os.path.exists(filepath):
        if version == "native_version":
            with open(filepath, "rb") as f:
                state = pickle.load(f)
            sim.rng.setstate(state)
        elif version == "numpy_version":
            with open(filepath, "rb") as f:
                state = pickle.load(f)
            sim.rng.bit_generator.state = state
        elif version == "numba_version":
            seed_rng(version, sim)

def main():
    if len(sys.argv) < 3:
        print("Użycie: python run_regression.py <wersja> <krok> [ilosc_cykli]")
        print("  wersja: native_version | numpy_version | numba_version")
        print("  krok: init | run")
        print("  ilosc_cykli: int (domyślnie 5 dla run)")
        sys.exit(1)

    version = sys.argv[1]
    krok = sys.argv[2]
    
    state_mod, sim_mod, cs_mod, io_mod, cross_mod, main_mod = get_adapter_and_modules(version)
    
    if krok == "init":
        # Czyszczenie starych plików danych dla tej konkretnej wersji w bieżącym katalogu
        for filename in ["picdata.bin", "rng_state.pkl", "conv.dat", "density.dat"]:
            if os.path.exists(filename):
                os.remove(filename)

        sim = state_mod.SimulationState()
        sim.measurement_mode = False
        
        # Inicjalizacja przekrojów
        cross_mod.set_electron_cross_sections_ar(sim)
        cross_mod.set_ion_cross_sections_ar(sim)
        cross_mod.calc_total_cross_sections(sim)
        
        # Seeding
        seed_rng(version, sim)
        
        sim.no_of_cycles = 1
        sim.cycle = 1
        
        # Wywołanie funkcji init z modułu main danej wersji
        main_mod.init(sim, cs_mod.N_INIT)
        
        sim.Time = 0.0
        sim_mod.do_one_cycle(sim, "conv.dat")
        sim.cycles_done = 1
        
        # Zapis stanu
        io_mod.save_particle_data(sim)
        save_rng_state(version, sim)
        print(f"[{version}] Inicjalizacja zakonczona.")

    elif krok == "run":
        cycles = int(sys.argv[3]) if len(sys.argv) > 3 else 5
        
        sim = state_mod.SimulationState()
        sim.measurement_mode = False
        
        # Inicjalizacja przekrojów
        cross_mod.set_electron_cross_sections_ar(sim)
        cross_mod.set_ion_cross_sections_ar(sim)
        cross_mod.calc_total_cross_sections(sim)
        
        # Wczytanie stanu
        io_mod.load_particle_data(sim)
        load_rng_state(version, sim)
        
        sim.no_of_cycles = cycles
        start_cycle = sim.cycles_done + 1
        end_cycle = sim.cycles_done + sim.no_of_cycles
        
        print(f"[{version}] Uruchomienie cykli: {start_cycle} - {end_cycle}")
        for cycle in range(start_cycle, end_cycle + 1):
            sim.cycle = cycle
            sim_mod.do_one_cycle(sim, "conv.dat")
            
        sim.cycles_done += sim.no_of_cycles
        
        # Zapis stanu końcowego
        io_mod.save_particle_data(sim)
        save_rng_state(version, sim)
        print(f"[{version}] Przebieg zakonczony.")

if __name__ == "__main__":
    main()
