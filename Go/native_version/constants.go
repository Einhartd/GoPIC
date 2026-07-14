package gopic

// constants

const (
	PI          float64 = 3.141592653589793 // mathematical constant Pi
	TWO_PI      float64 = 2.0 * PI          // two times Pi
	E_CHARGE    float64 = 1.60217662e-19    // electron charge [C]
	EV_TO_J     float64 = E_CHARGE          // eV <-> Joule conversion factor
	E_MASS      float64 = 9.10938356e-31    // mass of electron [kg]
	AR_MASS     float64 = 6.63352090e-26    // mass of argon atom [kg]
	MU_ARAR     float64 = AR_MASS / 2.0     // reduced mass of two argon atoms [kg]
	K_BOLTZMANN float64 = 1.38064852e-23    // Boltzmann's constant [J/K]
	EPSILON0    float64 = 8.85418781e-12    // permittivity of free space [F/m]

	// simulation parameters

	N_G            int     = 400     // number of grid points
	N_T            int     = 4000    // time steps within an RF period
	FREQUENCY      float64 = 13.56e6 // driving frequency [Hz]
	VOLTAGE        float64 = 250.0   // voltage amplitude [V]
	L              float64 = 0.025   // electrode gap [m]
	PRESSURE       float64 = 10.0    // gas pressure [Pa]
	TEMPERATURE    float64 = 350.0   // background gas temperature [K]
	WEIGHT         float64 = 7.0e4   // weight of superparticles
	ELECTRODE_AREA float64 = 1.0e-4  // (fictive) electrode area [m^2]
	N_INIT         int     = 1000    // number of initial electrons and ions

	// additional (derived) constants

	PERIOD      float64 = 1.0 / FREQUENCY                        // RF period length [s]
	DT_E        float64 = PERIOD / float64(N_T)                  // electron time step [s]
	N_SUB       int     = 20                                     // ions move only in these cycles (subcycling)
	DT_I        float64 = float64(N_SUB) * DT_E                  // ion time step [s]
	DX          float64 = L / float64(N_G-1)                     // spatial grid division [m]
	INV_DX      float64 = 1.0 / DX                               // inverse of spatial grid size [1/m]
	GAS_DENSITY float64 = PRESSURE / (K_BOLTZMANN * TEMPERATURE) // background gas density [1/m^3]
	OMEGA       float64 = TWO_PI * FREQUENCY                     // angular frequency [rad/s]

	// electron and ion cross sections

	N_CS      int     = 5       // total number of processes / cross sections
	E_ELA     int     = 0       // process identifier: electron/elastic
	E_EXC     int     = 1       // process identifier: electron/excitation
	E_ION     int     = 2       // process identifier: electron/ionization
	I_ISO     int     = 3       // process identifier: ion/elastic/isotropic
	I_BACK    int     = 4       // process identifier: ion/elastic/backscattering
	E_EXC_TH  float64 = 11.5    // electron impact excitation threshold [eV]
	E_ION_TH  float64 = 15.8    // electron impact ionization threshold [eV]
	CS_RANGES int     = 1000000 // number of entries in cross section arrays
	DE_CS     float64 = 0.001   // energy division in cross section arrays [eV]

	DV       float64 = ELECTRODE_AREA * DX
	FACTOR_W float64 = WEIGHT / DV
	FACTOR_E float64 = DT_E / E_MASS * E_CHARGE
	FACTOR_I float64 = DT_I / AR_MASS * E_CHARGE
	MIN_X    float64 = 0.45 * L // min. position for EEPF collection
	MAX_X    float64 = 0.55 * L // max. position for EEPF collection

	MAX_N_P int     = 1000000     // maximum number of particles (electrons / ions)
	N_EEPF  int     = 2000        // number of energy bins in Electron Energy Probability Function (EEPF)
	DE_EEPF float64 = 0.05        // resolution of EEPF [eV]
	N_IFED  int     = 200         // number of energy bins in Ion Flux-Energy Distributions (IFEDs)
	DE_IFED float64 = 1.0         // resolution of IFEDs [eV]
	N_BIN   int     = 20          // number of time steps binned for the XT distributions
	N_XT    int     = N_T / N_BIN // number of spatial bins for the XT distributions
)

// type definitions

type CrossSection [CS_RANGES]float64 // cross section array
type ParticleVector [MAX_N_P]float64 // array for particle properties
type Xvector [N_G]float64            // array for quantities defined at gird points
type EepfVector [N_EEPF]float64      // array for EEPF
type IfedVector [N_IFED]int          // array for IFEDs
type XtDistr [N_G][N_XT]float64      // array for XT distributions (decimal numbers)
