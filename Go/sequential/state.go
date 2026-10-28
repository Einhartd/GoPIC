package gopic

import (
	"math"
	"math/rand"
	"os"

	"github.com/seehuhn/mt19937"
)

var (
	// RMB_sigma określa odchylenie standardowe rozkładu Maxwella-Boltzmanna dla prędkości termicznej atomów Ar [m/s].
	RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)
)

// SimulationState przechowuje pełny stan symulacji PIC/MCC: tablice przekrojów czynnych,
// współrzędne cząstek w układzie SoA, pola na siatce, liczniki diagnostyczne oraz generator liczb losowych.
type SimulationState struct {
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
	// Uchwyt do pliku zbieżności conv.dat
	Datafile *os.File
	// Flaga aktywująca tryb pomiarowy (zbieranie i zapis diagnostyk)
	Measurement_mode bool

	// Instancja generatora liczb pseudolosowych (Mersenne Twister MT19937)
	Rng *rand.Rand

	// Maksymalna częstość zderzeń dla elektronów w metodzie Null-Collision [1/s]
	NuStarE float64
	// Maksymalne prawdopodobieństwo zderzenia elektronu w jednym kroku czasowym DT_E
	PStarE float64
	// Maksymalna częstość zderzeń dla jonów w metodzie Null-Collision [1/s]
	NuStarI float64
	// Maksymalne prawdopodobieństwo zderzenia jonu w jednym kroku subcyclingu DT_I
	PStarI float64
}

// NewSimulationState tworzy i inicjalizuje nową strukturę SimulationState
// z generatorem liczb pseudolosowych Mersenne Twister (MT19937) dla zadanego ziarna.
//
// Parametry:
//   - seed: wartość ziarna dla generatora liczb pseudolosowych.
//
// Zwraca:
//   - wskaźnik do nowo utworzonej struktury SimulationState.
func NewSimulationState(seed int64) *SimulationState {
	src := mt19937.New()
	src.Seed(seed)
	return &SimulationState{
		Rng: rand.New(src),
	}
}

// R01 losuje liczbę zmiennoprzecinkową z rozkładu jednorodnego na przedziale [0, 1).
//
// Zwraca:
//   - pseudolosowa liczba z przedziału [0.0, 1.0).
func (sim *SimulationState) R01() float64 {
	return sim.Rng.Float64()
}

// RMB losuje składową prędkości termicznej atomu gazu tła z rozkładu normalnego (Maxwella-Boltzmanna)
// o wartości oczekiwanej 0 i odchyleniu standardowym RMB_sigma.
//
// Zwraca:
//   - składowa prędkości termicznej atomu argonu [m/s].
func (sim *SimulationState) RMB() float64 {
	return sim.Rng.NormFloat64() * RMB_sigma
}
