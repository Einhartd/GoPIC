package gopic

import (
	"math"
	"sync/atomic"
)

/*
Główna pętla wykonawcza trwałego workera (Goroutine) w architekturze Channels.
Worker nasłuchuje na dedykowanym kanale sim.WorkerCmdChan[workerID] na polecenia koordynatora (WorkerCommand),
wykonuje przypisany fragment obliczeń (chunk) na prywatnych buforach bez alokacji pamięci,
a po zakończeniu wysyła swój identyfikator do kanału sim.WorkerDoneChan.
Obsługiwane rozkazy:
  - CmdComputeEDensity: Równoległa depozycja CIC ładunku elektronów w buforze WorkerEDensity.
  - CmdComputeIDensity: Równoległa depozycja CIC ładunku jonów w buforze WorkerIDensity.
  - CmdMoveElectrons: Popychanie elektronów (Leap-Frog) i zbieranie diagnostyk do WorkerEDiag.
  - CmdMoveIons: Popychanie jonów (Leap-Frog) i zbieranie diagnostyk do WorkerIDiag.
  - CmdCheckBoundariesE: Oznaczanie elektronów poza domeną w tablicy flag AbsorbedE.
  - CmdCheckBoundariesI: Oznaczanie jonów poza domeną i próbkowanie histogramu IFED.
  - CmdCollisionsE: Zderzenia elektronów MCC (Null-Collision lub bezpośrednie) z buforowaniem cząstek AoS.
  - CmdCollisionsI: Zderzenia jonów MCC z atomami tła wylosowanymi z rozkładu RMB.
  - CmdStop: Zakończenie pracy i wyjście z pętli goroutine.

@param workerID Identyfikator trwałego workera (0 .. NumWorkers-1).
*/
func (sim *SimulationState) startWorker(workerID int) {
	numWorkers := len(sim.WorkerCmdChan)

	// Pętla oczekiwania na rozkazy z kanału koordynatora
	for cmd := range sim.WorkerCmdChan[workerID] {
		switch cmd {
		case CmdComputeEDensity:

			// KROK 1a: Depozycja gęstości elektronów w chunku
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_e)

			densityE := &sim.WorkerEDensity[workerID]
			// Zerowanie prywatnego bufora węzłów siatki dla danego workera
			for i := range N_G {
				densityE[i] = 0.0
			}

			if start < end {
				for k := start; k < end; k++ {
					c0 := sim.X_e[k] * INV_DX
					p := min(max(int(c0), 0), N_G-2)
					d := c0 - float64(p)
					densityE[p] += (1.0 - d) * FACTOR_W
					densityE[p+1] += d * FACTOR_W
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdComputeIDensity:

			// KROK 1b: Depozycja gęstości jonów w chunku
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_i)

			densityI := &sim.WorkerIDensity[workerID]
			for i := range N_G {
				densityI[i] = 0.0
			}

			if start < end {
				for k := start; k < end; k++ {
					c0 := sim.X_i[k] * INV_DX
					p := min(max(int(c0), 0), N_G-2)
					d := c0 - float64(p)
					densityI[p] += (1.0 - d) * FACTOR_W
					densityI[p+1] += d * FACTOR_W
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdMoveElectrons:

			// KROK 3: Popychanie elektronów Leap-Frog i zbieranie diagnostyk
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_e)

			if sim.Measurement_mode {
				diag := &sim.WorkerEDiag[workerID]
				*diag = electronWorkerDiagnostics{}

				if start < end {
					var c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate float64
					var p, energy_index int

					for k := start; k < end; k++ {
						c0 = sim.X_e[k] * INV_DX
						p = min(max(int(c0), 0), N_G-2)
						c1 = float64(p) + 1.0 - c0
						c2 = c0 - float64(p)
						e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

						mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
						diag.counter_e[p] += c1
						diag.counter_e[p+1] += c2

						diag.ue[p] += c1 * mean_v
						diag.ue[p+1] += c2 * mean_v

						v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
						energy = 0.5 * E_MASS * v_sqr * INV_EV_TO_J

						diag.meanee[p] += c1 * energy
						diag.meanee[p+1] += c2 * energy

						energy_index = minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
						velocity = math.Sqrt(v_sqr)
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY

						diag.ioniz[p] += c1 * rate
						diag.ioniz[p+1] += c2 * rate

						// Zliczanie EEPF w centrum wyładowania
						if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
							energy_index = int(energy * INV_DE_EEPF)
							if energy_index < N_EEPF {
								diag.eepf[energy_index] += 1.0
							}
							diag.accuCenter += energy
							diag.counterCenter++
						}

						// Integracja ruchu Leap-Frog
						sim.Vx_e[k] -= e_x * FACTOR_E
						sim.X_e[k] += sim.Vx_e[k] * DT_E
					}
				}
			} else {
				if end > start {
					_ = sim.X_e[end-1]
					_ = sim.Vx_e[end-1]
				}

				k := start
				for ; k <= end-4; k += 4 {
					c0_0 := sim.X_e[k] * INV_DX
					p0 := min(max(int(c0_0), 0), N_G-2)
					d0 := c0_0 - float64(p0)
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])

					c0_1 := sim.X_e[k+1] * INV_DX
					p1 := min(max(int(c0_1), 0), N_G-2)
					d1 := c0_1 - float64(p1)
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])

					c0_2 := sim.X_e[k+2] * INV_DX
					p2 := min(max(int(c0_2), 0), N_G-2)
					d2 := c0_2 - float64(p2)
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])

					c0_3 := sim.X_e[k+3] * INV_DX
					p3 := min(max(int(c0_3), 0), N_G-2)
					d3 := c0_3 - float64(p3)
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])

					vx0 := sim.Vx_e[k] - ex0*FACTOR_E
					vx1 := sim.Vx_e[k+1] - ex1*FACTOR_E
					vx2 := sim.Vx_e[k+2] - ex2*FACTOR_E
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E

					sim.Vx_e[k] = vx0
					sim.Vx_e[k+1] = vx1
					sim.Vx_e[k+2] = vx2
					sim.Vx_e[k+3] = vx3

					sim.X_e[k] += vx0 * DT_E
					sim.X_e[k+1] += vx1 * DT_E
					sim.X_e[k+2] += vx2 * DT_E
					sim.X_e[k+3] += vx3 * DT_E
				}

				for ; k < end; k++ {
					c0 := sim.X_e[k] * INV_DX
					p := min(max(int(c0), 0), N_G-2)
					d := c0 - float64(p)
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])

					sim.Vx_e[k] -= ex * FACTOR_E
					sim.X_e[k] += sim.Vx_e[k] * DT_E
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdMoveIons:

			// KROK 4: Popychanie jonów Leap-Frog i zbieranie diagnostyk
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
			start := workerID * chunkSize
			end := min((workerID+1)*chunkSize, sim.N_i)

			if sim.Measurement_mode {
				diag := &sim.WorkerIDiag[workerID]
				*diag = ionWorkerDiagnostics{}

				if start < end {
					var c0, c1, c2, e_x, mean_v, v_sqr, energy float64
					var p int

					for k := start; k < end; k++ {
						c0 = sim.X_i[k] * INV_DX
						p = min(max(int(c0), 0), N_G-2)
						c1 = float64(p) + 1.0 - c0
						c2 = c0 - float64(p)
						e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

						mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
						diag.counter_i[p] += c1
						diag.counter_i[p+1] += c2
						diag.ui[p] += c1 * mean_v
						diag.ui[p+1] += c2 * mean_v
						v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
						energy = 0.5 * AR_MASS * v_sqr * INV_EV_TO_J
						diag.meanei[p] += c1 * energy
						diag.meanei[p+1] += c2 * energy

						sim.Vx_i[k] += e_x * FACTOR_I
						sim.X_i[k] += sim.Vx_i[k] * DT_I
					}
				}
			} else {
				if end > start {
					_ = sim.X_i[end-1]
					_ = sim.Vx_i[end-1]
				}

				k := start
				for ; k <= end-4; k += 4 {
					c0_0 := sim.X_i[k] * INV_DX
					p0 := min(max(int(c0_0), 0), N_G-2)
					d0 := c0_0 - float64(p0)
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])

					c0_1 := sim.X_i[k+1] * INV_DX
					p1 := min(max(int(c0_1), 0), N_G-2)
					d1 := c0_1 - float64(p1)
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])

					c0_2 := sim.X_i[k+2] * INV_DX
					p2 := min(max(int(c0_2), 0), N_G-2)
					d2 := c0_2 - float64(p2)
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])

					c0_3 := sim.X_i[k+3] * INV_DX
					p3 := min(max(int(c0_3), 0), N_G-2)
					d3 := c0_3 - float64(p3)
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])

					vx0 := sim.Vx_i[k] + ex0*FACTOR_I
					vx1 := sim.Vx_i[k+1] + ex1*FACTOR_I
					vx2 := sim.Vx_i[k+2] + ex2*FACTOR_I
					vx3 := sim.Vx_i[k+3] + ex3*FACTOR_I

					sim.Vx_i[k] = vx0
					sim.Vx_i[k+1] = vx1
					sim.Vx_i[k+2] = vx2
					sim.Vx_i[k+3] = vx3

					sim.X_i[k] += vx0 * DT_I
					sim.X_i[k+1] += vx1 * DT_I
					sim.X_i[k+2] += vx2 * DT_I
					sim.X_i[k+3] += vx3 * DT_I
				}

				for ; k < end; k++ {
					c0 := sim.X_i[k] * INV_DX
					p := min(max(int(c0), 0), N_G-2)
					d := c0 - float64(p)
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])

					sim.Vx_i[k] += ex * FACTOR_I
					sim.X_i[k] += sim.Vx_i[k] * DT_I
				}
			}
			sim.WorkerDoneChan <- workerID

		case CmdCheckBoundariesE:

			// KROK 5: Oznaczanie granic dla elektronów w chunku
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

			// KROK 6: Oznaczanie granic dla jonów i próbkowanie IFED
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
				var v_sqr float64
				var energy_index int

				for k := start; k < end; k++ {
					if sim.X_i[k] < 0 {
						sim.AbsorbedI[k] = 1
						diag.abs_pow++
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
						energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
						if energy_index < N_IFED {
							diag.ifed_pow[energy_index]++
						}
					} else if sim.X_i[k] > L {
						sim.AbsorbedI[k] = 2
						diag.abs_gnd++
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
						energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
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

			// KROK 7: Zderzenia elektronów MCC w chunku
			sim.WorkerNewElectrons[workerID] = sim.WorkerNewElectrons[workerID][:0]
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]

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
						eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
						realNu := sim.SigmaTotE[eIdx] * velocity

						if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
							sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx, workerID)
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

			// KROK 8: Zderzenia jonów MCC w chunku
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]

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
						eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
						realNu := sim.SigmaTotI[eIdx] * g

						if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
							sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
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
			// Zakończenie pracy goroutine
			return
		}
	}
}
