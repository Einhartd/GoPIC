import constants as cs
from state import SimulationState
import math


def set_electron_cross_sections_ar(sim: SimulationState):
    """
    electron cross sections: A V Phelps & Z Lj Petrovic, PSST 8 R21 (1999)
    """

    i: int
    en: float
    qmel: float
    qexc: float
    qion: float

    print(f">> PyPIC: Setting e- / Ar cross sections\n")
    for i in range(cs.CS_RANGES):
        en = cs.DE_CS if i==0 else cs.DE_CS * i

        term1 = 6.0 / (1.0 + (en/0.1) + (en/0.6)**2.0)**3.3
        term2 = 1.1 * (en**1.4) / (1.0 + (en/15.0)**1.2) / math.sqrt(1.0 + (en/5.5)**2.5 + (en/60.0)**4.1)
        term3 = 0.05 / (1.0 + en/10.0)**2.0
        term4 = 0.01 * (en**3.0) / (1.0 + (en/12.0)**6.0)
        qmel = abs(term1 - term2) + term3 + term4

        if en > cs.E_EXC_TH:
            qexc = (0.034 * ((en-11.5)**1.1) * (1.0 + (en/15.0)**2.8) / (1.0 + (en/23.0)**5.5) 
                   + 0.023 * (en-11.5) / (1.0 + en/80.0)**1.9)
        else:
            qexc = 0.0
            
        # Przekrój czynny na jonizację (Ionization)
        if en > cs.E_ION_TH:
            qion = (970.0 * (en-15.8) / (70.0 + en)**2.0 
                   + 0.06 * ((en-15.8)**2.0) * math.exp(-en/9.0))
        else:
            qion = 0.0
            
        # Zapis do dwuwymiarowej tablicy sigma
        sim.sigma[cs.E_ELA][i] = qmel * 1.0e-20
        sim.sigma[cs.E_EXC][i] = qexc * 1.0e-20
        sim.sigma[cs.E_ION][i] = qion * 1.0e-20


def set_ion_cross_sections_ar(sim: SimulationState):
    """
    ion cross sections: A. V. Phelps, J. Appl. Phys. 76, 747 (1994)
    """

    e_com: float
    e_lab: float
    qmom: float
    qback: float
    qiso: float

    print(f">> PyPIC: Setting Ar+ / Ar cross sections\n")
    for i in range(cs.CS_RANGES):
        e_com = cs.DE_CS if i==0 else cs.DE_CS * i
        e_lab = 2.0 * e_com
        qmom = 1.15e-18 * (e_lab ** -0.1) * ((1.0 + 0.015 / e_lab)**0.6)
        qiso = 2e-19 * (e_lab ** -0.5) / (1.0 + e_lab) + 3e-19 * e_lab / ((1.0 + e_lab / 3.0) ** 2.0)
        qback = (qmom - qiso) / 2.0
        sim.sigma[cs.I_ISO][i] = qiso
        sim.sigma[cs.I_BACK][i] = qback


def calc_total_cross_sections(sim: SimulationState):
    """
    calculation of total cross sections for electrons and ions
    """

    for i in range(cs.CS_RANGES):
        #   total macroscopic cross section of electrons
        sim.sigma_tot_e[i] = (sim.sigma[cs.E_ELA][i] + sim.sigma[cs.E_EXC][i] + sim.sigma[cs.E_ION][i]) * cs.GAS_DENSITY
        #   total macroscopic cross section of ions
        sim.sigma_tot_i[i] = (sim.sigma[cs.I_ISO][i] + sim.sigma[cs.I_BACK][i]) * cs.GAS_DENSITY


def test_cross_sections(sim: SimulationState):
    """
    test of cross sections fro electorns and ions
    """

    with open("cross_sections.dat", "w") as f:
        for i in range(cs.CS_RANGES):
            #   wypisanie energii
            f.write(f"{i * cs.DE_CS:12.4f} ")
            #   wypisanie wartości z tablicy sigma dla wszystkich procesów
            for j in range(cs.N_CS):
                f.write(f"{sim.sigma[j][i]:14e} ")
            #   nowa linia na koncu wiersza
            f.write("\n")
