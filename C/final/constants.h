#pragma once
#include <cmath>

// Stała matematyczna Pi
constexpr double PI                 = 3.141592653589793;
// Wielokrotność 2 * Pi
constexpr double TWO_PI             = 2.0 * PI;
// Ładunek elementarny elektronu [C]
constexpr double E_CHARGE           = 1.60217662e-19;
// Współczynnik konwersji elektronowolt <-> Dżul [J/eV]
constexpr double EV_TO_J            = E_CHARGE;
// Odwrotność współczynnika konwersji Dżul -> elektronowolt [eV/J]
constexpr double INV_EV_TO_J        = 1.0 / EV_TO_J;
// Masa spoczynkowa elektronu [kg]
constexpr double E_MASS             = 9.10938356e-31;
// Współczynnik 2 / m_e do szybkiego wyznaczania prędkości z energii kinetycznej [1/kg]
constexpr double TWO_OVER_E_MASS    = 2.0 / E_MASS;
// Współczynnik 0.5 * m_e do szybkiego wyznaczania energii kinetycznej z kwadratu prędkości [kg]
constexpr double HALF_E_MASS        = 0.5 * E_MASS;
// Masa atomu argonu Ar [kg]
constexpr double AR_MASS            = 6.63352090e-26;
// Masa zredukowana układu dwóch atomów argonu Ar+ / Ar [kg]
constexpr double MU_ARAR            = AR_MASS / 2.0;
// Stała Boltzmanna [J/K]
constexpr double K_BOLTZMANN        = 1.38064852e-23;
// Przenikalność elektryczna próżni [F/m]
constexpr double EPSILON0           = 8.85418781e-12;

// Liczba węzłów siatki przestrzennej 1D
constexpr int    N_G                = 400;
// Liczba kroków czasowych w jednym okresie fali RF
constexpr int    N_T                = 4000;
// Częstotliwość napięcia zasilającego RF [Hz]
constexpr double FREQUENCY          = 13.56e6;
// Amplituda napięcia na elektrodzie zasilanej [V]
constexpr double VOLTAGE            = 250.0;
// Odległość między elektrodami (szerokość szczeliny wyładowczej) [m]
constexpr double L                  = 0.025;
// Ciśnienie gazu neutralnego (argonu) [Pa]
constexpr double PRESSURE           = 10.0;
// Temperatura gazu tła [K]
constexpr double TEMPERATURE        = 350.0;
// Waga makrocząstki (liczba cząstek rzeczywistych reprezentowanych przez jedną supercząstkę)
constexpr double WEIGHT             = 7.0e4;
// Umowna powierzchnia elektrod [m^2]
constexpr double ELECTRODE_AREA     = 1.0e-4;
// Początkowa liczba par makrocząstek (elektronów i jonów) przy inicjalizacji
constexpr int    N_INIT             = 1000;

// Czas trwania jednego okresu RF [s]
constexpr double PERIOD             = 1.0 / FREQUENCY;
// Krok czasowy dla elektronów [s]
constexpr double DT_E               = PERIOD / (double)(N_T);
// Współczynnik subcyclingu jonów (ruch i zderzenia jonów co N_SUB kroków elektronowych)
constexpr int    N_SUB              = 20;
// Krok czasowy dla jonów [s]
constexpr double DT_I               = N_SUB * DT_E;
// Krok siatki przestrzennej [m]
constexpr double DX                 = L / (double)(N_G - 1);
// Odwrotność kroku siatki przestrzennej [1/m]
constexpr double INV_DX             = 1.0 / DX;
// Gęstość liczbowa gazu neutralnego z równania stanu gazu doskonałego [1/m^3]
constexpr double GAS_DENSITY        = PRESSURE / (K_BOLTZMANN * TEMPERATURE);
// Częstość kołowa napięcia RF [rad/s]
constexpr double OMEGA              = TWO_PI * FREQUENCY;

// Całkowita liczba modelowanych procesów zderzeniowych
constexpr int    N_CS               = 5;
// Identyfikator procesu: zderzenie sprężyste elektronu z atomem argonu (e- + Ar)
constexpr int    E_ELA              = 0;
// Identyfikator procesu: wzbudzenie elektronowe atomu argonu (e- + Ar -> e- + Ar*)
constexpr int    E_EXC              = 1;
// Identyfikator procesu: jonizacja uderzeniowa atomu argonu (e- + Ar -> 2e- + Ar+)
constexpr int    E_ION              = 2;
// Identyfikator procesu: sprężyste rozpraszanie izotropowe jonu (Ar+ + Ar)
constexpr int    I_ISO              = 3;
// Identyfikator procesu: rozpraszanie wsteczne / wymiana ładunku (Ar+ + Ar)
constexpr int    I_BACK             = 4;
// Próg energetyczny wzbudzenia atomu argonu [eV]
constexpr double E_EXC_TH           = 11.5;
// Próg energetyczny jonizacji atomu argonu [eV]
constexpr double E_ION_TH           = 15.8;
// Liczba przedziałów energetycznych w stabelaryzowanych tablicach przekrojów czynnych
constexpr int    CS_RANGES          = 1000000;
// Krok dyskretyzacji energii w tablicach przekrojów czynnych [eV]
constexpr double DE_CS              = 0.001;
// Odwrotność kroku dyskretyzacji energii w tablicach przekrojów czynnych [1/eV]
constexpr double INV_DE_CS          = 1.0 / DE_CS;
// Współczynnik konwersji kwadratu prędkości elektronu v^2 bezpośrednio na indeks tabeli przekrojów
constexpr double FACTOR_ENERGY_E    = (0.5 * E_MASS * INV_EV_TO_J) * INV_DE_CS;
// Współczynnik konwersji kwadratu prędkości względnej jonu g^2 bezpośrednio na indeks tabeli przekrojów
constexpr double FACTOR_ENERGY_I    = (0.5 * MU_ARAR * INV_EV_TO_J) * INV_DE_CS;
// Prekalkulowany współczynnik dla rozkładu energii elektronu wtórnego według formuły Opla [1/J]
constexpr double OPAL_FACTOR        = (1.0 / EV_TO_J) / 20.0;
// Typ tablicy stabelaryzowanego przekroju czynnego w funkcji energii
typedef double cross_section[CS_RANGES];

// Maksymalna pojemność tablic makrocząstek (elektronów i jonów)
constexpr int    MAX_N_P            = 1000000;
// Typ tablicy przechowującej pojedynczą współrzędną cząstek wyrównanej do linii cache 64 B (AVX-512)
typedef double __attribute__((aligned(64))) particle_vector[MAX_N_P];
// Typ wektora siatkowego z zapasem bufora SIMD wyrównanego do 64 B
typedef double __attribute__((aligned(64))) xvector[N_G + 16];
// Skrócony alias dla 64-bitowej liczby całkowitej bez znaku (liczniki zdarzeń)
typedef unsigned long long int Ullong;

// Liczba przedziałów histogramu funkcji rozkładu prawdopodobieństwa energii elektronów (EEPF)
constexpr int    N_EEPF             = 2000;
// Rozdzielczość energetyczna histogramu EEPF [eV]
constexpr double DE_EEPF            = 0.05;
// Odwrotność rozdzielczości energetycznej histogramu EEPF [1/eV]
constexpr double INV_DE_EEPF        = 1.0 / DE_EEPF;
// Typ tablicy przechowującej histogram EEPF
typedef double eepf_vector[N_EEPF];

// Dolna granica centralnego obszaru szczeliny dla zliczania rozkładu EEPF [m]
constexpr double MIN_X              = 0.45 * L;
// Górna granica centralnego obszaru szczeliny dla zliczania rozkładu EEPF [m]
constexpr double MAX_X              = 0.55 * L;
// Objętość pojedynczej komórki obliczeniowej siatki [m^3]
constexpr double DV                 = ELECTRODE_AREA * DX;
// Współczynnik wagowy do depozycji gęstości ładunku na siatkę [1/m^3]
constexpr double FACTOR_W           = WEIGHT / DV;
// Współczynnik przyspieszenia jonów w polu elektrycznym
constexpr double FACTOR_I           = DT_I / AR_MASS * E_CHARGE;
// Współczynnik przyspieszenia elektronów w polu elektrycznym
constexpr double FACTOR_E           = DT_E / E_MASS * E_CHARGE;

// Liczba przedziałów energetycznych rozkładu strumienia jonów na elektrodach (IFED)
constexpr int    N_IFED             = 200;
// Rozdzielczość energetyczna histogramu IFED [eV]
constexpr double DE_IFED            = 1.0;
// Odwrotność rozdzielczości energetycznej histogramu IFED [1/eV]
constexpr double INV_DE_IFED        = 1.0 / DE_IFED;
// Współczynnik konwersji kwadratu prędkości jonu v^2 bezpośrednio na indeks histogramu IFED
constexpr double FACTOR_ENERGY_IFED = (0.5 * AR_MASS * INV_EV_TO_J) * INV_DE_IFED;
// Typ tablicy przechowującej histogram IFED
typedef int ifed_vector[N_IFED];

// Liczba kroków czasowych agregowanych do jednego przedziału rozkładu czasoprzestrzennego XT
constexpr int    N_BIN              = 20;
// Liczba przedziałów czasowych w macierzach rozkładów czasoprzestrzennych XT
constexpr int    N_XT               = N_T / N_BIN;
// Typ dwuwymiarowej macierzy rozkładu czasoprzestrzennego XT (przestrzeń x czas)
typedef double xt_distr[N_G][N_XT];

// Ułamek masy elektronu w układzie środka masy e- / Ar
constexpr double F1                 = E_MASS  / (E_MASS + AR_MASS);
// Ułamek masy atomu argonu w układzie środka masy e- / Ar
constexpr double F2                 = AR_MASS / (E_MASS + AR_MASS);

// Współczynnik poddiagonalny macierzy trójdiagonalnej równania Poissona
constexpr double A                  =  1.0;
// Współczynnik głównej przekątnej macierzy trójdiagonalnej równania Poissona
constexpr double B                  = -2.0;
// Współczynnik naddiagonalny macierzy trójdiagonalnej równania Poissona
constexpr double C                  =  1.0;
// Współczynnik różnic centralnych do wyznaczania pola elektrycznego z potencjału [1/m]
constexpr double S                  = 1.0 / (2.0 * DX);
// Współczynnik prawej strony zlinearyzowanego równania Poissona
constexpr double ALPHA              = -DX * DX / EPSILON0;
// Współczynnik prawej strony równania Poissona przemnożony przez ładunek elementarny
constexpr double ALPHA_Q            = ALPHA * E_CHARGE;
// Współczynnik korekty brzegowej natężenia pola elektrycznego na elektrodach
constexpr double BETA_Q             = E_CHARGE * DX / (2.0 * EPSILON0);
