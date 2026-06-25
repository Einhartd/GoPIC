import math
import constants as cs
from state import SimulationState
import poisson
import collisions

def step1_compute_electron_density(sim: SimulationState):
    #   --- STEP 1A: COMPUTE ELECTRON DENSITY AT GRID POINTS ---
    for p in range(cs.N_G):
        sim.e_density[p] = 0.0

    for k in range(sim.N_e):
        c0: float = sim.x_e[k] * cs.INV_DX
        p: int = int(c0)
        sim.e_density[p] += (p + 1.0 - c0) * cs.FACTOR_W
        sim.e_density[p+1] += (c0 - p) * cs.FACTOR_W
    
    sim.e_density[0] *= 2.0
    sim.e_density[cs.N_G-1] *= 2.0

    for p in range(cs.N_G):
        sim.cumul_e_density[p] += sim.e_density[p]


def step1_compute_ion_density(sim: SimulationState, t: int):
    if t % cs.N_SUB != 0:
        return
    
    #   --- STEP 1B: COMPUTE ION DENSITY AT GRID POINTS (SUBCYCLING) ---
    for p in range(cs.N_G):
        sim.i_density[p] = 0.0

    for k in range(sim.N_i):
        c0: float = sim.x_i[k] * cs.INV_DX
        p: int = int(c0)
        sim.i_density[p] += (p + 1.0 - c0) * cs.FACTOR_W
        sim.i_density[p+1] += (c0 - p) * cs.FACTOR_W
    
    sim.i_density[0] *= 2.0
    sim.i_density[cs.N_G-1] *= 2.0

    for p in range(cs.N_G):
        sim.cumul_i_density[p] += sim.i_density[p]


def step2_solve_poisson(sim: SimulationState):
    #   --- STEP 2: SOLVE POISSON EQUATION ---
    rho: cs.xvector = [0.0] * cs.N_G
    for p in range(cs.N_G):
        rho[p] = cs.E_CHARGE * (sim.i_density[p] - sim.e_density[p])
    
    poisson.solve_poisson(sim, rho, sim.Time)


def step3_move_electrons(sim: SimulationState, t_index: int):
    #   --- STEP 3 & 4: MOVE PARTICLES ---
    for k in range(sim.N_e):
        c0 = sim.x_e[k] * cs.INV_DX
        p = int(c0)
        c1 = p + 1.0 - c0
        c2 = c0 - p
        e_x = c1 * sim.efield[p] + c2 * sim.efield[p+1]

        if sim.measurement_mode:
            #   measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
            mean_v = sim.vx_e[k] - 0.5 * e_x * cs.FACTOR_E
            sim.counter_e_xt[p][t_index]   += c1
            sim.counter_e_xt[p+1][t_index] += c2
            sim.ue_xt[p][t_index]   += c1 * mean_v
            sim.ue_xt[p+1][t_index] += c2 * mean_v

            v_sqr = mean_v**2.0 + sim.vy_e[k]**2.0 + sim.vz_e[k]**2.0
            energy = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J

            sim.meanee_xt[p][t_index] += c1 * energy
            sim.meanee_xt[p+1][t_index] += c2 * energy

            energy_index = min(int(energy / cs.DE_CS + 0.5), cs.CS_RANGES-1)
            velocity = math.sqrt(v_sqr)
            rate = sim.sigma[cs.E_ION][energy_index] * velocity * cs.DT_E * cs.GAS_DENSITY

            sim.ioniz_rate_xt[p][t_index] += c1 * rate
            sim.ioniz_rate_xt[p+1][t_index] += c2 * rate

            #   measure EEPF in the center
            if cs.MIN_X < sim.x_e[k] < cs.MAX_X:
                energy_index = int(energy / cs.DE_EEPF)
                if energy_index < cs.N_EEPF:
                    sim.eepf[energy_index] += 1.0
                sim.mean_energy_accu_center += energy
                sim.mean_energy_counter_center += 1
        
        #   update velocity and position
        sim.vx_e[k] -= e_x * cs.FACTOR_E
        sim.x_e[k] += sim.vx_e[k] * cs.DT_E


def step4_move_ions(sim:SimulationState, t_index: int, t: int):
    if (t % cs.N_SUB) != 0:
        return
    
    for k in range(sim.N_i):
        c0 = sim.x_i[k] * cs.INV_DX
        p = int(c0)
        c1 = p + 1.0 - c0
        c2 = c0 - p
        e_x = c1 * sim.efield[p] + c2 * sim.efield[p+1]

        if sim.measurement_mode:
            #   measurements: 'x' and 'v' are needed at the same time, 
            #   i.e. old 'x' and mean 'v'
            mean_v = sim.vx_i[k] + 0.5 * e_x * cs.FACTOR_I
            sim.counter_i_xt[p][t_index]   += c1
            sim.counter_i_xt[p+1][t_index] += c2
            sim.ui_xt[p][t_index]   += c1 * mean_v
            sim.ui_xt[p+1][t_index] += c2 * mean_v

            v_sqr = mean_v * mean_v + sim.vy_i[k]**2 + sim.vz_i[k]**2
            energy = 0.5 * cs.AR_MASS * v_sqr / cs.EV_TO_J
        
            sim.meanei_xt[p][t_index]   += c1 * energy
            sim.meanei_xt[p+1][t_index] += c2 * energy

        #   update velocity and position and accumulate absorbed energy
        sim.vx_i[k] += e_x * cs.FACTOR_I
        sim.x_i[k] += sim.vx_i[k] * cs.DT_I


def step5_check_boundaries_electrons(sim: SimulationState):
    #   --- STEP 5: CHECK BOUNDARIES ---
    k = 0
    while k < sim.N_e:
        out = False
        if sim.x_e[k] < 0:
            sim.N_e_abs_pow += 1
            out = True
        if sim.x_e[k] > cs.L:
            sim.N_e_abs_gnd += 1
            out = True
        if out:
        # Remove particle by replacing it with the last active particle
            sim.x_e[k]  = sim.x_e[sim.N_e - 1]
            sim.vx_e[k] = sim.vx_e[sim.N_e - 1]
            sim.vy_e[k] = sim.vy_e[sim.N_e - 1]
            sim.vz_e[k] = sim.vz_e[sim.N_e - 1]
            sim.N_e -= 1
        else:
            k += 1


def step6_check_boundaries_ions(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        return

    k = 0
    while k < sim.N_i:
        out = False
        if sim.x_i[k] < 0:
            sim.N_i_abs_pow += 1
            out = True
            v_sqr = sim.vx_i[k]**2 + sim.vy_i[k]**2 + sim.vz_i[k]**2
            energy = 0.5 * cs.AR_MASS * v_sqr / cs.EV_TO_J
            energy_index = int(energy / cs.DE_IFED)
            if energy_index < cs.N_IFED:
                sim.ifed_pow[energy_index] += 1  
        if sim.x_i[k] > cs.L:
            sim.N_i_abs_gnd += 1
            out = True
            v_sqr = sim.vx_i[k]**2 + sim.vy_i[k]**2 + sim.vz_i[k]**2
            energy = 0.5 * cs.AR_MASS * v_sqr / cs.EV_TO_J
            energy_index = int(energy / cs.DE_IFED)
            if energy_index < cs.N_IFED:
                sim.ifed_gnd[energy_index] += 1
                
        if out:
            sim.x_i[k]  = sim.x_i[sim.N_i - 1]
            sim.vx_i[k] = sim.vx_i[sim.N_i - 1]
            sim.vy_i[k] = sim.vy_i[sim.N_i - 1]
            sim.vz_i[k] = sim.vz_i[sim.N_i - 1]
            sim.N_i -= 1
        else:
            k += 1


def step7_collisions_electrons(sim: SimulationState):
    #   --- STEP 6: COLLISIONS ---
    k = 0
    while k < sim.N_e:
        v_sqr = sim.vx_e[k]**2 + sim.vy_e[k]**2 + sim.vz_e[k]**2
        velocity = math.sqrt(v_sqr)
        energy = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J
        energy_index = min(int(energy / cs.DE_CS + 0.5), cs.CS_RANGES - 1)
        nu = sim.sigma_tot_e[energy_index] * velocity
        p_coll = 1.0 - math.exp(-nu * cs.DT_E)
        if sim.rng.random() < p_coll:
            collisions.collision_electron(sim, k, energy_index)
            sim.N_e_coll += 1
            
        k += 1


def step8_collisions_ions(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        return

    k = 0
    while k < sim.N_i:
        vx_a = sim.rng.gauss(0.0, cs.NORMAL_DISTRIBUTION)
        vy_a = sim.rng.gauss(0.0, cs.NORMAL_DISTRIBUTION)
        vz_a = sim.rng.gauss(0.0, cs.NORMAL_DISTRIBUTION)

        gx = sim.vx_i[k] - vx_a
        gy = sim.vy_i[k] - vy_a
        gz = sim.vz_i[k] - vz_a
        g_sqr = gx*gx + gy*gy + gz*gz
        g = math.sqrt(g_sqr)

        energy = 0.5 * cs.MU_ARAR * g_sqr / cs.EV_TO_J
        energy_index = min(int(energy / cs.DE_CS + 0.5), cs.CS_RANGES - 1)
        nu = sim.sigma_tot_i[energy_index] * g
        p_coll = 1.0 - math.exp(-nu * cs.DT_I)

        if sim.rng.random() < p_coll:
            collisions.collision_ion(sim, k, vx_a, vy_a, vz_a, energy_index)
            sim.N_i_coll += 1
        
        k += 1


def step9_collect_xt_data(sim: SimulationState, t_index: int):
    if sim.measurement_mode:
        for p in range(cs.N_G):
            sim.pot_xt[p][t_index]    += sim.pot[p]
            sim.efield_xt[p][t_index] += sim.efield[p]
            sim.ne_xt[p][t_index]     += sim.e_density[p]
            sim.ni_xt[p][t_index]     += sim.i_density[p]



def do_one_cycle(sim: SimulationState, datafile_path: str = "conv.dat"):
    """
    Symulacja jednego pełnego cyklu RF (Radio Frequency).
    To najcięższa pętla w programie, łącząca PIC (Particle-in-Cell) 
    z MCC (Monte Carlo Collisions).
    """

    for t in range(cs.N_T): #   the RF period is divided into N_T equal time intervals (time step DT_E)
        sim.Time += cs.DT_E #   update of the total simulated time
        t_index: int = t // cs.N_BIN    #   index for XT distributions

        step1_compute_electron_density(sim)
        step1_compute_ion_density(sim, t)

        step2_solve_poisson(sim)

        step3_move_electrons(sim, t_index)
        step4_move_ions(sim, t_index, t)
        
        step5_check_boundaries_electrons(sim)
        step6_check_boundaries_ions(sim, t)

        step7_collisions_electrons(sim)
        step8_collisions_ions(sim, t)

        step9_collect_xt_data(sim, t_index)

        if (t % 1000) == 0:
            print(f" c = {sim.cycle:8d}  t = {t:8d}  #e = {sim.N_e:8d}  #i = {sim.N_i:8d}")

    with open(datafile_path, "a") as f:
        f.write(f"{sim.cycle:8d}  {sim.N_e:8d}  {sim.N_i:8d}\n")