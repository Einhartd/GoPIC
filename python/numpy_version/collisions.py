import numpy as np
import constants as cs
from state import SimulationState
import math

def max_electron_coll_freq(sim: SimulationState) -> float:
    """
    Znajdowanie górnego limitu częstości kolizji dla elektronów (zvectoryzowane)
    """
    e = np.arange(cs.CS_RANGES, dtype=np.float64) * cs.DE_CS
    v = np.sqrt(2.0 * e * cs.EV_TO_J / cs.E_MASS)
    nu = v * sim.sigma_tot_e
    return float(np.max(nu))

def max_ion_coll_freq(sim: SimulationState) -> float:
    """
    Znajdowanie górnego limitu częstości kolizji dla jonów (zvectoryzowane)
    """
    e = np.arange(cs.CS_RANGES, dtype=np.float64) * cs.DE_CS
    g = np.sqrt(2.0 * e * cs.EV_TO_J / cs.MU_ARAR)
    nu = g * sim.sigma_tot_i
    return float(np.max(nu))

def collision_electron(sim: SimulationState, k: int, e_index: int):
    """
    Obsługa zderzenia elektron / Ar (przybliżenie zimnego gazu).
    Modyfikuje bezpośrednio stan symulacji (prędkości i liczbę cząstek).
    """
    # Pobranie aktualnych wartosci czastki
    xe: float = sim.x_e[k]
    vxe: float = sim.vx_e[k]
    vye: float = sim.vy_e[k]
    vze: float = sim.vz_e[k]

    # calculate relative velocity before collision & velocity of the centre of mass
    gx: float = vxe
    gy: float = vye
    gz: float = vze
    g: float = math.sqrt(gx * gx + gy * gy + gz * gz)
    wx: float = cs.F1 * vxe
    wy: float = cs.F1 * vye
    wz: float = cs.F1 * vze

    # find Euler angles
    if gx == 0.0:
        theta = 0.5 * cs.PI
    else:
        theta = math.atan2(math.sqrt(gy * gy + gz * gz), gx)

    if gy == 0.0:
        if gz > 0.0:
            phi = 0.5 * cs.PI
        else:
            phi = -0.5 * cs.PI
    else:
        phi = math.atan2(gz, gy)

    st = math.sin(theta)
    ct = math.cos(theta)
    sp = math.sin(phi)
    cp = math.cos(phi)

    # choose the type of collision based on the cross sections
    # take into account energy loss in inelastic collisions
    # generate scattering and azimuth angles
    # in case of ionization handle the 'new' electron

    t0 = sim.sigma[cs.E_ELA, e_index]
    t1 = t0 + sim.sigma[cs.E_EXC, e_index]
    t2 = t1 + sim.sigma[cs.E_ION, e_index]

    rnd = sim.rng.random()

    if rnd < (t0 / t2):
        # --- elastic scattering ---
        chi = math.acos(1.0 - 2.0 * sim.rng.random())   # isotropic scattering
        eta = cs.TWO_PI * sim.rng.random()  # azimuthal angle
    elif rnd < (t1 / t2):
        # --- excitation ---
        energy = 0.5 * cs.E_MASS * g * g                # electron energy
        energy = abs(energy - cs.E_EXC_TH * cs.EV_TO_J) # subtract energy loss
        g = math.sqrt(2.0 * energy / cs.E_MASS)         # relative velocity after energy loss
        chi = math.acos(1.0 - 2.0 * sim.rng.random())   # isotropic scattering
        eta = cs.TWO_PI * sim.rng.random()              # azimuthal angle
    else:
        # --- ionization ---
        energy = 0.5 * cs.E_MASS * g * g                # electron energy
        energy = abs(energy - cs.E_ION_TH * cs.EV_TO_J) # subtract energy loss
        
        # energy of the ejected electron
        e_ej = 10.0 * math.tan(sim.rng.random() * math.atan(energy / cs.EV_TO_J / 20.0)) * cs.EV_TO_J
        e_sc = abs(energy - e_ej)                              # energy of scattered electron
        
        g = math.sqrt(2.0 * e_sc / cs.E_MASS)           # relative velocity of scattered electron
        g2 = math.sqrt(2.0 * e_ej / cs.E_MASS)          # relative velocity of ejected electron
        
        chi = math.acos(math.sqrt(e_sc / energy))              # scattering angle for scattered electron
        chi2 = math.acos(math.sqrt(e_ej / energy))             # scattering angle for ejected electrons
        
        eta = cs.TWO_PI * sim.rng.random()              # azimuthal angle for scattered electron
        eta2 = eta + cs.PI                              # azimuthal angle for ejected electron
        
        sc = math.sin(chi2)
        cc = math.cos(chi2)
        se = math.sin(eta2)
        ce = math.cos(eta2)
        
        # Obliczenie prędkości dla wybitego elektronu 
        gx2 = g2 * (ct * cc - st * sc * ce)
        gy2 = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se)
        gz2 = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se)
        
        # Dodanie nowego elektronu na koniec listy
        sim.x_e[sim.N_e] = xe
        sim.vx_e[sim.N_e] = wx + cs.F2 * gx2
        sim.vy_e[sim.N_e] = wy + cs.F2 * gy2
        sim.vz_e[sim.N_e] = wz + cs.F2 * gz2
        sim.N_e += 1
        
        # Dodanie nowego jonu na koniec listy (prędkość z rozkładu termicznego tła)
        sim.x_i[sim.N_i] = xe
        sim.vx_i[sim.N_i] = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION)
        sim.vy_i[sim.N_i] = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION)
        sim.vz_i[sim.N_i] = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION)
        sim.N_i += 1

    # scatter the primary electron
    sc = math.sin(chi)
    cc = math.cos(chi)
    se = math.sin(eta)
    ce = math.cos(eta)

    # compute new relative velocity
    gx_new = g * (ct * cc - st * sc * ce)
    gy_new = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se)
    gz_new = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se)
    
    # post-collision velocity of the colliding electron
    sim.vx_e[k] = wx + cs.F2 * gx_new
    sim.vy_e[k] = wy + cs.F2 * gy_new
    sim.vz_e[k] = wz + cs.F2 * gz_new


def collision_ion(sim: SimulationState, k: int, vx_a: float, vy_a: float, vz_a: float, e_index: int):
    """
    Obsługa zderzenia jon Ar+ / atom Ar.
    Modyfikuje bezpośrednio stan symulacji (prędkości wybranego jonu).
    """
    # pobranie aktualnych wlasciwosci jonu
    vx_1 = sim.vx_i[k]
    vy_1 = sim.vy_i[k]
    vz_1 = sim.vz_i[k]

    # calculate relative velocity before collision
    gx = vx_1 - vx_a
    gy = vy_1 - vy_a
    gz = vz_1 - vz_a
    g = math.sqrt(gx * gx + gy * gy + gz * gz)

    # velocity of the centre of mass
    wx = 0.5 * (vx_1 + vx_a)
    wy = 0.5 * (vy_1 + vy_a)
    wz = 0.5 * (vz_1 + vz_a)

    # find Euler angles
    if gx == 0.0:
        theta = 0.5 * cs.PI
    else:
        theta = math.atan2(math.sqrt(gy * gy + gz * gz), gx)
        
    if gy == 0.0:
        if gz > 0.0:
            phi = 0.5 * cs.PI
        else:
            phi = -0.5 * cs.PI
    else:
        phi = math.atan2(gz, gy)

    # determine the type of collision based on cross sections and generate scattering angle
    t1 = sim.sigma[cs.I_ISO, e_index]
    t2 = t1 + sim.sigma[cs.I_BACK, e_index]
    
    rnd = sim.rng.random()

    if rnd < (t1 / t2):
        # --- isotropic scattering ---
        chi = math.acos(1.0 - 2.0 * sim.rng.random())
    else:
        # --- backward scattering ---
        chi = cs.PI
        
    eta = cs.TWO_PI * sim.rng.random()
    
    sc = math.sin(chi)
    cc = math.cos(chi)
    se = math.sin(eta)
    ce = math.cos(eta)
    
    st = math.sin(theta)
    ct = math.cos(theta)
    sp = math.sin(phi)
    cp = math.cos(phi)

    # compute new relative velocity
    gx_new = g * (ct * cc - st * sc * ce)
    gy_new = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se)
    gz_new = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se)

    # post-collision velocity of the ion
    sim.vx_i[k] = wx + 0.5 * gx_new
    sim.vy_i[k] = wy + 0.5 * gy_new
    sim.vz_i[k] = wz + 0.5 * gz_new
