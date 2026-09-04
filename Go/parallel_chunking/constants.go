package gopic

// =============================================================================
// STAŁE FIZYCZNE I PARAMETRY SYMULACJI PIC/MCC (1D3V) W ARGONIE
// =============================================================================

const (

	// -------------------------------------------------------------------------
	// Podstawowe stałe fizyczne
	// -------------------------------------------------------------------------

	// Liczba Pi
	PI float64 = 3.141592653589793
	// 2 * Pi
	TWO_PI float64 = 2.0 * PI
	// Ładunek elementarny elektronu [C]
	E_CHARGE float64 = 1.60217662e-19
	// Współczynnik konwersji eV <-> Dżul [J/eV]
	EV_TO_J float64 = E_CHARGE
	// Masa spoczynkowa elektronu [kg]
	E_MASS float64 = 9.10938356e-31
	// Masa atomu argonu Ar [kg]
	AR_MASS float64 = 6.63352090e-26
	// Masa zredukowana układu Ar+ / Ar [kg]
	MU_ARAR float64 = AR_MASS / 2.0
	// Stała Boltzmanna [J/K]
	K_BOLTZMANN float64 = 1.38064852e-23
	// Przenikalność elektryczna próżni [F/m]
	EPSILON0 float64 = 8.85418781e-12

	// -------------------------------------------------------------------------
	// Parametry wyładowania i geometrii reaktora
	// -------------------------------------------------------------------------

	// Liczba punktów siatki przestrzennej 1D
	N_G int = 400
	// Liczba podkroków czasowych w jednym okresie RF
	N_T int = 4000
	// Częstotliwość napięcia zasilającego RF [Hz]
	FREQUENCY float64 = 13.56e6
	// Amplituda napięcia na elektrodzie zasilanej [V]
	VOLTAGE float64 = 250.0
	// Odległość między elektrodami (szerokość szczeliny) [m]
	L float64 = 0.025
	// Ciśnienie gazu neutralnego (Ar) [Pa]
	PRESSURE float64 = 10.0
	// Temperatura gazu tła [K]
	TEMPERATURE float64 = 350.0
	// Waga makrocząstki (liczba realnych cząstek w supercząstce)
	WEIGHT float64 = 7.0e4
	// Umowna powierzchnia elektrody [m^2]
	ELECTRODE_AREA float64 = 1.0e-4
	// Początkowa liczba par makrocząstek (elektronów i jonów)
	N_INIT int = 1000

	// -------------------------------------------------------------------------
	// Stałe pochodne dyskretyzacji czasoprzestrzennej
	// -------------------------------------------------------------------------

	// Okres fali RF [s]
	PERIOD float64 = 1.0 / FREQUENCY
	// Krok czasowy dla elektronów [s]
	DT_E float64 = PERIOD / float64(N_T)
	// Współczynnik subcyclingu jonów (ruch co N_SUB kroków)
	N_SUB int = 20
	// Krok czasowy dla jonów [s]
	DT_I float64 = float64(N_SUB) * DT_E
	// Krok siatki przestrzennej [m]
	DX float64 = L / float64(N_G-1)
	// Odwrotność kroku siatki [1/m]
	INV_DX float64 = 1.0 / DX
	// Gęstość atomów gazu neutralnego [1/m^3]
	GAS_DENSITY float64 = PRESSURE / (K_BOLTZMANN * TEMPERATURE)
	// Częstość kołowa napięcia RF [rad/s]
	OMEGA float64 = TWO_PI * FREQUENCY

	// -------------------------------------------------------------------------
	// Procesy zderzeniowe i przekroje czynne (Cross Sections)
	// -------------------------------------------------------------------------

	// Całkowita liczba modelowanych procesów zderzeniowych
	N_CS int = 5
	// Identyfikator: zderzenie sprężyste e- / Ar
	E_ELA int = 0
	// Identyfikator: wzbudzenie poziomu atomu e- / Ar
	E_EXC int = 1
	// Identyfikator: jonizacja uderzeniowa e- / Ar
	E_ION int = 2
	// Identyfikator: sprężyste izotropowe zderzenie Ar+ / Ar
	I_ISO int = 3
	// Identyfikator: rozpraszanie wsteczne (wymiana ładunku) Ar+ / Ar
	I_BACK int = 4
	// Próg energetyczny wzbudzenia argonu [eV]
	E_EXC_TH float64 = 11.5
	// Próg energetyczny jonizacji argonu [eV]
	E_ION_TH float64 = 15.8
	// Rozmiar tablicy dyskretyzacji przekrojów czynnych
	CS_RANGES int = 1000000
	// Krok dyskretyzacji energii w tabelach przekrojów [eV]
	DE_CS float64 = 0.001

	// -------------------------------------------------------------------------
	// Współczynniki wagowe i siły dla cząstek
	// -------------------------------------------------------------------------

	DV       float64 = ELECTRODE_AREA * DX
	FACTOR_W float64 = WEIGHT / DV
	FACTOR_E float64 = DT_E / E_MASS * E_CHARGE
	FACTOR_I float64 = DT_I / AR_MASS * E_CHARGE
	// Dolna granica centralnego obszaru dla EEPF [m]
	MIN_X float64 = 0.45 * L
	// Górna granica centralnego obszaru dla EEPF [m]
	MAX_X float64 = 0.55 * L

	// -------------------------------------------------------------------------
	// Diagnostyki plazmy (EEPF, IFED, XT)
	// -------------------------------------------------------------------------

	// Maksymalna pojemność tablic cząstek SoA
	MAX_N_P int = 1000000
	// Liczba przedziałów histogramu energii elektronów (EEPF)
	N_EEPF int = 2000
	// Krok dyskretyzacji energii dla EEPF [eV]
	DE_EEPF float64 = 0.05
	// Liczba przedziałów rozkładu strumienia jonów na elektrodach (IFED)
	N_IFED int = 200
	// Krok dyskretyzacji energii dla IFED [eV]
	DE_IFED float64 = 1.0
	// Liczba kroków czasowych agregowanych w jedną próbkę XT
	N_BIN int = 20
	// Liczba próbek czasowych w macierzach czasoprzestrzennych XT
	N_XT int = N_T / N_BIN

	// Współczynniki kinematyki zderzeń środka masy
	F1 float64 = E_MASS / (E_MASS + AR_MASS)
	F2 float64 = AR_MASS / (E_MASS + AR_MASS)

	// Współczynniki równania Poissona i algorytmu Thomasa
	A     float64 = 1.0
	B     float64 = -2.0
	C     float64 = 1.0
	S     float64 = 1.0 / (2.0 * DX)
	ALPHA float64 = -DX * DX / EPSILON0

	// -------------------------------------------------------------------------
	// Prekompilowane odwrotności i współczynniki łączone
	// -------------------------------------------------------------------------

	// Odwrotności stałych fizycznych
	INV_EV_TO_J     float64 = 1.0 / EV_TO_J
	INV_E_MASS      float64 = 1.0 / E_MASS
	TWO_OVER_E_MASS float64 = 2.0 / E_MASS
	HALF_E_MASS     float64 = 0.5 * E_MASS
	INV_AR_MASS     float64 = 1.0 / AR_MASS
	HALF_AR_MASS    float64 = 0.5 * AR_MASS

	// Odwrotności kroków czasoprzestrzennych
	INV_DT_E float64 = 1.0 / DT_E
	INV_DT_I float64 = 1.0 / DT_I

	// Współczynniki konwersji energii do indeksów dyskretyzacji
	INV_DE_CS       float64 = 1.0 / DE_CS
	FACTOR_ENERGY_E float64 = (0.5 * E_MASS * INV_EV_TO_J) * INV_DE_CS
	FACTOR_ENERGY_I float64 = (0.5 * MU_ARAR * INV_EV_TO_J) * INV_DE_CS
	OPAL_FACTOR     float64 = (1.0 / EV_TO_J) / 20.0

	// Diagnostyki (EEPF, IFED) i Poisson
	INV_DE_EEPF        float64 = 1.0 / DE_EEPF
	INV_DE_IFED        float64 = 1.0 / DE_IFED
	FACTOR_ENERGY_IFED float64 = (0.5 * AR_MASS * INV_EV_TO_J) * INV_DE_IFED
	BETA               float64 = DX / (2.0 * EPSILON0)
)

// =============================================================================
// DEFINICJE TYPÓW TABLICOWYCH
// =============================================================================

// Tablica dyskretyzacji przekroju czynnego
type CrossSection [CS_RANGES]float64

// Tablica składowej właściwości cząstek (SoA)
type ParticleVector [MAX_N_P]float64

// Tablica wielkości określonych w węzłach siatki 1D
type Xvector [N_G]float64

// Histogram funkcji rozkładu energii elektronów EEPF
type EepfVector [N_EEPF]float64

// Histogram rozkładu energii strumienia jonów IFED
type IfedVector [N_IFED]int

// Macierz rozkładu czasoprzestrzennego (N_G x N_XT)
type XtDistr [N_G][N_XT]float64
