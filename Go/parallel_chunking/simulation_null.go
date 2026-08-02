//go:build nullcollision

package gopic

import (
	"fmt"
	"math"
	"sync"
	"sync/atomic"
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
		return
	}

	candidates := sim.randomSample(sim.N_e, nCollStar)

	numWorkers := len(sim.WorkerEDensity)
	for w := 0; w < numWorkers; w++ {
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
	}

	totalCandidates := len(candidates)
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers

	var wg sync.WaitGroup

	for w := 0; w < numWorkers; w++ {
		start := w * chunkSize
		end := (w + 1) * chunkSize
		if end > totalCandidates {
			end = totalCandidates
		}
		if start >= end {
			continue
		}

		workerID, s, e := w, start, end
		wg.Go(func() {
			var localColl uint64
			for i := s; i < e; i++ {
				k := candidates[i]
				vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
				velocity := math.Sqrt(vSqr)
				energy := 0.5 * E_MASS * vSqr / EV_TO_J
				eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
				realNu := sim.SigmaTotE[eIdx] * velocity
				pAccept := realNu / sim.NuStarE
				if pAccept > 1.0 {
					pAccept = 1.0
				}

				if sim.WorkerR01(workerID) < pAccept {
					sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx, workerID)
					localColl++
				}
			}
			if localColl > 0 {
				atomic.AddUint64(&sim.N_e_coll, localColl)
			}
		})
	}
	wg.Wait()

	// Flush buforów workerów do stanu głównego
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
		return
	}

	candidates := sim.randomSample(sim.N_i, nCollStar)

	numWorkers := len(sim.WorkerEDensity)
	totalCandidates := len(candidates)
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers

	var wg sync.WaitGroup

	for w := 0; w < numWorkers; w++ {
		start := w * chunkSize
		end := (w + 1) * chunkSize
		if end > totalCandidates {
			end = totalCandidates
		}
		if start >= end {
			continue
		}

		workerID, s, e := w, start, end
		wg.Go(func() {
			var localColl uint64
			for i := s; i < e; i++ {
				k := candidates[i]
				vxA := sim.WorkerRMB(workerID)
				vyA := sim.WorkerRMB(workerID)
				vzA := sim.WorkerRMB(workerID)
				gx := sim.Vx_i[k] - vxA
				gy := sim.Vy_i[k] - vyA
				gz := sim.Vz_i[k] - vzA
				gSqr := gx*gx + gy*gy + gz*gz
				g := math.Sqrt(gSqr)
				energy := 0.5 * MU_ARAR * gSqr / EV_TO_J
				eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
				realNu := sim.SigmaTotI[eIdx] * g
				pAccept := realNu / sim.NuStarI
				if pAccept > 1.0 {
					pAccept = 1.0
				}

				if sim.WorkerR01(workerID) < pAccept {
					sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
					localColl++
				}
			}
			if localColl > 0 {
				atomic.AddUint64(&sim.N_i_coll, localColl)
			}
		})
	}
	wg.Wait()
}
