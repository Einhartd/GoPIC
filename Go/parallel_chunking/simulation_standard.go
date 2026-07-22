//go:build !nullcollision

package gopic

import (
	"math"
)

// InitNullCollision does nothing in standard mode.
func (sim *SimulationState) InitNullCollision() {
	// No initialization needed for standard collisions
}

func (sim *SimulationState) Step7CollisionsElectrons() {
	var k, energy_index int
	var v_sqr, velocity, energy, nu, p_coll float64

	for k = 0; k < sim.N_e; k++ { // checking for occurrence of a collision for all electrons in every time step
		v_sqr = sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
		velocity = math.Sqrt(v_sqr)
		energy = 0.5 * E_MASS * v_sqr / EV_TO_J
		energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
		nu = sim.SigmaTotE[energy_index] * velocity
		p_coll = 1 - math.Exp(-nu*DT_E) // collision probability for electrons
		if sim.R01() < p_coll {         // electron collision takes place
			sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], energy_index)
			sim.N_e_coll++
		}
	}
}

func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, energy_index int
	var vx_a, vy_a, vz_a, gx, gy, gz, g_sqr, g, energy, nu, p_coll float64

	for k = 0; k < sim.N_i; k++ {
		vx_a = sim.RMB() // pick velocity components of a random target gas atom
		vy_a = sim.RMB()
		vz_a = sim.RMB()
		gx = sim.Vx_i[k] - vx_a // compute the relative velocity of the collision partners
		gy = sim.Vy_i[k] - vy_a
		gz = sim.Vz_i[k] - vz_a
		g_sqr = gx*gx + gy*gy + gz*gz
		g = math.Sqrt(g_sqr)
		energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J
		energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
		nu = sim.SigmaTotI[energy_index] * g
		p_coll = 1 - math.Exp(-nu*DT_I) // collision probability for ions
		if sim.R01() < p_coll {         // ion collision takes place
			sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vx_a, &vy_a, &vz_a, energy_index)
			sim.N_i_coll++
		}
	}
}
