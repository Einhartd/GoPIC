import pytest
import math
import importlib
from conftest import SimulationAdapter

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_null_collision_precomputation(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod
    collisions = importlib.import_module("collisions")

    adapter.setup_cross_sections(sim)

    # Uruchamiamy obliczenie parametrów Null-Collision
    collisions.compute_null_collision_params(sim)

    # 1. Sprawdzamy, czy maksymalne częstości kolizji są dodatnie
    assert sim.nu_star_e > 0.0
    assert sim.nu_star_i > 0.0

    # 2. Sprawdzamy, czy prawdopodobieństwa są w zakresie [0, 1]
    assert 0.0 <= sim.P_star_e <= 1.0
    assert 0.0 <= sim.P_star_i <= 1.0

    # 3. Sprawdzamy warunek stabilności fizycznej (prawdopodobieństwo < 5%)
    assert sim.P_star_e < 0.05
    assert sim.P_star_i < 0.05

    # 4. Weryfikujemy, czy nu_star_e jest rzeczywiście górnym ograniczeniem częstości kolizji
    for i in range(cs.CS_RANGES):
        e = cs.DE_CS if i == 0 else i * cs.DE_CS
        v = math.sqrt(2.0 * e * cs.EV_TO_J / cs.E_MASS)
        nu = sim.sigma_tot_e[i] * v
        assert nu <= sim.nu_star_e + 1e-9

    # 5. Weryfikujemy, czy nu_star_i jest rzeczywiście górnym ograniczeniem częstości kolizji
    for i in range(cs.CS_RANGES):
        e = cs.DE_CS if i == 0 else i * cs.DE_CS
        g = math.sqrt(2.0 * e * cs.EV_TO_J / cs.MU_ARAR)
        nu = sim.sigma_tot_i[i] * g
        assert nu <= sim.nu_star_i + 1e-9
