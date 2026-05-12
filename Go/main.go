package main

import "math"

// math constants

const TWO_PI float64 = math.Pi * 2

// physical constants

const (
	E_CHARGE    float64 = 1.60217662e-19 //	electron charge [C]
	EV_TO_J     float64 = E_CHARGE       //	eV <-> J
	E_MASS      float64 = 9.10938356e-31 //	mass of electron [kg]
	AR_MASS     float64 = 6.63352090e-26 //	mass of argon atom [kg]
	MU_ARAR     float64 = AR_MASS / 2.0  //	reduced mass of two argon atoms [kg]
	K_BOLTZMANN float64 = 1.38064852e-23 //	Boltzmann's constant [J/K]
)

// simulation parameters

const (
	N_G            int16   = 400     //	number of grid points
	N_T            int16   = 4000    //	time steps within an RF period
	FREQUENCY      float64 = 13.56e6 //	driving frequency [Hz]
	VOLTAGE        float64 = 250.0   //	voltage amplitude [V]
	L              float64 = 0.025   //	electrode gap [m]
	PRESSURE       float64 = 10.0    //	gas pressure [Pa]
	TEMPERATURE    float64 = 350.0   // background gas temperature [K]
	WEIGHT         float64 = 7.0e4   // weight of superparticles
	ELECTRODE_AREA float64 = 1.0e-4  //	(fictive) electrode area [m^2]
	N_INIT         int16   = 1000    //	number of initial electrons and ions
)

func main() {
}
