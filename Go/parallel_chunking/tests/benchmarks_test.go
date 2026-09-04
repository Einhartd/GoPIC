package tests

import (
	"math/rand"
	"testing"

	"gopic"
)

// setupTestSimulation tworzy przygotowany stan symulacji z prekompilowanymi przekrojami czynnymi
func setupTestSimulation(seed int64, numParticles int) *gopic.SimulationState {
	sim := gopic.NewSimulationState(seed, 4)
	sim.N_e = numParticles
	sim.N_i = numParticles
	sim.Measurement_mode = false

	sim.SetElectronCrossSectionsAr()
	sim.SetIonCrossSectionsAr()
	sim.CalcTotalCrossSections()
	sim.InitNullCollision()

	r := rand.New(rand.NewSource(seed))
	for k := 0; k < numParticles; k++ {
		sim.X_e[k] = gopic.L * r.Float64()
		sim.Vx_e[k] = (r.Float64() - 0.5) * 1e6
		sim.Vy_e[k] = (r.Float64() - 0.5) * 1e6
		sim.Vz_e[k] = (r.Float64() - 0.5) * 1e6

		sim.X_i[k] = gopic.L * r.Float64()
		sim.Vx_i[k] = (r.Float64() - 0.5) * 1e4
		sim.Vy_i[k] = (r.Float64() - 0.5) * 1e4
		sim.Vz_i[k] = (r.Float64() - 0.5) * 1e4
	}

	for p := 0; p < gopic.N_G; p++ {
		sim.Efield[p] = 1000.0 * (float64(p) - float64(gopic.N_G)/2.0)
	}

	return sim
}

// TestZeroAllocationsInTimeStep bada liczbę alokacji sterty na krok obliczeniowy
func TestZeroAllocationsInTimeStep(t *testing.T) {
	sim := setupTestSimulation(42, 10000)

	t.Run("Step2SolvePoisson", func(t *testing.T) {
		allocs := testing.AllocsPerRun(20, func() {
			sim.Step2SolvePoisson(0.0)
		})
		if allocs != 0 {
			t.Errorf("Step2SolvePoisson alokuje na stercie: %.2f allocs/run", allocs)
		}
	})

	t.Run("Step3MoveElectrons_FastPath", func(t *testing.T) {
		allocs := testing.AllocsPerRun(20, func() {
			sim.Step3MoveElectrons(0)
		})
		t.Logf("Step3MoveElectrons (Fast-Path, 4-way unrolled): %.2f allocs/run", allocs)
	})

	t.Run("Step4MoveIons_FastPath", func(t *testing.T) {
		allocs := testing.AllocsPerRun(20, func() {
			sim.Step4MoveIons(0, 0)
		})
		t.Logf("Step4MoveIons (Fast-Path, 4-way unrolled): %.2f allocs/run", allocs)
	})

	t.Run("Step7CollisionsElectrons", func(t *testing.T) {
		allocs := testing.AllocsPerRun(20, func() {
			sim.Step7CollisionsElectrons()
		})
		t.Logf("Step7CollisionsElectrons (Null-Collision): %.2f allocs/run", allocs)
	})

	t.Run("Step8CollisionIons", func(t *testing.T) {
		allocs := testing.AllocsPerRun(20, func() {
			sim.Step8CollisionIons(0)
		})
		t.Logf("Step8CollisionIons (Fast-Path I_BACK): %.2f allocs/run", allocs)
	})
}

// Benchmark dla 100 000 elektronów w Leap-Frog
func BenchmarkStep3MoveElectrons(b *testing.B) {
	sim := setupTestSimulation(42, 100000)
	b.ResetTimer()
	b.ReportAllocs()
	for i := 0; i < b.N; i++ {
		sim.Step3MoveElectrons(0)
	}
}

// Benchmark dla 100 000 jonów w Leap-Frog
func BenchmarkStep4MoveIons(b *testing.B) {
	sim := setupTestSimulation(42, 100000)
	b.ResetTimer()
	b.ReportAllocs()
	for i := 0; i < b.N; i++ {
		sim.Step4MoveIons(0, 0)
	}
}

// Benchmark zderzeń zerowych elektronów (Null-Collision)
func BenchmarkStep7CollisionsElectrons(b *testing.B) {
	sim := setupTestSimulation(42, 100000)
	b.ResetTimer()
	b.ReportAllocs()
	for i := 0; i < b.N; i++ {
		sim.Step7CollisionsElectrons()
	}
}

// Benchmark zderzeń zerowych jonów z Fast-Path I_BACK
func BenchmarkStep8CollisionIons(b *testing.B) {
	sim := setupTestSimulation(42, 100000)
	b.ResetTimer()
	b.ReportAllocs()
	for i := 0; i < b.N; i++ {
		sim.Step8CollisionIons(0)
	}
}
