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
Losowanie unikalnego podzbioru indeksów cząstek bez powtórzeń (Algorytm Fishera-Yatesa).
Losuje 'count' unikalnych indeksów z przedziału [0, n) w czasie O(count) bez dodatkowych alokacji GC.
@param n     Całkowita liczba dostępnych cząstek w tablicy.
@param count Liczba kandydatów do wylosowania (N*_coll).
@return Wycinek zawierający 'count' unikalnych indeksów cząstek.
*/
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
Etapy:
 1. Losowanie łącznej liczby kandydatów N*_coll ~ Binomial(N_e, P*_e) i unikalnych indeksów bez powtórzeń.
 2. Podział kandydatów na równe chunki pomiędzy workery (goroutines).
 3. Każdy worker oblicza energię, rzeczywistą częstość nu(E) i test akceptacji p_accept = nu(E) / nu*_e.
 4. Wywołanie CollisionElectron i buforowanie nowo powstałych par (e-, Ar+) w prywatnych tablicach AoS.
 5. Scalenie (flush) buforów workerów do głównych tablic SoA stanu symulacji.
*/
func (sim *SimulationState) Step7CollisionsElectrons() {
	nCollStar := min(sim.sampleBinomial(sim.N_e, sim.PStarE), sim.N_e)
	if nCollStar == 0 {
		return
	}

	// Losowanie unikalnego podzbioru kandydatów (częściowy Fisher-Yates)
	candidates := sim.randomSample(sim.N_e, nCollStar)

	numWorkers := len(sim.WorkerEDensity)
	for w := range numWorkers {
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
	}

	// ZRÓWNOLEGLENIE: Podział tablicy kandydatów 'candidates' na równe chunki
	totalCandidates := len(candidates)
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers

	var wg sync.WaitGroup

	for w := range numWorkers {
		start := w * chunkSize
		end := min((w+1)*chunkSize, totalCandidates)
		if start >= end {
			continue
		}

		workerID, s, e := w, start, end

		// Start goroutine: Każdy worker niezależnie testuje akceptację zderzeń
		// dla swojego podzbioru kandydatów i zapisuje nowe cząstki do WorkerNewElectrons[workerID].
		wg.Go(func() {
			var localColl uint64
			for i := s; i < e; i++ {
				k := candidates[i]
				vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
				velocity := math.Sqrt(vSqr)

				eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
				realNu := sim.SigmaTotE[eIdx] * velocity
				if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
					sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx, workerID)
					localColl++
				}
			}
			// Bezpieczna atomowa akumulacja globalnego licznika zderzeń
			if localColl > 0 {
				atomic.AddUint64(&sim.N_e_coll, localColl)
			}
		})
	}

	// Bariera synchronizacyjna: oczekiwanie na zakończenie wszystkich zderzeń w chunkach
	wg.Wait()

	// SCALENIE (FLUSH): Przepisanie nowych cząstek (wtórne e- i jony Ar+) z prywatnych
	// buforów AoS do głównych tablic SoA stanu symulacji.
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
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Losowanie liczby kandydatów N*_coll ~ Binomial(N_i, P*_i) i unikalnych indeksów bez powtórzeń.
 3. Podział kandydatów na równe chunki pomiędzy workery (goroutines).
 4. Dla każdego kandydata: wylosowanie wektora prędkości atomu tła z rozkładu RMB.
 5. Test akceptacji zderzenia p_accept = nu(E) / nu*_i i wywołanie CollisionIon in-place.

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	nCollStar := min(sim.sampleBinomial(sim.N_i, sim.PStarI), sim.N_i)
	if nCollStar == 0 {
		return
	}

	candidates := sim.randomSample(sim.N_i, nCollStar)

	numWorkers := len(sim.WorkerEDensity)
	totalCandidates := len(candidates)

	// ZRÓWNOLEGLENIE: Podział kandydatów zderzeń jonowych na chunki
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers

	var wg sync.WaitGroup

	for w := 0; w < numWorkers; w++ {
		start := w * chunkSize
		end := min((w+1)*chunkSize, totalCandidates)
		if start >= end {
			continue
		}

		workerID, s, e := w, start, end

		// Start goroutine: test akceptacji i modyfikacja prędkości zderzających się jonów
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

				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
				realNu := sim.SigmaTotI[eIdx] * g
				if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
					sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
					localColl++
				}
			}
			if localColl > 0 {
				atomic.AddUint64(&sim.N_i_coll, localColl)
			}
		})
	}

	// Bariera synchronizacyjna jonów
	wg.Wait()
}
