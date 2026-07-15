import numpy as np
import numba
import math
import constants as cs
from state import SimulationState


def compute_null_collision_params(sim: SimulationState):
    """
    Obliczanie parametrów metody Null-Collision (nu* oraz P*) dla elektronów i jonów.
    """
    sim.nu_star_e = max_electron_coll_freq(sim)
    sim.P_star_e  = 1.0 - math.exp(-sim.nu_star_e * cs.DT_E)

    sim.nu_star_i = max_ion_coll_freq(sim)
    sim.P_star_i  = 1.0 - math.exp(-sim.nu_star_i * cs.DT_I)

    print(f">> GoPIC (Numba): null-collision: nu*_e = {sim.nu_star_e:.6e}, P*_e = {sim.P_star_e:.6e}")
    print(f">> GoPIC (Numba): null-collision: nu*_i = {sim.nu_star_i:.6e}, P*_i = {sim.P_star_i:.6e}")

def max_electron_coll_freq(sim: SimulationState) -> float:
    """
    Znajdowanie górnego limitu częstości kolizji dla elektronów
    """
    nu_max = 0.0
    for i in range(cs.CS_RANGES):
        e = i * cs.DE_CS
        v = math.sqrt(2.0 * e * cs.EV_TO_J / cs.E_MASS) if e > 0 else 0.0
        nu = v * sim.sigma_tot_e[i]
        if nu > nu_max:
            nu_max = nu
    return nu_max


def max_ion_coll_freq(sim: SimulationState) -> float:
    """
    Znajdowanie górnego limitu częstości kolizji dla jonów
    """
    nu_max = 0.0
    for i in range(cs.CS_RANGES):
        e = i * cs.DE_CS
        g = math.sqrt(2.0 * e * cs.EV_TO_J / cs.MU_ARAR) if e > 0 else 0.0
        nu = g * sim.sigma_tot_i[i]
        if nu > nu_max:
            nu_max = nu
    return nu_max


@numba.njit(cache=True)
def collision_electron(k, x_e, vx_e, vy_e, vz_e, N_e,
                        x_i, vx_i, vy_i, vz_i, N_i,
                        sigma,
                        e_index,
                        F1, F2, PI, TWO_PI,
                        E_MASS, AR_MASS,
                        E_EXC_TH, E_ION_TH, EV_TO_J,
                        NORMAL_DISTRIBUTION,
                        E_ELA, E_EXC, E_ION):
    """
    e / Ar collision (cold gas approximation).
    Modifies vx_e, vy_e, vz_e in place.
    Returns updated (N_e, N_i) — may increase by 1 if ionization occurs.
    """
    xe  = x_e[k]
    vxe = vx_e[k]
    vye = vy_e[k]
    vze = vz_e[k]

    gx = vxe
    gy = vye
    gz = vze
    g  = math.sqrt(gx * gx + gy * gy + gz * gz)
    wx = F1 * vxe
    wy = F1 * vye
    wz = F1 * vze

    if gx == 0.0:
        theta = 0.5 * PI
    else:
        theta = math.atan2(math.sqrt(gy * gy + gz * gz), gx)

    if gy == 0.0:
        if gz > 0.0:
            phi = 0.5 * PI
        else:
            phi = -0.5 * PI
    else:
        phi = math.atan2(gz, gy)

    st = math.sin(theta)
    ct = math.cos(theta)
    sp = math.sin(phi)
    cp = math.cos(phi)

    t0 = sigma[E_ELA, e_index]
    t1 = t0 + sigma[E_EXC, e_index]
    t2 = t1 + sigma[E_ION, e_index]

    rnd = np.random.uniform(0.0, 1.0)

    if rnd < (t0 / t2):
        # elastic
        chi = math.acos(1.0 - 2.0 * np.random.uniform(0.0, 1.0))
        eta = TWO_PI * np.random.uniform(0.0, 1.0)

    elif rnd < (t1 / t2):
        # excitation
        energy = 0.5 * E_MASS * g * g
        energy = abs(energy - E_EXC_TH * EV_TO_J)
        g = math.sqrt(2.0 * energy / E_MASS)
        chi = math.acos(1.0 - 2.0 * np.random.uniform(0.0, 1.0))
        eta = TWO_PI * np.random.uniform(0.0, 1.0)

    else:
        # ionization — creates new electron + ion pair
        energy  = 0.5 * E_MASS * g * g
        energy  = abs(energy - E_ION_TH * EV_TO_J)
        e_ej    = 10.0 * math.tan(np.random.uniform(0.0, 1.0) * math.atan(energy / EV_TO_J / 20.0)) * EV_TO_J
        e_sc    = abs(energy - e_ej)
        g       = math.sqrt(2.0 * e_sc / E_MASS)
        g2      = math.sqrt(2.0 * e_ej / E_MASS)
        chi     = math.acos(math.sqrt(e_sc / energy))
        chi2    = math.acos(math.sqrt(e_ej / energy))
        eta     = TWO_PI * np.random.uniform(0.0, 1.0)
        eta2    = eta + PI

        sc2 = math.sin(chi2); cc2 = math.cos(chi2)
        se2 = math.sin(eta2); ce2 = math.cos(eta2)

        gx2 = g2 * (ct * cc2 - st * sc2 * ce2)
        gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2)
        gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2)

        # New electron and ion (guarded against overflow to prevent SEGFAULT)
        if N_e < len(x_e) and N_i < len(x_i):
            x_e[N_e]  = xe
            vx_e[N_e] = wx + F2 * gx2
            vy_e[N_e] = wy + F2 * gy2
            vz_e[N_e] = wz + F2 * gz2
            N_e += 1

            # New ion (thermal background velocity)
            x_i[N_i]  = xe
            vx_i[N_i] = np.random.normal(0.0, NORMAL_DISTRIBUTION)
            vy_i[N_i] = np.random.normal(0.0, NORMAL_DISTRIBUTION)
            vz_i[N_i] = np.random.normal(0.0, NORMAL_DISTRIBUTION)
            N_i += 1
        else:
            # Silence print if desired, or print once
            pass

    # Scatter primary electron
    sc = math.sin(chi); cc = math.cos(chi)
    se = math.sin(eta); ce = math.cos(eta)

    gx_new = g * (ct * cc - st * sc * ce)
    gy_new = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se)
    gz_new = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se)

    vx_e[k] = wx + F2 * gx_new
    vy_e[k] = wy + F2 * gy_new
    vz_e[k] = wz + F2 * gz_new

    return N_e, N_i


@numba.njit(cache=True)
def collision_ion(k, vx_i, vy_i, vz_i,
                   vx_a, vy_a, vz_a,
                   sigma, e_index,
                   PI, TWO_PI,
                   I_ISO, I_BACK):
    """
    Ar+ / Ar collision.
    Modifies vx_i, vy_i, vz_i[k] in place.
    Gas atom velocity (vx_a, vy_a, vz_a) pre-sampled by caller.
    """
    vx_1 = vx_i[k]; vy_1 = vy_i[k]; vz_1 = vz_i[k]

    gx = vx_1 - vx_a; gy = vy_1 - vy_a; gz = vz_1 - vz_a
    g  = math.sqrt(gx * gx + gy * gy + gz * gz)

    wx = 0.5 * (vx_1 + vx_a)
    wy = 0.5 * (vy_1 + vy_a)
    wz = 0.5 * (vz_1 + vz_a)

    if gx == 0.0:
        theta = 0.5 * PI
    else:
        theta = math.atan2(math.sqrt(gy * gy + gz * gz), gx)

    if gy == 0.0:
        if gz > 0.0:
            phi = 0.5 * PI
        else:
            phi = -0.5 * PI
    else:
        phi = math.atan2(gz, gy)

    t1 = sigma[I_ISO,  e_index]
    t2 = t1 + sigma[I_BACK, e_index]

    if np.random.uniform(0.0, 1.0) < (t1 / t2):
        chi = math.acos(1.0 - 2.0 * np.random.uniform(0.0, 1.0))
    else:
        chi = PI

    eta = TWO_PI * np.random.uniform(0.0, 1.0)

    sc = math.sin(chi); cc = math.cos(chi)
    se = math.sin(eta); ce = math.cos(eta)
    st = math.sin(theta); ct = math.cos(theta)
    sp = math.sin(phi);   cp = math.cos(phi)

    gx_new = g * (ct * cc - st * sc * ce)
    gy_new = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se)
    gz_new = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se)

    vx_i[k] = wx + 0.5 * gx_new
    vy_i[k] = wy + 0.5 * gy_new
    vz_i[k] = wz + 0.5 * gz_new
