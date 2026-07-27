//go:build nullcollision

package gopic

import (
	"fmt"
	"math"
)

// InitNullCollision precomputes parameters for null-collision MCC.
func (sim *SimulationState) InitNullCollision() {
	sim.NuStarE = sim.MaxElectronCollFreq()
	sim.PStarE = 1.0 - math.Exp(-sim.NuStarE*DT_E)

	sim.NuStarI = sim.MaxIonCollFreq()
	sim.PStarI = 1.0 - math.Exp(-sim.NuStarI*DT_I)

	fmt.Printf(">> GoPIC: null-collision: nu*_e = %e, P*_e = %e\n", sim.NuStarE, sim.PStarE)
	fmt.Printf(">> GoPIC: null-collision: nu*_i = %e, P*_i = %e\n", sim.NuStarI, sim.PStarI)
}

// randomSample returns count unique indices drawn from [0, n) without replacement.
func (sim *SimulationState) randomSample(n, count int) []int {
	pool := make([]int, n)
	for i := range pool {
		pool[i] = i
	}
	for i := 0; i < count; i++ {
		j := i + sim.Rng.Intn(n-i)
		pool[i], pool[j] = pool[j], pool[i]
	}
	return pool[:count]
}

// sampleBinomial draws a count from Binomial(n, p) using sequential Bernoulli trials.
func (sim *SimulationState) sampleBinomial(n int, p float64) int {
	count := 0
	for i := 0; i < n; i++ {
		if sim.Rng.Float64() < p {
			count++
		}
	}
	return count
}

func (sim *SimulationState) Step7CollisionsElectrons() {
	nCollStar := sim.sampleBinomial(sim.N_e, sim.PStarE)
	if nCollStar > sim.N_e {
		nCollStar = sim.N_e
	}
	if nCollStar == 0 {
		sim.CandidatesE = nil
		return
	}

	sim.CandidatesE = sim.randomSample(sim.N_e, nCollStar)
	sim.broadcastAndWait(CmdCollisionsE)

	// Flush buforów workerów do stanu głównego
	numWorkers := len(sim.WorkerCmdChan)
	for w := 0; w < numWorkers; w++ {
		for _, p := range sim.WorkerNewElectrons[w] {
			sim.X_e[sim.N_e] = p.X
			sim.Vx_e[sim.N_e] = p.Vx
			sim.Vy_e[sim.N_e] = p.Vy
			sim.Vz_e[sim.N_e] = p.Vz
			sim.N_e++
		}
		for _, p := range sim.WorkerNewIons[w] {
			sim.X_i[sim.N_i] = p.X
			sim.Vx_i[sim.N_i] = p.Vx
			sim.Vy_i[sim.N_i] = p.Vy
			sim.Vz_i[sim.N_i] = p.Vz
			sim.N_i++
		}
	}
}

func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	nCollStar := sim.sampleBinomial(sim.N_i, sim.PStarI)
	if nCollStar > sim.N_i {
		nCollStar = sim.N_i
	}
	if nCollStar == 0 {
		sim.CandidatesI = nil
		return
	}

	sim.CandidatesI = sim.randomSample(sim.N_i, nCollStar)
	sim.broadcastAndWait(CmdCollisionsI)
}
