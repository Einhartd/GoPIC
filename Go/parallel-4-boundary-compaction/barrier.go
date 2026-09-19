package gopic

import (
	"sync/atomic"
)

// procyield wykonuje podaną liczbę instrukcji PAUSE na x86_64
func procyield(cycles uint32)

// paddedInt64 zapobiega fałszywemu współdzieleniu (False Sharing) linii pamięci podręcznej (64B).
type paddedInt64 struct {
	val atomic.Int64
	_   [56]byte
}

/*
StarBarrier reprezentuje bezblokadową barierę synchronizacyjną w topologii gwiazdy (Star-Topology).
Eliminuje konieczność wywołań systemowych SYS_futex oraz blokad kanałów Go (hchan lock).
Każdy worker zapisuje wyłącznie do swojego prywatnego wskaźnika postępu workerDone[id],
wyrównanego do osobnej 64-bajtowej linii pamięci podręcznej L1.

Koordynator (wątek główny):
 1. Ustawia rozkaz 'cmd' oraz inkrementuje krok globalny 'step'.
 2. Samodzielnie wykonuje zadanie workera 0 (eliminując marnowanie rdzenia na bezczynny spin).
 3. Czeka na zakończenie pozostałych workerów (1 .. numWorkers-1) za pomocą niskolatencyjnej pętli PAUSE.
*/
type StarBarrier struct {
	numWorkers int
	cmd        atomic.Int32
	step       atomic.Int64
	workerDone []paddedInt64
}

// NewStarBarrier tworzy nową barierę StarBarrier dla zadanej liczby workerów.
func NewStarBarrier(numWorkers int) *StarBarrier {
	return &StarBarrier{
		numWorkers: numWorkers,
		workerDone: make([]paddedInt64, numWorkers),
	}
}
