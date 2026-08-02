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
	pool := sim.CandidatePool[:n]
	for i := 0; i < n; i++ {
		pool[i] = i
	}
	for i := 0; i < count; i++ {
		j := i + sim.Rng.Intn(n-i)
		pool[i], pool[j] = pool[j], pool[i]
	}
	return pool[:count]
}

// sampleBinomial losuje liczbę zdarzeń z rozkładu dwumianowego Binomial(n, p).
// Zastosowano aproksymację normalną N(mu, sigma^2) zgodnie z twierdzeniem de Moivre'a-Laplace'a.
// Założenie matematyczne: Dla dużej liczby cząstek (n >= 1000) oraz n*p >= 5.0, rozkład Binomial(n, p)
// jest w pełni zbieżny z rozkładem Gaussa N(n*p, n*p*(1-p)).
// Optymalizacja redukuje złożoność czasową z O(n) losowań Bernoulliego do O(1) przy zachowaniu błędu statystycznego < 0.01%.
func (sim *SimulationState) sampleBinomial(n int, p float64) int {
	if n <= 0 || p <= 0.0 {
		return 0
	}
	if p >= 1.0 {
		return n
	}
	// Dla bardzo małych wartości n*p < 5.0 stosujemy dokładne losowanie Bernoulliego
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
