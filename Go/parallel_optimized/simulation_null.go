package gopic

import (
	"fmt"
	"math"
)

func (sim *SimulationState) InitNullCollision() {
	sim.NuStarE = sim.MaxElectronCollFreq()
	sim.PStarE = 1.0 - math.Exp(-sim.NuStarE*DT_E)

	sim.NuStarI = sim.MaxIonCollFreq()
	sim.PStarI = 1.0 - math.Exp(-sim.NuStarI*DT_I)

	fmt.Printf(">> GoPIC: null-collision: nu*_e = %e, P*_e = %e\n", sim.NuStarE, sim.PStarE)
	fmt.Printf(">> GoPIC: null-collision: nu*_i = %e, P*_i = %e\n", sim.NuStarI, sim.PStarI)
}

func (sim *SimulationState) workerSampleBinomial(workerID, n int, p float64) int {
	if n <= 0 || p <= 0.0 {
		return 0
	}
	if p >= 1.0 {
		return n
	}
	rng := sim.RngWorkers[workerID]
	if float64(n)*p < 5.0 {
		count := 0
		for i := 0; i < n; i++ {
			if rng.Float64() < p {
				count++
			}
		}
		return count
	}

	mu := float64(n) * p
	sigma := math.Sqrt(float64(n) * p * (1.0 - p))
	count := int(math.Round(mu + sigma*rng.NormFloat64()))

	if count < 0 {
		return 0
	}
	if count > n {
		return n
	}
	return count
}

func (sim *SimulationState) sampleBinomial(n int, p float64) int {
	if n <= 0 || p <= 0.0 {
		return 0
	}
	if p >= 1.0 {
		return n
	}
	if float64(n)*p < 5.0 {
		count := 0
		for i := 0; i < n; i++ {
			if sim.Rng.Float64() < p {
				count++
			}
		}
		return count
	}

	mu := float64(n) * p
	sigma := math.Sqrt(float64(n) * p * (1.0 - p))
	count := int(math.Round(mu + sigma*sim.Rng.NormFloat64()))

	if count < 0 {
		return 0
	}
	if count > n {
		return n
	}
	return count
}

func (sim *SimulationState) Step7CollisionsElectrons() {
	if sim.N_e == 0 {
		return
	}

	sim.broadcastAndWait(CmdCollisionsE)

	created := false
	for w := 0; w < sim.NumWorkers; w++ {
		for _, p := range sim.WorkerNewElectrons[w] {
			sim.X_e[sim.N_e] = p.X
			sim.Vx_e[sim.N_e] = p.Vx
			sim.Vy_e[sim.N_e] = p.Vy
			sim.Vz_e[sim.N_e] = p.Vz
			sim.N_e++
			created = true
		}
		for _, p := range sim.WorkerNewIons[w] {
			sim.X_i[sim.N_i] = p.X
			sim.Vx_i[sim.N_i] = p.Vx
			sim.Vy_i[sim.N_i] = p.Vy
			sim.Vz_i[sim.N_i] = p.Vz
			sim.N_i++
			created = true
		}
	}
	if created {
		sim.UpdateChunkSizes()
	}
}

//go:noinline
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t%N_SUB) != 0 || sim.N_i == 0 {
		return
	}

	sim.broadcastAndWait(CmdCollisionsI)
}
