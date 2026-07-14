import pytest
import math
from conftest import SimulationAdapter

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_phelps_cross_sections(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    adapter.setup_cross_sections(sim)

    idx_50 = int(50.0 / cs.DE_CS)
    total_macro = (sim.sigma[cs.E_ELA][idx_50] + sim.sigma[cs.E_EXC][idx_50] + sim.sigma[cs.E_ION][idx_50]) * cs.GAS_DENSITY

    print(f"\n[{version}] Przekroje czynne zderzen elektronow dla energii 50.0 eV:")
    print(f"  Elastyczne (sigma[E_ELA]): {sim.sigma[cs.E_ELA][idx_50]:10.2e} m^2")
    print(f"  Wzbudzenie (sigma[E_EXC]): {sim.sigma[cs.E_EXC][idx_50]:10.2e} m^2")
    print(f"  Jonizacja  (sigma[E_ION]): {sim.sigma[cs.E_ION][idx_50]:10.2e} m^2")
    print(f"  Suma makroskopowa total_e: {sim.sigma_tot_e[idx_50]:10.5f} 1/m (oczekiwana = {total_macro:10.5f} 1/m)")

    assert math.isclose(sim.sigma_tot_e[idx_50], total_macro, rel_tol=1e-7)
