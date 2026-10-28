//go:build nullcollision

package gopic

import (
	"fmt"
	"math"
)

// InitNullCollision oblicza i inicjalizuje globalne parametry metody zderzeń zerowych (Null-Collision):
// maksymalne częstości zderzeń (NuStarE, NuStarI) oraz odpowiadające im stałe maksymalne
// prawdopodobieństwa zderzenia w pojedynczym kroku czasowym (PStarE, PStarI).
func (sim *SimulationState) InitNullCollision() {
	sim.NuStarE = sim.MaxElectronCollFreq()
	sim.PStarE = 1.0 - math.Exp(-sim.NuStarE*DT_E)

	sim.NuStarI = sim.MaxIonCollFreq()
	sim.PStarI = 1.0 - math.Exp(-sim.NuStarI*DT_I)

	fmt.Printf(">> GoPIC: null-collision: nu*_e = %e, P*_e = %e\n", sim.NuStarE, sim.PStarE)
	fmt.Printf(">> GoPIC: null-collision: nu*_i = %e, P*_i = %e\n", sim.NuStarI, sim.PStarI)
}

// randomSample losuje bez zwracania podzbiór unikalnych indeksów z przedziału [0, n)
// za pomocą częściowego tasowania Fishera-Yatesa.
//
// Parametry:
//   - n: rozmiar całej populacji cząstek.
//   - count: liczba unikalnych indeksów do wylosowania.
//
// Zwraca:
//   - wycinek zawierający wylosowane indeksy kandydatów do zderzenia.
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

// sampleBinomial losuje liczbę kandydatów do zderzenia z rozkładu dwumianowego Binomial(n, p).
// Dla małych wartości oczekiwanych (n*p < 5.0) wykonuje dokładne próby Bernoulliego, natomiast
// dla większych populacji stosuje aproksymację rozkładem normalnym N(n*p, n*p*(1-p)) w czasie O(1).
//
// Parametry:
//   - n: liczba aktywnych cząstek w populacji.
//   - p: stałe maksymalne prawdopodobieństwo zderzenia P*.
//
// Zwraca:
//   - wylosowana liczba kandydatów do zderzenia z przedziału [0, n].
func (sim *SimulationState) sampleBinomial(n int, p float64) int {
	if n <= 0 || p <= 0.0 {
		return 0
	}
	if p >= 1.0 {
		return n
	}
	// Dokładne losowanie Bernoulliego dla małej oczekiwanej liczby zdarzeń (n*p < 5.0)
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

// Step7CollisionsElectrons realizuje zderzenia elektronów metodą Null-Collision.
// Losuje liczbę kandydatów z rozkładu dwumianowego Binomial(N_e, PStarE), wybiera losowe elektrony
// i przeprowadza test akceptacji z prawdopodobieństwem pAccept = nu(E) / NuStarE.
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

// Step8CollisionIons realizuje zderzenia jonów z atomami tła metodą Null-Collision co N_SUB kroków.
// Losuje liczbę kandydatów z rozkładu dwumianowego Binomial(N_i, PStarI) i przeprowadza test
// akceptacji pAccept = nu(E) / NuStarI z uwzględnieniem losowej prędkości termicznej atomu Ar.
//
// Parametry:
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
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
