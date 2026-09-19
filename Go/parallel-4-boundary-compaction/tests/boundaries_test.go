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

func TestFastSwapBoundaryIons(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	sim.N_i = 4
	sim.X_i[0] = -0.001          // pochłonięty na lewej elektrodzie (pow)
	sim.Vx_i[0] = 1000.0
	sim.X_i[1] = gopic.L * 0.5   // w środku
	sim.Vx_i[1] = 2000.0
	sim.X_i[2] = gopic.L * 0.75  // w środku
	sim.Vx_i[2] = 3000.0
	sim.X_i[3] = gopic.L + 0.001 // pochłonięty na prawej elektrodzie (gnd)
	sim.Vx_i[3] = 4000.0

	// Step6 wykonuje się co N_SUB kroków; dla t = 0 warunek (t % N_SUB == 0) jest spełniony
	sim.Step6CheckBoundariesIons(0)

	if sim.N_i != 2 {
		t.Errorf("Oczekiwano 2 jonow w grze, otrzymano %d", sim.N_i)
	}
	if sim.N_i_abs_pow != 1 {
		t.Errorf("Oczekiwano absorpcji 1 jonu na elektrodzie zasilanej, otrzymano %d", sim.N_i_abs_pow)
	}
	if sim.N_i_abs_gnd != 1 {
		t.Errorf("Oczekiwano absorpcji 1 jonu na elektrodzie uziemionej, otrzymano %d", sim.N_i_abs_gnd)
	}
	// Indeks 0 (pochłonięty) powinien zostać zastąpiony przez indeks 2 (ostatni żywy element)
	if !isClose(sim.X_i[0], gopic.L*0.75, 1e-12) {
		t.Errorf("Element z indeksu 2 powinien zastapic element 0. Otrzymano pozycje %f", sim.X_i[0])
	}
	// Indeks 1 nie powinien ulec zmianie
	if !isClose(sim.X_i[1], gopic.L*0.5, 1e-12) {
		t.Errorf("Element 1 powinien pozostac na pozycji %f, otrzymano %f", gopic.L*0.5, sim.X_i[1])
	}
}

