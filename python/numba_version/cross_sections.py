import numpy as np
import constants as cs
from state import SimulationState

def set_electron_cross_sections_ar(sim: SimulationState):
    """
    electron cross sections: A V Phelps & Z Lj Petrovic, PSST 8 R21 (1999)
    """
    print(f">> PyPIC: Setting e- / Ar cross sections")
    indices = np.arange(cs.CS_RANGES, dtype=np.float64)
    en = cs.DE_CS * indices
    en[0] = cs.DE_CS

    term1 = 6.0 / (1.0 + (en / 0.1) + (en / 0.6)**2.0)**3.3
    term2 = 1.1 * (en**1.4) / (1.0 + (en / 15.0)**1.2) / np.sqrt(1.0 + (en / 5.5)**2.5 + (en / 60.0)**4.1)
    term3 = 0.05 / (1.0 + en / 10.0)**2.0
    term4 = 0.01 * (en**3.0) / (1.0 + (en / 12.0)**6.0)
    qmel = np.abs(term1 - term2) + term3 + term4

    qexc = np.zeros(cs.CS_RANGES, dtype=np.float64)
    mask_exc = en > cs.E_EXC_TH
    qexc[mask_exc] = (0.034 * ((en[mask_exc] - 11.5)**1.1) * (1.0 + (en[mask_exc] / 15.0)**2.8) / (1.0 + (en[mask_exc] / 23.0)**5.5)
                      + 0.023 * (en[mask_exc] - 11.5) / (1.0 + en[mask_exc] / 80.0)**1.9)

    qion = np.zeros(cs.CS_RANGES, dtype=np.float64)
    mask_ion = en > cs.E_ION_TH
    qion[mask_ion] = (970.0 * (en[mask_ion] - 15.8) / (70.0 + en[mask_ion])**2.0
                      + 0.06 * ((en[mask_ion] - 15.8)**2.0) * np.exp(-en[mask_ion] / 9.0))

    sim.sigma[cs.E_ELA, :] = qmel * 1.0e-20
    sim.sigma[cs.E_EXC, :] = qexc * 1.0e-20
    sim.sigma[cs.E_ION, :] = qion * 1.0e-20


def set_ion_cross_sections_ar(sim: SimulationState):
    """
    ion cross sections: A. V. Phelps, J. Appl. Phys. 76, 747 (1994)
    """
    print(f">> PyPIC: Setting Ar+ / Ar cross sections")
    indices = np.arange(cs.CS_RANGES, dtype=np.float64)
    e_com = cs.DE_CS * indices
    e_com[0] = cs.DE_CS

    e_lab = 2.0 * e_com
    qmom = 1.15e-18 * (e_lab ** -0.1) * ((1.0 + 0.015 / e_lab)**0.6)
    qiso = 2e-19 * (e_lab ** -0.5) / (1.0 + e_lab) + 3e-19 * e_lab / ((1.0 + e_lab / 3.0) ** 2.0)
    qback = (qmom - qiso) / 2.0

    sim.sigma[cs.I_ISO, :] = qiso
    sim.sigma[cs.I_BACK, :] = qback


def calc_total_cross_sections(sim: SimulationState):
    """
    calculation of total cross sections for electrons and ions
    """
    sim.sigma_tot_e[:] = (sim.sigma[cs.E_ELA, :] + sim.sigma[cs.E_EXC, :] + sim.sigma[cs.E_ION, :]) * cs.GAS_DENSITY
    sim.sigma_tot_i[:] = (sim.sigma[cs.I_ISO, :] + sim.sigma[cs.I_BACK, :]) * cs.GAS_DENSITY


def test_cross_sections(sim: SimulationState):
    """
    test of cross sections for electrons and ions
    """
    with open("cross_sections.dat", "w") as f:
        for i in range(cs.CS_RANGES):
            f.write(f"{i * cs.DE_CS:12.4f} ")
            for j in range(cs.N_CS):
                f.write(f"{sim.sigma[j, i]:14e} ")
            f.write("\n")
