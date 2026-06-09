import numpy as np
from core.state import SimulationState


def collision_electron(
    state: SimulationState,
    k: int,
    energy_index: int,
    sigma: dict,
    rng: np.random.Generator,
):
    """
    Handles a single electron/Argon collision.
    Replicates the cold gas approximation from eduPIC C++ code.
    """
    cfg = state.cfg
    const = cfg.const

    # Mass factors
    f1 = const.E_MASS / (const.E_MASS + const.AR_MASS)
    f2 = const.AR_MASS / (const.E_MASS + const.AR_MASS)

    # Relative velocity & center of mass velocity
    vx, vy, vz = state.vx_e[k], state.vy_e[k], state.vz_e[k]
    g = np.sqrt(vx**2 + vy**2 + vz**2)
    wx, wy, wz = f1 * vx, f1 * vy, f1 * vz

    # Euler angles for relative velocity
    if vx == 0:
        theta = 0.5 * const.PI
    else:
        theta = np.arctan2(np.sqrt(vy**2 + vz**2), vx)

    if vy == 0:
        phi = 0.5 * const.PI if vz > 0 else -0.5 * const.PI
    else:
        phi = np.arctan2(vz, vy)

    st, ct = np.sin(theta), np.cos(theta)
    sp, cp = np.sin(phi), np.cos(phi)

    # Type of collision
    t0 = sigma["sigma_e_ela"][energy_index]
    t1 = t0 + sigma["sigma_e_exc"][energy_index]
    t2 = t1 + sigma["sigma_e_ion"][energy_index]

    rnd = rng.random()

    if rnd < (t0 / t2):  # Elastic scattering
        chi = np.arccos(1.0 - 2.0 * rng.random())  # Isotropic
        eta = const.TWO_PI * rng.random()
    elif rnd < (t1 / t2):  # Excitation
        energy = 0.5 * const.E_MASS * g**2
        energy = abs(energy - cfg.cs.E_EXC_TH * const.EV_TO_J)
        g = np.sqrt(2.0 * energy / const.E_MASS)
        chi = np.arccos(1.0 - 2.0 * rng.random())
        eta = const.TWO_PI * rng.random()
    else:  # Ionization
        energy = 0.5 * const.E_MASS * g**2
        energy = abs(energy - cfg.cs.E_ION_TH * const.EV_TO_J)

        # Opal formula for ejected electron energy (W=10.0 eV for Argon hardcoded in C++)
        e_ej = (
            10.0
            * np.tan(rng.random() * np.arctan(energy / const.EV_TO_J / 20.0))
            * const.EV_TO_J
        )
        e_sc = abs(energy - e_ej)

        g = np.sqrt(2.0 * e_sc / const.E_MASS)  # Scattered electron relative velocity
        g2 = np.sqrt(2.0 * e_ej / const.E_MASS)  # Ejected electron relative velocity

        chi = np.arccos(np.sqrt(e_sc / energy))
        chi2 = np.arccos(np.sqrt(e_ej / energy))
        eta = const.TWO_PI * rng.random()
        eta2 = eta + const.PI

        # New Ejected Electron
        sc2, cc2 = np.sin(chi2), np.cos(chi2)
        se2, ce2 = np.sin(eta2), np.cos(eta2)
        gx2 = g2 * (ct * cc2 - st * sc2 * ce2)
        gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2)
        gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2)

        if state.n_e < cfg.sim.MAX_N_P:
            state.x_e[state.n_e] = state.x_e[k]
            state.vx_e[state.n_e] = wx + f2 * gx2
            state.vy_e[state.n_e] = wy + f2 * gy2
            state.vz_e[state.n_e] = wz + f2 * gz2
            state.n_e += 1

        # New Ion
        if state.n_i < cfg.sim.MAX_N_P:
            state.x_i[state.n_i] = state.x_e[k]
            # Thermal background velocity for ion (Maxwell-Boltzmann)
            thermal_std = np.sqrt(
                const.K_BOLTZMANN * cfg.sim.TEMPERATURE / const.AR_MASS
            )
            state.vx_i[state.n_i] = rng.normal(0, thermal_std)
            state.vy_i[state.n_i] = rng.normal(0, thermal_std)
            state.vz_i[state.n_i] = rng.normal(0, thermal_std)
            state.n_i += 1

    # Update primary electron
    sc, cc = np.sin(chi), np.cos(chi)
    se, ce = np.sin(eta), np.cos(eta)
    gx_new = g * (ct * cc - st * sc * ce)
    gy_new = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se)
    gz_new = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se)

    state.vx_e[k] = wx + f2 * gx_new
    state.vy_e[k] = wy + f2 * gy_new
    state.vz_e[k] = wz + f2 * gz_new


def collision_ion(
    state: SimulationState,
    k: int,
    energy_index: int,
    sigma: dict,
    rng: np.random.Generator,
):
    """
    Handles a single Ion/Argon collision.
    """
    const = state.cfg.const

    # Thermal background velocity for target atom
    thermal_std = np.sqrt(const.K_BOLTZMANN * state.cfg.sim.TEMPERATURE / const.AR_MASS)
    vx2 = rng.normal(0, thermal_std)
    vy2 = rng.normal(0, thermal_std)
    vz2 = rng.normal(0, thermal_std)

    # Relative velocity
    gx = state.vx_i[k] - vx2
    gy = state.vy_i[k] - vy2
    gz = state.vz_i[k] - vz2
    g = np.sqrt(gx**2 + gy**2 + gz**2)

    # Center of mass velocity
    wx = 0.5 * (state.vx_i[k] + vx2)
    wy = 0.5 * (state.vy_i[k] + vy2)
    wz = 0.5 * (state.vz_i[k] + vz2)

    # Euler angles
    if gx == 0:
        theta = 0.5 * const.PI
    else:
        theta = np.arctan2(np.sqrt(gy**2 + gz**2), gx)

    if gy == 0:
        phi = 0.5 * const.PI if gz > 0 else -0.5 * const.PI
    else:
        phi = np.arctan2(gz, gy)

    # Collision type
    t1 = sigma["sigma_i_iso"][energy_index]
    t2 = t1 + sigma["sigma_i_back"][energy_index]

    rnd = rng.random()
    if rnd < (t1 / t2):
        chi = np.arccos(1.0 - 2.0 * rng.random())  # Isotropic
    else:
        chi = const.PI  # Backward

    eta = const.TWO_PI * rng.random()

    sc, cc = np.sin(chi), np.cos(chi)
    se, ce = np.sin(eta), np.cos(eta)
    st, ct = np.sin(theta), np.cos(theta)
    sp, cp = np.sin(phi), np.cos(phi)

    # New relative velocity
    gx_new = g * (ct * cc - st * sc * ce)
    gy_new = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se)
    gz_new = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se)

    # Post-collision velocity
    state.vx_i[k] = wx + 0.5 * gx_new
    state.vy_i[k] = wy + 0.5 * gy_new
    state.vz_i[k] = wz + 0.5 * gz_new
