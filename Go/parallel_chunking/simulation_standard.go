//go:build !nullcollision

package gopic

import (
	"math"
	"sync"
	"sync/atomic"
)

/*
Inicjalizacja parametrów zderzeń w trybie standardowym (bezpośrednie próbkowanie).
W trybie standardowym funkcja nie wykonuje żadnych operacji.
*/
func (sim *SimulationState) InitNullCollision() {
	// Brak wstępnych obliczeń w trybie bezpośrednim (standard)
}

/*
KROK 7: Zderzenia elektronów metodą bezpośredniego próbkowania (Standard MCC).
Wariant równoległy z podziałem tablicy N_e na równe chunki pomiędzy workery (goroutines).
Etapy:
 1. Wyczyszczenie prywatnych buforów na nowe cząstki w każdym workerze.
 2. Podział indeksów elektronów na równe ciągłe bloki (chunki).
 3. Każdy worker oblicza energię, częstość nu(E) i bezpośrednie prawdopodobieństwo P_coll = 1 - exp(-nu*dt_e).
 4. Obsługa zderzenia CollisionElectron i gromadzenie nowych par cząstek w prywatnych tablicach.
 5. Scalenie (flush) buforów workerów do głównych tablic SoA po zakończeniu goroutines.
*/
func (sim *SimulationState) Step7CollisionsElectrons() {
	numWorkers := len(sim.WorkerEDensity)

	// 1. Reset buforów nowych cząstek dla każdego workera
	for w := range numWorkers {
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
	}

	// ZRÓWNOLEGLENIE: Podział tablicy N_e elektronów na równe chunki
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers

	var wg sync.WaitGroup

	for w := 0; w < numWorkers; w++ {
		start := w * chunkSize
		end := (w + 1) * chunkSize

		if end > sim.N_e {
			end = sim.N_e
		}

		if start >= end {
			continue
		}

		workerID, s, e := w, start, end

		// Start goroutine: bezpośrednie próbkowanie zderzeń elektronów w chunku [s, e)
		wg.Go(func() {
			var localColl uint64
			for k := s; k < e; k++ {
				v_sqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
				velocity := math.Sqrt(v_sqr)
				energy := 0.5 * E_MASS * v_sqr / EV_TO_J
				energy_index := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
				nu := sim.SigmaTotE[energy_index] * velocity
				p_coll := 1 - math.Exp(-nu*DT_E)

				// Próbkowanie zderzenia dla elektronu
				if sim.WorkerR01(workerID) < p_coll {
					sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], energy_index, workerID)
					localColl++
				}
			}
			// Atomowa inkrementacja globalnego licznika zderzeń
			if localColl > 0 {
				atomic.AddUint64(&sim.N_e_coll, localColl)
			}
		})

	}

	// Bariera synchronizacyjna: oczekiwanie na wszystkie goroutines
	wg.Wait()

	// SCALENIE (FLUSH): Przepisanie nowych cząstek z buforów AoS do głównych tablic SoA
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
KROK 8: Zderzenia jonów metodą bezpośredniego próbkowania (Subcycling co N_SUB kroków).
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Podział indeksów jonów na równe chunki pomiędzy workery (goroutines).
 3. Każdy worker losuje prędkość atomu tła z rozkładu RMB i wyznacza energię zderzenia.
 4. Obliczenie prawdopodobieństwa P_coll = 1 - exp(-nu*dt_i) i wywołanie CollisionIon in-place.

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	numWorkers := len(sim.WorkerEDensity)

	// Reset buforów nowych cząstek dla workerów
	for w := 0; w < numWorkers; w++ {
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
	}

	// ZRÓWNOLEGLENIE: Podział tablicy jonów N_i na chunki
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers

	var wg sync.WaitGroup

	for w := 0; w < numWorkers; w++ {
		start := w * chunkSize
		end := (w + 1) * chunkSize

		if end > sim.N_i {
			end = sim.N_i
		}

		if start >= end {
			continue
		}

		workerID, s, e := w, start, end

		// Start goroutine: próbkowanie zderzeń jonów w chunku
		wg.Go(func() {
			var localColl uint64
			for k := s; k < e; k++ {
				vx_a := sim.WorkerRMB(workerID)
				vy_a := sim.WorkerRMB(workerID)
				vz_a := sim.WorkerRMB(workerID)
				gx := sim.Vx_i[k] - vx_a
				gy := sim.Vy_i[k] - vy_a
				gz := sim.Vz_i[k] - vz_a
				g_sqr := gx*gx + gy*gy + gz*gz
				g := math.Sqrt(g_sqr)
				energy := 0.5 * MU_ARAR * g_sqr / EV_TO_J
				energy_index := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
				nu := sim.SigmaTotI[energy_index] * g
				p_coll := 1 - math.Exp(-nu*DT_I)

				// Próbkowanie zderzenia dla jonu
				if sim.WorkerR01(workerID) < p_coll {
					sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vx_a, &vy_a, &vz_a, energy_index, workerID)
					localColl++
				}
			}
			// Atomowa inkrementacja globalnego licznika zderzeń jonowych
			if localColl > 0 {
				atomic.AddUint64(&sim.N_i_coll, localColl)
			}
		})

	}

	// Bariera synchronizacyjna jonów
	wg.Wait()
}
