package tests

import (
	"testing"

	"gopic"
)

func TestParticlePushSigns(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	sim.N_e = 1
	sim.X_e[0] = gopic.L / 2.0
	sim.Vx_e[0], sim.Vy_e[0], sim.Vz_e[0] = 0.0, 0.0, 0.0

	sim.N_i = 1
	sim.X_i[0] = gopic.L / 2.0
	sim.Vx_i[0], sim.Vy_i[0], sim.Vz_i[0] = 0.0, 0.0, 0.0

	for i := 0; i < gopic.N_G; i++ {
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
	sim := gopic.NewSimulationState(42)
	sim.N_e = 1
	p0 := 200
	sim.X_e[0] = gopic.DX * (float64(p0) + 0.5)
	sim.Vx_e[0] = 0.0
	sim.Efield[p0] = 100.0
	sim.Efield[p0+1] = 300.0

	sim.Step3MoveElectrons(0)

	expected_v := -200.0 * gopic.FACTOR_E
	expected_x := gopic.DX*(float64(p0)+0.5) + expected_v*gopic.DT_E

	if !isClose(sim.Vx_e[0], expected_v, 1e-5) {
		t.Errorf("Predkosc: oczekiwano %e, otrzymano %e", expected_v, sim.Vx_e[0])
	}
	if !isClose(sim.X_e[0], expected_x, 1e-10) {
		t.Errorf("Pozycja: oczekiwano %e, otrzymano %e", expected_x, sim.X_e[0])
	}
}
