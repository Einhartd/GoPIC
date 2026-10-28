#pragma once
#include <cmath>

// Stała matematyczna Pi
const double PI             = 3.141592653589793;
// Wielokrotność 2 * Pi
const double TWO_PI         = 2.0 * PI;
// Ładunek elementarny elektronu [C]
const double E_CHARGE       = 1.60217662e-19;
// Współczynnik konwersji elektronowolt <-> Dżul [J/eV]
const double EV_TO_J        = E_CHARGE;
// Masa spoczynkowa elektronu [kg]
const double E_MASS         = 9.10938356e-31;
// Masa atomu argonu Ar [kg]
const double AR_MASS        = 6.63352090e-26;
// Masa zredukowana układu dwóch atomów argonu Ar+ / Ar [kg]
const double MU_ARAR        = AR_MASS / 2.0;
// Stała Boltzmanna [J/K]
const double K_BOLTZMANN    = 1.38064852e-23;
// Przenikalność elektryczna próżni [F/m]
const double EPSILON0       = 8.85418781e-12;

// Liczba węzłów siatki przestrzennej 1D
const int    N_G            = 400;
// Liczba kroków czasowych w jednym okresie fali RF
const int    N_T            = 4000;
// Częstotliwość napięcia zasilającego RF [Hz]
const double FREQUENCY      = 13.56e6;
// Amplituda napięcia na elektrodzie zasilanej [V]
const double VOLTAGE        = 250.0;
// Odległość między elektrodami (szerokość szczeliny wyładowczej) [m]
const double L              = 0.025;
// Ciśnienie gazu neutralnego (argonu) [Pa]
const double PRESSURE       = 10.0;
// Temperatura gazu tła [K]
const double TEMPERATURE    = 350.0;
// Waga makrocząstki (liczba cząstek rzeczywistych reprezentowanych przez jedną supercząstkę)
const double WEIGHT         = 7.0e4;
// Umowna powierzchnia elektrod [m^2]
const double ELECTRODE_AREA = 1.0e-4;
// Początkowa liczba par makrocząstek (elektronów i jonów) przy inicjalizacji
const int    N_INIT         = 1000;

// Czas trwania jednego okresu RF [s]
const double PERIOD         = 1.0 / FREQUENCY;
// Krok czasowy dla elektronów [s]
const double DT_E           = PERIOD / (double)(N_T);
// Współczynnik subcyclingu jonów (ruch i zderzenia jonów co N_SUB kroków elektronowych)
const int    N_SUB          = 20;
// Krok czasowy dla jonów [s]
const double DT_I           = N_SUB * DT_E;
// Krok siatki przestrzennej [m]
const double DX             = L / (double)(N_G - 1);
// Odwrotność kroku siatki przestrzennej [1/m]
const double INV_DX         = 1.0 / DX;
// Gęstość liczbowa gazu neutralnego z równania stanu gazu doskonałego [1/m^3]
const double GAS_DENSITY    = PRESSURE / (K_BOLTZMANN * TEMPERATURE);
// Częstość kołowa napięcia RF [rad/s]
const double OMEGA          = TWO_PI * FREQUENCY;

// Całkowita liczba modelowanych procesów zderzeniowych
const int    N_CS           = 5;
// Identyfikator procesu: zderzenie sprężyste elektronu z atomem argonu (e- + Ar)
const int    E_ELA          = 0;
// Identyfikator procesu: wzbudzenie elektronowe atomu argonu (e- + Ar -> e- + Ar*)
const int    E_EXC          = 1;
// Identyfikator procesu: jonizacja uderzeniowa atomu argonu (e- + Ar -> 2e- + Ar+)
const int    E_ION          = 2;
// Identyfikator procesu: sprężyste rozpraszanie izotropowe jonu (Ar+ + Ar)
const int    I_ISO          = 3;
// Identyfikator procesu: rozpraszanie wsteczne / wymiana ładunku (Ar+ + Ar)
const int    I_BACK         = 4;
// Próg energetyczny wzbudzenia atomu argonu [eV]
const double E_EXC_TH       = 11.5;
// Próg energetyczny jonizacji atomu argonu [eV]
const double E_ION_TH       = 15.8;
// Liczba przedziałów energetycznych w stabelaryzowanych tablicach przekrojów czynnych
const int    CS_RANGES      = 1000000;
// Krok dyskretyzacji energii w tablicach przekrojów czynnych [eV]
const double DE_CS          = 0.001;
// Typ tablicy stabelaryzowanego przekroju czynnego w funkcji energii
typedef double cross_section[CS_RANGES];

// Maksymalna pojemność tablic makrocząstek (elektronów i jonów)
const int    MAX_N_P        = 1000000;
// Typ tablicy przechowującej pojedynczą współrzędną wszystkich cząstek (układ SoA)
typedef double particle_vector[MAX_N_P];
// Typ wektora wielkości zdefiniowanych w węzłach siatki przestrzennej
typedef double xvector[N_G];
// Skrócony alias dla 64-bitowej liczby całkowitej bez znaku (liczniki zdarzeń)
typedef unsigned long long int Ullong;

// Liczba przedziałów histogramu funkcji rozkładu prawdopodobieństwa energii elektronów (EEPF)
const int    N_EEPF         = 2000;
// Rozdzielczość energetyczna histogramu EEPF [eV]
const double DE_EEPF        = 0.05;
// Typ tablicy przechowującej histogram EEPF
typedef double eepf_vector[N_EEPF];

// Dolna granica centralnego obszaru szczeliny dla zliczania rozkładu EEPF [m]
const double MIN_X          = 0.45 * L;
// Górna granica centralnego obszaru szczeliny dla zliczania rozkładu EEPF [m]
const double MAX_X          = 0.55 * L;
// Objętość pojedynczej komórki obliczeniowej siatki [m^3]
const double DV             = ELECTRODE_AREA * DX;
// Współczynnik wagowy do depozycji gęstości ładunku na siatkę [1/m^3]
const double FACTOR_W       = WEIGHT / DV;
// Współczynnik przyspieszenia jonów w polu elektrycznym
const double FACTOR_I       = DT_I / AR_MASS * E_CHARGE;
// Współczynnik przyspieszenia elektronów w polu elektrycznym
const double FACTOR_E       = DT_E / E_MASS * E_CHARGE;

// Liczba przedziałów energetycznych rozkładu strumienia jonów na elektrodach (IFED)
const int    N_IFED         = 200;
// Rozdzielczość energetyczna histogramu IFED [eV]
const double DE_IFED        = 1.0;
// Typ tablicy przechowującej histogram IFED
typedef int  ifed_vector[N_IFED];

// Liczba kroków czasowych agregowanych do jednego przedziału rozkładu czasoprzestrzennego XT
const int    N_BIN          = 20;
// Liczba przedziałów czasowych w macierzach rozkładów czasoprzestrzennych XT
const int    N_XT           = N_T / N_BIN;
// Typ dwuwymiarowej macierzy rozkładu czasoprzestrzennego XT (przestrzeń x czas)
typedef double xt_distr[N_G][N_XT];

// Ułamek masy elektronu w układzie środka masy e- / Ar
const double F1             = E_MASS  / (E_MASS + AR_MASS);
// Ułamek masy atomu argonu w układzie środka masy e- / Ar
const double F2             = AR_MASS / (E_MASS + AR_MASS);

// Współczynnik poddiagonalny macierzy trójdiagonalnej równania Poissona
const double A              =  1.0;
// Współczynnik głównej przekątnej macierzy trójdiagonalnej równania Poissona
const double B              = -2.0;
// Współczynnik naddiagonalny macierzy trójdiagonalnej równania Poissona
const double C              =  1.0;
// Współczynnik różnic centralnych do wyznaczania pola elektrycznego z potencjału [1/m]
const double S              = 1.0 / (2.0 * DX);
// Współczynnik prawej strony zlinearyzowanego równania Poissona
const double ALPHA          = -DX * DX / EPSILON0;
