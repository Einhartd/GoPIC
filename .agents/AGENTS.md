# Workspace Custom Rules: GoPIC Project

This workspace is dedicated to the Go and Python reimplementations of the **eduPIC** 1D3V particle-in-cell radio-frequency plasma simulation code.

## 🤖 Guidelines for AI Assistants

### 1. Consult the Custom Skill
* For any task involving PIC simulation mechanics, algorithms, physical constants, or boundary conditions, you **MUST** consult and follow the instructions in the custom workspace skill:
  * [SKILL.md](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/.agents/skills/edupic_assistant/SKILL.md) — main skill (physics, algorithm, implementation rules)
  * [cpp_reference.md](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/.agents/skills/edupic_assistant/references/cpp_reference.md) — full C++ code structure & function details
  * [project_map.md](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/.agents/skills/edupic_assistant/references/project_map.md) — repository layout & file paths

### 2. Ground Truth Reference
* The **original, unmodified** C++ source is the ground truth:
  * [eduPIC/C/eduPIC.cc](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/eduPIC/C/eduPIC.cc) — original reference (do NOT modify)
  * [C/eduPIC.cc](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/C/eduPIC.cc) — working copy (may be refactored)

### 3. Code Translation & Reference Checks
* When refactoring, translating, or writing code:
  * Compare implementations against the original C++ reference.
  * Pay close attention to:
    - Density deposition linear weighting formula and the **mandatory ×2 boundary correction**
    - Cumulative density accumulation (`cumul_i_density` is accumulated **every** time step)
    - Ion subcycling: only when `t % N_SUB == 0`
    - Thomas algorithm tridiagonal solver (A=1, B=-2, C=1)
    - Electron push: `v -= FACTOR_E × E` (negative charge)
    - Ion push: `v += FACTOR_I × E` (positive charge)
  * Ensure random number generation distributions (uniform and normal) match the expected physics constraints.

### 4. Stability & Boundary Conditions
* Maintain all physical constraints:
  * Time steps ($\Delta t_e$, $\Delta t_i$), grid spacing ($\Delta x$), and superparticle weights must align with the simulation parameters.
  * Boundaries must correctly absorb electrons and ions, update current densities, and compile energy distributions.
  * Always verify stability conditions: $\omega_{pe} \Delta t_e < 0.2$, $\Delta x / \lambda_D < 1.0$, $P_{coll} < 0.05$.

### 5. NumPy Version Rules
* When working on `python/numpy_version/`:
  * Always use `np.add.at()` for density scatter-add — never `array[p] += value` with array indices.
  * Operate on active particle slices: `sim.x_e[:sim.N_e]`.
  * Use `scipy.linalg.solve_banded` with pre-built `sim._thomas_ab`.
  * See [AGENT_IMPLEMENTATION_SPEC.md](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/python/numpy_version/AGENT_IMPLEMENTATION_SPEC.md) for complete code templates.
