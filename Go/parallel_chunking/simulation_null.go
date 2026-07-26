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
					atomic.AddUint64(&sim.N_e_coll, 1)
				}
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
					atomic.AddUint64(&sim.N_i_coll, 1)
				}
			}
		})
	}
	wg.Wait()
}
