import math
import numpy as np
import numba
import constants as cs
from state import SimulationState
import poisson
from collisions import collision_electron, collision_ion


@numba.njit(parallel=False, cache=True)
def step1_compute_electron_density(x_e, N_e, e_density, cumul_e_density,
                                    INV_DX, FACTOR_W, N_G):
    for i in numba.prange(N_G):
        e_density[i] = 0.0

    for k in numba.prange(N_e):
        c0 = x_e[k] * INV_DX
        p  = int(c0)
        if p < 0:
            p = 0
        elif p >= N_G - 1:
            p = N_G - 2
        w_left  = (p + 1.0) - c0
        w_right = c0 - p
        # atomic add — safe with parallel=True
        e_density[p]     += w_left  * FACTOR_W
        e_density[p + 1] += w_right * FACTOR_W

    e_density[0]       *= 2.0
    e_density[N_G - 1] *= 2.0

    for i in numba.prange(N_G):
        cumul_e_density[i] += e_density[i]


@numba.njit(parallel=False, cache=True)
def step1_compute_ion_density(x_i, N_i, i_density, cumul_i_density,
                               INV_DX, FACTOR_W, N_G, t, N_SUB):
    if t % N_SUB != 0:
        # Not a subcycling step — only accumulate last valid i_density
        for i in numba.prange(N_G):
            cumul_i_density[i] += i_density[i]
        return

    for i in numba.prange(N_G):
        i_density[i] = 0.0

    for k in numba.prange(N_i):
        c0 = x_i[k] * INV_DX
        p  = int(c0)
        if p < 0:
            p = 0
        elif p >= N_G - 1:
            p = N_G - 2
        w_left  = (p + 1.0) - c0
        w_right = c0 - p
        i_density[p]     += w_left  * FACTOR_W
        i_density[p + 1] += w_right * FACTOR_W

    i_density[0]       *= 2.0
    i_density[N_G - 1] *= 2.0

    for i in numba.prange(N_G):
        cumul_i_density[i] += i_density[i]


@numba.njit(parallel=False, cache=True)
def step3_move_electrons(x_e, vx_e, vy_e, vz_e, N_e, efield,
                          counter_e_xt, ue_xt, meanee_xt, ioniz_rate_xt,
                          eepf, sigma,
                          INV_DX, FACTOR_E, DT_E, N_G, E_MASS, EV_TO_J,
                          DE_CS, DE_EEPF, N_EEPF, CS_RANGES, GAS_DENSITY,
                          MIN_X, MAX_X, E_ION,
                          t_index, measurement_mode):
    accu = 0.0
    counter = 0
    for k in numba.prange(N_e):
        c0  = x_e[k] * INV_DX
        p   = int(c0)
        if p < 0:
            p = 0
        elif p >= N_G - 1:
            p = N_G - 2
        c1  = (p + 1.0) - c0
        c2  = c0 - p
        e_x = c1 * efield[p] + c2 * efield[p + 1]

        if measurement_mode:
            mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E
            counter_e_xt[p,     t_index] += c1
            counter_e_xt[p + 1, t_index] += c2
            ue_xt[p,     t_index] += c1 * mean_v
            ue_xt[p + 1, t_index] += c2 * mean_v

            v_sqr  = mean_v**2 + vy_e[k]**2 + vz_e[k]**2
            energy = 0.5 * E_MASS * v_sqr / EV_TO_J
            meanee_xt[p,     t_index] += c1 * energy
            meanee_xt[p + 1, t_index] += c2 * energy

            e_idx = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
            rate  = sigma[E_ION, e_idx] * math.sqrt(v_sqr) * DT_E * GAS_DENSITY
            ioniz_rate_xt[p,     t_index] += c1 * rate
            ioniz_rate_xt[p + 1, t_index] += c2 * rate

            if MIN_X < x_e[k] < MAX_X:
                eepf_idx = int(energy / DE_EEPF)
                if eepf_idx < N_EEPF:
                    eepf[eepf_idx] += 1.0
                accu += energy
                counter += 1

        # Leapfrog push
        vx_e[k] -= e_x * FACTOR_E
        x_e[k]  += vx_e[k] * DT_E

    return accu, counter


@numba.njit(parallel=False, cache=True)
def step4_move_ions(x_i, vx_i, vy_i, vz_i, N_i, efield,
                     counter_i_xt, ui_xt, meanei_xt,
                     INV_DX, FACTOR_I, DT_I, N_G, AR_MASS, EV_TO_J,
                     t_index, measurement_mode,
                     t, N_SUB):
    if t % N_SUB != 0:
        return

    for k in numba.prange(N_i):
        c0  = x_i[k] * INV_DX
        p   = int(c0)
        if p < 0:
            p = 0
        elif p >= N_G - 1:
            p = N_G - 2
        c1  = (p + 1.0) - c0
        c2  = c0 - p
        e_x = c1 * efield[p] + c2 * efield[p + 1]

        if measurement_mode:
            mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I
            counter_i_xt[p,     t_index] += c1
            counter_i_xt[p + 1, t_index] += c2
            ui_xt[p,     t_index] += c1 * mean_v
            ui_xt[p + 1, t_index] += c2 * mean_v

            v_sqr  = mean_v**2 + vy_i[k]**2 + vz_i[k]**2
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
            meanei_xt[p,     t_index] += c1 * energy
            meanei_xt[p + 1, t_index] += c2 * energy

        vx_i[k] += e_x * FACTOR_I
        x_i[k]  += vx_i[k] * DT_I


@numba.njit(cache=True)
def step5_check_boundaries_electrons(x_e, vx_e, vy_e, vz_e, N_e, L):

    N_e_abs_pow = 0
    N_e_abs_gnd = 0
    k = 0
    while k < N_e:
        if x_e[k] < 0.0:
            N_e_abs_pow += 1
            x_e[k]  = x_e[N_e - 1]
            vx_e[k] = vx_e[N_e - 1]
            vy_e[k] = vy_e[N_e - 1]
            vz_e[k] = vz_e[N_e - 1]
            N_e -= 1
        elif x_e[k] > L:
            N_e_abs_gnd += 1
            x_e[k]  = x_e[N_e - 1]
            vx_e[k] = vx_e[N_e - 1]
            vy_e[k] = vy_e[N_e - 1]
            vz_e[k] = vz_e[N_e - 1]
            N_e -= 1
        else:
            k += 1
    return N_e, N_e_abs_pow, N_e_abs_gnd


@numba.njit(cache=True)
def step6_check_boundaries_ions(x_i, vx_i, vy_i, vz_i, N_i, L,
                                  ifed_pow, ifed_gnd,
                                  AR_MASS, EV_TO_J, DE_IFED, N_IFED,
                                  t, N_SUB):
    if t % N_SUB != 0:
        return N_i, 0, 0

    N_i_abs_pow = 0
    N_i_abs_gnd = 0
    k = 0
    while k < N_i:
        absorbed = False
        if x_i[k] < 0.0:
            N_i_abs_pow += 1
            absorbed = True
            v_sqr  = vx_i[k]**2 + vy_i[k]**2 + vz_i[k]**2
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
            idx    = int(energy / DE_IFED)
            if idx < N_IFED:
                ifed_pow[idx] += 1
        elif x_i[k] > L:
            N_i_abs_gnd += 1
            absorbed = True
            v_sqr  = vx_i[k]**2 + vy_i[k]**2 + vz_i[k]**2
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
            idx    = int(energy / DE_IFED)
            if idx < N_IFED:
                ifed_gnd[idx] += 1

        if absorbed:
            x_i[k]  = x_i[N_i - 1]
            vx_i[k] = vx_i[N_i - 1]
            vy_i[k] = vy_i[N_i - 1]
            vz_i[k] = vz_i[N_i - 1]
            N_i -= 1
        else:
            k += 1
    return N_i, N_i_abs_pow, N_i_abs_gnd


@numba.njit(cache=True)
def step7_collisions_electrons(x_e, vx_e, vy_e, vz_e, N_e,
                                 x_i, vx_i, vy_i, vz_i, N_i,
                                 sigma, sigma_tot_e,
                                 DT_E, DE_CS, CS_RANGES, E_MASS, EV_TO_J,
                                 NORMAL_DISTRIBUTION,
                                 F1, F2, PI, TWO_PI,
                                 E_EXC_TH, E_ION_TH,
                                 E_ELA, E_EXC, E_ION,
                                 AR_MASS):
    """
    Sequential loop — ionization events grow N_e and N_i.
    Cannot use prange here.
    """
    N_e_coll = 0
    for k in range(N_e):
        v_sqr    = vx_e[k]**2 + vy_e[k]**2 + vz_e[k]**2
        velocity = math.sqrt(v_sqr)
        energy   = 0.5 * E_MASS * v_sqr / EV_TO_J
        e_idx    = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
        nu       = sigma_tot_e[e_idx] * velocity
        p_coll   = 1.0 - math.exp(-nu * DT_E)

        if np.random.uniform(0.0, 1.0) < p_coll:
            N_e, N_i = collision_electron(
                k, x_e, vx_e, vy_e, vz_e, N_e,
                x_i, vx_i, vy_i, vz_i, N_i,
                sigma, e_idx,
                F1, F2, PI, TWO_PI, E_MASS, AR_MASS,
                E_EXC_TH, E_ION_TH, EV_TO_J,
                NORMAL_DISTRIBUTION, E_ELA, E_EXC, E_ION
            )
            N_e_coll += 1

    return N_e, N_i, N_e_coll


@numba.njit(cache=True)
def step8_collisions_ions(vx_i, vy_i, vz_i, N_i,
                            sigma, sigma_tot_i,
                            DT_I, DE_CS, CS_RANGES, AR_MASS, MU_ARAR, EV_TO_J,
                            NORMAL_DISTRIBUTION, PI, TWO_PI,
                            I_ISO, I_BACK,
                            t, N_SUB):
    if t % N_SUB != 0:
        return 0

    N_i_coll = 0
    for k in range(N_i):
        vx_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)
        vy_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)
        vz_a = np.random.normal(0.0, NORMAL_DISTRIBUTION)

        gx    = vx_i[k] - vx_a
        gy    = vy_i[k] - vy_a
        gz    = vz_i[k] - vz_a
        g_sqr = gx*gx + gy*gy + gz*gz
        g     = math.sqrt(g_sqr)

        energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J
        e_idx  = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
        nu     = sigma_tot_i[e_idx] * g
        p_coll = 1.0 - math.exp(-nu * DT_I)

        if np.random.uniform(0.0, 1.0) < p_coll:
            collision_ion(
                k, vx_i, vy_i, vz_i,
                vx_a, vy_a, vz_a,
                sigma, e_idx,
                PI, TWO_PI, I_ISO, I_BACK
            )
            N_i_coll += 1

    return N_i_coll


@numba.njit(parallel=False, cache=True)
def step9_collect_xt_data(pot, efield, e_density, i_density,
                            pot_xt, efield_xt, ne_xt, ni_xt,
                            N_G, t_index, measurement_mode):
    if not measurement_mode:
        return
    for i in numba.prange(N_G):
        pot_xt[i, t_index]    += pot[i]
        efield_xt[i, t_index] += efield[i]
        ne_xt[i, t_index]     += e_density[i]
        ni_xt[i, t_index]     += i_density[i]


def do_one_cycle(sim: SimulationState, datafile_path: str = "conv.dat"):
    """
    Python-level loop. Extracts arrays from sim, calls @njit step functions.
    JIT compilation happens on first call (cycle 0 = natural warmup).
    """
    for t in range(cs.N_T):
        sim.Time += cs.DT_E
        t_index   = t // cs.N_BIN

        step1_compute_electron_density(
            sim.x_e, sim.N_e, sim.e_density, sim.cumul_e_density,
            cs.INV_DX, cs.FACTOR_W, cs.N_G
        )
        step1_compute_ion_density(
            sim.x_i, sim.N_i, sim.i_density, sim.cumul_i_density,
            cs.INV_DX, cs.FACTOR_W, cs.N_G, t, cs.N_SUB
        )

        # Step 2 — Poisson (Python wrapper calls @njit solver)
        rho = cs.E_CHARGE * (sim.i_density - sim.e_density)
        poisson.solve_poisson(sim, rho, sim.Time)

        accu, counter = step3_move_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, sim.efield,
            sim.counter_e_xt, sim.ue_xt, sim.meanee_xt, sim.ioniz_rate_xt,
            sim.eepf, sim.sigma,
            cs.INV_DX, cs.FACTOR_E, cs.DT_E, cs.N_G, cs.E_MASS, cs.EV_TO_J,
            cs.DE_CS, cs.DE_EEPF, cs.N_EEPF, cs.CS_RANGES, cs.GAS_DENSITY,
            cs.MIN_X, cs.MAX_X, cs.E_ION,
            t_index, sim.measurement_mode
        )
        if sim.measurement_mode:
            sim.mean_energy_accu_center += accu
            sim.mean_energy_counter_center += counter
        step4_move_ions(
            sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, sim.efield,
            sim.counter_i_xt, sim.ui_xt, sim.meanei_xt,
            cs.INV_DX, cs.FACTOR_I, cs.DT_I, cs.N_G, cs.AR_MASS, cs.EV_TO_J,
            t_index, sim.measurement_mode, t, cs.N_SUB
        )

        sim.N_e, abs_pow, abs_gnd = step5_check_boundaries_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, cs.L
        )
        sim.N_e_abs_pow += abs_pow
        sim.N_e_abs_gnd += abs_gnd

        sim.N_i, abs_pow, abs_gnd = step6_check_boundaries_ions(
            sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, cs.L,
            sim.ifed_pow, sim.ifed_gnd,
            cs.AR_MASS, cs.EV_TO_J, cs.DE_IFED, cs.N_IFED, t, cs.N_SUB
        )
        sim.N_i_abs_pow += abs_pow
        sim.N_i_abs_gnd += abs_gnd

        sim.N_e, sim.N_i, coll = step7_collisions_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e,
            sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i,
            sim.sigma, sim.sigma_tot_e,
            cs.DT_E, cs.DE_CS, cs.CS_RANGES, cs.E_MASS, cs.EV_TO_J,
            cs.NORMAL_DISTRIBUTION, cs.F1, cs.F2, cs.PI, cs.TWO_PI,
            cs.E_EXC_TH, cs.E_ION_TH, cs.E_ELA, cs.E_EXC, cs.E_ION,
            cs.AR_MASS
        )
        sim.N_e_coll += coll

        coll = step8_collisions_ions(
            sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i,
            sim.sigma, sim.sigma_tot_i,
            cs.DT_I, cs.DE_CS, cs.CS_RANGES, cs.AR_MASS, cs.MU_ARAR, cs.EV_TO_J,
            cs.NORMAL_DISTRIBUTION, cs.PI, cs.TWO_PI, cs.I_ISO, cs.I_BACK,
            t, cs.N_SUB
        )
        sim.N_i_coll += coll

        step9_collect_xt_data(
            sim.pot, sim.efield, sim.e_density, sim.i_density,
            sim.pot_xt, sim.efield_xt, sim.ne_xt, sim.ni_xt,
            cs.N_G, t_index, sim.measurement_mode
        )

        if t % 1000 == 0:
            print(f" c = {sim.cycle:8d}  t = {t:8d}  #e = {sim.N_e:8d}  #i = {sim.N_i:8d}")

    with open(datafile_path, "a") as f:
        f.write(f"{sim.cycle:8d}  {sim.N_e:8d}  {sim.N_i:8d}\n")
