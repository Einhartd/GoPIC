package tests

import (
	"math"
	"testing"

	"gopic"
)

func isClose(a, b, tol float64) bool {
	return math.Abs(a-b) <= tol
}

func TestVacuumLinearPotential(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	var rho gopic.Xvector // Zerowy ładunek (próżnia)

	sim.SolvePoisson(&rho, 0.0)

	for i := 0; i < gopic.N_G; i++ {
		expected := gopic.VOLTAGE * (1.0 - float64(i)/float64(gopic.N_G-1))
		if !isClose(sim.Pot[i], expected, 1e-11) {
			t.Errorf("Wezel %d: oczekiwano potencjalu %f, otrzymano %f", i, expected, sim.Pot[i])
		}
	}
}

func TestVacuumConstantEfield(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	var rho gopic.Xvector

	sim.SolvePoisson(&rho, 0.0)
	expected_E := gopic.VOLTAGE / gopic.L

	for i := 1; i < gopic.N_G-1; i++ {
		if !isClose(sim.Efield[i], expected_E, 1e-8) {
			t.Errorf("Wezel %d: oczekiwano pola E %f, otrzymano %f", i, expected_E, sim.Efield[i])
		}
	}
}

func TestBoundaryEfieldWithCharge(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	var rho gopic.Xvector
	rho[0] = 1e15 * gopic.E_CHARGE
	rho[gopic.N_G-1] = 2e15 * gopic.E_CHARGE

	sim.SolvePoisson(&rho, 0.0)

	expected_e0 := (sim.Pot[0]-sim.Pot[1])*gopic.INV_DX - rho[0]*gopic.DX/(2.0*gopic.EPSILON0)
	expected_eN := (sim.Pot[gopic.N_G-2]-sim.Pot[gopic.N_G-1])*gopic.INV_DX + rho[gopic.N_G-1]*gopic.DX/(2.0*gopic.EPSILON0)

	if !isClose(sim.Efield[0], expected_e0, 1e-8) {
		t.Errorf("Lewa elektroda: oczekiwano pola %f, otrzymano %f", expected_e0, sim.Efield[0])
	}
	if !isClose(sim.Efield[gopic.N_G-1], expected_eN, 1e-8) {
		t.Errorf("Prawa elektroda: oczekiwano pola %f, otrzymano %f", expected_eN, sim.Efield[gopic.N_G-1])
	}
}
