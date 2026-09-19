package gopic

import (
	"math"
)

//----------------------------------------------------------------------//
// e / Ar collision  (cold gas approximation)                           //
//----------------------------------------------------------------------//

func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int) {
	// 1. Relative velocity before collision and center of mass velocity
	gx := *vxe
	gy := *vye
	gz := *vze
	g_perp_sq := gy*gy + gz*gz
	g_sq := gx*gx + g_perp_sq
	g := math.Sqrt(g_sq)
	g_perp := math.Sqrt(g_perp_sq)

	wx := F1 * (*vxe)
	wy := F1 * (*vye)
	wz := F1 * (*vze)

	// 2. Euler angles of initial velocity vector (vector algebra without Atan2/Sin/Cos)
	var ct, st, cp, sp float64
	if g > 0.0 {
		ct = gx / g
		st = g_perp / g
	} else {
		ct = 1.0
		st = 0.0
	}

	if g_perp > 0.0 {
		cp = gy / g_perp
		sp = gz / g_perp
	} else {
		cp = 1.0
		sp = 0.0
	}

	// 3. Select collision type (multiplicative selection without division)
	t0 := sim.Sigma[E_ELA][eindex]
	t1 := t0 + sim.Sigma[E_EXC][eindex]
	t2 := t1 + sim.Sigma[E_ION][eindex]
	rnd := sim.R01()
	r_t2 := rnd * t2

	eta := TWO_PI * sim.R01()
	se, ce := math.Sincos(eta)

	var sc, cc float64

	if r_t2 < t0 { // Elastic scattering (isotropic)
		cc = 1.0 - 2.0*sim.R01()
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
	} else if r_t2 < t1 { // Excitation (isotropic)
		energy := HALF_E_MASS * g_sq
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
		cc = 1.0 - 2.0*sim.R01()
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
	} else { // Ionization
		energy := HALF_E_MASS * g_sq
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)

		// Energy of ejected electron (Opal's formula)
		e_ej := 10.0 * math.Tan(sim.R01()*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
		e_sc := math.Abs(energy - e_ej)

		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)

		cc = math.Sqrt(e_sc / energy)
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))

		cc2 := math.Sqrt(e_ej / energy)
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))

		// Azimuthal angle for ejected electron is eta + PI -> sin and cos negate
		se2 := -se
		ce2 := -ce

		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)

		// Add secondary electron
		sim.X_e[sim.N_e] = xe
		sim.Vx_e[sim.N_e] = wx + F2*gx2
		sim.Vy_e[sim.N_e] = wy + F2*gy2
		sim.Vz_e[sim.N_e] = wz + F2*gz2
		sim.N_e++

		// Add new ion
		sim.X_i[sim.N_i] = xe
		sim.Vx_i[sim.N_i] = sim.RMB()
		sim.Vy_i[sim.N_i] = sim.RMB()
		sim.Vz_i[sim.N_i] = sim.RMB()
		sim.N_i++
	}

	// 4. Scatter primary electron
	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	*vxe = wx + F2*gx
	*vye = wy + F2*gy
	*vze = wz + F2*gz
}

//----------------------------------------------------------------------//
// Ar+ / Ar collision                                                   //
//----------------------------------------------------------------------//

func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int) {
	// 1. Process selection: isotropic vs backward scattering (charge exchange)
	t1 := sim.Sigma[I_ISO][e_index]
	t2 := t1 + sim.Sigma[I_BACK][e_index]
	rnd := sim.R01()

	if rnd*t2 >= t1 {
		// FAST-PATH: Backward scattering / Charge Exchange (I_BACK) - ~80% of ion collisions
		// The ion assumes target atom velocity directly without scattering geometry
		*vx_1 = *vx_2
		*vy_1 = *vy_2
		*vz_1 = *vz_2
		return
	}

	// 2. SLOW-PATH: Isotropic scattering (I_ISO) - ~20% of ion collisions
	gx := (*vx_1) - (*vx_2)
	gy := (*vy_1) - (*vy_2)
	gz := (*vz_1) - (*vz_2)
	g_perp_sq := gy*gy + gz*gz
	g_sq := gx*gx + g_perp_sq
	g := math.Sqrt(g_sq)
	g_perp := math.Sqrt(g_perp_sq)

	wx := 0.5 * ((*vx_1) + (*vx_2))
	wy := 0.5 * ((*vy_1) + (*vy_2))
	wz := 0.5 * ((*vz_1) + (*vz_2))

	var ct, st, cp, sp float64
	if g > 0.0 {
		ct = gx / g
		st = g_perp / g
	} else {
		ct = 1.0
		st = 0.0
	}

	if g_perp > 0.0 {
		cp = gy / g_perp
		sp = gz / g_perp
	} else {
		cp = 1.0
		sp = 0.0
	}

	cc := 1.0 - 2.0*sim.R01()
	sc := math.Sqrt(max(0.0, 1.0-cc*cc))

	eta := TWO_PI * sim.R01()
	se, ce := math.Sincos(eta)

	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	*vx_1 = wx + 0.5*gx
	*vy_1 = wy + 0.5*gy
	*vz_1 = wz + 0.5*gz
}
