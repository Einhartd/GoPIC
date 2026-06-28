# eduPIC NumPy — Agent Implementation Specification

> **Audience**: Coding agent performing the implementation  
> **Reference**: native_version source in `python/native_version/`  
> **Reference C++**: `C/eduPIC.cc`

---

## Prerequisites

- Read `python/native_version/simulation.py`, `state.py`, `constants.py`, `poisson.py`, `collisions.py` before starting.
- All output files go into `python/numpy_version/`.
- The `numpy_version` must produce physically identical results to `native_version` for the same RNG seed.
- Required dependencies: `numpy`, `scipy`.

---

## File Structure to Create

```
python/numpy_version/
├── constants.py
├── state.py
├── cross_sections.py
├── poisson.py
├── simulation.py
├── collisions.py
├── io_manager.py
└── main.py
```

---

## File 1: `constants.py`

Copy `python/native_version/constants.py` verbatim. Add at the top:

```python
import numpy as np
```

Remove the `type` alias lines at the bottom (Python 3.12 syntax incompatible with older envs if needed). The numerical constants and derived constants remain **identical**.

---

## File 2: `state.py`

Create `SimulationState` class. All arrays must be `np.ndarray`. The constructor must also build the tridiagonal matrix for the Poisson solver once (`_thomas_ab`).

### Particle arrays — use `np.empty`:
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

        # RNG — use numpy default RNG
        self.rng = np.random.default_rng()

        # Pre-built tridiagonal matrix for Poisson solver (constant — built once)
        self._thomas_ab = _build_thomas_matrix()


def _build_thomas_matrix() -> np.ndarray:
    """Build the constant banded matrix for scipy.linalg.solve_banded."""
    import constants as cs
    n = cs.N_G - 2  # interior points only
    ab = np.zeros((3, n), dtype=np.float64)
    ab[0, 1:]  = cs.A   # superdiagonal
    ab[1, :]   = cs.B   # main diagonal
    ab[2, :-1] = cs.C   # subdiagonal
    return ab
```

**Important**: The `rng` field is now `np.random.default_rng()`. All calls that previously used `sim.rng.random()` become `sim.rng.random()` (compatible API). Calls to `sim.rng.gauss(0, sigma)` become `sim.rng.normal(0, sigma)`.

---

## File 3: `cross_sections.py`

Copy `python/native_version/cross_sections.py`. Replace list-based `sigma` accesses with ndarray indexing (they are compatible — `sim.sigma[cs.E_ELA][i]` works fine on a 2D ndarray as `sim.sigma[cs.E_ELA, i]`). Update the accumulated loops to use numpy where straightforward, but correctness is the priority here. The cross section computation runs only once at startup.

---

## File 4: `poisson.py`

```python
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
```

---

## File 5: `collisions.py`

Copy `python/native_version/collisions.py` verbatim. Only changes required:
- Replace `sim.rng.gauss(0.0, sigma)` → `sim.rng.normal(0.0, sigma)` (numpy RNG API).
- Array element access `sim.sigma[cs.E_ELA][e_index]` → `sim.sigma[cs.E_ELA, e_index]` (2D ndarray).
- `sim.x_e[sim.N_e] = xe` etc. remains valid — numpy supports scalar assignment to ndarray index.

No other changes. The collision functions operate on single particles and are called only for the ~5% that collide.

---

## File 6: `simulation.py`

This is the main implementation file. Implement all nine step functions.

### `step1_compute_electron_density(sim)`

```python
def step1_compute_electron_density(sim: SimulationState):
    x  = sim.x_e[:sim.N_e]
    c0 = x * cs.INV_DX
    p  = c0.astype(np.int32)
    p_f = p.astype(np.float64)
    w_left  = p_f + 1.0 - c0    # weight for left node
    w_right = c0 - p_f          # weight for right node

    sim.e_density[:] = 0.0
    np.add.at(sim.e_density, p,     w_left  * cs.FACTOR_W)
    np.add.at(sim.e_density, p + 1, w_right * cs.FACTOR_W)

    sim.e_density[0]         *= 2.0
    sim.e_density[cs.N_G - 1] *= 2.0
    sim.cumul_e_density       += sim.e_density
```

### `step1_compute_ion_density(sim, t)`

```python
def step1_compute_ion_density(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        for p in range(cs.N_G):
            sim.cumul_i_density[p] += sim.i_density[p]
        return

    x  = sim.x_i[:sim.N_i]
    c0 = x * cs.INV_DX
    p  = c0.astype(np.int32)
    p_f = p.astype(np.float64)
    w_left  = p_f + 1.0 - c0
    w_right = c0 - p_f

    sim.i_density[:] = 0.0
    np.add.at(sim.i_density, p,     w_left  * cs.FACTOR_W)
    np.add.at(sim.i_density, p + 1, w_right * cs.FACTOR_W)

    sim.i_density[0]         *= 2.0
    sim.i_density[cs.N_G - 1] *= 2.0
    sim.cumul_i_density       += sim.i_density
```

### `step2_solve_poisson(sim)`

```python
def step2_solve_poisson(sim: SimulationState):
    rho = cs.E_CHARGE * (sim.i_density - sim.e_density)
    poisson.solve_poisson(sim, rho, sim.Time)
```

### `step3_move_electrons(sim, t_index)`

```python
def step3_move_electrons(sim: SimulationState, t_index: int):
    x  = sim.x_e[:sim.N_e]
    vx = sim.vx_e[:sim.N_e]
    vy = sim.vy_e[:sim.N_e]
    vz = sim.vz_e[:sim.N_e]

    c0 = x * cs.INV_DX
    p  = c0.astype(np.int32)
    p_f = p.astype(np.float64)
    c1 = p_f + 1.0 - c0
    c2 = c0 - p_f
    e_x = c1 * sim.efield[p] + c2 * sim.efield[p + 1]

    if sim.measurement_mode:
        mean_v = vx - 0.5 * e_x * cs.FACTOR_E
        np.add.at(sim.counter_e_xt[:, t_index], p,     c1)
        np.add.at(sim.counter_e_xt[:, t_index], p + 1, c2)
        np.add.at(sim.ue_xt[:, t_index], p,     c1 * mean_v)
        np.add.at(sim.ue_xt[:, t_index], p + 1, c2 * mean_v)

        v_sqr  = mean_v**2 + vy**2 + vz**2
        energy = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J
        np.add.at(sim.meanee_xt[:, t_index], p,     c1 * energy)
        np.add.at(sim.meanee_xt[:, t_index], p + 1, c2 * energy)

        e_idx  = np.minimum((energy / cs.DE_CS + 0.5).astype(np.int32), cs.CS_RANGES - 1)
        rate   = sim.sigma[cs.E_ION, e_idx] * np.sqrt(v_sqr) * cs.DT_E * cs.GAS_DENSITY
        np.add.at(sim.ioniz_rate_xt[:, t_index], p,     c1 * rate)
        np.add.at(sim.ioniz_rate_xt[:, t_index], p + 1, c2 * rate)

        # EEPF in center
        center_mask = (x > cs.MIN_X) & (x < cs.MAX_X)
        e_center = energy[center_mask]
        eepf_idx = (e_center / cs.DE_EEPF).astype(np.int32)
        valid = eepf_idx < cs.N_EEPF
        np.add.at(sim.eepf, eepf_idx[valid], 1.0)
        sim.mean_energy_accu_center    += float(np.sum(e_center))
        sim.mean_energy_counter_center += int(np.sum(center_mask))

    # Update velocity and position (in-place on views = modifies sim arrays)
    vx -= e_x * cs.FACTOR_E
    x  += vx  * cs.DT_E
```

### `step4_move_ions(sim, t_index, t)`

```python
def step4_move_ions(sim: SimulationState, t_index: int, t: int):
    if (t % cs.N_SUB) != 0:
        return

    x  = sim.x_i[:sim.N_i]
    vx = sim.vx_i[:sim.N_i]
    vy = sim.vy_i[:sim.N_i]
    vz = sim.vz_i[:sim.N_i]

    c0 = x * cs.INV_DX
    p  = c0.astype(np.int32)
    p_f = p.astype(np.float64)
    c1 = p_f + 1.0 - c0
    c2 = c0 - p_f
    e_x = c1 * sim.efield[p] + c2 * sim.efield[p + 1]

    if sim.measurement_mode:
        mean_v = vx + 0.5 * e_x * cs.FACTOR_I
        np.add.at(sim.counter_i_xt[:, t_index], p,     c1)
        np.add.at(sim.counter_i_xt[:, t_index], p + 1, c2)
        np.add.at(sim.ui_xt[:, t_index], p,     c1 * mean_v)
        np.add.at(sim.ui_xt[:, t_index], p + 1, c2 * mean_v)

        v_sqr  = mean_v**2 + vy**2 + vz**2
        energy = 0.5 * cs.AR_MASS * v_sqr / cs.EV_TO_J
        np.add.at(sim.meanei_xt[:, t_index], p,     c1 * energy)
        np.add.at(sim.meanei_xt[:, t_index], p + 1, c2 * energy)

    vx += e_x * cs.FACTOR_I
    x  += vx  * cs.DT_I
```

### `step5_check_boundaries_electrons(sim)`

```python
def step5_check_boundaries_electrons(sim: SimulationState):
    x = sim.x_e[:sim.N_e]

    mask_pow = x < 0.0
    mask_gnd = x > cs.L
    mask_out = mask_pow | mask_gnd

    sim.N_e_abs_pow += int(np.sum(mask_pow))
    sim.N_e_abs_gnd += int(np.sum(mask_gnd))

    mask_keep = ~mask_out
    n_keep = int(np.sum(mask_keep))

    sim.x_e[:n_keep]  = sim.x_e[:sim.N_e][mask_keep]
    sim.vx_e[:n_keep] = sim.vx_e[:sim.N_e][mask_keep]
    sim.vy_e[:n_keep] = sim.vy_e[:sim.N_e][mask_keep]
    sim.vz_e[:n_keep] = sim.vz_e[:sim.N_e][mask_keep]
    sim.N_e = n_keep
```

### `step6_check_boundaries_ions(sim, t)`

```python
def step6_check_boundaries_ions(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        return

    x  = sim.x_i[:sim.N_i]
    vx = sim.vx_i[:sim.N_i]
    vy = sim.vy_i[:sim.N_i]
    vz = sim.vz_i[:sim.N_i]

    mask_pow = x < 0.0
    mask_gnd = x > cs.L
    mask_out = mask_pow | mask_gnd

    sim.N_i_abs_pow += int(np.sum(mask_pow))
    sim.N_i_abs_gnd += int(np.sum(mask_gnd))

    # Collect IFED for absorbed ions
    v_sqr  = vx**2 + vy**2 + vz**2
    energy = 0.5 * cs.AR_MASS * v_sqr / cs.EV_TO_J

    for mask, ifed in [(mask_pow, sim.ifed_pow), (mask_gnd, sim.ifed_gnd)]:
        e_abs = energy[mask]
        idx   = (e_abs / cs.DE_IFED).astype(np.int64)
        valid = idx < cs.N_IFED
        np.add.at(ifed, idx[valid], 1)

    mask_keep = ~mask_out
    n_keep = int(np.sum(mask_keep))

    sim.x_i[:n_keep]  = sim.x_i[:sim.N_i][mask_keep]
    sim.vx_i[:n_keep] = sim.vx_i[:sim.N_i][mask_keep]
    sim.vy_i[:n_keep] = sim.vy_i[:sim.N_i][mask_keep]
    sim.vz_i[:n_keep] = sim.vz_i[:sim.N_i][mask_keep]
    sim.N_i = n_keep
```

### `step7_collisions_electrons(sim)`

```python
def step7_collisions_electrons(sim: SimulationState):
    vx = sim.vx_e[:sim.N_e]
    vy = sim.vy_e[:sim.N_e]
    vz = sim.vz_e[:sim.N_e]

    v_sqr    = vx**2 + vy**2 + vz**2
    velocity = np.sqrt(v_sqr)
    energy   = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J
    e_idx    = np.minimum((energy / cs.DE_CS + 0.5).astype(np.int32), cs.CS_RANGES - 1)

    nu     = sim.sigma_tot_e[e_idx] * velocity
    p_coll = 1.0 - np.exp(-nu * cs.DT_E)

    rands     = sim.rng.random(sim.N_e)
    colliding = np.where(rands < p_coll)[0]

    for k in colliding:
        collisions.collision_electron(sim, int(k), int(e_idx[k]))
        sim.N_e_coll += 1
```

### `step8_collisions_ions(sim, t)`

```python
def step8_collisions_ions(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        return

    vx = sim.vx_i[:sim.N_i]
    vy = sim.vy_i[:sim.N_i]
    vz = sim.vz_i[:sim.N_i]

    # Sample gas atom velocities for all ions at once
    vx_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)
    vy_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)
    vz_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, sim.N_i)

    gx    = vx - vx_a
    gy    = vy - vy_a
    gz    = vz - vz_a
    g_sqr = gx**2 + gy**2 + gz**2
    g     = np.sqrt(g_sqr)

    energy = 0.5 * cs.MU_ARAR * g_sqr / cs.EV_TO_J
    e_idx  = np.minimum((energy / cs.DE_CS + 0.5).astype(np.int32), cs.CS_RANGES - 1)

    nu     = sim.sigma_tot_i[e_idx] * g
    p_coll = 1.0 - np.exp(-nu * cs.DT_I)

    rands     = sim.rng.random(sim.N_i)
    colliding = np.where(rands < p_coll)[0]

    for k in colliding:
        collisions.collision_ion(
            sim, int(k),
            float(vx_a[k]), float(vy_a[k]), float(vz_a[k]),
            int(e_idx[k])
        )
        sim.N_i_coll += 1
```

### `step9_collect_xt_data(sim, t_index)`

```python
def step9_collect_xt_data(sim: SimulationState, t_index: int):
    if not sim.measurement_mode:
        return
    sim.pot_xt[:, t_index]    += sim.pot
    sim.efield_xt[:, t_index] += sim.efield
    sim.ne_xt[:, t_index]     += sim.e_density
    sim.ni_xt[:, t_index]     += sim.i_density
```

### `do_one_cycle(sim, datafile_path)`

```python
def do_one_cycle(sim: SimulationState, datafile_path: str = "conv.dat"):
    for t in range(cs.N_T):
        sim.Time += cs.DT_E
        t_index = t // cs.N_BIN

        step1_compute_electron_density(sim)
        step1_compute_ion_density(sim, t)
        step2_solve_poisson(sim)
        step3_move_electrons(sim, t_index)
        step4_move_ions(sim, t_index, t)
        step5_check_boundaries_electrons(sim)
        step6_check_boundaries_ions(sim, t)
        step7_collisions_electrons(sim)
        step8_collisions_ions(sim, t)
        step9_collect_xt_data(sim, t_index)

        if (t % 1000) == 0:
            print(f" c = {sim.cycle:8d}  t = {t:8d}  #e = {sim.N_e:8d}  #i = {sim.N_i:8d}")

    with open(datafile_path, "a") as f:
        f.write(f"{sim.cycle:8d}  {sim.N_e:8d}  {sim.N_i:8d}\n")
```

---

## Files 7 & 8: `io_manager.py` and `main.py`

Copy verbatim from `python/native_version/`. They are compatible with the new `SimulationState` as long as:
- `io_manager.py` accesses particle arrays as `sim.x_e[:sim.N_e]` (already does via `N_e` count).
- Binary I/O using `np.ndarray` requires using `sim.x_e[:sim.N_e].tobytes()` instead of list iteration where needed — **verify each `fread`/`fwrite` equivalent call** in `io_manager.py` and adapt if necessary.

---

## Critical Implementation Rules

1. **Never iterate over particle arrays with `for k in range(N_e)`** — always use vectorized numpy operations.
2. **Always use `np.add.at`** for density deposition and XT scatter operations — never `density[p] += w` with array `p`, as that silently produces wrong results for duplicate indices.
3. **Active particle slice convention**: all operations on electrons use `sim.x_e[:sim.N_e]`, on ions `sim.x_i[:sim.N_i]`. Never pass the full pre-allocated array to physics computations.
4. **Views modify in place**: `x = sim.x_e[:sim.N_e]` creates a view. Writing `x += ...` modifies `sim.x_e` in place. This is the intended behavior for Steps 3 & 4.
5. **`sim.rng.gauss(0, s)` → `sim.rng.normal(0, s)`**: NumPy RNG uses `.normal()` not `.gauss()`.
6. **`sim.sigma[cs.E_ELA][i]` → `sim.sigma[cs.E_ELA, i]`**: 2D ndarray uses comma indexing.
7. **Thomas matrix `sim._thomas_ab`** is built once in `SimulationState.__init__`. Do not rebuild it inside the loop.
8. The subcycling condition for ions is `if (t % cs.N_SUB) != 0: return` — skip when NOT a subcycling step.
