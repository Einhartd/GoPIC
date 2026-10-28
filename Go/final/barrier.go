package gopic

import (
	"sync/atomic"
)

// procyield wykonuje zadaną liczbę niskopoziomowych instrukcji procesora PAUSE na architekturze x86_64,
// redukując zużycie energii i opóźnienia wychodzenia z pętli aktywnego oczekiwania (spin-wait).
//
// Parametry:
//   - cycles: liczba iteracji instrukcji PAUSE do wykonania.
func procyield(cycles uint32)

// paddedInt64 opakowuje 64-bitowy licznik atomowy z 56-bajtowym dopełnieniem (paddingiem)
// do pełnej linii pamięci podręcznej (64 B), eliminując zjawisko False Sharing pomiędzy rdzeniami.
type paddedInt64 struct {
	// Wartość atomowego licznika ukończonego kroku
	val atomic.Int64
	// Dopełnienie do 64 bajtów
	_ [56]byte
}

// StarBarrier implementuje bezblokadową barierę synchronizacyjną w topologii gwiazdy (Star-Topology).
// Zastępuje standardowe kanały Go oraz sync.WaitGroup atomową sygnalizacją w pamięci L1/L2,
// eliminując wywołania systemowe futex oraz narzut planisty goroutines wewnątrz kroków czasowych.
//
// Zasada działania:
//  1. Koordynator zapisuje rozkaz w polu cmd oraz inkrementuje licznik kroku step.
//  2. Koordynator samodzielnie wykonuje pracę dla podzbioru 0, a workery 1 .. numWorkers-1 dla swoich podzbiorów.
//  3. Każdy worker po zakończeniu zadania zapisuje numer kroku do własnej linii cache workerDone[id].
type StarBarrier struct {
	// Całkowita liczba workerów uczestniczących w synchronizacji
	numWorkers int
	// Bieżący rozkaz do wykonania przez zespół workerów
	cmd atomic.Int32
	// Globalny licznik kroków synchronizacji
	step atomic.Int64
	// Tablica wyrównanych do linii cache znaczników ukończenia pracy dla każdego workera
	workerDone []paddedInt64
}

// NewStarBarrier tworzy i inicjalizuje nową strukturę StarBarrier dla zadanej liczby workerów.
//
// Parametry:
//   - numWorkers: liczba workerów synchronizowanych przez barierę.
//
// Zwraca:
//   - wskaźnik do utworzonej bariery StarBarrier.
func NewStarBarrier(numWorkers int) *StarBarrier {
	return &StarBarrier{
		numWorkers: numWorkers,
		workerDone: make([]paddedInt64, numWorkers),
	}
}
