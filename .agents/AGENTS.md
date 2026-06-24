# Workspace Custom Rules: GoPIC Project

This workspace is dedicated to the Go and Python reimplementations of the **eduPIC** 1D3V particle-in-cell radio-frequency plasma simulation code.

## 🤖 Guidelines for AI Assistants

### 1. Consult the Custom Skill
* For any task involving PIC simulation mechanics, algorithms, physical constants, or boundary conditions, you **MUST** consult and follow the instructions in the custom workspace skill:
  * [edupic-assistant](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/.agents/skills/edupic_assistant/SKILL.md)

### 2. Code Translation & Reference Checks
* When refactoring, translating, or writing code:
  * Compare implementations against the original C++ reference in [C/eduPIC.cc](file:///mnt/c/Documents%20and%20Settings/E14/Documents/GitHub/GoPIC/C/eduPIC.cc).
  * Pay close attention to spatial interpolation formulas, density deposition factors (e.g., doubling the boundaries), and the tridiagonal matrix solver (Thomas algorithm).
  * Ensure random number generation distributions (uniform and normal) match the expected physics constraints.

### 3. Stability & Boundary Conditions
* Maintain all physical constraints:
  * Time steps ($\Delta t_e$, $\Delta t_i$), grid spacing ($\Delta x$), and superparticle weights must align with the simulation parameters.
  * Boundaries must correctly absorb electrons and ions, update current densities, and compile energy distributions.
