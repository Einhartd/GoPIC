import sys
import numpy as np
import os

# Add src to python path for internal imports
sys.path.append(os.path.join(os.path.dirname(__file__), "src"))

from config.models import AppConfig
from core.state import SimulationState
from core.cross_sections import calculate_cross_sections
from core.engine import do_one_cycle
from utils.io import save_particle_data, load_particle_data
from utils.diagnostics import check_and_save_info


def print_header():
    print(">> PyPIC: starting...")
    print(
        ">> PyPIC: **************************************************************************"
    )
    print(">> PyPIC: Copyright (C) 2021 Z. Donko et al. (Python Rewrite)")
    print(">> PyPIC: This program comes with ABSOLUTELY NO WARRANTY")
    print(
        ">> PyPIC: This is free software, you are welcome to use, modify and redistribute it"
    )
    print(
        ">> PyPIC: according to the GNU General Public License, https://www.gnu.org/licenses/"
    )
    print(
        ">> PyPIC: **************************************************************************"
    )


def init_particles(state: SimulationState, rng: np.random.Generator):
    """Places initial electrons and ions at random positions between the electrodes."""
    cfg = state.cfg
    n_init = cfg.sim.N_INIT

    state.x_e[:n_init] = cfg.sim.L * rng.random(n_init)
    state.vx_e[:n_init] = 0.0
    state.vy_e[:n_init] = 0.0
    state.vz_e[:n_init] = 0.0

    state.x_i[:n_init] = cfg.sim.L * rng.random(n_init)
    state.vx_i[:n_init] = 0.0
    state.vy_i[:n_init] = 0.0
    state.vz_i[:n_init] = 0.0

    state.n_e = n_init
    state.n_i = n_init


def main():
    print_header()

    if len(sys.argv) < 2:
        print(">> PyPIC: error = need starting_cycle argument")
        sys.exit(1)

    try:
        arg1 = int(sys.argv[1])
    except ValueError:
        print(">> PyPIC: error = starting_cycle argument must be an integer")
        sys.exit(1)

    measurement_mode = False
    if len(sys.argv) > 2 and sys.argv[2] == "m":
        measurement_mode = True

    print(f">> PyPIC: measurement mode: {'on' if measurement_mode else 'off'}")

    # Initialize configuration and state
    cfg = AppConfig(measurement_mode=measurement_mode)
    state = SimulationState(cfg)

    # Initialize random number generator
    rng = np.random.default_rng()

    # Pre-calculate cross sections
    print(">> PyPIC: Setting e- / Ar and Ar+ / Ar cross sections")
    cross_sections = calculate_cross_sections(cfg)

    # Determine execution flow
    if arg1 == 0:
        if os.path.exists("picdata.bin"):
            print(">> PyPIC: Warning: Data from previous calculation are detected.")
            print(
                "           To start a new simulation from the beginning, please delete all output files before running ./PyPIC 0"
            )
            print(
                "           To continue the existing calculation, please specify the number of cycles to run, e.g. ./PyPIC 100"
            )
            sys.exit(0)

        no_of_cycles = 1
        state.cycle = 1
        init_particles(state, rng)
        print(">> PyPIC: running initializing cycle")
        state.time = 0.0

        do_one_cycle(state, cross_sections, rng)
        state.cycles_done = 1

    else:
        no_of_cycles = arg1
        if not load_particle_data(state):
            print(
                ">> PyPIC: ERROR: Cannot continue without initial data. Run with argument '0' first."
            )
            sys.exit(1)

        print(f">> PyPIC: running {no_of_cycles} cycle(s)")

        start_cycle = state.cycles_done + 1
        end_cycle = state.cycles_done + no_of_cycles

        for cycle in range(start_cycle, end_cycle + 1):
            state.cycle = cycle
            do_one_cycle(state, cross_sections, rng)

        state.cycles_done += no_of_cycles

    # Save end state and info
    save_particle_data(state)

    if cfg.measurement_mode:
        check_and_save_info(state, no_of_cycles, cross_sections)

    print(f">> PyPIC: simulation of {no_of_cycles} cycle(s) is completed.")


if __name__ == "__main__":
    main()
