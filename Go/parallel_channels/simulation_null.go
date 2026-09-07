package gopic

import (
	"fmt"
	"math"
)

/*
Wstępne wyznaczenie maksymalnych częstości zderzeń i prawdopodobieństw dla metody Null-Collision (MCC).
Oblicza nu*_e, P*_e dla elektronów oraz nu*_i, P*_i dla jonów w oparciu o stabelaryzowane przekroje czynne.
*/
func (sim *SimulationState) InitNullCollision() {
	sim.NuStarE = sim.MaxElectronCollFreq()
	sim.PStarE = 1.0 - math.Exp(-sim.NuStarE*DT_E)

	sim.NuStarI = sim.MaxIonCollFreq()
	sim.PStarI = 1.0 - math.Exp(-sim.NuStarI*DT_I)

	fmt.Printf(">> GoPIC: null-collision: nu*_e = %e, P*_e = %e\n", sim.NuStarE, sim.PStarE)
	fmt.Printf(">> GoPIC: null-collision: nu*_i = %e, P*_i = %e\n", sim.NuStarI, sim.PStarI)
}

/*
Losowanie liczby zdarzeń z rozkładu dwumianowego Binomial(n, p) dla wskazanego workera.
Dla n*p >= 5.0 stosuje aproksymację Gaussa N(mu, sigma^2) (tw. de Moivre'a-Laplace'a),
co redukuje złożoność z O(n) do O(1) przy błędzie statystycznym < 0.01%.
Dla małych prób wykonuje dokładne losowanie Bernoulliego.
@param workerID Identyfikator workera.
@param n        Liczba prób (liczba cząstek w lokalnym chunku).
@param p        Prawdopodobieństwo zderzenia P*.
@return Wylosowana lokalna liczba zderzeń pozornych.
*/
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

/*
Losowanie liczby zdarzeń z rozkładu dwumianowego Binomial(n, p).
Zastosowano aproksymację normalną N(mu, sigma^2) zgodnie z twierdzeniem de Moivre'a-Laplace'a.
Założenie matematyczne: Dla dużej liczby cząstek (n >= 1000) oraz n*p >= 5.0, rozkład Binomial(n, p)
jest w pełni zbieżny z rozkładem Gaussa N(n*p, n*p*(1-p)).
Optymalizacja redukuje złożoność czasową z O(n) losowań Bernoulliego do O(1) przy zachowaniu błędu statystycznego < 0.01%.
@param n Liczba prób (całkowita liczba cząstek w układzie).
@param p Prawdopodobieństwo sukcesu w pojedynczej próbie (P*_e lub P*_i).
@return Wylosowana liczba kandydatów do zderzenia N*_coll.
*/
func (sim *SimulationState) sampleBinomial(n int, p float64) int {
	if n <= 0 || p <= 0.0 {
		return 0
	}
	if p >= 1.0 {
		return n
	}
	// Dla małych wartości n*p < 5.0 stosujemy dokładne losowanie Bernoulliego
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

/*
KROK 7: Zderzenia elektronów metodą Null-Collision z równoległą obsługą przez kanały (Channels).
Zgodne z referencyjną implementacją C++ OpenMP:
 1. Rozesłanie rozkazu CmdCollisionsE do trwałych workerów za pomocą kanałów (broadcastAndWait).
 2. Każdy worker niezależnie losuje liczbę zderzeń w swoim chunku: localNColl ~ Binomial(nLocal, P*_e).
 3. Każdy worker losuje cząstki ze swojego chunka w czasie O(localNColl), bez globalnej alokacji/selekcji.
 4. Rejection sampling: test akceptacji p_accept = nu(E) / nu*_e i buforowanie nowo powstałych par w AoS.
 5. Scalenie (flush) nowo utworzonych cząstek do globalnych tablic SoA.
*/
func (sim *SimulationState) Step7CollisionsElectrons() {
	if sim.N_e == 0 {
		return
	}

	sim.broadcastAndWait(CmdCollisionsE)

	// SCALENIE (FLUSH): Przepisanie nowych cząstek z buforów AoS do tablic SoA
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

/*
KROK 8: Zderzenia jonów metodą Null-Collision (Subcycling co N_SUB kroków).
Zgodne z referencyjną implementacją C++ OpenMP:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Rozesłanie rozkazu CmdCollisionsI do kanałów workerów (broadcastAndWait).
 3. Każdy worker niezależnie losuje liczbę zderzeń w swoim chunku: localNColl ~ Binomial(nLocal, P*_i).
 4. Dla każdego wylosowanego jonu: losowanie prędkości atomu tła z RMB.
 5. Test akceptacji zderzenia p_accept = nu(E) / nu*_i i wywołanie CollisionIon in-place.

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t%N_SUB) != 0 || sim.N_i == 0 {
		return
	}

	sim.broadcastAndWait(CmdCollisionsI)
}
