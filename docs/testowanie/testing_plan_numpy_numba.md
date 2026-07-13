# Plan testów — wersja NumPy i Numba

Pliki źródłowe:
- [`python/numpy_version/`](../../python/numpy_version/) — implementacja NumPy (wektorowa)
- [`python/numba_version/`](../../python/numba_version/) — implementacja Numba (JIT-kompilowana)

Framework: [pytest](https://pytest.org) + [numpy.testing](https://numpy.org/doc/stable/reference/routines.testing.html)

> **Relacja z planem dla wersji native:** Testy weryfikują te same właściwości fizyczne
> co w [`testing_plan_python.md`](testing_plan_python.md). Dodane tu są sekcje
> specyficzne dla NumPy (`np.add.at`, widoki) i Numba (warmup JIT, przekazywanie tablic).

---

## Spis treści

1. [Architektura testów](#1-architektura-testów)
2. [Konfiguracja środowiska](#2-konfiguracja-środowiska)
3. [Testy regresyjne (golden run)](#3-testy-regresyjne-golden-run)
4. [Testy jednostkowe — Tier 1 (deterministyczne)](#4-testy-jednostkowe--tier-1-deterministyczne)
5. [Testy specyficzne dla NumPy](#5-testy-specyficzne-dla-numpy)
6. [Testy specyficzne dla Numba](#6-testy-specyficzne-dla-numba)
7. [Testy cross-version (NumPy vs Numba vs Native)](#7-testy-cross-version-numpy-vs-numba-vs-native)
8. [Uruchamianie testów](#8-uruchamianie-testów)
9. [Checklist](#9-checklist)

---

## 1. Architektura testów

### Struktura katalogów

```
python/
├── numpy_version/
│   └── tests/
│       ├── __init__.py
│       ├── conftest.py               ← fixtures z np.ndarray, seeded rng
│       ├── test_poisson_np.py
│       ├── test_density_np.py        ← zawiera test np.add.at i widoków
│       ├── test_push_np.py
│       ├── test_boundaries_np.py     ← boolean masking zamiast swap
│       ├── test_collisions_np.py
│       └── test_regression_np.py
│
└── numba_version/
    └── tests/
        ├── __init__.py
        ├── conftest.py               ← fixtures z raw arrays (bez SimulationState)
        ├── test_poisson_nb.py
        ├── test_density_nb.py        ← test prange / race condition
        ├── test_push_nb.py
        ├── test_boundaries_nb.py
        ├── test_collisions_nb.py
        └── test_regression_nb.py
```

### Kluczowe różnice architektoniczne

| Aspekt | NumPy | Numba |
|:-------|:------|:------|
| Funkcje przyjmują | `SimulationState` | Surowe `np.ndarray` (przez wartość) |
| Inicjalizacja | `__init__` normalny | Wymaga warmup JIT przed pierwszym testem |
| Losowość | `np.random.default_rng(seed)` | `np.random.default_rng(seed)` (te same seedy) |
| Scatter-add | `np.add.at(arr, idx, val)` | `arr[p] += val` (bezpieczne dzięki `parallel=False`) |
| Granice | boolean masking + filter | pętla while + swap (jak native) |

---

## 2. Konfiguracja środowiska

```bash
# NumPy version
cd python/numpy_version
pip install pytest pytest-cov numpy scipy
pytest tests/ -v

# Numba version
cd python/numba_version
pip install pytest pytest-cov numpy numba scipy
pytest tests/ -v

# Wspólne: z raportem pokrycia
pytest tests/ -v --cov=. --cov-report=html

# Uwaga Numba: pierwsze uruchomienie wolne (kompilacja JIT).
# Kolejne używają cache — przyspieszone.
```

---

## 3. Testy regresyjne (golden run)

### 3.1 `conftest.py` — NumPy

```python
# python/numpy_version/tests/conftest.py
import pytest, sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from state import SimulationState
import constants as cs
from cross_sections import (set_electron_cross_sections_ar,
                             set_ion_cross_sections_ar,
                             calc_total_cross_sections)

@pytest.fixture
def sim():
    """Świeży stan symulacji z deterministycznym RNG."""
    s = SimulationState()
    set_electron_cross_sections_ar(s)
    set_ion_cross_sections_ar(s)
    calc_total_cross_sections(s)
    s.rng = np.random.default_rng(42)  # ← seed dla reprodukowalności
    return s

@pytest.fixture
def sim_with_uniform_efield(sim):
    sim.efield[:] = 1000.0   # przypisanie wektorowe (nie pętla!)
    return sim
```

### 3.2 `conftest.py` — Numba

```python
# python/numba_version/tests/conftest.py
import pytest, sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

import constants as cs
from state import SimulationState
from cross_sections import (set_electron_cross_sections_ar,
                             set_ion_cross_sections_ar,
                             calc_total_cross_sections)

@pytest.fixture(scope="session", autouse=True)
def warmup_numba():
    """
    Uruchamia każdą funkcję @njit raz z małymi danymi PRZED testami.
    Bez tego pierwsze wywołanie w teście jest wolne (kompilacja JIT)
    i może przekroczyć limit czasu pytest.
    """
    s = SimulationState()
    set_electron_cross_sections_ar(s)
    set_ion_cross_sections_ar(s)
    calc_total_cross_sections(s)
    # Jeden mini-krok dla każdej skompilowanej funkcji
    from simulation import (step1_compute_electron_density,
                             step1_compute_ion_density,
                             step3_move_electrons)
    s.x_e[0] = cs.L / 2; s.N_e = 1
    step1_compute_electron_density(
        s.x_e, s.N_e, s.e_density, s.cumul_e_density,
        cs.INV_DX, cs.FACTOR_W, cs.N_G
    )
    # ... warmup pozostałych funkcji ...

@pytest.fixture
def sim():
    """Świeży stan symulacji dla Numba — z raw arrays gotowymi do @njit."""
    s = SimulationState()
    set_electron_cross_sections_ar(s)
    set_ion_cross_sections_ar(s)
    calc_total_cross_sections(s)
    return s

@pytest.fixture
def sim_with_uniform_efield(sim):
    sim.efield[:] = 1000.0
    return sim
```

### 3.3 Testy regresyjne

```python
# tests/test_regression_np.py  (i analogicznie test_regression_nb.py)
import numpy as np
import subprocess, os, pytest

GOLDEN_DIR = os.path.join(os.path.dirname(__file__), 'golden')
MAIN       = os.path.join(os.path.dirname(__file__), '..', 'main.py')


def run_sim(*args):
    res = subprocess.run(['python', MAIN, *map(str, args)],
                         capture_output=True, text=True)
    assert res.returncode == 0, res.stderr
    return res


def cmp(file, golden, rtol=1e-8):
    np.testing.assert_allclose(
        np.loadtxt(file), np.loadtxt(golden),
        rtol=rtol, atol=1e-30
    )


class TestGoldenRegression:

    def test_density_unchanged(self, tmp_path, monkeypatch):
        monkeypatch.chdir(tmp_path)
        run_sim(0); run_sim(5)
        cmp('density.dat', f'{GOLDEN_DIR}/density_golden.dat')

    def test_conv_unchanged(self, tmp_path, monkeypatch):
        monkeypatch.chdir(tmp_path)
        run_sim(0); run_sim(5)
        cmp('conv.dat', f'{GOLDEN_DIR}/conv_golden.dat')

    def test_eepf_unchanged(self, tmp_path, monkeypatch):
        monkeypatch.chdir(tmp_path)
        run_sim(0); run_sim(5, 'm')
        cmp('eepf.dat', f'{GOLDEN_DIR}/eepf_golden.dat', rtol=1e-6)

    def test_particle_count_stable(self, tmp_path, monkeypatch):
        monkeypatch.chdir(tmp_path)
        run_sim(0); run_sim(5)
        with open('conv.dat') as f:
            last = f.readlines()[-1].split()
        n_e, n_i = int(last[1]), int(last[2])
        assert 100 < n_e < 1_000_000
        assert 100 < n_i < 1_000_000
```

---

## 4. Testy jednostkowe — Tier 1 (deterministyczne)

Testy fizyczne są identyczne dla NumPy i Numba — różni się tylko sposób wywołania funkcji.
Poniżej pokazano **obie sygnatury** obok siebie.

### 4.1 `solve_poisson`

```python
# test_poisson_np.py
import numpy as np
import pytest
import constants as cs
from poisson import solve_poisson

class TestPoissonSolverNumPy:

    def test_vacuum_linear_potential(self, sim):
        rho = np.zeros(cs.N_G)
        solve_poisson(sim, rho, tt=0.0)
        for i in range(1, cs.N_G - 1):
            expected = cs.VOLTAGE * (1.0 - i / (cs.N_G - 1))
            assert abs(sim.pot[i] - expected) < 1e-8

    def test_vacuum_constant_efield(self, sim):
        rho = np.zeros(cs.N_G)
        solve_poisson(sim, rho, tt=0.0)
        E_exp = cs.VOLTAGE / cs.L
        # Użyj np.testing zamiast pętli:
        np.testing.assert_allclose(
            sim.efield[1:-2], E_exp,
            rtol=1e-6, err_msg="E-pole musi być stałe w próżni"
        )

    def test_boundary_conditions(self, sim):
        rho = np.zeros(cs.N_G)
        for tt in [0.0, cs.PERIOD / 4, cs.PERIOD / 2]:
            solve_poisson(sim, rho, tt=tt)
            assert abs(sim.pot[0]      - cs.VOLTAGE * np.cos(cs.OMEGA * tt)) < 1e-10
            assert abs(sim.pot[cs.N_G-1] - 0.0)                              < 1e-10

    def test_midpoint_potential(self, sim):
        rho = np.zeros(cs.N_G)
        solve_poisson(sim, rho, tt=0.0)
        assert abs(sim.pot[cs.N_G // 2] - cs.VOLTAGE * 0.5) < 1.0

    def test_boundary_efield_with_charge(self, sim):
        rho = np.zeros(cs.N_G)
        rho[0] = rho[-1] = 1e15 * cs.E_CHARGE
        solve_poisson(sim, rho, tt=0.0)
        expected_e0 = ((sim.pot[0] - sim.pot[1]) * cs.INV_DX
                       - rho[0] * cs.DX / (2.0 * cs.EPSILON0))
        assert abs(sim.efield[0] - expected_e0) < 1e-6
```

```python
# test_poisson_nb.py — Numba: identyczne testy, różna sygnatura poisson
import numpy as np
import constants as cs
from poisson import solve_poisson   # Numba poisson przyjmuje te same argumenty

class TestPoissonSolverNumba:
    # IDENTYCZNE testy jak NumPy — solve_poisson ma taką samą sygnaturę
    # (Numba version poisson.py opakowuje @njit wewnątrz, API jest takie samo)

    def test_vacuum_linear_potential(self, sim):
        rho = np.zeros(cs.N_G)
        solve_poisson(sim, rho, tt=0.0)
        for i in range(1, cs.N_G - 1):
            expected = cs.VOLTAGE * (1.0 - i / (cs.N_G - 1))
            assert abs(sim.pot[i] - expected) < 1e-8

    # ... (pozostałe testy identyczne jak NumPy)
```

---

### 4.2 `step1_compute_electron_density`

```python
# test_density_np.py
import numpy as np
import constants as cs
from simulation import step1_compute_electron_density, step1_compute_ion_density

class TestElectronDensityNumPy:

    def test_single_particle_on_node(self, sim):
        p0 = 100
        sim.x_e[0] = cs.DX * p0
        sim.N_e = 1
        step1_compute_electron_density(sim)
        assert abs(sim.e_density[p0]     - cs.FACTOR_W) < 1e-10
        assert abs(sim.e_density[p0 + 1] - 0.0)         < 1e-10
        assert abs(sim.e_density[p0 - 1] - 0.0)         < 1e-10

    def test_single_particle_midpoint(self, sim):
        p0 = 100
        sim.x_e[0] = cs.DX * (p0 + 0.5)
        sim.N_e = 1
        step1_compute_electron_density(sim)
        np.testing.assert_allclose(sim.e_density[p0],     0.5 * cs.FACTOR_W, rtol=1e-10)
        np.testing.assert_allclose(sim.e_density[p0 + 1], 0.5 * cs.FACTOR_W, rtol=1e-10)

    def test_mass_conservation(self, sim):
        sim.N_e = 50
        sim.x_e[:50] = np.linspace(cs.DX, cs.L - cs.DX, 50)
        step1_compute_electron_density(sim)
        total = np.sum(sim.e_density) * cs.DX * cs.ELECTRODE_AREA
        expected = sim.N_e * cs.WEIGHT
        assert abs(total - expected) / expected < 0.01

    def test_boundary_doubling_left(self, sim):
        sim.x_e[0] = cs.DX * 0.5
        sim.N_e = 1
        step1_compute_electron_density(sim)
        assert abs(sim.e_density[0] - cs.FACTOR_W)           < 1e-10
        assert abs(sim.e_density[1] - 0.5 * cs.FACTOR_W)     < 1e-10

    def test_boundary_doubling_right(self, sim):
        sim.x_e[0] = cs.L - cs.DX * 0.5
        sim.N_e = 1
        step1_compute_electron_density(sim)
        assert abs(sim.e_density[cs.N_G - 1] - cs.FACTOR_W)       < 1e-10
        assert abs(sim.e_density[cs.N_G - 2] - 0.5 * cs.FACTOR_W) < 1e-10

    def test_cumulative_density_accumulation(self, sim):
        sim.x_e[0] = cs.L / 2.0
        sim.N_e = 1
        step1_compute_electron_density(sim)
        c1 = sim.cumul_e_density[cs.N_G // 2]
        step1_compute_electron_density(sim)
        c2 = sim.cumul_e_density[cs.N_G // 2]
        np.testing.assert_allclose(c2, 2.0 * c1, rtol=1e-10)

    def test_zeroing_is_inplace(self, sim):
        """
        NumPy-specific: density[:] = 0.0 musi zerować in-place (nie tworzyć nowej tablicy).
        Sprawdzamy przez trzymanie referencji do oryginalnej tablicy.
        """
        original_ref = sim.e_density
        sim.x_e[0] = cs.L / 2.0; sim.N_e = 1
        step1_compute_electron_density(sim)
        assert sim.e_density is original_ref, \
            "step1 nie może zastąpić sim.e_density nową tablicą!"


class TestIonDensityNumPy:

    def test_subcycling_guard(self, sim):
        sim.x_i[0] = cs.L / 2.0; sim.N_i = 1
        step1_compute_ion_density(sim, t=1)
        assert sim.i_density[cs.N_G // 2] == 0.0

    def test_subcycling_executes_at_t0(self, sim):
        sim.x_i[0] = cs.L / 2.0; sim.N_i = 1
        step1_compute_ion_density(sim, t=0)
        assert sim.i_density[cs.N_G // 2] > 0.0

    def test_cumul_ion_density_every_step(self, sim):
        """cumul_i_density musi rosnąć nawet gdy t%N_SUB != 0 (zachowanie C++)."""
        sim.x_i[0] = cs.L / 2.0; sim.N_i = 1
        step1_compute_ion_density(sim, t=0)
        c0 = float(sim.cumul_i_density[cs.N_G // 2])
        step1_compute_ion_density(sim, t=1)   # t%N_SUB != 0
        c1 = float(sim.cumul_i_density[cs.N_G // 2])
        assert c1 > c0, "cumul_i_density musi rosnąć nawet bez subcyclingu"
```

```python
# test_density_nb.py — Numba: raw arrays jako argumenty
import numpy as np
import constants as cs
from simulation import step1_compute_electron_density, step1_compute_ion_density

class TestElectronDensityNumba:

    def _call(self, sim):
        """Helper: przekaż raw arrays do @njit."""
        step1_compute_electron_density(
            sim.x_e, sim.N_e, sim.e_density, sim.cumul_e_density,
            cs.INV_DX, cs.FACTOR_W, cs.N_G
        )

    def test_single_particle_on_node(self, sim):
        p0 = 100
        sim.x_e[0] = cs.DX * p0; sim.N_e = 1
        self._call(sim)
        assert abs(sim.e_density[p0]     - cs.FACTOR_W) < 1e-10
        assert abs(sim.e_density[p0 + 1] - 0.0)         < 1e-10

    def test_single_particle_midpoint(self, sim):
        p0 = 100
        sim.x_e[0] = cs.DX * (p0 + 0.5); sim.N_e = 1
        self._call(sim)
        np.testing.assert_allclose(sim.e_density[p0],     0.5 * cs.FACTOR_W, rtol=1e-10)
        np.testing.assert_allclose(sim.e_density[p0 + 1], 0.5 * cs.FACTOR_W, rtol=1e-10)

    def test_boundary_doubling_left(self, sim):
        sim.x_e[0] = cs.DX * 0.5; sim.N_e = 1
        self._call(sim)
        assert abs(sim.e_density[0] - cs.FACTOR_W)       < 1e-10

    def test_boundary_doubling_right(self, sim):
        sim.x_e[0] = cs.L - cs.DX * 0.5; sim.N_e = 1
        self._call(sim)
        assert abs(sim.e_density[cs.N_G - 1] - cs.FACTOR_W) < 1e-10

    def test_cumulative_density_accumulation(self, sim):
        sim.x_e[0] = cs.L / 2.0; sim.N_e = 1
        self._call(sim)
        c1 = float(sim.cumul_e_density[cs.N_G // 2])
        self._call(sim)
        c2 = float(sim.cumul_e_density[cs.N_G // 2])
        np.testing.assert_allclose(c2, 2.0 * c1, rtol=1e-10)
```

---

### 4.3 Push cząstek

```python
# test_push_np.py
import numpy as np
import constants as cs
from simulation import step3_move_electrons, step4_move_ions

class TestElectronPushNumPy:

    def test_electron_push_sign_positive_field(self, sim):
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0
        sim.vx_e[0] = sim.vy_e[0] = sim.vz_e[0] = 0.0
        sim.efield[:] = 1000.0
        step3_move_electrons(sim, t_index=0)
        assert sim.vx_e[0] < 0.0, f"Elektron w E>0 musi mieć vx<0, got {sim.vx_e[0]}"

    def test_electron_push_sign_negative_field(self, sim):
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0; sim.vx_e[0] = 0.0
        sim.efield[:] = -1000.0
        step3_move_electrons(sim, t_index=0)
        assert sim.vx_e[0] > 0.0

    def test_electron_acceleration_magnitude(self, sim):
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0; sim.vx_e[0] = 0.0
        sim.efield[:] = 1000.0
        step3_move_electrons(sim, t_index=0)
        np.testing.assert_allclose(sim.vx_e[0], -1000.0 * cs.FACTOR_E, rtol=1e-10)

    def test_free_streaming(self, sim):
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0; sim.vx_e[0] = 1e5
        sim.efield[:] = 0.0
        x_before = sim.x_e[0]
        step3_move_electrons(sim, t_index=0)
        np.testing.assert_allclose(sim.x_e[0],  x_before + 1e5 * cs.DT_E, rtol=1e-12)
        np.testing.assert_allclose(sim.vx_e[0], 1e5,                        rtol=1e-12)

    def test_efield_interpolation_midpoint(self, sim):
        p0 = 100
        sim.N_e = 1
        sim.x_e[0] = cs.DX * (p0 + 0.5); sim.vx_e[0] = 0.0
        sim.efield[:] = 0.0
        sim.efield[p0] = 200.0; sim.efield[p0 + 1] = 400.0
        step3_move_electrons(sim, t_index=0)
        # e_x = 0.5*200 + 0.5*400 = 300
        np.testing.assert_allclose(sim.vx_e[0], -300.0 * cs.FACTOR_E, rtol=1e-10)

    def test_push_modifies_sim_arrays_inplace(self, sim):
        """NumPy-specific: widoki muszą modyfikować sim.vx_e, nie kopię."""
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0; sim.vx_e[0] = 0.0
        sim.efield[:] = 1000.0
        vx_ref = sim.vx_e   # referencja do tablicy
        step3_move_electrons(sim, t_index=0)
        assert vx_ref[0] != 0.0, \
            "step3 musi modyfikować sim.vx_e in-place przez widok, nie kopię!"


class TestIonPushNumPy:

    def test_ion_push_sign_positive_field(self, sim):
        sim.N_i = 1
        sim.x_i[0] = cs.L / 2.0; sim.vx_i[0] = 0.0
        sim.efield[:] = 1000.0
        step4_move_ions(sim, t_index=0, t=0)
        assert sim.vx_i[0] > 0.0, f"Jon w E>0 musi mieć vx>0, got {sim.vx_i[0]}"

    def test_ion_subcycling_guard(self, sim):
        sim.N_i = 1
        sim.x_i[0] = cs.L / 2.0; sim.vx_i[0] = 0.0
        sim.efield[:] = 1000.0
        step4_move_ions(sim, t_index=0, t=1)
        assert sim.vx_i[0] == 0.0
```

```python
# test_push_nb.py — Numba: raw arrays
import numpy as np
import constants as cs
from simulation import step3_move_electrons, step4_move_ions

class TestElectronPushNumba:

    def _call_e(self, sim, t_index=0):
        step3_move_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, sim.efield,
            sim.counter_e_xt, sim.ue_xt, sim.meanee_xt, sim.ioniz_rate_xt,
            sim.eepf, sim.sigma,
            cs.INV_DX, cs.FACTOR_E, cs.DT_E, cs.N_G,
            cs.E_MASS, cs.EV_TO_J, cs.DE_CS, cs.DE_EEPF, cs.N_EEPF,
            cs.CS_RANGES, cs.GAS_DENSITY, cs.MIN_X, cs.MAX_X, cs.E_ION,
            t_index, False  # measurement_mode=False
        )

    def test_electron_push_sign_positive_field(self, sim):
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0; sim.vx_e[0] = 0.0
        sim.efield[:] = 1000.0
        self._call_e(sim)
        assert sim.vx_e[0] < 0.0

    def test_electron_acceleration_magnitude(self, sim):
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0; sim.vx_e[0] = 0.0
        sim.efield[:] = 1000.0
        self._call_e(sim)
        np.testing.assert_allclose(sim.vx_e[0], -1000.0 * cs.FACTOR_E, rtol=1e-10)

    def test_free_streaming(self, sim):
        sim.N_e = 1
        sim.x_e[0] = cs.L / 2.0; sim.vx_e[0] = 1e5
        sim.efield[:] = 0.0
        x_before = sim.x_e[0]
        self._call_e(sim)
        np.testing.assert_allclose(sim.x_e[0], x_before + 1e5 * cs.DT_E, rtol=1e-12)
```

---

### 4.4 Warunki brzegowe

```python
# test_boundaries_np.py
import numpy as np
import constants as cs
from simulation import step5_check_boundaries_electrons, step6_check_boundaries_ions

class TestElectronBoundariesNumPy:

    def test_electron_absorbed_at_powered(self, sim):
        sim.N_e = 1; sim.x_e[0] = -0.001
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 0
        assert sim.N_e_abs_pow == 1

    def test_electron_absorbed_at_grounded(self, sim):
        sim.N_e = 1; sim.x_e[0] = cs.L + 0.001
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 0
        assert sim.N_e_abs_gnd == 1

    def test_electron_inside_not_removed(self, sim):
        sim.N_e = 1; sim.x_e[0] = cs.L / 2.0
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 1

    def test_multiple_absorbed_count(self, sim):
        """NumPy boolean masking: np.sum(mask) musi poprawnie zliczyć."""
        sim.N_e = 10
        sim.x_e[:5] = -0.001          # 5 przez lewą
        sim.x_e[5:10] = cs.L + 0.001  # 5 przez prawą
        for i in range(10):
            sim.vx_e[i] = sim.vy_e[i] = sim.vz_e[i] = 0.0
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 0
        assert sim.N_e_abs_pow == 5
        assert sim.N_e_abs_gnd == 5

    def test_filter_preserves_inside_particles(self, sim):
        """
        NumPy-specific: filtrowanie przez boolean mask musi zachować cząstki wewnętrzne
        (kolejność może się zmienić względem natywnej wersji — to OK).
        """
        sim.N_e = 3
        sim.x_e[0]  = -0.001         # wychodzi
        sim.x_e[1]  = cs.L * 0.25    # zostaje, vx=100
        sim.x_e[2]  = cs.L * 0.75    # zostaje, vx=300
        sim.vx_e[0] = 999.0; sim.vx_e[1] = 100.0; sim.vx_e[2] = 300.0
        for i in range(3):
            sim.vy_e[i] = sim.vz_e[i] = 0.0

        step5_check_boundaries_electrons(sim)

        assert sim.N_e == 2
        # Sprawdź że obie pozostałe prędkości są zachowane (w dowolnej kolejności)
        remaining_vx = sorted([sim.vx_e[0], sim.vx_e[1]])
        assert remaining_vx == [100.0, 300.0]

    def test_all_electrons_absorbed(self, sim):
        sim.N_e = 10
        sim.x_e[:10] = -0.001
        for i in range(10):
            sim.vx_e[i] = sim.vy_e[i] = sim.vz_e[i] = 0.0
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 0


class TestIonBoundariesNumPy:

    def test_ifed_vectorized_powered(self, sim):
        """NumPy: IFED musi być wypełnione wektorowo przez np.add.at."""
        sim.N_i = 3
        sim.x_i[:3] = -0.001
        # Różne prędkości → różne biny IFED
        for k, vx in enumerate([500.0, 1000.0, 2000.0]):
            sim.vx_i[k] = vx
            sim.vy_i[k] = sim.vz_i[k] = 0.0
        step6_check_boundaries_ions(sim, t=0)
        assert sim.N_i == 0
        assert sim.N_i_abs_pow == 3
        # Suma IFED musi odpowiadać 3 pochłoniętym jonom
        assert np.sum(sim.ifed_pow) == 3

    def test_ion_subcycling_boundary(self, sim):
        sim.N_i = 1; sim.x_i[0] = -0.001
        step6_check_boundaries_ions(sim, t=1)
        assert sim.N_i == 1
```

```python
# test_boundaries_nb.py — Numba: swap zamiast boolean masking
import numpy as np
import constants as cs
from simulation import step5_check_boundaries_electrons, step6_check_boundaries_ions

class TestElectronBoundariesNumba:

    def _call_e(self, sim):
        n_pow, n_gnd, new_N_e = step5_check_boundaries_electrons(
            sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e
        )
        sim.N_e_abs_pow += n_pow
        sim.N_e_abs_gnd += n_gnd
        sim.N_e = new_N_e

    def test_electron_absorbed_at_powered(self, sim):
        sim.N_e = 1; sim.x_e[0] = -0.001
        self._call_e(sim)
        assert sim.N_e == 0
        assert sim.N_e_abs_pow == 1

    def test_fast_swap_correctness(self, sim):
        """Numba używa swap z ostatnim — kolejność może się zmienić."""
        sim.N_e = 3
        sim.x_e[0] = cs.L * 0.25; sim.vx_e[0] = 100.0
        sim.x_e[1] = -0.001;       sim.vx_e[1] = 999.0  # wychodzi
        sim.x_e[2] = cs.L * 0.75; sim.vx_e[2] = 300.0
        for i in range(3):
            sim.vy_e[i] = sim.vz_e[i] = 0.0
        self._call_e(sim)
        assert sim.N_e == 2
        # Swap z ostatnim: x_e[1] ← x_e[2] → vx_e[1] = 300.0
        assert abs(sim.vx_e[1] - 300.0) < 1e-15
```

---

## 5. Testy specyficzne dla NumPy

Testy weryfikujące poprawność mechanizmów wektorowych — nie mają odpowiednika w Numba.

```python
# test_density_np.py (fragment specyficzny)

class TestNumPySpecific:

    def test_add_at_vs_naive_plusequal(self, sim):
        """
        Kluczowy test: np.add.at musi dać inny (poprawny) wynik niż array[p] += val
        gdy dwie cząstki trafiają w ten sam węzeł.
        """
        import numpy as np
        arr_correct = np.zeros(cs.N_G)
        arr_naive   = np.zeros(cs.N_G)

        p   = np.array([5, 5])    # obie cząstki trafiają w węzeł 5!
        val = np.array([0.3, 0.5]) * cs.FACTOR_W

        np.add.at(arr_correct, p, val)   # poprawne scatter-add
        arr_naive[p] += val              # BŁĘDNE — gubi jedno dodanie

        # Poprawna suma to 0.3 + 0.5 = 0.8
        assert abs(arr_correct[5] - 0.8 * cs.FACTOR_W) < 1e-15
        # Naiwna += daje tylko 0.5 (ostatnią wartość), nie 0.8
        assert abs(arr_naive[5]   - 0.5 * cs.FACTOR_W) < 1e-15
        # Potwierdzamy że wyniki się różnią:
        assert abs(arr_correct[5] - arr_naive[5]) > 1e-15, \
            "Test pokazuje dlaczego np.add.at jest konieczne!"

    def test_view_modification_propagates(self, sim):
        """
        Widok na aktywne cząstki: modyfikacja view musi zmieniać oryginał.
        """
        sim.N_e = 5
        sim.vx_e[:5] = 0.0
        view = sim.vx_e[:sim.N_e]
        view += 999.0   # modyfikacja przez widok
        # Sprawdź że oryginał jest zmieniony:
        assert all(sim.vx_e[k] == 999.0 for k in range(5))
        # I że poza aktywnym zakresem nic się nie zmieniło:
        # (nie możemy sprawdzić sim.vx_e[5:] bo np.empty — wartości nieokreślone)

    def test_slice_assignment_not_replace(self, sim):
        """
        density[:] = 0.0 nie może tworzyć nowej tablicy.
        """
        ref_id = id(sim.e_density)
        sim.e_density[:] = 0.0
        assert id(sim.e_density) == ref_id, \
            "density[:] = 0.0 nie może zastąpić tablicy nową!"
```

---

## 6. Testy specyficzne dla Numba

```python
# python/numba_version/tests/test_numba_specific.py
import numpy as np
import pytest
import constants as cs

class TestNumbaSpecific:

    def test_jit_compiled_functions_are_cached(self, warmup_numba):
        """
        Po warmup, funkcje @njit muszą być skompilowane (nie None w cache).
        """
        from simulation import step1_compute_electron_density
        # Numba przechowuje skompilowane wersje w atrybucie _cache lub signatures
        assert hasattr(step1_compute_electron_density, 'signatures') or \
               hasattr(step1_compute_electron_density, '_cache'), \
               "Funkcja Numba musi mieć widoczny cache po warmup"

    def test_prange_result_same_as_sequential(self):
        """
        Numba prange (równoległy) musi dać te same wyniki co sekwencyjny.
        Sprawdzamy deterministyczność przez porównanie z native.
        """
        import sys; sys.path.insert(0, '../../native_version')
        from state import SimulationState as NativeState
        import simulation as native_sim
        from cross_sections import (set_electron_cross_sections_ar,
                                     set_ion_cross_sections_ar,
                                     calc_total_cross_sections)

        # Przygotuj identyczny stan dla obu
        s_nb = _make_sim_with_particles(N=100, seed=0)
        s_na = _make_native_sim_with_particles(N=100, seed=0)

        # Uruchom jeden krok depozycji
        _run_density_nb(s_nb)
        _run_density_na(s_na)

        # Wyniki muszą być numerycznie identyczne
        np.testing.assert_allclose(
            s_nb.e_density, np.array(s_na.e_density),
            rtol=1e-10,
            err_msg="Numba i native muszą dać identyczną gęstość"
        )

    def test_numba_clip_guard_vs_numpy_clip(self, sim):
        """
        Numba używa if/elif zamiast np.clip — wynik musi być taki sam.
        """
        from simulation import step1_compute_electron_density as nb_density
        import sys; sys.path.insert(0, '../../numpy_version')
        import simulation as np_sim
        from state import SimulationState as NpState
        from cross_sections import (set_electron_cross_sections_ar,
                                     set_ion_cross_sections_ar,
                                     calc_total_cross_sections)

        # Cząstka dokładnie na granicy (edge case dla clip vs if/elif)
        for x_val in [0.0, cs.L, cs.DX * 0.5, cs.L - cs.DX * 0.5]:
            s_nb = _fresh_sim_nb(); s_np = _fresh_sim_np()
            s_nb.x_e[0] = s_np.x_e[0] = x_val
            s_nb.N_e = s_np.N_e = 1

            _run_density_nb(s_nb)
            np_sim.step1_compute_electron_density(s_np)

            np.testing.assert_allclose(
                s_nb.e_density, s_np.e_density, rtol=1e-12,
                err_msg=f"Mismatch przy x={x_val}"
            )

    def test_first_call_warms_up_cache(self, tmp_path):
        """
        Sprawdź że po pierwszym wywołaniu @njit plik cache jest tworzony.
        """
        import os
        cache_dir = os.path.join(os.path.dirname(__file__), '..', '__pycache__')
        # Numba tworzy pliki .nbi i .nbc dla cache=True
        nb_files = [f for f in os.listdir(cache_dir)
                    if f.endswith('.nbi') or f.endswith('.nbc')]
        assert len(nb_files) > 0, \
            "Numba cache=True musi tworzyć pliki .nbi/.nbc po kompilacji"
```

---

## 7. Testy cross-version (NumPy vs Numba vs Native)

```python
# python/tests/test_cross_version.py
"""
Testy porównujące wyniki NumPy i Numba — muszą być numerycznie identyczne
(ta sama fizyka, różna implementacja).
"""
import numpy as np
import pytest
import sys, os
import constants as cs

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'numpy_version'))
import simulation as np_sim
from state import SimulationState as NpState

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'numba_version'))
import simulation as nb_sim
from state import SimulationState as NbState


def make_np_sim(N=50, seed=42):
    from numpy_version.cross_sections import (set_electron_cross_sections_ar,
                                               set_ion_cross_sections_ar,
                                               calc_total_cross_sections)
    s = NpState()
    set_electron_cross_sections_ar(s); set_ion_cross_sections_ar(s)
    calc_total_cross_sections(s)
    rng = np.random.default_rng(seed)
    s.x_e[:N] = rng.uniform(cs.DX, cs.L - cs.DX, N)
    s.N_e = N; s.N_i = 0
    return s


def make_nb_sim(N=50, seed=42):
    # analogiczne
    ...


class TestCrossVersionDensity:

    @pytest.mark.parametrize("N", [1, 10, 100, 1000])
    def test_electron_density_numpy_vs_numba(self, N):
        """
        Gęstość elektronów musi być identyczna w NumPy i Numba
        dla tych samych cząstek.
        """
        s_np = make_np_sim(N=N, seed=0)
        s_nb = make_nb_sim(N=N, seed=0)

        np_sim.step1_compute_electron_density(s_np)
        nb_sim.step1_compute_electron_density(
            s_nb.x_e, s_nb.N_e, s_nb.e_density, s_nb.cumul_e_density,
            cs.INV_DX, cs.FACTOR_W, cs.N_G
        )

        np.testing.assert_allclose(
            s_np.e_density, s_nb.e_density, rtol=1e-12,
            err_msg=f"NumPy vs Numba: e_density różni się przy N={N}"
        )


class TestCrossVersionPoisson:

    def test_poisson_numpy_vs_numba(self):
        s_np = make_np_sim(N=0)
        s_nb = make_nb_sim(N=0)
        rho = np.zeros(cs.N_G)

        import numpy_version.poisson as np_poisson
        import numba_version.poisson as nb_poisson

        np_poisson.solve_poisson(s_np, rho.copy(), tt=0.0)
        nb_poisson.solve_poisson(s_nb, rho.copy(), tt=0.0)

        np.testing.assert_allclose(s_np.pot,    s_nb.pot,    rtol=1e-12)
        np.testing.assert_allclose(s_np.efield, s_nb.efield, rtol=1e-12)


class TestCrossLanguageNative:
    """Porównanie NumPy z natywną wersją Python (identyczna fizyka)."""

    @pytest.mark.parametrize("N", [1, 50])
    def test_density_numpy_vs_native(self, N):
        s_np = make_np_sim(N=N, seed=7)
        # s_na = make_native_sim(N=N, seed=7)
        # Uruchom oba i porównaj
        ...
```

---

## 8. Uruchamianie testów

```bash
# NumPy version — wszystkie testy
cd python/numpy_version
pytest tests/ -v

# Numba version — wszystkie testy (pierwsza kompilacja może trwać ~10-30s)
cd python/numba_version
pytest tests/ -v

# Tylko Tier 1 (deterministyczne, szybkie)
pytest tests/ -v -k "not regression and not cross_version"

# Cross-version (wymaga obu wersji)
pytest python/tests/test_cross_version.py -v

# Z raportem pokrycia
pytest tests/ --cov=. --cov-report=html
open htmlcov/index.html

# Pomiń wolne testy Numba (pomijaj warmup jeśli cache istnieje)
pytest tests/ -v --numba-cache  # (custom marker, opcjonalne)

# CI-friendly
pytest tests/ -q --tb=short
```

### `pytest.ini` — NumPy

```ini
# python/numpy_version/pytest.ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
markers =
    numpy_specific: testy specyficzne dla implementacji NumPy
    regression: testy regresyjne (wolne)
    cross_version: testy porównawcze między wersjami
```

### `pytest.ini` — Numba

```ini
# python/numba_version/pytest.ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
markers =
    numba_specific: testy specyficzne dla JIT (warmup, cache, prange)
    regression: testy regresyjne (wolne)
    slow: kompilacja JIT + długi test
```

---

## 9. Checklist

### NumPy

| # | Test | Funkcja | Priorytet | Status |
|:-:|:-----|:--------|:---------:|:------:|
| 1 | `test_vacuum_linear_potential` | `solve_poisson` | 🔴 | ☐ |
| 2 | `test_vacuum_constant_efield` (np.testing) | `solve_poisson` | 🔴 | ☐ |
| 3 | `test_boundary_efield_with_charge` | `solve_poisson` | 🔴 | ☐ |
| 4 | `test_boundary_conditions` | `solve_poisson` | 🟡 | ☐ |
| 5 | `test_single_particle_on_node` | `step1_compute_electron_density` | 🔴 | ☐ |
| 6 | `test_single_particle_midpoint` | `step1_compute_electron_density` | 🔴 | ☐ |
| 7 | `test_boundary_doubling_left` | `step1_compute_electron_density` | 🔴 | ☐ |
| 8 | `test_boundary_doubling_right` | `step1_compute_electron_density` | 🔴 | ☐ |
| 9 | `test_mass_conservation` | `step1_compute_electron_density` | 🟡 | ☐ |
| 10 | `test_cumulative_density_accumulation` | `step1_compute_electron_density` | 🔴 | ☐ |
| 11 | `test_zeroing_is_inplace` ⭐ NumPy | `step1_compute_electron_density` | 🔴 | ☐ |
| 12 | `test_subcycling_guard` | `step1_compute_ion_density` | 🔴 | ☐ |
| 13 | `test_cumul_ion_density_every_step` | `step1_compute_ion_density` | 🔴 | ☐ |
| 14 | `test_electron_push_sign_positive_field` | `step3_move_electrons` | 🔴 | ☐ |
| 15 | `test_electron_acceleration_magnitude` | `step3_move_electrons` | 🔴 | ☐ |
| 16 | `test_free_streaming` | `step3_move_electrons` | 🟡 | ☐ |
| 17 | `test_efield_interpolation_midpoint` | `step3_move_electrons` | 🟡 | ☐ |
| 18 | `test_push_modifies_sim_arrays_inplace` ⭐ NumPy | `step3_move_electrons` | 🔴 | ☐ |
| 19 | `test_ion_push_sign_positive_field` | `step4_move_ions` | 🔴 | ☐ |
| 20 | `test_ion_subcycling_guard` | `step4_move_ions` | 🔴 | ☐ |
| 21 | `test_electron_absorbed_at_powered` | `step5_check_boundaries` | 🔴 | ☐ |
| 22 | `test_multiple_absorbed_count` | `step5_check_boundaries` | 🔴 | ☐ |
| 23 | `test_filter_preserves_inside_particles` ⭐ NumPy | `step5_check_boundaries` | 🔴 | ☐ |
| 24 | `test_ifed_vectorized_powered` ⭐ NumPy | `step6_check_boundaries` | 🟡 | ☐ |
| 25 | `test_ion_subcycling_boundary` | `step6_check_boundaries` | 🔴 | ☐ |
| 26 | `test_add_at_vs_naive_plusequal` ⭐ NumPy | mechanizm scatter-add | 🔴 | ☐ |
| 27 | `test_view_modification_propagates` ⭐ NumPy | mechanizm widoków | 🔴 | ☐ |
| R1 | Golden run — `density.dat` | `do_one_cycle` | 🔴 | ☐ |
| R2 | Golden run — `conv.dat` | `do_one_cycle` | 🔴 | ☐ |
| R3 | Golden run — `eepf.dat` | `do_one_cycle` | 🟡 | ☐ |

### Numba

| # | Test | Funkcja | Priorytet | Status |
|:-:|:-----|:--------|:---------:|:------:|
| 1 | `test_single_particle_on_node` | `step1_compute_electron_density` | 🔴 | ☐ |
| 2 | `test_boundary_doubling_left/right` | `step1_compute_electron_density` | 🔴 | ☐ |
| 3 | `test_cumulative_density_accumulation` | `step1_compute_electron_density` | 🔴 | ☐ |
| 4 | `test_electron_push_sign_positive_field` | `step3_move_electrons` | 🔴 | ☐ |
| 5 | `test_electron_acceleration_magnitude` | `step3_move_electrons` | 🔴 | ☐ |
| 6 | `test_free_streaming` | `step3_move_electrons` | 🟡 | ☐ |
| 7 | `test_electron_absorbed_at_powered` | `step5_check_boundaries` | 🔴 | ☐ |
| 8 | `test_fast_swap_correctness` ⭐ Numba | `step5_check_boundaries` | 🔴 | ☐ |
| 9 | `test_jit_compiled_functions_are_cached` ⭐ Numba | JIT infrastruktura | 🟡 | ☐ |
| 10 | `test_numba_clip_guard_vs_numpy_clip` ⭐ Numba | `if/elif` vs `np.clip` | 🔴 | ☐ |
| R1 | Golden run — `density.dat` | `do_one_cycle` | 🔴 | ☐ |
| R2 | Golden run — `conv.dat` | `do_one_cycle` | 🔴 | ☐ |

### Cross-version

| # | Test | Porównanie | Priorytet | Status |
|:-:|:-----|:-----------|:---------:|:------:|
| C1 | `test_electron_density_numpy_vs_numba` | NumPy ↔ Numba | 🔴 | ☐ |
| C2 | `test_poisson_numpy_vs_numba` | NumPy ↔ Numba | 🔴 | ☐ |
| C3 | `test_density_numpy_vs_native` | NumPy ↔ Native | 🟡 | ☐ |
| X1 | Cross-language `density.dat` (C vs NumPy) | C ↔ NumPy | 🟡 | ☐ |
| X2 | Cross-language `density.dat` (C vs Numba) | C ↔ Numba | 🟡 | ☐ |

> ⭐ = test specyficzny dla danej implementacji (nie ma odpowiednika w native)
>
> 🔴 = krytyczny (blokuje merge) | 🟡 = ważny (powinien przejść przed release)
