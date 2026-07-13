package main

import (
	"fmt"
	"math"
)

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

func minInt(a, b int) int {
	if a < b {
		return a
	}
	return b
}
