import numpy as np
import os
from core.state import SimulationState


def save_particle_data(state: SimulationState):
    """
    Saves particle coordinates and simulation progress to a binary file.
    Matches the binary format of the original eduPIC C++ code.
    """
    fname = "picdata.bin"
    with open(fname, "wb") as f:
        # Time [double]
        np.array([state.time], dtype=np.float64).tofile(f)
        # cycles_done [double]
        np.array([float(state.cycles_done)], dtype=np.float64).tofile(f)
        # N_e [double]
        np.array([float(state.n_e)], dtype=np.float64).tofile(f)
        # Electrons
        state.x_e[: state.n_e].tofile(f)
        state.vx_e[: state.n_e].tofile(f)
        state.vy_e[: state.n_e].tofile(f)
        state.vz_e[: state.n_e].tofile(f)
        # N_i [double]
        np.array([float(state.n_i)], dtype=np.float64).tofile(f)
        # Ions
        state.x_i[: state.n_i].tofile(f)
        state.vx_i[: state.n_i].tofile(f)
        state.vy_i[: state.n_i].tofile(f)
        state.vz_i[: state.n_i].tofile(f)
    print(
        f">> eduPIC: data saved : {state.n_e} electrons {state.n_i} ions, {state.cycles_done} cycles completed, time is {state.time:.4e} [s]"
    )


def load_particle_data(state: SimulationState):
    """
    Loads particle coordinates and simulation progress from a binary file.
    """
    fname = "picdata.bin"
    if not os.path.exists(fname):
        print(">> eduPIC: ERROR: No particle data file found!")
        return False

    with open(fname, "rb") as f:
        state.time = np.fromfile(f, dtype=np.float64, count=1)[0]
        state.cycles_done = int(np.fromfile(f, dtype=np.float64, count=1)[0])
        state.n_e = int(np.fromfile(f, dtype=np.float64, count=1)[0])
        state.x_e[: state.n_e] = np.fromfile(f, dtype=np.float64, count=state.n_e)
        state.vx_e[: state.n_e] = np.fromfile(f, dtype=np.float64, count=state.n_e)
        state.vy_e[: state.n_e] = np.fromfile(f, dtype=np.float64, count=state.n_e)
        state.vz_e[: state.n_e] = np.fromfile(f, dtype=np.float64, count=state.n_e)
        state.n_i = int(np.fromfile(f, dtype=np.float64, count=1)[0])
        state.x_i[: state.n_i] = np.fromfile(f, dtype=np.float64, count=state.n_i)
        state.vx_i[: state.n_i] = np.fromfile(f, dtype=np.float64, count=state.n_i)
        state.vy_i[: state.n_i] = np.fromfile(f, dtype=np.float64, count=state.n_i)
        state.vz_i[: state.n_i] = np.fromfile(f, dtype=np.float64, count=state.n_i)
    print(
        f">> eduPIC: data loaded : {state.n_e} electrons {state.n_i} ions, {state.cycles_done} cycles completed before, time is {state.time:.4e} [s]"
    )
    return True


def save_density(state: SimulationState, no_of_cycles: int):
    """
    Save density results to density.dat file.
    """
    cfg = state.cfg
    c = 1.0 / float(no_of_cycles) / float(cfg.sim.N_T)
    with open("density.dat", "w") as f:
        for m in range(cfg.sim.N_G):
            f.write(
                f"{m * cfg.DX:8.5f}  {state.cumul_e_density[m] * c:12e}  {state.cumul_i_density[m] * c:12e}\n"
            )


def save_eepf(state: SimulationState):
    """
    Save EEPF results to file eepf.dat.
    """
    cfg = state.cfg
    h = np.sum(state.eepf) * cfg.diag.DE_EEPF
    if h == 0:
        return
    with open("eepf.dat", "w") as f:
        for i in range(cfg.diag.N_EEPF):
            energy = (i + 0.5) * cfg.diag.DE_EEPF
            val = state.eepf[i] / h / np.sqrt(energy)
            f.write(f"{energy:e}  {val:e}\n")


def save_ifed(state: SimulationState):
    """
    Save IFED results to file ifed.dat.
    """
    cfg = state.cfg
    h_pow = np.sum(state.ifed_pow) * cfg.diag.DE_IFED
    h_gnd = np.sum(state.ifed_gnd) * cfg.diag.DE_IFED

    mean_i_energy_pow = 0.0
    mean_i_energy_gnd = 0.0

    with open("ifed.dat", "w") as f:
        for i in range(cfg.diag.N_IFED):
            energy = (i + 0.5) * cfg.diag.DE_IFED
            val_pow = state.ifed_pow[i] / h_pow if h_pow > 0 else 0.0
            val_gnd = state.ifed_gnd[i] / h_gnd if h_gnd > 0 else 0.0
            f.write(f"{energy:6.2f} {val_pow:10.6f} {val_gnd:10.6f}\n")
            mean_i_energy_pow += energy * val_pow
            mean_i_energy_gnd += energy * val_gnd

    return mean_i_energy_pow, mean_i_energy_gnd


def save_xt_data(state: SimulationState):
    """
    Save spatio-temporal distribution results to corresponding files.
    """
    files = {
        "pot_xt.dat": state.pot_xt,
        "efield_xt.dat": state.efield_xt,
        "ne_xt.dat": state.ne_xt,
        "ni_xt.dat": state.ni_xt,
        "je_xt.dat": state.je_xt,
        "ji_xt.dat": state.ji_xt,
        "powere_xt.dat": state.powere_xt,
        "poweri_xt.dat": state.poweri_xt,
        "meanee_xt.dat": state.meanee_xt,
        "meanei_xt.dat": state.meanei_xt,
        "ioniz_xt.dat": state.ioniz_rate_xt,
    }
    for fname, data in files.items():
        np.savetxt(fname, data, fmt="%e", delimiter="  ")
