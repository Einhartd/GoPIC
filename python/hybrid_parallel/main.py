import sys
import os
import numpy as np
import constants as cs
from state import SimulationState
import cross_sections
import simulation
import io_manager
from mpi4py import MPI


def init(sim: SimulationState, nseed: int):
    """
    Inicjalizacja symulacji poprzez umieszczenie danej ilości
    elektronów i jonów w losowych pozycjach między elektrodami.
    Dzieli nseed cząstek równomiernie na procesy MPI.
    """
    rank = sim.rank
    size = sim.size
    nseed_local = nseed // size + (1 if rank < nseed % size else 0)

    sim.x_e[:nseed_local]  = np.random.uniform(0.0, cs.L, nseed_local)
    sim.vx_e[:nseed_local] = 0.0
    sim.vy_e[:nseed_local] = 0.0
    sim.vz_e[:nseed_local] = 0.0

    sim.x_i[:nseed_local]  = np.random.uniform(0.0, cs.L, nseed_local)
    sim.vx_i[:nseed_local] = 0.0
    sim.vy_i[:nseed_local] = 0.0
    sim.vz_i[:nseed_local] = 0.0

    sim.N_e = nseed_local
    sim.N_i = nseed_local


def main():
    """
    Główna funkcja symulacji MPI + Numba Hybrid.
    """
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    if rank == 0:
        print(f">> PyPIC (Hybrid MPI+Numba): starting on {size} MPI rank(s)...")

    if len(sys.argv) < 2:
        if rank == 0:
            print(">> PyPIC: Error = need starting_cycle argument")
        sys.exit(1)

    try:
        arg1 = int(sys.argv[1])
    except ValueError:
        if rank == 0:
            print(">> PyPIC: error = starting_cycle must be an integer")
        sys.exit(1)

    measurement_mode = False
    if len(sys.argv) > 2:
        if sys.argv[2] == "m":
            measurement_mode = True

    if rank == 0:
        if measurement_mode:
            print(">> PyPIC: measurement mode: ON")
        else:
            print(">> PyPIC: measurement mode: OFF")

    sim = SimulationState(comm=comm)
    sim.measurement_mode = measurement_mode

    cross_sections.set_electron_cross_sections_ar(sim)
    cross_sections.set_ion_cross_sections_ar(sim)
    cross_sections.calc_total_cross_sections(sim)

    if cs.USE_NULL_COLLISION:
        import collisions
        collisions.compute_null_collision_params(sim)

    if arg1 == 0:
        if rank == 0 and os.path.exists("picdata.bin"):
            print(">> PyPIC: Warning: Data from previous calculation are detected.")
            print("           To start a new simulation from the beginning, please delete all output files before running python main.py 0")
            sys.exit(0)

        sim.no_of_cycles = 1
        sim.cycle = 1
        init(sim, cs.N_INIT)
        if rank == 0:
            print(">> PyPIC: running initializing cycle")
        sim.Time = 0.0
        simulation.do_one_cycle(sim, "conv.dat")
        sim.cycles_done = 1
    else:
        sim.no_of_cycles = arg1
        io_manager.load_particle_data(sim)
        if rank == 0:
            print(f">> PyPIC: running {sim.no_of_cycles} cycle(s)")

        start_cycle = sim.cycles_done + 1
        end_cycle = sim.cycles_done + sim.no_of_cycles
        for cycle in range(start_cycle, end_cycle + 1):
            sim.cycle = cycle
            simulation.do_one_cycle(sim, "conv.dat")

        sim.cycles_done += sim.no_of_cycles

    io_manager.save_particle_data(sim)

    if sim.measurement_mode:
        io_manager.check_and_save_info(sim)

    if rank == 0:
        print(f">> PyPIC: simulation of {sim.no_of_cycles} cycle(s) is completed.")


if __name__ == "__main__":
    main()
