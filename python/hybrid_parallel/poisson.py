import numpy as np
import numba
import math
import constants as cs
from state import SimulationState


@numba.njit(cache=True)
def _solve_poisson_jit(pot, efield, rho, V0_cos,
                        A, B, C, ALPHA, S, INV_DX, DX, EPSILON0, N_G):
    """Thomas algorithm (tridiagonal) Poisson solver — compiled by Numba."""
    pot[0]       = V0_cos   # powered electrode BC
    pot[N_G - 1] = 0.0      # grounded electrode BC

    # Allocate temporary arrays (stack-allocated by LLVM for fixed N_G)
    w = np.empty(N_G)
    g = np.empty(N_G)
    f = np.empty(N_G)

    # Right-hand side for interior nodes
    for i in range(1, N_G - 1):
        f[i] = ALPHA * rho[i]
    f[1]       -= pot[0]
    f[N_G - 2] -= pot[N_G - 1]

    # Forward sweep
    w[1] = C / B
    g[1] = f[1] / B
    for i in range(2, N_G - 1):
        denom = B - A * w[i - 1]
        w[i]  = C / denom
        g[i]  = (f[i] - A * g[i - 1]) / denom

    # Back substitution
    pot[N_G - 2] = g[N_G - 2]
    for i in range(N_G - 3, 0, -1):
        pot[i] = g[i] - w[i] * pot[i + 1]

    # Electric field — central differences for interior nodes
    for i in range(1, N_G - 1):
        efield[i] = (pot[i - 1] - pot[i + 1]) * S

    # Boundary electric field (half-cell correction, same as C++ and native versions)
    efield[0]       = (pot[0] - pot[1]) * INV_DX \
                      - rho[0] * DX / (2.0 * EPSILON0)
    efield[N_G - 1] = (pot[N_G - 2] - pot[N_G - 1]) * INV_DX \
                      + rho[N_G - 1] * DX / (2.0 * EPSILON0)


def solve_poisson(sim: SimulationState, rho: np.ndarray, tt: float):
    """Python wrapper — computes BC voltage, then calls JIT solver."""
    V0_cos = cs.VOLTAGE * math.cos(cs.OMEGA * tt)
    _solve_poisson_jit(
        sim.pot, sim.efield, rho, V0_cos,
        cs.A, cs.B, cs.C, cs.ALPHA, cs.S, cs.INV_DX, cs.DX, cs.EPSILON0, cs.N_G
    )
