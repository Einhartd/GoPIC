package gopic

import (
	"fmt"
	"math"
	"sync"
)

/*
Inicjalizacja cząstek początkowych (seed) w domenie 1D3V.
Losuje pozycje elektronów i jonów z rozkładu jednorodnego w przedziale [0, L] oraz zeruje prędkości.
@param nseed Liczba par makrocząstek do wylosowania na początku symulacji.
*/
func (sim *SimulationState) InitParticles(nseed int) {
	for i := range nseed {
		sim.X_e[i] = L * sim.R01() // Początkowa losowa pozycja elektronu [m]
		sim.Vx_e[i] = 0
		sim.Vy_e[i] = 0
		sim.Vz_e[i] = 0            // Składowe prędkości elektronu
		sim.X_i[i] = L * sim.R01() // Początkowa losowa pozycja jonu [m]
		sim.Vx_i[i] = 0
		sim.Vy_i[i] = 0
		sim.Vz_i[i] = 0 // Składowe prędkości jonu
	}
	sim.N_e = nseed // Początkowa liczba elektronów
	sim.N_i = nseed // Początkowa liczba jonów
}

/*
KROK 1a: Obliczanie gęstości ładunku elektronów metodą CIC (Cloud-in-Cell) z chunkingiem.
Etapy:
 1. Podział tablicy N_e na równe chunki pomiędzy goroutines.
 2. Każdy worker zeruje swój prywatny bufor WorkerEDensity i wykonuje depozycję wagową CIC.
 3. Redukcja (sumowanie) buforów workerów do tablicy globalnej E_density.
 4. Korekta gęstości w skrajnych półkomórkach (węzły 0 i N_G-1) mnożona x2.
 5. Akumulacja do skumulowanej gęstości Cumul_e_density.
*/
func (sim *SimulationState) Step1ComputeElectronDensity() {
	numWorkers := sim.NumWorkers
	var wg sync.WaitGroup

	// ZRÓWNOLEGLENIE: Podział przestrzeni N_e cząstek na równe bloki (chunki).
	// Rozmiar chunka wyliczany jako ceil(N_e / numWorkers).
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

		// Start goroutine (workerID): Przetwarzanie zakresu cząstek [s, e).
		// Każdy worker operuje wyłącznie na swoim prywatnym buforze WorkerEDensity[workerID],
		// co eliminuje wyścigi danych (Data Races) i potrzebę stosowania blokad (Mutex).
		wg.Go(func() {
			// 1. Zerowanie prywatnego bufora gęstości danego workera
			for p := range N_G {
				sim.WorkerEDensity[workerID][p] = 0.0
			}
			// 2. Depozycja wagowa ładunku cząstek do siatki (schemat liniowy CIC)
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

	// BARIERA SYNCHRONIZACYJNA: Oczekiwanie na zakończenie depozycji przez wszystkie goroutines.
	wg.Wait()

	// REDUKCJA: Wątek główny zeruje globalną tablicę i sumuje wkłady ze wszystkich workerów.
	for p := range N_G {
		sim.E_density[p] = 0.0
	}
	for w := range numWorkers {
		for p := range N_G {
			sim.E_density[p] += sim.WorkerEDensity[w][p]
		}
	}

	// Poprawki brzegowe dla skrajnych półkomórek (węzły 0 i N_G-1) oraz akumulacja w czasie
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p := range N_G {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

/*
KROK 1b: Obliczanie gęstości ładunku jonów (Subcycling co N_SUB kroków).
Etapy:
 1. Jeśli (t % N_SUB == 0): podział jonów na chunki i depozycja CIC do prywatnych buforów.
 2. Redukcja buforów workerów do tablicy globalnej I_density z korektą brzegową x2.
 3. Akumulacja do Cumul_i_density w KAŻDYM kroku czasowym (niezmiennik subcyclingu).

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	if (t % N_SUB) == 0 { // Gęstość jonów przeliczana w subcyclingu co N_SUB kroków
		numWorkers := sim.NumWorkers
		var wg sync.WaitGroup

		// ZRÓWNOLEGLENIE: Podział tablicy jonów N_i na chunki pomiędzy workery
		chunkSize := (sim.N_i + numWorkers - 1) / numWorkers

		for w := range numWorkers {
			start := w * chunkSize
			end := min((w+1)*chunkSize, sim.N_i)
			if start >= end {
				continue
			}
			workerID, s, e := w, start, end

			// Start goroutine: lokalna depozycja CIC jonów do bufora WorkerIDensity[workerID]
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

		// Bariera synchronizacyjna jonów
		wg.Wait()

		// Redukcja buforów jonowych do globalnej tablicy I_density
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
	// Niezmiennik subcyclingu: ciągła akumulacja do średniej w każdym kroku czasowym
	for p := range N_G {
		sim.Cumul_i_density[p] += sim.I_density[p]
	}
}

/*
KROK 2: Rozwiązanie równania Poissona (1D Field Solver).
Oblicza gęstość ładunku wypadkowego rho = e * (n_i - n_e) i wywołuje solver trójdiagonalny.
Wykonywane sekwencyjnie w jednym wątku (zbyt mały rozmiar siatki N_G=400 na zysk z paralelizacji).
@param currentTime Aktualny fizyczny czas symulacji [s].
*/
func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
	var rho Xvector
	for p := 0; p < N_G; p++ {
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // Gęstość ładunku przestrzennego
	}
	sim.SolvePoisson(&rho, currentTime) // Obliczenie potencjału i pola E
}

/*
KROK 3: Popychanie elektronów (Push / Leap-Frog) i akumulacja diagnostyk z chunkingiem.
Etapy:
 1. Podział elektronów na chunki pomiędzy goroutines.
 2. W trybie pomiarowym: wyzerowanie prywatnych struktur diagnostycznych WorkerEDiag.
 3. Interpolacja liniowa pola elektrycznego (CIC) do ciągłej pozycji elektronu.
 4. Gromadzenie wielkości diagnostycznych (prędkość, energia, jonizacja, EEPF w centrum).
 5. Integracja równań ruchu schematem Leap-Frog (aktualizacja Vx_e i X_e).
 6. Redukcja struktur diagnostycznych workerów do globalnych macierzy XT i tablicy EEPF.

@param t_index Indeks przedziału czasowego dla diagnostyk XT (t / N_BIN).
*/
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
	numWorkers := sim.NumWorkers
	var wg sync.WaitGroup

	// ZRÓWNOLEGLENIE: Popychanie N_e elektronów podzielone na ciągłe chunki.
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers

	for w := range numWorkers {
		start := w * chunkSize
		end := min((w+1)*chunkSize, sim.N_e)
		if start >= end {
			continue
		}
		workerID, s, e := w, start, end

		// Start goroutine: Przetwarzanie cząstek k = s .. e-1
		// Zapisy pozycji X_e i prędkości Vx_e są rozłączne (brak konfliktów).
		// Diagnostyki trafiają do prywatnej struktury WorkerEDiag[workerID].
		wg.Go(func() {
			if sim.Measurement_mode {
				// SLOW-PATH: Zbieranie diagnostyk XT i EEPF
				diag := &sim.WorkerEDiag[workerID]
				*diag = electronWorkerDiagnostics{}

				var c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate float64
				var p, energy_index int

				for k := s; k < e; k++ {
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
					sim.X_e[k] += sim.Vx_e[k] * DT_E
				}
			} else {
				// FAST-PATH: Czysty Leap-Frog (90%+ cykli symulacji)
				// BCE: Wskazówka eliminacji sprawdzeń granic
				if e > s {
					_ = sim.X_e[e-1]
					_ = sim.Vx_e[e-1]
				}

				k := s
				// Główna pętla 4-krotnie rozwinięta (ILP)
				for ; k <= e-4; k += 4 {
					// 1. Cząstka 0
					c0_0 := sim.X_e[k] * INV_DX
					p0 := min(max(int(c0_0), 0), N_G-2)
					c1_0 := float64(p0) + 1.0 - c0_0
					c2_0 := c0_0 - float64(p0)
					ex0 := c1_0*sim.Efield[p0] + c2_0*sim.Efield[p0+1]

					// 2. Cząstka 1
					c0_1 := sim.X_e[k+1] * INV_DX
					p1 := min(max(int(c0_1), 0), N_G-2)
					c1_1 := float64(p1) + 1.0 - c0_1
					c2_1 := c0_1 - float64(p1)
					ex1 := c1_1*sim.Efield[p1] + c2_1*sim.Efield[p1+1]

					// 3. Cząstka 2
					c0_2 := sim.X_e[k+2] * INV_DX
					p2 := min(max(int(c0_2), 0), N_G-2)
					c1_2 := float64(p2) + 1.0 - c0_2
					c2_2 := c0_2 - float64(p2)
					ex2 := c1_2*sim.Efield[p2] + c2_2*sim.Efield[p2+1]

					// 4. Cząstka 3
					c0_3 := sim.X_e[k+3] * INV_DX
					p3 := min(max(int(c0_3), 0), N_G-2)
					c1_3 := float64(p3) + 1.0 - c0_3
					c2_3 := c0_3 - float64(p3)
					ex3 := c1_3*sim.Efield[p3] + c2_3*sim.Efield[p3+1]

					// Aktualizacja prędkości Leap-Frog (niezależne potoki FMA)
					vx0 := sim.Vx_e[k] - ex0*FACTOR_E
					vx1 := sim.Vx_e[k+1] - ex1*FACTOR_E
					vx2 := sim.Vx_e[k+2] - ex2*FACTOR_E
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E

					sim.Vx_e[k] = vx0
					sim.Vx_e[k+1] = vx1
					sim.Vx_e[k+2] = vx2
					sim.Vx_e[k+3] = vx3

					// Aktualizacja położeń
					sim.X_e[k] += vx0 * DT_E
					sim.X_e[k+1] += vx1 * DT_E
					sim.X_e[k+2] += vx2 * DT_E
					sim.X_e[k+3] += vx3 * DT_E
				}

				// Pętla resztkowa (tail loop) dla reszty z dzielenia przez 4
				for ; k < e; k++ {
					c0 := sim.X_e[k] * INV_DX
					p := min(max(int(c0), 0), N_G-2)
					c1 := float64(p) + 1.0 - c0
					c2 := c0 - float64(p)
					ex := c1*sim.Efield[p] + c2*sim.Efield[p+1]

					sim.Vx_e[k] -= ex * FACTOR_E
					sim.X_e[k] += sim.Vx_e[k] * DT_E
				}
			}
		})
	}

	// Bariera synchronizacyjna: oczekiwanie na zakończenie ruchu wszystkich elektronów
	wg.Wait()

	// Redukcja diagnostyk ze wszystkich workerów do macierzy XT i tablicy EEPF
	if sim.Measurement_mode {
		for w := range numWorkers {
			for p := range N_G {
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
				sim.Ue_xt[p][t_index] += sim.WorkerEDiag[w].ue[p]
				sim.Meanee_xt[p][t_index] += sim.WorkerEDiag[w].meanee[p]
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
			}
			for i := range N_EEPF {
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
			}
			sim.Mean_energy_accu_center += sim.WorkerEDiag[w].accuCenter
			sim.Mean_energy_counter_center += sim.WorkerEDiag[w].counterCenter
		}
	}
}

/*
KROK 4: Popychanie jonów (Push / Leap-Frog, Subcycling co N_SUB kroków).
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Podział jonów na chunki pomiędzy goroutines.
 3. W trybie pomiarowym: zerowanie buforów diagnostycznych i interpolacja pola E.
 4. Popychanie cząstek schematem Leap-Frog z uwzględnieniem dodatniego ładunku jonów (+e).
 5. Redukcja diagnostyk jonowych do globalnych macierzy czasoprzestrzennych XT.

@param t_index Indeks przedziału czasowego dla diagnostyk XT (t / N_BIN).
@param t       Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	numWorkers := sim.NumWorkers
	var wg sync.WaitGroup

	// ZRÓWNOLEGLENIE: Popychanie N_i jonów w chunkach w krokach subcyclingu
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers

	for w := range numWorkers {
		start := w * chunkSize
		end := min((w+1)*chunkSize, sim.N_i)
		if start >= end {
			continue
		}
		workerID, s, e := w, start, end

		// Start goroutine: popychanie jonów Leap-Frog i zbieranie diagnostyk jonowych
		wg.Go(func() {
			if sim.Measurement_mode {
				// SLOW-PATH: Diagnostyki jonowe
				diag := &sim.WorkerIDiag[workerID]
				*diag = ionWorkerDiagnostics{}

				var c0, c1, c2, e_x, mean_v, v_sqr, energy float64
				var p int

				for k := s; k < e; k++ {
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

					// Jony mają ładunek dodatni (+e)
					sim.Vx_i[k] += e_x * FACTOR_I
					sim.X_i[k] += sim.Vx_i[k] * DT_I
				}
			} else {
				// FAST-PATH: Czysty Leap-Frog jonów (4-way unrolling + BCE)
				if e > s {
					_ = sim.X_i[e-1]
					_ = sim.Vx_i[e-1]
				}

				k := s
				for ; k <= e-4; k += 4 {
					// 1. Cząstka 0
					c0_0 := sim.X_i[k] * INV_DX
					p0 := min(max(int(c0_0), 0), N_G-2)
					c1_0 := float64(p0) + 1.0 - c0_0
					c2_0 := c0_0 - float64(p0)
					ex0 := c1_0*sim.Efield[p0] + c2_0*sim.Efield[p0+1]

					// 2. Cząstka 1
					c0_1 := sim.X_i[k+1] * INV_DX
					p1 := min(max(int(c0_1), 0), N_G-2)
					c1_1 := float64(p1) + 1.0 - c0_1
					c2_1 := c0_1 - float64(p1)
					ex1 := c1_1*sim.Efield[p1] + c2_1*sim.Efield[p1+1]

					// 3. Cząstka 2
					c0_2 := sim.X_i[k+2] * INV_DX
					p2 := min(max(int(c0_2), 0), N_G-2)
					c1_2 := float64(p2) + 1.0 - c0_2
					c2_2 := c0_2 - float64(p2)
					ex2 := c1_2*sim.Efield[p2] + c2_2*sim.Efield[p2+1]

					// 4. Cząstka 3
					c0_3 := sim.X_i[k+3] * INV_DX
					p3 := min(max(int(c0_3), 0), N_G-2)
					c1_3 := float64(p3) + 1.0 - c0_3
					c2_3 := c0_3 - float64(p3)
					ex3 := c1_3*sim.Efield[p3] + c2_3*sim.Efield[p3+1]

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

				// Pętla resztkowa dla pozostałych cząstek
				for ; k < e; k++ {
					c0 := sim.X_i[k] * INV_DX
					p := min(max(int(c0), 0), N_G-2)
					c1 := float64(p) + 1.0 - c0
					c2 := c0 - float64(p)
					ex := c1*sim.Efield[p] + c2*sim.Efield[p+1]

					sim.Vx_i[k] += ex * FACTOR_I
					sim.X_i[k] += sim.Vx_i[k] * DT_I
				}
			}
		})
	}

	// Bariera synchronizacyjna jonów
	wg.Wait()

	// Redukcja diagnostyk jonowych do macierzy XT
	if sim.Measurement_mode {
		for w := range numWorkers {
			for p := range N_G {
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
				sim.Ui_xt[p][t_index] += sim.WorkerIDiag[w].ui[p]
				sim.Meanei_xt[p][t_index] += sim.WorkerIDiag[w].meanei[p]
			}
		}
	}
}

/*
KROK 5: Sprawdzanie granic dla elektronów (Dwufazowe: Równoległe oznaczanie + Seryjna kompaktacja).
Etapy:
 1. Faza 1 (Równoległa): Podział N_e na chunki, oznaczanie cząstek w tablicy AbsorbedE[] i zliczanie absorpcji.
 2. Redukcja liczników absorpcji na elektrodzie zasilanej i uziemionej.
 3. Faza 2 (Seryjna): Kompaktacja tablic SoA in-place metodą swap-with-last.
*/
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
	numWorkers := sim.NumWorkers
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
	var wg sync.WaitGroup

	// FAZA 1 (Równoległa): Każda goroutine skanuje swój chunk elektronów i oznacza
	// cząstki poza domeną w tablicy flag AbsorbedE[] (1 = zasilana, 2 = uziemiona).
	for w := range numWorkers {
		start := w * chunkSize
		end := min((w+1)*chunkSize, sim.N_e)
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

	// Bariera synchronizacyjna: wszystkie flagi absorpcji muszą być zapisane przed kompaktacją
	wg.Wait()

	// Redukcja liczników absorpcji elektronów
	for w := range numWorkers {
		sim.N_e_abs_pow += sim.WorkerEDiag[w].abs_pow
		sim.N_e_abs_gnd += sim.WorkerEDiag[w].abs_gnd
	}

	// FAZA 2 (Sekwencyjna): Kompaktacja tablic elektronów in-place (swap-with-last).
	// Wykonywana jednowątkowo, ponieważ in-place nadpisuje skrajne elementy tablic SoA
	// i dekrementuje N_e bez konieczności kosztownej reallokacji pamięci.
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
 2. Faza 1 (Równoległa): Oznaczanie jonów poza domeną i próbkowanie histogramu energii uderzenia IFED.
 3. Redukcja liczników absorpcji oraz histogramów IFED do tablicy globalnej.
 4. Faza 2 (Seryjna): Kompaktacja tablicy jonów swap-with-last.

@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	numWorkers := sim.NumWorkers
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
	var wg sync.WaitGroup

	// FAZA 1 (Równoległa): Oznaczanie jonów i próbkowanie histogramu IFED w chunkach
	for w := range numWorkers {
		start := w * chunkSize
		end := min((w+1)*chunkSize, sim.N_i)
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

			var v_sqr float64
			var energy_index int

			for k := s; k < e; k++ {
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
		})
	}

	// Bariera synchronizacyjna
	wg.Wait()

	// Redukcja liczników absorpcji oraz histogramów IFED
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
KROK 9: Zbieranie chwilowych danych siatkowych do czasoprzestrzennych macierzy XT.
Kopiuje profile potencjału, pola elektrycznego oraz gęstości elektronów i jonów.
Wykonywane tylko w trybie pomiarowym (Measurement_mode == true).
@param t_index Indeks przedziału czasowego w macierzy XT (t / N_BIN).
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
Wykonanie jednego pełnego cyklu radiowej częstotliwości RF (N_T = 4000 kroków czasowych).
Główny silnik iteracyjny symulacji PIC/MCC.
Etapy dla każdego z N_T kroków czasowych:
 1. Krok 1a/1b: Obliczenie gęstości elektronów i jonów (CIC).
 2. Krok 2: Rozwiązanie równania Poissona i wyznaczenie pola E.
 3. Krok 3/4: Popychanie elektronów i jonów schematem Leap-Frog.
 4. Krok 5/6: Sprawdzanie granic i kompaktacja tablic cząstek.
 5. Krok 7/8: Zderzenia elektronów i jonów metodą MCC.
 6. Krok 9: Rejestracja diagnostyk XT.
 7. Zapis zbieżności do pliku conv.dat.
*/
func (sim *SimulationState) DoOneCycle() {
	var t int
	var t_index int

	for t = range N_T { // Okres RF jest dzielony na N_T jednakowych przedziałów czasowych DT_E
		sim.Time += DT_E    // Aktualizacja fizycznego czasu symulacji
		t_index = t / N_BIN // Indeks dla rozkładów czasoprzestrzennych XT

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
Funkcja pomocnicza: Wyznacza minimum z dwóch liczb całkowitych.
@param a Pierwsza liczba całkowita.
@param b Druga liczba całkowita.
@return Mniejsza z liczb a i b.
*/
func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}
