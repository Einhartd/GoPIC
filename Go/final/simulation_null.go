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

// workerSampleBinomial losuje liczbę kandydatów do zderzenia w podzbiorze workera z rozkładu
// dwumianowego Binomial(n, p), używając prywatnego generatora RngWorkers[workerID].
// Dla n*p < 5.0 wykonuje dokładne próby Bernoulliego, a dla większych wartości stosuje
// aproksymację rozkładem normalnym N(n*p, n*p*(1-p)) w czasie stałym O(1).
//
// Parametry:
//   - workerID: identyfikator workera wykonującego losowanie (0 .. NumWorkers-1).
//   - n: liczba cząstek w podzbiorze przypisanym do workera.
//   - p: stałe maksymalne prawdopodobieństwo zderzenia P*.
//
// Zwraca:
//   - wylosowana liczba kandydatów do zderzenia z przedziału [0, n].
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

// Step7CollisionsElectrons zleca workerom równoległe wykonanie zderzeń elektronów metodą Null-Collision,
// a następnie seryjnie przepisuje nowo wygenerowane elektrony i jony z prywatnych buforów workerów
// do globalnych tablic SoA.
func (sim *SimulationState) Step7CollisionsElectrons() {
	if sim.N_e == 0 {
		return
	}

	sim.broadcastAndWait(CmdCollisionsE)

	// Dopisanie nowo utworzonych cząstek z jonizacji do tablic globalnych
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

// Step8CollisionIons zleca workerom równoległe wykonanie zderzeń jonów z atomami tła metodą
// Null-Collision co N_SUB kroków czasowych.
//
// Parametry:
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
//
//go:noinline
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t%N_SUB) != 0 || sim.N_i == 0 {
		return
	}

	sim.broadcastAndWait(CmdCollisionsI)
}
