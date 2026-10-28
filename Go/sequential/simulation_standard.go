//go:build !nullcollision

package gopic

import (
	"math"
)

// InitNullCollision jest pustą metodą w standardowym trybie zderzeniowym (bez flagi nullcollision),
// zachowaną w celu zapewnienia jednolitego interfejsu inicjalizacji.
func (sim *SimulationState) InitNullCollision() {
}

// Step7CollisionsElectrons realizuje zderzenia elektronów metodą bezpośredniego losowania
// prawdopodobieństwa P = 1 - exp(-nu * DT_E) osobno dla każdego elektronu w tablicy.
func (sim *SimulationState) Step7CollisionsElectrons() {
	var k, energy_index int
	var v_sqr, velocity, energy, nu, p_coll float64

	// Sprawdzenie wystąpienia zderzenia dla każdego aktywnego elektronu
	for k = 0; k < sim.N_e; k++ {
		v_sqr = sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
		velocity = math.Sqrt(v_sqr)
		energy = 0.5 * E_MASS * v_sqr / EV_TO_J
		energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
		nu = sim.SigmaTotE[energy_index] * velocity
		p_coll = 1 - math.Exp(-nu*DT_E)
		if sim.R01() < p_coll {
			sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], energy_index)
			sim.N_e_coll++
		}
	}
}

// Step8CollisionIons realizuje zderzenia jonów z atomami gazu tła co N_SUB kroków czasowych
// metodą bezpośredniego losowania prawdopodobieństwa P = 1 - exp(-nu * DT_I) dla każdego jonu.
//
// Parametry:
//   - t: indeks bieżącego podkroku czasowego w okresie RF (0 .. N_T-1).
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, energy_index int
	var vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy, nu, p_coll float64

	// Sprawdzenie wystąpienia zderzenia dla każdego aktywnego jonu
	for k = 0; k < sim.N_i; k++ {
		// Losowanie prędkości termicznej neutralnego atomu argonu z rozkładu Maxwella-Boltzmanna
		vx_a = sim.RMB()
		vy_a = sim.RMB()
		vz_a = sim.RMB()
		// Wyznaczenie prędkości względnej układu jon-atom przed zderzeniem
		gx = sim.Vx_i[k] - vx_a
		gy = sim.Vy_i[k] - vy_a
		gz = sim.Vz_i[k] - vz_a
		g_sqr = gx*gx + gy*gy + gz*gz
		g = math.Sqrt(g_sqr)
		energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J
		energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
		nu = sim.SigmaTotI[energy_index] * g
		p_coll = 1 - math.Exp(-nu*DT_I)
		if sim.R01() < p_coll {
			sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vx_a, &vy_a, &vz_a, energy_index)
			sim.N_i_coll++
		}
	}
}
