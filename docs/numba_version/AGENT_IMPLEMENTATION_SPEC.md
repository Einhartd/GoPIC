# eduPIC Numba — Agent Implementation Specification

> **Audience**: Coding agent performing the implementation
> **Reference native**: `python/native_version/` — source of truth for algorithm logic
> **Reference NumPy**: `python/numpy_version/` — source of truth for ndarray structure and I/O
> **Reference C++**: `C/eduPIC.cc` — ground truth for physical correctness
> **Analysis doc**: `docs/numba_version/analiza_numba.md` — rationale and design decisions

---

## Prerequisites

- Read `python/numpy_version/simulation.py`, `state.py`, `poisson.py`, `collisions.py`, `io_manager.py`, `main.py` before starting.
- Read `python/native_version/collisions.py` — the collision functions are the best template for `@njit` adaptation.
- Read `docs/numba_version/analiza_numba.md` for the full design rationale.
- All output files go into `python/numba_version/`.
- The `numba_version` must produce physically equivalent results to `native_version` and `numpy_version` (same plasma parameters, within Monte Carlo statistical variance — NOT bit-identical, different PRNG).
- Required dependencies: `numpy`, `numba`.
- **No `scipy` dependency** — the Poisson solver uses a hand-written Thomas algorithm inside `@njit`.

---

## File Structure to Create

```
python/numba_version/
├── constants.py
├── state.py
├── cross_sections.py
├── poisson.py
├── collisions.py
├── simulation.py
├── io_manager.py
└── main.py
```

---

## File 1: `constants.py`

Copy `python/numpy_version/constants.py` **verbatim**. No changes required — all constants are plain Python scalars already compatible with Numba JIT when passed as arguments.

---

## File 2: `state.py`

Copy `python/numpy_version/state.py` **verbatim** with two changes:

1. Remove `self._thomas_ab = _build_thomas_matrix()` and the `_build_thomas_matrix()` function — **not needed** (Numba's Thomas solver pre-allocates internally).
2. Remove `self.rng = np.random.default_rng()` — **not needed** (Numba uses `np.random.*` inside JIT, seeded separately).

The resulting `SimulationState` is a plain Python class that holds `np.ndarray` fields. It is **never passed into `@njit` functions** — individual arrays are extracted and passed as arguments.

```python
import numpy as np
import constants as cs


class SimulationState:
    def __init__(self):
        # Cross sections
        self.sigma       = np.zeros((cs.N_CS, cs.CS_RANGES), dtype=np.float64)
        self.sigma_tot_e = np.zeros(cs.CS_RANGES, dtype=np.float64)
        self.sigma_tot_i = np.zeros(cs.CS_RANGES, dtype=np.float64)

        # Particle counts
        self.N_e = 0
        self.N_i = 0

        # Particle arrays (electron)
        self.x_e  = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vx_e = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vy_e = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vz_e = np.empty(cs.MAX_N_P, dtype=np.float64)

        # Particle arrays (ion)
        self.x_i  = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vx_i = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vy_i = np.empty(cs.MAX_N_P, dtype=np.float64)
        self.vz_i = np.empty(cs.MAX_N_P, dtype=np.float64)

        # Grid quantities
        self.efield          = np.zeros(cs.N_G, dtype=np.float64)
        self.pot             = np.zeros(cs.N_G, dtype=np.float64)
        self.e_density       = np.zeros(cs.N_G, dtype=np.float64)
        self.i_density       = np.zeros(cs.N_G, dtype=np.float64)
        self.cumul_e_density = np.zeros(cs.N_G, dtype=np.float64)
        self.cumul_i_density = np.zeros(cs.N_G, dtype=np.float64)

        # Absorption counters
        self.N_e_abs_pow = 0
        self.N_e_abs_gnd = 0
        self.N_i_abs_pow = 0
        self.N_i_abs_gnd = 0

        # EEPF & IFED
        self.eepf     = np.zeros(cs.N_EEPF, dtype=np.float64)
        self.ifed_pow = np.zeros(cs.N_IFED, dtype=np.int64)
        self.ifed_gnd = np.zeros(cs.N_IFED, dtype=np.int64)
        self.mean_i_energy_pow = 0.0
        self.mean_i_energy_gnd = 0.0

        # XT distributions — shape (N_G, N_XT)
        self.pot_xt        = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.efield_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ne_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ni_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ue_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ui_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.je_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ji_xt         = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.powere_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.poweri_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.meanee_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.meanei_xt     = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.counter_e_xt  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.counter_i_xt  = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)
        self.ioniz_rate_xt = np.zeros((cs.N_G, cs.N_XT), dtype=np.float64)

        # Global counters & time
        self.mean_energy_accu_center    = 0.0
        self.mean_energy_counter_center = 0
        self.N_e_coll = 0
        self.N_i_coll = 0
        self.Time         = 0.0
        self.cycle        = 0
        self.no_of_cycles = 0
        self.cycles_done  = 0
        self.measurement_mode = False
```

---

## File 3: `cross_sections.py`

Copy `python/numpy_version/cross_sections.py` **verbatim**. Cross sections are computed once at startup in pure Python/NumPy — no JIT needed.

---

## File 4: `poisson.py`

Implement the Poisson solver as `@njit`. **Do NOT use scipy** — implement the Thomas algorithm directly.

```python
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
```

---

## File 5: `collisions.py`

Adapt `python/native_version/collisions.py`. The scalar collision logic translates perfectly to `@njit`.

**Required changes vs. native_version:**

| Item | native_version | numba_version |
|:---|:---|:---|
| Decorator | none | `@numba.njit(cache=True)` |
| RNG uniform | `sim.rng.random()` | `np.random.uniform(0.0, 1.0)` |
| RNG normal | `sim.rng.gauss(0.0, s)` | `np.random.normal(0.0, s)` |
| Sigma index | `sim.sigma[cs.E_ELA][i]` | `sigma[E_ELA, i]` |
| `sim` object | passed as `sim` | individual arrays as arguments |
| New particle append | `sim.N_e += 1` | return updated `N_e`, `N_i` |
| `import math` | at module level | use `math.` inside `@njit` — supported |

```python
import numpy as np
import numba
import math


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

        # New electron
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
```

---

## File 6: `simulation.py`

This is the core file. All step functions are `@njit`. State is passed as explicit array arguments extracted from `sim` in the Python wrapper `do_one_cycle`.

### `step1_compute_electron_density`

```python
@numba.njit(parallel=False, cache=True)
def step1_compute_electron_density(x_e, N_e, e_density, cumul_e_density,
                                    INV_DX, FACTOR_W, N_G):
    for i in numba.prange(N_G):
        e_density[i] = 0.0

    for k in numba.prange(N_e):
        c0 = x_e[k] * INV_DX
        p  = int(c0)
        if p >= N_G - 1:
            p = N_G - 2
        w_left  = (p + 1.0) - c0
        w_right = c0 - p
        # sequential accumulation (parallel=False is required to avoid data races on deposit)
        e_density[p]     += w_left  * FACTOR_W
        e_density[p + 1] += w_right * FACTOR_W

    e_density[0]       *= 2.0
    e_density[N_G - 1] *= 2.0

    for i in numba.prange(N_G):
        cumul_e_density[i] += e_density[i]
```

### `step1_compute_ion_density`

```python
@numba.njit(parallel=False, cache=True)
def step1_compute_ion_density(x_i, N_i, i_density, cumul_i_density,
                               INV_DX, FACTOR_W, N_G, t, N_SUB):
    if t % N_SUB != 0:
        # Not a subcycling step — only accumulate last valid i_density
        for i in numba.prange(N_G):
            cumul_i_density[i] += i_density[i]
        return

    for i in numba.prange(N_G):
        i_density[i] = 0.0

    for k in numba.prange(N_i):
        c0 = x_i[k] * INV_DX
        p  = int(c0)
        if p >= N_G - 1:
            p = N_G - 2
        w_left  = (p + 1.0) - c0
        w_right = c0 - p
        i_density[p]     += w_left  * FACTOR_W
        i_density[p + 1] += w_right * FACTOR_W

    i_density[0]       *= 2.0
    i_density[N_G - 1] *= 2.0

    for i in numba.prange(N_G):
        cumul_i_density[i] += i_density[i]
```

### `step3_move_electrons`

```python
@numba.njit(parallel=False, cache=True)
def step3_move_electrons(x_e, vx_e, vy_e, vz_e, N_e, efield,
                          counter_e_xt, ue_xt, meanee_xt, ioniz_rate_xt,
                          eepf, sigma,
                          INV_DX, FACTOR_E, DT_E, N_G, E_MASS, EV_TO_J,
                          DE_CS, DE_EEPF, N_EEPF, CS_RANGES, GAS_DENSITY,
                          MIN_X, MAX_X, E_ION,
                          t_index, measurement_mode):
    for k in numba.prange(N_e):
        c0  = x_e[k] * INV_DX
        p   = int(c0)
        if p >= N_G - 1:
            p = N_G - 2
        c1  = (p + 1.0) - c0
        c2  = c0 - p
        e_x = c1 * efield[p] + c2 * efield[p + 1]

        if measurement_mode:
            mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E
            counter_e_xt[p,     t_index] += c1
            counter_e_xt[p + 1, t_index] += c2
            ue_xt[p,     t_index] += c1 * mean_v
            ue_xt[p + 1, t_index] += c2 * mean_v

            v_sqr  = mean_v**2 + vy_e[k]**2 + vz_e[k]**2
            energy = 0.5 * E_MASS * v_sqr / EV_TO_J
            meanee_xt[p,     t_index] += c1 * energy
            meanee_xt[p + 1, t_index] += c2 * energy

            e_idx = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
            rate  = sigma[E_ION, e_idx] * math.sqrt(v_sqr) * DT_E * GAS_DENSITY
            ioniz_rate_xt[p,     t_index] += c1 * rate
            ioniz_rate_xt[p + 1, t_index] += c2 * rate

            if MIN_X < x_e[k] < MAX_X:
                eepf_idx = int(energy / DE_EEPF)
                if eepf_idx < N_EEPF:
                    eepf[eepf_idx] += 1.0

        # Leapfrog push
        vx_e[k] -= e_x * FACTOR_E
        x_e[k]  += vx_e[k] * DT_E
```

> **IMPORTANT — Sequential loop safety:** Always run with `parallel=False`. Scatter-writes to grid and XT arrays (e.g., `counter_e_xt[p, t_index] += c1`) are not thread-safe under parallel execution, causing severe data races, drop in electron densities, unphysical fields, and breakdown.

### `step4_move_ions`

```python
@numba.njit(parallel=False, cache=True)
def step4_move_ions(x_i, vx_i, vy_i, vz_i, N_i, efield,
                     counter_i_xt, ui_xt, meanei_xt,
                     INV_DX, FACTOR_I, DT_I, N_G, AR_MASS, EV_TO_J,
                     t_index, measurement_mode,
                     t, N_SUB):
    if t % N_SUB != 0:
        return

    for k in numba.prange(N_i):
        c0  = x_i[k] * INV_DX
        p   = int(c0)
        if p >= N_G - 1:
            p = N_G - 2
        c1  = (p + 1.0) - c0
        c2  = c0 - p
        e_x = c1 * efield[p] + c2 * efield[p + 1]

        if measurement_mode:
            mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I
            counter_i_xt[p,     t_index] += c1
            counter_i_xt[p + 1, t_index] += c2
            ui_xt[p,     t_index] += c1 * mean_v
            ui_xt[p + 1, t_index] += c2 * mean_v

            v_sqr  = mean_v**2 + vy_i[k]**2 + vz_i[k]**2
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
            meanei_xt[p,     t_index] += c1 * energy
            meanei_xt[p + 1, t_index] += c2 * energy

        vx_i[k] += e_x * FACTOR_I
        x_i[k]  += vx_i[k] * DT_I
```

### `step5_check_boundaries_electrons`

```python
@numba.njit(cache=True)
def step5_check_boundaries_electrons(x_e, vx_e, vy_e, vz_e, N_e, L):
    """Sequential swap-with-last — cannot use prange (mutates N_e)."""
    N_e_abs_pow = 0
    N_e_abs_gnd = 0
    k = 0
    while k < N_e:
        if x_e[k] < 0.0:
            N_e_abs_pow += 1
            x_e[k]  = x_e[N_e - 1]
            vx_e[k] = vx_e[N_e - 1]
            vy_e[k] = vy_e[N_e - 1]
            vz_e[k] = vz_e[N_e - 1]
            N_e -= 1
        elif x_e[k] > L:
            N_e_abs_gnd += 1
            x_e[k]  = x_e[N_e - 1]
            vx_e[k] = vx_e[N_e - 1]
            vy_e[k] = vy_e[N_e - 1]
            vz_e[k] = vz_e[N_e - 1]
            N_e -= 1
        else:
            k += 1
    return N_e, N_e_abs_pow, N_e_abs_gnd
```

### `step6_check_boundaries_ions`

```python
@numba.njit(cache=True)
def step6_check_boundaries_ions(x_i, vx_i, vy_i, vz_i, N_i, L,
                                  ifed_pow, ifed_gnd,
                                  AR_MASS, EV_TO_J, DE_IFED, N_IFED,
                                  t, N_SUB):
    if t % N_SUB != 0:
        return N_i, 0, 0

    N_i_abs_pow = 0
    N_i_abs_gnd = 0
    k = 0
    while k < N_i:
        absorbed = False
        if x_i[k] < 0.0:
            N_i_abs_pow += 1
            absorbed = True
            v_sqr  = vx_i[k]**2 + vy_i[k]**2 + vz_i[k]**2
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
            idx    = int(energy / DE_IFED)
            if idx < N_IFED:
                ifed_pow[idx] += 1
        elif x_i[k] > L:
            N_i_abs_gnd += 1
            absorbed = True
            v_sqr  = vx_i[k]**2 + vy_i[k]**2 + vz_i[k]**2
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
            idx    = int(energy / DE_IFED)
            if idx < N_IFED:
                ifed_gnd[idx] += 1

        if absorbed:
            x_i[k]  = x_i[N_i - 1]
            vx_i[k] = vx_i[N_i - 1]
            vy_i[k] = vy_i[N_i - 1]
            vz_i[k] = vz_i[N_i - 1]
            N_i -= 1
        else:
            k += 1
    return N_i, N_i_abs_pow, N_i_abs_gnd
```

### `step7_collisions_electrons`

```python
@numba.njit(cache=True)
def step7_collisions_electrons(x_e, vx_e, vy_e, vz_e, N_e,
                                 x_i, vx_i, vy_i, vz_i, N_i,
                                 sigma, sigma_tot_e,
                                 DT_E, DE_CS, CS_RANGES, E_MASS, EV_TO_J,
                                 NORMAL_DISTRIBUTION,
                                 F1, F2, PI, TWO_PI,
                                 E_EXC_TH, E_ION_TH,
                                 E_ELA, E_EXC, E_ION):
    """
    Sequential loop — ionization events grow N_e and N_i.
    Cannot use prange here.
    """
    N_e_coll = 0
    for k in range(N_e):
        v_sqr    = vx_e[k]**2 + vy_e[k]**2 + vz_e[k]**2
        velocity = math.sqrt(v_sqr)
        energy   = 0.5 * E_MASS * v_sqr / EV_TO_J
        e_idx    = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
        nu       = sigma_tot_e[e_idx] * velocity
        p_coll   = 1.0 - math.exp(-nu * DT_E)

        if np.random.uniform(0.0, 1.0) < p_coll:
            N_e, N_i = collision_electron(
                k, x_e, vx_e, vy_e, vz_e, N_e,
                x_i, vx_i, vy_i, vz_i, N_i,
                sigma, e_idx,
                F1, F2, PI, TWO_PI, E_MASS, AR_MASS,
                E_EXC_TH, E_ION_TH, EV_TO_J,
                NORMAL_DISTRIBUTION, E_ELA, E_EXC, E_ION
            )
            N_e_coll += 1

    return N_e, N_i, N_e_coll
```

> The `AR_MASS` constant must be included in the argument list — add it to the call in `do_one_cycle`.

### `step8_collisions_ions`

```python
@numba.njit(cache=True)
def step8_collisions_ions(vx_i, vy_i, vz_i, N_i,
                            sigma, sigma_tot_i,
                            DT_I, DE_CS, CS_RANGES, AR_MASS, MU_ARAR, EV_TO_J,
                            NORMAL_DISTRIBUTION, PI, TWO_PI,
                            I_ISO, I_BACK,
                            t, N_SUB):
    if t % N_SUB != 0:
        return 0

    N_i_coll = 0
    for k in range(N_i):
        vx_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)
        vy_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)
        vz_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)

        gx    = vx_i[k] - vx_a
        gy    = vy_i[k] - vy_a
        gz    = vz_i[k] - vz_a
        g_sqr = gx*gx + gy*gy + gz*gz
        g     = math.sqrt(g_sqr)

        energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J
        e_idx  = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
        nu     = sigma_tot_i[e_idx] * g
        p_coll = 1.0 - math.exp(-nu * DT_I)

        if np.random.uniform(0.0, 1.0) < p_coll:
            collision_ion(
                k, vx_i, vy_i, vz_i,
                vx_a, vy_a, vz_a,
                sigma, e_idx,
                PI, TWO_PI, I_ISO, I_BACK
            )
            N_i_coll += 1

    return N_i_coll
```

### `step9_collect_xt_data`

```python
@numba.njit(parallel=False, cache=True)
def step9_collect_xt_data(pot, efield, e_density, i_density,
                            pot_xt, efield_xt, ne_xt, ni_xt,
                            N_G, t_index, measurement_mode):
    if not measurement_mode:
        return
    for i in numba.prange(N_G):
        pot_xt[i, t_index]    += pot[i]
        efield_xt[i, t_index] += efield[i]
        ne_xt[i, t_index]     += e_density[i]
        ni_xt[i, t_index]     += i_density[i]
```

### `do_one_cycle` — Python wrapper (not JIT)

```python
def do_one_cycle(sim: SimulationState, datafile_path: str = "conv.dat"):
    """
    Python-level loop. Extracts arrays from sim, calls @njit step functions.
    JIT compilation happens on first call (cycle 0 = natural warmup).
    """
    import math
    import poisson

    for t in range(cs.N_T):
        sim.Time += cs.DT_E
        t_index   = t // cs.N_BIN

        step1_compute_electron_density(
            sim.x_e, sim.N_e, sim.e_density, sim.cumul_e_density,
            cs.INV_DX, cs.FACTOR_W, cs.N_G
        )
        step1_compute_ion_density(
            sim.x_i, sim.N_i, sim.i_density, sim.cumul_i_density,
            cs.INV_DX, cs.FACTOR_W, cs.N_G, t, cs.N_SUB
        )

        # Step 2 — Poisson (Python wrapper calls @njit solver)
        rho = cs.E_CHARGE * (sim.i_density - sim.e_density)
        poisson.solve_poisson(sim, rho, sim.Time)

        step3_move_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, sim.efield,
            sim.counter_e_xt, sim.ue_xt, sim.meanee_xt, sim.ioniz_rate_xt,
            sim.eepf, sim.sigma,
            cs.INV_DX, cs.FACTOR_E, cs.DT_E, cs.N_G, cs.E_MASS, cs.EV_TO_J,
            cs.DE_CS, cs.DE_EEPF, cs.N_EEPF, cs.CS_RANGES, cs.GAS_DENSITY,
            cs.MIN_X, cs.MAX_X, cs.E_ION,
            t_index, sim.measurement_mode
        )
        step4_move_ions(
            sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, sim.efield,
            sim.counter_i_xt, sim.ui_xt, sim.meanei_xt,
            cs.INV_DX, cs.FACTOR_I, cs.DT_I, cs.N_G, cs.AR_MASS, cs.EV_TO_J,
            t_index, sim.measurement_mode, t, cs.N_SUB
        )

        sim.N_e, abs_pow, abs_gnd = step5_check_boundaries_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, cs.L
        )
        sim.N_e_abs_pow += abs_pow
        sim.N_e_abs_gnd += abs_gnd

        sim.N_i, abs_pow, abs_gnd = step6_check_boundaries_ions(
            sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, cs.L,
            sim.ifed_pow, sim.ifed_gnd,
            cs.AR_MASS, cs.EV_TO_J, cs.DE_IFED, cs.N_IFED, t, cs.N_SUB
        )
        sim.N_i_abs_pow += abs_pow
        sim.N_i_abs_gnd += abs_gnd

        sim.N_e, sim.N_i, coll = step7_collisions_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e,
            sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i,
            sim.sigma, sim.sigma_tot_e,
            cs.DT_E, cs.DE_CS, cs.CS_RANGES, cs.E_MASS, cs.EV_TO_J,
            cs.NORMAL_DISTRIBUTION, cs.F1, cs.F2, cs.PI, cs.TWO_PI,
            cs.E_EXC_TH, cs.E_ION_TH, cs.E_ELA, cs.E_EXC, cs.E_ION
        )
        sim.N_e_coll += coll

        coll = step8_collisions_ions(
            sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i,
            sim.sigma, sim.sigma_tot_i,
            cs.DT_I, cs.DE_CS, cs.CS_RANGES, cs.AR_MASS, cs.MU_ARAR, cs.EV_TO_J,
            cs.NORMAL_DISTRIBUTION, cs.PI, cs.TWO_PI, cs.I_ISO, cs.I_BACK,
            t, cs.N_SUB
        )
        sim.N_i_coll += coll

        step9_collect_xt_data(
            sim.pot, sim.efield, sim.e_density, sim.i_density,
            sim.pot_xt, sim.efield_xt, sim.ne_xt, sim.ni_xt,
            cs.N_G, t_index, sim.measurement_mode
        )

        if t % 1000 == 0:
            print(f" c = {sim.cycle:8d}  t = {t:8d}  #e = {sim.N_e:8d}  #i = {sim.N_i:8d}")

    with open(datafile_path, "a") as f:
        f.write(f"{sim.cycle:8d}  {sim.N_e:8d}  {sim.N_i:8d}\n")
```

> **Note on `mean_energy_accu_center` and `mean_energy_counter_center`:** These scalars are accumulated inside `step3_move_electrons` but cannot be returned cleanly from a `prange` loop without a reduction. Two options:
> 1. **Keep EEPF scatter inside `prange`** (atomic, correct) but accumulate `mean_energy_accu_center` via a separate sequential loop or a `numba.typed.List` reduction.
> 2. **Compute them from `eepf` post-step** (simplest, consistent with diagnostics).
> Recommended: compute `mean_energy_accu_center` from `eepf` in `io_manager` at the end of all measurement cycles.

---

## Files 7 & 8: `io_manager.py` and `main.py`

Copy `python/numpy_version/io_manager.py` and `python/numpy_version/main.py` **verbatim**.

Changes needed in `main.py`:
- Remove `sim.rng.random(nseed)` calls in `init()` — replace with `np.random.uniform(0, cs.L, nseed)`:
```python
def init(sim: SimulationState, nseed: int):
    sim.x_e[:nseed]  = np.random.uniform(0.0, cs.L, nseed)
    sim.vx_e[:nseed] = 0.0
    sim.vy_e[:nseed] = 0.0
    sim.vz_e[:nseed] = 0.0
    sim.x_i[:nseed]  = np.random.uniform(0.0, cs.L, nseed)
    sim.vx_i[:nseed] = 0.0
    sim.vy_i[:nseed] = 0.0
    sim.vz_i[:nseed] = 0.0
    sim.N_e = nseed
    sim.N_i = nseed
```
- No separate warmup step needed — **cycle 0 (the initialization cycle) is the natural JIT warmup**. The first call to `do_one_cycle()` triggers compilation of all `@njit` functions with production data. With `cache=True` this only happens once per environment.

---

## Critical Implementation Rules

1. **Never pass `sim` object into `@njit` functions** — extract individual `np.ndarray` fields and pass them as arguments.
2. **Use `@numba.njit(parallel=False, cache=True)`** — do NOT use `parallel=True` as Numba does not guarantee thread-safe atomic updates on scatter-adds (like `density[p] += ...`), leading to data races, corrupt field calculations, and runaway particle growth.
3. **Sequential `range` for collision steps** (step7, step8) — ionization modifies `N_e` and `N_i` inside the loop. Using `prange` here is a race condition.
4. **Sequential `while` loop for boundary checks** (step5, step6) — mutates `N_e`/`N_i` by swap-with-last; cannot be parallelised.
5. **`np.random.uniform()` / `np.random.normal()` inside `@njit`** — Numba provides thread-safe, JIT-compiled RNG. Do NOT use `sim.rng`, `random.random()`, or `np.random.default_rng()` inside JIT.
6. **`cache=True` on every `@njit` function** — mandatory for production use; eliminates 10–60 s recompilation on every run.
7. **Subcycling guard**: `if t % N_SUB != 0: return` in step1_ion, step4, step6, step8.
8. **Boundary density correction ×2**: `density[0] *= 2.0; density[N_G-1] *= 2.0` — NEVER omit.
9. **`cumul_i_density`** must accumulate every time step (not only subcycling steps) — in non-subcycling steps, accumulate the last valid `i_density`.
10. **Electron push sign**: `vx_e[k] -= e_x * FACTOR_E` (negative charge).
11. **Ion push sign**: `vx_i[k] += e_x * FACTOR_I` (positive charge).
