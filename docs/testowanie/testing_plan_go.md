# Plan testów — wersja Go

Plik źródłowy: [`Go/native_version/main.go`](../Go/native_version/main.go)  
Framework: wbudowany pakiet [`testing`](https://pkg.go.dev/testing) języka Go.

---

## Spis treści

1. [Architektura testów](#1-architektura-testów)
2. [Konfiguracja środowiska](#2-konfiguracja-środowiska)
3. [Testy regresyjne (golden run)](#3-testy-regresyjne-golden-run)
4. [Testy jednostkowe — Tier 1 (deterministyczne)](#4-testy-jednostkowe--tier-1-deterministyczne)
5. [Testy jednostkowe — Tier 2 (stochastyczne)](#5-testy-jednostkowe--tier-2-stochastyczne)
6. [Uruchamianie testów](#6-uruchamianie-testów)
7. [Checklist](#7-checklist)

---

## 1. Architektura testów

Podobnie jak wersja w C++, kod w Go (`Go/native_version/main.go`) opiera się na zmiennych globalnych zdefiniowanych w pakiecie `main`.

Aby umożliwić uruchamianie testów z zewnętrznego pliku testowego `main_test.go` (który musi należeć do tego samego pakietu `main` lub `main_test`), musimy zadbać o resetowanie stanu globalnego przed każdym testem.

### Helper resetu stanu (`test_helpers.go` lub wewnątrz `main_test.go`)

```go
package main

import (
	"math/rand"
	"github.com/seehuhn/mt19937"
)

// resetState resetuje stan globalny symulacji
func resetState() {
	N_e = 0
	N_i = 0
	N_e_abs_pow = 0
	N_e_abs_gnd = 0
	N_i_abs_pow = 0
	N_i_abs_gnd = 0
	N_e_coll = 0
	N_i_coll = 0
	Time = 0.0

	for i := 0; i < N_G; i++ {
		e_density[i] = 0.0
		i_density[i] = 0.0
		cumul_e_density[i] = 0.0
		cumul_i_density[i] = 0.0
		efield[i] = 0.0
		pot[i] = 0.0
	}
	for i := 0; i < N_EEPF; i++ {
		eepf[i] = 0.0
	}
	for i := 0; i < N_IFED; i++ {
		ifed_pow[i] = 0
		ifed_gnd[i] = 0
	}
}

// seedRNG ustawia stałe ziarno dla generatora mt19937 w celu zachowania determinizmu
func seedRNG(seed int64) {
	// Zakładamy, że w main.go MTgen jest zmienną globalną typu mt19937.Generator
	// Inicjalizujemy stałym ziarnem:
	rng := mt19937.New()
	rng.Seed(seed)
	// MTgen = rng (zależnie od tego jak zdefiniowano globalną zmienną)
}
```

---

## 2. Konfiguracja środowiska

Ponieważ wbudowane narzędzie `go test` wymaga modułów, upewnij się, że jesteś w katalogu modułu Go:
```bash
cd Go/native_version
```

Zależności pobieramy poprzez:
```bash
go mod tidy
```

---

## 3. Testy regresyjne (golden run)

W Go możemy wbudować test regresyjny bezpośrednio jako część pakietu testowego, który wywołuje potok symulacji i weryfikuje wyniki za pomocą plików `density.dat`, `conv.dat` itp.

```go
package main

import (
	"bytes"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"testing"
)

func TestGoldenRegression(t *testing.T) {
	// 1. Skompiluj binarkę testową lub uruchom bezpośrednio main.go z flagą seedowania
	// Aby ułatwić, najlepiej przygotować tryb testowy w main.go (np. flaga CLI lub zmienna środowiskowa):
	// env: EDUPIC_SEED=42
	
	tmpDir, err := ioutil.TempDir("", "edupic_go_test")
	if err != nil {
		t.Fatal(err)
	}
	defer os.RemoveAll(tmpDir)

	// Skopiuj binarkę / uruchom symulację w tymczasowym folderze
	cmdInit := exec.Command("go", "run", "main.go", "0")
	cmdInit.Dir = tmpDir
	cmdInit.Env = append(os.Environ(), "EDUPIC_SEED=42")
	if err := cmdInit.Run(); err != nil {
		t.Fatalf("Błąd inicjalizacji symulacji: %v", err)
	}

	cmdRun := exec.Command("go", "run", "main.go", "5", "m")
	cmdRun.Dir = tmpDir
	cmdRun.Env = append(os.Environ(), "EDUPIC_SEED=42")
	if err := cmdRun.Run(); err != nil {
		t.Fatalf("Błąd uruchomienia 5 cykli: %v", err)
	}

	// Porównanie wyników z golden output
	compareDatFiles(t, filepath.Join(tmpDir, "density.dat"), "golden/density_golden.dat")
	compareDatFiles(t, filepath.Join(tmpDir, "conv.dat"), "golden/conv_golden.dat")
}

func compareDatFiles(t *testing.T, file, golden string) {
	d1, err := ioutil.ReadFile(file)
	if err != nil {
		t.Fatalf("Nie można odczytać pliku testowego %s: %v", file, err)
	}
	d2, err := ioutil.ReadFile(golden)
	if err != nil {
		t.Fatalf("Nie można odczytać pliku golden %s: %v", golden, err)
	}

	if !bytes.Equal(d1, d2) {
		t.Errorf("Plik %s różni się od pliku golden %s", file, golden)
	}
}
```

---

## 4. Testy jednostkowe — Tier 1 (deterministyczne)

### 4.1 `solve_Poisson` — solver Thomasa

```go
package main

import (
	"math"
	"testing"
)

func TestPoisson_VacuumLinearPotential(t *testing.T) {
	resetState()
	
	var rho xvector // zero charge density (próżnia)
	// tt = 0.0 -> pot[0] = VOLTAGE * cos(0) = 250.0
	solve_Poisson(rho, 0.0)

	for i := 1; i < N_G-1; i++ {
		expected := VOLTAGE * (1.0 - float64(i)/float64(N_G-1))
		if math.Abs(pot[i]-expected) > 1e-8 {
			t.Errorf("Węzeł %d: potencjał %f różni się od oczekiwanego %f", i, pot[i], expected)
		}
	}
}

func TestPoisson_VacuumConstantEfield(t *testing.T) {
	resetState()
	var rho xvector
	solve_Poisson(rho, 0.0)

	expectedE := VOLTAGE / L
	for i := 1; i < N_G-2; i++ {
		if math.Abs(efield[i]-expectedE) > 1e-6 {
			t.Errorf("Węzeł %d: pole E %f różni się od oczekiwanego %f", i, efield[i], expectedE)
		}
	}
}

func TestPoisson_BoundaryEfieldWithCharge(t *testing.T) {
	resetState()
	var rho xvector
	rho[0] = 1e15 * E_CHARGE
	rho[N_G-1] = 1e15 * E_CHARGE
	solve_Poisson(rho, 0.0)

	expectedE0 := (pot[0]-pot[1])*INV_DX - rho[0]*DX/(2.0*EPSILON0)
	expectedEN := (pot[N_G-2]-pot[N_G-1])*INV_DX + rho[N_G-1]*DX/(2.0*EPSILON0)

	if math.Abs(efield[0]-expectedE0) > 1e-6 {
		t.Errorf("efield[0] = %f, oczekiwano %f", efield[0], expectedE0)
	}
	if math.Abs(efield[N_G-1]-expectedEN) > 1e-6 {
		t.Errorf("efield[N_G-1] = %f, oczekiwano %f", efield[N_G-1], expectedEN)
	}
}
```

---

### 4.2 Ważenie liniowe (`step1_compute_electron_density`)

```go
func TestDensity_SingleParticleOnNode(t *testing.T) {
	resetState()
	p0 := 100
	x_e[0] = DX * float64(p0)
	N_e = 1

	step1_compute_electron_density()

	if math.Abs(e_density[p0]-FACTOR_W) > 1e-10 {
		t.Errorf("e_density[%d] = %f, oczekiwano %f", p0, e_density[p0], FACTOR_W)
	}
	if e_density[p0+1] != 0.0 || e_density[p0-1] != 0.0 {
		t.Errorf("Gęstość rozlana poza węzeł p0")
	}
}

func TestDensity_BoundaryDoublingLeft(t *testing.T) {
	resetState()
	x_e[0] = DX * 0.5
	N_e = 1

	step1_compute_electron_density()

	// Z korekcją x2 na elektrodzie: e_density[0] = FACTOR_W
	if math.Abs(e_density[0]-FACTOR_W) > 1e-10 {
		t.Errorf("e_density[0] = %f, oczekiwano %f (korekta x2)", e_density[0], FACTOR_W)
	}
}

func TestDensity_IonDensitySubcycling(t *testing.T) {
	resetState()
	x_i[0] = L / 2.0
	N_i = 1

	// t % N_SUB != 0 -> brak deposycji, i_density zostaje zero
	step1_compute_ion_density(1)
	if i_density[N_G/2] != 0.0 {
		t.Errorf("Obliczono i_density mimo braku subcyclingu (t=1)")
	}

	// t % N_SUB == 0 -> wykonuje się deposycja
	step1_compute_ion_density(0)
	if i_density[N_G/2] == 0.0 {
		t.Errorf("Nie obliczono i_density przy t=0")
	}
}
```

---

### 4.3 Ruch cząstek (`step3_move_electrons` / `step4_move_ions`)

```go
func TestPush_ElectronPushSign(t *testing.T) {
	resetState()
	N_e = 1
	x_e[0] = L / 2.0
	vx_e[0], vy_e[0], vz_e[0] = 0.0, 0.0, 0.0

	// Dodatnie pole E -> elektron (ujemny ładunek) musi lecieć w -x
	for i := 0; i < N_G; i++ {
		efield[i] = 1000.0
	}

	step3_move_electrons(0)

	if vx_e[0] >= 0.0 {
		t.Errorf("Elektron w dodatnim polu E poleciał w prawo: vx = %f", vx_e[0])
	}
}

func TestPush_IonPushSign(t *testing.T) {
	resetState()
	N_i = 1
	x_i[0] = L / 2.0
	vx_i[0] = 0.0

	// Dodatnie pole E -> jon (dodatni ładunek) musi lecieć w +x
	for i := 0; i < N_G; i++ {
		efield[i] = 1000.0
	}

	step4_move_ions(0, 0) // t=0 -> subcycling ok

	if vx_i[0] <= 0.0 {
		t.Errorf("Jon w dodatnim polu E nie poleciał w prawo: vx = %f", vx_i[0])
	}
}
```

---

### 4.4 Granice (`step5_check_boundaries_electrons`)

```go
func TestBoundaries_ElectronAbsorbedAtPowered(t *testing.T) {
	resetState()
	N_e = 1
	x_e[0] = -0.001

	step5_check_boundaries_electrons()

	if N_e != 0 {
		t.Errorf("Elektron nie został usunięty z układu")
	}
	if N_e_abs_pow != 1 {
		t.Errorf("Licznik absorpcji na powered elektrodzie nie wzrósł")
	}
}

func TestBoundaries_FastSwap(t *testing.T) {
	resetState()
	N_e = 3
	x_e[0] = L * 0.25
	x_e[1] = -0.001 // do usunięcia
	x_e[2] = L * 0.75
	vx_e[0], vx_e[1], vx_e[2] = 100.0, 200.0, 300.0

	step5_check_boundaries_electrons()

	if N_e != 2 {
		t.Errorf("Oczekiwano N_e = 2, got %d", N_e)
	}
	// Ostatnia cząstka (indeks 2) wskakuje na miejsce indeksu 1
	if x_e[1] != L*0.75 || vx_e[1] != 300.0 {
		t.Errorf("Błąd implementacji fast-swap")
	}
}
```

---

## 5. Testy jednostkowe — Tier 2 (stochastyczne)

```go
func TestCollision_IonizationCreatesPair(t *testing.T) {
	resetState()
	seedRNG(42)
	set_electron_cross_sections_ar()
	set_ion_cross_sections_ar()
	calc_total_cross_sections()

	energy := 30.0 // powyżej progu 15.8 eV
	g := math.Sqrt(2.0 * energy * EV_TO_J / E_MASS)
	eindex := int(energy / DE_CS)

	N_e = 1
	N_i = 0
	x_e[0] = L / 2.0
	vx_e[0] = g

	// Losujemy seed, dopóki nie zajdzie jonizacja (powinna zajść bardzo szybko)
	ionizationOccurred := false
	for trial := int64(0); trial < 500; trial++ {
		seedRNG(trial)
		NeBefore := N_e
		NiBefore := N_i
		collision_electron(x_e[0], &vx_e[0], &vy_e[0], &vz_e[0], eindex)
		if N_e > NeBefore {
			if N_e != NeBefore+1 || N_i != NiBefore+1 {
				t.Fatalf("Nieprawidłowa liczba nowo utworzonych cząstek")
			}
			ionizationOccurred = true
			break
		}
	}

	if !ionizationOccurred {
		t.Errorf("Kolizja jonizacji nie zaszła ani razu w 500 próbach przy 30 eV")
	}
}
```

---

## 6. Uruchamianie testów

Uruchomienie wszystkich testów jednostkowych w pakiecie:
```bash
go test -v
```

Uruchomienie specyficznego testu:
```bash
go test -v -run TestPoisson_VacuumLinearPotential
```

Sprawdzenie pokrycia kodu testami (code coverage):
```bash
go test -coverprofile=coverage.out
go tool cover -html=coverage.out
```

---

## 7. Checklist

| # | Test | Cel | Priorytet | Status |
|:-:|:-----|:----|:---------:|:------:|
| 1 | `TestPoisson_VacuumLinearPotential` | Thomas solver liniowy | 🔴 | ☐ |
| 2 | `TestPoisson_VacuumConstantEfield` | Thomas solver E-pole | 🔴 | ☐ |
| 3 | `TestPoisson_BoundaryEfieldWithCharge` | Thomas solver granice | 🔴 | ☐ |
| 4 | `TestDensity_SingleParticleOnNode` | Depozycja na węźle | 🔴 | ☐ |
| 5 | `TestDensity_BoundaryDoublingLeft` | Korekta x2 na lewej granicy | 🔴 | ☐ |
| 6 | `TestDensity_IonDensitySubcycling` | Subcycling gęstości jonów | 🔴 | ☐ |
| 7 | `TestPush_ElectronPushSign` | Kierunek ruchu elektronu | 🔴 | ☐ |
| 8 | `TestPush_IonPushSign` | Kierunek ruchu jonu | 🔴 | ☐ |
| 9 | `TestBoundaries_ElectronAbsorbedAtPowered` | Absorpcja cząstek | 🔴 | ☐ |
| 10 | `TestBoundaries_FastSwap` | Poprawność fast-swap | 🔴 | ☐ |
| 11 | `TestCollision_IonizationCreatesPair` | MCC jonizacja pary | 🟡 | ☐ |
| R1 | `TestGoldenRegression` | Regresja bit-dla-bitu | 🔴 | ☐ |
