import sys
import os
import constants as cs
from state import SimulationState
import cross_sections
import simulation
import io_manager


def init(sim: SimulationState, nseed: int):
    """
    Inicjalizacja symulacji poprzez umieszczenie danej ilosci
    elektronow i jonow w losowych pozycjach miedzy elektrodami
    """

    for i in range(nseed):
        sim.x_e[i] = cs.L * sim.rng.random()
        sim.vx_e[i] = 0
        sim.vy_e[i] = 0
        sim.vz_e[i] = 0

        sim.x_i[i] = cs.L * sim.rng.random()
        sim.vx_i[i] = 0
        sim.vy_i[i] = 0
        sim.vz_i[i] = 0

    sim.N_e = nseed
    sim.N_i = nseed


def main():
    """
    glowna funkcja symulacji. Przyjmuje argumenty:
    [1]: liczba cykli (0 dla init)
    [2]: "m" - uruchomienie trybu diagnostycznego
    """
    print(">> PyPIC: starting...")
    os.makedirs("results", exist_ok=True)

    if len(sys.argv) < 2:
        print(">> PyPIC: Error = need starting_cycle argument")
        sys.exit(1)

    try:
        arg1 = int(sys.argv[1])
    except ValueError:
        print(">> PyPIC: error = starting_cycle must be an integer")
        sys.exit(1)

    #   Obsluga trybu pomiarowego
    measurement_mode = False
    if len(sys.argv) > 2:
        if sys.argv[2] == "m":
            measurement_mode = True

    if measurement_mode:
        print(">> PyPIC: measurement mode: ON")
    else:
        print(">> PyPIC: measurement mode: OFF")

    #   Inicjalizacja symulacji
    sim = SimulationState()
    sim.measurement_mode = measurement_mode

    #   Wygenerowanie przekrojow czynnych
    cross_sections.set_electron_cross_sections_ar(sim)
    cross_sections.set_ion_cross_sections_ar(sim)
    cross_sections.calc_total_cross_sections(sim)

    if arg1 == 0:
        #   Zabezpieczenie przed przypadkowym nadpisaniem
        if os.path.exists("picdata.bin"):
            print(">> PyPIC: Warning: Data from previous calculation are detected.")
            print("           To start a new simulation from the beginning, please delete all output files before running python main.py 0")
            print("           To continue the existing calculation, please specify the number of cycles to run, e.g. python main.py 100")
            sys.exit(0)

        sim.no_of_cycles = 1
        sim.cycle = 1
        init(sim, cs.N_INIT)
        print(">> PyPIC: running initializing cycle")
        sim.Time = 0.0
        simulation.do_one_cycle(sim, "conv.dat")
        sim.cycles_done = 1
    else:
        sim.no_of_cycles = arg1
        #   Wczytanie kroku z inicjalizacji
        io_manager.load_particle_data(sim)
        print(f">> PyPIC: running {sim.no_of_cycles} cycle(s)")

        #   Glowna petla symulacji
        start_cycle = sim.cycles_done + 1
        end_cycle = sim.cycles_done + sim.no_of_cycles
        for cycle in range(start_cycle, end_cycle + 1):
            sim.cycle = cycle
            simulation.do_one_cycle(sim, "conv.dat")

        sim.cycles_done += sim.no_of_cycles

    #   Zapisanie stanu koncowego symulacji
    io_manager.save_particle_data(sim)

    #   Wygenerowanie raportu i zapis diagnostyk w trybie pomiarowym
    if sim.measurement_mode:
        io_manager.check_and_save_info(sim)

    print(f">> PyPIC: simulation of {sim.no_of_cycles} cycle(s) is completed.")


if __name__ == "__main__":
    main()
