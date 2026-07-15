import numpy as np
import constants as cs
from state import SimulationState
import poisson
import collisions

def step1_compute_electron_density(sim: SimulationState):
    x  = sim.x_e[:sim.N_e]
    c0 = x * cs.INV_DX
    p  = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
    p_f = p.astype(np.float64)
    w_left  = p_f + 1.0 - c0    # weight for left node
    w_right = c0 - p_f          # weight for right node

    sim.e_density[:] = 0.0
    np.add.at(sim.e_density, p,     w_left  * cs.FACTOR_W)
    np.add.at(sim.e_density, p + 1, w_right * cs.FACTOR_W)

    sim.e_density[0]         *= 2.0
    sim.e_density[cs.N_G - 1] *= 2.0
    sim.cumul_e_density       += sim.e_density


def step1_compute_ion_density(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        sim.cumul_i_density += sim.i_density
        return

    x  = sim.x_i[:sim.N_i]
    c0 = x * cs.INV_DX
    p  = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
    p_f = p.astype(np.float64)
    w_left  = p_f + 1.0 - c0
    w_right = c0 - p_f

    sim.i_density[:] = 0.0
    np.add.at(sim.i_density, p,     w_left  * cs.FACTOR_W)
    np.add.at(sim.i_density, p + 1, w_right * cs.FACTOR_W)

    sim.i_density[0]         *= 2.0
    sim.i_density[cs.N_G - 1] *= 2.0
    sim.cumul_i_density       += sim.i_density


def step2_solve_poisson(sim: SimulationState):
    rho = cs.E_CHARGE * (sim.i_density - sim.e_density)
    poisson.solve_poisson(sim, rho, sim.Time)


def step3_move_electrons(sim: SimulationState, t_index: int):
    x  = sim.x_e[:sim.N_e]
    vx = sim.vx_e[:sim.N_e]
    vy = sim.vy_e[:sim.N_e]
    vz = sim.vz_e[:sim.N_e]

    c0 = x * cs.INV_DX
    p  = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
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


def step4_move_ions(sim: SimulationState, t_index: int, t: int):
    if (t % cs.N_SUB) != 0:
        return

    x  = sim.x_i[:sim.N_i]
    vx = sim.vx_i[:sim.N_i]
    vy = sim.vy_i[:sim.N_i]
    vz = sim.vz_i[:sim.N_i]

    c0 = x * cs.INV_DX
    p  = np.clip(c0.astype(np.int32), 0, cs.N_G - 2)
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


def step7_collisions_electrons(sim: SimulationState):
    if cs.USE_NULL_COLLISION:
        if sim.N_e == 0:
            return
        N_coll_star = int(sim.rng.binomial(sim.N_e, sim.P_star_e))
        if N_coll_star > sim.N_e:
            N_coll_star = sim.N_e
        if N_coll_star == 0:
            return

        candidates = sim.rng.choice(sim.N_e, size=N_coll_star, replace=False)

        vx = sim.vx_e[candidates]
        vy = sim.vy_e[candidates]
        vz = sim.vz_e[candidates]

        v_sqr = vx**2 + vy**2 + vz**2
        velocity = np.sqrt(v_sqr)
        energy = 0.5 * cs.E_MASS * v_sqr / cs.EV_TO_J
        e_idx = np.minimum((energy / cs.DE_CS + 0.5).astype(np.int32), cs.CS_RANGES - 1)

        real_nu = sim.sigma_tot_e[e_idx] * velocity
        p_accept = real_nu / sim.nu_star_e
        p_accept = np.minimum(p_accept, 1.0)

        rands = sim.rng.random(N_coll_star)
        accepted = rands < p_accept

        for idx, is_accepted in enumerate(accepted):
            if is_accepted:
                k = candidates[idx]
                collisions.collision_electron(sim, int(k), int(e_idx[idx]))
                sim.N_e_coll += 1
    else:
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


def step8_collisions_ions(sim: SimulationState, t: int):
    if (t % cs.N_SUB) != 0:
        return

    if cs.USE_NULL_COLLISION:
        if sim.N_i == 0:
            return
        N_coll_star = int(sim.rng.binomial(sim.N_i, sim.P_star_i))
        if N_coll_star > sim.N_i:
            N_coll_star = sim.N_i
        if N_coll_star == 0:
            return

        candidates = sim.rng.choice(sim.N_i, size=N_coll_star, replace=False)

        vx_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, N_coll_star)
        vy_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, N_coll_star)
        vz_a = sim.rng.normal(0.0, cs.NORMAL_DISTRIBUTION, N_coll_star)

        vx = sim.vx_i[candidates]
        vy = sim.vy_i[candidates]
        vz = sim.vz_i[candidates]

        gx = vx - vx_a
        gy = vy - vy_a
        gz = vz - vz_a
        g_sqr = gx**2 + gy**2 + gz**2
        g = np.sqrt(g_sqr)

        energy = 0.5 * cs.MU_ARAR * g_sqr / cs.EV_TO_J
        e_idx = np.minimum((energy / cs.DE_CS + 0.5).astype(np.int32), cs.CS_RANGES - 1)

        real_nu = sim.sigma_tot_i[e_idx] * g
        p_accept = real_nu / sim.nu_star_i
        p_accept = np.minimum(p_accept, 1.0)

        rands = sim.rng.random(N_coll_star)
        accepted = rands < p_accept

        for idx, is_accepted in enumerate(accepted):
            if is_accepted:
                k = candidates[idx]
                collisions.collision_ion(
                    sim, int(k),
                    float(vx_a[idx]), float(vy_a[idx]), float(vz_a[idx]),
                    int(e_idx[idx])
                )
                sim.N_i_coll += 1
    else:
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


def step9_collect_xt_data(sim: SimulationState, t_index: int):
    if not sim.measurement_mode:
        return
    sim.pot_xt[:, t_index]    += sim.pot
    sim.efield_xt[:, t_index] += sim.efield
    sim.ne_xt[:, t_index]     += sim.e_density
    sim.ni_xt[:, t_index]     += sim.i_density


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
