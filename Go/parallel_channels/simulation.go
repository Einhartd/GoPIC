package gopic

import (
	"fmt"
)

func (sim *SimulationState) InitWorkers() {
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		go sim.startWorker(w)
	}
}

func (sim *SimulationState) broadcastAndWait(cmd WorkerCommand) {
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.WorkerCmdChan[w] <- cmd
	}
	for range numWorkers {
		<-sim.WorkerDoneChan
	}
}

func (sim *SimulationState) StopWorkers() {
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.WorkerCmdChan[w] <- CmdStop
	}
}

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
	sim.broadcastAndWait(CmdComputeEDensity)

	// Redukcja - watek glowny zeruje e_density i sumuje wyniki workerow
	for p := range N_G {
		sim.E_density[p] = 0.0
	}
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		for p := range N_G {
			sim.E_density[p] += sim.WorkerEDensity[w][p]
		}
	}
	// Poprawki brzegowe
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p := range N_G {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	// ion density - computed in every N_SUB-th time steps (subcycling)
	if (t % N_SUB) == 0 {
		sim.broadcastAndWait(CmdComputeIDensity)

		for p := range N_G {
			sim.I_density[p] = 0.0
		}

		numWorkers := len(sim.WorkerCmdChan)

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
	sim.broadcastAndWait(CmdMoveElectrons)

	if sim.Measurement_mode {
		numWorkers := len(sim.WorkerCmdChan)

		for w := range numWorkers {
			diag := &sim.WorkerEDiag[w]

			for p := range N_G {
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
				sim.Ue_xt[p][t_index] += diag.ue[p]
				sim.Meanee_xt[p][t_index] += diag.meanee[p]
				sim.Ioniz_rate_xt[p][t_index] += diag.ioniz[p]
			}
			for eIdx := range N_EEPF {
				sim.Eepf[eIdx] += diag.eepf[eIdx]
			}
			sim.Mean_energy_accu_center += diag.accuCenter
			sim.Mean_energy_counter_center += diag.counterCenter
		}
	}
}

func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}
	sim.broadcastAndWait(CmdMoveIons)

	if sim.Measurement_mode {
		numWorkers := len(sim.WorkerCmdChan)
		for w := range numWorkers {
			diag := &sim.WorkerIDiag[w]
			for p := range N_G {
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
				sim.Ui_xt[p][t_index] += diag.ui[p]
				sim.Meanei_xt[p][t_index] += diag.meanei[p]
			}
		}
	}
}

func (sim *SimulationState) Step5CheckBoundariesElectrons() {
	sim.broadcastAndWait(CmdCheckBoundariesE)
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.N_e_abs_pow += sim.WorkerEDiag[w].abs_pow
		sim.N_e_abs_gnd += sim.WorkerEDiag[w].abs_gnd
	}
	// Usuwanie pochlonietych elektronow
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
	sim.broadcastAndWait(CmdCheckBoundariesI)

	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.N_i_abs_pow += sim.WorkerIDiag[w].abs_pow
		sim.N_i_abs_gnd += sim.WorkerIDiag[w].abs_gnd

		for eIdx := range N_IFED {
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
		}
	}

	// Usuwanie pochlonietych jonow
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
