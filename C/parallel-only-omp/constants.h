#pragma once
#include <cmath>

// =============================================================================
// Stałe fizyczne i matematyczne
// =============================================================================

const double     PI             = 3.141592653589793;          // Stała matematyczna Pi
const double     TWO_PI         = 2.0 * PI;                   // 2 * Pi
const double     E_CHARGE       = 1.60217662e-19;             // Ładunek elementarny elektronu [C]
const double     EV_TO_J        = E_CHARGE;                   // Współczynnik konwersji eV <-> Dżule
const double     E_MASS         = 9.10938356e-31;             // Masa spoczynkowa elektronu [kg]
const double     AR_MASS        = 6.63352090e-26;             // Masa atomu argonu [kg]
const double     MU_ARAR        = AR_MASS / 2.0;              // Masa zredukowana układu dwóch atomów argonu [kg]
const double     K_BOLTZMANN    = 1.38064852e-23;             // Stała Boltzmanna [J/K]
const double     EPSILON0       = 8.85418781e-12;             // Przenikalność elektryczna próżni [F/m]

// =============================================================================
// Główne parametry symulacji
// =============================================================================

const int        N_G            = 400;                        // Liczba punktów siatki przestrzennej
const int        N_T            = 4000;                       // Liczba kroków czasowych w jednym okresie RF
const double     FREQUENCY      = 13.56e6;                    // Częstotliwość napięcia zasilającego RF [Hz]
const double     VOLTAGE        = 250.0;                      // Amplituda napięcia zasilającego [V]
const double     L              = 0.025;                      // Odległość między elektrodami [m]
const double     PRESSURE       = 10.0;                       // Ciśnienie gazu neutralnego (argon) [Pa]
const double     TEMPERATURE    = 350.0;                      // Temperatura gazu tła [K]
const double     WEIGHT         = 7.0e4;                      // Waga supercząstki (liczba realnych cząstek przypadająca na makrocząstkę)
const double     ELECTRODE_AREA = 1.0e-4;                     // Fikcyjna powierzchnia elektrod [m^2]
const int        N_INIT         = 1000;                       // Początkowa liczba par elektron-jon przy inicjalizacji

// =============================================================================
// Stałe pochodne (wyliczane na podstawie parametrów głównych)
// =============================================================================

const double     PERIOD         = 1.0 / FREQUENCY;                           // Czas trwania jednego okresu RF [s]
const double     DT_E           = PERIOD / (double)(N_T);                    // Krok czasowy dla elektronów [s]
const int        N_SUB          = 20;                                        // Współczynnik subcyclingu jonów (jony poruszają się co N_SUB kroków elektronowych)
const double     DT_I           = N_SUB * DT_E;                              // Krok czasowy dla jonów [s]
const double     DX             = L / (double)(N_G - 1);                     // Krok siatki przestrzennej [m]
const double     INV_DX         = 1.0 / DX;                                  // Odwrotność kroku siatki [1/m]
const double     GAS_DENSITY    = PRESSURE / (K_BOLTZMANN * TEMPERATURE);    // Gęstość liczbowa gazu tła [1/m^3]
const double     OMEGA          = TWO_PI * FREQUENCY;                        // Częstość kołowa napięcia RF [rad/s]

// =============================================================================
// Przekroje czynne zderzeń elektronów i jonów z argonem
// =============================================================================

const int        N_CS           = 5;                          // Całkowita liczba typów procesów zderzeniowych
const int        E_ELA          = 0;                          // Identyfikator procesu: elektron / sprężyste
const int        E_EXC          = 1;                          // Identyfikator procesu: elektron / wzbudzenie
const int        E_ION          = 2;                          // Identyfikator procesu: elektron / jonizacja
const int        I_ISO          = 3;                          // Identyfikator procesu: jon / sprężyste izotropowe
const int        I_BACK         = 4;                          // Identyfikator procesu: jon / sprężyste wsteczne (wymiana ładunku)
const double     E_EXC_TH       = 11.5;                       // Próg energii dla wzbudzenia argonu przez elektron [eV]
const double     E_ION_TH       = 15.8;                       // Próg energii dla jonizacji argonu przez elektron [eV]
const int        CS_RANGES      = 1000000;                    // Liczba przedziałów w tabelach przekrojów czynnych
const double     DE_CS          = 0.001;                      // Krok dyskretyzacji energii w tabelach przekrojów czynnych [eV]
typedef double   cross_section[CS_RANGES];                    // Tablica przekroju czynnego w funkcji energii

// =============================================================================
// Współrzędne cząstek i typy wektorowe
// =============================================================================

const int        MAX_N_P = 1000000;                           // Maksymalna pojemność tablic cząstek (elektronów / jonów)
typedef double __attribute__((aligned(64)))   particle_vector[MAX_N_P];                    // Tablica przechowująca właściwości cząstek (pozycja, prędkości)
typedef double __attribute__((aligned(64)))   xvector[N_G + 16];                           // Tablica wielkości zdefiniowanych w węzłach siatki (z buforem SIMD)
typedef unsigned long long int Ullong;                        // Skrót dla 64-bitowej liczby całkowitej bez znaku

// =============================================================================
// Funkcja rozkładu prawdopodobieństwa energii elektronów (EEPF)
// =============================================================================

const int    N_EEPF  = 2000;                                 // Liczba przedziałów energii dla diagnostyki EEPF
const double DE_EEPF = 0.05;                                 // Rozdzielczość energetyczna EEPF [eV]
typedef double eepf_vector[N_EEPF];                          // Tablica rozkładu EEPF

// =============================================================================
// Współczynniki pomocnicze dla pętli do_one_cycle()
// =============================================================================

const double MIN_X    = 0.45 * L;                       // Dolna granica przestrzenna dla zliczania EEPF (środek szczeliny)
const double MAX_X    = 0.55 * L;                       // Górna granica przestrzenna dla zliczania EEPF (środek szczeliny)
const double DV       = ELECTRODE_AREA * DX;            // Objętość komórki siatki [m^3]
const double FACTOR_W = WEIGHT / DV;                    // Współczynnik wagi dla depozycji gęstości ładunku
const double FACTOR_I = DT_I / AR_MASS * E_CHARGE;      // Współczynnik przyspieszenia jonów w polu elektrycznym
const double FACTOR_E = DT_E / E_MASS * E_CHARGE;       // Współczynnik przyspieszenia elektronów w polu elektrycznym

// =============================================================================
// Rozkłady strumieniowo-energetyczne jonów docierających do elektrod (IFED)
// =============================================================================

const int    N_IFED   = 200;                                 // Liczba przedziałów energii dla diagnostyki IFED
const double DE_IFED  = 1.0;                                 // Rozdzielczość energetyczna IFED [eV]
typedef int  ifed_vector[N_IFED];                            // Tablica rozkładu IFED (histogram zliczeń)

// =============================================================================
// Rozkłady czasoprzestrzenne (XT)
// =============================================================================

const int N_BIN                     = 20;                    // Liczba kroków czasowych uśrednianych do jednego przedziału XT
const int N_XT                      = N_T / N_BIN;           // Liczba przedziałów czasowych w macierzach czasoprzestrzennych XT (200)
typedef double xt_distr[N_G][N_XT];                          // Macierz dla rozkładów czasoprzestrzennych

// =============================================================================
// Współczynniki kinematyki zderzeń (collision_electron)
// =============================================================================

const double F1 = E_MASS  / (E_MASS + AR_MASS);              // Ułamek masy układu środek masy / elektron
const double F2 = AR_MASS / (E_MASS + AR_MASS);              // Ułamek masy układu środek masy / atom argonu

// =============================================================================
// Współczynniki dla algorytmu Thomasa (solver Poissona)
// =============================================================================

const double A =  1.0;                                       // Współczynnik poddiagonali macierzy trójdiagonalnej
const double B = -2.0;                                       // Współczynnik głównej przekątnej
const double C =  1.0;                                       // Współczynnik naddiagonali
const double S = 1.0 / (2.0 * DX);                           // Współczynnik różnicowy dla pola elektrycznego wewnątrz siatki
const double ALPHA = -DX * DX / EPSILON0;                    // Współczynnik prawej strony równania Poissona
