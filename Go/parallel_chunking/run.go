package gopic

import (
	"fmt"
	"os"
	"runtime"
	"strconv"
	"strings"
	"time"
)

//------------------------------------------------------------------------------------------//
// Run is the main simulation entry point.
// command line arguments:                                                                  //
// [1]: number of cycles (0 for init)                                                       //
// [2]: "m" turns on data collection and saving                                             //
//------------------------------------------------------------------------------------------//

func Run() {
	fmt.Println(">> GoPIC: starting...")

	if len(os.Args) == 1 {
		fmt.Println(">> GoPIC: error = need starting_cycle argument")
		os.Exit(1)
	}

	// Parsowanie flag: --workers=N i --threads=N mogą pojawić się w dowolnym miejscu args.
	// --workers=N : liczba goroutyn w krokach PIC (niezależna od wątków OS)
	// --threads=N : liczba wątków OS (GOMAXPROCS); domyślnie = GOMAXPROCS systemu
	numWorkers := 0 // 0 = użyj GOMAXPROCS jako domyślne w NewSimulationState
	numThreads := 0 // 0 = nie zmieniaj GOMAXPROCS
	var positional []string

	for _, arg := range os.Args[1:] {
		if strings.HasPrefix(arg, "--workers=") {
			numWorkers, _ = strconv.Atoi(strings.TrimPrefix(arg, "--workers="))
		} else if strings.HasPrefix(arg, "--threads=") {
			numThreads, _ = strconv.Atoi(strings.TrimPrefix(arg, "--threads="))
		} else {
			positional = append(positional, arg)
		}
	}

	if numThreads > 0 {
		runtime.GOMAXPROCS(numThreads)
	}
	// Jeśli --workers nie podano, defaultujemy do aktualnego GOMAXPROCS
	if numWorkers <= 0 {
		numWorkers = runtime.GOMAXPROCS(0)
	}

	if len(positional) == 0 {
		fmt.Println(">> GoPIC: error = need starting_cycle argument")
		os.Exit(1)
	}
	st0 := positional[0]
	arg1 := atoi(st0)

	measurement_mode := false
	if len(positional) > 1 {
		if strings.TrimSpace(positional[1]) == "m" {
			measurement_mode = true // measurements will be done
		}
	}
	if measurement_mode {
		fmt.Println(">> GoPIC: measurement mode: on")
	} else {
		fmt.Println(">> GoPIC: measurement mode: off")
	}

	fmt.Printf(">> GoPIC: GOMAXPROCS (OS threads) = %d\n", runtime.GOMAXPROCS(0))
	fmt.Printf(">> GoPIC: NumWorkers (goroutines)  = %d\n", numWorkers)

	// Inicjalizacja stanu symulacji dynamicznym ziarnem (czas systemowy)
	sim := NewSimulationState(time.Now().UnixNano(), numWorkers)
	sim.Measurement_mode = measurement_mode
	sim.Arg1 = arg1

	sim.SetElectronCrossSectionsAr()
	sim.SetIonCrossSectionsAr()
	sim.CalcTotalCrossSections()
	sim.InitNullCollision()

	sim.Datafile = openAppend("conv.dat")
	defer sim.Datafile.Close()

	if sim.Arg1 == 0 {
		if fileExists("picdata.bin") {
			fmt.Println(">> GoPIC: Warning: Data from previous calculation are detected.")
			fmt.Println("           To start a new simulation from the beginning, please delete all output files before running ./GoPIC 0")
			fmt.Println("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./GoPIC 100")
			os.Exit(0)
		}
		sim.No_of_cycles = 1
		sim.Cycle = 1             // init cycle
		sim.InitParticles(N_INIT) // seed initial electrons & ions
		fmt.Println(">> GoPIC: running initializing cycle")
		sim.Time = 0
		sim.DoOneCycle()
		sim.Cycles_done = 1
	} else {
		sim.No_of_cycles = sim.Arg1 // run number of cycles specified in command line
		sim.LoadParticleData()      // read previous configuration from file
		fmt.Printf(">> GoPIC: running %d cycle(s)\n", sim.No_of_cycles)
		for sim.Cycle = sim.Cycles_done + 1; sim.Cycle <= sim.Cycles_done+sim.No_of_cycles; sim.Cycle++ {
			sim.DoOneCycle()
		}
		sim.Cycles_done += sim.No_of_cycles
	}
	sim.SaveParticleData()
	if sim.Measurement_mode {
		sim.CheckAndSaveInfo()
	}
	fmt.Printf(">> GoPIC: simulation of %d cycle(s) is completed.\n", sim.No_of_cycles)
}

// Takes string, trims whitespaces and casts to int
func atoi(s string) int {
	i, _ := strconv.Atoi(strings.TrimSpace(s))
	return i
}

// Opens file for appending (creates if doesn't exist)
func openAppend(name string) *os.File {
	f, err := os.OpenFile(name, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		panic(err)
	}
	return f
}

// Checks if file exist
func fileExists(name string) bool {
	_, err := os.Stat(name)
	return err == nil
}
