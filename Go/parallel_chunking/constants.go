package gopic

// =============================================================================
// STAŁE FIZYCZNE I PARAMETRY SYMULACJI PIC/MCC (1D3V) W ARGONIE
// =============================================================================

const (
	// -------------------------------------------------------------------------
	// Podstawowe stałe fizyczne
	// -------------------------------------------------------------------------

	PI          float64 = 3.141592653589793 // Liczba Pi
	TWO_PI      float64 = 2.0 * PI          // 2 * Pi
	E_CHARGE    float64 = 1.60217662e-19    // Ładunek elementarny elektronu [C]
	EV_TO_J     float64 = E_CHARGE          // Współczynnik konwersji eV <-> Dżul [J/eV]
	E_MASS      float64 = 9.10938356e-31    // Masa spoczynkowa elektronu [kg]
	AR_MASS     float64 = 6.63352090e-26    // Masa atomu argonu Ar [kg]
	MU_ARAR     float64 = AR_MASS / 2.0     // Masa zredukowana układu Ar+ / Ar [kg]
	K_BOLTZMANN float64 = 1.38064852e-23    // Stała Boltzmanna [J/K]
	EPSILON0    float64 = 8.85418781e-12    // Przenikalność elektryczna próżni [F/m]

	// -------------------------------------------------------------------------
	// Parametry wyładowania i geometrii reaktora
	// -------------------------------------------------------------------------

	N_G            int     = 400     // Liczba punktów siatki przestrzennej 1D
	N_T            int     = 4000    // Liczba podkroków czasowych w jednym okresie RF
	FREQUENCY      float64 = 13.56e6 // Częstotliwość napięcia zasilającego RF [Hz]
	VOLTAGE        float64 = 250.0   // Amplituda napięcia na elektrodzie zasilanej [V]
	L              float64 = 0.025   // Odległość między elektrodami (szerokość szczeliny) [m]
	PRESSURE       float64 = 10.0    // Ciśnienie gazu neutralnego (Ar) [Pa]
	TEMPERATURE    float64 = 350.0   // Temperatura gazu tła [K]
	WEIGHT         float64 = 7.0e4   // Waga makrocząstki (liczba realnych cząstek w supercząstce)
	ELECTRODE_AREA float64 = 1.0e-4  // Umowna powierzchnia elektrody [m^2]
	N_INIT         int     = 1000    // Początkowa liczba par makrocząstek (elektronów i jonów)

	// -------------------------------------------------------------------------
	// Stałe pochodne dyskretyzacji czasoprzestrzennej
	// -------------------------------------------------------------------------

	PERIOD      float64 = 1.0 / FREQUENCY                        // Okres fali RF [s]
	DT_E        float64 = PERIOD / float64(N_T)                  // Krok czasowy dla elektronów [s]
	N_SUB       int     = 20                                     // Współczynnik subcyclingu jonów (ruch co N_SUB kroków)
	DT_I        float64 = float64(N_SUB) * DT_E                  // Krok czasowy dla jonów [s]
	DX          float64 = L / float64(N_G-1)                     // Krok siatki przestrzennej [m]
	INV_DX      float64 = 1.0 / DX                               // Odwrotność kroku siatki [1/m]
	GAS_DENSITY float64 = PRESSURE / (K_BOLTZMANN * TEMPERATURE) // Gęstość atomów gazu neutralnego [1/m^3]
	OMEGA       float64 = TWO_PI * FREQUENCY                     // Częstość kołowa napięcia RF [rad/s]

	// -------------------------------------------------------------------------
	// Procesy zderzeniowe i przekroje czynne (Cross Sections)
	// -------------------------------------------------------------------------

	N_CS      int     = 5       // Całkowita liczba modelowanych procesów zderzeniowych
	E_ELA     int     = 0       // Identyfikator: zderzenie sprężyste e- / Ar
	E_EXC     int     = 1       // Identyfikator: wzbudzenie poziomu atomu e- / Ar
	E_ION     int     = 2       // Identyfikator: jonizacja uderzeniowa e- / Ar
	I_ISO     int     = 3       // Identyfikator: sprężyste izotropowe zderzenie Ar+ / Ar
	I_BACK    int     = 4       // Identyfikator: rozpraszanie wsteczne (wymiana ładunku) Ar+ / Ar
	E_EXC_TH  float64 = 11.5    // Próg energetyczny wzbudzenia argonu [eV]
	E_ION_TH  float64 = 15.8    // Próg energetyczny jonizacji argonu [eV]
	CS_RANGES int     = 1000000 // Rozmiar tablicy dyskretyzacji przekrojów czynnych
	DE_CS     float64 = 0.001   // Krok dyskretyzacji energii w tabelach przekrojów [eV]

	// -------------------------------------------------------------------------
	// Współczynniki wagowe i siły dla cząstek
	// -------------------------------------------------------------------------

	DV       float64 = ELECTRODE_AREA * DX
	FACTOR_W float64 = WEIGHT / DV
	FACTOR_E float64 = DT_E / E_MASS * E_CHARGE
	FACTOR_I float64 = DT_I / AR_MASS * E_CHARGE
	MIN_X    float64 = 0.45 * L // Dolna granica centralnego obszaru dla EEPF [m]
	MAX_X    float64 = 0.55 * L // Górna granica centralnego obszaru dla EEPF [m]

	// -------------------------------------------------------------------------
	// Diagnostyki plazmy (EEPF, IFED, XT)
	// -------------------------------------------------------------------------

	MAX_N_P int     = 1000000     // Maksymalna pojemność tablic cząstek SoA
	N_EEPF  int     = 2000        // Liczba przedziałów histogramu energii elektronów (EEPF)
	DE_EEPF float64 = 0.05        // Krok dyskretyzacji energii dla EEPF [eV]
	N_IFED  int     = 200         // Liczba przedziałów rozkładu strumienia jonów na elektrodach (IFED)
	DE_IFED float64 = 1.0         // Krok dyskretyzacji energii dla IFED [eV]
	N_BIN   int     = 20          // Liczba kroków czasowych agregowanych w jedną próbkę XT
	N_XT    int     = N_T / N_BIN // Liczba próbek czasowych w macierzach czasoprzestrzennych XT

	// Współczynniki kinematyki zderzeń środka masy
	F1 float64 = E_MASS / (E_MASS + AR_MASS)
	F2 float64 = AR_MASS / (E_MASS + AR_MASS)

	// Współczynniki równania Poissona i algorytmu Thomasa
	A     float64 = 1.0
	B     float64 = -2.0
	C     float64 = 1.0
	S     float64 = 1.0 / (2.0 * DX)
	ALPHA float64 = -DX * DX / EPSILON0
)

// =============================================================================
// DEFINICJE TYPÓW TABLICOWYCH
// =============================================================================

type CrossSection [CS_RANGES]float64 // Tablica dyskretyzacji przekroju czynnego
type ParticleVector [MAX_N_P]float64 // Tablica składowej właściwości cząstek (SoA)
type Xvector [N_G]float64            // Tablica wielkości określonych w węzłach siatki 1D
type EepfVector [N_EEPF]float64      // Histogram funkcji rozkładu energii elektronów EEPF
type IfedVector [N_IFED]int          // Histogram rozkładu energii strumienia jonów IFED
type XtDistr [N_G][N_XT]float64      // Macierz rozkładu czasoprzestrzennego (N_G x N_XT)
