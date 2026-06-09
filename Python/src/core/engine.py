import numpy as np
from core.state import SimulationState
from core.solver import solve_poisson
from core.collisions import collision_electron, collision_ion


def update_densities(state: SimulationState):
    """
    Computes electron and ion densities at grid points from particle positions.
    Replicates the weighting logic from eduPIC.
    """
    cfg = state.cfg
    inv_dx = cfg.INV_DX

    # Weighting factor for superparticles
    dv = cfg.sim.ELECTRODE_AREA * cfg.DX
    factor_w = cfg.sim.WEIGHT / dv

    # Reset current densities
    state.e_density.fill(0)
    state.i_density.fill(0)

    # --- Electron Density ---
    if state.n_e > 0:
        c0 = state.x_e[: state.n_e] * inv_dx
        p = c0.astype(int)
        frac = c0 - p

        # Charge assignment (linear interpolation)
        np.add.at(state.e_density, p, (1.0 - frac) * factor_w)
        np.add.at(state.e_density, p + 1, frac * factor_w)

        # Correct boundary points (factor 2.0 in C++ code due to half-cell volume)
        state.e_density[0] *= 2.0
        state.e_density[-1] *= 2.0

    # --- Ion Density (calculated every N_SUB-th step in C++, but we call it when needed) ---
    if state.n_i > 0:
        c0 = state.x_i[: state.n_i] * inv_dx
        p = c0.astype(int)
        frac = c0 - p

        np.add.at(state.i_density, p, (1.0 - frac) * factor_w)
        np.add.at(state.i_density, p + 1, frac * factor_w)

        state.i_density[0] *= 2.0
        state.i_density[-1] *= 2.0


def do_one_cycle(state: SimulationState, sigma: dict, rng: np.random.Generator):
    """
    Simulates one RF cycle. Replicates the 6-step PIC cycle from eduPIC.
    """
    cfg = state.cfg
    n_t = cfg.sim.N_T
    dt_e = cfg.DT_E
    dt_i = cfg.DT_I
    n_sub = cfg.sim.N_SUB
    n_bin = cfg.diag.N_BIN
    inv_dx = cfg.INV_DX

    # Derived factors for velocity updates
    factor_e = dt_e / cfg.const.E_MASS * cfg.const.E_CHARGE
    factor_i = dt_i / cfg.const.AR_MASS * cfg.const.E_CHARGE

    # Spatial bounds for EEPF
    min_x_eepf = 0.45 * cfg.sim.L
    max_x_eepf = 0.55 * cfg.sim.L

    for t in range(n_t):
        state.time += dt_e
        t_index = t // n_bin

        # --- Step 1: Densities ---
        update_densities(state)
        state.cumul_e_density += state.e_density
        state.cumul_i_density += (
            state.i_density
        )  # In C++ this is done regardless of subcycling? Yes.

        # --- Step 2: Poisson ---
        solve_poisson(state, state.time)

        # --- Step 3 & 4: Move Particles ---

        # Electrons (every step)
        if state.n_e > 0:
            c0 = state.x_e[: state.n_e] * inv_dx
            p = c0.astype(int)
            frac = c0 - p
            e_x = (1.0 - frac) * state.efield[p] + frac * state.efield[p + 1]

            if cfg.measurement_mode:
                # Diagnostics: use half-step velocity
                v_mean_x = state.vx_e[: state.n_e] - 0.5 * e_x * factor_e
                v_sqr = (
                    v_mean_x**2
                    + state.vy_e[: state.n_e] ** 2
                    + state.vz_e[: state.n_e] ** 2
                )
                energy = 0.5 * cfg.const.E_MASS * v_sqr / cfg.const.EV_TO_J

                # XT Counters
                np.add.at(state.counter_e_xt[:, t_index], p, 1.0 - frac)
                np.add.at(state.counter_e_xt[:, t_index], p + 1, frac)

                # XT Mean Velocity
                np.add.at(state.ue_xt[:, t_index], p, (1.0 - frac) * v_mean_x)
                np.add.at(state.ue_xt[:, t_index], p + 1, frac * v_mean_x)

                # XT Mean Energy
                np.add.at(state.meanee_xt[:, t_index], p, (1.0 - frac) * energy)
                np.add.at(state.meanee_xt[:, t_index], p + 1, frac * energy)

                # Ionization rate
                energy_idx = np.minimum(
                    (energy / cfg.cs.DE_CS + 0.5).astype(int), cfg.cs.CS_RANGES - 1
                )
                rate = (
                    sigma["sigma_e_ion"][energy_idx]
                    * np.sqrt(v_sqr)
                    * dt_e
                    * cfg.GAS_DENSITY
                )
                np.add.at(state.ioniz_rate_xt[:, t_index], p, (1.0 - frac) * rate)
                np.add.at(state.ioniz_rate_xt[:, t_index], p + 1, frac * rate)

                # EEPF Center measurement
                center_mask = (state.x_e[: state.n_e] > min_x_eepf) & (
                    state.x_e[: state.n_e] < max_x_eepf
                )
                if np.any(center_mask):
                    energy_center = energy[center_mask]
                    eepf_idx = (energy_center / cfg.diag.DE_EEPF).astype(int)
                    valid_eepf = eepf_idx < cfg.diag.N_EEPF
                    np.add.at(state.eepf, eepf_idx[valid_eepf], 1.0)
                    state.mean_energy_accu_center += np.sum(energy_center)
                    state.mean_energy_counter_center += len(energy_center)

            # Leapfrog update
            state.vx_e[: state.n_e] -= e_x * factor_e
            state.x_e[: state.n_e] += state.vx_e[: state.n_e] * dt_e

        # Ions (subcycling)
        if (t % n_sub) == 0:
            if state.n_i > 0:
                c0 = state.x_i[: state.n_i] * inv_dx
                p = c0.astype(int)
                frac = c0 - p
                e_x = (1.0 - frac) * state.efield[p] + frac * state.efield[p + 1]

                if cfg.measurement_mode:
                    v_mean_x = state.vx_i[: state.n_i] + 0.5 * e_x * factor_i
                    v_sqr = (
                        v_mean_x**2
                        + state.vy_i[: state.n_i] ** 2
                        + state.vz_i[: state.n_i] ** 2
                    )
                    energy = 0.5 * cfg.const.AR_MASS * v_sqr / cfg.const.EV_TO_J

                    np.add.at(state.counter_i_xt[:, t_index], p, 1.0 - frac)
                    np.add.at(state.counter_i_xt[:, t_index], p + 1, frac)
                    np.add.at(state.ui_xt[:, t_index], p, (1.0 - frac) * v_mean_x)
                    np.add.at(state.ui_xt[:, t_index], p + 1, frac * v_mean_x)
                    np.add.at(state.meanei_xt[:, t_index], p, (1.0 - frac) * energy)
                    np.add.at(state.meanei_xt[:, t_index], p + 1, frac * energy)

                state.vx_i[: state.n_i] += e_x * factor_i
                state.x_i[: state.n_i] += state.vx_i[: state.n_i] * dt_i

        # --- Step 5: Boundary Conditions ---

        # Electrons
        out_e = (state.x_e[: state.n_e] < 0) | (state.x_e[: state.n_e] > cfg.sim.L)
        if np.any(out_e):
            state.n_e_abs_pow += int(np.sum(state.x_e[: state.n_e][out_e] < 0))
            state.n_e_abs_gnd += int(np.sum(state.x_e[: state.n_e][out_e] > cfg.sim.L))

            # Efficiently remove particles by swapping with the end
            keep_idx = np.where(~out_e)[0]
            num_keep = len(keep_idx)
            if num_keep < state.n_e:
                state.x_e[:num_keep] = state.x_e[keep_idx]
                state.vx_e[:num_keep] = state.vx_e[keep_idx]
                state.vy_e[:num_keep] = state.vy_e[keep_idx]
                state.vz_e[:num_keep] = state.vz_e[keep_idx]
                state.n_e = num_keep

        # Ions
        if (t % n_sub) == 0:
            out_i = (state.x_i[: state.n_i] < 0) | (state.x_i[: state.n_i] > cfg.sim.L)
            if np.any(out_i):
                out_pow = state.x_i[: state.n_i] < 0
                out_gnd = state.x_i[: state.n_i] > cfg.sim.L

                # IFED collection
                if cfg.measurement_mode:
                    for k in np.where(out_pow)[0]:
                        state.n_i_abs_pow += 1
                        v_sqr = (
                            state.vx_i[k] ** 2 + state.vy_i[k] ** 2 + state.vz_i[k] ** 2
                        )
                        energy = 0.5 * cfg.const.AR_MASS * v_sqr / cfg.const.EV_TO_J
                        idx = int(energy / cfg.diag.DE_IFED)
                        if idx < cfg.diag.N_IFED:
                            state.ifed_pow[idx] += 1
                    for k in np.where(out_gnd)[0]:
                        state.n_i_abs_gnd += 1
                        v_sqr = (
                            state.vx_i[k] ** 2 + state.vy_i[k] ** 2 + state.vz_i[k] ** 2
                        )
                        energy = 0.5 * cfg.const.AR_MASS * v_sqr / cfg.const.EV_TO_J
                        idx = int(energy / cfg.diag.DE_IFED)
                        if idx < cfg.diag.N_IFED:
                            state.ifed_gnd[idx] += 1
                else:
                    state.n_i_abs_pow += int(np.sum(out_pow))
                    state.n_i_abs_gnd += int(np.sum(out_gnd))

                keep_idx = np.where(~out_i)[0]
                num_keep = len(keep_idx)
                if num_keep < state.n_i:
                    state.x_i[:num_keep] = state.x_i[keep_idx]
                    state.vx_i[:num_keep] = state.vx_i[keep_idx]
                    state.vy_i[:num_keep] = state.vy_i[keep_idx]
                    state.vz_i[:num_keep] = state.vz_i[keep_idx]
                    state.n_i = num_keep

        # --- Step 6: Collisions ---

        # Electrons
        if state.n_e > 0:
            v_sqr = (
                state.vx_e[: state.n_e] ** 2
                + state.vy_e[: state.n_e] ** 2
                + state.vz_e[: state.n_e] ** 2
            )
            velocity = np.sqrt(v_sqr)
            energy = 0.5 * cfg.const.E_MASS * v_sqr / cfg.const.EV_TO_J
            energy_idx = np.minimum(
                (energy / cfg.cs.DE_CS + 0.5).astype(int), cfg.cs.CS_RANGES - 1
            )

            nu = sigma["sigma_tot_e"][energy_idx] * velocity
            p_coll = 1.0 - np.exp(-nu * dt_e)

            colliding_indices = np.where(rng.random(state.n_e) < p_coll)[0]
            for k in colliding_indices:
                collision_electron(state, k, int(energy_idx[k]), sigma, rng)
                state.n_e_coll += 1

        # Ions
        if (t % n_sub) == 0:
            if state.n_i > 0:
                # This part is a bit trickier to vectorize due to target atom sampling
                # We'll stick to a loop for now, similar to C++
                for k in range(state.n_i):
                    thermal_std = np.sqrt(
                        cfg.const.K_BOLTZMANN * cfg.sim.TEMPERATURE / cfg.const.AR_MASS
                    )
                    vx_a, vy_a, vz_a = rng.normal(0, thermal_std, 3)

                    gx = state.vx_i[k] - vx_a
                    gy = state.vy_i[k] - vy_a
                    gz = state.vz_i[k] - vz_a
                    g_sqr = gx**2 + gy**2 + gz**2
                    g = np.sqrt(g_sqr)
                    energy = 0.5 * cfg.const.MU_ARAR * g_sqr / cfg.const.EV_TO_J
                    energy_idx = min(
                        int(energy / cfg.cs.DE_CS + 0.5), cfg.cs.CS_RANGES - 1
                    )

                    nu = sigma["sigma_tot_i"][energy_idx] * g
                    p_coll = 1.0 - np.exp(-nu * dt_i)

                    if rng.random() < p_coll:
                        collision_ion(state, k, energy_idx, sigma, rng)
                        state.n_i_coll += 1

        # XT diagnostic collection
        if cfg.measurement_mode:
            state.pot_xt[:, t_index] += state.pot
            state.efield_xt[:, t_index] += state.efield
            state.ne_xt[:, t_index] += state.e_density
            state.ni_xt[:, t_index] += state.i_density

        if (t % 1000) == 0:
            print(
                f" c = {state.cycle:8d}  t = {t:8d}  #e = {state.n_e:8d}  #i = {state.n_i:8d}"
            )
