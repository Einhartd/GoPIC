package main

import (
	"bufio"
	"encoding/binary"
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
	"time"

	"github.com/seehuhn/mt19937"
)

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
)

// simulation parameters

const (
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
)

// additional (derived) constants

const (
	PERIOD      float64 = 1.0 / FREQUENCY                        // RF period length [s]
	DT_E        float64 = PERIOD / float64(N_T)                  // electron time step [s]
	N_SUB       int     = 20                                     // ions move only in these cycles (subcycling)
	DT_I        float64 = float64(N_SUB) * DT_E                  // ion time step [s]
	DX          float64 = L / float64(N_G-1)                     // spatial grid division [m]
	INV_DX      float64 = 1.0 / DX                               // inverse of spatial grid size [1/m]
	GAS_DENSITY float64 = PRESSURE / (K_BOLTZMANN * TEMPERATURE) // background gas density [1/m^3]
	OMEGA       float64 = TWO_PI * FREQUENCY                     // angular frequency [rad/s]
)

var (
	DV       float64 = ELECTRODE_AREA * DX
	FACTOR_W float64 = WEIGHT / DV
	FACTOR_E float64 = DT_E / E_MASS * E_CHARGE
	FACTOR_I float64 = DT_I / AR_MASS * E_CHARGE
	MIN_X    float64 = 0.45 * L // min. position for EEPF collection
	MAX_X    float64 = 0.55 * L // max. position for EEPF collection
)

// electron and ion cross sections

const (
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
)

type cross_section [CS_RANGES]float64 // cross section array

var (
	sigma       [N_CS]cross_section // set of cross section arrays
	sigma_tot_e cross_section       // total macroscopic cross section of electrons
	sigma_tot_i cross_section       // total macroscopic cross section of ions
)

// particle coordinates

const MAX_N_P int = 1000000 // maximum number of particles (electrons / ions)

type particle_vector [MAX_N_P]float64 // array for particle properties

var (
	N_e  int             // number of electrons
	N_i  int             // number of ions
	x_e  particle_vector // coordinates of electrons (one spatial, three velocity components)
	vx_e particle_vector
	vy_e particle_vector
	vz_e particle_vector
	x_i  particle_vector // coordinates of ions (one spatial, three velocity components)
	vx_i particle_vector
	vy_i particle_vector
	vz_i particle_vector
)

type xvector [N_G]float64 // array for quantities defined at gird points

var (
	efield          xvector // electric field and potential
	pot             xvector
	e_density       xvector // electron and ion densities
	i_density       xvector
	cumul_e_density xvector // cumulative densities
	cumul_i_density xvector
)

var (
	N_e_abs_pow uint64 // counter for electrons absorbed at the powered electrode
	N_e_abs_gnd uint64 // counter for electrons absorbed at the grounded electrode
	N_i_abs_pow uint64 // counter for ions absorbed at the powered electrode
	N_i_abs_gnd uint64 // counter for ions absorbed at the grounded electrode
)

// electron energy probability function

const (
	N_EEPF  int     = 2000 // number of energy bins in Electron Energy Probability Function (EEPF)
	DE_EEPF float64 = 0.05 // resolution of EEPF [eV]
)

type eepf_vector [N_EEPF]float64 // array for EEPF

var eepf eepf_vector // time integrated EEPF in the center of the plasma

// ion flux-energy distributions

const (
	N_IFED  int     = 200 // number of energy bins in Ion Flux-Energy Distributions (IFEDs)
	DE_IFED float64 = 1.0 // resolution of IFEDs [eV]
)

type ifed_vector [N_IFED]int // array for IFEDs

var (
	ifed_pow          ifed_vector // IFED at the powered electrode
	ifed_gnd          ifed_vector // IFED at the grounded electrode
	mean_i_energy_pow float64     // mean ion energy at the powered electrode
	mean_i_energy_gnd float64     // mean ion energy at the grounded electrode
)

// spatio-temporal (XT) distributions

const (
	N_BIN int = 20          // number of time steps binned for the XT distributions
	N_XT  int = N_T / N_BIN // number of spatial bins for the XT distributions
)

type xt_distr [N_G][N_XT]float64 // array for XT distributions (decimal numbers)

var (
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
)

var (
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
)

//---------------------------------------------------------------------------//
// C++ Mersenne Twister 19937 generator                                      //
// R01(MTgen) will genarate uniform distribution over [0,1) interval         //
// RMB(MTgen) will generate Maxwell-Boltzmann distribution (of gas atoms)    //
//---------------------------------------------------------------------------//

var seedCounter uint64

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

// rngPool stores reusable RNG instances to avoid contention between goroutines.
var rngPool = sync.Pool{New: newRNG}

// RMB_sigma is the standard deviation for the Maxwell-Boltzmann velocity distribution.
var RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)

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

//----------------------------------------------------------------------------//
//  electron cross sections: A V Phelps & Z Lj Petrovic, PSST 8 R21 (1999)    //
//----------------------------------------------------------------------------//

func setElectronCrossSectionsAr() {
	var en, qmel, qexc, qion float64

	fmt.Println(">> eduPIC: Setting e- / Ar cross sections")
	for i := 0; i < CS_RANGES; i++ {
		if i == 0 {
			en = DE_CS
		} else {
			en = DE_CS * float64(i)
		} // electron energy
		qmel = math.Abs(6.0/math.Pow(1.0+(en/0.1)+math.Pow(en/0.6, 2.0), 3.3)-
			1.1*math.Pow(en, 1.4)/(1.0+math.Pow(en/15.0, 1.2))/math.Sqrt(1.0+math.Pow(en/5.5, 2.5)+math.Pow(en/60.0, 4.1))) +
			0.05/math.Pow(1.0+en/10.0, 2.0) + 0.01*math.Pow(en, 3.0)/(1.0+math.Pow(en/12.0, 6.0))
		if en > E_EXC_TH {
			qexc = 0.034*math.Pow(en-11.5, 1.1)*(1.0+math.Pow(en/15.0, 2.8))/(1.0+math.Pow(en/23.0, 5.5)) +
				0.023*(en-11.5)/math.Pow(1.0+en/80.0, 1.9)
		} else {
			qexc = 0
		}
		if en > E_ION_TH {
			qion = 970.0*(en-15.8)/math.Pow(70.0+en, 2.0) + 0.06*math.Pow(en-15.8, 2.0)*math.Exp(-en/9)
		} else {
			qion = 0
		}
		sigma[E_ELA][i] = qmel * 1.0e-20 // cross section for e- / Ar elastic collision
		sigma[E_EXC][i] = qexc * 1.0e-20 // cross section for e- / Ar excitation
		sigma[E_ION][i] = qion * 1.0e-20 // cross section for e- / Ar ionization
	}
}

//------------------------------------------------------------------------------//
//  ion cross sections: A. V. Phelps, J. Appl. Phys. 76, 747 (1994)             //
//------------------------------------------------------------------------------//

func setIonCrossSectionsAr() {
	var e_com, e_lab, qmom, qback, qiso float64

	fmt.Println(">> eduPIC: Setting Ar+ / Ar cross sections")
	for i := 0; i < CS_RANGES; i++ {
		if i == 0 {
			e_com = DE_CS
		} else {
			e_com = DE_CS * float64(i)
		} // ion energy in the center of mass frame of reference
		e_lab = 2.0 * e_com // ion energy in the laboratory frame of reference
		qmom = 1.15e-18 * math.Pow(e_lab, -0.1) * math.Pow(1.0+0.015/e_lab, 0.6)
		qiso = 2e-19*math.Pow(e_lab, -0.5)/(1.0+e_lab) + 3e-19*e_lab/math.Pow(1.0+e_lab/3.0, 2.0)
		qback = (qmom - qiso) / 2.0
		sigma[I_ISO][i] = qiso   // cross section for Ar+ / Ar isotropic part of elastic scattering
		sigma[I_BACK][i] = qback // cross section for Ar+ / Ar backward elastic scattering
	}
}

//----------------------------------------------------------------------//
//  calculation of total cross sections for electrons and ions          //
//----------------------------------------------------------------------//

func calcTotalCrossSections() {
	for i := 0; i < CS_RANGES; i++ {
		sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY // total macroscopic cross section of electrons
		sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY                  // total macroscopic cross section of ions
	}
}

//----------------------------------------------------------------------//
//  test of cross sections for electrons and ions                       //
//----------------------------------------------------------------------//

func testCrossSections() {
	f, err := os.Create("cross_sections.dat") // cross sections saved in data file: cross_sections.dat
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < CS_RANGES; i++ {
		fmt.Fprintf(f, "%12.4f ", float64(i)*DE_CS)
		for j := 0; j < N_CS; j++ {
			fmt.Fprintf(f, "%14e ", sigma[j][i])
		}
		fmt.Fprint(f, "\n")
	}
}

//---------------------------------------------------------------------//
// find upper limit of collision frequencies                           //
//---------------------------------------------------------------------//

func maxElectronCollFreq() float64 {
	nu_max := 0.0
	for i := 0; i < CS_RANGES; i++ {
		e := float64(i) * DE_CS
		v := math.Sqrt(2.0 * e * EV_TO_J / E_MASS)
		nu := v * sigma_tot_e[i]
		if nu > nu_max {
			nu_max = nu
		}
	}
	return nu_max
}

func maxIonCollFreq() float64 {
	nu_max := 0.0
	for i := 0; i < CS_RANGES; i++ {
		e := float64(i) * DE_CS
		g := math.Sqrt(2.0 * e * EV_TO_J / MU_ARAR)
		nu := g * sigma_tot_i[i]
		if nu > nu_max {
			nu_max = nu
		}
	}
	return nu_max
}

//----------------------------------------------------------------------//
// initialization of the simulation by placing a given number of        //
// electrons and ions at random positions between the electrodes        //
//----------------------------------------------------------------------//

func initParticles(nseed int) {
	for i := 0; i < nseed; i++ {
		x_e[i] = L * R01() // initial random position of the electron
		vx_e[i] = 0
		vy_e[i] = 0
		vz_e[i] = 0        // initial velocity components of the electron
		x_i[i] = L * R01() // initial random position of the ion
		vx_i[i] = 0
		vy_i[i] = 0
		vz_i[i] = 0 // initial velocity components of the ion
	}
	N_e = nseed // initial number of electrons
	N_i = nseed // initial number of ions
}

//----------------------------------------------------------------------//
// e / Ar collision  (cold gas approximation)                           //
//----------------------------------------------------------------------//

func collisionElectron(xe float64, vxe, vye, vze *float64, eindex int) {
	const F1 float64 = E_MASS / (E_MASS + AR_MASS)
	const F2 float64 = AR_MASS / (E_MASS + AR_MASS)
	var t0, t1, t2, rnd float64
	var g, g2, gx, gy, gz, wx, wy, wz, theta, phi float64
	var chi, eta, chi2, eta2, sc, cc, se, ce, st, ct, sp, cp, energy, e_sc, e_ej float64

	// calculate relative velocity before collision & velocity of the centre of mass

	gx = *vxe
	gy = *vye
	gz = *vze
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
	wx = F1 * (*vxe)
	wy = F1 * (*vye)
	wz = F1 * (*vze)

	// find Euler angles

	if gx == 0 {
		theta = 0.5 * PI
	} else {
		theta = math.Atan2(math.Sqrt(gy*gy+gz*gz), gx)
	}
	if gy == 0 {
		if gz > 0 {
			phi = 0.5 * PI
		} else {
			phi = -0.5 * PI
		}
	} else {
		phi = math.Atan2(gz, gy)
	}
	st = math.Sin(theta)
	ct = math.Cos(theta)
	sp = math.Sin(phi)
	cp = math.Cos(phi)

	// choose the type of collision based on the cross sections
	// take into account energy loss in inelastic collisions
	// generate scattering and azimuth angles
	// in case of ionization handle the 'new' electron

	t0 = sigma[E_ELA][eindex]
	t1 = t0 + sigma[E_EXC][eindex]
	t2 = t1 + sigma[E_ION][eindex]
	rnd = R01()
	if rnd < (t0 / t2) { // elastic scattering
		chi = math.Acos(1.0 - 2.0*R01()) // isotropic scattering
		eta = TWO_PI * R01()             // azimuthal angle
	} else if rnd < (t1 / t2) { // excitation
		energy = 0.5 * E_MASS * g * g
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J) // subtract energy loss for excitation
		g = math.Sqrt(2.0 * energy / E_MASS)         // relative velocity after energy loss
		chi = math.Acos(1.0 - 2.0*R01())             // isotropic scattering
		eta = TWO_PI * R01()                         // azimuthal angle
	} else { // ionization
		energy = 0.5 * E_MASS * g * g
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)                           // subtract energy loss of ionization
		e_ej = 10.0 * math.Tan(R01()*math.Atan(energy/EV_TO_J/20.0)) * EV_TO_J // energy of the ejected electron
		e_sc = math.Abs(energy - e_ej)                                         // energy of scattered electron after the collision
		g = math.Sqrt(2.0 * e_sc / E_MASS)                                     // relative velocity of scattered electron
		g2 = math.Sqrt(2.0 * e_ej / E_MASS)                                    // relative velocity of ejected electron
		chi = math.Acos(math.Sqrt(e_sc / energy))                              // scattering angle for scattered electron
		chi2 = math.Acos(math.Sqrt(e_ej / energy))                             // scattering angle for ejected electrons
		eta = TWO_PI * R01()                                                   // azimuthal angle for scattered electron
		eta2 = eta + PI                                                        // azimuthal angle for ejected electron
		sc = math.Sin(chi2)
		cc = math.Cos(chi2)
		se = math.Sin(eta2)
		ce = math.Cos(eta2)
		gx = g2 * (ct*cc - st*sc*ce)
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
		x_e[N_e] = xe // add new electron
		vx_e[N_e] = wx + F2*gx
		vy_e[N_e] = wy + F2*gy
		vz_e[N_e] = wz + F2*gz
		N_e++
		x_i[N_i] = xe     // add new ion
		vx_i[N_i] = RMB() // velocity is sampled from background thermal distribution
		vy_i[N_i] = RMB()
		vz_i[N_i] = RMB()
		N_i++
	}

	// scatter the primary electron

	sc = math.Sin(chi)
	cc = math.Cos(chi)
	se = math.Sin(eta)
	ce = math.Cos(eta)

	// compute new relative velocity:

	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	// post-collision velocity of the colliding electron

	*vxe = wx + F2*gx
	*vye = wy + F2*gy
	*vze = wz + F2*gz
}

//----------------------------------------------------------------------//
// Ar+ / Ar collision                                                   //
//----------------------------------------------------------------------//

func collisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int) {
	var g, gx, gy, gz, wx, wy, wz, rnd float64
	var theta, phi, chi, eta, st, ct, sp, cp, sc, cc, se, ce, t1, t2 float64

	// calculate relative velocity before collision
	// random Maxwellian target atom already selected (vx_2,vy_2,vz_2 velocity components of target atom come with the call)

	gx = (*vx_1) - (*vx_2)
	gy = (*vy_1) - (*vy_2)
	gz = (*vz_1) - (*vz_2)
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
	wx = 0.5 * ((*vx_1) + (*vx_2))
	wy = 0.5 * ((*vy_1) + (*vy_2))
	wz = 0.5 * ((*vz_1) + (*vz_2))

	// find Euler angles

	if gx == 0 {
		theta = 0.5 * PI
	} else {
		theta = math.Atan2(math.Sqrt(gy*gy+gz*gz), gx)
	}
	if gy == 0 {
		if gz > 0 {
			phi = 0.5 * PI
		} else {
			phi = -0.5 * PI
		}
	} else {
		phi = math.Atan2(gz, gy)
	}

	// determine the type of collision based on cross sections and generate scattering angle

	t1 = sigma[I_ISO][e_index]
	t2 = t1 + sigma[I_BACK][e_index]
	rnd = R01()
	if rnd < (t1 / t2) { // isotropic scattering
		chi = math.Acos(1.0 - 2.0*R01()) // scattering angle
	} else { // backward scattering
		chi = PI // scattering angle
	}
	eta = TWO_PI * R01() // azimuthal angle
	sc = math.Sin(chi)
	cc = math.Cos(chi)
	se = math.Sin(eta)
	ce = math.Cos(eta)
	st = math.Sin(theta)
	ct = math.Cos(theta)
	sp = math.Sin(phi)
	cp = math.Cos(phi)

	// compute new relative velocity

	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	// post-collision velocity of the ion

	*vx_1 = wx + 0.5*gx
	*vy_1 = wy + 0.5*gy
	*vz_1 = wz + 0.5*gz
}

//-----------------------------------------------------------------//
// solve Poisson equation (Thomas algorithm)                       //
//-----------------------------------------------------------------//

func solvePoisson(rho1 *xvector, tt float64) {
	const A float64 = 1.0
	const B float64 = -2.0
	const C float64 = 1.0
	const S float64 = 1.0 / (2.0 * DX)
	const ALPHA float64 = -DX * DX / EPSILON0
	var g, w, f xvector

	// apply potential to the electrodes - boundary conditions

	pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // potential at the powered electrode
	pot[N_G-1] = 0.0                      // potential at the grounded electrode

	// solve Poisson equation

	for i := 1; i <= N_G-2; i++ {
		f[i] = ALPHA * (*rho1)[i]
	}
	f[1] -= pot[0]
	f[N_G-2] -= pot[N_G-1]
	w[1] = C / B
	g[1] = f[1] / B
	for i := 2; i <= N_G-2; i++ {
		w[i] = C / (B - A*w[i-1])
		g[i] = (f[i] - A*g[i-1]) / (B - A*w[i-1])
	}
	pot[N_G-2] = g[N_G-2]
	for i := N_G - 3; i > 0; i-- {
		pot[i] = g[i] - w[i]*pot[i+1] // potential at the grid points between the electrodes
	}

	// compute electric field

	for i := 1; i <= N_G-2; i++ {
		efield[i] = (pot[i-1] - pot[i+1]) * S // electric field at the grid points between the electrodes
	}
	efield[0] = (pot[0]-pot[1])*INV_DX - (*rho1)[0]*DX/(2.0*EPSILON0)                 // powered electrode
	efield[N_G-1] = (pot[N_G-2]-pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*DX/(2.0*EPSILON0) // grounded electrode
}

//---------------------------------------------------------------------//
// simulation of one radiofrequency cycle                              //
//---------------------------------------------------------------------//

func step1_compute_electron_density() {
	var k, p int
	var c0 float64

	for p = 0; p < N_G; p++ {
		e_density[p] = 0 // electron density - computed in every time step
	}
	for k = 0; k < N_e; k++ {
		c0 = x_e[k] * INV_DX
		p = int(c0)
		e_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
		e_density[p+1] += (c0 - float64(p)) * FACTOR_W
	}
	e_density[0] *= 2.0
	e_density[N_G-1] *= 2.0
	for p = 0; p < N_G; p++ {
		cumul_e_density[p] += e_density[p]
	}
}

func step1_compute_ion_density(t int) {
	var k, p int
	var c0 float64

	if (t % N_SUB) == 0 { // ion density - computed in every N_SUB-th time steps (subcycling)
		for p = 0; p < N_G; p++ {
			i_density[p] = 0
		}
		for k = 0; k < N_i; k++ {
			c0 = x_i[k] * INV_DX
			p = int(c0)
			i_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
			i_density[p+1] += (c0 - float64(p)) * FACTOR_W
		}
		i_density[0] *= 2.0
		i_density[N_G-1] *= 2.0
	}
	for p = 0; p < N_G; p++ {
		cumul_i_density[p] += i_density[p]
	}
}

func step2_solve_poisson(currentTime float64) {
	var rho xvector
	for p := 0; p < N_G; p++ {
		rho[p] = E_CHARGE * (i_density[p] - e_density[p]) // get charge density
	}
	solvePoisson(&rho, currentTime) // compute potential and electric field
}

func step3_move_electrons(t_index int) {
	var k, p, energy_index int
	var c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate float64

	for k = 0; k < N_e; k++ { // move all electrons in every time step
		c0 = x_e[k] * INV_DX
		p = int(c0)
		c1 = float64(p) + 1.0 - c0
		c2 = c0 - float64(p)
		e_x = c1*efield[p] + c2*efield[p+1]

		if measurement_mode {
			// measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
			mean_v = vx_e[k] - 0.5*e_x*FACTOR_E
			counter_e_xt[p][t_index] += c1
			counter_e_xt[p+1][t_index] += c2
			ue_xt[p][t_index] += c1 * mean_v
			ue_xt[p+1][t_index] += c2 * mean_v
			v_sqr = mean_v*mean_v + vy_e[k]*vy_e[k] + vz_e[k]*vz_e[k]
			energy = 0.5 * E_MASS * v_sqr / EV_TO_J
			meanee_xt[p][t_index] += c1 * energy
			meanee_xt[p+1][t_index] += c2 * energy
			energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
			velocity = math.Sqrt(v_sqr)
			rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
			ioniz_rate_xt[p][t_index] += c1 * rate
			ioniz_rate_xt[p+1][t_index] += c2 * rate

			// measure EEPF in the center
			if (MIN_X < x_e[k]) && (x_e[k] < MAX_X) {
				energy_index = int(energy / DE_EEPF)
				if energy_index < N_EEPF {
					eepf[energy_index] += 1.0
				}
				mean_energy_accu_center += energy
				mean_energy_counter_center++
			}
		}

		// update velocity and position
		vx_e[k] -= e_x * FACTOR_E
		x_e[k] += vx_e[k] * DT_E
	}
}

func step4_move_ions(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, p int
	var c0, c1, c2, e_x, mean_v, v_sqr, energy float64

	for k = 0; k < N_i; k++ {
		c0 = x_i[k] * INV_DX
		p = int(c0)
		c1 = float64(p) + 1.0 - c0
		c2 = c0 - float64(p)
		e_x = c1*efield[p] + c2*efield[p+1]

		if measurement_mode {
			// measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
			mean_v = vx_i[k] + 0.5*e_x*FACTOR_I
			counter_i_xt[p][t_index] += c1
			counter_i_xt[p+1][t_index] += c2
			ui_xt[p][t_index] += c1 * mean_v
			ui_xt[p+1][t_index] += c2 * mean_v
			v_sqr = mean_v*mean_v + vy_i[k]*vy_i[k] + vz_i[k]*vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			meanei_xt[p][t_index] += c1 * energy
			meanei_xt[p+1][t_index] += c2 * energy
		}

		// update velocity and position and accumulate absorbed energy
		vx_i[k] += e_x * FACTOR_I
		x_i[k] += vx_i[k] * DT_I
	}
}

func step5_check_boundaries_electrons() {
	var k int = 0
	var out bool
	for k < N_e { // check boundaries for all electrons in every time step
		out = false
		if x_e[k] < 0 {
			N_e_abs_pow++ // the electron is out at the powered electrode
			out = true
		}
		if x_e[k] > L {
			N_e_abs_gnd++ // the electron is out at the grounded electrode
			out = true
		}
		if out { // remove the electron, if out
			x_e[k] = x_e[N_e-1]
			vx_e[k] = vx_e[N_e-1]
			vy_e[k] = vy_e[N_e-1]
			vz_e[k] = vz_e[N_e-1]
			N_e--
		} else {
			k++
		}
	}
}

func step6_check_boundaries_ions(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, energy_index int
	var out bool
	var v_sqr, energy float64

	k = 0
	for k < N_i {
		out = false
		if x_i[k] < 0 { // the ion is out at the powered electrode
			N_i_abs_pow++
			out = true
			v_sqr = vx_i[k]*vx_i[k] + vy_i[k]*vy_i[k] + vz_i[k]*vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			energy_index = int(energy / DE_IFED)
			if energy_index < N_IFED {
				ifed_pow[energy_index]++ // save IFED at the powered electrode
			}
		}
		if x_i[k] > L { // the ion is out at the grounded electrode
			N_i_abs_gnd++
			out = true
			v_sqr = vx_i[k]*vx_i[k] + vy_i[k]*vy_i[k] + vz_i[k]*vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			energy_index = int(energy / DE_IFED)
			if energy_index < N_IFED {
				ifed_gnd[energy_index]++ // save IFED at the grounded electrode
			}
		}
		if out { // delete the ion, if out
			x_i[k] = x_i[N_i-1]
			vx_i[k] = vx_i[N_i-1]
			vy_i[k] = vy_i[N_i-1]
			vz_i[k] = vz_i[N_i-1]
			N_i--
		} else {
			k++
		}
	}
}

func step7_collisions_electrons() {
	var k, energy_index int
	var v_sqr, velocity, energy, nu, p_coll float64

	for k = 0; k < N_e; k++ { // checking for occurrence of a collision for all electrons in every time step
		v_sqr = vx_e[k]*vx_e[k] + vy_e[k]*vy_e[k] + vz_e[k]*vz_e[k]
		velocity = math.Sqrt(v_sqr)
		energy = 0.5 * E_MASS * v_sqr / EV_TO_J
		energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
		nu = sigma_tot_e[energy_index] * velocity
		p_coll = 1 - math.Exp(-nu*DT_E) // collision probability for electrons
		if R01() < p_coll {             // electron collision takes place
			collisionElectron(x_e[k], &vx_e[k], &vy_e[k], &vz_e[k], energy_index)
			N_e_coll++
		}
	}
}

func step8_collision_ions(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, energy_index int
	var vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy, nu, p_coll float64

	for k = 0; k < N_i; k++ {
		vx_a = RMB() // pick velocity components of a random target gas atom
		vy_a = RMB()
		vz_a = RMB()
		gx = vx_i[k] - vx_a // compute the relative velocity of the collision partners
		gy = vy_i[k] - vy_a
		gz = vz_i[k] - vz_a
		g_sqr = gx*gx + gy*gy + gz*gz
		g = math.Sqrt(g_sqr)
		energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J
		energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
		nu = sigma_tot_i[energy_index] * g
		p_coll = 1 - math.Exp(-nu*DT_I) // collision probability for ions
		if R01() < p_coll {             // ion collision takes place
			collisionIon(&vx_i[k], &vy_i[k], &vz_i[k], &vx_a, &vy_a, &vz_a, energy_index)
			N_i_coll++
		}
	}
}

func step9_collect_xt_data(t_index int) {
	if !measurement_mode {
		return
	}

	for p := 0; p < N_G; p++ {
		pot_xt[p][t_index] += pot[p]
		efield_xt[p][t_index] += efield[p]
		ne_xt[p][t_index] += e_density[p]
		ni_xt[p][t_index] += i_density[p]
	}
}

func doOneCycle() {
	var t int
	var t_index int

	for t = 0; t < N_T; t++ { // the RF period is divided into N_T equal time intervals (time step DT_E)
		Time += DT_E        // update of the total simulated time
		t_index = t / N_BIN // index for XT distributions

		step1_compute_electron_density()
		step1_compute_ion_density(t)
		step2_solve_poisson(Time)

		step3_move_electrons(t_index)
		step4_move_ions(t_index, t)

		step5_check_boundaries_electrons()
		step6_check_boundaries_ions(t)

		step7_collisions_electrons()
		step8_collision_ions(t)

		step9_collect_xt_data(t_index)

		if (t % 1000) == 0 {
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", cycle, t, N_e, N_i)
		}
	}
	fmt.Fprintf(datafile, "%8d  %8d  %8d\n", cycle, N_e, N_i)
}

//---------------------------------------------------------------------//
// save particle coordinates                                           //
//---------------------------------------------------------------------//

func saveParticleData() {
	f, err := os.Create("picdata.bin")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	buf := bufio.NewWriter(f)
	defer buf.Flush()

	writeFloat64(buf, Time)
	writeFloat64(buf, float64(cycles_done))
	writeFloat64(buf, float64(N_e))
	writeFloat64Slice(buf, x_e[:N_e])
	writeFloat64Slice(buf, vx_e[:N_e])
	writeFloat64Slice(buf, vy_e[:N_e])
	writeFloat64Slice(buf, vz_e[:N_e])
	writeFloat64(buf, float64(N_i))
	writeFloat64Slice(buf, x_i[:N_i])
	writeFloat64Slice(buf, vx_i[:N_i])
	writeFloat64Slice(buf, vy_i[:N_i])
	writeFloat64Slice(buf, vz_i[:N_i])

	fmt.Printf(">> eduPIC: data saved : %d electrons %d ions, %d cycles completed, time is %e [s]\n", N_e, N_i, cycles_done, Time)
}

//---------------------------------------------------------------------//
// load particle coordinates                                           //
//---------------------------------------------------------------------//

func loadParticleData() {
	f, err := os.Open("picdata.bin")
	if err != nil {
		fmt.Println(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'")
		os.Exit(0)
	}
	defer f.Close()

	buf := bufio.NewReader(f)
	Time = readFloat64(buf)
	cycles_done = int(readFloat64(buf))
	N_e = int(readFloat64(buf))
	readFloat64Slice(buf, x_e[:N_e])
	readFloat64Slice(buf, vx_e[:N_e])
	readFloat64Slice(buf, vy_e[:N_e])
	readFloat64Slice(buf, vz_e[:N_e])
	N_i = int(readFloat64(buf))
	readFloat64Slice(buf, x_i[:N_i])
	readFloat64Slice(buf, vx_i[:N_i])
	readFloat64Slice(buf, vy_i[:N_i])
	readFloat64Slice(buf, vz_i[:N_i])

	fmt.Printf(">> eduPIC: data loaded : %d electrons %d ions, %d cycles completed before, time is %e [s]\n", N_e, N_i, cycles_done, Time)
}

//---------------------------------------------------------------------//
// save density data                                                   //
//---------------------------------------------------------------------//

func saveDensity() {
	f, err := os.Create("density.dat")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	c := 1.0 / float64(no_of_cycles) / float64(N_T)
	for m := 0; m < N_G; m++ {
		fmt.Fprintf(f, "%8.5f  %12e  %12e\n", float64(m)*DX, cumul_e_density[m]*c, cumul_i_density[m]*c)
	}
}

//---------------------------------------------------------------------//
// save EEPF data                                                      //
//---------------------------------------------------------------------//

func saveEEPF() {
	h := 0.0
	for i := 0; i < N_EEPF; i++ {
		h += eepf[i]
	}
	h *= DE_EEPF
	f, err := os.Create("eepf.dat")
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < N_EEPF; i++ {
		energy := (float64(i) + 0.5) * DE_EEPF
		fmt.Fprintf(f, "%e  %e\n", energy, eepf[i]/h/math.Sqrt(energy))
	}
}

//---------------------------------------------------------------------//
// save IFED data                                                      //
//---------------------------------------------------------------------//

func saveIFED() {
	h_pow := 0.0
	h_gnd := 0.0
	for i := 0; i < N_IFED; i++ {
		h_pow += float64(ifed_pow[i])
		h_gnd += float64(ifed_gnd[i])
	}
	h_pow *= DE_IFED
	h_gnd *= DE_IFED
	mean_i_energy_pow = 0.0
	mean_i_energy_gnd = 0.0
	f, err := os.Create("ifed.dat")
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < N_IFED; i++ {
		energy := (float64(i) + 0.5) * DE_IFED
		fmt.Fprintf(f, "%6.2f %10.6f %10.6f\n", energy, float64(ifed_pow[i])/h_pow, float64(ifed_gnd[i])/h_gnd)
		mean_i_energy_pow += energy * float64(ifed_pow[i]) / h_pow
		mean_i_energy_gnd += energy * float64(ifed_gnd[i]) / h_gnd
	}
}

//--------------------------------------------------------------------//
// save XT data                                                       //
//--------------------------------------------------------------------//

func saveXT1(distr xt_distr, fname string) {
	f, err := os.Create(fname)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < N_G; i++ {
		for j := 0; j < N_XT; j++ {
			fmt.Fprintf(f, "%e  ", distr[i][j])
		}
		fmt.Fprint(f, "\n")
	}
}

func normAllXT() {
	var f1, f2 float64

	// normalize all XT data

	f1 = float64(N_XT) / float64(no_of_cycles*N_T)
	f2 = WEIGHT / (ELECTRODE_AREA * DX) / (float64(no_of_cycles) * (PERIOD / float64(N_XT)))

	for i := 0; i < N_G; i++ {
		for j := 0; j < N_XT; j++ {
			pot_xt[i][j] *= f1
			efield_xt[i][j] *= f1
			ne_xt[i][j] *= f1
			ni_xt[i][j] *= f1
			if counter_e_xt[i][j] > 0 {
				ue_xt[i][j] = ue_xt[i][j] / counter_e_xt[i][j]
				je_xt[i][j] = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE
				meanee_xt[i][j] = meanee_xt[i][j] / counter_e_xt[i][j]
				ioniz_rate_xt[i][j] *= f2
			} else {
				ue_xt[i][j] = 0.0
				je_xt[i][j] = 0.0
				meanee_xt[i][j] = 0.0
				ioniz_rate_xt[i][j] = 0.0
			}
			if counter_i_xt[i][j] > 0 {
				ui_xt[i][j] = ui_xt[i][j] / counter_i_xt[i][j]
				ji_xt[i][j] = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE
				meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j]
			} else {
				ui_xt[i][j] = 0.0
				ji_xt[i][j] = 0.0
				meanei_xt[i][j] = 0.0
			}
			powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j]
			poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j]
		}
	}
}

func saveAllXT() {
	saveXT1(pot_xt, "pot_xt.dat")
	saveXT1(efield_xt, "efield_xt.dat")
	saveXT1(ne_xt, "ne_xt.dat")
	saveXT1(ni_xt, "ni_xt.dat")
	saveXT1(je_xt, "je_xt.dat")
	saveXT1(ji_xt, "ji_xt.dat")
	saveXT1(powere_xt, "powere_xt.dat")
	saveXT1(poweri_xt, "poweri_xt.dat")
	saveXT1(meanee_xt, "meanee_xt.dat")
	saveXT1(meanei_xt, "meanei_xt.dat")
	saveXT1(ioniz_rate_xt, "ioniz_xt.dat")
}

//---------------------------------------------------------------------//
// simulation report including stability and accuracy conditions       //
//---------------------------------------------------------------------//

func checkAndSaveInfo() {
	var plas_freq, meane, kT, debye_length, density, ecoll_freq, icoll_freq, sim_time, e_max, v_max, power_e, power_i, c float64
	var conditions_OK bool

	density = cumul_e_density[N_G/2] / float64(no_of_cycles) / float64(N_T) // e density @ center
	plas_freq = E_CHARGE * math.Sqrt(density/EPSILON0/E_MASS)               // e plasma frequency @ center
	meane = mean_energy_accu_center / float64(mean_energy_counter_center)   // e mean energy @ center
	kT = 2.0 * meane * EV_TO_J / 3.0                                        // k T_e @ center (approximate)
	sim_time = float64(no_of_cycles) / FREQUENCY                            // simulated time
	ecoll_freq = float64(N_e_coll) / sim_time / float64(N_e)                // e collision frequency
	icoll_freq = float64(N_i_coll) / sim_time / float64(N_i)                // ion collision frequency
	debye_length = math.Sqrt(EPSILON0*kT/density) / E_CHARGE                // e Debye length @ center

	f, err := os.Create("info.txt")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	fmt.Fprintln(f, "########################## eduPIC simulation report ############################")
	fmt.Fprintln(f, "Simulation parameters:")
	fmt.Fprintf(f, "Gap distance                          = %12.3e [m]\n", L)
	fmt.Fprintf(f, "# of grid divisions                   = %12d\n", N_G)
	fmt.Fprintf(f, "Frequency                             = %12.3e [Hz]\n", FREQUENCY)
	fmt.Fprintf(f, "# of time steps / period              = %12d\n", N_T)
	fmt.Fprintf(f, "# of electron / ion time steps        = %12d\n", N_SUB)
	fmt.Fprintf(f, "Voltage amplitude                     = %12.3e [V]\n", VOLTAGE)
	fmt.Fprintf(f, "Pressure (Ar)                         = %12.3e [Pa]\n", PRESSURE)
	fmt.Fprintf(f, "Temperature                           = %12.3e [K]\n", TEMPERATURE)
	fmt.Fprintf(f, "Superparticle weight                  = %12.3e\n", WEIGHT)
	fmt.Fprintf(f, "# of simulation cycles in this run    = %12d\n", no_of_cycles)
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")
	fmt.Fprintln(f, "Plasma characteristics:")
	fmt.Fprintf(f, "Electron density @ center             = %12.3e [m^{-3}]\n", density)
	fmt.Fprintf(f, "Plasma frequency @ center             = %12.3e [rad/s]\n", plas_freq)
	fmt.Fprintf(f, "Debye length @ center                 = %12.3e [m]\n", debye_length)
	fmt.Fprintf(f, "Electron collision frequency          = %12.3e [1/s]\n", ecoll_freq)
	fmt.Fprintf(f, "Ion collision frequency               = %12.3e [1/s]\n", icoll_freq)
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")
	fmt.Fprintln(f, "Stability and accuracy conditions:")
	conditions_OK = true
	c = plas_freq * DT_E
	fmt.Fprintf(f, "Plasma frequency @ center * DT_E      = %12.3f (OK if less than 0.20)\n", c)
	if c > 0.2 {
		conditions_OK = false
	}
	c = DX / debye_length
	fmt.Fprintf(f, "DX / Debye length @ center            = %12.3f (OK if less than 1.00)\n", c)
	if c > 1.0 {
		conditions_OK = false
	}
	c = maxElectronCollFreq() * DT_E
	fmt.Fprintf(f, "Max. electron coll. frequency * DT_E  = %12.3f (OK if less than 0.05)\n", c)
	if c > 0.05 {
		conditions_OK = false
	}
	c = maxIonCollFreq() * DT_I
	fmt.Fprintf(f, "Max. ion coll. frequency * DT_I       = %12.3f (OK if less than 0.05)\n", c)
	if c > 0.05 {
		conditions_OK = false
	}
	if !conditions_OK {
		fmt.Fprintln(f, "--------------------------------------------------------------------------------")
		fmt.Fprintln(f, "** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **")
		fmt.Fprintln(f, "--------------------------------------------------------------------------------")
		fmt.Println(">> eduPIC: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!")
		fmt.Println(">> eduPIC: for details see 'info.txt' and refine simulation settings!")
		return
	}

	// calculate maximum energy for which the Courant-Friedrichs-Levy condition holds:

	v_max = DX / DT_E
	e_max = 0.5 * E_MASS * v_max * v_max / EV_TO_J
	fmt.Fprintf(f, "Max e- energy for CFL condition       = %12.3f [eV]\n", e_max)
	fmt.Fprintln(f, "Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!")
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")

	// saving of the following data is done here as some of the further lines need data
	// that are computed / normalized in these functions

	fmt.Println(">> eduPIC: saving diagnostics data")
	saveDensity()
	saveEEPF()
	saveIFED()
	normAllXT()
	saveAllXT()
	fmt.Fprintln(f, "Particle characteristics at the electrodes:")
	fmt.Fprintf(f, "Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", float64(N_i_abs_pow)*WEIGHT/ELECTRODE_AREA/(float64(no_of_cycles)*PERIOD))
	fmt.Fprintf(f, "Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", float64(N_i_abs_gnd)*WEIGHT/ELECTRODE_AREA/(float64(no_of_cycles)*PERIOD))
	fmt.Fprintf(f, "Mean ion energy at powered electrode  = %12.3e [eV]\n", mean_i_energy_pow)
	fmt.Fprintf(f, "Mean ion energy at grounded electrode = %12.3e [eV]\n", mean_i_energy_gnd)
	fmt.Fprintf(f, "Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", float64(N_e_abs_pow)*WEIGHT/ELECTRODE_AREA/(float64(no_of_cycles)*PERIOD))
	fmt.Fprintf(f, "Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", float64(N_e_abs_gnd)*WEIGHT/ELECTRODE_AREA/(float64(no_of_cycles)*PERIOD))
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")

	// calculate spatially and temporally averaged power absorption by the electrons and ions

	power_e = 0.0
	power_i = 0.0
	for i := 0; i < N_G; i++ {
		for j := 0; j < N_XT; j++ {
			power_e += powere_xt[i][j]
			power_i += poweri_xt[i][j]
		}
	}
	power_e /= float64(N_XT * N_G)
	power_i /= float64(N_XT * N_G)
	fmt.Fprintln(f, "Absorbed power calculated as <j*E>:")
	fmt.Fprintf(f, "Electron power density (average)      = %12.3e [W m^{-3}]\n", power_e)
	fmt.Fprintf(f, "Ion power density (average)           = %12.3e [W m^{-3}]\n", power_i)
	fmt.Fprintf(f, "Total power density(average)          = %12.3e [W m^{-3}]\n", power_e+power_i)
	fmt.Fprintln(f, "--------------------------------------------------------------------------------")
}

//------------------------------------------------------------------------------------------//
// main                                                                                     //
// command line arguments:                                                                  //
// [1]: number of cycles (0 for init)                                                       //
// [2]: "m" turns on data collection and saving                                             //
//------------------------------------------------------------------------------------------//

func main() {
	fmt.Println(">> GoPIC: starting...")

	if len(os.Args) == 1 {
		fmt.Println(">> GoPIC: error = need starting_cycle argument")
		os.Exit(1)
	}

	st0 = os.Args[1]
	arg1 = atoi(st0)

	if len(os.Args) > 2 {
		if strings.TrimSpace(os.Args[2]) == "m" {
			measurement_mode = true // measurements will be done
		} else {
			measurement_mode = false
		}
	}
	if measurement_mode {
		fmt.Println(">> GoPIC: measurement mode: on")
	} else {
		fmt.Println(">> GoPIC: measurement mode: off")
	}

	setElectronCrossSectionsAr()
	setIonCrossSectionsAr()
	calcTotalCrossSections()
	//testCrossSections(); return

	datafile = openAppend("conv.dat")
	defer datafile.Close()

	if arg1 == 0 {
		if fileExists("picdata.bin") {
			fmt.Println(">> GoPIC: Warning: Data from previous calculation are detected.")
			fmt.Println("           To start a new simulation from the beginning, please delete all output files before running ./GoPIC 0")
			fmt.Println("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./GoPIC 100")
			os.Exit(0)
		}
		no_of_cycles = 1
		cycle = 1             // init cycle
		initParticles(N_INIT) // seed initial electrons & ions
		fmt.Println(">> GoPIC: running initializing cycle")
		Time = 0
		doOneCycle()
		cycles_done = 1
	} else {
		no_of_cycles = arg1 // run number of cycles specified in command line
		loadParticleData()  // read previous configuration from file
		fmt.Printf(">> GoPIC: running %d cycle(s)\n", no_of_cycles)
		for cycle = cycles_done + 1; cycle <= cycles_done+no_of_cycles; cycle++ {
			doOneCycle()
		}
		cycles_done += no_of_cycles
	}
	saveParticleData()
	if measurement_mode {
		checkAndSaveInfo()
	}
	fmt.Printf(">> GoPIC: simulation of %d cycle(s) is completed.\n", no_of_cycles)
}

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}

// Takes string, trims whitespaces and casts to int
func atoi(s string) int {
	i, _ := strconv.Atoi(strings.TrimSpace(s))
	return i
}

// Opens file for appending (creates if doesn't exist)
func openAppend(name string) *os.File {
	f, err := os.OpenFile(name, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		panic(err)
	}
	return f
}

// Checks if file exist
func fileExists(name string) bool {
	_, err := os.Stat(name)
	return err == nil
}

// save single float64 value to buffer in little-endian format
func writeFloat64(w *bufio.Writer, v float64) {
	if err := binary.Write(w, binary.LittleEndian, v); err != nil {
		panic(err)
	}
}

// save array/slice to buffer
func writeFloat64Slice(w *bufio.Writer, v []float64) {
	for _, x := range v {
		writeFloat64(w, x)
	}
}

// read float64 from buffer
func readFloat64(r *bufio.Reader) float64 {
	var v float64
	if err := binary.Read(r, binary.LittleEndian, &v); err != nil {
		panic(err)
	}
	return v
}

// read array/slice from buffer
func readFloat64Slice(r *bufio.Reader, v []float64) {
	for i := range v {
		v[i] = readFloat64(r)
	}
}
