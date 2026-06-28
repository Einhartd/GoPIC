import numpy as np
from scipy.linalg import solve_banded
import constants as cs
from state import SimulationState


def solve_poisson(sim: SimulationState, rho: np.ndarray, tt: float):
    """Solve Poisson equation using scipy banded solver + vectorized E-field."""

    # Boundary conditions
    sim.pot[0]      = cs.VOLTAGE * np.cos(cs.OMEGA * tt)
    sim.pot[cs.N_G - 1] = 0.0

    # Right-hand side for interior nodes (indices 1..N_G-2)
    f = cs.ALPHA * rho[1:-1].copy()
    f[0]  -= sim.pot[0]
    f[-1] -= sim.pot[cs.N_G - 1]

    # Solve tridiagonal system — result is pot[1..N_G-2]
    sim.pot[1:-1] = solve_banded((1, 1), sim._thomas_ab, f)

    # Electric field — vectorized central differences for interior nodes
    sim.efield[1:-1] = (sim.pot[:-2] - sim.pot[2:]) * cs.S

    # Boundary electric field (half-cell correction)
    sim.efield[0]  = (sim.pot[0] - sim.pot[1]) * cs.INV_DX \
                     - rho[0] * cs.DX / (2.0 * cs.EPSILON0)
    sim.efield[-1] = (sim.pot[-2] - sim.pot[-1]) * cs.INV_DX \
                     + rho[-1] * cs.DX / (2.0 * cs.EPSILON0)
