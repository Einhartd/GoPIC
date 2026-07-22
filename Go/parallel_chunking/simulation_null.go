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
		return
	}

	candidates := sim.randomSample(sim.N_e, nCollStar)

	for _, k := range candidates {
		vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
		velocity := math.Sqrt(vSqr)
		energy := 0.5 * E_MASS * vSqr / EV_TO_J
		eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
		realNu := sim.SigmaTotE[eIdx] * velocity
		pAccept := realNu / sim.NuStarE
		if pAccept > 1.0 {
			pAccept = 1.0
		}

		if sim.Rng.Float64() < pAccept {
			sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx)
			sim.N_e_coll++
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

	for _, k := range candidates {
		vxA := sim.RMB()
		vyA := sim.RMB()
		vzA := sim.RMB()
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

		if sim.Rng.Float64() < pAccept {
			sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx)
			sim.N_i_coll++
		}
	}
}
