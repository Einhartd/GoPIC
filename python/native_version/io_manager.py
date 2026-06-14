import struct
import math
import os
import constants as cs
from state import SimulationState


def save_particle_data(sim: SimulationState):
    """
    Zapisuje stan symulacji do pliku binarnego.
    """
    with open("picdata.bin", "wb") as f:
        #   Zapis zmiennych pojedynczych
        """
        struct.pack() pakuje zmienne z formatu Pythona do C
        "d" - oznacza zmienną typu double
        W tym przypadku konwertujemy dane z float pythonowego do double z C
        """
        f.write(struct.pack("d", sim.Time))
        f.write(struct.pack("d", float(sim.cycles_done)))
        f.write(struct.pack("d", float(sim.N_e)))

        #   Zapis tablic elektronów
        """
        Składnia f"{sim.N_e}d" mówi: "spakuj N_e elementów jako podwójnej precyzji floaty".
        Operator '*' rozpakowuje wycinek listy jako argumenty dla funkcji pack.
        """
        f.write(struct.pack(f"{sim.N_e}d", *sim.x_e[:sim.N_e]))
        f.write(struct.pack(f"{sim.N_e}d", *sim.vx_e[:sim.N_e]))
        f.write(struct.pack(f"{sim.N_e}d", *sim.vy_e[:sim.N_e]))
        f.write(struct.pack(f"{sim.N_e}d", *sim.vz_e[:sim.N_e]))

        #   Zapis tablic jonów
        f.write(struct.pack("d", float(sim.N_i)))
        f.write(struct.pack(f"{sim.N_i}d", *sim.x_i[:sim.N_i]))
        f.write(struct.pack(f"{sim.N_i}d", *sim.vx_i[:sim.N_i]))
        f.write(struct.pack(f"{sim.N_i}d", *sim.vy_i[:sim.N_i]))
        f.write(struct.pack(f"{sim.N_i}d", *sim.vz_i[:sim.N_i]))
    
    print(f">> PyPIC: data saved: {sim.N_e} electrons {sim.N_i} ions, {sim.cycles_done} cycles completed, time: {sim.Time} [s]\n")


def load_particle_data(sim: SimulationState):
    """
    Wczytuje stan z pliku binarnego.
    """
    if not os.path.exists("picdata.bin"):
        print(f">> PyPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n")
        exit(0)
    
    with open("picdata.bin", "rb") as f:
        #   Wczytywanie 8 bajtów (rozmiar 'double' w C)
        sim.Time = struct.unpack("d", f.read(8))[0]
        sim.cycles_done = int(struct.unpack("d", f.read(8))[0])
        sim.N_e = int(struct.unpack("d", f.read(8))[0])

        # Wczytywanie całych bloków pamięci elektronów i podmiana wycinka listy
        bytes_to_read = 8 * sim.N_e
        sim.x_e[:sim.N_e]  = struct.unpack(f"{sim.N_e}d", f.read(bytes_to_read))
        sim.vx_e[:sim.N_e] = struct.unpack(f"{sim.N_e}d", f.read(bytes_to_read))
        sim.vy_e[:sim.N_e] = struct.unpack(f"{sim.N_e}d", f.read(bytes_to_read))
        sim.vz_e[:sim.N_e] = struct.unpack(f"{sim.N_e}d", f.read(bytes_to_read))

        # Wczytywanie jonów
        sim.N_i = int(struct.unpack("d", f.read(8))[0])
        bytes_to_read = 8 * sim.N_i
        sim.x_i[:sim.N_i]  = struct.unpack(f"{sim.N_i}d", f.read(bytes_to_read))
        sim.vx_i[:sim.N_i] = struct.unpack(f"{sim.N_i}d", f.read(bytes_to_read))
        sim.vy_i[:sim.N_i] = struct.unpack(f"{sim.N_i}d", f.read(bytes_to_read))
        sim.vz_i[:sim.N_i] = struct.unpack(f"{sim.N_i}d", f.read(bytes_to_read))

    print(f">> PyPIC: data loaded : {sim.N_e} electrons {sim.N_i} ions, {sim.cycles_done} cycles completed before, time is {sim.Time:e} [s]")


def save_density(sim: SimulationState):
    """
    Zapisuje rozkład gęstości ładunku na siatce przestrzennej.
    """

    if sim.no_of_cycles == 0 or cs.N_T == 0:
        return
    
    c = 1.0 / float(sim.no_of_cycles) / float(cs.N_T)

    with open("density.dat", "w") as f:
        for m in range(cs.N_G):
            x_pos = m * cs.DX
            e_den = sim.cumul_e_density[m] * c
            i_den = sim.cumul_i_density[m] * c

            f.write(f"{x_pos:8.5f}  {e_den:12e}  {i_den:12e}\n")


def save_eepf(sim: SimulationState):
    """
    Zapisuje dane odnośnie EEPF.
    """
    h: float = 0.0
    for i in range(cs.N_EEPF):
        h += sim.eepf[i]

    h *= cs.DE_EEPF

    with open("eepf.dat", "w") as f:
        for i in range(cs.N_EEPF):
            energy = (i + 0.5) * cs.DE_EEPF
            
            f.write(f"{energy}  {sim.eepf[i] / h / math.sqrt(energy)}\n")


def save_ifed(sim: SimulationState):
    """
    Zapisuje dane odnośnie IFED
    """
    h_pow = 0.0
    h_gnd = 0.0
    for i in range(cs.N_IFED):
        h_pow += sim.ifed_pow[i]
        h_gnd += sim.ifed_gnd[i]

    h_pow *= cs.DE_IFED
    h_gnd *= cs.DE_IFED
    sim.mean_i_energy_pow = 0.0
    sim.mean_i_energy_gnd = 0.0
    with open("ifed.dat", "w") as f:
        for i in range(cs.N_IFED):
            energy = (i + 0.5) * cs.DE_IFED
            f.write(f"{energy:6.2f} {float(sim.ifed_pow[i]/h_pow):10.6f} {float(sim.ifed_gnd[i])/h_gnd}")
            sim.mean_i_energy_pow += energy * float(sim.ifed_pow[i]) / h_pow
            sim.mean_i_energy_gnd += energy * float(sim.ifed_gnd[i]) / h_gnd


def save_xt_1(distr: list[list[float]], fname: str):
    """
    Zapisuje dwuwymiarowy rozkład czasowo-przestrzenny (XT) do pliku tekstowego.
    Przyjmuje tablicę 2D oraz docelową nazwę pliku.
    """
    with open(fname, "w") as f:
        for i in range(cs.N_G):
            for j in range(cs.N_XT):
                f.write(f"{distr[i][j]:e}  ")
            
            f.write("\n")


def norm_all_xt(sim: SimulationState):
    """
    Normalizacja danych XT
    """
    f1: float = float(cs.N_XT) / float(sim.no_of_cycles * cs.N_T)
    f2: float = cs.WEIGHT / (cs.ELECTRODE_AREA * cs.DX) / (sim.no_of_cycles * (cs.PERIOD / float(cs.N_XT)))

    for i in range(cs.N_G):
        for j in range(cs.N_XT):
            sim.pot_xt[i][j]    *= f1
            sim.efield_xt[i][j] *= f1
            sim.ne_xt[i][j]     *= f1
            sim.ni_xt[i][j]     *= f1

            if sim.counter_e_xt[i][j] > 0:
                sim.ue_xt[i][j] = sim.ue_xt[i][j] / sim.counter_e_xt[i][j]
                sim.je_xt[i][j] = -sim.ue_xt[i][j] * sim.ne_xt[i][j] * cs.E_CHARGE
                sim.meanee_xt[i][j] =  sim.meanee_xt[i][j] / sim.counter_e_xt[i][j]
                sim.ioniz_rate_xt[i][j] *= f2
            else:
                sim.ue_xt[i][j]         = 0.0
                sim.je_xt[i][j]         = 0.0
                sim.meanee_xt[i][j]     = 0.0
                sim.ioniz_rate_xt[i][j] = 0.0

            if sim.counter_i_xt[i][j] > 0:
                sim.ui_xt[i][j]     = sim.ui_xt[i][j] / sim.counter_i_xt[i][j]
                sim.ji_xt[i][j]     = sim.ui_xt[i][j] * sim.ni_xt[i][j] * cs.E_CHARGE
                sim.meanei_xt[i][j] = sim.meanei_xt[i][j] / sim.counter_i_xt[i][j]
            else:
                sim.ui_xt[i][j]     = 0.0
                sim.ji_xt[i][j]     = 0.0
                sim.meanei_xt[i][j] = 0.0

            sim.powere_xt[i][j] = sim.je_xt[i][j] * sim.efield_xt[i][j]
            sim.poweri_xt[i][j] = sim.ji_xt[i][j] * sim.efield_xt[i][j]
