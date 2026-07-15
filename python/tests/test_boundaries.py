import pytest
import math
from conftest import SimulationAdapter

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_fast_swap_boundary(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    sim.N_e = 3
    sim.x_e[0] = cs.L * 0.25;  sim.vx_e[0] = 10.0
    sim.x_e[1] = -0.001;    sim.vx_e[1] = 20.0
    sim.x_e[2] = cs.L * 0.75;  sim.vx_e[2] = 30.0

    adapter.step5_check_boundaries_electrons(sim)

    print(f"\n[{version}] Usuwanie czastek metoda fast-swap (lub boolean mask):")
    print(f"  Poczatkowa liczba czastek = 3, koncowa = {sim.N_e} (oczekiwana = 2)")
    print(f"  Liczba zaabsorbowanych elektronow = {sim.N_e_abs_pow} (oczekiwana = 1)")
    print(f"  Nowa czastka pod indeksem 1: x = {sim.x_e[1]:10.5f} m, vx = {sim.vx_e[1]:10.2f} m/s")

    assert sim.N_e == 2
    assert sim.N_e_abs_pow == 1
    assert math.isclose(sim.x_e[1], cs.L * 0.75, abs_tol=1e-12)
    assert math.isclose(sim.vx_e[1], 30.0, abs_tol=1e-12)

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_ion_flux_energy_distribution(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    sim.N_i = 1
    sim.x_i[0] = cs.L + 0.001

    target_energy_eV = 50.5
    v_x = math.sqrt(2.0 * target_energy_eV * cs.E_CHARGE / cs.AR_MASS)
    sim.vx_i[0] = v_x
    sim.vy_i[0] = 0.0
    sim.vz_i[0] = 0.0

    adapter.step6_check_boundaries_ions(sim, 0)

    print(f"\n[{version}] Rozklad energii strumienia jonow (IFED) na uziemionej elektrodzie:")
    print(f"  Jon zaabsorbowany: N_i_abs_gnd = {sim.N_i_abs_gnd} (oczekiwana = 1)")
    print(f"  Bin 50 (50-51 eV) w IFED: {sim.ifed_gnd[50]} (oczekiwana = 1)")
    print(f"  Bin 51 (51-52 eV) w IFED: {sim.ifed_gnd[51]} (oczekiwana = 0)")

    assert sim.N_i == 0
    assert sim.N_i_abs_gnd == 1
    assert sim.ifed_gnd[50] == 1
    assert sim.ifed_gnd[51] == 0
