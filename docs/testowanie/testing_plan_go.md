# Plan testów — wersja Go (native_version)

Pliki źródłowe w katalogu: [`Go/native_version/`](../../Go/native_version/)  
Narzędzie testujące: Standardowy moduł Go `testing` (`go test`)

---

## Spis treści

1. [Samouczek: Podstawy testowania w języku Go](#1-samouczek-podstawy-testowania-w-języku-go)
2. [Architektura testów dla GoPIC](#2-architektura-testów-dla-gopic)
3. [Implementacja i Uruchamianie Testów](#3-implementacja-i-uruchamianie-testów)
4. [Kody testów jednostkowych](#4-kody-testów-jednostkowych)
   * [4.1 Solver Poissona (poisson_test.go)](#41-solver-poissona-poisson_testgo)
   * [4.2 Depozycja gęstości (density_test.go)](#42-depozycja-gęstości-density_testgo)
   * [4.3 Popychanie Leapfrog (push_test.go)](#43-popychanie-leapfrog-push_testgo)
   * [4.4 Warunki brzegowe (boundaries_test.go)](#44-warunki-brzegowe-boundaries_testgo)
   * [4.5 Przekroje czynne (cross_sections_test.go)](#45-przekroje-czynne-cross_sections_testgo)
5. [Testy regresyjne / Golden Run (regression_test.go)](#5-testy-regresyjne--golden-run-regression_testgo)
6. [Checklist walidacji](#6-checklist-walidacji)

---

## 1. Samouczek: Podstawy testowania w języku Go

W przeciwieństwie do C++ (GTest) czy Pythona (pytest), Język Go posiada **wbudowane wsparcie dla testów jednostkowych** bezpośrednio w bibliotece standardowej. Nie ma potrzeby instalowania zewnętrznych frameworków.

### 1.1 Konwencje nazewnictwa i lokalizacja plików
1. **Nazwy plików:** Każdy plik testowy musi kończyć się sufiksem `_test.go`.
2. **Pakiety:** Ponieważ przenieśliśmy testy do oddzielnego katalogu `tests/` w celu wdrożenia architektury zbieżnej z Pythonem, testy należą do osobnego pakietu `package tests` i importują główny moduł symulacji (`import "edupic"`).

### 1.2 Struktura funkcji testowej
Każda funkcja testowa musi:
* Zaczynać się od słowa **`Test`** (np. `TestVacuumLinearPotential`).
* Przyjmować parametr `t *testing.T` z wbudowanej biblioteki `testing`.

Przykład minimalnego testu:
```go
package tests

import "testing"

func TestDodawania(t *testing.T) {
    wynik := 2 + 2
    if wynik != 4 {
        t.Errorf("Oczekiwano 4, ale otrzymano %d", wynik)
    }
}
```

### 1.3 Asercje w Go
Do zgłaszania błędów używa się metod obiektu `t`:
* `t.Errorf(format, args...)` — zgłasza błąd testu, ale **nie przerywa** jego wykonywania.
* `t.Fatalf(format, args...)` — zgłasza błąd i **natychmiast przerywa** wykonywanie bieżącego testu.

---

## 2. Architektura testów dla GoPIC

Aby umożliwić izolację testów w osobnym katalogu i uprościć dodawanie kolejnych wersji symulacji (np. parallel/matrix) w przyszłości, przeprowadziliśmy refaktoryzację kodu Go do architektury obiektowej (zbieżnej z wersją w Pythonie):

1. **Struktura `SimulationState`:** Stan symulacji został przeniesiony ze zmiennych globalnych pakietu do pól instancji struktury `SimulationState` w `state.go`.
2. **Metody:** Funkcje kroków symulacji (np. `Step1ComputeElectronDensity`, `SolvePoisson` itp.) stały się metodami struktury `*SimulationState`.
3. **Dynamiczny Seed w run.go:** Normalny bieg symulacji produkcyjnej (`cmd/pic/main.go`) używa dynamicznego ziarna opartego na czasie systemowym (`time.Now().UnixNano()`), dzięki czemu wyniki rzeczywistych symulacji nie są sztucznie powtarzalne.
4. **Dedykowany Runner Regresyjny (`cmd/regression/main.go`):** Aby umożliwić deterministyczne testowanie regresji bez zaśmiecania kodu produkcyjnego, stworzyliśmy osobny program uruchomieniowy. Jest on sztywno zasiewany stałą wartością `67` (zgodnie z silnikiem C++) i potrafi zapisać/odczytać stan RNG do `rng_state.bin`.
5. **Izolacja testów:** Testy zostały umieszczone w osobnym katalogu `Go/native_version/tests/` jako `package tests` i importują moduł `"edupic"`. Rozwiązuje to problem współdzielenia stanu globalnego.

Układ plików:
```
Go/native_version/
├── state.go               ← Struktura SimulationState i metody RNG
├── simulation.go          ← Metody kroków symulacji 1, 3, 4, 5, 6, 7, 8, 9
├── poisson.go             ← Metoda SolvePoisson
├── ... (pliki produkcyjne)
├── cmd/
│   ├── pic/
│   │   └── main.go        ← Punkt wejścia aplikacji produkcyjnej (dynamiczny seed)
│   └── regression/
│       └── main.go        ← Dedykowany runner regresyjny (stały seed, serializacja RNG)
└── tests/                 ← IZOLOWANY KATALOG TESTÓW
    ├── poisson_test.go        ← Testy solvera Poissona
    ├── density_test.go        ← Testy depozycji ładunku
    ├── push_test.go           ← Testy popychania Leapfrog
    ├── boundaries_test.go     ← Testy brzegowe i usuwania
    ├── cross_sections_test.go ← Testy przekrojów czynnych Phelpsa
    ├── regression_test.go     ← Test regresyjny Golden Run (wywołuje runner regresji)
    └── regression_gold/       
        └── conv.dat           ← Plik wzorcowy dla wersji Go
```

---

## 3. Implementacja i Uruchamianie Testów

Przejdź do katalogu modułu Go i wywołaj polecenie `go test`:

```bash
cd Go/native_version/

# Uruchomienie wszystkich testów w katalogu tests
go test -v ./tests
```

---

## 4. Kody testów jednostkowych

### 4.1 Solver Poissona (`Go/native_version/tests/poisson_test.go`)

```go
package tests

import (
	"math"
	"testing"

	"edupic"
)

func isClose(a, b, tol float64) bool {
	return math.Abs(a-b) <= tol
}

func TestVacuumLinearPotential(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	var rho edupic.Xvector // Zerowy ładunek (próżnia)

	sim.SolvePoisson(&rho, 0.0)

	for i := 0; i < edupic.N_G; i++ {
		expected := edupic.VOLTAGE * (1.0 - float64(i)/float64(edupic.N_G-1))
		if !isClose(sim.Pot[i], expected, 1e-11) {
			t.Errorf("Wezel %d: oczekiwano potencjalu %f, otrzymano %f", i, expected, sim.Pot[i])
		}
	}
}

func TestVacuumConstantEfield(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	var rho edupic.Xvector

	sim.SolvePoisson(&rho, 0.0)
	expected_E := edupic.VOLTAGE / edupic.L

	for i := 1; i < edupic.N_G-1; i++ {
		if !isClose(sim.Efield[i], expected_E, 1e-8) {
			t.Errorf("Wezel %d: oczekiwano pola E %f, otrzymano %f", i, expected_E, sim.Efield[i])
		}
	}
}

func TestBoundaryEfieldWithCharge(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	var rho edupic.Xvector
	rho[0] = 1e15 * edupic.E_CHARGE
	rho[edupic.N_G-1] = 2e15 * edupic.E_CHARGE

	sim.SolvePoisson(&rho, 0.0)

	expected_e0 := (sim.Pot[0]-sim.Pot[1])*edupic.INV_DX - rho[0]*edupic.DX/(2.0*edupic.EPSILON0)
	expected_eN := (sim.Pot[edupic.N_G-2]-sim.Pot[edupic.N_G-1])*edupic.INV_DX + rho[edupic.N_G-1]*edupic.DX/(2.0*edupic.EPSILON0)

	if !isClose(sim.Efield[0], expected_e0, 1e-8) {
		t.Errorf("Lewa elektroda: oczekiwano pola %f, otrzymano %f", expected_e0, sim.Efield[0])
	}
	if !isClose(sim.Efield[edupic.N_G-1], expected_eN, 1e-8) {
		t.Errorf("Prawa elektroda: oczekiwano pola %f, otrzymano %f", expected_eN, sim.Efield[edupic.N_G-1])
	}
}
```

---

### 4.2 Depozycja gęstości (`Go/native_version/tests/density_test.go`)

```go
package tests

import (
	"testing"

	"edupic"
)

func TestSingleParticleOnInternalNode(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	p0 := 150
	sim.N_e = 1
	sim.X_e[0] = edupic.DX * float64(p0)

	sim.Step1ComputeElectronDensity()

	if !isClose(sim.E_density[p0], edupic.FACTOR_W, 1e-2) {
		t.Errorf("Wezel %d: oczekiwano gestosci %e, otrzymano %e", p0, edupic.FACTOR_W, sim.E_density[p0])
	}
	if !isClose(sim.E_density[p0+1], 0.0, 1e-2) {
		t.Errorf("Wezel %d: oczekiwano gestosci 0.0, otrzymano %e", p0+1, sim.E_density[p0+1])
	}
}

func TestBoundaryDoublingLeft(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	sim.N_e = 1
	sim.X_e[0] = edupic.DX * 0.5

	sim.Step1ComputeElectronDensity()

	if !isClose(sim.E_density[0], edupic.FACTOR_W, 1e-2) {
		t.Errorf("Wezel 0 (granica): oczekiwano %e, otrzymano %e", edupic.FACTOR_W, sim.E_density[0])
	}
	if !isClose(sim.E_density[1], 0.5*edupic.FACTOR_W, 1e-2) {
		t.Errorf("Wezel 1: oczekiwano %e, otrzymano %e", 0.5*edupic.FACTOR_W, sim.E_density[1])
	}
}
```

---

### 4.3 Popychanie Leapfrog (`Go/native_version/tests/push_test.go`)

```go
package tests

import (
	"testing"

	"edupic"
)

func TestParticlePushSigns(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	sim.N_e = 1
	sim.X_e[0] = edupic.L / 2.0
	sim.Vx_e[0], sim.Vy_e[0], sim.Vz_e[0] = 0.0, 0.0, 0.0

	sim.N_i = 1
	sim.X_i[0] = edupic.L / 2.0
	sim.Vx_i[0], sim.Vy_i[0], sim.Vz_i[0] = 0.0, 0.0, 0.0

	for i := 0; i < edupic.N_G; i++ {
		sim.Efield[i] = 1000.0
	}

	sim.Step3MoveElectrons(0)
	sim.Step4MoveIons(0, 0) // t = 0 (subcycling trigger)

	if sim.Vx_e[0] >= 0.0 {
		t.Errorf("Elektron powinien przyspieszyc w lewo (vx < 0), otrzymano %f", sim.Vx_e[0])
	}
	if sim.Vx_i[0] <= 0.0 {
		t.Errorf("Jon powinien przyspieszyc w prawo (vx > 0), otrzymano %f", sim.Vx_i[0])
	}
}

func TestEfieldInterpolationMidpoint(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	sim.N_e = 1
	p0 := 200
	sim.X_e[0] = edupic.DX * (float64(p0) + 0.5)
	sim.Vx_e[0] = 0.0
	sim.Efield[p0] = 100.0
	sim.Efield[p0+1] = 300.0

	sim.Step3MoveElectrons(0)

	expected_v := -200.0 * edupic.FACTOR_E
	expected_x := edupic.DX*(float64(p0)+0.5) + expected_v*edupic.DT_E

	if !isClose(sim.Vx_e[0], expected_v, 1e-5) {
		t.Errorf("Predkosc: oczekiwano %e, otrzymano %e", expected_v, sim.Vx_e[0])
	}
	if !isClose(sim.X_e[0], expected_x, 1e-10) {
		t.Errorf("Pozycja: oczekiwano %e, otrzymano %e", expected_x, sim.X_e[0])
	}
}
```

---

### 4.4 Warunki brzegowe (`Go/native_version/tests/boundaries_test.go`)

```go
package tests

import (
	"testing"

	"edupic"
)

func TestFastSwapBoundary(t *testing.T) {
	sim := edupic.NewSimulationState(42)
	sim.N_e = 3
	sim.X_e[0] = edupic.L * 0.25;  sim.Vx_e[0] = 10.0
	sim.X_e[1] = -0.001;    sim.Vx_e[1] = 20.0  // Wykracza poza lewą elektrodę
	sim.X_e[2] = edupic.L * 0.75;  sim.Vx_e[2] = 30.0  // Ostatni element w tablicy

	sim.Step5CheckBoundariesElectrons()

	if sim.N_e != 2 {
		t.Errorf("Oczekiwano 2 elektronow w grze, otrzymano %d", sim.N_e)
	}
	if sim.N_e_abs_pow != 1 {
		t.Errorf("Oczekiwano absorpcji 1 elektronu na lewej elektrodzie, otrzymano %d", sim.N_e_abs_pow)
	}
	if !isClose(sim.X_e[1], edupic.L*0.75, 1e-12) {
		t.Errorf("Element z indeksu 2 powinien zastapic element 1. Otrzymano pozycje %f", sim.X_e[1])
	}
}
```

---

### 4.5 Przekroje czynne (`Go/native_version/tests/cross_sections_test.go`)

```go
package tests

import (
	"testing"

	"edupic"
)

func TestPhelpsCrossSections(t *testing.T) {
	sim := edupic.NewSimulationState(42)

	sim.SetElectronCrossSectionsAr()
	sim.SetIonCrossSectionsAr()
	sim.CalcTotalCrossSections()

	idx_50 := int(50.0 / edupic.DE_CS)
	total_macro := (sim.Sigma[edupic.E_ELA][idx_50] + sim.Sigma[edupic.E_EXC][idx_50] + sim.Sigma[edupic.E_ION][idx_50]) * edupic.GAS_DENSITY

	if !isClose(sim.SigmaTotE[idx_50], total_macro, 1e-7) {
		t.Errorf("Oczekiwano makroskopowego przekroju czynnego %f dla energii 50 eV, otrzymano %f", total_macro, sim.SigmaTotE[idx_50])
	}
}
```

---

## 5. Testy regresyjne / Golden Run (`Go/native_version/tests/regression_test.go`)

Testy regresyjne weryfikują pełne, wielocyklowe przebiegi symulacji (krok po kroku z MCC kolizjami).
* **Determinizm RNG w Go:** Za pomocą pakietu `unsafe` rzutujemy wewnętrzny wskaźnik generatora `mt19937.MT19937` na naszą pomocniczą strukturę-cień:
  ```go
  type mt19937Shadow struct {
      State []uint64
      Index int
  }
  ```
  Dzięki temu możemy bez przeszkód zrzucić 312 liczb stanu wewnętrznego Mersenne Twister do pliku `rng_state.bin` w kroku `init` i wczytać je z powrotem w kroku `run`. Daje to pełny, powtarzalny determinizm symulacji rozłożonej na wiele procesów.
* **Wzorzec Golden Run:** Wyjściowy plik zbieżności `conv.dat` jest porównywany z plikiem referencyjnym w katalogu `tests/regression_gold/conv.dat` z dokładnością bitową (`1e-12`).

---

## 6. Checklist walidacji

Wszystkie testy jednostkowe oraz testy regresyjne w Go przechodzą pomyślnie:

| Krok symulacji | Test | Status Go |
|:---|:---|:---:|
| **Poisson** | `test_vacuum_linear_potential` | ✅ |
| | `test_vacuum_constant_efield` | ✅ |
| | `test_boundary_efield_with_charge` | ✅ |
| **Density** | `test_boundary_doubling_left` | ✅ |
| **Leapfrog** | `test_efield_interpolation_midpoint`| ✅ |
| **Boundaries** | `test_fast_swap_boundary` | ✅ |
| **Cross Sections**| `test_phelps_cross_sections` | ✅ |
| **Regression** | `test_regression_golden_run` | ✅ |
