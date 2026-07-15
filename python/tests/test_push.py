import pytest
import math
from conftest import SimulationAdapter

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_particle_push_signs(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    sim.N_e = 1
    sim.x_e[0] = cs.L / 2.0
    sim.vx_e[0] = sim.vy_e[0] = sim.vz_e[0] = 0.0

    sim.N_i = 1
    sim.x_i[0] = cs.L / 2.0
    sim.vx_i[0] = sim.vy_i[0] = sim.vz_i[0] = 0.0

    for i in range(cs.N_G):
        sim.efield[i] = 1000.0

    adapter.step3_move_electrons(sim, 0)
    adapter.step4_move_ions(sim, 0, 0)  # t = 0 (subcycling)

    print(f"\n[{version}] Kierunki popychania czastek w polu E > 0:")
    print(f"  Elektron (u): vx = {sim.vx_e[0]:10.2e} m/s (powinien byc < 0)")
    print(f"  Jon (dodatni): vx = {sim.vx_i[0]:10.2e} m/s (powinien byc > 0)")

    assert sim.vx_e[0] < 0.0
    assert sim.vx_i[0] > 0.0

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_efield_interpolation_midpoint(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    sim.N_e = 1
    p0 = 200
    sim.x_e[0] = cs.DX * (p0 + 0.5)
    sim.vx_e[0] = 0.0
    sim.efield[p0] = 100.0
    sim.efield[p0 + 1] = 300.0

    adapter.step3_move_electrons(sim, 0)

    expected_v = -200.0 * cs.FACTOR_E
    expected_x = cs.DX * (p0 + 0.5) + expected_v * cs.DT_E

    print(f"\n[{version}] Interpolacja pola E w polowie komorki (wezel {p0} - {p0+1}):")
    print(f"  E_field w wezlach: E[{p0}] = {sim.efield[p0]} V/m, E[{p0+1}] = {sim.efield[p0+1]} V/m")
    print(f"  Elektron po popchnieciu: vx = {sim.vx_e[0]:10.2e} m/s (oczekiwane = {expected_v:10.2e})")
    print(f"  Elektron po popchnieciu: x  = {sim.x_e[0]:10.5f} m   (oczekiwane = {expected_x:10.5f})")

    assert math.isclose(sim.vx_e[0], expected_v, abs_tol=1e-5)
    assert math.isclose(sim.x_e[0], expected_x, abs_tol=1e-10)
