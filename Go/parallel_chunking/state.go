package gopic

import (
	"math"
	"math/rand"
	"os"
	"runtime"

	"github.com/seehuhn/mt19937"
)

/*
Prywatne bufory diagnostyczne dla pojedynczego workera (elektrony).
Gromadzi lokalne wartości gęstości, prędkości, energii i EEPF bez konfliktów zapisu.
*/
type electronWorkerDiagnostics struct {
	counter_e     [N_G]float64
	ue            [N_G]float64
	meanee        [N_G]float64
	ioniz         [N_G]float64
	eepf          [N_EEPF]float64
	accuCenter    float64
	counterCenter uint64
	abs_pow       uint64
	abs_gnd       uint64
}

/*
Prywatne bufory diagnostyczne dla pojedynczego workera (jony).
Gromadzi lokalne wartości profilu prędkości, energii i histogramów IFED.
*/
type ionWorkerDiagnostics struct {
	counter_i [N_G]float64
	ui        [N_G]float64
	meanei    [N_G]float64
	abs_pow   uint64
	abs_gnd   uint64
	ifed_pow  [N_IFED]int
	ifed_gnd  [N_IFED]int
}

/*
Reprezentacja pojedynczej nowo utworzonej makrocząstki w układzie AoS (Array of Structures).
Układ AoS dla tymczasowych buforów zderzeń został wybrany ze względu na:
 1. Lokalność przestrzenną: Zapis pozycji i 3 składowych prędkości (32B) mieści się w 1 linii cache L1 (64B).
 2. Efektywność runtime Go: 1 nagłówek wycinka na workera zamiast 4 osobnych alokacji.
 3. Niski koszt scalania: Przepisanie do głównych tablic SoA po zakończeniu pętli cząstek.
*/
type CreatedParticle struct {
	X  float64
	Vx float64
	Vy float64
	Vz float64
}

var (
	// RMB_sigma określa odchylenie standardowe dla rozkładu prędkości Maxwella-Boltzmanna tła atomowego.
	RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)
)

/*
Główny stan symulacji PIC/MCC (1D3V) w implementacji równoległej Go (Chunking).
Przechowuje tablice cząstek w układzie SoA, siatki przestrzenne, diagnostyki czasoprzestrzenne,
struktury robocze workerów oraz generatory pseudolosowe Mersenne Twister.
*/
type SimulationState struct {
	// Prywatne bufory depozycji gęstości ładunku (Krok 1)
	WorkerEDensity []Xvector
	WorkerIDensity []Xvector

	// Prywatne bufory diagnostyk (Krok 3 i Krok 4)
	WorkerEDiag []electronWorkerDiagnostics
	WorkerIDiag []ionWorkerDiagnostics

	// Tablice flag absorpcji na elektrodach dla dwufazowej filtracji granic (Krok 5 i Krok 6)
	AbsorbedE []uint8
	AbsorbedI []uint8

	// Prywatne bufory na nowo utworzone cząstki w procesach jonizacji MCC
	WorkerNewElectrons [][]CreatedParticle
	WorkerNewIons      [][]CreatedParticle

	// Tablice przekrojów czynnych
	Sigma     [N_CS]CrossSection // Zestaw tablic przekrojów czynnych dla wszystkich procesów
	SigmaTotE CrossSection       // Całkowity makroskopowy przekrój czynny dla elektronów
	SigmaTotI CrossSection       // Całkowity makroskopowy przekrój czynny dla jonów

	// Tablice cząstek SoA (Structure of Arrays)
	N_e                   int            // Aktualna liczba aktywnych elektronów
	N_i                   int            // Aktualna liczba aktywnych jonów
	X_e, Vx_e, Vy_e, Vz_e ParticleVector // Współrzędna 1D i wektor prędkości 3V dla elektronów
	X_i, Vx_i, Vy_i, Vz_i ParticleVector // Współrzędna 1D i wektor prędkości 3V dla jonów

	// Siatki przestrzenne potencjału, pola E i gęstości
	Efield, Pot                      Xvector // Rozkład pola elektrycznego i potencjału
	E_density, I_density             Xvector // Chwilowe gęstości elektronów i jonów
	Cumul_e_density, Cumul_i_density Xvector // Skumulowane gęstości uśredniane w czasie

	// Liczniki cząstek pochłoniętych na elektrodach
	N_e_abs_pow uint64 // Licznik elektronów zaabsorbowanych na elektrodzie zasilanej
	N_e_abs_gnd uint64 // Licznik elektronów zaabsorbowanych na elektrodzie uziemionej
	N_i_abs_pow uint64 // Licznik jonów zaabsorbowanych na elektrodzie zasilanej
	N_i_abs_gnd uint64 // Licznik jonów zaabsorbowanych na elektrodzie uziemionej

	// Diagnostyka energetyczna elektronów w centrum wyładowania
	Eepf EepfVector // Scałkowany w czasie rozkład energii elektronów EEPF

	// Diagnostyka energetyczna jonów na elektrodach
	Ifed_pow          IfedVector // Rozkład strumienia energii jonów IFED na elektrodzie zasilanej
	Ifed_gnd          IfedVector // Rozkład strumienia energii jonów IFED na elektrodzie uziemionej
	Mean_i_energy_pow float64    // Średnia energia jonów uderzających w elektrodę zasilaną [eV]
	Mean_i_energy_gnd float64    // Średnia energia jonów uderzających w elektrodę uziemioną [eV]

	// Czasoprzestrzenne macierze diagnostyczne (XT)
	Pot_xt        XtDistr // Rozkład czasoprzestrzenny potencjału
	Efield_xt     XtDistr // Rozkład czasoprzestrzenny pola elektrycznego
	Ne_xt         XtDistr // Rozkład czasoprzestrzenny gęstości elektronów
	Ni_xt         XtDistr // Rozkład czasoprzestrzenny gęstości jonów
	Ue_xt         XtDistr // Rozkład czasoprzestrzenny średniej prędkości elektronów
	Ui_xt         XtDistr // Rozkład czasoprzestrzenny średniej prędkości jonów
	Je_xt         XtDistr // Rozkład czasoprzestrzenny gęstości prądu elektronów
	Ji_xt         XtDistr // Rozkład czasoprzestrzenny gęstości prądu jonów
	Powere_xt     XtDistr // Rozkład mocy pochłanianej przez elektrony (je * E)
	Poweri_xt     XtDistr // Rozkład mocy pochłanianej przez jony (ji * E)
	Meanee_xt     XtDistr // Rozkład czasoprzestrzenny średniej energii elektronów
	Meanei_xt     XtDistr // Rozkład czasoprzestrzenny średniej energii jonów
	Counter_e_xt  XtDistr // Licznik próbek elektronowych dla siatki XT
	Counter_i_xt  XtDistr // Licznik próbek jonowych dla siatki XT
	Ioniz_rate_xt XtDistr // Rozkład czasoprzestrzenny częstości jonizacji

	// Zmienne statystyczne i sterujące symulacją
	Mean_energy_accu_center    float64  // Akumulator energii elektronów w centrum
	Mean_energy_counter_center uint64   // Licznik próbek energii elektronów w centrum
	N_e_coll                   uint64   // Całkowita liczba zderzeń elektronów
	N_i_coll                   uint64   // Całkowita liczba zderzeń jonów
	Time                       float64  // Całkowity fizyczny czas symulacji [s]
	Cycle                      int      // Numer bieżącego cyklu RF
	No_of_cycles               int      // Liczba cykli do wykonania w bieżącym uruchomieniu
	Cycles_done                int      // Liczba cykli ukończonych w poprzednich uruchomieniach
	Arg1                       int      // Argument wiersza poleceń (liczba cykli)
	St0                        string   // Łańcuch znakowy pierwszego argumentu
	Datafile                   *os.File // Uchwyt do pliku zbieżności conv.dat
	Measurement_mode           bool     // Flaga włączająca tryb pomiarowy i diagnostyki

	// Liczba workerów (goroutines) biorących udział w równoległym przetwarzaniu chunków
	NumWorkers int

	// Niezależne generatory pseudolosowe dla każdego workera
	RngWorkers []*rand.Rand
	// Główny generator pseudolosowy
	Rng *rand.Rand
	// Źródło Mersenne Twister do serializacji stanu
	MtSrc *mt19937.MT19937

	// Parametry metody Null-Collision
	NuStarE float64 // Maksymalna częstość zderzeń dla elektronów nu*_e
	PStarE  float64 // Maksymalne prawdopodobieństwo zderzenia elektronu P*_e
	NuStarI float64 // Maksymalna częstość zderzeń dla jonów nu*_i
	PStarI  float64 // Maksymalne prawdopodobieństwo zderzenia jonu P*_i

	// Wstępnie zaalokowana pula indeksów do bezalokacyjnego losowania kandydatów
	CandidatePool []int
}

/*
Tworzy i inicjalizuje nową instancję stanu symulacji SimulationState.
Inicjalizuje niezależne instancje generatora Mersenne Twister MT19937 dla każdego workera
oraz prealokuje wszystkie tablice i prywatne bufory robocze.
@param seed          Ziarno początkowe dla generatora liczb pseudolosowych.
@param optNumWorkers Opcjonalna liczba workerów (goroutines). Domyślnie runtime.GOMAXPROCS(0).
@return Wskaźnik do w pełni zainicjalizowanej struktury SimulationState.
*/
func NewSimulationState(seed int64, optNumWorkers ...int) *SimulationState {
	src := mt19937.New()
	src.Seed(seed)

	numWorkers := 0
	if len(optNumWorkers) > 0 {
		numWorkers = optNumWorkers[0]
	}
	if numWorkers <= 0 {
		numWorkers = runtime.GOMAXPROCS(0)
	}

	workers := make([]*rand.Rand, numWorkers)
	for i := 0; i < numWorkers; i++ {
		wSrc := mt19937.New()
		wSrc.Seed(seed + int64(i)*10007 + 1)
		workers[i] = rand.New(wSrc)
	}

	return &SimulationState{
		NumWorkers:         numWorkers,
		WorkerEDensity:     make([]Xvector, numWorkers),
		WorkerIDensity:     make([]Xvector, numWorkers),
		WorkerEDiag:        make([]electronWorkerDiagnostics, numWorkers),
		WorkerIDiag:        make([]ionWorkerDiagnostics, numWorkers),
		AbsorbedE:          make([]uint8, MAX_N_P),
		AbsorbedI:          make([]uint8, MAX_N_P),
		WorkerNewElectrons: make([][]CreatedParticle, numWorkers),
		WorkerNewIons:      make([][]CreatedParticle, numWorkers),
		CandidatePool:      make([]int, MAX_N_P),
		RngWorkers:         workers,
		Rng:                rand.New(src),
		MtSrc:              src,
	}
}

/*
Losuje liczbę zmiennoprzecinkową o rozkładzie jednorodnym w przedziale [0, 1) z głównego generatora.
@return Liczba pseudolosowa z przedziału [0, 1).
*/
func (sim *SimulationState) R01() float64 {
	return sim.Rng.Float64()
}

/*
Losuje prędkość termiczną z jednowymiarowego rozkładu Maxwella-Boltzmanna (średnia 0, odchylenie RMB_sigma).
@return Prędkość termiczna atomu tła [m/s].
*/
func (sim *SimulationState) RMB() float64 {
	return sim.Rng.NormFloat64() * RMB_sigma
}

/*
Losuje liczbę o rozkładzie jednorodnym w [0, 1) z generatora przypisanego do konkretnego workera.
@param workerID Identyfikator workera (0 .. NumWorkers-1).
@return Liczba pseudolosowa z przedziału [0, 1).
*/
func (sim *SimulationState) WorkerR01(workerID int) float64 {
	return sim.RngWorkers[workerID].Float64()
}

/*
Losuje prędkość termiczną z rozkładu Maxwella-Boltzmanna dla wskazanego workera.
@param workerID Identyfikator workera (0 .. NumWorkers-1).
@return Prędkość termiczna atomu tła [m/s].
*/
func (sim *SimulationState) WorkerRMB(workerID int) float64 {
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
}
