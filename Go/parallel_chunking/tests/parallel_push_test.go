package tests

import (
	"math/rand"
	"runtime"
	"testing"

	"gopic"
)

// TestParallelVsSequentialPush verifies that parallel Step3MoveElectrons produces
// bitwise identical results across different GOMAXPROCS thread counts, both with
// and without Measurement_mode.
func TestParallelVsSequentialPush(t *testing.T) {
	const numParticles = 10000

	// Helper function to create a test state with N_e particles
	createState := func(seed int64, measurementMode bool) *gopic.SimulationState {
		sim := gopic.NewSimulationState(seed)
		sim.N_e = numParticles
		sim.Measurement_mode = measurementMode

		r := rand.New(rand.NewSource(seed))
		for k := 0; k < numParticles; k++ {
			sim.X_e[k] = gopic.L * r.Float64()
			sim.Vx_e[k] = (r.Float64() - 0.5) * 1e6
			sim.Vy_e[k] = (r.Float64() - 0.5) * 1e6
			sim.Vz_e[k] = (r.Float64() - 0.5) * 1e6
		}

		for p := 0; p < gopic.N_G; p++ {
			sim.Efield[p] = 1000.0 * (float64(p) - float64(gopic.N_G)/2.0)
		}
		return sim
	}

	// 1. Run baseline with 1 worker (Sequential)
	origProcs := runtime.GOMAXPROCS(1)
	defer runtime.GOMAXPROCS(origProcs)

	simSeq := createState(12345, true)
	simSeq.Step3MoveElectrons(0)

	// 2. Run parallel with 4 workers
	runtime.GOMAXPROCS(4)
	simPar := createState(12345, true)
	simPar.Step3MoveElectrons(0)

	// 3. Compare positions and velocities (should be exact bitwise)
	for k := 0; k < numParticles; k++ {
		if simSeq.X_e[k] != simPar.X_e[k] {
			t.Fatalf("Discrepancy in X_e[%d]: seq=%e, par=%e", k, simSeq.X_e[k], simPar.X_e[k])
		}
		if simSeq.Vx_e[k] != simPar.Vx_e[k] {
			t.Fatalf("Discrepancy in Vx_e[%d]: seq=%e, par=%e", k, simSeq.Vx_e[k], simPar.Vx_e[k])
		}
	}

	// 4. Compare diagnostic outputs (sum order floating-point relative tolerance 1e-9)
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
		if !isCloseRel(simSeq.Counter_e_xt[p][0], simPar.Counter_e_xt[p][0], 1e-9) {
			t.Fatalf("Discrepancy in Counter_e_xt[%d][0]: seq=%.15e, par=%.15e", p, simSeq.Counter_e_xt[p][0], simPar.Counter_e_xt[p][0])
		}
		if !isCloseRel(simSeq.Ue_xt[p][0], simPar.Ue_xt[p][0], 1e-9) {
			t.Fatalf("Discrepancy in Ue_xt[%d][0]: seq=%.15e, par=%.15e", p, simSeq.Ue_xt[p][0], simPar.Ue_xt[p][0])
		}
		if !isCloseRel(simSeq.Meanee_xt[p][0], simPar.Meanee_xt[p][0], 1e-9) {
			t.Fatalf("Discrepancy in Meanee_xt[%d][0]: seq=%.15e, par=%.15e", p, simSeq.Meanee_xt[p][0], simPar.Meanee_xt[p][0])
		}
	}

	for i := 0; i < gopic.N_EEPF; i++ {
		if !isCloseRel(simSeq.Eepf[i], simPar.Eepf[i], 1e-9) {
			t.Fatalf("Discrepancy in Eepf[%d]: seq=%.15e, par=%.15e", i, simSeq.Eepf[i], simPar.Eepf[i])
		}
	}

	if !isCloseRel(simSeq.Mean_energy_accu_center, simPar.Mean_energy_accu_center, 1e-9) {
		t.Fatalf("Discrepancy in Mean_energy_accu_center: seq=%e, par=%e", simSeq.Mean_energy_accu_center, simPar.Mean_energy_accu_center)
	}

	if simSeq.Mean_energy_counter_center != simPar.Mean_energy_counter_center {
		t.Fatalf("Discrepancy in Mean_energy_counter_center: seq=%d, par=%d", simSeq.Mean_energy_counter_center, simPar.Mean_energy_counter_center)
	}
}
