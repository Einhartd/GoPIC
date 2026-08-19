package gopic

import (
	"fmt"
	"math"
	"sync"
)

//----------------------------------------------------------------------//
// initialization of the simulation by placing a given number of        //
// electrons and ions at random positions between the electrodes        //
//----------------------------------------------------------------------//

func (sim *SimulationState) InitParticles(nseed int) {
	for i := 0; i < nseed; i++ {
		sim.X_e[i] = L * sim.R01() // initial random position of the electron
		sim.Vx_e[i] = 0
		sim.Vy_e[i] = 0
		sim.Vz_e[i] = 0            // initial velocity components of the electron
		sim.X_i[i] = L * sim.R01() // initial random position of the ion
		sim.Vx_i[i] = 0
		sim.Vy_i[i] = 0
		sim.Vz_i[i] = 0 // initial velocity components of the ion
	}
	sim.N_e = nseed // initial number of electrons
	sim.N_i = nseed // initial number of ions
}

//---------------------------------------------------------------------//
// simulation of one radiofrequency cycle                              //
//---------------------------------------------------------------------//

func (sim *SimulationState) Step1ComputeElectronDensity() {
	numWorkers := sim.NumWorkers
	var wg sync.WaitGroup
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers

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
			// zerowanie tablicy dla workera
			for p := range N_G {
				sim.WorkerEDensity[workerID][p] = 0.0
			}
			// Depozycja czastek przypisanych do workera
			var c0 float64
			var p int
			for k := s; k < e; k++ {
				c0 = sim.X_e[k] * INV_DX
				p = int(c0)
				sim.WorkerEDensity[workerID][p] += (float64(p) + 1.0 - c0) * FACTOR_W
				sim.WorkerEDensity[workerID][p+1] += (c0 - float64(p)) * FACTOR_W
			}
		})
	}
	wg.Wait()

	// Redukcja - watek glowny zeruje E_density i sumuje wyniki workerow
	for p := range N_G {
		sim.E_density[p] = 0.0
	}
	for w := range numWorkers {
		for p := range N_G {
			sim.E_density[p] += sim.WorkerEDensity[w][p]
		}
	}

	// Poprawki brzegowe i akumulacja
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p := range N_G {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	if (t % N_SUB) == 0 { // ion density - computed in every N_SUB-th time steps (subcycling)

		//	TODO dodac sterowana ilosc gorutyn
		numWorkers := sim.NumWorkers
		var wg sync.WaitGroup
		chunkSize := (sim.N_i + numWorkers - 1) / numWorkers

		for w := range numWorkers {
			start := w * chunkSize
			end := min((w+1)*chunkSize, sim.N_i)
			if start >= end {
				continue
			}
			workerID, s, e := w, start, end

			wg.Go(func() {
				for p := range N_G {
					sim.WorkerIDensity[workerID][p] = 0.0
				}
				var c0 float64
				var p int
				for k := s; k < e; k++ {
					c0 = sim.X_i[k] * INV_DX
					p = int(c0)
					sim.WorkerIDensity[workerID][p] += (float64(p) + 1.0 - c0) * FACTOR_W
					sim.WorkerIDensity[workerID][p+1] += (c0 - float64(p)) * FACTOR_W
				}
			})
		}
		wg.Wait()

		for p := range N_G {
			sim.I_density[p] = 0.0
		}
		for w := range numWorkers {
			for p := range N_G {
				sim.I_density[p] += sim.WorkerIDensity[w][p]
			}
		}

		sim.I_density[0] *= 2.0
		sim.I_density[N_G-1] *= 2.0
	}
	for p := range N_G {
		sim.Cumul_i_density[p] += sim.I_density[p]
	}
}

func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
	var rho Xvector
	for p := 0; p < N_G; p++ {
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // get charge density
	}
	sim.SolvePoisson(&rho, currentTime) // compute potential and electric field
}

func (sim *SimulationState) Step3MoveElectrons(t_index int) {
	numWorkers := sim.NumWorkers
	var wg sync.WaitGroup
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers

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
			diag := &sim.WorkerEDiag[workerID]
			*diag = electronWorkerDiagnostics{}

			var c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate float64
			var p, energy_index int

			for k := s; k < e; k++ {
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
		})
	}

	wg.Wait()

	if sim.Measurement_mode {
		for w := 0; w < numWorkers; w++ {
			for p := 0; p < N_G; p++ {
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
				sim.Ue_xt[p][t_index] += sim.WorkerEDiag[w].ue[p]
				sim.Meanee_xt[p][t_index] += sim.WorkerEDiag[w].meanee[p]
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
			}
			for i := 0; i < N_EEPF; i++ {
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
			}
			sim.Mean_energy_accu_center += sim.WorkerEDiag[w].accuCenter
			sim.Mean_energy_counter_center += sim.WorkerEDiag[w].counterCenter
		}
	}
}

func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	numWorkers := sim.NumWorkers
	var wg sync.WaitGroup
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers

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
			diag := &sim.WorkerIDiag[workerID]
			*diag = ionWorkerDiagnostics{}

			var c0, c1, c2, e_x, mean_v, v_sqr, energy float64
			var p int

			for k := s; k < e; k++ {
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
		})
	}

	wg.Wait()

	if sim.Measurement_mode {
		for w := 0; w < numWorkers; w++ {
			for p := 0; p < N_G; p++ {
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
				sim.Ui_xt[p][t_index] += sim.WorkerIDiag[w].ui[p]
				sim.Meanei_xt[p][t_index] += sim.WorkerIDiag[w].meanei[p]
			}
		}
	}
}

func (sim *SimulationState) Step5CheckBoundariesElectrons() {
	numWorkers := sim.NumWorkers
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
			diag := &sim.WorkerEDiag[workerID]
			diag.abs_pow = 0
			diag.abs_gnd = 0

			for k := s; k < e; k++ {
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
		})
	}
	wg.Wait()

	// Reduce absorption counters
	for w := 0; w < numWorkers; w++ {
		sim.N_e_abs_pow += sim.WorkerEDiag[w].abs_pow
		sim.N_e_abs_gnd += sim.WorkerEDiag[w].abs_gnd
	}

	// Sequential fast-swap deletion of absorbed electrons
	k := 0
	for k < sim.N_e {
		if sim.AbsorbedE[k] != 0 {
			sim.N_e--
			sim.X_e[k] = sim.X_e[sim.N_e]
			sim.Vx_e[k] = sim.Vx_e[sim.N_e]
			sim.Vy_e[k] = sim.Vy_e[sim.N_e]
			sim.Vz_e[k] = sim.Vz_e[sim.N_e]
			sim.AbsorbedE[k] = sim.AbsorbedE[sim.N_e]
		} else {
			k++
		}
	}
}

func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	numWorkers := sim.NumWorkers
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
			diag := &sim.WorkerIDiag[workerID]
			diag.abs_pow = 0
			diag.abs_gnd = 0
			for idx := range N_IFED {
				diag.ifed_pow[idx] = 0
				diag.ifed_gnd[idx] = 0
			}

			var v_sqr, energy float64
			var energy_index int

			for k := s; k < e; k++ {
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
		})
	}
	wg.Wait()

	// Reduce absorption counters and IFED energy distributions
	for w := 0; w < numWorkers; w++ {
		sim.N_i_abs_pow += sim.WorkerIDiag[w].abs_pow
		sim.N_i_abs_gnd += sim.WorkerIDiag[w].abs_gnd
		for eIdx := 0; eIdx < N_IFED; eIdx++ {
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
		}
	}

	// Sequential fast-swap deletion of absorbed ions
	k := 0
	for k < sim.N_i {
		if sim.AbsorbedI[k] != 0 {
			sim.N_i--
			sim.X_i[k] = sim.X_i[sim.N_i]
			sim.Vx_i[k] = sim.Vx_i[sim.N_i]
			sim.Vy_i[k] = sim.Vy_i[sim.N_i]
			sim.Vz_i[k] = sim.Vz_i[sim.N_i]
			sim.AbsorbedI[k] = sim.AbsorbedI[sim.N_i]
		} else {
			k++
		}
	}
}

func (sim *SimulationState) Step9CollectXtData(t_index int) {
	if !sim.Measurement_mode {
		return
	}

	for p := 0; p < N_G; p++ {
		sim.Pot_xt[p][t_index] += sim.Pot[p]
		sim.Efield_xt[p][t_index] += sim.Efield[p]
		sim.Ne_xt[p][t_index] += sim.E_density[p]
		sim.Ni_xt[p][t_index] += sim.I_density[p]
	}
}

func (sim *SimulationState) DoOneCycle() {
	var t int
	var t_index int

	for t = 0; t < N_T; t++ { // the RF period is divided into N_T equal time intervals (time step DT_E)
		sim.Time += DT_E    // update of the total simulated time
		t_index = t / N_BIN // index for XT distributions

		sim.Step1ComputeElectronDensity()
		sim.Step1ComputeIonDensity(t)
		sim.Step2SolvePoisson(sim.Time)

		sim.Step3MoveElectrons(t_index)
		sim.Step4MoveIons(t_index, t)

		sim.Step5CheckBoundariesElectrons()
		sim.Step6CheckBoundariesIons(t)

		sim.Step7CollisionsElectrons()
		sim.Step8CollisionIons(t)

		sim.Step9CollectXtData(t_index)

		if (t % 1000) == 0 {
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
		}
	}
	fmt.Fprintf(sim.Datafile, "%8d  %8d  %8d\n", sim.Cycle, sim.N_e, sim.N_i)
}

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}
