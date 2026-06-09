import numpy as np
from core.state import SimulationState


def solve_poisson(state: SimulationState, tt: float):
    """
    Solves the 1D Poisson equation using the Thomas algorithm.
    Calculates potential and electric field at grid points.
    """
    cfg = state.cfg
    n_g = cfg.sim.N_G
    dx = cfg.DX
    epsilon0 = cfg.const.EPSILON0
    e_charge = cfg.const.E_CHARGE

    # Constants for Thomas algorithm
    A: float = 1.0
    B: float = -2.0
    C: float = 1.0
    S: float = 1.0 / (2.0 * dx)
    ALPHA: float = -dx * dx / epsilon0

    # Boundary Conditions
    # Potential at powered electrode (x=0)
    state.pot[0] = cfg.sim.VOLTAGE * np.cos(cfg.OMEGA * tt)
    # Potential at grounded electrode (x=L)
    state.pot[n_g - 1] = 0.0

    # Charge density rho = e * (n_i - n_e)
    rho = e_charge * (state.i_density - state.e_density)

    # RHS of Poisson: f[i] = ALPHA * rho[i]
    # We only solve for internal points 1 to N_G-2
    n_internal = n_g - 2
    f = ALPHA * rho[1 : n_g - 1]

    # Adjust RHS for boundary conditions
    f[0] -= state.pot[0]
    f[-1] -= state.pot[n_g - 1]

    # Forward elimination
    w = np.zeros(n_internal)
    g = np.zeros(n_internal)

    w[0] = C / B
    g[0] = f[0] / B

    for i in range(1, n_internal):
        denom = B - A * w[i - 1]
        w[i] = C / denom
        g[i] = (f[i] - A * g[i - 1]) / denom

    # Backward substitution
    state.pot[n_g - 2] = g[-1]
    for i in range(n_internal - 2, -1, -1):
        state.pot[i + 1] = g[i] - w[i] * state.pot[i + 2]

    # Compute electric field
    # Internal points: central difference
    state.efield[1 : n_g - 1] = (state.pot[0 : n_g - 2] - state.pot[2:n_g]) * S

    # Powered electrode (x=0)
    state.efield[0] = (state.pot[0] - state.pot[1]) * cfg.INV_DX - rho[0] * dx / (
        2.0 * epsilon0
    )

    # Grounded electrode (x=L)
    state.efield[n_g - 1] = (
        state.pot[n_g - 2] - state.pot[n_g - 1]
    ) * cfg.INV_DX + rho[n_g - 1] * dx / (2.0 * epsilon0)
