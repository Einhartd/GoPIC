# Plan testów — wersje Python (native, numpy, numba)

Pliki źródłowe w katalogach:
* [`python/native_version/`](../../python/native_version/) — referencyjna wersja sekwencyjna (listy)
* [`python/numpy_version/`](../../python/numpy_version/) — wersja wektorowa NumPy/SciPy
* [`python/numba_version/`](../../python/numba_version/) — wersja zoptymalizowana Numba JIT

Framework testowy: [pytest](https://docs.pytest.org/)  
Menedżer środowiska: [uv](https://github.com/astral-sh/uv)

---

## Spis treści

1. [Architektura zunifikowanego katalogu testów](#1-architektura-zunifikowanego-katalogu-testów)
2. [Konfiguracyjny Adapter Środowiska (conftest.py)](#2-konfiguracyjny-adapter-środowiska-conftestpy)
3. [Implementacja testów jednostkowych](#3-implementacja-testów-jednostkowych)
   * [3.1 Solver Poissona (test_poisson.py)](#31-solver-poissona-test_poissonpy)
   * [3.2 Depozycja gęstości (test_density.py)](#32-depozycja-gęstości-test_densitypy)
   * [3.3 Popychanie Leapfrog (test_push.py)](#33-popychanie-leapfrog-test_pushpy)
   * [3.4 Absorpcja brzegowa (test_boundaries.py)](#34-absorpcja-brzegowa-test_boundariespy)
   * [3.5 Przekroje czynne (test_cross_sections.py)](#35-przekroje-czynne-test_cross_sectionspy)
4. [Testy różnicowe (test_differential.py)](#4-testy-różnicowe-test_differentialpy)
5. [Testy regresyjne / Golden Run (test_regression.py)](#5-testy-regresyjne--golden-run-test_regressionpy)
6. [Uruchamianie testów i raportowanie](#6-uruchamianie-testów-i-raportowanie)
7. [Checklist walidacji](#7-checklist-walidacji)

---

## 1. Architektura zunifikowanego katalogu testów

Testy jednostkowe, różnicowe oraz regresyjne znajdują się w jednym, wspólnym katalogu `python/tests/` na poziomie głównym projektu Pythona. Zapobiega to powielaniu kodu testów oraz pozwala na bezpośrednie porównywanie zachowania zoptymalizowanych implementacji (NumPy, Numba) z wersją referencyjną (Native).

Struktura katalogów:

```
python/
├── native_version/    ← Referencyjny kod
├── numpy_version/     ← Wersja NumPy/SciPy
├── numba_version/     ← Wersja Numba JIT
└── tests/             ← ZUNIFIKOWANE TESTY
    ├── conftest.py            ← Ujednolicony adapter sygnatur
    ├── test_poisson.py        ← Testy solvera Poissona
    ├── test_density.py        ← Testy depozycji ładunku (step1)
    ├── test_push.py           ← Testy popychania cząstek (step3/4)
    ├── test_boundaries.py     ← Testy usuwania cząstek i IFED (step5/6)
    ├── test_cross_sections.py ← Testy przekrojów czynnych
    ├── test_differential.py   ← Testy bezpośredniego porównania
    ├── test_regression.py     ← Testy regresyjne (Golden Run)
    └── run_regression.py      ← Skrypt sterujący regresją (seeding + serializacja)
```

---

## 2. Konfiguracyjny Adapter Środowiska (`conftest.py`)

Jako że `numba_version` optymalizuje kod poprzez bezpośrednie przekazywanie tablic numpy do funkcji `@numba.njit` (zamiast obiektu stanu `SimulationState`), jej sygnatury różnią się od wersji `native` i `numpy`. 

Klasa `SimulationAdapter` w `python/tests/conftest.py` ujednolica interfejs wywołań wszystkich kroków symulacji oraz rozwiązuje problem izolacji przestrzeni nazw (czyszczenie `sys.modules` przy przełączaniu wersji):

```python
# python/tests/conftest.py
import sys
import os
import importlib

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

class SimulationAdapter:
    """Adapter ujednolicający wywołania funkcji pętli głównej dla wszystkich wersji"""
    def __init__(self, version: str):
        self.version = version
        
        # 1. Wyczyszczenie sys.modules z poprzednich wersji, aby uniknąć problemów z cache
        for mod_name in ["constants", "state", "simulation", "poisson", "collisions", "cross_sections", "io_manager"]:
            if mod_name in sys.modules:
                del sys.modules[mod_name]
                
        # 2. Oczyszczenie sys.path z innych wersji
        for path in list(sys.path):
            if any(path.endswith(v) for v in ["native_version", "numpy_version", "numba_version"]):
                sys.path.remove(path)
                
        # 3. Dodanie aktualnej wersji na początek sys.path
        version_dir = os.path.join(ROOT_DIR, version)
        sys.path.insert(0, version_dir)
        
        # 4. Import modułów specyficznych dla danej wersji
        self.state_mod = importlib.import_module("state")
        self.sim_mod = importlib.import_module("simulation")
        self.cs_mod = importlib.import_module("constants")
        self.poisson_mod = importlib.import_module("poisson")
        self.cross_mod = importlib.import_module("cross_sections")

    def create_state(self):
        return self.state_mod.SimulationState()

    def solve_poisson(self, sim, rho, tt: float):
        self.poisson_mod.solve_poisson(sim, rho, tt)

    def setup_cross_sections(self, sim):
        self.cross_mod.set_electron_cross_sections_ar(sim)
        self.cross_mod.set_ion_cross_sections_ar(sim)
        self.cross_mod.calc_total_cross_sections(sim)

    def step1_compute_electron_density(self, sim):
        if self.version == "numba_version":
            self.sim_mod.step1_compute_electron_density(
                sim.x_e, sim.N_e, sim.e_density, sim.cumul_e_density,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_W, self.cs_mod.N_G
            )
        else:
            self.sim_mod.step1_compute_electron_density(sim)

    def step1_compute_ion_density(self, sim, t: int):
        if self.version == "numba_version":
            self.sim_mod.step1_compute_ion_density(
                sim.x_i, sim.N_i, sim.i_density, sim.cumul_i_density,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_W, self.cs_mod.N_G,
                t, self.cs_mod.N_SUB
            )
        else:
            self.sim_mod.step1_compute_ion_density(sim, t)

    def step3_move_electrons(self, sim, t_index: int):
        if self.version == "numba_version":
            self.sim_mod.step3_move_electrons(
                sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, sim.efield,
                sim.counter_e_xt, sim.ue_xt, sim.meanee_xt, sim.ioniz_rate_xt,
                sim.eepf, sim.sigma,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_E, self.cs_mod.DT_E, self.cs_mod.N_G,
                self.cs_mod.E_MASS, self.cs_mod.EV_TO_J, self.cs_mod.DE_CS, self.cs_mod.DE_EEPF,
                self.cs_mod.N_EEPF, self.cs_mod.CS_RANGES, self.cs_mod.GAS_DENSITY,
                self.cs_mod.MIN_X, self.cs_mod.MAX_X, self.cs_mod.E_ION,
                t_index, sim.measurement_mode
            )
        else:
            self.sim_mod.step3_move_electrons(sim, t_index)

    def step4_move_ions(self, sim, t_index: int, t: int):
        if self.version == "numba_version":
            self.sim_mod.step4_move_ions(
                sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, sim.efield,
                sim.counter_i_xt, sim.ui_xt, sim.meanei_xt,
                self.cs_mod.INV_DX, self.cs_mod.FACTOR_I, self.cs_mod.DT_I, self.cs_mod.N_G,
                self.cs_mod.AR_MASS, self.cs_mod.EV_TO_J,
                t_index, sim.measurement_mode, t, self.cs_mod.N_SUB
            )
        else:
            self.sim_mod.step4_move_ions(sim, t_index, t)

    def step5_check_boundaries_electrons(self, sim):
        if self.version == "numba_version":
            sim.N_e, abs_pow, abs_gnd = self.sim_mod.step5_check_boundaries_electrons(
                sim.x_e, sim.vx_e, sim.vy_e, sim.vz_e, sim.N_e, self.cs_mod.L
            )
            sim.N_e_abs_pow += abs_pow
            sim.N_e_abs_gnd += abs_gnd
        else:
            self.sim_mod.step5_check_boundaries_electrons(sim)

    def step6_check_boundaries_ions(self, sim, t: int):
        if self.version == "numba_version":
            sim.N_i, abs_pow, abs_gnd = self.sim_mod.step6_check_boundaries_ions(
                sim.x_i, sim.vx_i, sim.vy_i, sim.vz_i, sim.N_i, self.cs_mod.L,
                sim.ifed_pow, sim.ifed_gnd,
                self.cs_mod.AR_MASS, self.cs_mod.EV_TO_J, self.cs_mod.DE_IFED, self.cs_mod.N_IFED,
                t, self.cs_mod.N_SUB
            )
            sim.N_i_abs_pow += abs_pow
            sim.N_i_abs_gnd += abs_gnd
        else:
            self.sim_mod.step6_check_boundaries_ions(sim, t)
```

---

## 3. Implementacja testów jednostkowych

Wszystkie poniższe testy korzystają z parametryzacji `pytest` i wykonują się po kolei dla wersji: `native_version`, `numpy_version` oraz `numba_version`.

### 3.1 Solver Poissona (`tests/test_poisson.py`)

Testuje potencjał liniowy w próżni, stałe pole elektryczne oraz natężenie pola z uwzględnieniem ładunku przestrzennego na elektrodach.

```python
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

    for i in range(cs.N_G):
        expected = cs.VOLTAGE * (1.0 - i / (cs.N_G - 1))
        assert math.isclose(sim.pot[i], expected, abs_tol=1e-11)
```

---

### 3.2 Depozycja gęstości (`tests/test_density.py`)

Weryfikuje interpolację liniową depozycji cząstek na siatkę oraz podwajanie ładunku na brzegach (boundary corrections).

```python
import pytest
import math
from conftest import SimulationAdapter

@pytest.mark.parametrize("version", ["native_version", "numpy_version", "numba_version"])
def test_boundary_doubling_left(version):
    adapter = SimulationAdapter(version)
    sim = adapter.create_state()
    cs = adapter.cs_mod

    sim.N_e = 1
    sim.x_e[0] = cs.DX * 0.5
    
    adapter.step1_compute_electron_density(sim)

    assert math.isclose(sim.e_density[0], cs.FACTOR_W, abs_tol=1e-2)
    assert math.isclose(sim.e_density[1], 0.5 * cs.FACTOR_W, abs_tol=1e-2)
```

---

### 3.3 Popychanie Leapfrog (`tests/test_push.py`)

Testuje kierunek popychania cząstek dodatnich/ujemnych oraz interpolację pola elektrycznego w połowie komórki siatki.

```python
import pytest
import math
from conftest import SimulationAdapter

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

    assert math.isclose(sim.vx_e[0], expected_v, abs_tol=1e-5)
    assert math.isclose(sim.x_e[0], expected_x, abs_tol=1e-10)
```

---

### 3.4 Absorpcja brzegowa (`tests/test_boundaries.py`)

Testuje algorytm usuwania cząstek metodą `fast-swap` (lub boolean mask, które są zbieżne dla tego testu) oraz zbieranie energii jonów docierających do elektrod do histogramu IFED.

```python
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
    sim.x_e[1] = -0.001;    sim.vx_e[1] = 20.0  # Wykracza poza granicę
    sim.x_e[2] = cs.L * 0.75;  sim.vx_e[2] = 30.0  # Ostatnia cząstka w tablicy

    adapter.step5_check_boundaries_electrons(sim)

    assert sim.N_e == 2
    assert sim.N_e_abs_pow == 1
    assert math.isclose(sim.x_e[1], cs.L * 0.75, abs_tol=1e-12)
```

---

### 3.5 Przekroje czynne (`tests/test_cross_sections.py`)

Testuje poprawność generowania i interpolacji przekrojów czynnych Phelpsa/Petrovica dla Argonu.

```python
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
    assert math.isclose(sim.sigma_tot_e[idx_50], total_macro, rel_tol=1e-7)
```

---

## 4. Testy różnicowe (`tests/test_differential.py`)

Te testy bezpośrednio porównują zachowanie zoptymalizowanych wersji NumPy i Numba z referencyjną wersją Native dla identycznych stanów początkowych cząstek z dokładnością bitową (`1e-15`), gwarantując poprawność wektoryzacji.

```python
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

    for i in range(cs.N_G):
        assert math.isclose(sim_nat.e_density[i], sim_opt.e_density[i], abs_tol=1e-15)
```

---

## 5. Testy regresyjne / Golden Run (`tests/test_regression.py`)

Testy regresyjne weryfikują pełne przebiegi symulacji (krok po kroku, łącznie z MCC kolizjami) przy użyciu deterministycznego zasiewania generatorów losowych (RNG Seeding) oraz zapisu/odczytu stanu symulacji.

Jako że wersje korzystają z innych mechanizmów losowości (`random.Random` w Native, `np.random.default_rng` w NumPy oraz wewnętrzny generator JIT w Numbie), każda wersja posiada **własny, niezależny plik wzorcowy (golden run)** zlokalizowany w `python/tests/regression_gold/{wersja}/conv.dat`.

### 5.1 Seeding i Serializacja RNG (`tests/run_regression.py`)
Skrypt zarządza odtworzeniem stanów generatorów losowych:
* **Native:** `sim.rng.getstate()` / `sim.rng.setstate(state)` z biblioteki standardowej.
* **NumPy:** Zapisuje/odczytuje wewnętrzny stan generatora bitowego: `sim.rng.bit_generator.state`.
* **Numba:** Ponieważ Numba JIT posiada własny, wątkowo-lokalny stan RNG, zasiewamy go poprzez wywołanie skompilowanej funkcji pomocniczej `@numba.njit` w tym samym wątku:
  ```python
  @numba.njit
  def _seed_numba(seed):
      np.random.seed(seed)
  ```
  Zabezpiecza to pełną zbieżność numeryczną.

### 5.2 Integracja z pytest (`tests/test_regression.py`)
Podczas pierwszego uruchomienia (jeśli pliki wzorcowe w `tests/regression_gold/` nie istnieją), test wykonuje automatyczny zapis ("bootstrap") i pomija asercje. Przy każdym kolejnym uruchomieniu test wykonuje pełną symulację i weryfikuje zbieżność z dokładnością do `1e-12` (identyczność co do bita):

```python
# Uruchomienie testów regresyjnych
uv run pytest tests/test_regression.py -s -v
```

---

## 6. Uruchamianie testów i raportowanie

### 6.1 Uruchomienie wszystkich testów
```bash
cd python/
uv run pytest tests/
```

### 6.2 Generowanie interaktywnego raportu HTML
Użycie biblioteki `pytest-html` pozwala na wygenerowanie szczegółowego raportu z podglądem wyliczonych wartości liczbowych (dzięki dodanym wywołaniom `print` w Captured stdout):

```bash
uv run pytest --html=report.html --self-contained-html tests/
```

---

## 7. Checklist walidacji

Wszystkie 35 testów jednostkowych, różnicowych i regresyjnych zostało zaimplementowanych i przechodzi pomyślnie z pełną dokładnością:

| Krok symulacji | Test | Wersja Native | Wersja NumPy | Wersja Numba |
|:---|:---|:---:|:---:|:---:|
| **Poisson** | `test_vacuum_linear_potential` | ✅ | ✅ | ✅ |
| | `test_vacuum_constant_efield` | ✅ | ✅ | ✅ |
| | `test_boundary_efield_with_charge` | ✅ | ✅ | ✅ |
| **Density** | `test_boundary_doubling_left` | ✅ | ✅ | ✅ |
| **Leapfrog** | `test_efield_interpolation_midpoint`| ✅ | ✅ | ✅ |
| **Boundaries** | `test_fast_swap_boundary` | ✅ | ✅ | ✅ |
| **Cross Sections**| `test_phelps_cross_sections` | ✅ | ✅ | ✅ |
| **Differential** | `test_compare_density_deposition` | — | ✅ | ✅ |
| **Regression** | `test_regression_golden_run` | ✅ | ✅ | ✅ |
