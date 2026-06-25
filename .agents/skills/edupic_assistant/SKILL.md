---
name: edupic-assistant
description: >
  Expert assistant for the eduPIC 1D3V Particle-in-Cell / Monte Carlo Collisions (PIC/MCC)
  plasma simulation project. Covers physics, algorithms, C++ reference code, Python (native
  and NumPy) reimplementations, and the Go reimplementation. Activate whenever the user asks
  about: simulation physics, PIC/MCC algorithms, code refactoring, numpy vectorization,
  debugging, performance, cross sections, Poisson solver, boundary conditions, or any aspect
  of the GoPIC repository.
---

# eduPIC Assistant Skill

You are an expert in the **eduPIC** educational 1D3V Particle-in-Cell / Monte Carlo Collisions
simulation code. You know the physics, the original C++ implementation, and all reimplementations
in the GoPIC repository.

**Before answering any question, read the relevant reference documents:**
- [cpp_reference.md](references/cpp_reference.md) — Complete C++ code structure and function details
- [project_map.md](references/project_map.md) — Repository layout, module map, file paths

---

## Physical System

The simulation models a **Capacitively Coupled Plasma (CCP)** in **Argon gas** between two
parallel plate electrodes driven by a 13.56 MHz RF voltage.

### Geometry & Parameters
- Gap: L = 25 mm, area A = 1 cm²
- Grid: N_G = 400 points, Δx = L/(N_G-1) ≈ 62.7 μm
- RF period N_T = 4000 electron time steps per cycle
- Δt_e = T/N_T ≈ 18.4 ps,  Δt_i = N_SUB × Δt_e (N_SUB = 20)
- Superparticle weight W = 7×10⁴
- Ar pressure 10 Pa, temperature 350 K → n_g ≈ 2.06×10²¹ m⁻³

---

## The PIC/MCC Algorithm (9 Steps per Time Step)

```
for t in [0, N_T):
    Step 1a: Deposit electron density (every step)
    Step 1b: Deposit ion density (only t % N_SUB == 0)
    Step 2:  Solve Poisson equation → E-field
    Step 3:  Push electrons (leapfrog, every step)
    Step 4:  Push ions (leapfrog, every N_SUB steps)
    Step 5:  Remove absorbed electrons from boundaries
    Step 6:  Remove absorbed ions from boundaries (every N_SUB steps)
    Step 7:  Monte Carlo electron collisions (every step)
    Step 8:  Monte Carlo ion collisions (every N_SUB steps)
    Step 9:  Accumulate XT diagnostic data (measurement_mode only)
```

### Step 1 — Density Deposition (Linear Weighting)
```
c0 = x[k] / Δx
p  = int(c0)
density[p]   += (p + 1 - c0) × W/(A·Δx)
density[p+1] += (c0 - p)     × W/(A·Δx)
boundary correction: density[0] *= 2,  density[N_G-1] *= 2
```

### Step 2 — Poisson Solver (Thomas Algorithm)
Tridiagonal system: A=1, B=-2, C=1, α=-Δx²/ε₀
- BC: pot[0]=V₀cos(ωt), pot[N_G-1]=0
- E-field interior: E[i] = (pot[i-1]-pot[i+1])/(2Δx)
- E-field boundaries include half-cell ρ correction (see cpp_reference.md)

### Steps 3 & 4 — Leapfrog Particle Push
```
e_x = c1×E[p] + c2×E[p+1]       (field interpolation)
vx_e -= e_x × (Δt_e/m_e × e)    (FACTOR_E)
x_e  += vx_e × Δt_e

vx_i += e_x × (Δt_i/m_Ar × e)   (FACTOR_I, ions have +e charge)
x_i  += vx_i × Δt_i
```
**Sign**: electrons: v -= FACTOR_E × E; ions: v += FACTOR_I × E

### Steps 5 & 6 — Boundary Absorption
- Remove particles with x < 0 (powered, += N_abs_pow) or x > L (grounded, += N_abs_gnd)
- C++ uses fast in-place swap with last element; NumPy uses boolean masking
- For ions: record IFED energy = 0.5×m_Ar×v² into ifed_pow/ifed_gnd histograms
- EEPF measured in center: MIN_X=0.45L to MAX_X=0.55L

### Steps 7 & 8 — Monte Carlo Collisions
```
p_coll_e = 1 - exp(-sigma_tot_e[e_idx] × |v| × Δt_e)
p_coll_i = 1 - exp(-sigma_tot_i[e_idx] × g × Δt_i)   (g = relative velocity)
```
**Electron collision types** (Ar, cold-gas):
1. Elastic — isotropic, chi=acos(1-2r)
2. Excitation — energy loss 11.5 eV
3. Ionization — energy loss 15.8 eV, creates new e⁻ + Ar⁺ pair

**Ion collision types** (Ar⁺/Ar):
1. Isotropic elastic — chi=acos(1-2r) in COM frame
2. Backward (charge exchange) — chi=π

Rotation formula for new velocity:
```
gx = g·(ct·cc - st·sc·ce)
gy = g·(st·cp·cc + ct·cp·sc·ce - sp·sc·se)
gz = g·(st·sp·cc + ct·sp·sc·ce + cp·sc·se)
v_new = w + F2·g_new
```
Where ct/st=cos/sin(theta), cp/sp=cos/sin(phi), cc/sc=cos/sin(chi), ce/se=cos/sin(eta)

---

## Cross Sections

**Electron/Ar** (Phelps & Petrovic, PSST 8 R21, 1999):
- E_ELA: modified momentum transfer (elastic) — complex polynomial formula
- E_EXC: excitation (threshold 11.5 eV)
- E_ION: ionization (threshold 15.8 eV)
- All ×1e-20 m²

**Ar⁺/Ar** (Phelps, J. Appl. Phys. 76, 747, 1994):
- e_lab = 2 × e_com (COM → lab frame)
- I_ISO: isotropic part of elastic
- I_BACK: backward scattering = (qmom - qiso) / 2

Total macroscopic cross sections include GAS_DENSITY factor:
```
sigma_tot_e[i] = (E_ELA + E_EXC + E_ION)[i] × n_g
sigma_tot_i[i] = (I_ISO + I_BACK)[i] × n_g
```

---

## Stability Conditions

Must ALL be satisfied:
1. `ω_pe × Δt_e < 0.2`  (plasma frequency condition)
2. `Δx / λ_D < 1.0`     (Debye length condition)
3. `max(ν_e) × Δt_e < 0.05`  (electron collision probability < 5%)
4. `max(ν_i) × Δt_i < 0.05`  (ion collision probability < 5%)
5. CFL: `v_e_max × Δt_e < Δx` → E_CFL = ½m_e(Δx/Δt_e)² must cover bulk of EEPF

---

## Diagnostic Outputs

| File | Content |
|:-----|:--------|
| `picdata.bin` | Binary particle state (Time, N_e, x_e[], vx_e[], ...) |
| `conv.dat` | Per-cycle: cycle#, N_e, N_i |
| `density.dat` | Time-averaged electron and ion density profiles |
| `eepf.dat` | Electron Energy Probability Function (normalized, center) |
| `ifed.dat` | Ion Flux-Energy Distributions at both electrodes |
| `info.txt` | Stability report + plasma diagnostics |
| `*_xt.dat` | 2D (space × time) distributions for all field/fluid quantities |

XT normalization: `f1 = N_XT / (N_cycles × N_T)`, `f2` for ionization rate.
Current: `j_e = -u_e × n_e × e_charge`, `j_i = u_i × n_i × e_charge`
Power: `P = j × E`

---

## Reimplementation Rules

When helping with Python/Go/NumPy code:

1. **Always compare against** `eduPIC/C/eduPIC.cc` (original reference).
2. **Subcycling guard**: Python/Go use `if t % N_SUB != 0: return`. C++ uses `if (t%N_SUB)==0 { ... }` as trigger. Both are correct.
3. **Boundary density factor ×2**: Only applied to `[0]` and `[N_G-1]` after deposition loop — NEVER skip this.
4. **cumul_i_density**: Accumulated EVERY time step in C++ (not just subcycling steps) — use last valid `i_density`.
5. **Electron push sign**: `vx_e -= FACTOR_E × e_x` (electrons have negative charge).
6. **Ion push sign**: `vx_i += FACTOR_I × e_x` (ions have positive charge).
7. **NumPy scatter-add**: Use `np.add.at` for density deposition — never `density[p] += w` with array `p` (gives wrong results for duplicate indices).
8. **NumPy collisions**: Vectorize collision *selection* only; call `collision_electron/ion` per-particle for the ~5% that collide.
9. **Thomas matrix** (NumPy): Build `_thomas_ab` once in `SimulationState.__init__`, reuse every step.

---

## Key Constants Quick Reference

| Symbol | Value | Unit |
|:-------|:------|:-----|
| E_CHARGE | 1.60217662×10⁻¹⁹ | C |
| E_MASS | 9.10938356×10⁻³¹ | kg |
| AR_MASS | 6.63352090×10⁻²⁶ | kg |
| EPSILON0 | 8.85418781×10⁻¹² | F/m |
| K_BOLTZMANN | 1.38064852×10⁻²³ | J/K |
| FACTOR_E | DT_E/E_MASS × E_CHARGE | (m/s)/(V/m) per step |
| FACTOR_I | DT_I/AR_MASS × E_CHARGE | (m/s)/(V/m) per step |
| FACTOR_W | WEIGHT/(A×DX) | 1/m³ per particle |
| NORMAL_DISTRIBUTION σ | √(kB×T/AR_MASS) | m/s |
