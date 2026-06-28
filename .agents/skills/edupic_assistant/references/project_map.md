# eduPIC — Project Structure & Reimplementation Map

Source project: GoPIC  
Repository: `/home/oliwier/Dev/GoPIC`

---

## Repository Layout

```
GoPIC/
├── eduPIC/
│   ├── C/
│   │   ├── eduPIC.cc              ← ORIGINAL reference C++ implementation
│   │   └── eduPIC_manual.pdf      ← Official manual (Thomas algorithm, physics details)
│   └── edupic-article.pdf         ← Published paper (PSST 2021, Donko et al.)
│
├── C/
│   └── eduPIC.cc                  ← Working copy of C++ (refactored: split do_one_cycle)
│
├── python/
│   ├── native_version/            ← Python reimplementation using plain lists
│   │   ├── main.py
│   │   ├── constants.py
│   │   ├── state.py               ← SimulationState class
│   │   ├── simulation.py          ← do_one_cycle + step1..step9 functions
│   │   ├── poisson.py
│   │   ├── collisions.py
│   │   ├── cross_sections.py
│   │   └── io_manager.py
│   │
│   └── numpy_version/             ← Planned NumPy reimplementation
│       ├── IMPLEMENTATION_PLAN.md  ← Original combined plan
│       ├── ENGINEERING_OVERVIEW.md ← Engineer-facing: rationale & benefits
│       └── AGENT_IMPLEMENTATION_SPEC.md ← Agent-facing: code templates & rules
│
├── Go/
│   └── main.go                    ← Go reimplementation
│
└── .agents/
    ├── AGENTS.md                  ← Workspace rules
    └── skills/
        └── edupic_assistant/
            ├── SKILL.md
            └── references/
                ├── cpp_reference.md      ← C++ code structure
                ├── project_map.md        ← This file
                └── physics_details.md    ← Deep physics/algorithm details
```

---

## Python Native Version — Module Structure

### `constants.py`
All physical and simulation constants. Type aliases at bottom.  
Key: `N_G=400`, `N_T=4000`, `N_SUB=20`, `MAX_N_P=1_000_000`, `CS_RANGES=1_000_000`.

### `state.py` — `SimulationState` class
All simulation state in one object. Particle arrays are Python `list[float]` of length `MAX_N_P`.  
Active particles: `sim.x_e[:sim.N_e]`, `sim.x_i[:sim.N_i]`.

### `simulation.py` — step functions
Modular split of `do_one_cycle`:
- `step1_compute_electron_density(sim)` — always runs
- `step1_compute_ion_density(sim, t)` — early return if `t % N_SUB != 0`
- `step2_solve_poisson(sim)` — calls `poisson.solve_poisson`
- `step3_move_electrons(sim, t_index)` — always runs, diagnostic in `measurement_mode`
- `step4_move_ions(sim, t_index, t)` — early return if `t % N_SUB != 0`
- `step5_check_boundaries_electrons(sim)` — always runs
- `step6_check_boundaries_ions(sim, t)` — early return if `t % N_SUB != 0`
- `step7_collisions_electrons(sim)` — always runs
- `step8_collisions_ions(sim, t)` — early return if `t % N_SUB != 0`
- `step9_collect_xt_data(sim, t_index)` — only in `measurement_mode`
- `do_one_cycle(sim, datafile_path)` — outer loop N_T iterations

### `collisions.py`
- `collision_electron(sim, k, e_index)` — modifies `sim.vx_e[k]` etc. in-place; can add new particles
- `collision_ion(sim, k, vx_a, vy_a, vz_a, e_index)` — modifies `sim.vx_i[k]` etc.
- `max_electron_coll_freq(sim)` / `max_ion_coll_freq(sim)` — stability checks

### `poisson.py`
- `solve_poisson(sim, rho, tt)` — Thomas algorithm, updates `sim.pot` and `sim.efield`

---

## NumPy Version — Planned Changes

See `AGENT_IMPLEMENTATION_SPEC.md` for complete code.  
Key differences from native version:
1. `state.py`: all arrays → `np.ndarray(dtype=float64)`, `rng` → `np.random.default_rng()`
2. `state.py`: adds `_thomas_ab` (pre-built banded matrix for scipy solver)
3. `simulation.py step1`: `np.add.at` for scatter-add density deposition
4. `poisson.py`: `scipy.linalg.solve_banded` + vectorized efield
5. `simulation.py step3/4`: vectorized field interpolation and particle push
6. `simulation.py step5/6`: boolean masking instead of while-loop deletion
7. `simulation.py step7/8`: vectorized collision probability, scalar loop only over colliding ~5%
8. `simulation.py step9`: column-wise 2D ndarray accumulation

---

## Go Version — `Go/main.go`

Single-file implementation. Mirrors C++ structure with:
- Separate slices for `X_e`, `Vx_e`, `Vy_e`, `Vz_e` (SoA layout)
- `doOneCycle()` split into modular step functions (same step1–step9 pattern)
- `math/rand` for RNG, `math` package for physics
- Subcycling: `if t%N_SUB != 0 { return }` guards

---

## Known Bugs Fixed

1. **Subcycling condition**: Original C++ uses `(t % N_SUB) == 0` as trigger. Python/Go use `(t % N_SUB) != 0` as early-return guard — these are equivalent.  
2. **`cumul_i_density` accumulation**: In C++ this always runs (line 542). Python must match this — accumulate every step using the last valid `i_density`.

---

## File Paths Quick Reference

| File | Absolute Path |
|:-----|:-------------|
| Original C++ | `/home/oliwier/Dev/GoPIC/eduPIC/C/eduPIC.cc` |
| Working C++ | `/home/oliwier/Dev/GoPIC/C/eduPIC.cc` |
| Python native simulation | `/home/oliwier/Dev/GoPIC/python/native_version/simulation.py` |
| Python native state | `/home/oliwier/Dev/GoPIC/python/native_version/state.py` |
| Python numpy spec | `/home/oliwier/Dev/GoPIC/python/numpy_version/AGENT_IMPLEMENTATION_SPEC.md` |
| Go main | `/home/oliwier/Dev/GoPIC/Go/main.go` |
| Article PDF | `/home/oliwier/Dev/GoPIC/eduPIC/edupic-article.pdf` |
| Manual PDF | `/home/oliwier/Dev/GoPIC/eduPIC/C/eduPIC_manual.pdf` |
