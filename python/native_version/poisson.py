import constants as cs
from state import SimulationState
import math

def solve_poisson(sim: SimulationState, rho1: cs.xvector, tt: float):
    """
        solve Poisson equation (Thomas algorithm)
    """
    
    g: cs.xvector = [0.0] * cs.N_G
    w: cs.xvector = [0.0] * cs.N_G
    f: cs.xvector = [0.0] * cs.N_G

    #   potential at the powered electrode
    sim.pot[0] = cs.VOLTAGE * math.cos(cs.OMEGA * tt)
    #   potential at the grounded electrode
    sim.pot[cs.N_G-1] = 0.0

    #   solve Poisson equation
    for i in range(1, cs.N_G-1):
        f[i] = cs.ALPHA * rho1[i]

    f[1] -= sim.pot[0]

    f[cs.N_G - 2] -= sim.pot[cs.N_G - 1]
    
    w[1] = cs.C / cs.B
    g[1] = f[1] / cs.B

    #   potential at the grid points between the electrodes
    for i in range(2, cs.N_G - 1):
        w[i] = cs.C / (cs.B - cs.A * w[i-1])
        g[i] = (f[i] - cs.A * g[i - 1]) / (cs.B - cs.A * w[i - 1])

    sim.pot[cs.N_G - 2] = g[cs.N_G - 2]

    #   compute electric field
    for i in range(1, cs.N_G - 1):
        sim.efield[i] = (sim.pot[i - 1] - sim.pot[i + 1]) * cs.S

    sim.efield[0] = (sim.pot[0] - sim.pot[1]) * cs.INV_DX - rho1[0] * cs.DX / (2.0 * cs.EPSILON0)
    sim.efield[cs.N_G - 1] = (sim.pot[cs.N_G - 2] - sim.pot[cs.N_G - 1]) * cs.INV_DX + rho1[cs.N_G - 1] * cs.DX / (2.0 * cs.EPSILON0)