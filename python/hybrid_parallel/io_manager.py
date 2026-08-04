import struct
import math
import os
import numpy as np
import constants as cs
import collisions
from state import SimulationState


from mpi4py import MPI


def save_particle_data(sim: SimulationState):
    """
    Zapisuje stan symulacji do pliku binarnego picdata.bin.
    Wykorzystuje operacje zbiorcze MPI (comm.gather i comm.Gatherv):
    1. Procesy wysyłają swoje liczby cząstek (N_e, N_i) do Ranka 0.
    2. Rank 0 wylicza przesunięcia (displacements) i alokuje zbiorcze tablice.
    3. Operacja comm.Gatherv scala lokalne podzbiory cząstek z każdego ranka w ciągłe tablice na Rank 0.
    4. Rank 0 zapisuje plik binarne picdata.bin w standardowym formacie.
    """
    comm = sim.comm
    rank = sim.rank
    size = sim.size

    # Zbieranie liczby cząstek ze wszystkich procesów do listy na Rank 0
    counts_e: list[int] | None = comm.gather(sim.N_e, root=0)
    counts_i: list[int] | None = comm.gather(sim.N_i, root=0)

    # Ensure totals are defined for all branches (static analyzers)
    total_e = 0
    total_i = 0

    if rank == 0:
        if counts_e is None or counts_i is None:
            raise RuntimeError("Failed to gather particle counts")

        total_e = sum(counts_e)
        total_i = sum(counts_i)
        # Obliczenie wektorów przesunięć (displacements) w pamięci dla Gatherv
        disps_e = np.insert(np.cumsum(counts_e), 0, 0)[:-1]
        disps_i = np.insert(np.cumsum(counts_i), 0, 0)[:-1]

        x_e_g  = np.empty(total_e, dtype=np.float64)
        vx_e_g = np.empty(total_e, dtype=np.float64)
        vy_e_g = np.empty(total_e, dtype=np.float64)
        vz_e_g = np.empty(total_e, dtype=np.float64)

        x_i_g  = np.empty(total_i, dtype=np.float64)
        vx_i_g = np.empty(total_i, dtype=np.float64)
        vy_i_g = np.empty(total_i, dtype=np.float64)
        vz_i_g = np.empty(total_i, dtype=np.float64)
    else:
        disps_e = None
        disps_i = None
        x_e_g = vx_e_g = vy_e_g = vz_e_g = None
        x_i_g = vx_i_g = vy_i_g = vz_i_g = None

    # Zbiorcza redukcja wektorowa (Gatherv) cząstek ze wszystkich procesów do Ranka 0
    comm.Gatherv(sim.x_e[:sim.N_e], [x_e_g, counts_e, disps_e, MPI.DOUBLE], root=0)
    comm.Gatherv(sim.vx_e[:sim.N_e], [vx_e_g, counts_e, disps_e, MPI.DOUBLE], root=0)
    comm.Gatherv(sim.vy_e[:sim.N_e], [vy_e_g, counts_e, disps_e, MPI.DOUBLE], root=0)
    comm.Gatherv(sim.vz_e[:sim.N_e], [vz_e_g, counts_e, disps_e, MPI.DOUBLE], root=0)

    comm.Gatherv(sim.x_i[:sim.N_i], [x_i_g, counts_i, disps_i, MPI.DOUBLE], root=0)
    comm.Gatherv(sim.vx_i[:sim.N_i], [vx_i_g, counts_i, disps_i, MPI.DOUBLE], root=0)
    comm.Gatherv(sim.vy_i[:sim.N_i], [vy_i_g, counts_i, disps_i, MPI.DOUBLE], root=0)
    comm.Gatherv(sim.vz_i[:sim.N_i], [vz_i_g, counts_i, disps_i, MPI.DOUBLE], root=0)

    if rank == 0:
        # Ensure gathered arrays are present on rank 0
        assert x_e_g is not None and vx_e_g is not None and vy_e_g is not None and vz_e_g is not None, "Missing electron arrays on rank 0"
        assert x_i_g is not None and vx_i_g is not None and vy_i_g is not None and vz_i_g is not None, "Missing ion arrays on rank 0"

        with open("picdata.bin", "wb") as f:
            f.write(struct.pack("d", sim.Time))
            f.write(struct.pack("d", float(sim.cycles_done)))
            f.write(struct.pack("d", float(total_e)))

            f.write(x_e_g.tobytes())
            f.write(vx_e_g.tobytes())
            f.write(vy_e_g.tobytes())
            f.write(vz_e_g.tobytes())

            f.write(struct.pack("d", float(total_i)))
            f.write(x_i_g.tobytes())
            f.write(vx_i_g.tobytes())
            f.write(vy_i_g.tobytes())
            f.write(vz_i_g.tobytes())

        print(f">> PyPIC: data saved: {total_e} electrons {total_i} ions, {sim.cycles_done} cycles completed, time: {sim.Time} [s]")


def load_particle_data(sim: SimulationState):
    """
    Wczytuje stan z pliku binarnego picdata.bin na Rank 0 i dystrybuuje cząstki między procesy MPI.
    1. Rank 0 wczytuje plik binarny z dysku.
    2. Rozgłasza skalarne wartości (Time, cycles_done, total_e, total_i) do wszystkich procesów przez comm.bcast.
    3. Każdy proces oblicza swoją lokalną porcję cząstek (counts_e[rank], counts_i[rank]).
    4. Operacja comm.Scatterv rozdziela ciągłe tablice z Ranka 0 do lokalnych buforów sim.x_e, sim.vx_e itp.
    """
    comm = sim.comm
    rank = sim.rank
    size = sim.size

    if rank == 0:
        if not os.path.exists("picdata.bin"):
            print(f">> PyPIC: ERROR: No particle data file found, try running initial cycle using argument '0'")
            exit(0)

        with open("picdata.bin", "rb") as f:
            time_val = struct.unpack("d", f.read(8))[0]
            cycles_done_val = int(struct.unpack("d", f.read(8))[0])
            total_e = int(struct.unpack("d", f.read(8))[0])

            bytes_to_read = 8 * total_e
            x_e_g  = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
            vx_e_g = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
            vy_e_g = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
            vz_e_g = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)

            total_i = int(struct.unpack("d", f.read(8))[0])
            bytes_to_read = 8 * total_i
            x_i_g  = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
            vx_i_g = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
            vy_i_g = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
            vz_i_g = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)

        print(f">> PyPIC: data loaded : {total_e} electrons {total_i} ions, {cycles_done_val} cycles completed before, time is {time_val:e} [s]")
    else:
        time_val = 0.0
        cycles_done_val = 0
        total_e = 0
        total_i = 0
        x_e_g = vx_e_g = vy_e_g = vz_e_g = None
        x_i_g = vx_i_g = vy_i_g = vz_i_g = None

    # Rozgłoszenie wartości nagłówkowych z Ranka 0 do wszystkich procesów MPI
    sim.Time = comm.bcast(time_val, root=0)
    sim.cycles_done = comm.bcast(cycles_done_val, root=0)
    total_e = comm.bcast(total_e, root=0)
    total_i = comm.bcast(total_i, root=0)

    # Obliczenie podziału cząstek na procesy MPI
    counts_e = [total_e // size + (1 if i < total_e % size else 0) for i in range(size)]
    counts_i = [total_i // size + (1 if i < total_i % size else 0) for i in range(size)]
    disps_e = np.insert(np.cumsum(counts_e), 0, 0)[:-1]
    disps_i = np.insert(np.cumsum(counts_i), 0, 0)[:-1]

    sim.N_e = counts_e[rank]
    sim.N_i = counts_i[rank]

    # Rozdzielenie wektorowe (Scatterv) tablic cząstek z Ranka 0 do lokalnych buforów procesów
    comm.Scatterv([x_e_g, counts_e, disps_e, MPI.DOUBLE], sim.x_e[:sim.N_e], root=0)
    comm.Scatterv([vx_e_g, counts_e, disps_e, MPI.DOUBLE], sim.vx_e[:sim.N_e], root=0)
    comm.Scatterv([vy_e_g, counts_e, disps_e, MPI.DOUBLE], sim.vy_e[:sim.N_e], root=0)
    comm.Scatterv([vz_e_g, counts_e, disps_e, MPI.DOUBLE], sim.vz_e[:sim.N_e], root=0)

    comm.Scatterv([x_i_g, counts_i, disps_i, MPI.DOUBLE], sim.x_i[:sim.N_i], root=0)
    comm.Scatterv([vx_i_g, counts_i, disps_i, MPI.DOUBLE], sim.vx_i[:sim.N_i], root=0)
    comm.Scatterv([vy_i_g, counts_i, disps_i, MPI.DOUBLE], sim.vy_i[:sim.N_i], root=0)
    comm.Scatterv([vz_i_g, counts_i, disps_i, MPI.DOUBLE], sim.vz_i[:sim.N_i], root=0)


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
    h: float = float(np.sum(sim.eepf))
    h *= cs.DE_EEPF

    with open("eepf.dat", "w") as f:
        for i in range(cs.N_EEPF):
            energy = (i + 0.5) * cs.DE_EEPF
            val = sim.eepf[i] / h / math.sqrt(energy) if h > 0 else 0.0
            f.write(f"{energy}  {val}\n")


def save_ifed(sim: SimulationState):
    """
    Zapisuje dane odnośnie IFED
    """
    h_pow = float(np.sum(sim.ifed_pow)) * cs.DE_IFED
    h_gnd = float(np.sum(sim.ifed_gnd)) * cs.DE_IFED

    sim.mean_i_energy_pow = 0.0
    sim.mean_i_energy_gnd = 0.0
    with open("ifed.dat", "w") as f:
        for i in range(cs.N_IFED):
            energy = (i + 0.5) * cs.DE_IFED
            val_pow = float(sim.ifed_pow[i]) / h_pow if h_pow > 0 else 0.0
            val_gnd = float(sim.ifed_gnd[i]) / h_gnd if h_gnd > 0 else 0.0
            f.write(f"{energy:6.2f} {val_pow:10.6f} {val_gnd}\n")
            sim.mean_i_energy_pow += energy * (float(sim.ifed_pow[i]) / h_pow if h_pow > 0 else 0.0)
            sim.mean_i_energy_gnd += energy * (float(sim.ifed_gnd[i]) / h_gnd if h_gnd > 0 else 0.0)


def save_xt(distr: np.ndarray, fname: str):
    """
    Zapisuje dwuwymiarowy rozkład czasowo-przestrzenny (XT) do pliku tekstowego.
    Przyjmuje tablicę 2D oraz docelową nazwę pliku.
    """
    with open(fname, "w") as f:
        for i in range(cs.N_G):
            f.write("".join(f"{val:e}  " for val in distr[i]) + "\n")


def norm_all_xt(sim: SimulationState):
    """
    Normalizacja danych XT (w pełni wektorowa)
    """
    f1: float = float(cs.N_XT) / float(sim.no_of_cycles * cs.N_T)
    f2: float = cs.WEIGHT / (cs.ELECTRODE_AREA * cs.DX) / (sim.no_of_cycles * (cs.PERIOD / float(cs.N_XT)))

    sim.pot_xt    *= f1
    sim.efield_xt *= f1
    sim.ne_xt     *= f1
    sim.ni_xt     *= f1

    # Normalizacja dla elektronów
    mask_e = sim.counter_e_xt > 0
    sim.ue_xt[mask_e] /= sim.counter_e_xt[mask_e]
    sim.je_xt[mask_e] = -sim.ue_xt[mask_e] * sim.ne_xt[mask_e] * cs.E_CHARGE
    sim.meanee_xt[mask_e] /= sim.counter_e_xt[mask_e]
    sim.ioniz_rate_xt[mask_e] *= f2

    sim.ue_xt[~mask_e]         = 0.0
    sim.je_xt[~mask_e]         = 0.0
    sim.meanee_xt[~mask_e]     = 0.0
    sim.ioniz_rate_xt[~mask_e] = 0.0

    # Normalizacja dla jonów
    mask_i = sim.counter_i_xt > 0
    sim.ui_xt[mask_i] /= sim.counter_i_xt[mask_i]
    sim.ji_xt[mask_i] = sim.ui_xt[mask_i] * sim.ni_xt[mask_i] * cs.E_CHARGE
    sim.meanei_xt[mask_i] /= sim.counter_i_xt[mask_i]

    sim.ui_xt[~mask_i]     = 0.0
    sim.ji_xt[~mask_i]     = 0.0
    sim.meanei_xt[~mask_i] = 0.0

    # Power XT
    sim.powere_xt = sim.je_xt * sim.efield_xt
    sim.poweri_xt = sim.ji_xt * sim.efield_xt


def save_all_xt(sim: SimulationState):
    """
    Zapisanie wszystkich plików XT
    """
    save_xt(sim.pot_xt, "pot_xt.dat")
    save_xt(sim.efield_xt, "efield_xt.dat")
    save_xt(sim.ne_xt, "ne_xt.dat")
    save_xt(sim.ni_xt, "ni_xt.dat")
    save_xt(sim.je_xt, "je_xt.dat")
    save_xt(sim.ji_xt, "ji_xt.dat")
    save_xt(sim.powere_xt, "powere_xt.dat")
    save_xt(sim.ioniz_rate_xt, "ioniz_xt.dat")
    save_xt(sim.poweri_xt, "poweri_xt.dat")
    save_xt(sim.meanee_xt, "meanee_xt.dat")
    save_xt(sim.meanei_xt, "meanei_xt.dat")



def reduce_diagnostics_mpi(sim: SimulationState):
    """
    Sumuje dane diagnostyczne ze wszystkich procesów MPI na proces 0.
    """
    comm = sim.comm
    rank = sim.rank
    if sim.size == 1:
        return

    sim.N_e_abs_pow = comm.reduce(sim.N_e_abs_pow, op=MPI.SUM, root=0) or 0
    sim.N_e_abs_gnd = comm.reduce(sim.N_e_abs_gnd, op=MPI.SUM, root=0) or 0
    sim.N_i_abs_pow = comm.reduce(sim.N_i_abs_pow, op=MPI.SUM, root=0) or 0
    sim.N_i_abs_gnd = comm.reduce(sim.N_i_abs_gnd, op=MPI.SUM, root=0) or 0
    sim.N_e_coll    = comm.reduce(sim.N_e_coll, op=MPI.SUM, root=0) or 0
    sim.N_i_coll    = comm.reduce(sim.N_i_coll, op=MPI.SUM, root=0) or 0
    sim.mean_energy_accu_center = comm.reduce(sim.mean_energy_accu_center, op=MPI.SUM, root=0) or 0.0
    sim.mean_energy_counter_center = comm.reduce(sim.mean_energy_counter_center, op=MPI.SUM, root=0) or 0

    for attr in ["eepf", "counter_e_xt", "counter_i_xt",
                 "ue_xt", "ui_xt", "meanee_xt", "meanei_xt", "ioniz_rate_xt"]:
        arr = getattr(sim, attr)
        recv_buf = np.zeros_like(arr) if rank == 0 else None
        comm.Reduce(arr, recv_buf, op=MPI.SUM, root=0)
        if rank == 0:
            setattr(sim, attr, recv_buf)

    for attr in ["ifed_pow", "ifed_gnd"]:
        arr = getattr(sim, attr)
        recv_buf = np.zeros_like(arr) if rank == 0 else None
        comm.Reduce(arr, recv_buf, op=MPI.SUM, root=0)
        if rank == 0:
            setattr(sim, attr, recv_buf)

    total_e = comm.reduce(sim.N_e, op=MPI.SUM, root=0) or 0
    total_i = comm.reduce(sim.N_i, op=MPI.SUM, root=0) or 0
    if rank == 0:
        sim.N_e = total_e
        sim.N_i = total_i


def check_and_save_info(sim: SimulationState):                                                                                                                                           
    """                                                                                                                                                                                  
    Generuje raport z symulacji (info.txt) oraz weryfikuje warunki                                                                                                                       
    stabilności i dokładności numerycznej. Jeśli warunki są spełnione,                                                                                                                   
    zapisuje pełne dane diagnostyczne.                                                                                                                                                   
    """
    reduce_diagnostics_mpi(sim)

    if sim.rank != 0:
        return

    density = sim.cumul_e_density[cs.N_G // 2] / float(sim.no_of_cycles) / float(cs.N_T)                                                                                                 
    plas_freq = cs.E_CHARGE * math.sqrt(density / cs.EPSILON0 / cs.E_MASS) if density > 0 else 0.0                                                                                       
                                                                                                                                                                                         
    meane = (sim.mean_energy_accu_center / float(sim.mean_energy_counter_center)                                                                                                         
                if sim.mean_energy_counter_center > 0 else 0.0)                                                                                                                             
    kT = 2.0 * meane * cs.EV_TO_J / 3.0                                                                                                                                                  
    sim_time = float(sim.no_of_cycles) / cs.FREQUENCY                                                                                                                                    
                                                                                                                                                                                         
    ecoll_freq = (float(sim.N_e_coll) / sim_time / float(sim.N_e)                                                                                                                        
                    if sim.N_e > 0 else 0.0)                                                                                                                                               
    icoll_freq = (float(sim.N_i_coll) / sim_time / float(sim.N_i)                                                                                                                        
                    if sim.N_i > 0 else 0.0)                                                                                                                                               
                                                                                                                                                                                         
    debye_length = math.sqrt(cs.EPSILON0 * kT / density) / cs.E_CHARGE if density > 0 else 0.0                                                                                           
                                                                                                                                                                                         
    with open("info.txt", "w") as f:                                                                                                                                                     
        f.write("########################## PyPIC simulation report ############################\n")                                                                                    
        f.write("Simulation parameters:\n")                                                                                                                                              
        f.write(f"Gap distance                          = {cs.L:12.3e} [m]\n")                                                                                                           
        f.write(f"# of grid divisions                   = {cs.N_G:12d}\n")                                                                                                               
        f.write(f"Frequency                             = {cs.FREQUENCY:12.3e} [Hz]\n")                                                                                                  
        f.write(f"# of time steps / period              = {cs.N_T:12d}\n")                                                                                                               
        f.write(f"# of electron / ion time steps        = {cs.N_SUB:12d}\n")                                                                                                             
        f.write(f"Voltage amplitude                     = {cs.VOLTAGE:12.3e} [V]\n")                                                                                                     
        f.write(f"Pressure (Ar)                         = {cs.PRESSURE:12.3e} [Pa]\n")                                                                                                   
        f.write(f"Temperature                           = {cs.TEMPERATURE:12.3e} [K]\n")                                                                                                 
        f.write(f"Superparticle weight                  = {cs.WEIGHT:12.3e}\n")                                                                                                          
        f.write(f"# of simulation cycles in this run    = {sim.no_of_cycles:12d}\n")                                                                                                     
        f.write("--------------------------------------------------------------------------------\n")                                                                                    
        f.write("Plasma characteristics:\n")                                                                                                                                             
        f.write(f"Electron density @ center             = {density:12.3e} [m^{{-3}}]\n")                                                                                                 
        f.write(f"Plasma frequency @ center             = {plas_freq:12.3e} [rad/s]\n")                                                                                                  
        f.write(f"Debye length @ center                 = {debye_length:12.3e} [m]\n")                                                                                                   
        f.write(f"Electron collision frequency          = {ecoll_freq:12.3e} [1/s]\n")                                                                                                   
        f.write(f"Ion collision frequency               = {icoll_freq:12.3e} [1/s]\n")                                                                                                   
        f.write("--------------------------------------------------------------------------------\n")                                                                                    
        f.write("Stability and accuracy conditions:\n")                                                                                                                                  
                                                                                                                                                                                         
        conditions_OK = True                                                                                                                                                             
                                                                                                                                                                                         
        c = plas_freq * cs.DT_E                                                                                                                                                          
        f.write(f"Plasma frequency @ center * DT_E      = {c:12.3f} (OK if less than 0.20)\n")                                                                                           
        if c > 0.2:                                                                                                                                                                      
            conditions_OK = False                                                                                                                                                        
                                                                                                                                                                                         
        c = cs.DX / debye_length if debye_length > 0 else float('inf')                                                                                                                   
        f.write(f"DX / Debye length @ center            = {c:12.3f} (OK if less than 1.00)\n")                                                                                           
        if c > 1.0:                                                                                                                                                                      
            conditions_OK = False                                                                                                                                                        
                                                                                                                                                                                         
        max_e_coll = collisions.max_electron_coll_freq(sim)                                                                                                                              
        c = max_e_coll * cs.DT_E                                                                                                                                                         
        f.write(f"Max. electron coll. frequency * DT_E  = {c:12.3f} (OK if less than 0.05)\n")                                                                                           
        if c > 0.05:                                                                                                                                                                     
            conditions_OK = False                                                                                                                                                        
                                                                                                                                                                                         
        max_i_coll = collisions.max_ion_coll_freq(sim)                                                                                                                                   
        c = max_i_coll * cs.DT_I                                                                                                                                                         
        f.write(f"Max. ion coll. frequency * DT_I       = {c:12.3f} (OK if less than 0.05)\n")                                                                                           
        if c > 0.05:                                                                                                                                                                     
            conditions_OK = False                                                                                                                                                        
                                                                                                                                                                                         
        if not conditions_OK:                                                                                                                                                            
            f.write("--------------------------------------------------------------------------------\n")                                                                                
            f.write("** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **\n")                                                                                
            f.write("--------------------------------------------------------------------------------\n")                                                                                
            print(">> PyPIC: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!")                                                                                                     
            print(">> PyPIC: for details see 'info.txt' and refine simulation settings!")                                                                                               
        else:                                                                                                                                                                            
            v_max = cs.DX / cs.DT_E                                                                                                                                                      
            e_max = 0.5 * cs.E_MASS * v_max * v_max / cs.EV_TO_J                                                                                                                         
            f.write(f"Max e- energy for CFL condition       = {e_max:12.3f} [eV]\n")                                                                                                     
            f.write("Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!\n")                                                                                   
            f.write("--------------------------------------------------------------------------------\n")                                                                                
                                                                                                                                                                                         
            print(">> PyPIC: saving diagnostics data")                                                                                                                                   
            save_density(sim)                                                                                                                                                            
            save_eepf(sim)                                                                                                                                                               
            save_ifed(sim)                                                                                                                                                               
            norm_all_xt(sim)                                                                                                                                                             
            save_all_xt(sim)                                                                                                                                                             
                                                                                                                                                                                         
            f.write("Particle characteristics at the electrodes:\n")                                                                                                                     
            denom = float(sim.no_of_cycles) * cs.PERIOD                                                                                                                                  
            factor = cs.WEIGHT / cs.ELECTRODE_AREA / denom                                                                                                                               
                                                                                                                                                                                         
            f.write(f"Ion flux at powered electrode         = {sim.N_i_abs_pow * factor:12.3e} [m^{{-2}} s^{{-1}}]\n")                                                                   
            f.write(f"Ion flux at grounded electrode        = {sim.N_i_abs_gnd * factor:12.3e} [m^{{-2}} s^{{-1}}]\n")                                                                   
            f.write(f"Mean ion energy at powered electrode  = {sim.mean_i_energy_pow:12.3e} [eV]\n")                                                                                     
            f.write(f"Mean ion energy at grounded electrode = {sim.mean_i_energy_gnd:12.3e} [eV]\n")                                                                                     
            f.write(f"Electron flux at powered electrode    = {sim.N_e_abs_pow * factor:12.3e} [m^{{-2}} s^{{-1}}]\n")                                                                   
            f.write(f"Electron flux at grounded electrode   = {sim.N_e_abs_gnd * factor:12.3e} [m^{{-2}} s^{{-1}}]\n")                                                                   
            f.write("--------------------------------------------------------------------------------\n")                                                                                
                                                                                                                                                                                         
            power_e = float(np.mean(sim.powere_xt))                                                                                                                                      
            power_i = float(np.mean(sim.poweri_xt))                                                                                                                                      
                                                                                                                                                                                         
            f.write("Absorbed power calculated as <j*E>:\n")                                                                                                                             
            f.write(f"Electron power density (average)      = {power_e:12.3e} [W m^{{-3}}]\n")                                                                                           
            f.write(f"Ion power density (average)           = {power_i:12.3e} [W m^{{-3}}]\n")                                                                                           
            f.write("--------------------------------------------------------------------------------\n")                                                                                
