package main

import (
	"gopic"
)

/*
Główny punkt wejściowy binarnego programu symulatora GoPIC (Parallel Channels).
Wywołuje funkcję Run() pakietu gopic z obsługą kanałowej dystrybucji zadań.
*/
func main() {
	gopic.Run()
}
