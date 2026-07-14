import pytest
import math
from conftest import SimulationAdapter

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_single_particle_on_internal_node(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    p0 = 150
    sim.N_e = 1
    sim.x_e[0] = cs.DX * p0
    
    adapter.step1_compute_electron_density(sim)

    print(f"\n[{version}] Depozycja pojedynczej czastki w wezle {p0}:")
    print(f"  Wezel {p0-1:3d}: {sim.e_density[p0-1]:10.2e} (oczekiwana = 0.0)")
    print(f"  Wezel {p0:3d}: {sim.e_density[p0]:10.2e} (oczekiwana = {cs.FACTOR_W:10.2e})")
    print(f"  Wezel {p0+1:3d}: {sim.e_density[p0+1]:10.2e} (oczekiwana = 0.0)")

    assert math.isclose(sim.e_density[p0], cs.FACTOR_W, abs_tol=1e-2)
    assert math.isclose(sim.e_density[p0 + 1], 0.0, abs_tol=1e-2)
    assert math.isclose(sim.e_density[p0 - 1], 0.0, abs_tol=1e-2)

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_boundary_doubling_left(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    sim.N_e = 1
    sim.x_e[0] = cs.DX * 0.5
    
    adapter.step1_compute_electron_density(sim)

    print(f"\n[{version}] Korekcja brzegowa (lewa granica):")
    print(f"  Wezel 0: {sim.e_density[0]:10.2e} (oczekiwana = {cs.FACTOR_W:10.2e})")
    print(f"  Wezel 1: {sim.e_density[1]:10.2e} (oczekiwana = {0.5 * cs.FACTOR_W:10.2e})")

    assert math.isclose(sim.e_density[0], cs.FACTOR_W, abs_tol=1e-2)
    assert math.isclose(sim.e_density[1], 0.5 * cs.FACTOR_W, abs_tol=1e-2)

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_boundary_doubling_right(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    sim.N_e = 1
    sim.x_e[0] = cs.L - cs.DX * 0.25
    
    adapter.step1_compute_electron_density(sim)

    print(f"\n[{version}] Korekcja brzegowa (prawa granica):")
    print(f"  Wezel {cs.N_G-2:3d}: {sim.e_density[cs.N_G-2]:10.2e} (oczekiwana = {0.25 * cs.FACTOR_W:10.2e})")
    print(f"  Wezel {cs.N_G-1:3d}: {sim.e_density[cs.N_G-1]:10.2e} (oczekiwana = {1.50 * cs.FACTOR_W:10.2e})")

    assert math.isclose(sim.e_density[cs.N_G - 2], 0.25 * cs.FACTOR_W, abs_tol=1e-2)
    assert math.isclose(sim.e_density[cs.N_G - 1], 1.50 * cs.FACTOR_W, abs_tol=1e-2)
