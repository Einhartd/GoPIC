package main

import (
	"encoding/binary"
	"fmt"
	"os"
	"strconv"
	"strings"
	"unsafe"

	"gopic"
)

type mt19937Shadow struct {
	State []uint64
	Index int
}

/*
Punkt wejściowy programu testów regresyjnych GoPIC w wariancie Channels (bit-perfect regression runner).
Obsługuje serializację i deserializację pełnego stanu generatora Mersenne Twister (rng_state.bin)
w celu zapewnienia 100% determinizmu i zgodności bitowej z referencyjną implementacją C++.
@param os.Args[1] Liczba cykli (0 dla cyklu inicjalizacyjnego).
@param os.Args[2] Opcjonalna flaga "m" dla trybu pomiarowego.
*/
func main() {
	SEED := 67

	fmt.Println(">> GoPIC_reg: Starting regression runner...")
	fmt.Println(">> GoPIC_reg: **************************************************************************")
	fmt.Println(">> GoPIC_reg: Running with bit-perfect RNG state tracking for regression testing.")
	fmt.Println(">> GoPIC_reg: **************************************************************************")

	if len(os.Args) == 1 {
		fmt.Println(">> GoPIC_reg: error = need starting_cycle argument")
		os.Exit(1)
	}

	st0 := os.Args[1]
	arg1, _ := strconv.Atoi(strings.TrimSpace(st0))

	measurement_mode := false
	if len(os.Args) > 2 {
		if strings.TrimSpace(os.Args[2]) == "m" {
			measurement_mode = true
		}
	}

	if measurement_mode {
		fmt.Println(">> GoPIC_reg: measurement mode: on")
	} else {
		fmt.Println(">> GoPIC_reg: measurement mode: off")
	}

	// Inicjalizacja stanu symulacji (ziarno 67 - zgodne z C++)
	sim := gopic.NewSimulationState(int64(SEED))
	defer sim.StopWorkers()
	sim.Measurement_mode = measurement_mode
	sim.Arg1 = arg1

	sim.SetElectronCrossSectionsAr()
	sim.SetIonCrossSectionsAr()
	sim.CalcTotalCrossSections()
	sim.InitNullCollision()

	sim.Datafile = openAppend("conv.dat")
	defer sim.Datafile.Close()

	if sim.Arg1 == 0 {
		// === INICJALIZACJA ===
		if fileExists("picdata.bin") {
			fmt.Println(">> GoPIC_reg: Warning: Data from previous calculation are detected. Deleting old files...")
			os.Remove("picdata.bin")
			os.Remove("rng_state.bin")
		}
		sim.No_of_cycles = 1
		sim.Cycle = 1

		sim.InitParticles(gopic.N_INIT)
		fmt.Println(">> GoPIC_reg: running initializing cycle")
		sim.Time = 0
		sim.DoOneCycle()
		sim.Cycles_done = 1
		sim.SaveParticleData()

		saveRNGState(sim) // Zapisujemy dokładny stan RNG
	} else {
		// === KONTYNUACJA ===
		sim.No_of_cycles = sim.Arg1
		sim.LoadParticleData()
		loadRNGState(sim) // Odczytujemy dokładny stan RNG

		fmt.Printf(">> GoPIC_reg: running %d cycle(s)\n", sim.No_of_cycles)
		for sim.Cycle = sim.Cycles_done + 1; sim.Cycle <= sim.Cycles_done+sim.No_of_cycles; sim.Cycle++ {
			sim.DoOneCycle()
		}
		sim.Cycles_done += sim.No_of_cycles
		sim.SaveParticleData()

		saveRNGState(sim) // Zapisujemy stan RNG dla kolejnych kroków
	}

	if sim.Measurement_mode {
		sim.CheckAndSaveInfo()
	}

	fmt.Printf(">> GoPIC_reg: simulation of %d cycle(s) is completed.\n", sim.No_of_cycles)
}

/*
Zapis pełnego stanu wewnętrznego generatora MT19937 do binarnego pliku rng_state.bin.
@param sim Wskaźnik do stanu symulacji zawierającego instancję MT19937.
*/
func saveRNGState(sim *gopic.SimulationState) {
	f, err := os.Create("rng_state.bin")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	shadow := (*mt19937Shadow)(unsafe.Pointer(sim.MtSrc))

	// Zapis indeksu tablicy stanu
	err = binary.Write(f, binary.LittleEndian, int64(shadow.Index))
	if err != nil {
		panic(err)
	}

	// Zapis 624-elementowej tablicy stanu uint64
	for _, val := range shadow.State {
		err = binary.Write(f, binary.LittleEndian, val)
		if err != nil {
			panic(err)
		}
	}
}

/*
Wczytanie pełnego stanu wewnętrznego generatora MT19937 z pliku rng_state.bin.
@param sim Wskaźnik do stanu symulacji.
*/
func loadRNGState(sim *gopic.SimulationState) {
	f, err := os.Open("rng_state.bin")
	if err != nil {
		fmt.Println(">> GoPIC_reg: ERROR: No RNG state file found.")
		os.Exit(1)
	}
	defer f.Close()

	shadow := (*mt19937Shadow)(unsafe.Pointer(sim.MtSrc))

	var index int64
	err = binary.Read(f, binary.LittleEndian, &index)
	if err != nil {
		panic(err)
	}
	shadow.Index = int(index)

	for i := 0; i < len(shadow.State); i++ {
		var val uint64
		err = binary.Read(f, binary.LittleEndian, &val)
		if err != nil {
			panic(err)
		}
		shadow.State[i] = val
	}
}

/*
Funkcja pomocnicza: Otwarcie pliku w trybie dopisywania (Append).
@param name Ścieżka do pliku.
@return Wskaźnik do otwartego pliku os.File.
*/
func openAppend(name string) *os.File {
	f, err := os.OpenFile(name, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		panic(err)
	}
	return f
}

/*
Funkcja pomocnicza: Sprawdzenie, czy plik o podanej nazwie istnieje na dysku.
@param name Ścieżka do pliku.
@return True, jeśli plik istnieje, w przeciwnym razie false.
*/
func fileExists(name string) bool {
	_, err := os.Stat(name)
	return err == nil
}
