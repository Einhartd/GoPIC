package gopic

import (
	"fmt"
	"math"
	"sync"
	"sync/atomic"
)

/*
Inicjalizacja parametrów metody Null-Collision dla elektronów i jonów.
Wyznacza maksymalne częstości zderzeń nu*_e, nu*_i oraz prawdopodobieństwa P*_e, P*_i.
Etapy:
 1. Wyznaczenie maksymalnej częstości zderzeń dla elektronów nu*_e i prawdopodobieństwa P*_e = 1 - exp(-nu*_e * dt_e).
 2. Wyznaczenie maksymalnej częstości zderzeń dla jonów nu*_i i prawdopodobieństwa P*_i = 1 - exp(-nu*_i * dt_i).
 3. Wyświetlenie parametrów na standardowym wyjściu.
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
		for range n {
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
Dla n >= 1000 i n*p >= 5.0 stosuje aproksymację Gaussa N(mu, sigma^2) (tw. de Moivre'a-Laplace'a),
co redukuje złożoność z O(n) do O(1) przy błędzie statystycznym < 0.01%.
Dla małych prób wykonuje dokładne losowanie Bernoulliego.
@param n Liczba prób (całkowita liczba cząstek w domenie).
@param p Prawdopodobieństwo sukcesu w pojedynczej próbie (P*).
@return Wylosowana całkowita liczba zderzeń pozornych N*_coll.
*/
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
		for range n {
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
KROK 7: Zderzenia elektronów metodą Null-Collision z równoległym chunkingiem (Goroutines).
Zgodne z referencyjną implementacją C++ OpenMP:
 1. Podział cząstek N_e na równe chunki pomiędzy workery.
 2. Każdy worker niezależnie losuje liczbę zderzeń w swoim chunku: localNColl ~ Binomial(nLocal, P*_e).
 3. Każdy worker losuje cząstki ze swojego chunka w czasie O(localNColl), bez globalnej alokacji/selekcji.
 4. Rejection sampling: test akceptacji p_accept = nu(E) / nu*_e i wywołanie CollisionElectron in-place.
 5. Scalenie (flush) nowo utworzonych cząstek do globalnych tablic SoA.
*/
func (sim *SimulationState) Step7CollisionsElectrons() {
	if sim.N_e == 0 {
		return
	}

	numWorkers := sim.NumWorkers
	for w := range numWorkers {
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
	}

	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
	var wg sync.WaitGroup

	for w := range numWorkers {
		start := w * chunkSize
		end := min((w+1)*chunkSize, sim.N_e)
		if start >= end {
			continue
		}

		workerID, s, e := w, start, end
		wg.Go(func() {
			nLocal := e - s
			localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarE)
			if localNColl > nLocal {
				localNColl = nLocal
			}

			var localColl uint64
			for range localNColl {
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
				if ki >= e {
					ki = e - 1
				}

				vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
				velocity := math.Sqrt(vSqr)

				eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
				realNu := sim.SigmaTotE[eIdx] * velocity
				if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
					sim.CollisionElectron(sim.X_e[ki], &sim.Vx_e[ki], &sim.Vy_e[ki], &sim.Vz_e[ki], eIdx, workerID)
					localColl++
				}
			}
			if localColl > 0 {
				atomic.AddUint64(&sim.N_e_coll, localColl)
			}
		})
	}

	wg.Wait()

	for w := range numWorkers {
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
 1. Sprawdzenie subcyclingu (t % N_SUB == 0).
 2. Podział cząstek N_i na równe chunki pomiędzy workery.
 3. Każdy worker niezależnie losuje liczbę zderzeń w swoim chunku: localNColl ~ Binomial(nLocal, P*_i).
 4. Dla każdego wylosowanego jonu: losowanie prędkości atomu tła z RMB.
 5. Test akceptacji zderzenia p_accept = nu(E) / nu*_i i wywołanie CollisionIon in-place.

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t%N_SUB) != 0 || sim.N_i == 0 {
		return
	}

	numWorkers := sim.NumWorkers
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
	var wg sync.WaitGroup

	for w := range numWorkers {
		start := w * chunkSize
		end := min((w+1)*chunkSize, sim.N_i)
		if start >= end {
			continue
		}

		workerID, s, e := w, start, end
		wg.Go(func() {
			nLocal := e - s
			localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarI)
			if localNColl > nLocal {
				localNColl = nLocal
			}

			var localColl uint64
			for range localNColl {
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
				if ki >= e {
					ki = e - 1
				}

				vxA := sim.WorkerRMB(workerID)
				vyA := sim.WorkerRMB(workerID)
				vzA := sim.WorkerRMB(workerID)
				gx := sim.Vx_i[ki] - vxA
				gy := sim.Vy_i[ki] - vyA
				gz := sim.Vz_i[ki] - vzA
				gSqr := gx*gx + gy*gy + gz*gz
				g := math.Sqrt(gSqr)

				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
				realNu := sim.SigmaTotI[eIdx] * g
				if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
					sim.CollisionIon(&sim.Vx_i[ki], &sim.Vy_i[ki], &sim.Vz_i[ki], &vxA, &vyA, &vzA, eIdx, workerID)
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
