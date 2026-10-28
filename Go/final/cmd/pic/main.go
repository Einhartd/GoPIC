// Package main stanowi punkt wejścia dla pliku wykonywalnego równoległej wersji symulacji GoPIC.
package main

import (
	"gopic"
)

// main uruchamia główną procedurę sterującą równoległą symulacją 1D3V PIC/MCC z pakietu gopic.
func main() {
	gopic.Run()
}
