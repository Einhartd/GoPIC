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
	_             [4]uint64 // 32-bajtowy padding zapobiegający False Sharing
}

type ionWorkerDiagnostics struct {
	counter_i [N_G]float64
	ui        [N_G]float64
	meanei    [N_G]float64
	abs_pow   uint64
	abs_gnd   uint64
	ifed_pow  [N_IFED]int
	ifed_gnd  [N_IFED]int
	_         [6]uint64 // 48-bajtowy padding zapobiegający False Sharing
}

type CreatedParticle struct {
	X  float64
	Vx float64
	Vy float64
	Vz float64
}

var (
	RMB_sigma = math.Sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)
)

type SimulationState struct {
	WorkerEDensity []Xvector
	WorkerIDensity []Xvector

	WorkerEDiag []electronWorkerDiagnostics
	WorkerIDiag []ionWorkerDiagnostics

	WorkerDeadElectrons [][]int
	WorkerDeadIons      [][]int

	WorkerNewElectrons [][]CreatedParticle
	WorkerNewIons      [][]CreatedParticle

	Sigma     [N_CS]CrossSection
	SigmaTotE CrossSection
	SigmaTotI CrossSection

	N_e                   int
	N_i                   int
	X_e, Vx_e, Vy_e, Vz_e ParticleVector
	X_i, Vx_i, Vy_i, Vz_i ParticleVector

	Efield, Pot                      Xvector
	E_density, I_density             Xvector
	Cumul_e_density, Cumul_i_density Xvector
	ThomasW                          Xvector

	N_e_abs_pow uint64
	N_e_abs_gnd uint64
	N_i_abs_pow uint64
	N_i_abs_gnd uint64

	Eepf EepfVector

	Ifed_pow          IfedVector
	Ifed_gnd          IfedVector
	Mean_i_energy_pow float64
	Mean_i_energy_gnd float64

	Pot_xt        XtDistr
	Efield_xt     XtDistr
	Ne_xt         XtDistr
	Ni_xt         XtDistr
	Ue_xt         XtDistr
	Ui_xt         XtDistr
	Je_xt         XtDistr
	Ji_xt         XtDistr
	Powere_xt     XtDistr
	Poweri_xt     XtDistr
	Meanee_xt     XtDistr
	Meanei_xt     XtDistr
	Counter_e_xt  XtDistr
	Counter_i_xt  XtDistr
	Ioniz_rate_xt XtDistr

	Mean_energy_accu_center    float64
	Mean_energy_counter_center uint64
	N_e_coll                   uint64
	N_i_coll                   uint64
	Time                       float64
	Cycle                      int
	No_of_cycles               int
	Cycles_done                int
	Arg1                       int
	St0                        string
	Datafile                   *os.File
	Measurement_mode           bool

	RngWorkers   []*rand.Rand
	MtSrcWorkers []*mt19937.MT19937
	Rng          *rand.Rand
	MtSrc        *mt19937.MT19937

	NuStarE float64
	PStarE  float64
	NuStarI float64
	PStarI  float64

	NumWorkers int
	Barrier    *StarBarrier

	// Prekomputowane rozmiary chunków (eliminacja IDIVQ z pętli workerów)
	EChunkSize int
	IChunkSize int
}

func NewSimulationState(seed int64, optNumWorkers ...int) *SimulationState {
	src := mt19937.New()
	src.Seed(seed)

	numWorkers := 0
	if len(optNumWorkers) > 0 {
		numWorkers = optNumWorkers[0]
	}
	if numWorkers <= 0 {
		numWorkers = runtime.GOMAXPROCS(0)
	}

	workers := make([]*rand.Rand, numWorkers)
	wSrcs := make([]*mt19937.MT19937, numWorkers)

	for i := range numWorkers {
		wSrc := mt19937.New()
		wSrc.Seed(seed + int64(i)*10007 + 1)
		wSrcs[i] = wSrc
		workers[i] = rand.New(wSrc)
	}

	newElectrons := make([][]CreatedParticle, numWorkers)
	newIons := make([][]CreatedParticle, numWorkers)
	deadElectrons := make([][]int, numWorkers)
	deadIons := make([][]int, numWorkers)
	for i := range numWorkers {
		newElectrons[i] = make([]CreatedParticle, 0, 4096)
		newIons[i] = make([]CreatedParticle, 0, 4096)
		deadElectrons[i] = make([]int, 0, 1024)
		deadIons[i] = make([]int, 0, 1024)
	}

	var thomasW Xvector
	thomasW[1] = C / B
	for i := 2; i <= N_G-2; i++ {
		thomasW[i] = C / (B - A*thomasW[i-1])
	}

	sim := &SimulationState{
		NumWorkers:          numWorkers,
		WorkerEDensity:      make([]Xvector, numWorkers),
		WorkerIDensity:      make([]Xvector, numWorkers),
		WorkerEDiag:         make([]electronWorkerDiagnostics, numWorkers),
		WorkerIDiag:         make([]ionWorkerDiagnostics, numWorkers),
		WorkerDeadElectrons: deadElectrons,
		WorkerDeadIons:      deadIons,
		WorkerNewElectrons:  newElectrons,
		WorkerNewIons:       newIons,
		ThomasW:             thomasW,

		Barrier: NewStarBarrier(numWorkers),

		RngWorkers:   workers,
		MtSrcWorkers: wSrcs,
		Rng:          rand.New(src),
		MtSrc:        src,
	}

	sim.UpdateChunkSizes()
	sim.InitWorkers()

	return sim
}

/*
UpdateChunkSizes wyznacza rozmiary podzbiorów cząstek dla workerów.
Wywoływane tylko w momencie zmiany N_e lub N_i (kompaktacja, zderzenia),
dzięki czemu workery nie muszą wykonywać instrukcji dzielenia IDIVQ w podkrokach.
*/
func (sim *SimulationState) UpdateChunkSizes() {
	if sim.NumWorkers > 0 {
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
		sim.IChunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
	}
}

func (sim *SimulationState) R01() float64 {
	return sim.Rng.Float64()
}

func (sim *SimulationState) RMB() float64 {
	return sim.Rng.NormFloat64() * RMB_sigma
}

func (sim *SimulationState) WorkerR01(workerID int) float64 {
	return sim.RngWorkers[workerID].Float64()
}

func (sim *SimulationState) WorkerRMB(workerID int) float64 {
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
}
