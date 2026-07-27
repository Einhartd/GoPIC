package tests

import (
	"testing"

	"gopic"
)

func TestPhelpsCrossSections(t *testing.T) {
	sim := gopic.NewSimulationState(42)

	sim.SetElectronCrossSectionsAr()
	sim.SetIonCrossSectionsAr()
	sim.CalcTotalCrossSections()

	idx_50 := int(50.0 / gopic.DE_CS)
	total_macro := (sim.Sigma[gopic.E_ELA][idx_50] + sim.Sigma[gopic.E_EXC][idx_50] + sim.Sigma[gopic.E_ION][idx_50]) * gopic.GAS_DENSITY

	if !isClose(sim.SigmaTotE[idx_50], total_macro, 1e-7) {
		t.Errorf("Oczekiwano makroskopowego przekroju czynnego %f dla energii 50 eV, otrzymano %f", total_macro, sim.SigmaTotE[idx_50])
	}
}
