import numpy as np
from config.models import AppConfig


def calculate_cross_sections(cfg: AppConfig):
    """
    Calculates electron and ion cross sections for Argon based on
    analytical formulas from the original eduPIC C++ code.
    """
    cs_ranges = cfg.cs.CS_RANGES
    de_cs = cfg.cs.DE_CS
    gas_density = cfg.GAS_DENSITY

    # Energy array [eV]
    energies = np.arange(cs_ranges) * de_cs
    energies[0] = de_cs  # Avoid zero energy in formulas if necessary

    # --- Electron Cross Sections (A V Phelps & Z Lj Petrovic, PSST 8 R21 (1999)) ---

    # Elastic (qmel)
    qmel = (
        np.abs(
            6.0 / (1.0 + (energies / 0.1) + (energies / 0.6) ** 2.0) ** 3.3
            - 1.1
            * energies**1.4
            / (1.0 + (energies / 15.0) ** 1.2)
            / np.sqrt(1.0 + (energies / 5.5) ** 2.5 + (energies / 60.0) ** 4.1)
        )
        + 0.05 / (1.0 + energies / 10.0) ** 2.0
        + 0.01 * energies**3.0 / (1.0 + (energies / 12.0) ** 6.0)
    )

    # Excitation (qexc)
    qexc = np.zeros_like(energies)
    mask_exc = energies > cfg.cs.E_EXC_TH
    qexc[mask_exc] = (
        0.034
        * (energies[mask_exc] - 11.5) ** 1.1
        * (1.0 + (energies[mask_exc] / 15.0) ** 2.8)
        / (1.0 + (energies[mask_exc] / 23.0) ** 5.5)
        + 0.023 * (energies[mask_exc] - 11.5) / (1.0 + energies[mask_exc] / 80.0) ** 1.9
    )

    # Ionization (qion)
    qion = np.zeros_like(energies)
    mask_ion = energies > cfg.cs.E_ION_TH
    qion[mask_ion] = 970.0 * (energies[mask_ion] - 15.8) / (
        70.0 + energies[mask_ion]
    ) ** 2.0 + 0.06 * (energies[mask_ion] - 15.8) ** 2.0 * np.exp(
        -energies[mask_ion] / 9
    )

    # Convert to m^2 (formulas are in units of 10^-20 m^2 in C++ code)
    sigma_e_ela = qmel * 1.0e-20
    sigma_e_exc = qexc * 1.0e-20
    sigma_e_ion = qion * 1.0e-20

    # Total macroscopic cross section for electrons
    sigma_tot_e = (sigma_e_ela + sigma_e_exc + sigma_e_ion) * gas_density

    # --- Ion Cross Sections (A. V. Phelps, J. Appl. Phys. 76, 747 (1994)) ---

    e_com = energies  # Center of mass energy
    e_lab = 2.0 * e_com  # Laboratory frame energy

    qmom = 1.15e-18 * e_lab ** (-0.1) * (1.0 + 0.015 / e_lab) ** 0.6
    qiso = (
        2e-19 * e_lab ** (-0.5) / (1.0 + e_lab)
        + 3e-19 * e_lab / (1.0 + e_lab / 3.0) ** 2.0
    )
    qback = (qmom - qiso) / 2.0

    sigma_i_iso = qiso
    sigma_i_back = qback

    # Total macroscopic cross section for ions
    sigma_tot_i = (sigma_i_iso + sigma_i_back) * gas_density

    return {
        "sigma_e_ela": sigma_e_ela,
        "sigma_e_exc": sigma_e_exc,
        "sigma_e_ion": sigma_e_ion,
        "sigma_tot_e": sigma_tot_e,
        "sigma_i_iso": sigma_i_iso,
        "sigma_i_back": sigma_i_back,
        "sigma_tot_i": sigma_tot_i,
    }


def get_max_coll_frequencies(cfg: AppConfig, cross_sections: dict):
    """
    Finds upper limit of collision frequencies for electrons and ions.
    """
    cs_ranges = cfg.cs.CS_RANGES
    de_cs = cfg.cs.DE_CS
    energies = np.arange(cs_ranges) * de_cs
    ev_to_j = cfg.const.EV_TO_J

    # Electrons
    v_e = np.sqrt(2.0 * energies * ev_to_j / cfg.const.E_MASS)
    nu_e = v_e * cross_sections["sigma_tot_e"]
    nu_e_max = np.max(nu_e)

    # Ions
    g_i = np.sqrt(2.0 * energies * ev_to_j / cfg.const.MU_ARAR)
    nu_i = g_i * cross_sections["sigma_tot_i"]
    nu_i_max = np.max(nu_i)

    return nu_e_max, nu_i_max
