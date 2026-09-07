package gopic

import (
	"math"
	"runtime"
	"sync/atomic"
)

/*
InitWorkers uruchamia trwałe goroutines workerów w tle (dla workerID = 1 .. NumWorkers-1).
Worker 0 jest wykonywany bezpośrednio przez wątek główny (koordynatora).
*/
func (sim *SimulationState) InitWorkers() {
	for w := 1; w < sim.NumWorkers; w++ {
		go sim.startWorker(w)
	}
}

/*
startWorker to główna pętla wykonawcza trwałego workera w tle (workerID = 1 .. NumWorkers-1).
*/
func (sim *SimulationState) startWorker(workerID int) {
	var myStep int64 = 1
	for {
		spins := 0
		for sim.Barrier.step.Load() < myStep {
			procyield(30)
			spins++
			if spins > 200 {
				runtime.Gosched()
				spins = 0
			}
		}

		cmd := WorkerCommand(sim.Barrier.cmd.Load())
		if cmd == CmdStop {
			sim.Barrier.workerDone[workerID].val.Store(myStep)
			return
		}

		sim.executeWorkerTask(workerID, cmd)

		sim.Barrier.workerDone[workerID].val.Store(myStep)
		myStep++
	}
}

/*
executeWorkerTask to lekki dyspozytor zadań.
Dzięki rozbiciu na wyspecjalizowane metody kompilator Go nie zrzuca rejestrów na stos (brak register spilling).
*/
func (sim *SimulationState) executeWorkerTask(workerID int, cmd WorkerCommand) {
	switch cmd {
	case CmdComputeEDensity:
		sim.workerComputeEDensity(workerID)
	case CmdComputeIDensity:
		sim.workerComputeIDensity(workerID)
	case CmdMoveElectronsAndBoundaries:
		sim.workerMoveElectrons(workerID)
	case CmdMoveIonsAndBoundaries:
		sim.workerMoveIons(workerID)
	case CmdCollisionsE:
		sim.workerCollisionsE(workerID)
	case CmdCollisionsI:
		sim.workerCollisionsI(workerID)
	}
}

// workerComputeEDensity wykonuje depozycję ładunku elektronów w przypisanym fragmencie.
func (sim *SimulationState) workerComputeEDensity(workerID int) {
	chunkSize := sim.EChunkSize
	if chunkSize <= 0 {
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
	}
	start := workerID * chunkSize
	end := start + chunkSize
	if end > sim.N_e {
		end = sim.N_e
	}

	densityE := &sim.WorkerEDensity[workerID]
	for i := 0; i < N_G; i++ {
		densityE[i] = 0.0
	}

	if start < end {
		for k := start; k < end; k++ {
			c0 := sim.X_e[k] * INV_DX
			p := min(max(int(c0), 0), N_G-2)
			c2 := (c0 - float64(p)) * FACTOR_W
			c1 := FACTOR_W - c2
			densityE[p] += c1
			densityE[p+1] += c2
		}
	}
}

// workerComputeIDensity wykonuje depozycję ładunku jonów w przypisanym fragmencie.
func (sim *SimulationState) workerComputeIDensity(workerID int) {
	chunkSize := sim.IChunkSize
	if chunkSize <= 0 {
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
	}
	start := workerID * chunkSize
	end := start + chunkSize
	if end > sim.N_i {
		end = sim.N_i
	}

	densityI := &sim.WorkerIDensity[workerID]
	for i := 0; i < N_G; i++ {
		densityI[i] = 0.0
	}

	if start < end {
		for k := start; k < end; k++ {
			c0 := sim.X_i[k] * INV_DX
			p := min(max(int(c0), 0), N_G-2)
			c2 := (c0 - float64(p)) * FACTOR_W
			c1 := FACTOR_W - c2
			densityI[p] += c1
			densityI[p+1] += c2
		}
	}
}

// workerMoveElectrons integruje ruch elektronów Leap-Frog z natychmiastowym sprawdzeniem granic w rejestrach.
func (sim *SimulationState) workerMoveElectrons(workerID int) {
	chunkSize := sim.EChunkSize
	if chunkSize <= 0 {
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
	}
	start := workerID * chunkSize
	end := start + chunkSize
	if end > sim.N_e {
		end = sim.N_e
	}

	diag := &sim.WorkerEDiag[workerID]
	diag.abs_pow = 0
	diag.abs_gnd = 0
	dead := sim.WorkerDeadElectrons[workerID][:0]

	if sim.Measurement_mode {
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

				if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
					energy_index = int(energy * INV_DE_EEPF)
					if energy_index < N_EEPF {
						diag.eepf[energy_index] += 1.0
					}
					diag.accuCenter += energy
					diag.counterCenter++
				}

				sim.Vx_e[k] -= e_x * FACTOR_E
				newX := sim.X_e[k] + sim.Vx_e[k]*DT_E
				sim.X_e[k] = newX

				if newX < 0 {
					dead = append(dead, k)
					diag.abs_pow++
				} else if newX > L {
					dead = append(dead, k)
					diag.abs_gnd++
				}
			}
		}
	} else {
		// Ścieżka szybka (bez pomiarów): rozwinięcie x4 zminimalizowane w małej funkcji
		if end > start {
			_ = sim.X_e[end-1]
			_ = sim.Vx_e[end-1]
		}

		var absPow, absGnd uint64
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

			x0 := sim.X_e[k] + vx0*DT_E
			x1 := sim.X_e[k+1] + vx1*DT_E
			x2 := sim.X_e[k+2] + vx2*DT_E
			x3 := sim.X_e[k+3] + vx3*DT_E

			sim.X_e[k] = x0
			sim.X_e[k+1] = x1
			sim.X_e[k+2] = x2
			sim.X_e[k+3] = x3

			if x0 < 0 {
				dead = append(dead, k)
				absPow++
			} else if x0 > L {
				dead = append(dead, k)
				absGnd++
			}

			if x1 < 0 {
				dead = append(dead, k+1)
				absPow++
			} else if x1 > L {
				dead = append(dead, k+1)
				absGnd++
			}

			if x2 < 0 {
				dead = append(dead, k+2)
				absPow++
			} else if x2 > L {
				dead = append(dead, k+2)
				absGnd++
			}

			if x3 < 0 {
				dead = append(dead, k+3)
				absPow++
			} else if x3 > L {
				dead = append(dead, k+3)
				absGnd++
			}
		}

		for ; k < end; k++ {
			c0 := sim.X_e[k] * INV_DX
			p := min(max(int(c0), 0), N_G-2)
			d := c0 - float64(p)
			ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])

			vx := sim.Vx_e[k] - ex*FACTOR_E
			sim.Vx_e[k] = vx
			x := sim.X_e[k] + vx*DT_E
			sim.X_e[k] = x

			if x < 0 {
				dead = append(dead, k)
				absPow++
			} else if x > L {
				dead = append(dead, k)
				absGnd++
			}
		}

		diag.abs_pow = absPow
		diag.abs_gnd = absGnd
	}
	sim.WorkerDeadElectrons[workerID] = dead
}

// workerMoveIons integruje ruch jonów Leap-Frog z natychmiastowym sprawdzeniem granic i IFED.
func (sim *SimulationState) workerMoveIons(workerID int) {
	chunkSize := sim.IChunkSize
	if chunkSize <= 0 {
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
	}
	start := workerID * chunkSize
	end := start + chunkSize
	if end > sim.N_i {
		end = sim.N_i
	}

	diag := &sim.WorkerIDiag[workerID]
	diag.abs_pow = 0
	diag.abs_gnd = 0
	for idx := 0; idx < N_IFED; idx++ {
		diag.ifed_pow[idx] = 0
		diag.ifed_gnd[idx] = 0
	}
	dead := sim.WorkerDeadIons[workerID][:0]

	if sim.Measurement_mode {
		diag.counter_i = [N_G]float64{}
		diag.ui = [N_G]float64{}
		diag.meanei = [N_G]float64{}

		if start < end {
			var c0, c1, c2, e_x, mean_v, v_sqr, energy float64
			var p, energy_index int

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
				newX := sim.X_i[k] + sim.Vx_i[k]*DT_I
				sim.X_i[k] = newX

				if newX < 0 {
					dead = append(dead, k)
					diag.abs_pow++
					vSqr := sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
					energy_index = int(vSqr * FACTOR_ENERGY_IFED)
					if energy_index < N_IFED {
						diag.ifed_pow[energy_index]++
					}
				} else if newX > L {
					dead = append(dead, k)
					diag.abs_gnd++
					vSqr := sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
					energy_index = int(vSqr * FACTOR_ENERGY_IFED)
					if energy_index < N_IFED {
						diag.ifed_gnd[energy_index]++
					}
				}
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

			x0 := sim.X_i[k] + vx0*DT_I
			x1 := sim.X_i[k+1] + vx1*DT_I
			x2 := sim.X_i[k+2] + vx2*DT_I
			x3 := sim.X_i[k+3] + vx3*DT_I

			sim.X_i[k] = x0
			sim.X_i[k+1] = x1
			sim.X_i[k+2] = x2
			sim.X_i[k+3] = x3

			if x0 < 0 {
				dead = append(dead, k)
				diag.abs_pow++
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_pow[eIdx]++
				}
			} else if x0 > L {
				dead = append(dead, k)
				diag.abs_gnd++
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_gnd[eIdx]++
				}
			}

			if x1 < 0 {
				dead = append(dead, k+1)
				diag.abs_pow++
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_pow[eIdx]++
				}
			} else if x1 > L {
				dead = append(dead, k+1)
				diag.abs_gnd++
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_gnd[eIdx]++
				}
			}

			if x2 < 0 {
				dead = append(dead, k+2)
				diag.abs_pow++
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_pow[eIdx]++
				}
			} else if x2 > L {
				dead = append(dead, k+2)
				diag.abs_gnd++
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_gnd[eIdx]++
				}
			}

			if x3 < 0 {
				dead = append(dead, k+3)
				diag.abs_pow++
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_pow[eIdx]++
				}
			} else if x3 > L {
				dead = append(dead, k+3)
				diag.abs_gnd++
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_gnd[eIdx]++
				}
			}
		}

		for ; k < end; k++ {
			c0 := sim.X_i[k] * INV_DX
			p := min(max(int(c0), 0), N_G-2)
			d := c0 - float64(p)
			ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])

			vx := sim.Vx_i[k] + ex*FACTOR_I
			sim.Vx_i[k] = vx
			x := sim.X_i[k] + vx*DT_I
			sim.X_i[k] = x

			if x < 0 {
				dead = append(dead, k)
				diag.abs_pow++
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_pow[eIdx]++
				}
			} else if x > L {
				dead = append(dead, k)
				diag.abs_gnd++
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
				if eIdx < N_IFED {
					diag.ifed_gnd[eIdx]++
				}
			}
		}
	}
	sim.WorkerDeadIons[workerID] = dead
}

// workerCollisionsE przeprowadza zderzenia MCC elektronów w przypisanym fragmencie.
func (sim *SimulationState) workerCollisionsE(workerID int) {
	sim.WorkerNewElectrons[workerID] = sim.WorkerNewElectrons[workerID][:0]
	sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]

	chunkSize := sim.EChunkSize
	if chunkSize <= 0 {
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
	}
	start := workerID * chunkSize
	end := start + chunkSize
	if end > sim.N_e {
		end = sim.N_e
	}
	nLocal := end - start

	var localEColl uint64
	if nLocal > 0 {
		localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarE)
		if localNColl > nLocal {
			localNColl = nLocal
		}

		for i := 0; i < localNColl; i++ {
			ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
			if ki >= end {
				ki = end - 1
			}
			vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
			velocity := math.Sqrt(vSqr)
			eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
			realNu := sim.SigmaTotE[eIdx] * velocity

			if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
				sim.CollisionElectron(sim.X_e[ki], &sim.Vx_e[ki], &sim.Vy_e[ki], &sim.Vz_e[ki], eIdx, workerID)
				localEColl++
			}
		}
	}
	if localEColl > 0 {
		atomic.AddUint64(&sim.N_e_coll, localEColl)
	}
}

// workerCollisionsI przeprowadza zderzenia MCC jonów w przypisanym fragmencie.
func (sim *SimulationState) workerCollisionsI(workerID int) {
	sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]

	chunkSize := sim.IChunkSize
	if chunkSize <= 0 {
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
	}
	start := workerID * chunkSize
	end := start + chunkSize
	if end > sim.N_i {
		end = sim.N_i
	}
	nLocal := end - start

	var localIColl uint64
	if nLocal > 0 {
		localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarI)
		if localNColl > nLocal {
			localNColl = nLocal
		}

		for i := 0; i < localNColl; i++ {
			ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
			if ki >= end {
				ki = end - 1
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
				localIColl++
			}
		}
	}
	if localIColl > 0 {
		atomic.AddUint64(&sim.N_i_coll, localIColl)
	}
}
