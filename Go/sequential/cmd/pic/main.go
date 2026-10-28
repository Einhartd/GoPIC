// Package main stanowi punkt wejścia dla pliku wykonywalnego sekwencyjnej wersji symulacji GoPIC.
package main

import (
	"gopic"
)

// main uruchamia główną procedurę sterującą symulacją 1D3V PIC/MCC z pakietu gopic.
func main() {
	gopic.Run()
}
