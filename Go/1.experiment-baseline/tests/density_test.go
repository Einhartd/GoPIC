package tests

import (
	"testing"

	"gopic"
)

func TestSingleParticleOnInternalNode(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	p0 := 150
	sim.N_e = 1
	sim.X_e[0] = gopic.DX * float64(p0)

	sim.Step1ComputeElectronDensity()

	if !isClose(sim.E_density[p0], gopic.FACTOR_W, 1e-2) {
		t.Errorf("Wezel %d: oczekiwano gestosci %e, otrzymano %e", p0, gopic.FACTOR_W, sim.E_density[p0])
	}
	if !isClose(sim.E_density[p0+1], 0.0, 1e-2) {
		t.Errorf("Wezel %d: oczekiwano gestosci 0.0, otrzymano %e", p0+1, sim.E_density[p0+1])
	}
}

func TestBoundaryDoublingLeft(t *testing.T) {
	sim := gopic.NewSimulationState(42)
	sim.N_e = 1
	sim.X_e[0] = gopic.DX * 0.5

	sim.Step1ComputeElectronDensity()

	if !isClose(sim.E_density[0], gopic.FACTOR_W, 1e-2) {
		t.Errorf("Wezel 0 (granica): oczekiwano %e, otrzymano %e", gopic.FACTOR_W, sim.E_density[0])
	}
	if !isClose(sim.E_density[1], 0.5*gopic.FACTOR_W, 1e-2) {
		t.Errorf("Wezel 1: oczekiwano %e, otrzymano %e", 0.5*gopic.FACTOR_W, sim.E_density[1])
	}
}
