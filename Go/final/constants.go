// Package gopic implementuje zoptymalizowaną równoległą symulację 1D3V Particle-in-Cell / Monte Carlo Collisions (PIC/MCC)
// wyładowania pojemnościowego sprzężonego radiowo (CCRF) w argonie z wykorzystaniem trwałych workerów i bariery StarBarrier.
package gopic

const (
	// Stała matematyczna Pi
	PI float64 = 3.141592653589793
	// Wielokrotność 2 * Pi
	TWO_PI float64 = 2.0 * PI
	// Ładunek elementarny elektronu [C]
	E_CHARGE float64 = 1.60217662e-19
	// Współczynnik konwersji elektronowolt <-> Dżul [J/eV]
	EV_TO_J float64 = E_CHARGE
	// Masa spoczynkowa elektronu [kg]
	E_MASS float64 = 9.10938356e-31
	// Masa atomu argonu Ar [kg]
	AR_MASS float64 = 6.63352090e-26
	// Masa zredukowana układu dwóch atomów argonu Ar+ / Ar [kg]
	MU_ARAR float64 = AR_MASS / 2.0
	// Stała Boltzmanna [J/K]
	K_BOLTZMANN float64 = 1.38064852e-23
	// Przenikalność elektryczna próżni [F/m]
	EPSILON0 float64 = 8.85418781e-12

	// Liczba węzłów siatki przestrzennej 1D
	N_G int = 400
	// Liczba kroków czasowych w jednym okresie fali RF
	N_T int = 4000
	// Częstotliwość napięcia zasilającego RF [Hz]
	FREQUENCY float64 = 13.56e6
	// Amplituda napięcia na elektrodzie zasilanej [V]
	VOLTAGE float64 = 250.0
	// Odległość między elektrodami (szerokość szczeliny wyładowczej) [m]
	L float64 = 0.025
	// Ciśnienie gazu neutralnego (argonu) [Pa]
	PRESSURE float64 = 10.0
	// Temperatura gazu tła [K]
	TEMPERATURE float64 = 350.0
	// Waga makrocząstki (liczba cząstek rzeczywistych reprezentowanych przez jedną supercząstkę)
	WEIGHT float64 = 7.0e4
	// Umowna powierzchnia elektrod [m^2]
	ELECTRODE_AREA float64 = 1.0e-4
	// Początkowa liczba par makrocząstek (elektronów i jonów) przy inicjalizacji
	N_INIT int = 1000

	// Czas trwania jednego okresu RF [s]
	PERIOD float64 = 1.0 / FREQUENCY
	// Krok czasowy dla elektronów [s]
	DT_E float64 = PERIOD / float64(N_T)
	// Współczynnik subcyclingu jonów (ruch i zderzenia jonów co N_SUB kroków elektronowych)
	N_SUB int = 20
	// Krok czasowy dla jonów [s]
	DT_I float64 = float64(N_SUB) * DT_E
	// Krok siatki przestrzennej [m]
	DX float64 = L / float64(N_G-1)
	// Odwrotność kroku siatki przestrzennej [1/m]
	INV_DX float64 = 1.0 / DX
	// Gęstość liczbowa gazu neutralnego z równania stanu gazu doskonałego [1/m^3]
	GAS_DENSITY float64 = PRESSURE / (K_BOLTZMANN * TEMPERATURE)
	// Częstość kołowa napięcia RF [rad/s]
	OMEGA float64 = TWO_PI * FREQUENCY

	// Całkowita liczba modelowanych procesów zderzeniowych
	N_CS int = 5
	// Identyfikator procesu: zderzenie sprężyste elektronu z atomem argonu (e- + Ar)
	E_ELA int = 0
	// Identyfikator procesu: wzbudzenie elektronowe atomu argonu (e- + Ar -> e- + Ar*)
	E_EXC int = 1
	// Identyfikator procesu: jonizacja uderzeniowa atomu argonu (e- + Ar -> 2e- + Ar+)
	E_ION int = 2
	// Identyfikator procesu: sprężyste rozpraszanie izotropowe jonu (Ar+ + Ar)
	I_ISO int = 3
	// Identyfikator procesu: rozpraszanie wsteczne / wymiana ładunku (Ar+ + Ar)
	I_BACK int = 4
	// Próg energetyczny wzbudzenia atomu argonu [eV]
	E_EXC_TH float64 = 11.5
	// Próg energetyczny jonizacji atomu argonu [eV]
	E_ION_TH float64 = 15.8
	// Liczba przedziałów energetycznych w stabelaryzowanych tablicach przekrojów czynnych
	CS_RANGES int = 1000000
	// Krok dyskretyzacji energii w tablicach przekrojów czynnych [eV]
	DE_CS float64 = 0.001

	// Objętość pojedynczej komórki obliczeniowej siatki [m^3]
	DV float64 = ELECTRODE_AREA * DX
	// Współczynnik wagowy do depozycji gęstości ładunku na siatkę [1/m^3]
	FACTOR_W float64 = WEIGHT / DV
	// Współczynnik przyspieszenia elektronów w polu elektrycznym
	FACTOR_E float64 = DT_E / E_MASS * E_CHARGE
	// Współczynnik przyspieszenia jonów w polu elektrycznym
	FACTOR_I float64 = DT_I / AR_MASS * E_CHARGE
	// Dolna granica centralnego obszaru szczeliny dla zliczania rozkładu EEPF [m]
	MIN_X float64 = 0.45 * L
	// Górna granica centralnego obszaru szczeliny dla zliczania rozkładu EEPF [m]
	MAX_X float64 = 0.55 * L

	// Maksymalna pojemność tablic makrocząstek (elektronów i jonów)
	MAX_N_P int = 1000000
	// Liczba przedziałów histogramu funkcji rozkładu prawdopodobieństwa energii elektronów (EEPF)
	N_EEPF int = 2000
	// Rozdzielczość energetyczna histogramu EEPF [eV]
	DE_EEPF float64 = 0.05
	// Liczba przedziałów energetycznych rozkładu strumienia jonów na elektrodach (IFED)
	N_IFED int = 200
	// Rozdzielczość energetyczna histogramu IFED [eV]
	DE_IFED float64 = 1.0
	// Liczba kroków czasowych agregowanych do jednego przedziału rozkładu czasoprzestrzennego XT
	N_BIN int = 20
	// Liczba przedziałów czasowych w macierzach rozkładów czasoprzestrzennych XT
	N_XT int = N_T / N_BIN

	// Ułamek masy elektronu w układzie środka masy e- / Ar
	F1 float64 = E_MASS / (E_MASS + AR_MASS)
	// Ułamek masy atomu argonu w układzie środka masy e- / Ar
	F2 float64 = AR_MASS / (E_MASS + AR_MASS)

	// Współczynnik poddiagonalny macierzy trójdiagonalnej równania Poissona
	A float64 = 1.0
	// Współczynnik głównej przekątnej macierzy trójdiagonalnej równania Poissona
	B float64 = -2.0
	// Współczynnik naddiagonalny macierzy trójdiagonalnej równania Poissona
	C float64 = 1.0
	// Współczynnik różnic centralnych do wyznaczania pola elektrycznego z potencjału [1/m]
	S float64 = 1.0 / (2.0 * DX)
	// Współczynnik prawej strony zlinearyzowanego równania Poissona
	ALPHA float64 = -DX * DX / EPSILON0

	// Odwrotność współczynnika konwersji Dżul -> elektronowolt [eV/J]
	INV_EV_TO_J float64 = 1.0 / EV_TO_J
	// Współczynnik 2 / m_e do szybkiego wyznaczania prędkości z energii kinetycznej [1/kg]
	TWO_OVER_E_MASS float64 = 2.0 / E_MASS
	// Współczynnik 0.5 * m_e do szybkiego wyznaczania energii kinetycznej z kwadratu prędkości [kg]
	HALF_E_MASS float64 = 0.5 * E_MASS

	// Odwrotność kroku dyskretyzacji energii w tablicach przekrojów czynnych [1/eV]
	INV_DE_CS float64 = 1.0 / DE_CS
	// Współczynnik konwersji kwadratu prędkości elektronu v^2 bezpośrednio na indeks tabeli przekrojów
	FACTOR_ENERGY_E float64 = (0.5 * E_MASS * INV_EV_TO_J) * INV_DE_CS
	// Współczynnik konwersji kwadratu prędkości względnej jonu g^2 bezpośrednio na indeks tabeli przekrojów
	FACTOR_ENERGY_I float64 = (0.5 * MU_ARAR * INV_EV_TO_J) * INV_DE_CS
	// Prekalkulowany współczynnik dla rozkładu energii elektronu wtórnego według formuły Opla [1/J]
	OPAL_FACTOR float64 = (1.0 / EV_TO_J) / 20.0

	// Odwrotność rozdzielczości energetycznej histogramu EEPF [1/eV]
	INV_DE_EEPF float64 = 1.0 / DE_EEPF
	// Odwrotność rozdzielczości energetycznej histogramu IFED [1/eV]
	INV_DE_IFED float64 = 1.0 / DE_IFED
	// Współczynnik konwersji kwadratu prędkości jonu v^2 bezpośrednio na indeks histogramu IFED
	FACTOR_ENERGY_IFED float64 = (0.5 * AR_MASS * INV_EV_TO_J) * INV_DE_IFED
	// Współczynnik korekty brzegowej natężenia pola elektrycznego na elektrodach
	BETA float64 = DX / (2.0 * EPSILON0)
)

// CrossSection reprezentuje stabelaryzowany przekrój czynny w funkcji energii.
type CrossSection [CS_RANGES]float64

// ParticleVector reprezentuje tablicę pojedynczej współrzędnej wszystkich makrocząstek (układ SoA).
type ParticleVector [MAX_N_P]float64

// Xvector reprezentuje wektor wielkości fizycznej zdefiniowanej w węzłach siatki przestrzennej.
type Xvector [N_G]float64

// EepfVector reprezentuje histogram funkcji rozkładu prawdopodobieństwa energii elektronów (EEPF).
type EepfVector [N_EEPF]float64

// IfedVector reprezentuje histogram rozkładu strumieniowo-energetycznego jonów na elektrodzie (IFED).
type IfedVector [N_IFED]int

// XtDistr reprezentuje dwuwymiarową macierz rozkładu czasoprzestrzennego XT (przestrzeń x czas).
type XtDistr [N_G][N_XT]float64

// WorkerCommand określa typ rozkazu rozsyłanego przez koordynatora do trwałych workerów w pętli czasowej.
type WorkerCommand int

const (
	// Rozkaz równoległej depozycji gęstości ładunku elektronów na siatkę (Krok 1a)
	CmdComputeEDensity WorkerCommand = iota
	// Rozkaz równoległej depozycji gęstości ładunku jonów na siatkę (Krok 1b)
	CmdComputeIDensity
	// Rozkaz równoległego przesunięcia elektronów i detekcji przekroczenia granic (Kroki 3 + 5)
	CmdMoveElectronsAndBoundaries
	// Rozkaz równoległego przesunięcia jonów, detekcji granic i zliczania IFED (Kroki 4 + 6)
	CmdMoveIonsAndBoundaries
	// Rozkaz równoległej obsługi zderzeń Monte Carlo dla elektronów (Krok 7)
	CmdCollisionsE
	// Rozkaz równoległej obsługi zderzeń Monte Carlo dla jonów (Krok 8)
	CmdCollisionsI
	// Rozkaz zakończenia pętli wykonawczej trwałych workerów
	CmdStop
)
