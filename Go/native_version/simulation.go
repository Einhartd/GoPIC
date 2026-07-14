package gopic

import (
	"fmt"
	"math"
)

//----------------------------------------------------------------------//
// initialization of the simulation by placing a given number of        //
// electrons and ions at random positions between the electrodes        //
//----------------------------------------------------------------------//

func (sim *SimulationState) InitParticles(nseed int) {
	for i := 0; i < nseed; i++ {
		sim.X_e[i] = L * sim.R01() // initial random position of the electron
		sim.Vx_e[i] = 0
		sim.Vy_e[i] = 0
		sim.Vz_e[i] = 0            // initial velocity components of the electron
		sim.X_i[i] = L * sim.R01() // initial random position of the ion
		sim.Vx_i[i] = 0
		sim.Vy_i[i] = 0
		sim.Vz_i[i] = 0 // initial velocity components of the ion
	}
	sim.N_e = nseed // initial number of electrons
	sim.N_i = nseed // initial number of ions
}

//---------------------------------------------------------------------//
// simulation of one radiofrequency cycle                              //
//---------------------------------------------------------------------//

func (sim *SimulationState) Step1ComputeElectronDensity() {
	var k, p int
	var c0 float64

	for p = 0; p < N_G; p++ {
		sim.E_density[p] = 0 // electron density - computed in every time step
	}
	for k = 0; k < sim.N_e; k++ {
		c0 = sim.X_e[k] * INV_DX
		p = int(c0)
		sim.E_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
		sim.E_density[p+1] += (c0 - float64(p)) * FACTOR_W
	}
	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p = 0; p < N_G; p++ {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	var k, p int
	var c0 float64

	if (t % N_SUB) == 0 { // ion density - computed in every N_SUB-th time steps (subcycling)
		for p = 0; p < N_G; p++ {
			sim.I_density[p] = 0
		}
		for k = 0; k < sim.N_i; k++ {
			c0 = sim.X_i[k] * INV_DX
			p = int(c0)
			sim.I_density[p] += (float64(p) + 1.0 - c0) * FACTOR_W
			sim.I_density[p+1] += (c0 - float64(p)) * FACTOR_W
		}
		sim.I_density[0] *= 2.0
		sim.I_density[N_G-1] *= 2.0
	}
	for p = 0; p < N_G; p++ {
		sim.Cumul_i_density[p] += sim.I_density[p]
	}
}

func (sim *SimulationState) Step2SolvePoisson(currentTime float64) {
	var rho Xvector
	for p := 0; p < N_G; p++ {
		rho[p] = E_CHARGE * (sim.I_density[p] - sim.E_density[p]) // get charge density
	}
	sim.SolvePoisson(&rho, currentTime) // compute potential and electric field
}

func (sim *SimulationState) Step3MoveElectrons(t_index int) {
	var k, p, energy_index int
	var c0, c1, c2, e_x, mean_v, v_sqr, energy, velocity, rate float64

	for k = 0; k < sim.N_e; k++ { // move all electrons in every time step
		c0 = sim.X_e[k] * INV_DX
		p = int(c0)
		c1 = float64(p) + 1.0 - c0
		c2 = c0 - float64(p)
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

		if sim.Measurement_mode {
			// measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
			mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
			sim.Counter_e_xt[p][t_index] += c1
			sim.Counter_e_xt[p+1][t_index] += c2
			sim.Ue_xt[p][t_index] += c1 * mean_v
			sim.Ue_xt[p+1][t_index] += c2 * mean_v
			v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
			energy = 0.5 * E_MASS * v_sqr / EV_TO_J
			sim.Meanee_xt[p][t_index] += c1 * energy
			sim.Meanee_xt[p+1][t_index] += c2 * energy
			energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
			velocity = math.Sqrt(v_sqr)
			rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
			sim.Ioniz_rate_xt[p][t_index] += c1 * rate
			sim.Ioniz_rate_xt[p+1][t_index] += c2 * rate

			// measure EEPF in the center
			if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
				energy_index = int(energy / DE_EEPF)
				if energy_index < N_EEPF {
					sim.Eepf[energy_index] += 1.0
				}
				sim.Mean_energy_accu_center += energy
				sim.Mean_energy_counter_center++
			}
		}

		// update velocity and position
		sim.Vx_e[k] -= e_x * FACTOR_E
		sim.X_e[k] += sim.Vx_e[k] * DT_E
	}
}

func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, p int
	var c0, c1, c2, e_x, mean_v, v_sqr, energy float64

	for k = 0; k < sim.N_i; k++ {
		c0 = sim.X_i[k] * INV_DX
		p = int(c0)
		c1 = float64(p) + 1.0 - c0
		c2 = c0 - float64(p)
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]

		if sim.Measurement_mode {
			// measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
			mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
			sim.Counter_i_xt[p][t_index] += c1
			sim.Counter_i_xt[p+1][t_index] += c2
			sim.Ui_xt[p][t_index] += c1 * mean_v
			sim.Ui_xt[p+1][t_index] += c2 * mean_v
			v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			sim.Meanei_xt[p][t_index] += c1 * energy
			sim.Meanei_xt[p+1][t_index] += c2 * energy
		}

		// update velocity and position and accumulate absorbed energy
		sim.Vx_i[k] += e_x * FACTOR_I
		sim.X_i[k] += sim.Vx_i[k] * DT_I
	}
}

func (sim *SimulationState) Step5CheckBoundariesElectrons() {
	var k int = 0
	var out bool
	for k < sim.N_e { // check boundaries for all electrons in every time step
		out = false
		if sim.X_e[k] < 0 {
			sim.N_e_abs_pow++ // the electron is out at the powered electrode
			out = true
		}
		if sim.X_e[k] > L {
			sim.N_e_abs_gnd++ // the electron is out at the grounded electrode
			out = true
		}
		if out { // remove the electron, if out
			sim.X_e[k] = sim.X_e[sim.N_e-1]
			sim.Vx_e[k] = sim.Vx_e[sim.N_e-1]
			sim.Vy_e[k] = sim.Vy_e[sim.N_e-1]
			sim.Vz_e[k] = sim.Vz_e[sim.N_e-1]
			sim.N_e--
		} else {
			k++
		}
	}
}

func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}

	var k, energy_index int
	var out bool
	var v_sqr, energy float64

	k = 0
	for k < sim.N_i {
		out = false
		if sim.X_i[k] < 0 { // the ion is out at the powered electrode
			sim.N_i_abs_pow++
			out = true
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			energy_index = int(energy / DE_IFED)
			if energy_index < N_IFED {
				sim.Ifed_pow[energy_index]++ // save IFED at the powered electrode
			}
		}
		if sim.X_i[k] > L { // the ion is out at the grounded electrode
			sim.N_i_abs_gnd++
			out = true
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
			energy_index = int(energy / DE_IFED)
			if energy_index < N_IFED {
				sim.Ifed_gnd[energy_index]++ // save IFED at the grounded electrode
			}
		}
		if out { // delete the ion, if out
			sim.X_i[k] = sim.X_i[sim.N_i-1]
			sim.Vx_i[k] = sim.Vx_i[sim.N_i-1]
			sim.Vy_i[k] = sim.Vy_i[sim.N_i-1]
			sim.Vz_i[k] = sim.Vz_i[sim.N_i-1]
			sim.N_i--
		} else {
			k++
		}
	}
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

func (sim *SimulationState) Step9CollectXtData(t_index int) {
	if !sim.Measurement_mode {
		return
	}

	for p := 0; p < N_G; p++ {
		sim.Pot_xt[p][t_index] += sim.Pot[p]
		sim.Efield_xt[p][t_index] += sim.Efield[p]
		sim.Ne_xt[p][t_index] += sim.E_density[p]
		sim.Ni_xt[p][t_index] += sim.I_density[p]
	}
}

func (sim *SimulationState) DoOneCycle() {
	var t int
	var t_index int

	for t = 0; t < N_T; t++ { // the RF period is divided into N_T equal time intervals (time step DT_E)
		sim.Time += DT_E    // update of the total simulated time
		t_index = t / N_BIN // index for XT distributions

		sim.Step1ComputeElectronDensity()
		sim.Step1ComputeIonDensity(t)
		sim.Step2SolvePoisson(sim.Time)

		sim.Step3MoveElectrons(t_index)
		sim.Step4MoveIons(t_index, t)

		sim.Step5CheckBoundariesElectrons()
		sim.Step6CheckBoundariesIons(t)

		sim.Step7CollisionsElectrons()
		sim.Step8CollisionIons(t)

		sim.Step9CollectXtData(t_index)

		if (t % 1000) == 0 {
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
		}
	}
	fmt.Fprintf(sim.Datafile, "%8d  %8d  %8d\n", sim.Cycle, sim.N_e, sim.N_i)
}

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}
