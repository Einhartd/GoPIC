package gopic

import (
	"math"
	"math/rand"
	"os"

	"github.com/seehuhn/mt19937"
)

var (
	RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS) // RMB_sigma is the standard deviation for the Maxwell-Boltzmann velocity distribution.
)

type SimulationState struct {
	Sigma     [N_CS]CrossSection // set of cross section arrays
	SigmaTotE CrossSection       // total macroscopic cross section of electrons
	SigmaTotI CrossSection       // total macroscopic cross section of ions

	N_e                   int            // number of electrons
	N_i                   int            // number of ions
	X_e, Vx_e, Vy_e, Vz_e ParticleVector // coordinates of electrons (one spatial, three velocity components)
	X_i, Vx_i, Vy_i, Vz_i ParticleVector // coordinates of ions (one spatial, three velocity components)

	Efield, Pot                      Xvector // electric field and potential
	E_density, I_density             Xvector // electron and ion densities
	Cumul_e_density, Cumul_i_density Xvector // cumulative densities

	N_e_abs_pow uint64 // counter for electrons absorbed at the powered electrode
	N_e_abs_gnd uint64 // counter for electrons absorbed at the grounded electrode
	N_i_abs_pow uint64 // counter for ions absorbed at the powered electrode
	N_i_abs_gnd uint64 // counter for ions absorbed at the grounded electrode

	Eepf EepfVector // time integrated EEPF in the center of the plasma

	Ifed_pow          IfedVector // IFED at the powered electrode
	Ifed_gnd          IfedVector // IFED at the grounded electrode
	Mean_i_energy_pow float64    // mean ion energy at the powered electrode
	Mean_i_energy_gnd float64    // mean ion energy at the grounded electrode

	Pot_xt        XtDistr // XT distribution of the potential
	Efield_xt     XtDistr // XT distribution of the electric field
	Ne_xt         XtDistr // XT distribution of the electron density
	Ni_xt         XtDistr // XT distribution of the ion density
	Ue_xt         XtDistr // XT distribution of the mean electron velocity
	Ui_xt         XtDistr // XT distribution of the mean ion velocity
	Je_xt         XtDistr // XT distribution of the electron current density
	Ji_xt         XtDistr // XT distribution of the ion current density
	Powere_xt     XtDistr // XT distribution of the electron powering (power absorption) rate
	Poweri_xt     XtDistr // XT distribution of the ion powering (power absorption) rate
	Meanee_xt     XtDistr // XT distribution of the mean electron energy
	Meanei_xt     XtDistr // XT distribution of the mean ion energy
	Counter_e_xt  XtDistr // XT counter for electron properties
	Counter_i_xt  XtDistr // XT counter for ion properties
	Ioniz_rate_xt XtDistr // XT distribution of the ionisation rate

	Mean_energy_accu_center    float64  // mean electron energy accumulator in the center of the gap
	Mean_energy_counter_center uint64   // mean electron energy counter in the center of the gap
	N_e_coll                   uint64   // counter for electron collisions
	N_i_coll                   uint64   // counter for ion collisions
	Time                       float64  // total simulated time (from the beginning of the simulation)
	Cycle                      int      // current cycle
	No_of_cycles               int      // total cycles in the run
	Cycles_done                int      // cycles completed
	Arg1                       int      // used for reading command line arguments
	St0                        string   // used for reading command line arguments
	Datafile                   *os.File // used for saving data
	Measurement_mode           bool     // flag that controls measurements and data saving

	Rng   *rand.Rand       // RNG instance dedicated to this simulation state
	MtSrc *mt19937.MT19937 // Underlying mt19937 source for state serialization
}

// NewSimulationState creates and initializes a SimulationState with mt19937 RNG.
func NewSimulationState(seed int64) *SimulationState {
	src := mt19937.New()
	src.Seed(seed)
	return &SimulationState{
		Rng:   rand.New(src),
		MtSrc: src,
	}
}

// R01 returns a uniform random number in [0,1) for this state.
func (sim *SimulationState) R01() float64 {
	return sim.Rng.Float64()
}

// RMB returns a normal random number with mean 0 and stddev RMB_sigma for this state.
func (sim *SimulationState) RMB() float64 {
	return sim.Rng.NormFloat64() * RMB_sigma
}
