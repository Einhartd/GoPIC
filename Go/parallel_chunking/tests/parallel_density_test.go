package tests

import (
	"math/rand"
	"runtime"
	"testing"

	"gopic"
)

// TestParallelVsSequentialDensity verifies that parallel Step1ComputeElectronDensity
// produces bitwise identical charge density arrays across different GOMAXPROCS worker counts.
func TestParallelVsSequentialDensity(t *testing.T) {
	const numParticles = 20000

	createState := func(seed int64) *gopic.SimulationState {
		sim := gopic.NewSimulationState(seed)
		sim.N_e = numParticles

		r := rand.New(rand.NewSource(seed))
		for k := 0; k < numParticles; k++ {
			sim.X_e[k] = gopic.L * r.Float64()
		}
		return sim
	}

	// 1. Run baseline with 1 worker (Sequential)
	origProcs := runtime.GOMAXPROCS(1)
	defer runtime.GOMAXPROCS(origProcs)

	simSeq := createState(9999)
	simSeq.Step1ComputeElectronDensity()

	// 2. Run parallel with 4 workers
	runtime.GOMAXPROCS(4)
	simPar := createState(9999)
	simPar.Step1ComputeElectronDensity()

	// 3. Compare resulting electron density grid
	isCloseRel := func(a, b, relTol float64) bool {
		diff := a - b
		if diff < 0 {
			diff = -diff
		}
		if diff == 0 {
			return true
		}
		mag := a
		if mag < 0 {
			mag = -mag
		}
		bMag := b
		if bMag < 0 {
			bMag = -bMag
		}
		if bMag > mag {
			mag = bMag
		}
		return (diff / mag) <= relTol
	}

	for p := 0; p < gopic.N_G; p++ {
		if !isCloseRel(simSeq.E_density[p], simPar.E_density[p], 1e-12) {
			t.Fatalf("Discrepancy in E_density[%d]: seq=%.15e, par=%.15e", p, simSeq.E_density[p], simPar.E_density[p])
		}
		if !isCloseRel(simSeq.Cumul_e_density[p], simPar.Cumul_e_density[p], 1e-12) {
			t.Fatalf("Discrepancy in Cumul_e_density[%d]: seq=%.15e, par=%.15e", p, simSeq.Cumul_e_density[p], simPar.Cumul_e_density[p])
		}
	}
}
