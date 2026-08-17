# eduPIC C++ Reference — Full Code Structure

Source: `eduPIC/C/eduPIC.cc`  
Version: 1.0, March 2021  
Authors: Z. Donko, A. Derzsi, M. Vass, B. Horvath, S. Wilczek, B. Hartmann, P. Hartmann  
Paper: PSST vol 30, pp. 095017 (2021)

---

## Global State (all global variables in C++)

```cpp
// Particle arrays — pre-allocated to MAX_N_P = 1,000,000
int     N_e, N_i;                     // active particle counts
double  x_e[MAX_N_P], vx_e, vy_e, vz_e;  // electron coords
double  x_i[MAX_N_P], vx_i, vy_i, vz_i;  // ion coords

// Grid arrays — N_G = 400 points
double  efield[N_G], pot[N_G];
double  e_density[N_G], i_density[N_G];
double  cumul_e_density[N_G], cumul_i_density[N_G];

// Cross sections — sigma[N_CS][CS_RANGES], sigma_tot_e[CS_RANGES], sigma_tot_i[CS_RANGES]
// CS_RANGES = 1,000,000, DE_CS = 0.001 eV per bin

// Diagnostics
double eepf[N_EEPF];        // N_EEPF=2000, DE_EEPF=0.05 eV
int    ifed_pow[N_IFED];    // N_IFED=200,  DE_IFED=1.0 eV
int    ifed_gnd[N_IFED];
double xt_distr[N_G][N_XT]; // N_XT = N_T/N_BIN = 4000/20 = 200
// xt arrays: pot_xt, efield_xt, ne_xt, ni_xt, ue_xt, ui_xt,
//            je_xt, ji_xt, powere_xt, poweri_xt, meanee_xt, meanei_xt,
//            counter_e_xt, counter_i_xt, ioniz_rate_xt

// RNG
std::mt19937 MTgen(rd());
std::uniform_real_distribution<> R01(0.0, 1.0);
std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
```

---

## Functions

### `set_electron_cross_sections_ar()`
Fills `sigma[E_ELA]`, `sigma[E_EXC]`, `sigma[E_ION]` using Phelps & Petrovic (1999) formulas.
- E_ELA: modified momentum cross section (elastic)
- E_EXC: excitation (threshold 11.5 eV)
- E_ION: ionization (threshold 15.8 eV)
- Units: all ×1e-20 m²

### `set_ion_cross_sections_ar()`
Fills `sigma[I_ISO]` and `sigma[I_BACK]` using Phelps (1994) formulas.
- e_lab = 2 × e_com (lab frame energy)
- qmom, qiso, qback = formulas from Phelps 1994

### `calc_total_cross_sections()`
```
sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY
sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY
```

### `init(int nseed)`
- Places `nseed` electrons and ions at uniform random positions in [0, L]
- All initial velocities = 0
- Sets N_e = N_i = nseed

### `collision_electron(double xe, double *vxe, double *vye, double *vze, int eindex)`
Cold-gas approximation. Steps:
1. Compute relative velocity g = |v_electron|, COM velocity w = F1 * v_e
2. Find Euler angles theta, phi from gx, gy, gz
3. Determine collision type via random selection weighted by cross-section ratios:
   - Elastic: chi = acos(1 - 2*rnd), isotropic
   - Excitation: energy loss E_EXC_TH=11.5eV, then isotropic
   - Ionization: energy loss E_ION_TH=15.8eV, split remainder between scattered+ejected electrons; add new e-/ion pair at position xe
4. Scatter primary electron using Euler rotation matrix
```
gx_new = g*(ct*cc - st*sc*ce)
gy_new = g*(st*cp*cc + ct*cp*sc*ce - sp*sc*se)
gz_new = g*(st*sp*cc + ct*sp*sc*ce + cp*sc*se)
v_new = w + F2 * g_new
```
Constants: F1 = E_MASS/(E_MASS+AR_MASS), F2 = AR_MASS/(E_MASS+AR_MASS)

### `collision_ion(*vx_1, *vy_1, *vz_1, *vx_2, *vy_2, *vz_2, e_index)`
Ar+/Ar collision. vx_2/vy_2/vz_2 are pre-sampled atom velocities (RMB).
- Relative velocity g, COM w
- Euler angles
- I_ISO → chi = acos(1 - 2*rnd), I_BACK → chi = PI
- Post-collision: v_ion = w + 0.5 * g_new

### `solve_Poisson(xvector rho1, double tt)`
Thomas algorithm for tridiagonal system:
- A=1, B=-2, C=1, ALPHA = -DX*DX/EPSILON0, S = 1/(2*DX)
- pot[0] = VOLTAGE*cos(OMEGA*tt)
- pot[N_G-1] = 0
- Forward sweep: w[i]=C/(B-A*w[i-1]), g[i]=(f[i]-A*g[i-1])/(B-A*w[i-1])
- Back substitution: pot[i] = g[i] - w[i]*pot[i+1]
- efield[i] = (pot[i-1]-pot[i+1]) * S  for interior
- efield[0] = (pot[0]-pot[1])*INV_DX - rho[0]*DX/(2*EPSILON0)
- efield[N_G-1] = (pot[N_G-2]-pot[N_G-1])*INV_DX + rho[N_G-1]*DX/(2*EPSILON0)

### `do_one_cycle()` — Main loop (N_T=4000 iterations)
```
for t in [0, N_T):
    Time += DT_E
    t_index = t / N_BIN

    // STEP 1: densities
    e_density[p] = 0; deposit electrons always
    if (t % N_SUB == 0): deposit ions (NOTE: original uses == 0)
    cumul_i_density += i_density  // always accumulate

    // STEP 2: Poisson
    rho[p] = E_CHARGE * (i_density - e_density)
    solve_Poisson(rho, Time)

    // STEP 3: move electrons (always)
    interpolate E-field → e_x
    if measurement_mode: collect ue_xt, meanee_xt, ioniz_rate_xt, eepf
    vx_e[k] -= e_x * FACTOR_E     // FACTOR_E = DT_E/E_MASS * E_CHARGE
    x_e[k]  += vx_e[k] * DT_E

    // STEP 4: move ions (only if t % N_SUB == 0)
    interpolate E-field → e_x
    if measurement_mode: collect ui_xt, meanei_xt
    vx_i[k] += e_x * FACTOR_I     // FACTOR_I = DT_I/AR_MASS * E_CHARGE
    x_i[k]  += vx_i[k] * DT_I

    // STEP 5: boundaries (electrons always, ions if t % N_SUB == 0)
    // Fast in-place delete: swap with last element, decrement count

    // STEP 6: collisions
    // electrons (always): p_coll = 1 - exp(-sigma_tot_e[e_idx]*v*DT_E)
    // ions (only t%N_SUB==0): sample vx_a/vy_a/vz_a from RMB
    //                          g = v_ion - v_atom
    //                          p_coll = 1 - exp(-sigma_tot_i[e_idx]*g*DT_I)

    // STEP 7 (measurement_mode): collect XT grid data
    pot_xt[p][t_index] += pot[p], etc.
```

### Output Functions
- `save_particle_data()` / `load_particle_data()`: binary `picdata.bin`
- `save_density()`: `density.dat` (avg cumul density per N_T steps)
- `save_eepf()`: `eepf.dat` (normalized by DE_EEPF and sqrt(energy))
- `save_ifed()`: `ifed.dat` (normalized IFEDs at both electrodes)
- `norm_all_xt()`: normalizes XT distributions, computes je/ji/powere/poweri
- `save_all_xt()`: writes all XT .dat files
- `check_and_save_info()`: stability report in `info.txt`

### `main(int argc, char* argv[])`
- argv[1] = number of cycles (0 = init run)
- argv[2] = "m" enables measurement_mode
- If arg1==0: init() + 1 cycle (no measurement)
- Else: load_particle_data() + run N cycles
- Always ends with: save_particle_data()
- If measurement_mode: check_and_save_info()

---

## Subcycling Logic (IMPORTANT)

**Original C++ code**: ion updates trigger when `(t % N_SUB) == 0`  
**Corrected logic in Python/Go reimplementations**: `(t % N_SUB) != 0` in `return` guards  
(Both are equivalent — the condition in C++ is the trigger, while Python/Go use early-return guards)

The `cumul_i_density` accumulation happens **every step** in C++ (line 542), using the last computed `i_density` (which is updated only on subcycling steps). The Python reimplementation should match this.

---

## Key Derived Constants

| Symbol | Formula | Value |
|:-------|:--------|:------|
| PERIOD | 1/FREQUENCY | ~73.7 ns |
| DT_E | PERIOD/N_T | ~18.4 ps |
| DT_I | N_SUB × DT_E | ~368 ps |
| DX | L/(N_G-1) | ~62.7 μm |
| INV_DX | 1/DX | ~15940 /m |
| OMEGA | 2π×FREQUENCY | ~85.2 Mrad/s |
| GAS_DENSITY | P/(kB×T) | ~2.06×10²¹ /m³ |
| FACTOR_W | WEIGHT/(A×DX) | ~1.12×10¹³ /m³ |
| FACTOR_E | DT_E/E_MASS × E_CHARGE | ~3.24×10⁶ (m/s)/V/m |
| FACTOR_I | DT_I/AR_MASS × E_CHARGE | ~8.87×10² (m/s)/V/m |
| NORMAL_DISTRIBUTION σ | √(kB×T/AR_MASS) | ~289 m/s |
