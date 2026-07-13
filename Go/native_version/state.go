package main

import (
	"math"
	"math/rand"
	"os"
	"sync"
	"sync/atomic"
	"time"

	"github.com/seehuhn/mt19937"
)

var (
	sigma       [N_CS]cross_section // set of cross section arrays
	sigma_tot_e cross_section       // total macroscopic cross section of electrons
	sigma_tot_i cross_section       // total macroscopic cross section of ions

	N_e                   int             // number of electrons
	N_i                   int             // number of ions
	x_e, vx_e, vy_e, vz_e particle_vector // coordinates of electrons (one spatial, three velocity components)
	x_i, vx_i, vy_i, vz_i particle_vector // coordinates of ions (one spatial, three velocity components)

	efield, pot                      xvector // electric field and potential
	e_density, i_density             xvector // electron and ion densities
	cumul_e_density, cumul_i_density xvector // cumulative densities

	N_e_abs_pow uint64 // counter for electrons absorbed at the powered electrode
	N_e_abs_gnd uint64 // counter for electrons absorbed at the grounded electrode
	N_i_abs_pow uint64 // counter for ions absorbed at the powered electrode
	N_i_abs_gnd uint64 // counter for ions absorbed at the grounded electrode

	eepf eepf_vector // time integrated EEPF in the center of the plasma

	ifed_pow          ifed_vector // IFED at the powered electrode
	ifed_gnd          ifed_vector // IFED at the grounded electrode
	mean_i_energy_pow float64     // mean ion energy at the powered electrode
	mean_i_energy_gnd float64     // mean ion energy at the grounded electrode

	pot_xt        xt_distr // XT distribution of the potential
	efield_xt     xt_distr // XT distribution of the electric field
	ne_xt         xt_distr // XT distribution of the electron density
	ni_xt         xt_distr // XT distribution of the ion density
	ue_xt         xt_distr // XT distribution of the mean electron velocity
	ui_xt         xt_distr // XT distribution of the mean ion velocity
	je_xt         xt_distr // XT distribution of the electron current density
	ji_xt         xt_distr // XT distribution of the ion current density
	powere_xt     xt_distr // XT distribution of the electron powering (power absorption) rate
	poweri_xt     xt_distr // XT distribution of the ion powering (power absorption) rate
	meanee_xt     xt_distr // XT distribution of the mean electron energy
	meanei_xt     xt_distr // XT distribution of the mean ion energy
	counter_e_xt  xt_distr // XT counter for electron properties
	counter_i_xt  xt_distr // XT counter for ion properties
	ioniz_rate_xt xt_distr // XT distribution of the ionisation rate

	mean_energy_accu_center    float64  // mean electron energy accumulator in the center of the gap
	mean_energy_counter_center uint64   // mean electron energy counter in the center of the gap
	N_e_coll                   uint64   // counter for electron collisions
	N_i_coll                   uint64   // counter for ion collisions
	Time                       float64  // total simulated time (from the beginning of the simulation)
	cycle                      int      // current cycle
	no_of_cycles               int      // total cycles in the run
	cycles_done                int      // cycles completed
	arg1                       int      // used for reading command line arguments
	st0                        string   // used for reading command line arguments
	datafile                   *os.File // used for saving data
	measurement_mode           bool     // flag that controls measurements and data saving

	seedCounter uint64
	rngPool     = sync.Pool{New: newRNG}                         // rngPool stores reusable RNG instances to avoid contention between goroutines.
	RMB_sigma   = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS) // RMB_sigma is the standard deviation for the Maxwell-Boltzmann velocity distribution.

)

//---------------------------------------------------------------------------//
// C++ Mersenne Twister 19937 generator                                      //
// R01(MTgen) will genarate uniform distribution over [0,1) interval         //
// RMB(MTgen) will generate Maxwell-Boltzmann distribution (of gas atoms)    //
//---------------------------------------------------------------------------//

// newMTRand builds a dedicated MT19937-backed RNG instance.
func newMTRand() *rand.Rand {
	seed := uint64(time.Now().UnixNano()) + atomic.AddUint64(&seedCounter, 1)
	src := mt19937.New()
	src.Seed(int64(seed))
	return rand.New(src)
}

// newRNG provides a fresh RNG when the pool is empty.
func newRNG() any {
	return newMTRand()
}

// R01 returns a uniform random number in [0,1).
func R01() float64 {
	r := rngPool.Get().(*rand.Rand)
	v := r.Float64()
	rngPool.Put(r)
	return v
}

// RMB returns a normal random number with mean 0 and stddev RMB_sigma.
func RMB() float64 {
	r := rngPool.Get().(*rand.Rand)
	v := r.NormFloat64() * RMB_sigma
	rngPool.Put(r)
	return v
}
