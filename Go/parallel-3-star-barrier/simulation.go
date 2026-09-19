package gopic

import (
	"fmt"
	"runtime"
)

/*
broadcastAndWait rozsyła rozkaz do workerów za pośrednictwem bezblokadowej bariery StarBarrier.
Koordynator samodzielnie wykonuje chunk 0 (eliminując marnowanie rdzenia i goroutine oversubscription),
a następnie czeka w pętli PAUSE na zakończenie pozostałych workerów.
*/
func (sim *SimulationState) broadcastAndWait(cmd WorkerCommand) {
	sim.Barrier.cmd.Store(int32(cmd))
	target := sim.Barrier.step.Add(1)

	// Koordynator natychmiast wykonuje chunk 0
	sim.executeWorkerTask(0, cmd)
	sim.Barrier.workerDone[0].val.Store(target)

	// Czeka na zakończenie workerów 1 .. NumWorkers-1
	for i := 1; i < sim.NumWorkers; i++ {
		spins := 0
		for sim.Barrier.workerDone[i].val.Load() < target {
			procyield(30)
			spins++
			if spins > 200 {
				runtime.Gosched()
				spins = 0
			}
		}
	}
}

/*
StopWorkers zatrzymuje trwałe goroutines workerów, wysyłając rozkaz CmdStop przez barierę.
*/
func (sim *SimulationState) StopWorkers() {
	if sim.NumWorkers <= 1 {
		return
	}
	sim.Barrier.cmd.Store(int32(CmdStop))
	target := sim.Barrier.step.Add(1)
	sim.Barrier.workerDone[0].val.Store(target)

	for i := 1; i < sim.NumWorkers; i++ {
		spins := 0
		for sim.Barrier.workerDone[i].val.Load() < target {
			procyield(30)
			spins++
			if spins > 200 {
				runtime.Gosched()
				spins = 0
			}
		}
	}
}

/*
Inicjalizacja cząstek w domenie symulacji (Seed).
*/
func (sim *SimulationState) InitParticles(nseed int) {
	for i := 0; i < nseed; i++ {
		sim.X_e[i] = L * sim.R01()
		sim.Vx_e[i] = 0
		sim.Vy_e[i] = 0
		sim.Vz_e[i] = 0
		sim.X_i[i] = L * sim.R01()
		sim.Vx_i[i] = 0
		sim.Vy_i[i] = 0
		sim.Vz_i[i] = 0
	}
	sim.N_e = nseed
	sim.N_i = nseed
	sim.UpdateChunkSizes()
}

/*
KROK 1a: Obliczanie gęstości ładunku elektronów metodą CIC ze zoptymalizowaną redukcją sekwencyjną (streaming access).
*/
func (sim *SimulationState) Step1ComputeElectronDensity() {
	sim.broadcastAndWait(CmdComputeEDensity)

	// Zoptymalizowana redukcja strumieniowa:
	// Kopiujemy wkład workera 0 (sekwencyjny odczyt i zapis w pamięci cache L1)
	w0 := &sim.WorkerEDensity[0]
	for p := 0; p < N_G; p++ {
		sim.E_density[p] = w0[p]
	}

	// Dodajemy wkłady pozostałych workerów (sekwencyjny streaming, brak skoków pamięciowych)
	for w := 1; w < sim.NumWorkers; w++ {
		wb := &sim.WorkerEDensity[w]
		for p := 0; p < N_G; p++ {
			sim.E_density[p] += wb[p]
		}
	}

	// Korekta skrajnych półkomórek i akumulacja w czasie
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p := 0; p < N_G; p++ {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

/*
KROK 1b: Obliczanie gęstości ładunku jonów (Subcycling co N_SUB kroków).
*/
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	if (t % N_SUB) == 0 {
		sim.broadcastAndWait(CmdComputeIDensity)

		w0 := &sim.WorkerIDensity[0]
		for p := 0; p < N_G; p++ {
			sim.I_density[p] = w0[p]
		}

		for w := 1; w < sim.NumWorkers; w++ {
			wb := &sim.WorkerIDensity[w]
			for p := 0; p < N_G; p++ {
				sim.I_density[p] += wb[p]
			}
		}

		sim.I_density[0] *= 2.0
		sim.I_density[N_G-1] *= 2.0
	}

	for p := 0; p < N_G; p++ {
		sim.Cumul_i_density[p] += sim.I_density[p]
	}
}

/*
KROK 2: Rozwiązanie równania Poissona (1D Field Solver).
Wykonywane sekwencyjnie w jednym wątku.
*/
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
	var rho Xvector
	for p := 0; p < N_G; p++ {
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p])
	}
	sim.SolvePoisson(&rho, currentTime)
}

/*
KROK 3: Popychanie elektronów (Push / Leap-Frog) - bez sprawdzania granic w tej fazie.
*/
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
	sim.broadcastAndWait(CmdMoveElectrons)

	if sim.Measurement_mode {
		for w := 0; w < sim.NumWorkers; w++ {
			diag := &sim.WorkerEDiag[w]

			for p := 0; p < N_G; p++ {
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
				sim.Ue_xt[p][t_index] += diag.ue[p]
				sim.Meanee_xt[p][t_index] += diag.meanee[p]
				sim.Ioniz_rate_xt[p][t_index] += diag.ioniz[p]
			}
			for eIdx := 0; eIdx < N_EEPF; eIdx++ {
				sim.Eepf[eIdx] += diag.eepf[eIdx]
			}
			sim.Mean_energy_accu_center += diag.accuCenter
			sim.Mean_energy_counter_center += diag.counterCenter
		}
	}
}

/*
KROK 4: Popychanie jonów (Push / Leap-Frog) - bez sprawdzania granic w tej fazie.
*/
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	sim.broadcastAndWait(CmdMoveIons)

	if sim.Measurement_mode {
		for w := 0; w < sim.NumWorkers; w++ {
			diag := &sim.WorkerIDiag[w]
			for p := 0; p < N_G; p++ {
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
				sim.Ui_xt[p][t_index] += diag.ui[p]
				sim.Meanei_xt[p][t_index] += diag.meanei[p]
			}
		}
	}
}

/*
KROK 5: Sprawdzenie granic elektronów i seryjna kompaktacja in-place O(dead).
*/
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
	sim.broadcastAndWait(CmdCheckBoundariesElectrons)
	sim.Step5CompactElectrons()
}

func (sim *SimulationState) Step5CompactElectrons() {
	var totalAbs int
	for w := 0; w < sim.NumWorkers; w++ {
		p := sim.WorkerEDiag[w].abs_pow
		g := sim.WorkerEDiag[w].abs_gnd
		sim.N_e_abs_pow += p
		sim.N_e_abs_gnd += g
		totalAbs += int(p + g)
	}

	if totalAbs > 0 {
		lastValid := sim.N_e - 1
		for w := 0; w < sim.NumWorkers; w++ {
			for _, deadIdx := range sim.WorkerDeadElectrons[w] {
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
					lastValid--
				}
				if lastValid > deadIdx {
					sim.X_e[deadIdx] = sim.X_e[lastValid]
					sim.Vx_e[deadIdx] = sim.Vx_e[lastValid]
					sim.Vy_e[deadIdx] = sim.Vy_e[lastValid]
					sim.Vz_e[deadIdx] = sim.Vz_e[lastValid]
					lastValid--
				}
			}
			sim.WorkerDeadElectrons[w] = sim.WorkerDeadElectrons[w][:0]
			sim.WorkerEDiag[w].abs_pow = 0
			sim.WorkerEDiag[w].abs_gnd = 0
		}
		sim.N_e -= totalAbs
		sim.UpdateChunkSizes()
	}
}

/*
KROK 6: Sprawdzenie granic jonów i seryjna kompaktacja in-place O(dead).
*/
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	sim.broadcastAndWait(CmdCheckBoundariesIons)
	sim.Step6CompactIons(t)
}

func (sim *SimulationState) Step6CompactIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var totalAbs int
	for w := 0; w < sim.NumWorkers; w++ {
		p := sim.WorkerIDiag[w].abs_pow
		g := sim.WorkerIDiag[w].abs_gnd
		sim.N_i_abs_pow += p
		sim.N_i_abs_gnd += g
		totalAbs += int(p + g)

		for eIdx := 0; eIdx < N_IFED; eIdx++ {
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
		}
	}

	if totalAbs > 0 {
		lastValid := sim.N_i - 1
		for w := 0; w < sim.NumWorkers; w++ {
			for _, deadIdx := range sim.WorkerDeadIons[w] {
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
					lastValid--
				}
				if lastValid > deadIdx {
					sim.X_i[deadIdx] = sim.X_i[lastValid]
					sim.Vx_i[deadIdx] = sim.Vx_i[lastValid]
					sim.Vy_i[deadIdx] = sim.Vy_i[lastValid]
					sim.Vz_i[deadIdx] = sim.Vz_i[lastValid]
					lastValid--
				}
			}
			sim.WorkerDeadIons[w] = sim.WorkerDeadIons[w][:0]
			sim.WorkerIDiag[w].abs_pow = 0
			sim.WorkerIDiag[w].abs_gnd = 0
		}
		sim.N_i -= totalAbs
		sim.UpdateChunkSizes()
	}
}

/*
KROK 9: Zbieranie danych czasoprzestrzennych do macierzy XT.
*/
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

/*
DoOneCycle wykonuje pełny okres RF (N_T kroków).
*/
func (sim *SimulationState) DoOneCycle() {
	var t int
	var t_index int

	for t = 0; t < N_T; t++ {
		sim.Time += DT_E
		t_index = t / N_BIN

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
