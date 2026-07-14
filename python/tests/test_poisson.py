import pytest
import math
import numpy as np
from conftest import SimulationAdapter

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_vacuum_linear_potential(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    if version == "native_version":
        rho = [0.0] * cs.N_G
    else:
        rho = np.zeros(cs.N_G, dtype=np.float64)

    sim.Time = 0.0
    adapter.solve_poisson(sim, rho, sim.Time)

    print(f"\n[{version}] Liniowy potencjal prozniowy (wybrane punkty siatki):")
    for idx in [0, cs.N_G // 4, cs.N_G // 2, (3 * cs.N_G) // 4, cs.N_G - 1]:
        print(f"  Wezel {idx:3d}: obliczony = {sim.pot[idx]:10.5f} V")

    for i in range(cs.N_G):
        expected = cs.VOLTAGE * (1.0 - i / (cs.N_G - 1))
        assert math.isclose(sim.pot[i], expected, abs_tol=1e-11)


@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_vacuum_constant_efield(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    if version == "native_version":
        rho = [0.0] * cs.N_G
    else:
        rho = np.zeros(cs.N_G, dtype=np.float64)

    sim.Time = 0.0
    adapter.solve_poisson(sim, rho, sim.Time)
    expected_E = cs.VOLTAGE / cs.L

    print(f"\n[{version}] Stale pole elektryczne w prozni (wybrane punkty siatki):")
    for idx in [1, cs.N_G // 2, cs.N_G - 2]:
        print(f"  Wezel {idx:3d}: obliczone = {sim.efield[idx]:10.5f} V/m (oczekiwane = {expected_E:10.5f} V/m)")

    for i in range(1, cs.N_G - 1):
        assert math.isclose(sim.efield[i], expected_E, abs_tol=1e-8)

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_boundary_efield_with_charge(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    if version == "native_version":
        rho = [0.0] * cs.N_G
    else:
        rho = np.zeros(cs.N_G, dtype=np.float64)
    rho[0] = 1e15 * cs.E_CHARGE
    rho[cs.N_G - 1] = 2e15 * cs.E_CHARGE

    sim.Time = 0.0
    adapter.solve_poisson(sim, rho, sim.Time)

    expected_e0 = (sim.pot[0] - sim.pot[1]) * cs.INV_DX - rho[0] * cs.DX / (2.0 * cs.EPSILON0)
    expected_eN = (sim.pot[cs.N_G - 2] - sim.pot[cs.N_G - 1]) * cs.INV_DX + rho[cs.N_G - 1] * cs.DX / (2.0 * cs.EPSILON0)

    print(f"\n[{version}] Pole elektryczne na granicach z ladunkiem przestrzennym:")
    print(f"  Lewa elektroda (wezel 0): {sim.efield[0]:10.5f} V/m (oczekiwane = {expected_e0:10.5f} V/m)")
    print(f"  Prawa elektroda (wezel {cs.N_G - 1}): {sim.efield[cs.N_G - 1]:10.5f} V/m (oczekiwane = {expected_eN:10.5f} V/m)")

    assert math.isclose(sim.efield[0], expected_e0, abs_tol=1e-8)
    assert math.isclose(sim.efield[cs.N_G - 1], expected_eN, abs_tol=1e-8)