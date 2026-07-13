package main

import (
	"bufio"
	"encoding/binary"
	"fmt"
	"os"
	"strconv"
	"strings"
)

//------------------------------------------------------------------------------------------//
// main                                                                                     //
// command line arguments:                                                                  //
// [1]: number of cycles (0 for init)                                                       //
// [2]: "m" turns on data collection and saving                                             //
//------------------------------------------------------------------------------------------//

func main() {
	fmt.Println(">> GoPIC: starting...")

	if len(os.Args) == 1 {
		fmt.Println(">> GoPIC: error = need starting_cycle argument")
		os.Exit(1)
	}

	st0 = os.Args[1]
	arg1 = atoi(st0)

	if len(os.Args) > 2 {
		if strings.TrimSpace(os.Args[2]) == "m" {
			measurement_mode = true // measurements will be done
		} else {
			measurement_mode = false
		}
	}
	if measurement_mode {
		fmt.Println(">> GoPIC: measurement mode: on")
	} else {
		fmt.Println(">> GoPIC: measurement mode: off")
	}

	setElectronCrossSectionsAr()
	setIonCrossSectionsAr()
	calcTotalCrossSections()
	//testCrossSections(); return

	datafile = openAppend("conv.dat")
	defer datafile.Close()

	if arg1 == 0 {
		if fileExists("picdata.bin") {
			fmt.Println(">> GoPIC: Warning: Data from previous calculation are detected.")
			fmt.Println("           To start a new simulation from the beginning, please delete all output files before running ./GoPIC 0")
			fmt.Println("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./GoPIC 100")
			os.Exit(0)
		}
		no_of_cycles = 1
		cycle = 1             // init cycle
		initParticles(N_INIT) // seed initial electrons & ions
		fmt.Println(">> GoPIC: running initializing cycle")
		Time = 0
		doOneCycle()
		cycles_done = 1
	} else {
		no_of_cycles = arg1 // run number of cycles specified in command line
		loadParticleData()  // read previous configuration from file
		fmt.Printf(">> GoPIC: running %d cycle(s)\n", no_of_cycles)
		for cycle = cycles_done + 1; cycle <= cycles_done+no_of_cycles; cycle++ {
			doOneCycle()
		}
		cycles_done += no_of_cycles
	}
	saveParticleData()
	if measurement_mode {
		checkAndSaveInfo()
	}
	fmt.Printf(">> GoPIC: simulation of %d cycle(s) is completed.\n", no_of_cycles)
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

// save single float64 value to buffer in little-endian format
func writeFloat64(w *bufio.Writer, v float64) {
	if err := binary.Write(w, binary.LittleEndian, v); err != nil {
		panic(err)
	}
}
