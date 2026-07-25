import math
import numpy as np
import numba
import constants as cs
from state import SimulationState
import poisson
from collisions import collision_electron, collision_ion


@numba.njit(parallel=True, cache=True)
def step1_compute_local_electron_density(x_e, N_e, local_e_density: np.ndarray, e_density: np.ndarray, 
                                          INV_DX, FACTOR_W, N_G, num_threads):
    local_e_density.fill(0.0)
    e_density.fill(0.0)

    for k in numba.prange(N_e):
        tid = numba.get_thread_id()
        c0 = x_e[k] * INV_DX
        p  = int(c0)
        if p < 0:
            p = 0
        elif p >= N_G - 1:
            p = N_G - 2
        w_left  = (p + 1.0) - c0
        w_right = c0 - p

        local_e_density[tid, p]     += w_left  * FACTOR_W
        local_e_density[tid, p+1]   += w_right * FACTOR_W

    for i in numba.prange(N_G):
        acc = 0.0
        for t in range(num_threads):
            acc += local_e_density[t, i]

        e_density[i] = acc


@numba.njit(parallel=True, cache=True)
def step1_finish_electron_density(global_e_density, cumul_e_density, N_G):
    global_e_density[0]       *= 2.0
    global_e_density[N_G - 1] *= 2.0

    for i in numba.prange(N_G):
        cumul_e_density[i] += global_e_density[i]


@numba.njit(parallel=True, cache=True)
def step1_compute_local_ion_density(x_i, N_i, local_i_density: np.ndarray, i_density: np.ndarray,
                                      INV_DX, FACTOR_W, N_G, num_threads):
    local_i_density.fill(0.0)
    i_density.fill(0.0)

    for k in numba.prange(N_i):
        tid = numba.get_thread_id()
        c0 = x_i[k] * INV_DX
        p  = int(c0)
        if p < 0:
            p = 0
        elif p >= N_G - 1:
            p = N_G - 2
        w_left  = (p + 1.0) - c0
        w_right = c0 - p
        local_i_density[tid, p]     += w_left  * FACTOR_W
        local_i_density[tid, p+1]   += w_right * FACTOR_W

    for i in numba.prange(N_G):
        acc = 0.0
        for thr in range(num_threads):
            acc += local_i_density[thr, i]

        i_density[i] = acc


@numba.njit(parallel=True, cache=True)
def step1_finish_ion_density(global_i_density, cumul_i_density, N_G):
    global_i_density[0]       *= 2.0
    global_i_density[N_G - 1] *= 2.0

    for i in numba.prange(N_G):
        cumul_i_density[i] += global_i_density[i]


@numba.njit(parallel=True, cache=True)
def step1_accumulate_ion_density(global_i_density, cumul_i_density, N_G):
    for i in numba.prange(N_G):
        cumul_i_density[i] += global_i_density[i]


@numba.njit(parallel=True, cache=True)
def step3_move_electrons(x_e, vx_e, vy_e, vz_e, N_e, efield,
                          counter_e_xt, ue_xt, meanee_xt, ioniz_rate_xt,
                          eepf, sigma,
                          local_counter_e_xt, local_ue_xt, local_meanee_xt, local_ioniz_rate_xt,
                          local_eepf, local_accu, local_counter,
                          INV_DX, FACTOR_E, DT_E, N_G, E_MASS, EV_TO_J,
                          DE_CS, DE_EEPF, N_EEPF, CS_RANGES, GAS_DENSITY,
                          MIN_X, MAX_X, E_ION,
                          t_index, measurement_mode, num_threads):
    if measurement_mode:
        local_counter_e_xt.fill(0.0)
        local_ue_xt.fill(0.0)
        local_meanee_xt.fill(0.0)
        local_ioniz_rate_xt.fill(0.0)
        local_eepf.fill(0.0)
        local_accu.fill(0.0)
        local_counter.fill(0)

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
            tid = numba.get_thread_id()
            mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E
            local_counter_e_xt[tid, p]     += c1
            local_counter_e_xt[tid, p + 1] += c2
            local_ue_xt[tid, p]     += c1 * mean_v
            local_ue_xt[tid, p + 1] += c2 * mean_v

            v_sqr  = mean_v**2 + vy_e[k]**2 + vz_e[k]**2
            energy = 0.5 * E_MASS * v_sqr / EV_TO_J
            local_meanee_xt[tid, p]     += c1 * energy
            local_meanee_xt[tid, p + 1] += c2 * energy

            e_idx = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
            rate  = sigma[E_ION, e_idx] * math.sqrt(v_sqr) * DT_E * GAS_DENSITY
            local_ioniz_rate_xt[tid, p]     += c1 * rate
            local_ioniz_rate_xt[tid, p + 1] += c2 * rate

            if MIN_X < x_e[k] < MAX_X:
                eepf_idx = int(energy / DE_EEPF)
                if eepf_idx < N_EEPF:
                    local_eepf[tid, eepf_idx] += 1.0
                local_accu[tid] += energy
                local_counter[tid] += 1

        # Leapfrog push
        vx_e[k] -= e_x * FACTOR_E
        x_e[k]  += vx_e[k] * DT_E

    accu = 0.0
    counter = 0
    if measurement_mode:
        for i in numba.prange(N_G):
            acc_cnt = 0.0
            acc_u   = 0.0
            acc_mee = 0.0
            acc_rat = 0.0
            for thr in range(num_threads):
                acc_cnt += local_counter_e_xt[thr, i]
                acc_u   += local_ue_xt[thr, i]
                acc_mee += local_meanee_xt[thr, i]
                acc_rat += local_ioniz_rate_xt[thr, i]
            counter_e_xt[i, t_index]  += acc_cnt
            ue_xt[i, t_index]         += acc_u
            meanee_xt[i, t_index]     += acc_mee
            ioniz_rate_xt[i, t_index] += acc_rat

        for idx in numba.prange(N_EEPF):
            acc_eepf = 0.0
            for thr in range(num_threads):
                acc_eepf += local_eepf[thr, idx]
            eepf[idx] += acc_eepf

        for thr in range(num_threads):
            accu += local_accu[thr]
            counter += local_counter[thr]

    return accu, counter


@numba.njit(parallel=True, cache=True)
def step4_move_ions(x_i, vx_i, vy_i, vz_i, N_i, efield,
                     counter_i_xt, ui_xt, meanei_xt,
                     local_counter_i_xt, local_ui_xt, local_meanei_xt,
                     INV_DX, FACTOR_I, DT_I, N_G, AR_MASS, EV_TO_J,
                     t_index, measurement_mode,
                     t, N_SUB, num_threads):
    if t % N_SUB != 0:
        return

    if measurement_mode:
        local_counter_i_xt.fill(0.0)
        local_ui_xt.fill(0.0)
        local_meanei_xt.fill(0.0)

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
            tid = numba.get_thread_id()
            mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I
            local_counter_i_xt[tid, p]     += c1
            local_counter_i_xt[tid, p + 1] += c2
            local_ui_xt[tid, p]     += c1 * mean_v
            local_ui_xt[tid, p + 1] += c2 * mean_v

            v_sqr  = mean_v**2 + vy_i[k]**2 + vz_i[k]**2
            energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
            local_meanei_xt[tid, p]     += c1 * energy
            local_meanei_xt[tid, p + 1] += c2 * energy

        vx_i[k] += e_x * FACTOR_I
        x_i[k]  += vx_i[k] * DT_I

    if measurement_mode:
        for i in numba.prange(N_G):
            acc_cnt = 0.0
            acc_u   = 0.0
            acc_mee = 0.0
            for thr in range(num_threads):
                acc_cnt += local_counter_i_xt[thr, i]
                acc_u   += local_ui_xt[thr, i]
                acc_mee += local_meanei_xt[thr, i]
            counter_i_xt[i, t_index] += acc_cnt
            ui_xt[i, t_index]        += acc_u
            meanei_xt[i, t_index]    += acc_mee


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
def sample_indices_inplace(n, count, out_buffer):
    """
    Zero-heap-allocation random sampling without replacement from [0, n).
    Fills out_buffer[:count].
    """
    idx = 0
    for i in range(n):
        rem = n - i
        needed = count - idx
        if np.random.uniform(0.0, 1.0) * rem < needed:
            out_buffer[idx] = i
            idx += 1
            if idx >= count:
                break


@numba.njit(parallel=True, cache=True)
def _find_colliding_electrons_parallel(
    vx_e, vy_e, vz_e, N_e,
    sigma_tot_e, DT_E, DE_CS, CS_RANGES, E_MASS, EV_TO_J,
    thread_coll_indices, thread_coll_counts, num_threads
):
    thread_coll_counts.fill(0)
    for k in numba.prange(N_e):
        v_sqr    = vx_e[k]**2 + vy_e[k]**2 + vz_e[k]**2
        velocity = math.sqrt(v_sqr)
        energy   = 0.5 * E_MASS * v_sqr / EV_TO_J
        e_idx    = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
        nu       = sigma_tot_e[e_idx] * velocity
        p_coll   = 1.0 - math.exp(-nu * DT_E)

        if np.random.uniform(0.0, 1.0) < p_coll:
            tid = numba.get_thread_id()
            idx = thread_coll_counts[tid]
            thread_coll_indices[tid, idx] = k
            thread_coll_counts[tid] = idx + 1


@numba.njit(parallel=True, cache=True)
def _find_colliding_ions_parallel(
    vx_i, vy_i, vz_i, N_i,
    sigma_tot_i, DT_I, DE_CS, CS_RANGES, AR_MASS, MU_ARAR, EV_TO_J,
    NORMAL_DISTRIBUTION,
    thread_coll_indices, thread_coll_counts, num_threads
):
    thread_coll_counts.fill(0)
    for k in numba.prange(N_i):
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
            tid = numba.get_thread_id()
            idx = thread_coll_counts[tid]
            thread_coll_indices[tid, idx] = k
            thread_coll_counts[tid] = idx + 1


@numba.njit(cache=True)
def step7_collisions_electrons(x_e, vx_e, vy_e, vz_e, N_e,
                                 x_i, vx_i, vy_i, vz_i, N_i,
                                 sigma, sigma_tot_e,
                                 thread_coll_indices, thread_coll_counts, null_coll_buffer, num_threads,
                                 DT_E, DE_CS, CS_RANGES, E_MASS, EV_TO_J,
                                 NORMAL_DISTRIBUTION,
                                 F1, F2, PI, TWO_PI,
                                 E_EXC_TH, E_ION_TH,
                                 E_ELA, E_EXC, E_ION,
                                 AR_MASS,
                                 use_null_collision, nu_star_e, P_star_e):
    N_e_coll = 0
    if use_null_collision:
        if N_e == 0:
            return N_e, N_i, N_e_coll
        N_coll_star = int(np.random.binomial(N_e, P_star_e))
        if N_coll_star > N_e:
            N_coll_star = N_e
        if N_coll_star == 0:
            return N_e, N_i, N_e_coll

        sample_indices_inplace(N_e, N_coll_star, null_coll_buffer)
        for idx in range(N_coll_star):
            k = null_coll_buffer[idx]
            v_sqr    = vx_e[k]**2 + vy_e[k]**2 + vz_e[k]**2
            velocity = math.sqrt(v_sqr)
            energy   = 0.5 * E_MASS * v_sqr / EV_TO_J
            e_idx    = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
            real_nu  = sigma_tot_e[e_idx] * velocity
            p_accept = real_nu / nu_star_e
            if p_accept > 1.0:
                p_accept = 1.0

            if np.random.uniform(0.0, 1.0) < p_accept:
                N_e, N_i = collision_electron(
                    k, x_e, vx_e, vy_e, vz_e, N_e,
                    x_i, vx_i, vy_i, vz_i, N_i,
                    sigma, e_idx,
                    F1, F2, PI, TWO_PI, E_MASS, AR_MASS,
                    E_EXC_TH, E_ION_TH, EV_TO_J,
                    NORMAL_DISTRIBUTION, E_ELA, E_EXC, E_ION
                )
                N_e_coll += 1
    else:
        if N_e == 0:
            return N_e, N_i, N_e_coll

        _find_colliding_electrons_parallel(
            vx_e, vy_e, vz_e, N_e,
            sigma_tot_e, DT_E, DE_CS, CS_RANGES, E_MASS, EV_TO_J,
            thread_coll_indices, thread_coll_counts, num_threads
        )

        for tid in range(num_threads):
            count = thread_coll_counts[tid]
            for c in range(count):
                k = thread_coll_indices[tid, c]
                v_sqr  = vx_e[k]**2 + vy_e[k]**2 + vz_e[k]**2
                energy = 0.5 * E_MASS * v_sqr / EV_TO_J
                e_idx  = min(int(energy / DE_CS + 0.5), CS_RANGES - 1)
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
                            thread_coll_indices, thread_coll_counts, null_coll_buffer, num_threads,
                            DT_I, DE_CS, CS_RANGES, AR_MASS, MU_ARAR, EV_TO_J,
                            NORMAL_DISTRIBUTION, PI, TWO_PI,
                            I_ISO, I_BACK,
                            t, N_SUB,
                            use_null_collision, nu_star_i, P_star_i):
    if t % N_SUB != 0:
        return 0

    N_i_coll = 0
    if use_null_collision:
        if N_i == 0:
            return N_i_coll
        N_coll_star = int(np.random.binomial(N_i, P_star_i))
        if N_coll_star > N_i:
            N_coll_star = N_i
        if N_coll_star == 0:
            return N_i_coll

        sample_indices_inplace(N_i, N_coll_star, null_coll_buffer)
        for idx in range(N_coll_star):
            k = null_coll_buffer[idx]
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
            real_nu = sigma_tot_i[e_idx] * g
            p_accept = real_nu / nu_star_i
            if p_accept > 1.0:
                p_accept = 1.0

            if np.random.uniform(0.0, 1.0) < p_accept:
                collision_ion(
                    k, vx_i, vy_i, vz_i,
                    vx_a, vy_a, vz_a,
                    sigma, e_idx,
                    PI, TWO_PI, I_ISO, I_BACK
                )
                N_i_coll += 1
    else:
        if N_i == 0:
            return N_i_coll

        _find_colliding_ions_parallel(
            vx_i, vy_i, vz_i, N_i,
            sigma_tot_i, DT_I, DE_CS, CS_RANGES, AR_MASS, MU_ARAR, EV_TO_J,
            NORMAL_DISTRIBUTION,
            thread_coll_indices, thread_coll_counts, num_threads
        )

        for tid in range(num_threads):
            count = thread_coll_counts[tid]
            for c in range(count):
                k = thread_coll_indices[tid, c]
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
                collision_ion(
                    k, vx_i, vy_i, vz_i,
                    vx_a, vy_a, vz_a,
                    sigma, e_idx,
                    PI, TWO_PI, I_ISO, I_BACK
                )
                N_i_coll += 1

    return N_i_coll


@numba.njit(parallel=True, cache=True)
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


import ctypes
import ctypes.util
from mpi4py import MPI

_lib_path = ctypes.util.find_library("mpi") or "libmpi.so.40"
_libmpi = ctypes.CDLL(_lib_path)

_MPI_Allreduce = _libmpi.MPI_Allreduce
_MPI_Allreduce.restype = ctypes.c_int
_MPI_Allreduce.argtypes = [
    ctypes.c_void_p,
    ctypes.c_void_p,
    ctypes.c_int,
    ctypes.c_void_p,
    ctypes.c_void_p,
    ctypes.c_void_p
]


def get_mpi_c_handles(comm=None):
    if comm is None:
        comm = MPI.COMM_WORLD
    comm_ptr = ctypes.c_void_p.from_address(MPI._addressof(comm)).value
    op_ptr   = ctypes.c_void_p.from_address(MPI._addressof(MPI.SUM)).value
    type_ptr = ctypes.c_void_p.from_address(MPI._addressof(MPI.DOUBLE)).value
    return comm_ptr, op_ptr, type_ptr


@numba.njit
def _mpi_allreduce_double_sum(sendbuf, recvbuf, count, comm_ptr, op_ptr, type_ptr):
    _MPI_Allreduce(
        sendbuf.ctypes.data,
        recvbuf.ctypes.data,
        count,
        type_ptr,
        op_ptr,
        comm_ptr
    )


@numba.njit
def _do_one_cycle_jit(
    x_e, vx_e, vy_e, vz_e, N_e,
    x_i, vx_i, vy_i, vz_i, N_i,
    e_density, i_density, global_e_density, global_i_density,
    cumul_e_density, cumul_i_density,
    local_e_density, local_i_density, rho, pot, efield,
    counter_e_xt, ue_xt, meanee_xt, ioniz_rate_xt, eepf,
    local_counter_e_xt, local_ue_xt, local_meanee_xt, local_ioniz_rate_xt,
    local_eepf, local_accu_center, local_counter_center,
    counter_i_xt, ui_xt, meanei_xt,
    local_counter_i_xt, local_ui_xt, local_meanei_xt,
    thread_coll_indices_e, thread_coll_counts_e,
    thread_coll_indices_i, thread_coll_counts_i,
    null_coll_buffer,
    ifed_pow, ifed_gnd, pot_xt, efield_xt, ne_xt, ni_xt,
    sigma, sigma_tot_e, sigma_tot_i,
    Time, cycle_number,
    N_e_abs_pow, N_e_abs_gnd, N_i_abs_pow, N_i_abs_gnd,
    N_e_coll, N_i_coll, mean_energy_accu_center, mean_energy_counter_center,
    measurement_mode, num_threads, nu_star_e, P_star_e, nu_star_i, P_star_i,
    comm_ptr, op_ptr, type_ptr,
    N_T, DT_E, N_BIN, INV_DX, FACTOR_W, N_G, N_SUB,
    E_CHARGE, VOLTAGE, OMEGA, A_p, B_p, C_p, ALPHA_p, S_p, DX_p, EPSILON0_p,
    FACTOR_E, E_MASS, EV_TO_J, DE_CS, DE_EEPF, N_EEPF, CS_RANGES, GAS_DENSITY, MIN_X, MAX_X, E_ION,
    FACTOR_I, DT_I, AR_MASS, DE_IFED, N_IFED,
    NORMAL_DISTRIBUTION, F1, F2, PI, TWO_PI, E_EXC_TH, E_ION_TH, E_ELA, E_EXC,
    MU_ARAR, I_ISO, I_BACK, USE_NULL_COLLISION, L_param
):
    for t in range(N_T):
        Time += DT_E
        t_index = t // N_BIN

        step1_compute_local_electron_density(
            x_e, N_e, local_e_density, e_density,
            INV_DX, FACTOR_W, N_G, num_threads
        )
        _mpi_allreduce_double_sum(
            e_density, global_e_density, N_G,
            comm_ptr, op_ptr, type_ptr
        )
        step1_finish_electron_density(global_e_density, cumul_e_density, N_G)

        if t % N_SUB == 0:
            step1_compute_local_ion_density(
                x_i, N_i, local_i_density, i_density,
                INV_DX, FACTOR_W, N_G, num_threads
            )
            _mpi_allreduce_double_sum(
                i_density, global_i_density, N_G,
                comm_ptr, op_ptr, type_ptr
            )
            step1_finish_ion_density(global_i_density, cumul_i_density, N_G)
        else:
            step1_accumulate_ion_density(global_i_density, cumul_i_density, N_G)

        for i in range(N_G):
            rho[i] = E_CHARGE * (global_i_density[i] - global_e_density[i])

        V0_cos = VOLTAGE * math.cos(OMEGA * Time)
        poisson._solve_poisson_jit(
            pot, efield, rho, V0_cos,
            A_p, B_p, C_p, ALPHA_p, S_p, INV_DX, DX_p, EPSILON0_p, N_G
        )

        accu, counter = step3_move_electrons(
            x_e, vx_e, vy_e, vz_e, N_e, efield,
            counter_e_xt, ue_xt, meanee_xt, ioniz_rate_xt, eepf, sigma,
            local_counter_e_xt, local_ue_xt, local_meanee_xt, local_ioniz_rate_xt,
            local_eepf, local_accu_center, local_counter_center,
            INV_DX, FACTOR_E, DT_E, N_G, E_MASS, EV_TO_J,
            DE_CS, DE_EEPF, N_EEPF, CS_RANGES, GAS_DENSITY,
            MIN_X, MAX_X, E_ION,
            t_index, measurement_mode, num_threads
        )
        if measurement_mode:
            mean_energy_accu_center += accu
            mean_energy_counter_center += counter

        step4_move_ions(
            x_i, vx_i, vy_i, vz_i, N_i, efield,
            counter_i_xt, ui_xt, meanei_xt,
            local_counter_i_xt, local_ui_xt, local_meanei_xt,
            INV_DX, FACTOR_I, DT_I, N_G, AR_MASS, EV_TO_J,
            t_index, measurement_mode, t, N_SUB, num_threads
        )

        N_e, abs_pow_e, abs_gnd_e = step5_check_boundaries_electrons(
            x_e, vx_e, vy_e, vz_e, N_e, L_param
        )
        N_e_abs_pow += abs_pow_e
        N_e_abs_gnd += abs_gnd_e

        N_i, abs_pow_i, abs_gnd_i = step6_check_boundaries_ions(
            x_i, vx_i, vy_i, vz_i, N_i, L_param,
            ifed_pow, ifed_gnd,
            AR_MASS, EV_TO_J, DE_IFED, N_IFED, t, N_SUB
        )
        N_i_abs_pow += abs_pow_i
        N_i_abs_gnd += abs_gnd_i

        N_e, N_i, coll_e = step7_collisions_electrons(
            x_e, vx_e, vy_e, vz_e, N_e,
            x_i, vx_i, vy_i, vz_i, N_i,
            sigma, sigma_tot_e,
            thread_coll_indices_e, thread_coll_counts_e, null_coll_buffer, num_threads,
            DT_E, DE_CS, CS_RANGES, E_MASS, EV_TO_J,
            NORMAL_DISTRIBUTION, F1, F2, PI, TWO_PI,
            E_EXC_TH, E_ION_TH, E_ELA, E_EXC, E_ION,
            AR_MASS,
            USE_NULL_COLLISION, nu_star_e, P_star_e
        )
        N_e_coll += coll_e

        coll_i = step8_collisions_ions(
            vx_i, vy_i, vz_i, N_i,
            sigma, sigma_tot_i,
            thread_coll_indices_i, thread_coll_counts_i, null_coll_buffer, num_threads,
            DT_I, DE_CS, CS_RANGES, AR_MASS, MU_ARAR, EV_TO_J,
            NORMAL_DISTRIBUTION, PI, TWO_PI, I_ISO, I_BACK,
            t, N_SUB,
            USE_NULL_COLLISION, nu_star_i, P_star_i
        )
        N_i_coll += coll_i

        step9_collect_xt_data(
            pot, efield, global_e_density, global_i_density,
            pot_xt, efield_xt, ne_xt, ni_xt,
            N_G, t_index, measurement_mode
        )

        if t % 1000 == 0:
            print(" c =", cycle_number, "  t =", t, "  #e (local) =", N_e, "  #i (local) =", N_i)

    return (
        N_e, N_i, Time,
        N_e_abs_pow, N_e_abs_gnd, N_i_abs_pow, N_i_abs_gnd,
        N_e_coll, N_i_coll,
        mean_energy_accu_center, mean_energy_counter_center
    )


def do_one_cycle(sim: SimulationState, datafile_path: str = "conv.dat"):
    """
    Executes a full RF cycle using JIT mega-kernel with ctypes MPI_Allreduce.
    """
    comm_ptr, op_ptr, type_ptr = get_mpi_c_handles(sim.comm)

    (
        sim.N_e, sim.N_i, sim.Time,
        sim.N_e_abs_pow, sim.N_e_abs_gnd, sim.N_i_abs_pow, sim.N_i_abs_gnd,
        sim.N_e_coll, sim.N_i_coll,
        sim.mean_energy_accu_center, sim.mean_energy_counter_center
    ) = _do_one_cycle_jit(
        sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e,
        sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i,
        sim.e_density, sim.i_density, sim.global_e_density, sim.global_i_density,
        sim.cumul_e_density, sim.cumul_i_density,
        sim.local_e_density, sim.local_i_density, sim.rho, sim.pot, sim.efield,
        sim.counter_e_xt, sim.ue_xt, sim.meanee_xt, sim.ioniz_rate_xt, sim.eepf,
        sim.local_counter_e_xt, sim.local_ue_xt, sim.local_meanee_xt, sim.local_ioniz_rate_xt,
        sim.local_eepf, sim.local_accu_center, sim.local_counter_center,
        sim.counter_i_xt, sim.ui_xt, sim.meanei_xt,
        sim.local_counter_i_xt, sim.local_ui_xt, sim.local_meanei_xt,
        sim.thread_coll_indices_e, sim.thread_coll_counts_e,
        sim.thread_coll_indices_i, sim.thread_coll_counts_i,
        sim.null_coll_buffer,
        sim.ifed_pow, sim.ifed_gnd, sim.pot_xt, sim.efield_xt, sim.ne_xt, sim.ni_xt,
        sim.sigma, sim.sigma_tot_e, sim.sigma_tot_i,
        sim.Time, sim.cycle,
        sim.N_e_abs_pow, sim.N_e_abs_gnd, sim.N_i_abs_pow, sim.N_i_abs_gnd,
        sim.N_e_coll, sim.N_i_coll, sim.mean_energy_accu_center, sim.mean_energy_counter_center,
        sim.measurement_mode, sim.num_threads, sim.nu_star_e, sim.P_star_e, sim.nu_star_i, sim.P_star_i,
        comm_ptr, op_ptr, type_ptr,
        cs.N_T, cs.DT_E, cs.N_BIN, cs.INV_DX, cs.FACTOR_W, cs.N_G, cs.N_SUB,
        cs.E_CHARGE, cs.VOLTAGE, cs.OMEGA, cs.A, cs.B, cs.C, cs.ALPHA, cs.S, cs.DX, cs.EPSILON0,
        cs.FACTOR_E, cs.E_MASS, cs.EV_TO_J, cs.DE_CS, cs.DE_EEPF, cs.N_EEPF, cs.CS_RANGES, cs.GAS_DENSITY, cs.MIN_X, cs.MAX_X, cs.E_ION,
        cs.FACTOR_I, cs.DT_I, cs.AR_MASS, cs.DE_IFED, cs.N_IFED,
        cs.NORMAL_DISTRIBUTION, cs.F1, cs.F2, cs.PI, cs.TWO_PI, cs.E_EXC_TH, cs.E_ION_TH, cs.E_ELA, cs.E_EXC,
        cs.MU_ARAR, cs.I_ISO, cs.I_BACK, cs.USE_NULL_COLLISION, cs.L
    )

    total_e = sim.comm.allreduce(sim.N_e, op=MPI.SUM)
    total_i = sim.comm.allreduce(sim.N_i, op=MPI.SUM)
    if sim.rank == 0:
        with open(datafile_path, "a") as f:
            f.write(f"{sim.cycle:8d}  {total_e:8d}  {total_i:8d}\n")

