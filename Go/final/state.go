package gopic

import (
	"math"
	"math/rand"
	"os"
	"runtime"

	"github.com/seehuhn/mt19937"
)

// electronWorkerDiagnostics przechowuje prywatne bufory diagnostyczne oraz liczniki absorpcji
// pojedynczego workera dla elektronów, uzupełnione dopełnieniem (paddingiem) chroniącym przed False Sharing.
type electronWorkerDiagnostics struct {
	// Lokalny licznik wag elektronów w węzłach siatki
	counter_e [N_G]float64
	// Lokalny akumulator prędkości kierunkowej elektronów w węzłach siatki
	ue [N_G]float64
	// Lokalny akumulator energii kinetycznej elektronów w węzłach siatki
	meanee [N_G]float64
	// Lokalny akumulator szybkości jonizacji w węzłach siatki
	ioniz [N_G]float64
	// Lokalny histogram rozkładu energii elektronów EEPF
	eepf [N_EEPF]float64
	// Lokalny akumulator energii elektronów w centralnym obszarze wyładowania [eV]
	accuCenter float64
	// Lokalny licznik próbek energii elektronów w centralnym obszarze wyładowania
	counterCenter uint64
	// Lokalny licznik elektronów zaabsorbowanych na elektrodzie zasilanej (x = 0)
	abs_pow uint64
	// Lokalny licznik elektronów zaabsorbowanych na elektrodzie uziemionej (x = L)
	abs_gnd uint64
	// Dopełnienie pamięci (32 B) separujące linie pamięci podręcznej pomiędzy sąsiednimi workerami
	_ [4]uint64
}

// ionWorkerDiagnostics przechowuje prywatne bufory diagnostyczne, histogramy IFED oraz liczniki
// absorpcji pojedynczego workera dla jonów, z dopełnieniem chroniącym przed False Sharing.
type ionWorkerDiagnostics struct {
	// Lokalny licznik wag jonów w węzłach siatki
	counter_i [N_G]float64
	// Lokalny akumulator prędkości kierunkowej jonów w węzłach siatki
	ui [N_G]float64
	// Lokalny akumulator energii kinetycznej jonów w węzłach siatki
	meanei [N_G]float64
	// Lokalny licznik jonów zaabsorbowanych na elektrodzie zasilanej (x = 0)
	abs_pow uint64
	// Lokalny licznik jonów zaabsorbowanych na elektrodzie uziemionej (x = L)
	abs_gnd uint64
	// Lokalny histogram rozkładu energetycznego jonów IFED na elektrodzie zasilanej
	ifed_pow [N_IFED]int
	// Lokalny histogram rozkładu energetycznego jonów IFED na elektrodzie uziemionej
	ifed_gnd [N_IFED]int
	// Dopełnienie pamięci (48 B) separujące linie pamięci podręcznej pomiędzy sąsiednimi workerami
	_ [6]uint64
}

// CreatedParticle reprezentuje położenie 1D oraz składowe prędkości 3V pojedynczej cząstki
// wtórnej (elektronu lub jonu) wygenerowanej w procesie jonizacji uderzeniowej.
type CreatedParticle struct {
	// Pozycja 1D nowo utworzonej cząstki [m]
	X float64
	// Składowa prędkości wzdłuż osi x [m/s]
	Vx float64
	// Składowa prędkości wzdłuż osi y [m/s]
	Vy float64
	// Składowa prędkości wzdłuż osi z [m/s]
	Vz float64
}

var (
	// RMB_sigma określa odchylenie standardowe rozkładu Maxwella-Boltzmanna dla prędkości termicznej atomów Ar [m/s].
	RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)
)

// SimulationState przechowuje pełny stan równoległej symulacji PIC/MCC: prywatne bufory workerów,
// tablice przekrojów czynnych, współrzędne cząstek w układzie SoA, pola na siatce, liczniki diagnostyczne
// oraz strukturę synchronizacji StarBarrier.
type SimulationState struct {
	// Prywatne bufory depozycji gęstości elektronów dla każdego workera
	WorkerEDensity []Xvector
	// Prywatne bufory depozycji gęstości jonów dla każdego workera
	WorkerIDensity []Xvector

	// Prywatne bufory diagnostyczne elektronów dla każdego workera
	WorkerEDiag []electronWorkerDiagnostics
	// Prywatne bufory diagnostyczne jonów dla każdego workera
	WorkerIDiag []ionWorkerDiagnostics

	// Prywatne listy indeksów elektronów zaabsorbowanych na elektrodach w bieżącym kroku
	WorkerDeadElectrons [][]int
	// Prywatne listy indeksów jonów zaabsorbowanych na elektrodach w bieżącym kroku subcyclingu
	WorkerDeadIons [][]int

	// Prywatne bufory nowych elektronów wtórnych utworzonych podczas jonizacji
	WorkerNewElectrons [][]CreatedParticle
	// Prywatne bufory nowych jonów Ar+ utworzonych podczas jonizacji
	WorkerNewIons [][]CreatedParticle

	// Zestaw stabelaryzowanych przekrojów czynnych dla wszystkich 5 procesów zderzeniowych [m^2]
	Sigma [N_CS]CrossSection
	// Całkowity makroskopowy przekrój czynny dla elektronów (sigma_tot * n_gaz) [1/m]
	SigmaTotE CrossSection
	// Całkowity makroskopowy przekrój czynny dla jonów (sigma_tot * n_gaz) [1/m]
	SigmaTotI CrossSection

	// Aktualna liczba aktywnych makrocząstek elektronowych w symulacji
	N_e int
	// Aktualna liczba aktywnych makrocząstek jonowych w symulacji
	N_i int
	// Pozycje 1D [m] oraz składowe prędkości 3V [m/s] elektronów (układ SoA)
	X_e, Vx_e, Vy_e, Vz_e ParticleVector
	// Pozycje 1D [m] oraz składowe prędkości 3V [m/s] jonów (układ SoA)
	X_i, Vx_i, Vy_i, Vz_i ParticleVector

	// Natężenie pola elektrycznego [V/m] oraz potencjał elektrostatyczny [V] w węzłach siatki
	Efield, Pot Xvector
	// Chwilowe gęstości liczbowe elektronów i jonów w węzłach siatki [1/m^3]
	E_density, I_density Xvector
	// Skumulowane w czasie gęstości elektronów i jonów do uśrednień diagnostycznych [1/m^3]
	Cumul_e_density, Cumul_i_density Xvector
	// Prekalkulowane współczynniki eliminacji w przód dla algorytmu Thomasa (solver Poissona)
	ThomasW Xvector

	// Liczba makrocząstek elektronowych zaabsorbowanych na elektrodzie zasilanej (x = 0)
	N_e_abs_pow uint64
	// Liczba makrocząstek elektronowych zaabsorbowanych na elektrodzie uziemionej (x = L)
	N_e_abs_gnd uint64
	// Liczba makrocząstek jonowych zaabsorbowanych na elektrodzie zasilanej (x = 0)
	N_i_abs_pow uint64
	// Liczba makrocząstek jonowych zaabsorbowanych na elektrodzie uziemionej (x = L)
	N_i_abs_gnd uint64

	// Histogram funkcji rozkładu prawdopodobieństwa energii elektronów (EEPF) w środku układu
	Eepf EepfVector

	// Histogram rozkładu energetycznego jonów (IFED) uderzających w elektrodę zasilaną (x = 0)
	Ifed_pow IfedVector
	// Histogram rozkładu energetycznego jonów (IFED) uderzających w elektrodę uziemioną (x = L)
	Ifed_gnd IfedVector
	// Średnia energia jonów docierających do elektrody zasilanej [eV]
	Mean_i_energy_pow float64
	// Średnia energia jonów docierających do elektrody uziemionej [eV]
	Mean_i_energy_gnd float64

	// Rozkład czasoprzestrzenny potencjału elektrostatycznego [V]
	Pot_xt XtDistr
	// Rozkład czasoprzestrzenny natężenia pola elektrycznego [V/m]
	Efield_xt XtDistr
	// Rozkład czasoprzestrzenny gęstości elektronów [1/m^3]
	Ne_xt XtDistr
	// Rozkład czasoprzestrzenny gęstości jonów [1/m^3]
	Ni_xt XtDistr
	// Rozkład czasoprzestrzenny średniej prędkości kierunkowej elektronów [m/s]
	Ue_xt XtDistr
	// Rozkład czasoprzestrzenny średniej prędkości kierunkowej jonów [m/s]
	Ui_xt XtDistr
	// Rozkład czasoprzestrzenny gęstości prądu elektronowego [A/m^2]
	Je_xt XtDistr
	// Rozkład czasoprzestrzenny gęstości prądu jonowego [A/m^2]
	Ji_xt XtDistr
	// Rozkład czasoprzestrzenny gęstości mocy pochłanianej przez elektrony [W/m^3]
	Powere_xt XtDistr
	// Rozkład czasoprzestrzenny gęstości mocy pochłanianej przez jony [W/m^3]
	Poweri_xt XtDistr
	// Rozkład czasoprzestrzenny średniej energii elektronów [eV]
	Meanee_xt XtDistr
	// Rozkład czasoprzestrzenny średniej energii jonów [eV]
	Meanei_xt XtDistr
	// Licznik próbek elektronowych w komórkach siatki czasoprzestrzennej XT
	Counter_e_xt XtDistr
	// Licznik próbek jonowych w komórkach siatki czasoprzestrzennej XT
	Counter_i_xt XtDistr
	// Rozkład czasoprzestrzenny szybkości jonizacji [1/(m^3 s)]
	Ioniz_rate_xt XtDistr

	// Akumulator energii elektronów w centralnym obszarze wyładowania [eV]
	Mean_energy_accu_center float64
	// Licznik zliczeń elektronów w centralnym obszarze wyładowania
	Mean_energy_counter_center uint64
	// Całkowita liczba zderzeń elektronów w przebiegu pomiarowym
	N_e_coll uint64
	// Całkowita liczba zderzeń jonów w przebiegu pomiarowym
	N_i_coll uint64
	// Aktualny fizyczny czas symulacji [s]
	Time float64
	// Bieżący numer cyklu RF
	Cycle int
	// Zadana liczba cykli RF do wykonania w bieżącym uruchomieniu
	No_of_cycles int
	// Całkowita liczba ukończonych dotychczas cykli RF
	Cycles_done int
	// Sparowany pierwszy argument wiersza poleceń określający liczbę cykli do uruchomienia
	Arg1 int
	// Napis reprezentujący pierwszy argument pozycyjny wiersza poleceń
	St0 string
	// Uchwyt do pliku zbieżności conv.dat
	Datafile *os.File
	// Flaga aktywująca tryb pomiarowy (zbieranie i zapis diagnostyk)
	Measurement_mode bool

	// Niezależne generatory liczb pseudolosowych (MT19937) przypisane do poszczególnych workerów
	RngWorkers []*rand.Rand
	// Generator liczb pseudolosowych (MT19937) używany przez wątek główny podczas inicjalizacji
	Rng *rand.Rand

	// Maksymalna częstość zderzeń dla elektronów w metodzie Null-Collision [1/s]
	NuStarE float64
	// Maksymalne prawdopodobieństwo zderzenia elektronu w jednym kroku czasowym DT_E
	PStarE float64
	// Maksymalna częstość zderzeń dla jonów w metodzie Null-Collision [1/s]
	NuStarI float64
	// Maksymalne prawdopodobieństwo zderzenia jonu w jednym kroku subcyclingu DT_I
	PStarI float64

	// Liczba aktywnych workerów równoległych
	NumWorkers int
	// Bezblokadowa bariera synchronizacyjna w topologii gwiazdy
	Barrier *StarBarrier

	// Prekalkulowany rozmiar podzbioru elektronów przypadający na jednego workera
	EChunkSize int
	// Prekalkulowany rozmiar podzbioru jonów przypadający na jednego workera
	IChunkSize int
}

// NewSimulationState tworzy i inicjalizuje strukturę SimulationState wraz z prywatnymi buforami,
// niezależnymi generatorami MT19937 dla każdego workera, współczynnikami Thomasa oraz barierą StarBarrier,
// a następnie uruchamia pulę trwałych goroutines roboczych.
//
// Parametry:
//   - seed: bazowe ziarno dla generatorów liczb pseudolosowych.
//   - optNumWorkers: opcjonalna liczba workerów (domyślnie równa runtime.GOMAXPROCS(0)).
//
// Zwraca:
//   - wskaźnik do zainicjalizowanej struktury SimulationState.
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

	// Inicjalizacja niezależnych generatorów MT19937 dla każdego workera
	workers := make([]*rand.Rand, numWorkers)
	for i := range numWorkers {
		wSrc := mt19937.New()
		wSrc.Seed(seed + int64(i)*10007 + 1)
		workers[i] = rand.New(wSrc)
	}

	// Prealokacja prywatnych buforów na nowe oraz zaabsorbowane cząstki
	newElectrons := make([][]CreatedParticle, numWorkers)
	newIons := make([][]CreatedParticle, numWorkers)
	deadElectrons := make([][]int, numWorkers)
	deadIons := make([][]int, numWorkers)
	for i := range numWorkers {
		newElectrons[i] = make([]CreatedParticle, 0, 4096)
		newIons[i] = make([]CreatedParticle, 0, 4096)
		deadElectrons[i] = make([]int, 0, 1024)
		deadIons[i] = make([]int, 0, 1024)
	}

	// Jednorazowe wyznaczenie współczynników eliminacji w przód dla algorytmu Thomasa
	var thomasW Xvector
	thomasW[1] = C / B
	for i := 2; i <= N_G-2; i++ {
		thomasW[i] = C / (B - A*thomasW[i-1])
	}

	sim := &SimulationState{
		NumWorkers:          numWorkers,
		WorkerEDensity:      make([]Xvector, numWorkers),
		WorkerIDensity:      make([]Xvector, numWorkers),
		WorkerEDiag:         make([]electronWorkerDiagnostics, numWorkers),
		WorkerIDiag:         make([]ionWorkerDiagnostics, numWorkers),
		WorkerDeadElectrons: deadElectrons,
		WorkerDeadIons:      deadIons,
		WorkerNewElectrons:  newElectrons,
		WorkerNewIons:       newIons,
		ThomasW:             thomasW,

		Barrier: NewStarBarrier(numWorkers),

		RngWorkers: workers,
		Rng:        rand.New(src),
	}

	sim.UpdateChunkSizes()
	sim.InitWorkers()

	return sim
}

// UpdateChunkSizes aktualizuje rozmiary podzbiorów elektronów (EChunkSize) i jonów (IChunkSize)
// przypadających na jednego workera. Wywoływana wyłącznie w momencie zmiany liczby cząstek N_e lub N_i.
func (sim *SimulationState) UpdateChunkSizes() {
	if sim.NumWorkers > 0 {
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
		sim.IChunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
	}
}

// R01 losuje liczbę zmiennoprzecinkową z rozkładu jednorodnego [0, 1) przy użyciu głównego generatora Rng.
//
// Zwraca:
//   - pseudolosowa liczba z przedziału [0.0, 1.0).
func (sim *SimulationState) R01() float64 {
	return sim.Rng.Float64()
}

// WorkerR01 losuje liczbę zmiennoprzecinkową z rozkładu jednorodnego [0, 1) przy użyciu
// prywatnego generatora przypisanego do workera o identyfikatorze workerID.
//
// Parametry:
//   - workerID: indeks workera wykonującego losowanie (0 .. NumWorkers-1).
//
// Zwraca:
//   - pseudolosowa liczba z przedziału [0.0, 1.0).
func (sim *SimulationState) WorkerR01(workerID int) float64 {
	return sim.RngWorkers[workerID].Float64()
}

// WorkerRMB losuje składową prędkości termicznej atomu gazu tła z rozkładu Maxwella-Boltzmanna
// przy użyciu prywatnego generatora przypisanego do workera o identyfikatorze workerID.
//
// Parametry:
//   - workerID: indeks workera wykonującego losowanie (0 .. NumWorkers-1).
//
// Zwraca:
//   - składowa prędkości termicznej atomu argonu [m/s].
func (sim *SimulationState) WorkerRMB(workerID int) float64 {
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
}
