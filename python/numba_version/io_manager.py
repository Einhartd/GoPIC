import struct
import math
import os
import numpy as np
import constants as cs
import collisions
from state import SimulationState


def save_particle_data(sim: SimulationState):
    """
    Zapisuje stan symulacji do pliku binarnego.
    """
    with open(os.path.join("results", "picdata.bin"), "wb") as f:
        # Zapis zmiennych pojedynczych
        f.write(struct.pack("d", sim.Time))
        f.write(struct.pack("d", float(sim.cycles_done)))
        f.write(struct.pack("d", float(sim.N_e)))

        # Zapis tablic elektronów przy użyciu tobytes() dla wydajności i kompatybilności z NumPy
        f.write(sim.x_e[:sim.N_e].tobytes())
        f.write(sim.vx_e[:sim.N_e].tobytes())
        f.write(sim.vy_e[:sim.N_e].tobytes())
        f.write(sim.vz_e[:sim.N_e].tobytes())

        # Zapis tablic jonów
        f.write(struct.pack("d", float(sim.N_i)))
        f.write(sim.x_i[:sim.N_i].tobytes())
        f.write(sim.vx_i[:sim.N_i].tobytes())
        f.write(sim.vy_i[:sim.N_i].tobytes())
        f.write(sim.vz_i[:sim.N_i].tobytes())
    
    print(f">> PyPIC: data saved: {sim.N_e} electrons {sim.N_i} ions, {sim.cycles_done} cycles completed, time: {sim.Time} [s]")


def load_particle_data(sim: SimulationState):
    """
    Wczytuje stan z pliku binarnego.
    """
    if not os.path.exists(os.path.join("results", "picdata.bin")):
        print(f">> PyPIC: ERROR: No particle data file found, try running initial cycle using argument '0'")
        exit(0)
    
    with open(os.path.join("results", "picdata.bin"), "rb") as f:
        sim.Time = struct.unpack("d", f.read(8))[0]
        sim.cycles_done = int(struct.unpack("d", f.read(8))[0])
        sim.N_e = int(struct.unpack("d", f.read(8))[0])

        bytes_to_read = 8 * sim.N_e
        sim.x_e[:sim.N_e]  = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
        sim.vx_e[:sim.N_e] = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
        sim.vy_e[:sim.N_e] = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
        sim.vz_e[:sim.N_e] = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)

        sim.N_i = int(struct.unpack("d", f.read(8))[0])
        bytes_to_read = 8 * sim.N_i
        sim.x_i[:sim.N_i]  = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
        sim.vx_i[:sim.N_i] = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
        sim.vy_i[:sim.N_i] = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)
        sim.vz_i[:sim.N_i] = np.frombuffer(f.read(bytes_to_read), dtype=np.float64)

    print(f">> PyPIC: data loaded : {sim.N_e} electrons {sim.N_i} ions, {sim.cycles_done} cycles completed before, time is {sim.Time:e} [s]")


def save_density(sim: SimulationState):
    """
    Zapisuje rozkład gęstości ładunku na siatce przestrzennej.
    """
    if sim.no_of_cycles == 0 or cs.N_T == 0:
        return
    
    c = 1.0 / float(sim.no_of_cycles) / float(cs.N_T)

    with open(os.path.join("results", "density.dat"), "w") as f:
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

    with open(os.path.join("results", "eepf.dat"), "w") as f:
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
    with open(os.path.join("results", "ifed.dat"), "w") as f:
        for i in range(cs.N_IFED):
            energy = (i + 0.5) * cs.DE_IFED
            val_pow = float(sim.ifed_pow[i]) / h_pow if h_pow > 0 else 0.0
            val_gnd = float(sim.ifed_gnd[i]) / h_gnd if h_gnd > 0 else 0.0
            f.write(f"{energy:6.2f} {val_pow:10.6f} {val_gnd}\n")
            sim.mean_i_energy_pow += energy * (float(sim.ifed_pow[i]) / h_pow if h_pow > 0 else 0.0)
            sim.mean_i_energy_gnd += energy * (float(sim.ifed_gnd[i]) / h_gnd if h_gnd > 0 else 0.0)


def save_xt_1(distr: np.ndarray, fname: str):
    """
    Zapisuje dwuwymiarowy rozkład czasowo-przestrzenny (XT) do pliku tekstowego.
    Przyjmuje tablicę 2D oraz docelową nazwę pliku.
    """
    with open(os.path.join("results", fname), "w") as f:
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
    save_xt_1(sim.pot_xt, "pot_xt.dat")
    save_xt_1(sim.efield_xt, "efield_xt.dat")
    save_xt_1(sim.ne_xt, "ne_xt.dat")
    save_xt_1(sim.ni_xt, "ni_xt.dat")
    save_xt_1(sim.je_xt, "je_xt.dat")
    save_xt_1(sim.ji_xt, "ji_xt.dat")
    save_xt_1(sim.powere_xt, "powere_xt.dat")
    save_xt_1(sim.poweri_xt, "poweri_xt.dat")
    save_xt_1(sim.meanee_xt, "meanee_xt.dat")
    save_xt_1(sim.meanei_xt, "meanei_xt.dat")
    save_xt_1(sim.ioniz_rate_xt, "ioniz_xt.dat")


def check_and_save_info(sim: SimulationState):                                                                                                                                           
    """                                                                                                                                                                                  
    Generuje raport z symulacji (info.txt) oraz weryfikuje warunki                                                                                                                       
    stabilności i dokładności numerycznej. Jeśli warunki są spełnione,                                                                                                                   
    zapisuje pełne dane diagnostyczne.                                                                                                                                                   
    """                                                                                                                                                                                  
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
                                                                                                                                                                                         
    with open(os.path.join("results", "info.txt"), "w") as f:                                                                                                                                                     
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
            print(">> PyPIC: for details see 'results/info.txt' and refine simulation settings!")                                                                                               
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
            f.write(f"Total power density(average)          = {power_e + power_i:12.3e} [W m^{{-3}}]\n")                                                                                 
            f.write("--------------------------------------------------------------------------------\n")                                                                                
