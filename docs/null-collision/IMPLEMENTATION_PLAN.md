# Null-Collision — Agent Implementation Plan

> **Target files**: C++ (`C/eduPIC.cc`), Python native (`python/native_version/`), Go (`Go/main.go`)  
> **Reference**: `eduPIC/C/eduPIC.cc` — original code (do NOT modify this file)  
> **Prerequisite**: Read `null-collision/ENGINEERING_GUIDE.md` for theory

---

## Overview

Replace the per-particle `exp()` call in Steps 7 & 8 (MCC) with the null-collision method.

### What changes:
1. Precompute `nu_star_e`, `P_star_e`, `nu_star_i`, `P_star_i` once (before the main loop)
2. In each time step: sample `N_coll_star` candidates from the particle array
3. For each candidate: test `real_nu / nu_star < random` (no `exp()` needed)
4. If test passes → call existing `collision_electron` / `collision_ion` unchanged

### What does NOT change:
- `collision_electron()` / `collision_ion()` functions — completely unchanged
- Poisson solver, density deposition, particle push, boundary conditions — unchanged
- Physical results remain statistically equivalent (not numerically identical)

---

## Algorithm Specification

### Precomputation (once, before the time loop)

```
nu_star_e = max over i in [0, CS_RANGES):
    energy = i * DE_CS
    v      = sqrt(2.0 * energy * EV_TO_J / E_MASS)
    yield  sigma_tot_e[i] * v

P_star_e = 1.0 - exp(-nu_star_e * DT_E)

nu_star_i = max over i in [0, CS_RANGES):
    energy = i * DE_CS
    g      = sqrt(2.0 * energy * EV_TO_J / MU_ARAR)
    yield  sigma_tot_i[i] * g

P_star_i = 1.0 - exp(-nu_star_i * DT_I)
```

Note: `sigma_tot_e` and `sigma_tot_i` already contain the `GAS_DENSITY` factor.

### Per-Step Electron Collisions (replace current step7)

```
N_coll_star = sample_binomial(N_e, P_star_e)
candidates  = random_sample_without_replacement(range(N_e), N_coll_star)

for k in candidates:
    v_sqr    = vx_e[k]^2 + vy_e[k]^2 + vz_e[k]^2
    velocity = sqrt(v_sqr)
    energy   = 0.5 * E_MASS * v_sqr / EV_TO_J
    e_idx    = clamp(int(energy / DE_CS + 0.5), 0, CS_RANGES-1)
    real_nu  = sigma_tot_e[e_idx] * velocity
    p_accept = real_nu / nu_star_e          // NO exp() here
    if rng.random() < p_accept:
        collision_electron(k, e_idx)
        N_e_coll++
```

### Per-Step Ion Collisions (replace current step8, guarded by t%N_SUB==0)

```
N_coll_star = sample_binomial(N_i, P_star_i)
candidates  = random_sample_without_replacement(range(N_i), N_coll_star)

for k in candidates:
    vx_a = rng.gauss(0, NORMAL_DISTRIBUTION)
    vy_a = rng.gauss(0, NORMAL_DISTRIBUTION)
    vz_a = rng.gauss(0, NORMAL_DISTRIBUTION)
    gx = vx_i[k] - vx_a
    gy = vy_i[k] - vy_a
    gz = vz_i[k] - vz_a
    g_sqr    = gx^2 + gy^2 + gz^2
    g        = sqrt(g_sqr)
    energy   = 0.5 * MU_ARAR * g_sqr / EV_TO_J
    e_idx    = clamp(int(energy / DE_CS + 0.5), 0, CS_RANGES-1)
    real_nu  = sigma_tot_i[e_idx] * g
    p_accept = real_nu / nu_star_i          // NO exp() here
    if rng.random() < p_accept:
        collision_ion(k, vx_a, vy_a, vz_a, e_idx)
        N_i_coll++
```

### Helper: `sample_binomial(n, p)` 

Draw the count of colliding particles. Use:
- **C++**: `std::binomial_distribution<int>(n, p)(MTgen)`
- **Python**: `sim.rng.binomial(n, p)` (using `np.random.default_rng`) or `int(rng.binomialvariate(n, p))`  
  For native version: `sum(1 for _ in range(n) if rng.random() < p)` is equivalent but slow — instead use `math`: `random.binomialvariate(n, p)` (Python 3.12+) or simply `np.random.binomial(n, p)`.
- **Go**: Loop `for i := 0; i < n; i++ { if rng.Float64() < p { count++ } }` — correct but O(N). Better: use `rand.Int63n` pattern or a proper binomial sampler.

### Helper: `random_sample_without_replacement(range(N), count)`

Draw `count` unique indices from `[0, N)`:
- **C++**: `std::sample(indices.begin(), indices.end(), selected.begin(), count, MTgen)` (C++17)
- **Python native**: `random.sample(range(N_e), N_coll_star)`
- **Python numpy**: `np.random.default_rng().choice(N_e, size=N_coll_star, replace=False)`
- **Go**: Partial Fisher-Yates shuffle on a pre-built index slice

---

## C++ Implementation (`C/eduPIC.cc`)

### Step 1: Add precomputation function

Add this function after `max_ion_coll_freq()` (around line 276):

```cpp
//---------------------------------------------------------------------//
// precompute null-collision parameters                                 //
//---------------------------------------------------------------------//

void compute_null_collision_params(double &nu_star_e, double &P_star_e,
                                   double &nu_star_i, double &P_star_i) {
    double e, v, g, nu;
    
    nu_star_e = 0.0;
    for (int i = 0; i < CS_RANGES; i++) {
        e  = (i == 0) ? DE_CS : i * DE_CS;
        v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
        nu = sigma_tot_e[i] * v;
        if (nu > nu_star_e) nu_star_e = nu;
    }
    P_star_e = 1.0 - exp(-nu_star_e * DT_E);
    
    nu_star_i = 0.0;
    for (int i = 0; i < CS_RANGES; i++) {
        e  = (i == 0) ? DE_CS : i * DE_CS;
        g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
        nu = sigma_tot_i[i] * g;
        if (nu > nu_star_i) nu_star_i = nu;
    }
    P_star_i = 1.0 - exp(-nu_star_i * DT_I);
    
    printf(">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n", nu_star_e, P_star_e);
    printf(">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n", nu_star_i, P_star_i);
}
```

### Step 2: Add global variables for nu_star, P_star

Add near the top of the file (after existing global declarations, around line 155):

```cpp
// null-collision parameters (precomputed once)
double nu_star_e = 0.0;
double P_star_e  = 0.0;
double nu_star_i = 0.0;
double P_star_i  = 0.0;
```

### Step 3: Add index shuffle helper

Add after `compute_null_collision_params`:

```cpp
//---------------------------------------------------------------------//
// partial Fisher-Yates: fill 'out' with 'count' distinct indices from //
// [0, n) using the global MTgen                                        //
//---------------------------------------------------------------------//

void random_sample(int n, int count, std::vector<int> &out) {
    // Build index array only up to 'count' (partial shuffle)
    static std::vector<int> pool;
    pool.resize(n);
    std::iota(pool.begin(), pool.end(), 0);
    for (int i = 0; i < count; i++) {
        int j = i + (int)(R01(MTgen) * (n - i));
        std::swap(pool[i], pool[j]);
    }
    out.assign(pool.begin(), pool.begin() + count);
}
```

Add `#include <vector>` and `#include <numeric>` at the top with other includes.

### Step 4: Replace the electron collision loop in `do_one_cycle()`

Find the current electron collision loop (around lines 671–682):
```cpp
// OLD — replace this:
for (k=0; k<N_e; k++){
    v_sqr = vx_e[k]*vx_e[k] + vy_e[k]*vy_e[k] + vz_e[k]*vz_e[k];
    velocity = sqrt(v_sqr);
    energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
    energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
    nu = sigma_tot_e[energy_index] * velocity;
    p_coll = 1 - exp(- nu * DT_E);
    if (R01(MTgen) < p_coll) {
        collision_electron(x_e[k], &vx_e[k], &vy_e[k], &vz_e[k], energy_index);
        N_e_coll++;
    }
}
```

Replace with:
```cpp
// NULL-COLLISION for electrons
{
    std::binomial_distribution<int> binom_e(N_e, P_star_e);
    int N_coll_star_e = binom_e(MTgen);
    std::vector<int> candidates_e;
    random_sample(N_e, N_coll_star_e, candidates_e);
    
    for (int ki : candidates_e) {
        v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
        velocity = sqrt(v_sqr);
        energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
        energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
        double real_nu  = sigma_tot_e[energy_index] * velocity;
        double p_accept = real_nu / nu_star_e;
        if (R01(MTgen) < p_accept) {
            collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index);
            N_e_coll++;
        }
    }
}
```

### Step 5: Replace the ion collision loop in `do_one_cycle()`

Find the current ion collision block (around lines 684–703):
```cpp
// OLD — replace the inner loop only (keep the t%N_SUB guard):
if ((t % N_SUB) == 0) {
    for (k=0; k<N_i; k++){
        vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
        gx = vx_i[k]-vx_a; gy = vy_i[k]-vy_a; gz = vz_i[k]-vz_a;
        g_sqr = gx*gx + gy*gy + gz*gz;
        g = sqrt(g_sqr);
        energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
        energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
        nu = sigma_tot_i[energy_index] * g;
        p_coll = 1 - exp(- nu * DT_I);
        if (R01(MTgen) < p_coll) {
            collision_ion(&vx_i[k],&vy_i[k],&vz_i[k],&vx_a,&vy_a,&vz_a, energy_index);
            N_i_coll++;
        }
    }
}
```

Replace with:
```cpp
if ((t % N_SUB) == 0) {
    // NULL-COLLISION for ions
    std::binomial_distribution<int> binom_i(N_i, P_star_i);
    int N_coll_star_i = binom_i(MTgen);
    std::vector<int> candidates_i;
    random_sample(N_i, N_coll_star_i, candidates_i);
    
    for (int ki : candidates_i) {
        vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
        gx = vx_i[ki]-vx_a; gy = vy_i[ki]-vy_a; gz = vz_i[ki]-vz_a;
        g_sqr = gx*gx + gy*gy + gz*gz;
        g = sqrt(g_sqr);
        energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
        energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
        double real_nu  = sigma_tot_i[energy_index] * g;
        double p_accept = real_nu / nu_star_i;
        if (R01(MTgen) < p_accept) {
            collision_ion(&vx_i[ki],&vy_i[ki],&vz_i[ki],&vx_a,&vy_a,&vz_a, energy_index);
            N_i_coll++;
        }
    }
}
```

### Step 6: Call precomputation in `main()`

In `main()`, after `calc_total_cross_sections()` (around line 1069), add:
```cpp
compute_null_collision_params(nu_star_e, P_star_e, nu_star_i, P_star_i);
```

---

## Python Native Implementation (`python/native_version/simulation.py`)

### Step 1: Add precomputation to `constants.py` or expose via state

Add a new function in `collisions.py` (after existing `max_electron_coll_freq`):

```python
def compute_null_collision_params(sim: SimulationState):
    """
    Precompute nu_star and P_star for null-collision method.
    Call once after cross sections are loaded.
    """
    import constants as cs
    import math
    
    nu_star_e = 0.0
    for i in range(cs.CS_RANGES):
        e  = i * cs.DE_CS if i > 0 else cs.DE_CS
        v  = math.sqrt(2.0 * e * cs.EV_TO_J / cs.E_MASS)
        nu = sim.sigma_tot_e[i] * v
        if nu > nu_star_e:
            nu_star_e = nu
    P_star_e = 1.0 - math.exp(-nu_star_e * cs.DT_E)
    
    nu_star_i = 0.0
    for i in range(cs.CS_RANGES):
        e  = i * cs.DE_CS if i > 0 else cs.DE_CS
        g  = math.sqrt(2.0 * e * cs.EV_TO_J / cs.MU_ARAR)
        nu = sim.sigma_tot_i[i] * g
        if nu > nu_star_i:
            nu_star_i = nu
    P_star_i = 1.0 - math.exp(-nu_star_i * cs.DT_I)
    
    sim.nu_star_e = nu_star_e
    sim.P_star_e  = P_star_e
    sim.nu_star_i = nu_star_i
    sim.P_star_i  = P_star_i
    print(f">> null-collision: nu*_e = {nu_star_e:.4e}, P*_e = {P_star_e:.4e}")
    print(f">> null-collision: nu*_i = {nu_star_i:.4e}, P*_i = {P_star_i:.4e}")
```

### Step 2: Add fields to `state.py`

In `SimulationState.__init__`, add:
```python
# null-collision precomputed parameters
self.nu_star_e: float = 0.0
self.P_star_e:  float = 0.0
self.nu_star_i: float = 0.0
self.P_star_i:  float = 0.0
```

### Step 3: Replace `step7_collisions_electrons` in `simulation.py`

```python
def step7_collisions_electrons(sim: SimulationState):
    """Electron collisions using null-collision method."""
    # Sample number of candidates from binomial distribution
    # Python 3.12+: N_coll_star = sim.rng.binomialvariate(sim.N_e, sim.P_star_e)
    # Compatible: use round + Bernoulli for fractional part
    import random as _rng_module
    expected = sim.N_e * sim.P_star_e
    N_coll_star = int(expected) + (1 if sim.rng.random() < (expected % 1) else 0)
    N_coll_star = min(N_coll_star, sim.N_e)
    
    if N_coll_star == 0:
        return
    
    # Select N_coll_star unique indices from [0, N_e)
    candidates = sim.rng.sample(range(sim.N_e), N_coll_star)
    
    for k in candidates:
        v_sqr    = sim.vx_e[k]**2 + sim.vy_e[k]**2 + sim.vz_e[k]**2
        velocity = math.sqrt(v_sqr)
        energy   = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J
        e_idx    = min(int(energy / cs.DE_CS + 0.5), cs.CS_RANGES - 1)
        real_nu  = sim.sigma_tot_e[e_idx] * velocity
        p_accept = real_nu / sim.nu_star_e
        if sim.rng.random() < p_accept:
            collisions.collision_electron(sim, k, e_idx)
            sim.N_e_coll += 1
```

### Step 4: Replace `step8_collisions_ions` in `simulation.py`

```python
def step8_collisions_ions(sim: SimulationState, t: int):
    """Ion collisions using null-collision method."""
    if (t % cs.N_SUB) != 0:
        return
    
    expected = sim.N_i * sim.P_star_i
    N_coll_star = int(expected) + (1 if sim.rng.random() < (expected % 1) else 0)
    N_coll_star = min(N_coll_star, sim.N_i)
    
    if N_coll_star == 0:
        return
    
    candidates = sim.rng.sample(range(sim.N_i), N_coll_star)
    
    for k in candidates:
        vx_a = sim.rng.gauss(0.0, cs.NORMAL_DISTRIBUTION)
        vy_a = sim.rng.gauss(0.0, cs.NORMAL_DISTRIBUTION)
        vz_a = sim.rng.gauss(0.0, cs.NORMAL_DISTRIBUTION)
        gx = sim.vx_i[k] - vx_a
        gy = sim.vy_i[k] - vy_a
        gz = sim.vz_i[k] - vz_a
        g_sqr    = gx*gx + gy*gy + gz*gz
        g        = math.sqrt(g_sqr)
        energy   = 0.5 * cs.MU_ARAR * g_sqr / cs.EV_TO_J
        e_idx    = min(int(energy / cs.DE_CS + 0.5), cs.CS_RANGES - 1)
        real_nu  = sim.sigma_tot_i[e_idx] * g
        p_accept = real_nu / sim.nu_star_i
        if sim.rng.random() < p_accept:
            collisions.collision_ion(sim, k, vx_a, vy_a, vz_a, e_idx)
            sim.N_i_coll += 1
```

### Step 5: Call precomputation in `main.py`

After cross sections are loaded (after `set_electron_cross_sections_ar()` and related calls), add:
```python
from collisions import compute_null_collision_params
compute_null_collision_params(sim)
```

---

## Go Implementation (`Go/main.go`)

### Step 1: Add global null-collision variables

Near other global `var` declarations, add:
```go
var (
    nuStarE float64
    pStarE  float64
    nuStarI float64
    pStarI  float64
)
```

### Step 2: Add precomputation function

```go
// computeNullCollisionParams precomputes nu* and P* for null-collision method.
// Call once after cross-sections are loaded.
func computeNullCollisionParams() {
    nuStarE = 0.0
    for i := 0; i < CS_RANGES; i++ {
        e := float64(i) * DE_CS
        if e == 0 {
            e = DE_CS
        }
        v  := math.Sqrt(2.0 * e * EV_TO_J / E_MASS)
        nu := sigmaTotE[i] * v
        if nu > nuStarE {
            nuStarE = nu
        }
    }
    pStarE = 1.0 - math.Exp(-nuStarE*DT_E)

    nuStarI = 0.0
    for i := 0; i < CS_RANGES; i++ {
        e := float64(i) * DE_CS
        if e == 0 {
            e = DE_CS
        }
        g  := math.Sqrt(2.0 * e * EV_TO_J / MU_ARAR)
        nu := sigmaTotI[i] * g
        if nu > nuStarI {
            nuStarI = nu
        }
    }
    pStarI = 1.0 - math.Exp(-nuStarI*DT_I)

    fmt.Printf(">> null-collision: nu*_e = %e, P*_e = %e\n", nuStarE, pStarE)
    fmt.Printf(">> null-collision: nu*_i = %e, P*_i = %e\n", nuStarI, pStarI)
}
```

### Step 3: Add helper — partial Fisher-Yates sample

```go
// randomSample returns count unique indices drawn from [0, n) without replacement.
// Uses partial Fisher-Yates shuffle for efficiency.
func randomSample(n, count int) []int {
    pool := make([]int, n)
    for i := range pool {
        pool[i] = i
    }
    for i := 0; i < count; i++ {
        j := i + rng.Intn(n-i)
        pool[i], pool[j] = pool[j], pool[i]
    }
    return pool[:count]
}
```

### Step 4: Add binomial sampler helper

```go
// sampleBinomial draws a count from Binomial(n, p) using sequential Bernoulli trials.
// Efficient for small p (as guaranteed by stability condition P* < 0.05).
func sampleBinomial(n int, p float64) int {
    count := 0
    for i := 0; i < n; i++ {
        if rng.Float64() < p {
            count++
        }
    }
    return count
}
```

> **Performance note**: For large N (>50k), this O(N) loop may dominate. Replace with a proper binomial sampler (inverse CDF or Devroye's algorithm) if profiling shows it as a bottleneck.

### Step 5: Replace electron collision step in `step7CollisionsElectrons`

```go
func step7CollisionsElectrons() {
    nCollStar := sampleBinomial(Ne, pStarE)
    if nCollStar == 0 {
        return
    }
    candidates := randomSample(Ne, nCollStar)
    
    for _, k := range candidates {
        vSqr     := vxE[k]*vxE[k] + vyE[k]*vyE[k] + vzE[k]*vzE[k]
        velocity := math.Sqrt(vSqr)
        energy   := 0.5 * E_MASS * vSqr / EV_TO_J
        eIdx     := min(int(energy/DE_CS+0.5), CS_RANGES-1)
        realNu   := sigmaTotE[eIdx] * velocity
        pAccept  := realNu / nuStarE
        if rng.Float64() < pAccept {
            collisionElectron(k, eIdx)
            NeColls++
        }
    }
}
```

### Step 6: Replace ion collision step in `step8CollisionsIons`

```go
func step8CollisionsIons(t int) {
    if t%N_SUB != 0 {
        return
    }
    nCollStar := sampleBinomial(Ni, pStarI)
    if nCollStar == 0 {
        return
    }
    candidates := randomSample(Ni, nCollStar)
    
    for _, k := range candidates {
        vxA := rng.NormFloat64() * NORMAL_DISTRIBUTION
        vyA := rng.NormFloat64() * NORMAL_DISTRIBUTION
        vzA := rng.NormFloat64() * NORMAL_DISTRIBUTION
        gx := vxI[k] - vxA
        gy := vyI[k] - vyA
        gz := vzI[k] - vzA
        gSqr     := gx*gx + gy*gy + gz*gz
        g        := math.Sqrt(gSqr)
        energy   := 0.5 * MU_ARAR * gSqr / EV_TO_J
        eIdx     := min(int(energy/DE_CS+0.5), CS_RANGES-1)
        realNu   := sigmaTotI[eIdx] * g
        pAccept  := realNu / nuStarI
        if rng.Float64() < pAccept {
            collisionIon(k, vxA, vyA, vzA, eIdx)
            NiColls++
        }
    }
}
```

### Step 7: Call precomputation in `main()` (Go)

After `calcTotalCrossSections()` call, add:
```go
computeNullCollisionParams()
```

---

## Critical Implementation Rules

1. **`nu_star` must be a global maximum** — it must be ≥ `real_nu` for all particles at all times. If a particle ever has `real_nu > nu_star`, clamp: `p_accept = min(real_nu / nu_star, 1.0)`.

2. **Do NOT recompute `nu_star` every cycle** — it is based on fixed cross section tables and gas density. Compute once at startup.

3. **`N_coll_star` must never exceed `N_e`** — clamp: `N_coll_star = min(N_coll_star, N_e)`.

4. **Newly created particles (ionization) are NOT candidates this step** — `N_coll_star` is sampled from `N_e` at the START of the collision loop. New particles added by `collision_electron` during the loop are skipped (they will be processed in the next time step). This is correct behavior.

5. **Collision handler functions are unchanged** — `collision_electron(k, e_idx)` and `collision_ion(k, vx_a, vy_a, vz_a, e_idx)` accept the same arguments as before. The particle index `k` here is an index into the active particle arrays `[0, N_e)`.

6. **Physical validation required** — run both standard MCC and null-collision for at least 500 RF cycles and compare: EEPF shape, ion density profile, mean electron energy. They should agree within statistical noise (~1–5%).

7. **`sample_binomial` correctness** — For Python native version without Python 3.12 `random.binomialvariate`: use `np.random.binomial(n, p)` (import numpy only for this) or implement by drawing a Poisson variate (good approximation for small p).

---

## Verification Steps

After implementation, run the following verification:

1. **Compile/run** 10 initialization cycles with null-collision enabled
2. **Check**: Print `nu_star_e`, `P_star_e`, `nu_star_i`, `P_star_i` — expected ranges:
   - `P_star_e` < 0.05 (required by stability)
   - `P_star_i` < 0.05 (required by stability)
3. **Check**: `N_coll_star` ≈ `N_e * P_star_e` each step — print a few values
4. **Run 500 cycles** with standard MCC and 500 cycles with null-collision (same random seed if possible, though results will differ due to algorithm change)
5. **Compare EEPF** from `eepf.dat` — shape should match, peak position within 5%
6. **Compare density** from `density.dat` — profiles should match within statistical noise
7. **Compare N_e_coll / N_i_coll** — collision rates should match within ~1%

---

## Summary of Changes by File

| File | Changed | What |
|:-----|:--------|:-----|
| `C/eduPIC.cc` | Yes | Add 3 functions, replace 2 collision loops, add 4 globals, add 2 includes |
| `python/native_version/collisions.py` | Yes | Add `compute_null_collision_params()` |
| `python/native_version/state.py` | Yes | Add 4 float fields to `SimulationState` |
| `python/native_version/simulation.py` | Yes | Replace `step7_*` and `step8_*` |
| `python/native_version/main.py` | Yes | Call `compute_null_collision_params(sim)` |
| `Go/main.go` | Yes | Add 3 functions, 4 globals, replace 2 step functions, call precompute in main |
| `eduPIC/C/eduPIC.cc` | **NO** | Original reference — do not touch |
| `python/numpy_version/*` | No | Separate implementation — handle separately |
