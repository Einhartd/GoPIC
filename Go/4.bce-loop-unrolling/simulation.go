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

//----------------------------------------------------------------------//
// Null-Collision precomputation and sampling methods                   //
//----------------------------------------------------------------------//

func (sim *SimulationState) InitNullCollision() {
	sim.NuStarE = sim.MaxElectronCollFreq()
	sim.PStarE = 1.0 - math.Exp(-sim.NuStarE*DT_E)

	sim.NuStarI = sim.MaxIonCollFreq()
	sim.PStarI = 1.0 - math.Exp(-sim.NuStarI*DT_I)

	fmt.Printf(">> GoPIC: null-collision: nu*_e = %e, P*_e = %e\n", sim.NuStarE, sim.PStarE)
	fmt.Printf(">> GoPIC: null-collision: nu*_i = %e, P*_i = %e\n", sim.NuStarI, sim.PStarI)
}

func (sim *SimulationState) sampleBinomial(n int, p float64) int {
	if n <= 0 || p <= 0.0 {
		return 0
	}
	if p >= 1.0 {
		return n
	}
	mean := float64(n) * p
	variance := mean * (1.0 - p)
	if mean >= 5.0 && variance > 0.0 {
		// de Moivre-Laplace Gaussian approximation
		val := int(math.Round(mean + sim.Rng.NormFloat64()*math.Sqrt(variance)))
		if val < 0 {
			return 0
		}
		if val > n {
			return n
		}
		return val
	}

	count := 0
	for i := 0; i < n; i++ {
		if sim.R01() < p {
			count++
		}
	}
	return count
}

// randomSample selects k unique indices from [0, n) using partial Fisher-Yates shuffle.
// Zero-Allocation optimization: reuses preallocated sim.SamplePool slice,
// resulting in 0 heap allocations per call and 0 B/cycle memory pressure.
func (sim *SimulationState) randomSample(n, k int) []int {
	if k <= 0 || n <= 0 {
		return nil
	}
	if k > n {
		k = n
	}
	pool := sim.SamplePool[:n]
	for i := 0; i < n; i++ {
		pool[i] = i
	}
	for i := 0; i < k; i++ {
		j := i + int(sim.R01()*float64(n-i))
		pool[i], pool[j] = pool[j], pool[i]
	}
	return pool[:k]
}

//---------------------------------------------------------------------//
// simulation of one radiofrequency cycle                              //
//---------------------------------------------------------------------//

func (sim *SimulationState) Step1ComputeElectronDensity() {
	for p := 0; p < N_G; p++ {
		sim.E_density[p] = 0 // electron density - computed in every time step
	}
	n := sim.N_e
	if n <= 0 {
		return
	}
	xe := sim.X_e[:n]
	edensity := sim.E_density[:]
	_ = xe[n-1]

	k := 0
	for ; k <= n-4; k += 4 {
		c0_0 := xe[k] * INV_DX
		p0 := int(c0_0)
		d0 := c0_0 - float64(p0)
		w2_0 := d0 * FACTOR_W
		w1_0 := FACTOR_W - w2_0
		_ = edensity[p0+1]
		edensity[p0] += w1_0
		edensity[p0+1] += w2_0

		c0_1 := xe[k+1] * INV_DX
		p1 := int(c0_1)
		d1 := c0_1 - float64(p1)
		w2_1 := d1 * FACTOR_W
		w1_1 := FACTOR_W - w2_1
		_ = edensity[p1+1]
		edensity[p1] += w1_1
		edensity[p1+1] += w2_1

		c0_2 := xe[k+2] * INV_DX
		p2 := int(c0_2)
		d2 := c0_2 - float64(p2)
		w2_2 := d2 * FACTOR_W
		w1_2 := FACTOR_W - w2_2
		_ = edensity[p2+1]
		edensity[p2] += w1_2
		edensity[p2+1] += w2_2

		c0_3 := xe[k+3] * INV_DX
		p3 := int(c0_3)
		d3 := c0_3 - float64(p3)
		w2_3 := d3 * FACTOR_W
		w1_3 := FACTOR_W - w2_3
		_ = edensity[p3+1]
		edensity[p3] += w1_3
		edensity[p3+1] += w2_3
	}

	for ; k < n; k++ {
		c0 := xe[k] * INV_DX
		p := int(c0)
		d := c0 - float64(p)
		w2 := d * FACTOR_W
		w1 := FACTOR_W - w2
		_ = edensity[p+1]
		edensity[p] += w1
		edensity[p+1] += w2
	}

	sim.E_density[0] *= 2.0
	sim.E_density[N_G-1] *= 2.0
	for p := 0; p < N_G; p++ {
		sim.Cumul_e_density[p] += sim.E_density[p]
	}
}

func (sim *SimulationState) Step1ComputeIonDensity(t int) {
	if (t % N_SUB) == 0 { // ion density - computed in every N_SUB-th time steps (subcycling)
		for p := 0; p < N_G; p++ {
			sim.I_density[p] = 0
		}
		n := sim.N_i
		if n > 0 {
			xi := sim.X_i[:n]
			idensity := sim.I_density[:]
			_ = xi[n-1]

			k := 0
			for ; k <= n-4; k += 4 {
				c0_0 := xi[k] * INV_DX
				p0 := int(c0_0)
				d0 := c0_0 - float64(p0)
				w2_0 := d0 * FACTOR_W
				w1_0 := FACTOR_W - w2_0
				_ = idensity[p0+1]
				idensity[p0] += w1_0
				idensity[p0+1] += w2_0

				c0_1 := xi[k+1] * INV_DX
				p1 := int(c0_1)
				d1 := c0_1 - float64(p1)
				w2_1 := d1 * FACTOR_W
				w1_1 := FACTOR_W - w2_1
				_ = idensity[p1+1]
				idensity[p1] += w1_1
				idensity[p1+1] += w2_1

				c0_2 := xi[k+2] * INV_DX
				p2 := int(c0_2)
				d2 := c0_2 - float64(p2)
				w2_2 := d2 * FACTOR_W
				w1_2 := FACTOR_W - w2_2
				_ = idensity[p2+1]
				idensity[p2] += w1_2
				idensity[p2+1] += w2_2

				c0_3 := xi[k+3] * INV_DX
				p3 := int(c0_3)
				d3 := c0_3 - float64(p3)
				w2_3 := d3 * FACTOR_W
				w1_3 := FACTOR_W - w2_3
				_ = idensity[p3+1]
				idensity[p3] += w1_3
				idensity[p3+1] += w2_3
			}

			for ; k < n; k++ {
				c0 := xi[k] * INV_DX
				p := int(c0)
				d := c0 - float64(p)
				w2 := d * FACTOR_W
				w1 := FACTOR_W - w2
				_ = idensity[p+1]
				idensity[p] += w1
				idensity[p+1] += w2
			}
		}
		sim.I_density[0] *= 2.0
		sim.I_density[N_G-1] *= 2.0
	}
	for p := 0; p < N_G; p++ {
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
	n := sim.N_e
	if n <= 0 {
		return
	}
	xe := sim.X_e[:n]
	vxe := sim.Vx_e[:n]
	efield := sim.Efield[:]
	_ = xe[n-1]
	_ = vxe[n-1]

	if !sim.Measurement_mode {
		// Fast-path for non-diagnostic cycles: 4-way unrolling + BCE + FMA
		k := 0
		for ; k <= n-4; k += 4 {
			c0_0 := xe[k] * INV_DX
			p0 := int(c0_0)
			d0 := c0_0 - float64(p0)
			_ = efield[p0+1]
			ex0 := efield[p0] + d0*(efield[p0+1]-efield[p0])

			c0_1 := xe[k+1] * INV_DX
			p1 := int(c0_1)
			d1 := c0_1 - float64(p1)
			_ = efield[p1+1]
			ex1 := efield[p1] + d1*(efield[p1+1]-efield[p1])

			c0_2 := xe[k+2] * INV_DX
			p2 := int(c0_2)
			d2 := c0_2 - float64(p2)
			_ = efield[p2+1]
			ex2 := efield[p2] + d2*(efield[p2+1]-efield[p2])

			c0_3 := xe[k+3] * INV_DX
			p3 := int(c0_3)
			d3 := c0_3 - float64(p3)
			_ = efield[p3+1]
			ex3 := efield[p3] + d3*(efield[p3+1]-efield[p3])

			vx0 := vxe[k] - ex0*FACTOR_E
			vx1 := vxe[k+1] - ex1*FACTOR_E
			vx2 := vxe[k+2] - ex2*FACTOR_E
			vx3 := vxe[k+3] - ex3*FACTOR_E

			vxe[k] = vx0
			vxe[k+1] = vx1
			vxe[k+2] = vx2
			vxe[k+3] = vx3

			xe[k] += vx0 * DT_E
			xe[k+1] += vx1 * DT_E
			xe[k+2] += vx2 * DT_E
			xe[k+3] += vx3 * DT_E
		}

		for ; k < n; k++ {
			c0 := xe[k] * INV_DX
			p := int(c0)
			d := c0 - float64(p)
			_ = efield[p+1]
			ex := efield[p] + d*(efield[p+1]-efield[p])

			vxe[k] -= ex * FACTOR_E
			xe[k] += vxe[k] * DT_E
		}
		return
	}

	for k := 0; k < n; k++ { // move all electrons in every time step
		c0 := xe[k] * INV_DX
		p := int(c0)
		c2 := c0 - float64(p)
		c1 := 1.0 - c2
		_ = efield[p+1]
		ep := efield[p]
		e_x := ep + c2*(efield[p+1]-ep)

		// measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
		mean_v := vxe[k] - 0.5*e_x*FACTOR_E
		sim.Counter_e_xt[p][t_index] += c1
		sim.Counter_e_xt[p+1][t_index] += c2
		sim.Ue_xt[p][t_index] += c1 * mean_v
		sim.Ue_xt[p+1][t_index] += c2 * mean_v
		v_sqr := mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
		energy := (0.5 * E_MASS * INV_EV_TO_J) * v_sqr
		sim.Meanee_xt[p][t_index] += c1 * energy
		sim.Meanee_xt[p+1][t_index] += c2 * energy
		energy_index := minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
		velocity := math.Sqrt(v_sqr)
		rate := sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
		sim.Ioniz_rate_xt[p][t_index] += c1 * rate
		sim.Ioniz_rate_xt[p+1][t_index] += c2 * rate

		// measure EEPF in the center
		if (MIN_X < xe[k]) && (xe[k] < MAX_X) {
			eepf_index := int(energy * INV_DE_EEPF)
			if eepf_index < N_EEPF {
				sim.Eepf[eepf_index] += 1.0
			}
			sim.Mean_energy_accu_center += energy
			sim.Mean_energy_counter_center++
		}

		// update velocity and position
		vxe[k] -= e_x * FACTOR_E
		xe[k] += vxe[k] * DT_E
	}
}

func (sim *SimulationState) Step4MoveIons(t_index, t int) {
	if (t % N_SUB) != 0 {
		return
	}

	n := sim.N_i
	if n <= 0 {
		return
	}
	xi := sim.X_i[:n]
	vxi := sim.Vx_i[:n]
	efield := sim.Efield[:]
	_ = xi[n-1]
	_ = vxi[n-1]

	if !sim.Measurement_mode {
		// Fast-path for non-diagnostic cycles: 4-way unrolling + BCE + FMA
		k := 0
		for ; k <= n-4; k += 4 {
			c0_0 := xi[k] * INV_DX
			p0 := int(c0_0)
			d0 := c0_0 - float64(p0)
			_ = efield[p0+1]
			ex0 := efield[p0] + d0*(efield[p0+1]-efield[p0])

			c0_1 := xi[k+1] * INV_DX
			p1 := int(c0_1)
			d1 := c0_1 - float64(p1)
			_ = efield[p1+1]
			ex1 := efield[p1] + d1*(efield[p1+1]-efield[p1])

			c0_2 := xi[k+2] * INV_DX
			p2 := int(c0_2)
			d2 := c0_2 - float64(p2)
			_ = efield[p2+1]
			ex2 := efield[p2] + d2*(efield[p2+1]-efield[p2])

			c0_3 := xi[k+3] * INV_DX
			p3 := int(c0_3)
			d3 := c0_3 - float64(p3)
			_ = efield[p3+1]
			ex3 := efield[p3] + d3*(efield[p3+1]-efield[p3])

			vx0 := vxi[k] + ex0*FACTOR_I
			vx1 := vxi[k+1] + ex1*FACTOR_I
			vx2 := vxi[k+2] + ex2*FACTOR_I
			vx3 := vxi[k+3] + ex3*FACTOR_I

			vxi[k] = vx0
			vxi[k+1] = vx1
			vxi[k+2] = vx2
			vxi[k+3] = vx3

			xi[k] += vx0 * DT_I
			xi[k+1] += vx1 * DT_I
			xi[k+2] += vx2 * DT_I
			xi[k+3] += vx3 * DT_I
		}

		for ; k < n; k++ {
			c0 := xi[k] * INV_DX
			p := int(c0)
			d := c0 - float64(p)
			_ = efield[p+1]
			ex := efield[p] + d*(efield[p+1]-efield[p])

			vxi[k] += ex * FACTOR_I
			xi[k] += vxi[k] * DT_I
		}
		return
	}

	for k := 0; k < n; k++ {
		c0 := xi[k] * INV_DX
		p := int(c0)
		c2 := c0 - float64(p)
		c1 := 1.0 - c2
		_ = efield[p+1]
		ep := efield[p]
		e_x := ep + c2*(efield[p+1]-ep)

		// measurements: 'x' and 'v' are needed at the same time, i.e. old 'x' and mean 'v'
		mean_v := vxi[k] + 0.5*e_x*FACTOR_I
		sim.Counter_i_xt[p][t_index] += c1
		sim.Counter_i_xt[p+1][t_index] += c2
		sim.Ui_xt[p][t_index] += c1 * mean_v
		sim.Ui_xt[p+1][t_index] += c2 * mean_v
		v_sqr := mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
		energy := (0.5 * AR_MASS * INV_EV_TO_J) * v_sqr
		sim.Meanei_xt[p][t_index] += c1 * energy
		sim.Meanei_xt[p+1][t_index] += c2 * energy

		// update velocity and position
		vxi[k] += e_x * FACTOR_I
		xi[k] += vxi[k] * DT_I
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
	var v_sqr float64

	k = 0
	for k < sim.N_i {
		out = false
		if sim.X_i[k] < 0 { // the ion is out at the powered electrode
			sim.N_i_abs_pow++
			out = true
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
			if energy_index < N_IFED {
				sim.Ifed_pow[energy_index]++ // save IFED at the powered electrode
			}
		}
		if sim.X_i[k] > L { // the ion is out at the grounded electrode
			sim.N_i_abs_gnd++
			out = true
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
			energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
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
	if sim.N_e <= 0 {
		return
	}

	numColl := sim.sampleBinomial(sim.N_e, sim.PStarE)
	if numColl <= 0 {
		return
	}

	candidates := sim.randomSample(sim.N_e, numColl)
	for _, ki := range candidates {
		v_sqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
		velocity := math.Sqrt(v_sqr)
		energy_index := minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)

		realNu := sim.SigmaTotE[energy_index] * velocity
		pAccept := realNu / sim.NuStarE
		if pAccept > 1.0 {
			pAccept = 1.0
		}

		if sim.R01() < pAccept {
			sim.CollisionElectron(sim.X_e[ki], &sim.Vx_e[ki], &sim.Vy_e[ki], &sim.Vz_e[ki], energy_index)
			sim.N_e_coll++
		}
	}
}

func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t%N_SUB) != 0 || sim.N_i <= 0 {
		return
	}

	numColl := sim.sampleBinomial(sim.N_i, sim.PStarI)
	if numColl <= 0 {
		return
	}

	candidates := sim.randomSample(sim.N_i, numColl)
	for _, ki := range candidates {
		vx_a := sim.RMB()
		vy_a := sim.RMB()
		vz_a := sim.RMB()
		gx := sim.Vx_i[ki] - vx_a
		gy := sim.Vy_i[ki] - vy_a
		gz := sim.Vz_i[ki] - vz_a
		g_sqr := gx*gx + gy*gy + gz*gz
		g := math.Sqrt(g_sqr)
		energy_index := minInt(int(g_sqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)

		realNu := sim.SigmaTotI[energy_index] * g
		pAccept := realNu / sim.NuStarI
		if pAccept > 1.0 {
			pAccept = 1.0
		}

		if sim.R01() < pAccept {
			sim.CollisionIon(&sim.Vx_i[ki], &sim.Vy_i[ki], &sim.Vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index)
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
