package tests

import (
	"math"
	"testing"

	"gopic"
)

func TestNullCollisionPrecomputation(t *testing.T) {
	sim := gopic.NewSimulationState(42)

	sim.SetElectronCrossSectionsAr()
	sim.SetIonCrossSectionsAr()
	sim.CalcTotalCrossSections()

	sim.InitNullCollision()

	// Jeśli kompilacja nie ma tagu nullcollision, InitNullCollision() jest pusta, a NuStarE wynosi 0.
	if sim.NuStarE == 0.0 {
		t.Skip("Pomiń: Null-collision nie jest aktywne w tym buildu (uruchom z flagą -tags nullcollision)")
	}

	// 1. Sprawdzamy, czy maksymalne częstości są dodatnie
	if sim.NuStarE <= 0.0 {
		t.Errorf("Oczekiwano NuStarE > 0, otrzymano %e", sim.NuStarE)
	}
	if sim.NuStarI <= 0.0 {
		t.Errorf("Oczekiwano NuStarI > 0, otrzymano %e", sim.NuStarI)
	}

	// 2. Sprawdzamy, czy prawdopodobieństwa są w zakresie [0, 1]
	if sim.PStarE < 0.0 || sim.PStarE > 1.0 {
		t.Errorf("Oczekiwano PStarE w [0, 1], otrzymano %e", sim.PStarE)
	}
	if sim.PStarI < 0.0 || sim.PStarI > 1.0 {
		t.Errorf("Oczekiwano PStarI w [0, 1], otrzymano %e", sim.PStarI)
	}

	// 3. Sprawdzamy warunek stabilności fizycznej (prawdopodobieństwo < 5%)
	if sim.PStarE >= 0.05 {
		t.Errorf("Oczekiwano PStarE < 0.05 (stabilność), otrzymano %e", sim.PStarE)
	}
	if sim.PStarI >= 0.05 {
		t.Errorf("Oczekiwano PStarI < 0.05 (stabilność), otrzymano %e", sim.PStarI)
	}

	// 4. Weryfikujemy, czy NuStarE jest rzeczywiście maksymalną częstością elektronów
	for i := 0; i < gopic.CS_RANGES; i++ {
		var e float64
		if i == 0 {
			e = gopic.DE_CS
		} else {
			e = float64(i) * gopic.DE_CS
		}
		v := math.Sqrt(2.0 * e * gopic.EV_TO_J / gopic.E_MASS)
		nu := sim.SigmaTotE[i] * v
		if nu > sim.NuStarE+1e-9 {
			t.Errorf("Dla indeksu %d (energia %f eV) nu (%e) przekracza NuStarE (%e)", i, e, nu, sim.NuStarE)
		}
	}

	// 5. Weryfikujemy, czy NuStarI jest rzeczywiście maksymalną częstością jonów
	for i := 0; i < gopic.CS_RANGES; i++ {
		var e float64
		if i == 0 {
			e = gopic.DE_CS
		} else {
			e = float64(i) * gopic.DE_CS
		}
		g := math.Sqrt(2.0 * e * gopic.EV_TO_J / gopic.MU_ARAR)
		nu := sim.SigmaTotI[i] * g
		if nu > sim.NuStarI+1e-9 {
			t.Errorf("Dla indeksu %d (energia %f eV) nu (%e) przekracza NuStarI (%e)", i, e, nu, sim.NuStarI)
		}
	}
}
