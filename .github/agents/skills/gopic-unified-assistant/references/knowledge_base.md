# GoPIC Unified Knowledge Base

This reference merges project physics, C++ reference behavior, and implementation mapping.

## 1. What the simulation models

- 1D3V CCP Argon plasma between parallel plates.
- RF drive: 13.56 MHz.
- Main scales: `N_G=400`, `N_T=4000`, `N_SUB=20`, `L=25 mm`, `A=1 cm^2`.

## 2. Canonical algorithm (per electron time step)

1. Deposit electron density.
2. Deposit ion density (subcycling).
3. Solve Poisson equation.
4. Push electrons.
5. Push ions (subcycling).
6. Absorb boundary electrons.
7. Absorb boundary ions (subcycling).
8. Electron collisions.
9. Ion collisions (subcycling).
10. XT diagnostics (measurement mode).

Notes:
- C++ uses trigger style (`if t%N_SUB==0`), Python/Go often use guard style (`if t%N_SUB!=0: return`).
- `cumul_i_density` still accumulates every electron step.

## 3. Invariants that must never be broken

- Density deposition uses linear weighting and boundary `x2` correction only at endpoints.
- Poisson solver tridiagonal coefficients: `A=1, B=-2, C=1`.
- Electrons use negative charge sign in push; ions positive sign.
- Collision probability form is exponential attenuation with `sigma_tot * speed * dt`.
- Cross-section lookup index must map kinetic energy bins correctly and remain in bounds.

## 4. Ground truth and implementation hierarchy

1. Ground truth: `eduPIC/C/eduPIC.cc` (do not modify).
2. Working C++ variant: `C/eduPIC.cc`.
3. Reimplementations:
   - `python/native_version/` (list-based parity-oriented translation),
   - `python/numpy_version/` (vectorized design with explicit parity rules),
   - `Go/main.go` (single-file Go translation).

## 5. Implementation responsibilities by language

- C++ reference:
  - Defines exact physics/algorithm behavior and diagnostics semantics.
- Python native:
  - Keeps step-by-step readability and direct parity with C++ logic.
- Python NumPy:
  - Preserves parity while vectorizing dense loops (`np.add.at`, masking, solve_banded).
- Go:
  - Preserves behavior with SoA slices and explicit step functions.

## 6. Diagnostics outputs that encode physics correctness

- `conv.dat`: per-cycle macro particle evolution.
- `density.dat`: averaged `n_e`, `n_i` profiles.
- `eepf.dat`: central EEPF shape and normalization.
- `ifed.dat`: electrode ion energy-flux distributions.
- `*_xt.dat`: space-time potentials, fields, currents, powers, rates.
- `info.txt`: stability checks and plasma diagnostics.

If behavior differs between implementations, compare these outputs against C++ reference trends first.
