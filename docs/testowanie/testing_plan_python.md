# Plan testów — wersja Python (native i NumPy)

Pliki źródłowe:
- [`python/native_version/`](../python/native_version/) — implementacja natywna (listy Python)
- [`python/numpy_version/`](../python/numpy_version/) — implementacja NumPy (planowana)

Framework: [pytest](https://pytest.org) + [numpy.testing](https://numpy.org/doc/stable/reference/routines.testing.html)

---

## Spis treści

1. [Architektura testów](#1-architektura-testów)
2. [Konfiguracja środowiska](#2-konfiguracja-środowiska)
3. [Testy regresyjne (golden run)](#3-testy-regresyjne-golden-run)
4. [Testy jednostkowe — Tier 1 (deterministyczne)](#4-testy-jednostkowe--tier-1-deterministyczne)
5. [Testy jednostkowe — Tier 2 (stochastyczne)](#5-testy-jednostkowe--tier-2-stochastyczne)
6. [Testy cross-language (C vs Python)](#6-testy-cross-language-c-vs-python)
7. [Uruchamianie testów](#7-uruchamianie-testów)
8. [Checklist](#8-checklist)

---

## 1. Architektura testów

### Struktura katalogów

```
python/
├── native_version/
│   ├── constants.py
│   ├── state.py
│   ├── simulation.py
│   ├── poisson.py
│   ├── collisions.py
│   ├── cross_sections.py
│   ├── io_manager.py
│   └── tests/
│       ├── __init__.py
│       ├── conftest.py              <- fixtures pytest (SimulationState)
│       ├── test_poisson.py
│       ├── test_density.py
│       ├── test_push.py
│       ├── test_boundaries.py
│       ├── test_cross_sections.py
│       ├── test_collisions.py
│       └── test_regression.py
│
└── numpy_version/
    └── tests/
        ├── __init__.py
        ├── conftest.py
        ├── test_poisson_np.py
        ├── test_density_np.py
        ├── test_push_np.py
        ├── test_boundaries_np.py
        └── test_regression_np.py
```

### `conftest.py` — wspólne fixtures

```python
# python/native_version/tests/conftest.py
import pytest
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from state import SimulationState
from constants import *
from cross_sections import set_electron_cross_sections_ar, set_ion_cross_sections_ar, calc_total_cross_sections


@pytest.fixture
def sim():
    """Świeży, zresetowany stan symulacji."""
    s = SimulationState()
    set_electron_cross_sections_ar(s)
    set_ion_cross_sections_ar(s)
    calc_total_cross_sections(s)
    return s


@pytest.fixture
def sim_seeded(sim):
    """Stan z deterministycznym seedem RNG — dla testów regresyjnych."""
    import random
    random.seed(42)
    sim.rng_seed = 42
    return sim


@pytest.fixture
def sim_with_uniform_efield(sim):
    """Stan z jednorodnym E-polem do testów pushu."""
    for i in range(N_G):
        sim.efield[i] = 1000.0
    return sim
```

---

## 2. Konfiguracja środowiska

```bash
# Instalacja zależności
pip install pytest pytest-cov numpy scipy

# Uruchomienie testów (native)
cd python/native_version
pytest tests/ -v

# Uruchomienie testów z raportem pokrycia
pytest tests/ -v --cov=. --cov-report=html

# Uruchomienie tylko konkretnej grupy
pytest tests/test_density.py -v
pytest tests/ -k "Boundary" -v
```

---

## 3. Testy regresyjne (golden run)

### Cel

Zagwarantować identyczne wyniki numeryczne przed i po zmianach.

### Krok 1: Seed deterministyczny

```python
# W state.py — dodaj obsługę seeda:
import random

class SimulationState:
    def __init__(self, seed: int | None = None):
        # ...
        self._seed = seed
        if seed is not None:
            random.seed(seed)
            # Dla numpy version: self.rng = np.random.default_rng(seed)
```

### Krok 2: Wygeneruj golden output

```bash
cd python/native_version
python main.py 0          # init cycle
python main.py 5          # 5 cycles
cp density.dat tests/golden/density_golden.dat
cp conv.dat    tests/golden/conv_golden.dat
```

### Krok 3: Test regresyjny

```python
# tests/test_regression.py
import numpy as np
import subprocess
import shutil
import os
import pytest

GOLDEN_DIR = os.path.join(os.path.dirname(__file__), 'golden')
WORK_DIR   = os.path.join(os.path.dirname(__file__), 'regression_workdir')


@pytest.fixture(autouse=True)
def setup_workdir(tmp_path, monkeypatch):
    """Przełącza CWD na tymczasowy katalog i uruchamia symulację."""
    monkeypatch.chdir(tmp_path)
    # Kopiuj wymagane pliki konfiguracyjne jeśli potrzebne
    yield tmp_path


def run_simulation(*args):
    """Uruchamia główny skrypt z podanymi argumentami."""
    result = subprocess.run(
        ['python', '../main.py', *[str(a) for a in args]],
        capture_output=True, text=True
    )
    assert result.returncode == 0, f"Symulacja nie powiodła się:\n{result.stderr}"
    return result


def compare_numeric(file1: str, file2: str, rtol: float = 1e-8):
    """Porównuje dwa pliki numeryczne z tolerancją względną."""
    a = np.loadtxt(file1)
    b = np.loadtxt(file2)
    assert a.shape == b.shape, f"Shape mismatch: {a.shape} vs {b.shape}"
    np.testing.assert_allclose(a, b, rtol=rtol, atol=1e-30,
        err_msg=f"Pliki {file1} i {file2} różnią się bardziej niż rtol={rtol}")


class TestGoldenRegression:

    def test_density_unchanged(self, tmp_path):
        run_simulation(0)   # seed 42 w main.py
        run_simulation(5)
        compare_numeric('density.dat',
                        os.path.join(GOLDEN_DIR, 'density_golden.dat'))

    def test_conv_unchanged(self, tmp_path):
        run_simulation(0)
        run_simulation(5)
        compare_numeric('conv.dat',
                        os.path.join(GOLDEN_DIR, 'conv_golden.dat'))

    def test_eepf_unchanged(self, tmp_path):
        run_simulation(0)
        run_simulation(5, 'm')   # measurement mode
        compare_numeric('eepf.dat',
                        os.path.join(GOLDEN_DIR, 'eepf_golden.dat'),
                        rtol=1e-6)

    def test_particle_count_stable(self, tmp_path):
        """Liczba cząstek po 5 cyklach musi być w zakresie fizycznym."""
        run_simulation(0)
        result = run_simulation(5)
        # Parsuj ostatnią linię conv.dat
        with open('conv.dat') as f:
            lines = f.readlines()
        last = lines[-1].split()
        n_e, n_i = int(last[1]), int(last[2])
        assert 100 < n_e < 1_000_000, f"N_e={n_e} poza zakresem"
        assert 100 < n_i < 1_000_000, f"N_i={n_i} poza zakresem"
```

---

## 4. Testy jednostkowe — Tier 1 (deterministyczne)

### 4.1 `solve_poisson` — solver Thomasa

```python
# tests/test_poisson.py
import numpy as np
import pytest
from constants import *
from poisson import solve_poisson
from state import SimulationState


class TestPoissonSolver:

    # Test A: potencjał liniowy w próżni
    def test_vacuum_linear_potential(self, sim):
        rho = [0.0] * N_G
        V0 = VOLTAGE   # cos(0) = 1 → tt=0
        solve_poisson(sim, rho, tt=0.0)

        for i in range(1, N_G - 1):
            expected = V0 * (1.0 - i / (N_G - 1))
            assert abs(sim.pot[i] - expected) < 1e-8, \
                f"Błąd potencjału w węźle i={i}: {sim.pot[i]:.6f} != {expected:.6f}"

    # Test B: E-pole stałe w próżni
    def test_vacuum_constant_efield(self, sim):
        rho = [0.0] * N_G
        solve_poisson(sim, rho, tt=0.0)
        E_expected = VOLTAGE / L
        for i in range(1, N_G - 2):
            assert abs(sim.efield[i] - E_expected) < 1e-6, \
                f"Błąd E-pola w węźle i={i}"

    # Test C: warunki graniczne E-pola z rho!=0
    def test_boundary_efield_with_charge(self, sim):
        rho = [0.0] * N_G
        rho[0]     = 1e15 * E_CHARGE
        rho[N_G-1] = 1e15 * E_CHARGE
        solve_poisson(sim, rho, tt=0.0)
        expected_e0 = (sim.pot[0] - sim.pot[1]) * INV_DX - rho[0] * DX / (2.0 * EPSILON0)
        expected_eN = (sim.pot[N_G-2] - sim.pot[N_G-1]) * INV_DX + rho[N_G-1] * DX / (2.0 * EPSILON0)
        assert abs(sim.efield[0]     - expected_e0) < 1e-6
        assert abs(sim.efield[N_G-1] - expected_eN) < 1e-6

    # Test D: środek liniowego potencjału
    def test_midpoint_potential(self, sim):
        rho = [0.0] * N_G
        solve_poisson(sim, rho, tt=0.0)
        assert abs(sim.pot[N_G // 2] - VOLTAGE * 0.5) < 1.0

    # Test E: wartości graniczne BC
    def test_boundary_conditions(self, sim):
        rho = [0.0] * N_G
        for tt in [0.0, PERIOD / 4, PERIOD / 2]:
            solve_poisson(sim, rho, tt=tt)
            expected_pot0 = VOLTAGE * np.cos(OMEGA * tt)
            assert abs(sim.pot[0]     - expected_pot0) < 1e-10
            assert abs(sim.pot[N_G-1] - 0.0)          < 1e-10
```

---

### 4.2 `step1_compute_electron_density` — ważenie liniowe

```python
# tests/test_density.py
import pytest
import math
from constants import *
from simulation import step1_compute_electron_density, step1_compute_ion_density


class TestElectronDensity:

    # Test A: cząstka dokładnie na węźle
    def test_single_particle_on_node(self, sim):
        p0 = 100
        sim.x_e[0] = DX * p0
        sim.N_e = 1
        step1_compute_electron_density(sim)
        assert abs(sim.e_density[p0]     - FACTOR_W) < 1e-10
        assert abs(sim.e_density[p0 + 1] - 0.0)      < 1e-10
        assert abs(sim.e_density[p0 - 1] - 0.0)      < 1e-10

    # Test B: cząstka w połowie między węzłami
    def test_single_particle_midpoint(self, sim):
        p0 = 100
        sim.x_e[0] = DX * (p0 + 0.5)
        sim.N_e = 1
        step1_compute_electron_density(sim)
        assert abs(sim.e_density[p0]     - 0.5 * FACTOR_W) < 1e-10
        assert abs(sim.e_density[p0 + 1] - 0.5 * FACTOR_W) < 1e-10

    # Test C: zachowanie masy
    def test_mass_conservation(self, sim):
        sim.N_e = 50
        for k in range(sim.N_e):
            sim.x_e[k] = DX + (L - 2*DX) * k / (sim.N_e - 1)
        step1_compute_electron_density(sim)
        total = sum(sim.e_density[p] * DX * ELECTRODE_AREA for p in range(N_G))
        expected = sim.N_e * WEIGHT
        assert abs(total - expected) / expected < 0.01, \
            f"Naruszenie zachowania masy: {total:.3e} != {expected:.3e}"

    # Test D: KRYTYCZNY — korekta x2 na lewej granicy
    def test_boundary_doubling_left(self, sim):
        sim.x_e[0] = DX * 0.5
        sim.N_e = 1
        step1_compute_electron_density(sim)
        # Po korekcji x2: density[0] = FACTOR_W (nie 0.5 * FACTOR_W)
        assert abs(sim.e_density[0] - FACTOR_W)       < 1e-10, \
            "Korekta x2 na lewej granicy nie zostala zastosowana!"
        assert abs(sim.e_density[1] - 0.5 * FACTOR_W) < 1e-10

    # Test E: KRYTYCZNY — korekta x2 na prawej granicy
    def test_boundary_doubling_right(self, sim):
        sim.x_e[0] = L - DX * 0.5
        sim.N_e = 1
        step1_compute_electron_density(sim)
        assert abs(sim.e_density[N_G - 1] - FACTOR_W)       < 1e-10, \
            "Korekta x2 na prawej granicy nie zostala zastosowana!"
        assert abs(sim.e_density[N_G - 2] - 0.5 * FACTOR_W) < 1e-10

    # Test F: cumul_e_density akumuluje w każdym kroku
    def test_cumulative_density_accumulation(self, sim):
        sim.x_e[0] = L / 2.0
        sim.N_e = 1
        step1_compute_electron_density(sim)
        after_step1 = sim.cumul_e_density[N_G // 2]
        step1_compute_electron_density(sim)
        after_step2 = sim.cumul_e_density[N_G // 2]
        assert abs(after_step2 - 2.0 * after_step1) < 1e-10, \
            "cumul_e_density musi rosnąć liniowo z każdym krokiem"


class TestIonDensity:

    # Test G: subcycling guard
    def test_subcycling_guard(self, sim):
        sim.x_i[0] = L / 2.0
        sim.N_i = 1
        # t=1 → t%N_SUB != 0 → brak deposycji
        step1_compute_ion_density(sim, t=1)
        assert sim.i_density[N_G // 2] == 0.0, \
            "i_density musi byc 0 gdy t%N_SUB != 0"

    # Test H: subcycling — deposycja przy t=0
    def test_subcycling_executes_at_t0(self, sim):
        sim.x_i[0] = L / 2.0
        sim.N_i = 1
        step1_compute_ion_density(sim, t=0)
        assert sim.i_density[N_G // 2] > 0.0, \
            "i_density musi byc obliczona gdy t%N_SUB == 0"

    # Test I: cumul_i_density akumuluje KAŻDY krok (nawet bez subcyclingu)
    def test_cumul_ion_density_every_step(self, sim):
        """cumul_i_density musi rosnąć przy każdym kroku,
        nawet gdy i_density nie jest przeliczana (zachowanie C++)."""
        sim.x_i[0] = L / 2.0
        sim.N_i = 1
        # Najpierw oblicz i_density przy t=0
        step1_compute_ion_density(sim, t=0)
        cumul_after_t0 = sim.cumul_i_density[N_G // 2]
        # Teraz krok bez subcyclingu — cumul MUSI rosnąć (używa ostatniej i_density)
        step1_compute_ion_density(sim, t=1)
        cumul_after_t1 = sim.cumul_i_density[N_G // 2]
        assert cumul_after_t1 > cumul_after_t0, \
            "cumul_i_density musi rosnąć nawet gdy t%N_SUB != 0!"
```

---

### 4.3 `step3_move_electrons` / `step4_move_ions` — push leapfrog

```python
# tests/test_push.py
import pytest
from constants import *
from simulation import step3_move_electrons, step4_move_ions


class TestElectronPush:

    # Test A: KRYTYCZNY — znak przyspieszenia
    def test_electron_push_sign_positive_field(self, sim):
        """Elektron w E>0 przyspiesza w -x (ładunek ujemny)."""
        sim.N_e = 1
        sim.x_e[0] = L / 2.0
        sim.vx_e[0] = sim.vy_e[0] = sim.vz_e[0] = 0.0
        for i in range(N_G):
            sim.efield[i] = 1000.0
        step3_move_electrons(sim, t_index=0)
        assert sim.vx_e[0] < 0.0, \
            f"Elektron w E>0 musi mieć vx<0, got vx={sim.vx_e[0]}"

    def test_electron_push_sign_negative_field(self, sim):
        """Elektron w E<0 przyspiesza w +x."""
        sim.N_e = 1
        sim.x_e[0] = L / 2.0
        sim.vx_e[0] = 0.0
        for i in range(N_G):
            sim.efield[i] = -1000.0
        step3_move_electrons(sim, t_index=0)
        assert sim.vx_e[0] > 0.0

    # Test B: wartość przyspieszenia
    def test_electron_acceleration_magnitude(self, sim):
        sim.N_e = 1
        sim.x_e[0] = L / 2.0   # na węźle N_G//2
        sim.vx_e[0] = 0.0
        E_val = 1000.0
        for i in range(N_G):
            sim.efield[i] = E_val
        step3_move_electrons(sim, t_index=0)
        expected_dv = -E_val * FACTOR_E
        assert abs(sim.vx_e[0] - expected_dv) < 1e-10

    # Test C: swobodny ruch przy E=0
    def test_free_streaming(self, sim):
        sim.N_e = 1
        sim.x_e[0] = L / 2.0
        sim.vx_e[0] = 1e5
        for i in range(N_G):
            sim.efield[i] = 0.0
        x_before = sim.x_e[0]
        step3_move_electrons(sim, t_index=0)
        assert abs(sim.x_e[0] - (x_before + 1e5 * DT_E)) < 1e-15
        assert abs(sim.vx_e[0] - 1e5) < 1e-15

    # Test D: interpolacja — cząstka w połowie między węzłami
    def test_efield_interpolation_midpoint(self, sim):
        p0 = 100
        sim.N_e = 1
        sim.x_e[0] = DX * (p0 + 0.5)
        sim.vx_e[0] = 0.0
        for i in range(N_G):
            sim.efield[i] = 0.0
        sim.efield[p0]     = 200.0
        sim.efield[p0 + 1] = 400.0
        step3_move_electrons(sim, t_index=0)
        # e_x = 0.5*200 + 0.5*400 = 300 → dv = -300 * FACTOR_E
        assert abs(sim.vx_e[0] - (-300.0 * FACTOR_E)) < 1e-10


class TestIonPush:

    # Test E: KRYTYCZNY — znak przyspieszenia jonu
    def test_ion_push_sign_positive_field(self, sim):
        """Jon w E>0 przyspiesza w +x (ładunek dodatni)."""
        sim.N_i = 1
        sim.x_i[0] = L / 2.0
        sim.vx_i[0] = sim.vy_i[0] = sim.vz_i[0] = 0.0
        for i in range(N_G):
            sim.efield[i] = 1000.0
        step4_move_ions(sim, t_index=0, t=0)   # t=0 → t%N_SUB==0
        assert sim.vx_i[0] > 0.0, \
            f"Jon w E>0 musi mieć vx>0, got vx={sim.vx_i[0]}"

    # Test F: subcycling guard
    def test_ion_subcycling_guard(self, sim):
        sim.N_i = 1
        sim.x_i[0] = L / 2.0
        sim.vx_i[0] = 0.0
        for i in range(N_G):
            sim.efield[i] = 1000.0
        step4_move_ions(sim, t_index=0, t=1)   # t=1 → t%N_SUB != 0
        assert sim.vx_i[0] == 0.0, "Jon nie powinien się ruszyć gdy t%N_SUB != 0"

    # Test G: FACTOR_E vs FACTOR_I — różne wartości
    def test_factor_e_vs_factor_i_magnitude(self, sim):
        """FACTOR_I << FACTOR_E — jon jest N_SUB-razy cięższy od elektronu * DT."""
        # FACTOR_E = DT_E / E_MASS * E_CHARGE
        # FACTOR_I = DT_I / AR_MASS * E_CHARGE = N_SUB*DT_E / AR_MASS * E_CHARGE
        ratio = FACTOR_E / FACTOR_I
        # AR_MASS/E_MASS * N_SUB ≈ 1633 (jony są 1633x słabiej przyspieszane)
        expected_ratio = (AR_MASS / E_MASS) / N_SUB
        assert abs(ratio - expected_ratio) / expected_ratio < 1e-8
```

---

### 4.4 `step5/6_check_boundaries` — usuwanie cząstek

```python
# tests/test_boundaries.py
import pytest
from constants import *
from simulation import step5_check_boundaries_electrons, step6_check_boundaries_ions


class TestElectronBoundaries:

    def test_electron_absorbed_at_powered(self, sim):
        sim.N_e = 1
        sim.x_e[0] = -0.001
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 0
        assert sim.N_e_abs_pow == 1
        assert sim.N_e_abs_gnd == 0

    def test_electron_absorbed_at_grounded(self, sim):
        sim.N_e = 1
        sim.x_e[0] = L + 0.001
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 0
        assert sim.N_e_abs_gnd == 1
        assert sim.N_e_abs_pow == 0

    def test_electron_inside_not_removed(self, sim):
        sim.N_e = 1
        sim.x_e[0] = L / 2.0
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 1
        assert sim.N_e_abs_pow == 0
        assert sim.N_e_abs_gnd == 0

    def test_fast_swap_correctness(self, sim):
        """Usunięcie środkowej cząstki: [dobra, ZLA, dobra] → [dobra, dobra]"""
        sim.N_e = 3
        sim.x_e[0]  = L * 0.25; sim.vx_e[0] = 100.0
        sim.x_e[1]  = -0.001;   sim.vx_e[1] = 200.0  # wychodzi
        sim.x_e[2]  = L * 0.75; sim.vx_e[2] = 300.0
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 2
        assert abs(sim.x_e[1]  - L * 0.75) < 1e-15
        assert abs(sim.vx_e[1] - 300.0)    < 1e-15

    def test_all_electrons_absorbed(self, sim):
        sim.N_e = 10
        for k in range(5):  sim.x_e[k] = -0.001
        for k in range(5, 10): sim.x_e[k] = L + 0.001
        step5_check_boundaries_electrons(sim)
        assert sim.N_e == 0
        assert sim.N_e_abs_pow == 5
        assert sim.N_e_abs_gnd == 5


class TestIonBoundaries:

    def test_ion_energy_recorded_in_ifed_powered(self, sim):
        sim.N_i = 1
        sim.x_i[0]  = -0.001
        sim.vx_i[0] = 1000.0
        sim.vy_i[0] = sim.vz_i[0] = 0.0
        energy = 0.5 * AR_MASS * 1000.0**2 / EV_TO_J
        expected_bin = int(energy / DE_IFED)
        step6_check_boundaries_ions(sim, t=0)
        assert sim.N_i == 0
        assert sim.N_i_abs_pow == 1
        if expected_bin < N_IFED:
            assert sim.ifed_pow[expected_bin] == 1

    def test_ion_subcycling_boundary(self, sim):
        """Granice jonów sprawdzane tylko przy t%N_SUB == 0."""
        sim.N_i = 1
        sim.x_i[0] = -0.001
        step6_check_boundaries_ions(sim, t=1)   # t%N_SUB != 0
        assert sim.N_i == 1, "Jon nie powinien być usunięty gdy t%N_SUB != 0"
```

---

### 4.5 Cross-sections

```python
# tests/test_cross_sections.py
import pytest
from constants import *
from cross_sections import set_electron_cross_sections_ar, calc_total_cross_sections


class TestElectronCrossSections:

    def test_excitation_threshold(self, sim):
        """sigma_exc == 0 poniżej progu 11.5 eV."""
        threshold_bin = int(E_EXC_TH / DE_CS)
        for i in range(threshold_bin):
            assert sim.sigma[E_EXC][i] == 0.0, \
                f"sigma_exc musi być 0 poniżej progu, bin={i}"
        assert sim.sigma[E_EXC][int(12.0 / DE_CS)] > 0.0

    def test_ionization_threshold(self, sim):
        """sigma_ion == 0 poniżej progu 15.8 eV."""
        threshold_bin = int(E_ION_TH / DE_CS)
        for i in range(threshold_bin):
            assert sim.sigma[E_ION][i] == 0.0, f"bin={i}"
        assert sim.sigma[E_ION][int(16.0 / DE_CS)] > 0.0

    def test_elastic_always_nonnegative(self, sim):
        for i in range(CS_RANGES):
            assert sim.sigma[E_ELA][i] >= 0.0, f"E_ELA < 0 w bin={i}"

    def test_total_cross_section_formula(self, sim):
        for i in range(0, CS_RANGES, 10000):
            expected = (sim.sigma[E_ELA][i] + sim.sigma[E_EXC][i] + sim.sigma[E_ION][i]) * GAS_DENSITY
            assert abs(sim.sigma_tot_e[i] - expected) < expected * 1e-10, \
                f"Błędna sigma_tot_e w bin={i}"
```

---

## 5. Testy jednostkowe — Tier 2 (stochastyczne)

```python
# tests/test_collisions.py
import random
import pytest
import math
from constants import *
from collisions import collision_electron, collision_ion


class TestCollisionElectron:

    def test_ionization_creates_particle_pair(self, sim):
        """Jonizacja musi zwiększyć N_e o 1 i N_i o 1."""
        energy_eV = 30.0
        g = math.sqrt(2.0 * energy_eV * EV_TO_J / E_MASS)
        eindex = int(energy_eV / DE_CS)
        sim.N_e = 1; sim.N_i = 0

        ionization_occurred = False
        for seed in range(500):
            random.seed(seed)
            ne_before, ni_before = sim.N_e, sim.N_i
            vx, vy, vz = g, 0.0, 0.0
            collision_electron(sim, k=0, e_index=eindex)
            if sim.N_e > ne_before:
                assert sim.N_e == ne_before + 1
                assert sim.N_i == ni_before + 1
                ionization_occurred = True
                break

        assert ionization_occurred, "Jonizacja musi zajść przy 30 eV w 500 próbach"

    def test_excitation_impossible_below_threshold(self, sim):
        """Przy energii poniżej progu sigma_exc=0 → excytacja nie może zajść."""
        eindex = int(5.0 / DE_CS)   # 5 eV < 11.5 eV
        assert sim.sigma[E_EXC][eindex] == 0.0


class TestCollisionIon:

    def test_momentum_conservation(self, sim):
        """Kolizja jonów zachowuje całkowity pęd."""
        import random
        random.seed(42)

        vx1, vy1, vz1 = 1000.0, 0.0, 0.0
        vx2, vy2, vz2 = 0.0, 0.0, 0.0
        gx = vx1 - vx2
        energy_com = 0.5 * MU_ARAR * gx**2 / EV_TO_J
        eindex = int(energy_com / DE_CS)
        p_before = AR_MASS * (vx1 + vx2)

        sim.vx_i[0] = vx1; sim.vy_i[0] = vy1; sim.vz_i[0] = vz1
        vx_a, vy_a, vz_a = vx2, vy2, vz2
        collision_ion(sim, k=0, vx_a=vx_a, vy_a=vy_a, vz_a=vz_a, e_index=eindex)

        p_after = AR_MASS * (sim.vx_i[0] + vx_a)
        assert abs(p_after - p_before) / abs(p_before) < 1e-10
```

---

## 6. Testy cross-language (C vs Python)

Porównanie wyników numerycznych między implementacją C i Python przy tym samym wejściu.

```python
# tests/test_cross_language.py
"""
Testy cross-language: porównuje Python native z C reference.
Wymaga wcześniejszego wygenerowania golden output z C.
"""
import numpy as np
import os
import pytest

C_GOLDEN_DIR = os.path.join(
    os.path.dirname(__file__), '..', '..', '..', 'C', 'tests', 'golden'
)

def compare_files(py_file, c_golden_file, rtol=1e-5):
    """Porównuje plik Python z golden C — tolerancja 1e-5 rel."""
    py_data = np.loadtxt(py_file)
    c_data  = np.loadtxt(c_golden_file)
    np.testing.assert_allclose(
        py_data, c_data, rtol=rtol, atol=1e-30,
        err_msg=f"Python vs C: {py_file} różni się od {c_golden_file}"
    )


@pytest.mark.skipif(
    not os.path.exists(C_GOLDEN_DIR),
    reason="C golden output nie jest dostępny"
)
class TestCrossLanguageValidation:

    def test_density_matches_c(self, tmp_path, monkeypatch):
        monkeypatch.chdir(tmp_path)
        import subprocess
        subprocess.run(['python', '../main.py', '0'], check=True)
        subprocess.run(['python', '../main.py', '5', 'm'], check=True)
        compare_files('density.dat',
                      os.path.join(C_GOLDEN_DIR, 'density_golden.dat'))

    def test_eepf_matches_c(self, tmp_path, monkeypatch):
        monkeypatch.chdir(tmp_path)
        import subprocess
        subprocess.run(['python', '../main.py', '0'], check=True)
        subprocess.run(['python', '../main.py', '5', 'm'], check=True)
        compare_files('eepf.dat',
                      os.path.join(C_GOLDEN_DIR, 'eepf_golden.dat'),
                      rtol=1e-4)
```

---

## 7. Uruchamianie testów

```bash
# Wszystkie testy (native version)
cd python/native_version
pytest tests/ -v

# Tylko testy Tier 1
pytest tests/ -v -k "not Collision and not regression"

# Tylko testy regresyjne
pytest tests/test_regression.py -v

# Z raportem pokrycia
pytest tests/ --cov=. --cov-report=html
open htmlcov/index.html

# CI-friendly (bez verbose, zwraca kod błędu)
pytest tests/ -q --tb=short
```

### Konfiguracja `pytest.ini`

```ini
# python/native_version/pytest.ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
markers =
    regression: testy regresyjne (wolne, wymagają golden output)
    cross_language: testy cross-language (wymagają C golden output)
    slow: testy stochastyczne (duża liczba prób)
```

---

## 8. Checklist

| # | Test | Funkcja | Priorytet | Status |
|:-:|:-----|:--------|:---------:|:------:|
| 1 | `test_vacuum_linear_potential` | `solve_poisson` | 🔴 | ☐ |
| 2 | `test_vacuum_constant_efield` | `solve_poisson` | 🔴 | ☐ |
| 3 | `test_boundary_efield_with_charge` | `solve_poisson` | 🔴 | ☐ |
| 4 | `test_boundary_conditions` | `solve_poisson` | 🟡 | ☐ |
| 5 | `test_single_particle_on_node` | `step1_compute_electron_density` | 🔴 | ☐ |
| 6 | `test_single_particle_midpoint` | `step1_compute_electron_density` | 🔴 | ☐ |
| 7 | `test_boundary_doubling_left` | `step1_compute_electron_density` | 🔴 | ☐ |
| 8 | `test_boundary_doubling_right` | `step1_compute_electron_density` | 🔴 | ☐ |
| 9 | `test_mass_conservation` | `step1_compute_electron_density` | 🟡 | ☐ |
| 10 | `test_cumulative_density_accumulation` | `step1_compute_electron_density` | 🔴 | ☐ |
| 11 | `test_subcycling_guard` | `step1_compute_ion_density` | 🔴 | ☐ |
| 12 | `test_cumul_ion_density_every_step` | `step1_compute_ion_density` | 🔴 | ☐ |
| 13 | `test_electron_push_sign_positive_field` | `step3_move_electrons` | 🔴 | ☐ |
| 14 | `test_ion_push_sign_positive_field` | `step4_move_ions` | 🔴 | ☐ |
| 15 | `test_free_streaming` | `step3_move_electrons` | 🟡 | ☐ |
| 16 | `test_efield_interpolation_midpoint` | `step3_move_electrons` | 🟡 | ☐ |
| 17 | `test_ion_subcycling_guard` | `step4_move_ions` | 🔴 | ☐ |
| 18 | `test_electron_absorbed_at_powered` | `step5_check_boundaries` | 🔴 | ☐ |
| 19 | `test_fast_swap_correctness` | `step5_check_boundaries` | 🔴 | ☐ |
| 20 | `test_ion_energy_recorded_in_ifed_powered` | `step6_check_boundaries` | 🟡 | ☐ |
| 21 | `test_ion_subcycling_boundary` | `step6_check_boundaries` | 🔴 | ☐ |
| 22 | `test_excitation_threshold` | `set_electron_cross_sections_ar` | 🔴 | ☐ |
| 23 | `test_ionization_threshold` | `set_electron_cross_sections_ar` | 🔴 | ☐ |
| 24 | `test_total_cross_section_formula` | `calc_total_cross_sections` | 🔴 | ☐ |
| 25 | `test_ionization_creates_particle_pair` | `collision_electron` | 🟡 | ☐ |
| 26 | `test_momentum_conservation` | `collision_ion` | 🟡 | ☐ |
| R1 | Golden run — `density.dat` | `do_one_cycle` | 🔴 | ☐ |
| R2 | Golden run — `conv.dat` | `do_one_cycle` | 🔴 | ☐ |
| R3 | Golden run — `eepf.dat` | `do_one_cycle` | 🟡 | ☐ |
| X1 | Cross-language `density.dat` (C vs Py) | cały pipeline | 🟡 | ☐ |
| X2 | Cross-language `eepf.dat` (C vs Py) | cały pipeline | 🟡 | ☐ |

> **Uwaga dla wersji NumPy:** Testy dla `numpy_version/` mają identyczne nazwy i sprawdzane właściwości, ale konfiguracja fixture uwzględnia `np.ndarray` zamiast `list[float]`, a zamiast `np.add.at` sprawdzamy brak `array[p] += value` z tablicowymi indeksami.
