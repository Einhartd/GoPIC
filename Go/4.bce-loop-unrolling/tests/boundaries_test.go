package tests

import (
	"testing"

	"gopic"
)

func TestFastSwapBoundary(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	sim.N_e = 3
	sim.X_e[0] = gopic.L * 0.25
	sim.Vx_e[0] = 10.0
	sim.X_e[1] = -0.001
	sim.Vx_e[1] = 20.0 // Wykracza poza lewą elektrodę
	sim.X_e[2] = gopic.L * 0.75
	sim.Vx_e[2] = 30.0 // Ostatni element w tablicy

	sim.Step5CheckBoundariesElectrons()

	if sim.N_e != 2 {
		t.Errorf("Oczekiwano 2 elektronow w grze, otrzymano %d", sim.N_e)
	}
	if sim.N_e_abs_pow != 1 {
		t.Errorf("Oczekiwano absorpcji 1 elektronu na lewej elektrodzie, otrzymano %d", sim.N_e_abs_pow)
	}
	if !isClose(sim.X_e[1], gopic.L*0.75, 1e-12) {
		t.Errorf("Element z indeksu 2 powinien zastapic element 1. Otrzymano pozycje %f", sim.X_e[1])
	}
}
