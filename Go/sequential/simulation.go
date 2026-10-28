package gopic

import (
	"fmt"
	"math"
)

// InitParticles inicjalizuje populację początkową elektronów i jonów w obszarze wyładowczym,
// rozmieszczając zadaną liczbę par makrocząstek jednorodnie w przestrzeni [0, L]
// z zerowymi prędkościami początkowymi.
//
// Parametry:
//   - nseed: liczba par elektron-jon tworzonych na starcie symulacji.
func (sim *SimulationState) InitParticles(nseed int) {
	for i := 0; i < nseed; i++ {
		// Losowanie początkowej pozycji elektronu i wyzerowanie składowych prędkości 3V
		sim.X_e[i] = L * sim.R01()
		sim.Vx_e[i] = 0
		sim.Vy_e[i] = 0
		sim.Vz_e[i] = 0
		// Losowanie początkowej pozycji jonu i wyzerowanie składowych prędkości 3V
		sim.X_i[i] = L * sim.R01()
		sim.Vx_i[i] = 0
		sim.Vy_i[i] = 0
		sim.Vz_i[i] = 0
	}
	sim.N_e = nseed
	sim.N_i = nseed
}

// Step1ComputeElectronDensity wykonuje depozycję gęstości ładunku elektronów na siatkę
// metodą liniowego ważenia Cloud-in-Cell (CIC) w każdym kroku czasowym oraz aktualizuje
// tablicę skumulowanej gęstości Cumul_e_density.
func (sim *SimulationState) Step1ComputeElectronDensity() {
	var k, p int
	var c0 float64

	// Wyzerowanie chwilowej gęstości elektronów przed depozycją
	for p = 0; p < N_G; p++ {
		sim.E_density[p] = 0
	}
	// Liniowa interpolacja ładunku każdego elektronu do dwóch sąsiednich węzłów siatki
	for k = 0; k < sim.N_e; k++ {
		c0 = sim.X_e[k] * INV_DX
		p = int(c0)
		sim.E_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
		sim.E_density[p+1] += (c0 - float64(p)) * FACTOR_W
	}
	// Korekta objętości połowicznych komórek brzegowych na elektrodach (mnożnik 2.0)
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p = 0; p < N_G; p++ {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

// Step1ComputeIonDensity wykonuje depozycję gęstości ładunku jonów na siatkę metodą CIC
// co N_SUB kroków czasowych (subcycling) oraz w każdym kroku akumuluje Cumul_i_density.
//
// Parametry:
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	var k, p int
	var c0 float64

	// Obliczenie nowej gęstości jonów wykonywane co N_SUB kroków czasowych
	if (t % N_SUB) == 0 {
		for p = 0; p < N_G; p++ {
			sim.I_density[p] = 0
		}
		for k = 0; k < sim.N_i; k++ {
			c0 = sim.X_i[k] * INV_DX
			p = int(c0)
			sim.I_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
			sim.I_density[p+1] += (c0 - float64(p)) * FACTOR_W
		}
		sim.I_density[0] *= 2.0
		sim.I_density[N_G-1] *= 2.0
	}
	for p = 0; p < N_G; p++ {
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

// Step3MoveElectrons przesuwa wszystkie elektrony w polu elektrycznym zgodnie ze schematem
// całkowania Leap-Frog oraz (w trybie pomiarowym) gromadzi rozkłady czasoprzestrzenne XT i EEPF.
//
// Parametry:
//   - t_index: indeks przedziału czasowego dla macierzy diagnostyk XT (t / N_BIN).
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
	var k, p, energy_index int
	var c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate float64

	for k = 0; k < sim.N_e; k++ {
		// Interpolacja natężenia pola elektrycznego z węzłów siatki do położenia elektronu
		c0 = sim.X_e[k] * INV_DX
		p = int(c0)
		c1 = float64(p) + 1.0 - c0
		c2 = c0 - float64(p)
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

		if sim.Measurement_mode {
			// Wyznaczenie prędkości w chwili całkowitej t na potrzeby diagnostyki
			mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
			sim.Counter_e_xt[p][t_index] += c1
			sim.Counter_e_xt[p+1][t_index] += c2
			sim.Ue_xt[p][t_index] += c1 * mean_v
			sim.Ue_xt[p+1][t_index] += c2 * mean_v
			v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
			energy = 0.5 * E_MASS * v_sqr / EV_TO_J
			sim.Meanee_xt[p][t_index] += c1 * energy
			sim.Meanee_xt[p+1][t_index] += c2 * energy
			energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
			velocity = math.Sqrt(v_sqr)
			rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
			sim.Ioniz_rate_xt[p][t_index] += c1 * rate
			sim.Ioniz_rate_xt[p+1][t_index] += c2 * rate

			// Zliczanie histogramu EEPF w centralnym obszarze wyładowania (MIN_X < x < MAX_X)
			if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
				energy_index = int(energy / DE_EEPF)
				if energy_index < N_EEPF {
					sim.Eepf[energy_index] += 1.0
				}
				sim.Mean_energy_accu_center += energy
				sim.Mean_energy_counter_center++
			}
		}

		// Aktualizacja prędkości i położenia elektronu w schemacie Leap-Frog
		sim.Vx_e[k] -= e_x * FACTOR_E
		sim.X_e[k] += sim.Vx_e[k] * DT_E
	}
}

// Step4MoveIons przesuwa wszystkie jony w polu elektrycznym co N_SUB kroków czasowych (subcycling)
// oraz (w trybie pomiarowym) gromadzi rozkłady prędkości i energii jonów w macierzach XT.
//
// Parametry:
//   - t_index: indeks przedziału czasowego dla macierzy diagnostyk XT (t / N_BIN).
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, p int
	var c0, c1, c2, e_x, mean_v, v_sqr, energy float64

	for k = 0; k < sim.N_i; k++ {
		c0 = sim.X_i[k] * INV_DX
		p = int(c0)
		c1 = float64(p) + 1.0 - c0
		c2 = c0 - float64(p)
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

		if sim.Measurement_mode {
			// Wyznaczenie prędkości jonu w chwili całkowitej t na potrzeby diagnostyki
			mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
			sim.Counter_i_xt[p][t_index] += c1
			sim.Counter_i_xt[p+1][t_index] += c2
			sim.Ui_xt[p][t_index] += c1 * mean_v
			sim.Ui_xt[p+1][t_index] += c2 * mean_v
			v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			sim.Meanei_xt[p][t_index] += c1 * energy
			sim.Meanei_xt[p+1][t_index] += c2 * energy
		}

		// Aktualizacja prędkości i położenia jonu w kroku subcyclingu DT_I
		sim.Vx_i[k] += e_x * FACTOR_I
		sim.X_i[k] += sim.Vx_i[k] * DT_I
	}
}

// Step5CheckBoundariesElectrons weryfikuje warunki brzegowe dla elektronów w każdym kroku czasowym.
// Elektrony opuszczające obszar wyładowczy (x < 0 lub x > L) są zliczane jako zaabsorbowane
// na odpowiedniej elektrodzie i usuwane z tablic przez nadpisanie ostatnim aktywnym elektronem.
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
	var k int = 0
	var out bool
	for k < sim.N_e {
		out = false
		// Sprawdzenie absorpcji na elektrodzie zasilanej (x < 0) oraz uziemionej (x > L)
		if sim.X_e[k] < 0 {
			sim.N_e_abs_pow++
			out = true
		}
		if sim.X_e[k] > L {
			sim.N_e_abs_gnd++
			out = true
		}
		// Usunięcie zaabsorbowanego elektronu metodą zamiany z ostatnim elementem (swap-with-last)
		if out {
			sim.X_e[k] = sim.X_e[sim.N_e-1]
			sim.Vx_e[k] = sim.Vx_e[sim.N_e-1]
			sim.Vy_e[k] = sim.Vy_e[sim.N_e-1]
			sim.Vz_e[k] = sim.Vz_e[sim.N_e-1]
			sim.N_e--
		} else {
			k++
		}
	}
}

// Step6CheckBoundariesIons weryfikuje warunki brzegowe dla jonów co N_SUB kroków czasowych.
// Jony docierające do elektrod są rejestrowane w histogramach IFED (Ifed_pow, Ifed_gnd)
// oraz usuwane z tablic przez nadpisanie ostatnim aktywnym jonem.
//
// Parametry:
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, energy_index int
	var out bool
	var v_sqr, energy float64

	k = 0
	for k < sim.N_i {
		out = false
		// Absorpcja jonu na elektrodzie zasilanej (x < 0) i aktualizacja rozkładu IFED
		if sim.X_i[k] < 0 {
			sim.N_i_abs_pow++
			out = true
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			energy_index = int(energy / DE_IFED)
			if energy_index < N_IFED {
				sim.Ifed_pow[energy_index]++
			}
		}
		// Absorpcja jonu na elektrodzie uziemionej (x > L) i aktualizacja rozkładu IFED
		if sim.X_i[k] > L {
			sim.N_i_abs_gnd++
			out = true
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			energy_index = int(energy / DE_IFED)
			if energy_index < N_IFED {
				sim.Ifed_gnd[energy_index]++
			}
		}
		// Usunięcie zaabsorbowanego jonu metodą zamiany z ostatnim elementem (swap-with-last)
		if out {
			sim.X_i[k] = sim.X_i[sim.N_i-1]
			sim.Vx_i[k] = sim.Vx_i[sim.N_i-1]
			sim.Vy_i[k] = sim.Vy_i[sim.N_i-1]
			sim.Vz_i[k] = sim.Vz_i[sim.N_i-1]
			sim.N_i--
		} else {
			k++
		}
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

// DoOneCycle wykonuje jeden pełny okres RF symulacji podzielony na N_T kroków czasowych DT_E.
// W każdym kroku realizuje pełny cykl PIC/MCC: depozycję ładunku, rozwiązanie równania Poissona,
// przesunięcie cząstek, obsługę granic, zderzenia Monte Carlo oraz diagnostykę.
func (sim *SimulationState) DoOneCycle() {
	var t int
	var t_index int

	for t = 0; t < N_T; t++ {
		sim.Time += DT_E
		t_index = t / N_BIN

		// Krok 1 i 2: Depozycja ładunku na siatkę oraz rozwiązanie równania Poissona
		sim.Step1ComputeElectronDensity()
		sim.Step1ComputeIonDensity(t)
		sim.Step2SolvePoisson(sim.Time)

		// Krok 3 i 4: Przesunięcie elektronów i jonów w polu elektrycznym
		sim.Step3MoveElectrons(t_index)
		sim.Step4MoveIons(t_index, t)

		// Krok 5 i 6: Sprawdzenie warunków brzegowych (absorpcja na elektrodach)
		sim.Step5CheckBoundariesElectrons()
		sim.Step6CheckBoundariesIons(t)

		// Krok 7 i 8: Zderzenia Monte Carlo (MCC) dla elektronów i jonów
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
