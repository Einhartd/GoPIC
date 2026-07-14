import pytest
import math
from conftest import SimulationAdapter

@pytest.mark.parametrize("optimized_version", ["numpy_version", "numba_version"])
def test_compare_density_deposition(optimized_version):
    native = SimulationAdapter("native_version")
    opt    = SimulationAdapter(optimized_version)

    sim_nat = native.create_state()
    sim_opt = opt.create_state()
    cs = native.cs_mod

    # Wstrzyknij identyczne pozycje cząstek
    for sim in [sim_nat, sim_opt]:
        sim.N_e = 3
        sim.x_e[0] = cs.DX * 10.25
        sim.x_e[1] = cs.DX * 150.5
        sim.x_e[2] = cs.L - cs.DX * 0.75

    native.step1_compute_electron_density(sim_nat)
    opt.step1_compute_electron_density(sim_opt)

    print(f"\n[Test Roznicowy] Porownanie depozycji gestosci native_version vs {optimized_version}:")
    for idx in [10, 11, 150, 151, cs.N_G - 2, cs.N_G - 1]:
        val_nat = sim_nat.e_density[idx]
        val_opt = sim_opt.e_density[idx]
        print(f"  Wezel {idx:3d}: native = {val_nat:10.2e}, {optimized_version} = {val_opt:10.2e} (roznica = {abs(val_nat - val_opt):.2e})")

    for i in range(cs.N_G):
        assert math.isclose(sim_nat.e_density[i], sim_opt.e_density[i], abs_tol=1e-15)
