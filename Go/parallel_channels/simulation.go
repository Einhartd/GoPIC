package gopic

import (
	"fmt"
)

/*
Uruchamia trwałe goroutines workerów w tle (startWorker).
Każdy worker nasłuchuje na dedykowanym kanale sim.WorkerCmdChan[w].
*/
func (sim *SimulationState) InitWorkers() {
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		go sim.startWorker(w)
	}
}

/*
Rozsyła rozkaz do wszystkich trwałych workerów za pomocą kanałów i oczekuje na potwierdzenie zakończenia.
Działa jako kanałowa bariera synchronizacyjna:
 1. Wysłanie wartości WorkerCommand do buforowanych kanałów WorkerCmdChan[w].
 2. Oczekiwanie w pętli na odebranie sygnału ukończenia z kanału WorkerDoneChan od każdego workera.

@param cmd Rozkaz do wykonania (WorkerCommand).
*/
func (sim *SimulationState) broadcastAndWait(cmd WorkerCommand) {
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.WorkerCmdChan[w] <- cmd
	}
	for range numWorkers {
		<-sim.WorkerDoneChan
	}
}

/*
Zatrzymuje trwałe goroutines workerów, wysyłając rozkaz CmdStop do ich kanałów poleceń.
*/
func (sim *SimulationState) StopWorkers() {
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.WorkerCmdChan[w] <- CmdStop
	}
}

/*
Inicjalizacja cząstek w domenie symulacji (Seed).
Losuje równomierne położenia początkowe cząstek x in [0, L] oraz zeruje ich wektory prędkości.
@param nseed Liczba par makrocząstek (elektronów i jonów) do wylosowania.
*/
func (sim *SimulationState) InitParticles(nseed int) {
	for i := 0; i < nseed; i++ {
		sim.X_e[i] = L * sim.R01() // Początkowa losowa pozycja elektronu
		sim.Vx_e[i] = 0
		sim.Vy_e[i] = 0
		sim.Vz_e[i] = 0            // Składowe prędkości elektronu
		sim.X_i[i] = L * sim.R01() // Początkowa losowa pozycja jonu
		sim.Vx_i[i] = 0
		sim.Vy_i[i] = 0
		sim.Vz_i[i] = 0 // Składowe prędkości jonu
	}
	sim.N_e = nseed // Początkowa liczba elektronów
	sim.N_i = nseed // Początkowa liczba jonów
}

/*
KROK 1a: Obliczanie gęstości ładunku elektronów metodą CIC z kanałową dystrybucją pracy (Channels).
Etapy:
 1. Rozesłanie rozkazu CmdComputeEDensity do workerów kanałami (broadcastAndWait).
 2. Workery równolegle wykonują depozycję do prywatnych buforów WorkerEDensity.
 3. Redukcja (sumowanie) buforów workerów do tablicy globalnej E_density w wątku głównym.
 4. Korekta gęstości w skrajnych półkomórkach (węzły 0 i N_G-1) mnożona x2.
 5. Akumulacja do skumulowanej gęstości Cumul_e_density.
*/
func (sim *SimulationState) Step1ComputeElectronDensity() {

	// ZRÓWNOLEGLENIE: Wysłanie rozkazu depozycji elektronów do kanałów workerów
	sim.broadcastAndWait(CmdComputeEDensity)

	// REDUKCJA: Wątek główny zeruje globalną tablicę i sumuje wkłady ze wszystkich workerów.
	for p := range N_G {
		sim.E_density[p] = 0.0
	}
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		for p := range N_G {
			sim.E_density[p] += sim.WorkerEDensity[w][p]
		}
	}
	// Poprawki brzegowe dla skrajnych półkomórek i akumulacja w czasie
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p := range N_G {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

/*
KROK 1b: Obliczanie gęstości ładunku jonów (Subcycling co N_SUB kroków).
Etapy:
 1. Jeśli (t % N_SUB == 0): rozesłanie rozkazu CmdComputeIDensity do kanałów workerów.
 2. Workery równolegle wykonują depozycję jonów CIC do WorkerIDensity.
 3. Redukcja buforów workerów do tablicy globalnej I_density z korektą brzegową x2.
 4. Akumulacja do Cumul_i_density w KAŻDYM kroku czasowym (niezmiennik subcyclingu).

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	if (t % N_SUB) == 0 {

		// ZRÓWNOLEGLENIE: Wysłanie rozkazu depozycji jonów w krokach subcyclingu
		sim.broadcastAndWait(CmdComputeIDensity)

		// Redukcja buforów jonowych do globalnej tablicy I_density
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

	// Niezmiennik subcyclingu: ciągła akumulacja do średniej
	for p := range N_G {
		sim.Cumul_i_density[p] += sim.I_density[p]
	}
}

/*
KROK 2: Rozwiązanie równania Poissona (1D Field Solver).
Oblicza gęstość ładunku wypadkowego rho = e * (n_i - n_e) i wywołuje solver trójdiagonalny.
Wykonywane sekwencyjnie w jednym wątku.
@param currentTime Aktualny fizyczny czas symulacji [s].
*/
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
	var rho Xvector
	for p := range N_G {
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // Gęstość ładunku przestrzennego
	}
	sim.SolvePoisson(&rho, currentTime) // Obliczenie potencjału i pola E
}

/*
KROK 3: Popychanie elektronów (Push / Leap-Frog) i akumulacja diagnostyk.
Etapy:
 1. Rozesłanie rozkazu CmdMoveElectrons do workerów za pomocą kanałów (broadcastAndWait).
 2. Workery równolegle interpolują pole E, integrują równania ruchu Leap-Frog i zbierają diagnostyki do WorkerEDiag.
 3. W trybie pomiarowym: redukcja diagnostyk workerów do macierzy XT i tablicy EEPF.

@param t_index Indeks przedziału czasowego dla diagnostyk XT (t / N_BIN).
*/
func (sim *SimulationState) Step3MoveElectrons(t_index int) {

	// ZRÓWNOLEGLENIE: Wysłanie rozkazu popychania elektronów do kanałów workerów
	sim.broadcastAndWait(CmdMoveElectrons)

	// Redukcja diagnostyk ze wszystkich workerów do macierzy XT i tablicy EEPF
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

/*
KROK 4: Popychanie jonów (Push / Leap-Frog, Subcycling co N_SUB kroków).
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Rozesłanie rozkazu CmdMoveIons do workerów (broadcastAndWait).
 3. Workery równolegle popychają jony i zbierają diagnostyki jonowe do WorkerIDiag.
 4. Redukcja diagnostyk jonowych do globalnych macierzy XT w wątku głównym.

@param t_index Indeks przedziału czasowego dla diagnostyk XT (t / N_BIN).
@param t       Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	// ZRÓWNOLEGLENIE: Wysłanie rozkazu popychania jonów do kanałów workerów
	sim.broadcastAndWait(CmdMoveIons)

	// Redukcja diagnostyk jonowych do macierzy XT
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

/*
KROK 5: Sprawdzanie granic dla elektronów (Dwufazowe: Równoległe oznaczanie + Seryjna kompaktacja).
Etapy:
 1. Faza 1 (Równoległa): Rozesłanie CmdCheckBoundariesE, workery oznaczają flagi w AbsorbedE i zliczają absorpcję.
 2. Redukcja liczników absorpcji na elektrodzie zasilanej i uziemionej.
 3. Faza 2 (Seryjna): Kompaktacja tablic SoA in-place metodą swap-with-last.
*/
func (sim *SimulationState) Step5CheckBoundariesElectrons() {

	// FAZA 1 (Równoległa): Rozesłanie rozkazu oznaczania granic elektronów
	sim.broadcastAndWait(CmdCheckBoundariesE)

	// Redukcja liczników absorpcji elektronów
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.N_e_abs_pow += sim.WorkerEDiag[w].abs_pow
		sim.N_e_abs_gnd += sim.WorkerEDiag[w].abs_gnd
	}

	// FAZA 2 (Sekwencyjna): Kompaktacja tablic elektronów in-place (swap-with-last)
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

/*
KROK 6: Sprawdzanie granic dla jonów (Subcycling co N_SUB kroków).
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Faza 1 (Równoległa): Rozesłanie CmdCheckBoundariesI, workery oznaczają jony i próbkują histogram IFED.
 3. Redukcja liczników absorpcji oraz histogramów IFED do tablic globalnych.
 4. Faza 2 (Seryjna): Kompaktacja tablicy jonów swap-with-last.

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	// FAZA 1 (Równoległa): Rozesłanie rozkazu oznaczania granic jonów i IFED
	sim.broadcastAndWait(CmdCheckBoundariesI)

	// Redukcja liczników absorpcji oraz histogramów IFED
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		sim.N_i_abs_pow += sim.WorkerIDiag[w].abs_pow
		sim.N_i_abs_gnd += sim.WorkerIDiag[w].abs_gnd

		for eIdx := range N_IFED {
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
		}
	}

	// FAZA 2 (Sekwencyjna): Kompaktacja tablicy jonów in-place (swap-with-last)
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

/*
KROK 9: Zbieranie danych czasoprzestrzennych do macierzy XT.
Akumuluje chwilowy potencjał, pole elektryczne oraz gęstości ładunków dla indeksu czasowego t_index.
Wykonywane tylko przy włączonym trybie pomiarowym (Measurement_mode = true).
@param t_index Indeks czasowy w macierzy XT (t / N_BIN).
*/
func (sim *SimulationState) Step9CollectXtData(t_index int) {
	if !sim.Measurement_mode {
		return
	}

	for p := range N_G {
		sim.Pot_xt[p][t_index] += sim.Pot[p]
		sim.Efield_xt[p][t_index] += sim.Efield[p]
		sim.Ne_xt[p][t_index] += sim.E_density[p]
		sim.Ni_xt[p][t_index] += sim.I_density[p]
	}
}

/*
Wykonanie pełnego okresu zasilania w.cz. (jeden cykl RF = N_T kroków czasowych dt_e).
Główna pętla czasowa realizująca sekwencję kroków PIC/MCC:
 1. Aktualizacja czasu: Time += DT_E.
 2. Krok 1a i 1b: Depozycja gęstości ładunku elektronów i jonów (CIC).
 3. Krok 2: Rozwiązanie równania Poissona (Thomas TDMA).
 4. Krok 3 i 4: Popychanie cząstek (Leap-Frog) i akumulacja diagnostyk.
 5. Krok 5 i 6: Sprawdzanie granic i absorpcja na elektrodach.
 6. Krok 7 i 8: Zderzenia cząstek z gazem neutralnym (MCC).
 7. Krok 9: Akumulacja macierzy czasoprzestrzennych XT.
 8. Zapis postępu do pliku zbieżności conv.dat.
*/
func (sim *SimulationState) DoOneCycle() {
	var t int
	var t_index int

	for t = range N_T {
		sim.Time += DT_E    // Aktualizacja całkowitego fizycznego czasu symulacji
		t_index = t / N_BIN // Indeks dla macierzy czasoprzestrzennych XT

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

/*
Funkcja pomocnicza: Wyznaczenie minimum z dwóch liczb całkowitych.
@param a Pierwsza liczba całkowita.
@param b Druga liczba całkowita.
@return Mniejsza z wartości a i b.
*/
func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}
