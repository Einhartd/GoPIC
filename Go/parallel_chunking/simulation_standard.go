//go:build !nullcollision

package gopic

import (
	"math"
	"sync"
	"sync/atomic"
)

// InitNullCollision does nothing in standard mode.
func (sim *SimulationState) InitNullCollision() {
	// No initialization needed for standard collisions
}

func (sim *SimulationState) Step7CollisionsElectrons() {

	numWorkers := len(sim.WorkerEDensity)

	//	Reset buforow nowych czastek na workerow
	for w := 0; w < numWorkers; w++ {
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
	}

	// Podzial elektronow na chunki
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
		wg.Go(func() {
			var localColl uint64
			for k := s; k < e; k++ {
				v_sqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
				velocity := math.Sqrt(v_sqr)
				energy := 0.5 * E_MASS * v_sqr / EV_TO_J
				energy_index := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
				nu := sim.SigmaTotE[energy_index] * velocity
				p_coll := 1 - math.Exp(-nu*DT_E)

				// petla kolizji dla elektronow
				if sim.WorkerR01(workerID) < p_coll {
					sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], energy_index, workerID)
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

	numWorkers := len(sim.WorkerEDensity)

	//	Reset buforow nowych czastek na workerow
	for w := 0; w < numWorkers; w++ {
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
	}

	// Podzial jonow na chunki
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

				// petla kolizji dla jonow
				if sim.WorkerR01(workerID) < p_coll {
					sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vx_a, &vy_a, &vz_a, energy_index, workerID)
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
