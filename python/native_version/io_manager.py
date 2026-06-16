import struct
import math
import os
import constants as cs
import collisions
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
    
    print(f">> PyPIC: data saved: {sim.N_e} electrons {sim.N_i} ions, {sim.cycles_done} cycles completed, time: {sim.Time} [s]")


def load_particle_data(sim: SimulationState):
    """
    Wczytuje stan z pliku binarnego.
    """
    if not os.path.exists("picdata.bin"):
        print(f">> PyPIC: ERROR: No particle data file found, try running initial cycle using argument '0'")
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
            f.write(f"{energy:6.2f} {float(sim.ifed_pow[i]/h_pow):10.6f} {float(sim.ifed_gnd[i])/h_gnd}\n")
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
    # Obliczenia parametrów fizycznych w centrum (indeks N_G // 2)                                                                                                                       
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
            # Obliczenie Courant-Friedrichs-Lewy (CFL)                                                                                                                                   
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
                                                                                                                                                                                            
            # Obliczenie średniej gęstości pochłanianej mocy <j*E>                                                                                                                       
            power_e = 0.0                                                                                                                                                                
            power_i = 0.0                                                                                                                                                                
            for i in range(cs.N_G):                                                                                                                                                      
                for j in range(cs.N_XT):                                                                                                                                                 
                    power_e += sim.powere_xt[i][j]                                                                                                                                       
                    power_i += sim.poweri_xt[i][j]

            power_e /= float(cs.N_XT * cs.N_G)
            power_i /= float(cs.N_XT * cs.N_G)

            f.write("Absorbed power calculated as <j*E>:\n")
            f.write(f"Electron power density (average)      = {power_e:12.3e} [W m^{{-3}}]\n")
            f.write(f"Ion power density (average)           = {power_i:12.3e} [W m^{{-3}}]\n")
            f.write(f"Total power density(average)          = {power_e + power_i:12.3e} [W m^{{-3}}]\n")
            f.write("--------------------------------------------------------------------------------\n")