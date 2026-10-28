package gopic

import (
	"fmt"
	"runtime"
)

// broadcastAndWait rozsyła rozkaz cmd do zespołu workerów za pośrednictwem bariery StarBarrier.
// Wątek koordynatora samodzielnie wykonuje pracę dla podzbioru 0, a następnie oczekuje
// w niskolatencyjnej pętli procyield na zakończenie pracy przez pozostałe workery (1 .. NumWorkers-1).
//
// Parametry:
//   - cmd: rozkaz określający fazę obliczeń do wykonania przez wszystkie workery.
func (sim *SimulationState) broadcastAndWait(cmd WorkerCommand) {
	sim.Barrier.cmd.Store(int32(cmd))
	target := sim.Barrier.step.Add(1)

	// Wątek główny wykonuje bezpośrednio podzbiór 0
	sim.executeWorkerTask(0, cmd)
	sim.Barrier.workerDone[0].val.Store(target)

	// Oczekiwanie na ukończenie kroku przez pozostałe workery w tle
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

// StopWorkers zatrzymuje wszystkie trwałe goroutines robocze działające w tle,
// wysyłając rozkaz CmdStop przez barierę StarBarrier.
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

// InitParticles inicjalizuje populację początkową elektronów i jonów w obszarze wyładowczym,
// rozmieszczając zadaną liczbę par makrocząstek jednorodnie w przestrzeni [0, L]
// z zerowymi prędkościami początkowymi oraz aktualizując rozmiary podzbiorów dla workerów.
//
// Parametry:
//   - nseed: liczba par elektron-jon tworzonych na starcie symulacji.
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

// Step1ComputeElectronDensity realizuje równoległą depozycję gęstości ładunku elektronów metodą CIC
// oraz sekwencyjną redukcję buforów prywatnych WorkerEDensity do tablicy globalnej E_density.
func (sim *SimulationState) Step1ComputeElectronDensity() {
	sim.broadcastAndWait(CmdComputeEDensity)

	// Skopiowanie tablicy pierwszego workera jako bazy do redukcji
	w0 := &sim.WorkerEDensity[0]
	for p := 0; p < N_G; p++ {
		sim.E_density[p] = w0[p]
	}

	// Sekwencyjne zsumowanie wkładów od pozostałych workerów
	for w := 1; w < sim.NumWorkers; w++ {
		wb := &sim.WorkerEDensity[w]
		for p := 0; p < N_G; p++ {
			sim.E_density[p] += wb[p]
		}
	}

	// Korekta objętości połowicznych komórek brzegowych na elektrodach (mnożnik 2.0) oraz akumulacja
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p := 0; p < N_G; p++ {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

// Step1ComputeIonDensity realizuje równoległą depozycję gęstości ładunku jonów metodą CIC
// co N_SUB kroków czasowych (subcycling) oraz w każdym kroku akumuluje tablicę Cumul_i_density.
//
// Parametry:
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
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

// Step2SolvePoisson wyznacza wypadkową gęstość ładunku przestrzennego rho = e * (n_i - n_e)
// w węzłach siatki i rozwiązuje równanie Poissona dla zadanego czasu fizycznego.
//
// Parametry:
//   - currentTime: aktualny fizyczny czas symulacji [s].
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
	var rho Xvector
	for p := 0; p < N_G; p++ {
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p])
	}
	sim.SolvePoisson(&rho, currentTime)
}

// Step3MoveAndBoundariesElectrons zleca workerom równoległe wykonanie połączonego kroku przesunięcia
// elektronów i detekcji granic, a w trybie pomiarowym redukuje zebrane bufory diagnostyczne do tablic globalnych.
//
// Parametry:
//   - t_index: indeks przedziału czasowego dla macierzy diagnostyk XT (t / N_BIN).
func (sim *SimulationState) Step3MoveAndBoundariesElectrons(t_index int) {
	sim.broadcastAndWait(CmdMoveElectronsAndBoundaries)

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

// Step4MoveAndBoundariesIons zleca workerom równoległe wykonanie połączonego kroku przesunięcia jonów,
// detekcji granic i zliczania IFED co N_SUB kroków czasowych, a w trybie pomiarowym redukuje diagnostyki XT.
//
// Parametry:
//   - t_index: indeks przedziału czasowego dla macierzy diagnostyk XT (t / N_BIN).
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
func (sim *SimulationState) Step4MoveAndBoundariesIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	sim.broadcastAndWait(CmdMoveIonsAndBoundaries)

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

// Step5CompactElectrons wykonuje dwuwskaźnikową kompaktację in-place tablic elektronowych,
// zastępując elektrony zaabsorbowane na elektrodach (zgromadzone w WorkerDeadElectrons)
// aktywnymi cząstkami z końca tablicy w czasie proporcjonalnym wyłącznie do liczby usuniętych cząstek.
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

// Step6CompactIons redukuje lokalne histogramy IFED oraz wykonuje dwuwskaźnikową kompaktację in-place
// tablic jonowych co N_SUB kroków czasowych.
//
// Parametry:
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
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

// Step9CollectXtData akumuluje chwilowe profile potencjału, pola elektrycznego oraz gęstości
// cząstek do macierzy rozkładów czasoprzestrzennych XT, gdy aktywny jest tryb pomiarowy.
//
// Parametry:
//   - t_index: indeks przedziału czasowego dla macierzy diagnostyk XT (t / N_BIN).
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

// DoOneCycle wykonuje jeden pełny okres RF symulacji (N_T = 4000 kroków czasowych DT_E),
// koordynując pracę trwałych workerów za pomocą bezblokadowej bariery StarBarrier.
func (sim *SimulationState) DoOneCycle() {
	for t := 0; t < N_T; t++ {
		sim.Time += DT_E
		t_index := t / N_BIN

		// Krok 1 i 2: Równoległa depozycja gęstości ładunku i rozwiązanie równania Poissona
		sim.Step1ComputeElectronDensity()
		sim.Step1ComputeIonDensity(t)
		sim.Step2SolvePoisson(sim.Time)

		// Kroki 3 i 4: Równoległe przesunięcie elektronów i jonów połączone z detekcją granic
		sim.Step3MoveAndBoundariesElectrons(t_index)
		sim.Step4MoveAndBoundariesIons(t_index, t)

		// Kroki 5 i 6: Seryjna kompaktacja in-place usuniętych cząstek
		sim.Step5CompactElectrons()
		sim.Step6CompactIons(t)

		// Kroki 7 i 8: Równoległe zderzenia Monte Carlo metodą Null-Collision
		sim.Step7CollisionsElectrons()
		sim.Step8CollisionIons(t)

		// Krok 9: Zbieranie rozkładów czasoprzestrzennych XT
		sim.Step9CollectXtData(t_index)

		if (t % 1000) == 0 {
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
		}
	}
	fmt.Fprintf(sim.Datafile, "%8d  %8d  %8d\n", sim.Cycle, sim.N_e, sim.N_i)
}

// minInt zwraca mniejszą z dwóch liczb całkowitych.
//
// Parametry:
//   - a: pierwsza liczba całkowita.
//   - b: druga liczba całkowita.
//
// Zwraca:
//   - mniejsza z wartości a i b.
func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}
