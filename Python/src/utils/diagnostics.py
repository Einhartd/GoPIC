import numpy as np
from core.state import SimulationState
from utils.io import save_density, save_eepf, save_ifed, save_xt_data
from core.cross_sections import get_max_coll_frequencies


def norm_all_xt(state: SimulationState, no_of_cycles: int):
    """
    Normalizes all XT (Spatio-temporal) data at the end of the simulation.
    """
    cfg = state.cfg

    f1 = float(cfg.N_XT) / float(no_of_cycles * cfg.sim.N_T)
    f2 = (
        cfg.sim.WEIGHT
        / (cfg.sim.ELECTRODE_AREA * cfg.DX)
        / (no_of_cycles * (cfg.PERIOD / float(cfg.N_XT)))
    )

    state.pot_xt *= f1
    state.efield_xt *= f1
    state.ne_xt *= f1
    state.ni_xt *= f1

    # Electrons
    mask_e = state.counter_e_xt > 0
    state.ue_xt[mask_e] /= state.counter_e_xt[mask_e]
    state.je_xt[mask_e] = (
        -state.ue_xt[mask_e] * state.ne_xt[mask_e] * cfg.const.E_CHARGE
    )
    state.meanee_xt[mask_e] /= state.counter_e_xt[mask_e]
    state.ioniz_rate_xt[mask_e] *= f2

    state.ue_xt[~mask_e] = 0.0
    state.je_xt[~mask_e] = 0.0
    state.meanee_xt[~mask_e] = 0.0
    state.ioniz_rate_xt[~mask_e] = 0.0

    # Ions
    mask_i = state.counter_i_xt > 0
    state.ui_xt[mask_i] /= state.counter_i_xt[mask_i]
    state.ji_xt[mask_i] = state.ui_xt[mask_i] * state.ni_xt[mask_i] * cfg.const.E_CHARGE
    state.meanei_xt[mask_i] /= state.counter_i_xt[mask_i]

    state.ui_xt[~mask_i] = 0.0
    state.ji_xt[~mask_i] = 0.0
    state.meanei_xt[~mask_i] = 0.0

    # Power
    state.powere_xt = state.je_xt * state.efield_xt
    state.poweri_xt = state.ji_xt * state.efield_xt


def check_and_save_info(
    state: SimulationState, no_of_cycles: int, cross_sections: dict
):
    """
    Generates simulation report including stability and accuracy conditions.
    """
    cfg = state.cfg
    const = cfg.const

    density = (
        state.cumul_e_density[cfg.sim.N_G // 2]
        / float(no_of_cycles)
        / float(cfg.sim.N_T)
    )
    plas_freq = (
        const.E_CHARGE * np.sqrt(density / const.EPSILON0 / const.E_MASS)
        if density > 0
        else 0
    )
    meane = (
        state.mean_energy_accu_center / float(state.mean_energy_counter_center)
        if state.mean_energy_counter_center > 0
        else 0
    )
    kT = 2.0 * meane * const.EV_TO_J / 3.0

    sim_time = float(no_of_cycles) / cfg.sim.FREQUENCY
    ecoll_freq = (
        float(state.n_e_coll) / sim_time / float(state.n_e) if state.n_e > 0 else 0
    )
    icoll_freq = (
        float(state.n_i_coll) / sim_time / float(state.n_i) if state.n_i > 0 else 0
    )
    debye_length = (
        np.sqrt(const.EPSILON0 * kT / density) / const.E_CHARGE if density > 0 else 0
    )

    nu_e_max, nu_i_max = get_max_coll_frequencies(cfg, cross_sections)

    conditions_ok = True
    c_plas = plas_freq * cfg.DT_E
    c_debye = cfg.DX / debye_length if debye_length > 0 else float("inf")
    c_nu_e = nu_e_max * cfg.DT_E
    c_nu_i = nu_i_max * cfg.DT_I

    if c_plas > 0.2:
        conditions_ok = False
    if c_debye > 1.0:
        conditions_ok = False
    if c_nu_e > 0.05:
        conditions_ok = False
    if c_nu_i > 0.05:
        conditions_ok = False

    with open("info.txt", "w") as f:
        f.write(
            "########################## eduPIC simulation report ############################\n"
        )
        f.write("Simulation parameters:\n")
        f.write(f"Gap distance                          = {cfg.sim.L:12.3e} [m]\n")
        f.write(f"# of grid divisions                   = {cfg.sim.N_G:12d}\n")
        f.write(
            f"Frequency                             = {cfg.sim.FREQUENCY:12.3e} [Hz]\n"
        )
        f.write(f"# of time steps / period              = {cfg.sim.N_T:12d}\n")
        f.write(f"# of electron / ion time steps        = {cfg.sim.N_SUB:12d}\n")
        f.write(
            f"Voltage amplitude                     = {cfg.sim.VOLTAGE:12.3e} [V]\n"
        )
        f.write(
            f"Pressure (Ar)                         = {cfg.sim.PRESSURE:12.3e} [Pa]\n"
        )
        f.write(
            f"Temperature                           = {cfg.sim.TEMPERATURE:12.3e} [K]\n"
        )
        f.write(f"Superparticle weight                  = {cfg.sim.WEIGHT:12.3e}\n")
        f.write(f"# of simulation cycles in this run    = {no_of_cycles:12d}\n")
        f.write(
            "--------------------------------------------------------------------------------\n"
        )
        f.write("Plasma characteristics:\n")
        f.write(f"Electron density @ center             = {density:12.3e} [m^{{-3}}]\n")
        f.write(f"Plasma frequency @ center             = {plas_freq:12.3e} [rad/s]\n")
        f.write(f"Debye length @ center                 = {debye_length:12.3e} [m]\n")
        f.write(f"Electron collision frequency          = {ecoll_freq:12.3e} [1/s]\n")
        f.write(f"Ion collision frequency               = {icoll_freq:12.3e} [1/s]\n")
        f.write(
            "--------------------------------------------------------------------------------\n"
        )
        f.write("Stability and accuracy conditions:\n")

        f.write(
            f"Plasma frequency @ center * DT_E      = {c_plas:12.3f} (OK if less than 0.20)\n"
        )
        f.write(
            f"DX / Debye length @ center            = {c_debye:12.3f} (OK if less than 1.00)\n"
        )
        f.write(
            f"Max. electron coll. frequency * DT_E  = {c_nu_e:12.3f} (OK if less than 0.05)\n"
        )
        f.write(
            f"Max. ion coll. frequency * DT_I       = {c_nu_i:12.3f} (OK if less than 0.05)\n"
        )

        if not conditions_ok:
            f.write(
                "--------------------------------------------------------------------------------\n"
            )
            f.write(
                "** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **\n"
            )
            f.write(
                "--------------------------------------------------------------------------------\n"
            )
            print(">> eduPIC: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!")
            print(
                ">> eduPIC: for details see 'info.txt' and refine simulation settings!"
            )
            return

        v_max = cfg.DX / cfg.DT_E
        e_max = 0.5 * const.E_MASS * v_max**2 / const.EV_TO_J
        f.write(f"Max e- energy for CFL condition       = {e_max:12.3f} [eV]\n")
        f.write(
            "Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!\n"
        )
        f.write(
            "--------------------------------------------------------------------------------\n"
        )

        print(">> eduPIC: saving diagnostics data")
        save_density(state, no_of_cycles)
        save_eepf(state)
        mean_i_energy_pow, mean_i_energy_gnd = save_ifed(state)

        norm_all_xt(state, no_of_cycles)
        save_xt_data(state)

        f.write("Particle characteristics at the electrodes:\n")
        flux_pow_i = (
            state.n_i_abs_pow
            * cfg.sim.WEIGHT
            / cfg.sim.ELECTRODE_AREA
            / (no_of_cycles * cfg.PERIOD)
        )
        flux_gnd_i = (
            state.n_i_abs_gnd
            * cfg.sim.WEIGHT
            / cfg.sim.ELECTRODE_AREA
            / (no_of_cycles * cfg.PERIOD)
        )
        flux_pow_e = (
            state.n_e_abs_pow
            * cfg.sim.WEIGHT
            / cfg.sim.ELECTRODE_AREA
            / (no_of_cycles * cfg.PERIOD)
        )
        flux_gnd_e = (
            state.n_e_abs_gnd
            * cfg.sim.WEIGHT
            / cfg.sim.ELECTRODE_AREA
            / (no_of_cycles * cfg.PERIOD)
        )

        f.write(
            f"Ion flux at powered electrode         = {flux_pow_i:12.3e} [m^{{-2}} s^{{-1}}]\n"
        )
        f.write(
            f"Ion flux at grounded electrode        = {flux_gnd_i:12.3e} [m^{{-2}} s^{{-1}}]\n"
        )
        f.write(
            f"Mean ion energy at powered electrode  = {mean_i_energy_pow:12.3e} [eV]\n"
        )
        f.write(
            f"Mean ion energy at grounded electrode = {mean_i_energy_gnd:12.3e} [eV]\n"
        )
        f.write(
            f"Electron flux at powered electrode    = {flux_pow_e:12.3e} [m^{{-2}} s^{{-1}}]\n"
        )
        f.write(
            f"Electron flux at grounded electrode   = {flux_gnd_e:12.3e} [m^{{-2}} s^{{-1}}]\n"
        )
        f.write(
            "--------------------------------------------------------------------------------\n"
        )

        power_e = np.mean(state.powere_xt)
        power_i = np.mean(state.poweri_xt)

        f.write("Absorbed power calculated as <j*E>:\n")
        f.write(
            f"Electron power density (average)      = {power_e:12.3e} [W m^{{-3}}]\n"
        )
        f.write(
            f"Ion power density (average)           = {power_i:12.3e} [W m^{{-3}}]\n"
        )
        f.write(
            f"Total power density(average)          = {power_e + power_i:12.3e} [W m^{{-3}}]\n"
        )
        f.write(
            "--------------------------------------------------------------------------------\n"
        )
