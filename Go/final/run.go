package gopic

import (
	"fmt"
	"os"
	"runtime"
	"strconv"
	"strings"
	"time"
)

// Run stanowi główną funkcję sterującą przebiegiem równoległej symulacji GoPIC.
// Parsuje flagi współbieżności (--workers, --threads) oraz argumenty pozycyjne wiersza poleceń,
// inicjalizuje przekroje czynne, stan symulacji oraz pulę trwałych workerów, wykonuje zadaną
// liczbę cykli RF i zapisuje stan końcowy oraz diagnostyki.
//
// Argumenty wiersza poleceń (os.Args):
//   - --workers=N: opcjonalna liczba równoległych workerów (goroutines).
//   - --threads=M: opcjonalna wartość GOMAXPROCS (liczba wątków systemowych).
//   - arg[0]: liczba cykli RF do wykonania (0 oznacza uruchomienie cyklu inicjalizacyjnego).
//   - arg[1]: opcjonalna flaga "m" włączająca tryb pomiarowy (gromadzenie i zapis diagnostyk).
func Run() {
	fmt.Println(">> GoPIC: starting (optimized)...")

	// Walidacja obecności argumentów wiersza poleceń
	if len(os.Args) == 1 {
		fmt.Println(">> GoPIC: error = need starting_cycle argument")
		os.Exit(1)
	}

	numWorkers := 0
	numThreads := 0
	var positional []string

	// Odczyt flag opcjonalnych (--workers, --threads) oraz argumentów pozycyjnych
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
			measurement_mode = true
		}
	}
	if measurement_mode {
		fmt.Println(">> GoPIC: measurement mode: on")
	} else {
		fmt.Println(">> GoPIC: measurement mode: off")
	}

	fmt.Printf(">> GoPIC: GOMAXPROCS (OS threads) = %d\n", runtime.GOMAXPROCS(0))
	fmt.Printf(">> GoPIC: NumWorkers (goroutines)  = %d\n", numWorkers)

	// Utworzenie stanu symulacji oraz uruchomienie trwałych workerów w tle
	sim := NewSimulationState(time.Now().UnixNano(), numWorkers)
	defer sim.StopWorkers()
	sim.Measurement_mode = measurement_mode
	sim.Arg1 = arg1

	// Inicjalizacja tablic przekrojów czynnych oraz parametrów Null-Collision
	sim.SetElectronCrossSectionsAr()
	sim.SetIonCrossSectionsAr()
	sim.CalcTotalCrossSections()
	sim.InitNullCollision()

	// Otwarcie pliku zbieżności conv.dat w trybie dopisywania
	sim.Datafile = openAppend("conv.dat")
	defer sim.Datafile.Close()

	start_time := time.Now()
	if sim.Arg1 == 0 {
		// Tryb inicjalizacyjny: sprawdzenie, czy nie istnieją już dane z wcześniejszej symulacji
		if fileExists("picdata.bin") {
			fmt.Println(">> GoPIC: Warning: Data from previous calculation are detected.")
			fmt.Println("           To start a new simulation from the beginning, please delete all output files before running ./GoPIC 0")
			fmt.Println("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./GoPIC 100")
			os.Exit(0)
		}
		sim.No_of_cycles = 1
		sim.Cycle = 1
		// Zasianie początkowych makrocząstek i wykonanie pierwszego cyklu RF
		sim.InitParticles(N_INIT)
		fmt.Println(">> GoPIC: running initializing cycle")
		sim.Time = 0
		sim.DoOneCycle()
		sim.Cycles_done = 1
	} else {
		// Tryb kontynuacji: wczytanie stanu z pliku picdata.bin i wykonanie zadanej liczby cykli
		sim.No_of_cycles = sim.Arg1
		sim.LoadParticleData()
		sim.UpdateChunkSizes()
		fmt.Printf(">> GoPIC: running %d cycle(s)\n", sim.No_of_cycles)
		for sim.Cycle = sim.Cycles_done + 1; sim.Cycle <= sim.Cycles_done+sim.No_of_cycles; sim.Cycle++ {
			sim.DoOneCycle()
		}
		sim.Cycles_done += sim.No_of_cycles
	}

	// Zapis stanu końcowego cząstek oraz opcjonalny zapis pełnej diagnostyki
	sim.SaveParticleData()
	if sim.Measurement_mode {
		sim.CheckAndSaveInfo()
	}
	fmt.Printf(">> GoPIC: simulation of %d cycle(s) is completed.\n", sim.No_of_cycles)
	elapsed := time.Since(start_time).Seconds()
	fmt.Printf(">> GoPIC: Simulation finished. Total elapsed time: %.3f s\n", elapsed)
}

// atoi usuwa białe znaki z napisu i konwertuje go na liczbę całkowitą.
//
// Parametry:
//   - s: łańcuch znaków reprezentujący liczbę całkowitą.
//
// Zwraca:
//   - skonwertowana wartość typu int.
func atoi(s string) int {
	i, _ := strconv.Atoi(strings.TrimSpace(s))
	return i
}

// openAppend otwiera plik w trybie dopisywania na końcu lub tworzy go, jeśli nie istnieje.
//
// Parametry:
//   - name: ścieżka lub nazwa pliku do otwarcia.
//
// Zwraca:
//   - wskaźnik do otwartego deskryptora pliku os.File.
func openAppend(name string) *os.File {
	f, err := os.OpenFile(name, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		panic(err)
	}
	return f
}

// fileExists sprawdza, czy plik o podanej nazwie istnieje w systemie plików.
//
// Parametry:
//   - name: ścieżka lub nazwa sprawdzanego pliku.
//
// Zwraca:
//   - true, jeśli plik istnieje; false w przeciwnym przypadku.
func fileExists(name string) bool {
	_, err := os.Stat(name)
	return err == nil
}
