package gopic

import (
	"math"
	"sync/atomic"
)

func (sim *SimulationState) startWorker(workerID int) {
	numWorkers := len(sim.WorkerCmdChan)

	for cmd := range sim.WorkerCmdChan[workerID] {
		switch cmd {
		case CmdComputeEDensity:
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_e)

			for i := range N_G {
				sim.WorkerEDensity[workerID][i] = 0.0
			}

			if start < end {
				var c0 float64
				var p int
				for k := start; k < end; k++ {
					c0 = sim.X_e[k] * INV_DX
					p = int(c0)
					sim.WorkerEDensity[workerID][p] += (float64(p) + 1.0 - c0) * FACTOR_W
					sim.WorkerEDensity[workerID][p+1] += (c0 - float64(p)) * FACTOR_W
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdComputeIDensity:
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_i)

			for i := range N_G {
				sim.WorkerIDensity[workerID][i] = 0.0
			}

			if start < end {
				var c0 float64
				var p int
				for k := start; k < end; k++ {
					c0 = sim.X_i[k] * INV_DX
					p = int(c0)
					sim.WorkerIDensity[workerID][p] += (float64(p) + 1.0 - c0) * FACTOR_W
					sim.WorkerIDensity[workerID][p+1] += (c0 - float64(p)) * FACTOR_W
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdMoveElectrons:
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_e)

			diag := &sim.WorkerEDiag[workerID]
			*diag = electronWorkerDiagnostics{}

			if start < end {
				var c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate float64
				var p, energy_index int

				for k := start; k < end; k++ {
					c0 = sim.X_e[k] * INV_DX
					p = int(c0)
					c1 = float64(p) + 1.0 - c0
					c2 = c0 - float64(p)
					e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

					if sim.Measurement_mode {
						mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
						diag.counter_e[p] += c1
						diag.counter_e[p+1] += c2

						diag.ue[p] += c1 * mean_v
						diag.ue[p+1] += c2 * mean_v

						v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
						energy = 0.5 * E_MASS * v_sqr / EV_TO_J

						diag.meanee[p] += c1 * energy
						diag.meanee[p+1] += c2 * energy

						energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
						velocity = math.Sqrt(v_sqr)
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY

						diag.ioniz[p] += c1 * rate
						diag.ioniz[p+1] += c2 * rate

						if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
							energy_index = int(energy / DE_EEPF)
							if energy_index < N_EEPF {
								diag.eepf[energy_index] += 1.0
							}
							diag.accuCenter += energy
							diag.counterCenter++
						}
					}

					// update velocity and position
					sim.Vx_e[k] -= e_x * FACTOR_E
					sim.X_e[k] += sim.Vx_e[k] * DT_E
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdMoveIons:
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_i)

			diag := &sim.WorkerIDiag[workerID]
			*diag = ionWorkerDiagnostics{}

			if start < end {
				var c0, c1, c2, e_x, mean_v, v_sqr, energy float64
				var p int

				for k := start; k < end; k++ {
					c0 = sim.X_i[k] * INV_DX
					p = int(c0)
					c1 = float64(p) + 1.0 - c0
					c2 = c0 - float64(p)
					e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

					if sim.Measurement_mode {
						mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
						diag.counter_i[p] += c1
						diag.counter_i[p+1] += c2
						diag.ui[p] += c1 * mean_v
						diag.ui[p+1] += c2 * mean_v
						v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
						energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
						diag.meanei[p] += c1 * energy
						diag.meanei[p+1] += c2 * energy
					}

					sim.Vx_i[k] += e_x * FACTOR_I
					sim.X_i[k] += sim.Vx_i[k] * DT_I
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdCheckBoundariesE:
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_e)

			diag := &sim.WorkerEDiag[workerID]
			diag.abs_pow = 0
			diag.abs_gnd = 0

			if start < end {
				for k := start; k < end; k++ {
					if sim.X_e[k] < 0 {
						sim.AbsorbedE[k] = 1
						diag.abs_pow++
					} else if sim.X_e[k] > L {
						sim.AbsorbedE[k] = 2
						diag.abs_gnd++
					} else {
						sim.AbsorbedE[k] = 0
					}
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdCheckBoundariesI:
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_i)

			diag := &sim.WorkerIDiag[workerID]
			diag.abs_pow = 0
			diag.abs_gnd = 0
			for idx := range N_IFED {
				diag.ifed_pow[idx] = 0
				diag.ifed_gnd[idx] = 0
			}

			if start < end {
				var v_sqr, energy float64
				var energy_index int

				for k := start; k < end; k++ {
					if sim.X_i[k] < 0 {
						sim.AbsorbedI[k] = 1
						diag.abs_pow++
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
						energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
						energy_index = int(energy / DE_IFED)
						if energy_index < N_IFED {
							diag.ifed_pow[energy_index]++
						}
					} else if sim.X_i[k] > L {
						sim.AbsorbedI[k] = 2
						diag.abs_gnd++
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
						energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
						energy_index = int(energy / DE_IFED)
						if energy_index < N_IFED {
							diag.ifed_gnd[energy_index]++
						}
					} else {
						sim.AbsorbedI[k] = 0
					}
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdCollisionsE:

			//	Reset buforow nowych czastek na workerow
			sim.WorkerNewElectrons[workerID] = sim.WorkerNewElectrons[workerID][:0]
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]

			// Lokalny licznik kolizji — jeden atomic.AddUint64 na koniec chunka
			// (identycznie jak Go-CK i C++ OMP, zamiast atomic per kolizję)
			var localEColl uint64

			if len(sim.CandidatesE) > 0 {
				totalCandidates := len(sim.CandidatesE)
				chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
				start := workerID * chunkSize
				end := min((workerID+1)*chunkSize, totalCandidates)

				if start < end {
					for i := start; i < end; i++ {
						k := sim.CandidatesE[i]
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
							localEColl++
						}
					}
				}
			} else {
				chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
				start := workerID * chunkSize
				end := min((workerID+1)*chunkSize, sim.N_e)

				if start < end {
					for k := start; k < end; k++ {
						v_sqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
						velocity := math.Sqrt(v_sqr)
						energy := 0.5 * E_MASS * v_sqr / EV_TO_J
						energy_index := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
						nu := sim.SigmaTotE[energy_index] * velocity
						p_coll := 1 - math.Exp(-nu*DT_E)

						// petla kolizji dla elektronow
						if sim.WorkerR01(workerID) < p_coll {
							sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], energy_index, workerID)
							localEColl++
						}
					}
				}
			}
			if localEColl > 0 {
				atomic.AddUint64(&sim.N_e_coll, localEColl)
			}
			sim.WorkerDoneChan <- workerID

		case CmdCollisionsI:
			//	Reset buforow nowych czastek na workerow
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]

			// Lokalny licznik kolizji — jeden atomic.AddUint64 na koniec chunka
			var localIColl uint64

			if len(sim.CandidatesI) > 0 {
				totalCandidates := len(sim.CandidatesI)
				chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
				start := workerID * chunkSize
				end := min((workerID+1)*chunkSize, totalCandidates)

				if start < end {
					for i := start; i < end; i++ {
						k := sim.CandidatesI[i]
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
							localIColl++
						}
					}
				}
			} else {
				chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
				start := workerID * chunkSize
				end := min((workerID+1)*chunkSize, sim.N_i)

				if start < end {
					for k := start; k < end; k++ {
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
							localIColl++
						}
					}
				}
			}
			if localIColl > 0 {
				atomic.AddUint64(&sim.N_i_coll, localIColl)
			}
			sim.WorkerDoneChan <- workerID

		case CmdStop:
			return
		}
	}
}
