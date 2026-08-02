package gopic

import (
	"math"
	"math/rand"
	"os"
	"runtime"

	"github.com/seehuhn/mt19937"
)

type electronWorkerDiagnostics struct {
	counter_e     [N_G]float64
	ue            [N_G]float64
	meanee        [N_G]float64
	ioniz         [N_G]float64
	eepf          [N_EEPF]float64
	accuCenter    float64
	counterCenter uint64
	abs_pow       uint64
	abs_gnd       uint64
}

type ionWorkerDiagnostics struct {
	counter_i [N_G]float64
	ui        [N_G]float64
	meanei    [N_G]float64
	abs_pow   uint64
	abs_gnd   uint64
	ifed_pow  [N_IFED]int
	ifed_gnd  [N_IFED]int
}

// CreatedParticle represents a single newly generated particle in AoS layout.
// AoS is chosen for temporary thread-local worker buffers during collisions because:
// 1. Spatial Locality: Writing X, Vx, Vy, Vz (32 bytes) sequentially to a single slice fits in 1 L1 cache line (64B).
// 2. Go Runtime Efficiency: Maintains 1 slice header per worker instead of 4 separate slice allocations & capacity checks.
// 3. Low Flush Cost: Merging small buffers (~20-50 particles/step) into main SoA arrays takes sub-nanosecond time.
type CreatedParticle struct {
	X  float64
	Vx float64
	Vy float64
	Vz float64
}

var (
	RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS) // RMB_sigma is the standard deviation for the Maxwell-Boltzmann velocity distribution.
)

type SimulationState struct {

	//	Step1ComputeElectronDensity()
	WorkerEDensity []Xvector
	//	Step1ComputeIonDensity()
	WorkerIDensity []Xvector
	//	Step3MoveElectrons()
	WorkerEDiag []electronWorkerDiagnostics
	//	Step4MoveIons()
	WorkerIDiag []ionWorkerDiagnostics

	// Boundary absorption flag buffers (2-phase boundary checking)
	AbsorbedE []uint8
	AbsorbedI []uint8

	// Collisions worker buffers for new particles (AoS per worker)
	WorkerNewElectrons [][]CreatedParticle
	WorkerNewIons      [][]CreatedParticle

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

	// List of rng instances for workers
	RngWorkers []*rand.Rand
	// RNG instance used before deploying workers
	Rng *rand.Rand
	// Underlying mt19937 source for state serialization
	MtSrc *mt19937.MT19937

	// Null-collision precomputed parameters
	NuStarE float64
	PStarE  float64
	NuStarI float64
	PStarI  float64

	// fields for comm channels
	// slice kanalow po jednym na workera, koordynator wysyla nim polecenia
	WorkerCmdChan []chan WorkerCommand
	// zbiorczy kanal do sygnalizowania konca pracy
	WorkerDoneChan chan int

	CandidatesE []int
	CandidatesI []int

	// Pre-allocated pool for random sampling without GC allocations
	CandidatePool []int
}

// NewSimulationState creates and initializes a SimulationState with mt19937 RNG.
func NewSimulationState(seed int64) *SimulationState {
	src := mt19937.New()
	src.Seed(seed)

	numWorkers := runtime.GOMAXPROCS(0)
	workers := make([]*rand.Rand, numWorkers)

	for i := range numWorkers {
		wSrc := mt19937.New()
		wSrc.Seed(seed + int64(i)*10007 + 1)
		workers[i] = rand.New(wSrc)
	}

	sim := &SimulationState{
		WorkerEDensity:     make([]Xvector, numWorkers),
		WorkerIDensity:     make([]Xvector, numWorkers),
		WorkerEDiag:        make([]electronWorkerDiagnostics, numWorkers),
		WorkerIDiag:        make([]ionWorkerDiagnostics, numWorkers),
		AbsorbedE:          make([]uint8, MAX_N_P),
		AbsorbedI:          make([]uint8, MAX_N_P),
		WorkerNewElectrons: make([][]CreatedParticle, numWorkers),
		WorkerNewIons:      make([][]CreatedParticle, numWorkers),
		CandidatePool:      make([]int, MAX_N_P),

		WorkerCmdChan:  make([]chan WorkerCommand, numWorkers),
		WorkerDoneChan: make(chan int, numWorkers),

		RngWorkers: workers,
		Rng:        rand.New(src),
		MtSrc:      src,
	}

	for i := range numWorkers {
		sim.WorkerCmdChan[i] = make(chan WorkerCommand, 1)
	}

	sim.InitWorkers()

	return sim
}

// Commands for workers
const (
	CmdComputeEDensity = iota
	CmdComputeIDensity
	CmdMoveElectrons
	CmdMoveIons
	CmdCheckBoundariesE
	CmdCheckBoundariesI
	CmdCollisionsE
	CmdCollisionsI
	CmdStop
)

// R01 returns a uniform random number in [0,1) for this state.
func (sim *SimulationState) R01() float64 {
	return sim.Rng.Float64()
}

// RMB returns a normal random number with mean 0 and stddev RMB_sigma for this state.
func (sim *SimulationState) RMB() float64 {
	return sim.Rng.NormFloat64() * RMB_sigma
}

// WorkerR01 returns a uniform random number in [0,1) for a specific worker.
func (sim *SimulationState) WorkerR01(workerID int) float64 {
	return sim.RngWorkers[workerID].Float64()
}

// WorkerRMB returns a normal random number with mean 0 and stddev RMB_sigma for a specific worker.
func (sim *SimulationState) WorkerRMB(workerID int) float64 {
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
}
