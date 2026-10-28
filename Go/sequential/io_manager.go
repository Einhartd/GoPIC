package gopic

import (
	"bufio"
	"encoding/binary"
	"fmt"
	"math"
	"os"
)

// SaveParticleData zapisuje pełny stan symulacji (czas fizyczny, liczbę ukończonych cykli oraz
// pozycje i prędkości wszystkich elektronów i jonów) do pliku binarnego picdata.bin.
func (sim *SimulationState) SaveParticleData() {
	f, err := os.Create("picdata.bin")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	buf := bufio.NewWriter(f)
	defer buf.Flush()

	writeFloat64(buf, sim.Time)
	writeFloat64(buf, float64(sim.Cycles_done))
	writeFloat64(buf, float64(sim.N_e))
	writeFloat64Slice(buf, sim.X_e[:sim.N_e])
	writeFloat64Slice(buf, sim.Vx_e[:sim.N_e])
	writeFloat64Slice(buf, sim.Vy_e[:sim.N_e])
	writeFloat64Slice(buf, sim.Vz_e[:sim.N_e])
	writeFloat64(buf, float64(sim.N_i))
	writeFloat64Slice(buf, sim.X_i[:sim.N_i])
	writeFloat64Slice(buf, sim.Vx_i[:sim.N_i])
	writeFloat64Slice(buf, sim.Vy_i[:sim.N_i])
	writeFloat64Slice(buf, sim.Vz_i[:sim.N_i])

	fmt.Printf(">> gopic: data saved : %d electrons %d ions, %d cycles completed, time is %e [s]\n", sim.N_e, sim.N_i, sim.Cycles_done, sim.Time)
}

// LoadParticleData wczytuje stan symulacji z pliku binarnego picdata.bin (czas fizyczny,
// liczbę przebytych cykli oraz tablice położeń i prędkości elektronów i jonów).
// W przypadku braku pliku kończy program komunikatem informacyjnym.
func (sim *SimulationState) LoadParticleData() {
	f, err := os.Open("picdata.bin")
	if err != nil {
		fmt.Println(">> gopic: ERROR: No particle data file found, try running initial cycle using argument '0'")
		os.Exit(0)
	}
	defer f.Close()

	buf := bufio.NewReader(f)
	sim.Time = readFloat64(buf)
	sim.Cycles_done = int(readFloat64(buf))
	sim.N_e = int(readFloat64(buf))
	readFloat64Slice(buf, sim.X_e[:sim.N_e])
	readFloat64Slice(buf, sim.Vx_e[:sim.N_e])
	readFloat64Slice(buf, sim.Vy_e[:sim.N_e])
	readFloat64Slice(buf, sim.Vz_e[:sim.N_e])
	sim.N_i = int(readFloat64(buf))
	readFloat64Slice(buf, sim.X_i[:sim.N_i])
	readFloat64Slice(buf, sim.Vx_i[:sim.N_i])
	readFloat64Slice(buf, sim.Vy_i[:sim.N_i])
	readFloat64Slice(buf, sim.Vz_i[:sim.N_i])

	fmt.Printf(">> gopic: data loaded : %d electrons %d ions, %d cycles completed before, time is %e [s]\n", sim.N_e, sim.N_i, sim.Cycles_done, sim.Time)
}

// SaveDensity zapisuje uśrednione w czasie profile przestrzenne gęstości elektronów i jonów do pliku density.dat.
// Kolumny wyjściowe: położenie x [m], średnia gęstość elektronów [m^-3], średnia gęstość jonów [m^-3].
func (sim *SimulationState) SaveDensity() {
	f, err := os.Create("density.dat")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	c := 1.0 / float64(sim.No_of_cycles) / float64(N_T)
	for m := 0; m < N_G; m++ {
		fmt.Fprintf(f, "%8.5f  %12e  %12e\n", float64(m)*DX, sim.Cumul_e_density[m]*c, sim.Cumul_i_density[m]*c)
	}
}

// SaveEEPF unormowuje i zapisuje funkcję rozkładu prawdopodobieństwa energii elektronów (EEPF) do pliku eepf.dat.
// Kolumny wyjściowe: energia kinetyczna E [eV], wartość f_EEPF(E) = f_EEDF(E) / sqrt(E) [eV^(-3/2)].
func (sim *SimulationState) SaveEEPF() {
	h := 0.0
	for i := 0; i < N_EEPF; i++ {
		h += sim.Eepf[i]
	}
	h *= DE_EEPF
	f, err := os.Create("eepf.dat")
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < N_EEPF; i++ {
		energy := (float64(i) + 0.5) * DE_EEPF
		fmt.Fprintf(f, "%e  %e\n", energy, sim.Eepf[i]/h/math.Sqrt(energy))
	}
}

// SaveIFED zapisuje unormowane rozkłady energetyczne strumienia jonów (IFED) na obu elektrodach
// do pliku ifed.dat oraz wyznacza średnią energię jonów uderzających w elektrodę zasilaną i uziemioną.
func (sim *SimulationState) SaveIFED() {
	h_pow := 0.0
	h_gnd := 0.0
	for i := 0; i < N_IFED; i++ {
		h_pow += float64(sim.Ifed_pow[i])
		h_gnd += float64(sim.Ifed_gnd[i])
	}
	h_pow *= DE_IFED
	h_gnd *= DE_IFED
	sim.Mean_i_energy_pow = 0.0
	sim.Mean_i_energy_gnd = 0.0
	f, err := os.Create("ifed.dat")
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < N_IFED; i++ {
		energy := (float64(i) + 0.5) * DE_IFED
		fmt.Fprintf(f, "%6.2f %10.6f %10.6f\n", energy, float64(sim.Ifed_pow[i])/h_pow, float64(sim.Ifed_gnd[i])/h_gnd)
		sim.Mean_i_energy_pow += energy * float64(sim.Ifed_pow[i]) / h_pow
		sim.Mean_i_energy_gnd += energy * float64(sim.Ifed_gnd[i]) / h_gnd
	}
}

// SaveXT1 zapisuje pojedynczą dwuwymiarową macierz rozkładu czasoprzestrzennego (N_G x N_XT) do pliku tekstowego.
//
// Parametry:
//   - distr: macierz rozkładu czasoprzestrzennego do zapisania.
//   - fname: ścieżka lub nazwa pliku wyjściowego.
func (sim *SimulationState) SaveXT1(distr XtDistr, fname string) {
	f, err := os.Create(fname)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < N_G; i++ {
		for j := 0; j < N_XT; j++ {
			fmt.Fprintf(f, "%e  ", distr[i][j])
		}
		fmt.Fprint(f, "\n")
	}
}

// NormAllXT przeprowadza normalizację wszystkich zgromadzonych rozkładów czasoprzestrzennych XT
// po zakończeniu pomiaru oraz wyznacza gęstości prądów j_e, j_i i gęstości mocy pochłanianej p_e, p_i.
func (sim *SimulationState) NormAllXT() {
	var f1, f2 float64

	f1 = float64(N_XT) / float64(sim.No_of_cycles*N_T)
	f2 = WEIGHT / (ELECTRODE_AREA * DX) / (float64(sim.No_of_cycles) * (PERIOD / float64(N_XT)))

	for i := 0; i < N_G; i++ {
		for j := 0; j < N_XT; j++ {
			sim.Pot_xt[i][j] *= f1
			sim.Efield_xt[i][j] *= f1
			sim.Ne_xt[i][j] *= f1
			sim.Ni_xt[i][j] *= f1
			if sim.Counter_e_xt[i][j] > 0 {
				sim.Ue_xt[i][j] = sim.Ue_xt[i][j] / sim.Counter_e_xt[i][j]
				sim.Je_xt[i][j] = -sim.Ue_xt[i][j] * sim.Ne_xt[i][j] * E_CHARGE
				sim.Meanee_xt[i][j] = sim.Meanee_xt[i][j] / sim.Counter_e_xt[i][j]
				sim.Ioniz_rate_xt[i][j] *= f2
			} else {
				sim.Ue_xt[i][j] = 0.0
				sim.Je_xt[i][j] = 0.0
				sim.Meanee_xt[i][j] = 0.0
				sim.Ioniz_rate_xt[i][j] = 0.0
			}
			if sim.Counter_i_xt[i][j] > 0 {
				sim.Ui_xt[i][j] = sim.Ui_xt[i][j] / sim.Counter_i_xt[i][j]
				sim.Ji_xt[i][j] = sim.Ui_xt[i][j] * sim.Ni_xt[i][j] * E_CHARGE
				sim.Meanei_xt[i][j] = sim.Meanei_xt[i][j] / sim.Counter_i_xt[i][j]
			} else {
				sim.Ui_xt[i][j] = 0.0
				sim.Ji_xt[i][j] = 0.0
				sim.Meanei_xt[i][j] = 0.0
			}
			sim.Powere_xt[i][j] = sim.Je_xt[i][j] * sim.Efield_xt[i][j]
			sim.Poweri_xt[i][j] = sim.Ji_xt[i][j] * sim.Efield_xt[i][j]
		}
	}
}

// SaveAllXT zapisuje wszystkie 11 znormalizowanych macierzy czasoprzestrzennych XT do odpowiednich plików *.dat.
func (sim *SimulationState) SaveAllXT() {
	sim.SaveXT1(sim.Pot_xt, "pot_xt.dat")
	sim.SaveXT1(sim.Efield_xt, "efield_xt.dat")
	sim.SaveXT1(sim.Ne_xt, "ne_xt.dat")
	sim.SaveXT1(sim.Ni_xt, "ni_xt.dat")
	sim.SaveXT1(sim.Je_xt, "je_xt.dat")
	sim.SaveXT1(sim.Ji_xt, "ji_xt.dat")
	sim.SaveXT1(sim.Powere_xt, "powere_xt.dat")
	sim.SaveXT1(sim.Poweri_xt, "poweri_xt.dat")
	sim.SaveXT1(sim.Meanee_xt, "meanee_xt.dat")
	sim.SaveXT1(sim.Meanei_xt, "meanei_xt.dat")
	sim.SaveXT1(sim.Ioniz_rate_xt, "ioniz_xt.dat")
}

// CheckAndSaveInfo weryfikuje warunki stabilności i dokładności metody PIC/MCC (częstość plazmowa,
// długość Debye'a, częstości zderzeń oraz warunek CFL) i generuje raport podsumowujący w pliku info.txt.
// Jeśli warunki stabilności są spełnione, wywołuje zapis wszystkich plików diagnostycznych.
func (sim *SimulationState) CheckAndSaveInfo() {
	var plas_freq, meane, kT, debye_length, density, ecoll_freq, icoll_freq, sim_time, e_max, v_max, power_e, power_i, c float64
	var conditions_OK bool

	// Obliczenie parametrów plazmy w centrum wyładowania
	density = sim.Cumul_e_density[N_G/2] / float64(sim.No_of_cycles) / float64(N_T)
	plas_freq = E_CHARGE * math.Sqrt(density/EPSILON0/E_MASS)
	meane = sim.Mean_energy_accu_center / float64(sim.Mean_energy_counter_center)
	kT = 2.0 * meane * EV_TO_J / 3.0
	sim_time = float64(sim.No_of_cycles) / FREQUENCY
	ecoll_freq = float64(sim.N_e_coll) / sim_time / float64(sim.N_e)
	icoll_freq = float64(sim.N_i_coll) / sim_time / float64(sim.N_i)
	debye_length = math.Sqrt(EPSILON0*kT/density) / E_CHARGE

	f, err := os.Create("info.txt")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	fmt.Fprintln(f, "########################## gopic simulation report ############################")
	fmt.Fprintln(f, "Simulation parameters:")
	fmt.Fprintf(f, "Gap distance                          = %12.3e [m]\n", L)
	fmt.Fprintf(f, "# of grid divisions                   = %12d\n", N_G)
	fmt.Fprintf(f, "Frequency                             = %12.3e [Hz]\n", FREQUENCY)
	fmt.Fprintf(f, "# of time steps / period              = %12d\n", N_T)
	fmt.Fprintf(f, "# of electron / ion time steps        = %12d\n", N_SUB)
	fmt.Fprintf(f, "Voltage amplitude                     = %12.3e [V]\n", VOLTAGE)
	fmt.Fprintf(f, "Pressure (Ar)                         = %12.3e [Pa]\n", PRESSURE)
	fmt.Fprintf(f, "Temperature                           = %12.3e [K]\n", TEMPERATURE)
	fmt.Fprintf(f, "Superparticle weight                  = %12.3e\n", WEIGHT)
	fmt.Fprintf(f, "# of simulation cycles in this run    = %12d\n", sim.No_of_cycles)
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")
	fmt.Fprintln(f, "Plasma characteristics:")
	fmt.Fprintf(f, "Electron density @ center             = %12.3e [m^{-3}]\n", density)
	fmt.Fprintf(f, "Plasma frequency @ center             = %12.3e [rad/s]\n", plas_freq)
	fmt.Fprintf(f, "Debye length @ center                 = %12.3e [m]\n", debye_length)
	fmt.Fprintf(f, "Electron collision frequency          = %12.3e [1/s]\n", ecoll_freq)
	fmt.Fprintf(f, "Ion collision frequency               = %12.3e [1/s]\n", icoll_freq)
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")
	fmt.Fprintln(f, "Stability and accuracy conditions:")
	conditions_OK = true
	c = plas_freq * DT_E
	fmt.Fprintf(f, "Plasma frequency @ center * DT_E      = %12.3f (OK if less than 0.20)\n", c)
	if c > 0.2 {
		conditions_OK = false
	}
	c = DX / debye_length
	fmt.Fprintf(f, "DX / Debye length @ center            = %12.3f (OK if less than 1.00)\n", c)
	if c > 1.0 {
		conditions_OK = false
	}
	c = sim.MaxElectronCollFreq() * DT_E
	fmt.Fprintf(f, "Max. electron coll. frequency * DT_E  = %12.3f (OK if less than 0.05)\n", c)
	if c > 0.05 {
		conditions_OK = false
	}
	c = sim.MaxIonCollFreq() * DT_I
	fmt.Fprintf(f, "Max. ion coll. frequency * DT_I       = %12.3f (OK if less than 0.05)\n", c)
	if c > 0.05 {
		conditions_OK = false
	}
	if !conditions_OK {
		fmt.Fprintln(f, "--------------------------------------------------------------------------------")
		fmt.Fprintln(f, "** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **")
		fmt.Fprintln(f, "--------------------------------------------------------------------------------")
		fmt.Println(">> gopic: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!")
		fmt.Println(">> gopic: for details see 'info.txt' and refine simulation settings!")
		return
	}

	// Obliczenie maksymalnej energii elektronu spełniającej warunek Couranta-Friedrichsa-Lewy'ego (CFL)
	v_max = DX / DT_E
	e_max = 0.5 * E_MASS * v_max * v_max / EV_TO_J
	fmt.Fprintf(f, "Max e- energy for CFL condition       = %12.3f [eV]\n", e_max)
	fmt.Fprintln(f, "Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!")
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")

	// Zapis wszystkich plików diagnostycznych oraz normalizacja rozkładów
	fmt.Println(">> gopic: saving diagnostics data")
	sim.SaveDensity()
	sim.SaveEEPF()
	sim.SaveIFED()
	sim.NormAllXT()
	sim.SaveAllXT()
	fmt.Fprintln(f, "Particle characteristics at the electrodes:")
	fmt.Fprintf(f, "Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", float64(sim.N_i_abs_pow)*WEIGHT/ELECTRODE_AREA/(float64(sim.No_of_cycles)*PERIOD))
	fmt.Fprintf(f, "Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", float64(sim.N_i_abs_gnd)*WEIGHT/ELECTRODE_AREA/(float64(sim.No_of_cycles)*PERIOD))
	fmt.Fprintf(f, "Mean ion energy at powered electrode  = %12.3e [eV]\n", sim.Mean_i_energy_pow)
	fmt.Fprintf(f, "Mean ion energy at grounded electrode = %12.3e [eV]\n", sim.Mean_i_energy_gnd)
	fmt.Fprintf(f, "Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", float64(sim.N_e_abs_pow)*WEIGHT/ELECTRODE_AREA/(float64(sim.No_of_cycles)*PERIOD))
	fmt.Fprintf(f, "Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", float64(sim.N_e_abs_gnd)*WEIGHT/ELECTRODE_AREA/(float64(sim.No_of_cycles)*PERIOD))
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")

	// Obliczenie uśrednionej w przestrzeni i czasie mocy pochłanianej <j * E>
	power_e = 0.0
	power_i = 0.0
	for i := 0; i < N_G; i++ {
		for j := 0; j < N_XT; j++ {
			power_e += sim.Powere_xt[i][j]
			power_i += sim.Poweri_xt[i][j]
		}
	}
	power_e /= float64(N_XT * N_G)
	power_i /= float64(N_XT * N_G)
	fmt.Fprintln(f, "Absorbed power calculated as <j*E>:")
	fmt.Fprintf(f, "Electron power density (average)      = %12.3e [W m^{-3}]\n", power_e)
	fmt.Fprintf(f, "Ion power density (average)           = %12.3e [W m^{-3}]\n", power_i)
	fmt.Fprintf(f, "Total power density(average)          = %12.3e [W m^{-3}]\n", power_e+power_i)
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")
}

// readFloat64Slice wczytuje ciąg wartości float64 z buforowanego strumienia binarnego do wycinka v.
//
// Parametry:
//   - r: buforowany czytnik strumienia wejściowego.
//   - v: docelowy wycinek wypełniany odczytanymi wartościami.
func readFloat64Slice(r *bufio.Reader, v []float64) {
	for i := range v {
		v[i] = readFloat64(r)
	}
}

// readFloat64 wczytuje pojedynczą 64-bitową liczbę zmiennoprzecinkową w formacie little-endian.
//
// Parametry:
//   - r: buforowany czytnik strumienia wejściowego.
//
// Zwraca:
//   - odczytana wartość typu float64.
func readFloat64(r *bufio.Reader) float64 {
	var v float64
	if err := binary.Read(r, binary.LittleEndian, &v); err != nil {
		panic(err)
	}
	return v
}

// writeFloat64Slice zapisuje wszystkie elementy wycinka float64 do buforowanego strumienia binarnego.
//
// Parametry:
//   - w: buforowany pisarz strumienia wyjściowego.
//   - v: wycinek wartości float64 przeznaczonych do zapisu.
func writeFloat64Slice(w *bufio.Writer, v []float64) {
	for _, x := range v {
		writeFloat64(w, x)
	}
}

// writeFloat64 zapisuje pojedynczą 64-bitową liczbę zmiennoprzecinkową w formacie little-endian.
//
// Parametry:
//   - w: buforowany pisarz strumienia wyjściowego.
//   - v: wartość float64 do zapisania.
func writeFloat64(w *bufio.Writer, v float64) {
	if err := binary.Write(w, binary.LittleEndian, v); err != nil {
		panic(err)
	}
}
