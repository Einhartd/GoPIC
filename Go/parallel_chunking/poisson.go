package gopic

import (
	"math"
)

//-----------------------------------------------------------------//
// solve Poisson equation (Thomas algorithm)                       //
//-----------------------------------------------------------------//

func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {

	var g, w, f Xvector

	// apply potential to the electrodes - boundary conditions

	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // potential at the powered electrode
	sim.Pot[N_G-1] = 0.0                      // potential at the grounded electrode

	// solve Poisson equation

	for i := 1; i <= N_G-2; i++ {
		f[i] = ALPHA * (*rho1)[i]
	}
	f[1] -= sim.Pot[0]
	f[N_G-2] -= sim.Pot[N_G-1]
	w[1] = C / B
	g[1] = f[1] / B
	for i := 2; i <= N_G-2; i++ {
		w[i] = C / (B - A*w[i-1])
		g[i] = (f[i] - A*g[i-1]) / (B - A*w[i-1])
	}
	sim.Pot[N_G-2] = g[N_G-2]
	for i := N_G - 3; i > 0; i-- {
		sim.Pot[i] = g[i] - w[i]*sim.Pot[i+1] // potential at the grid points between the electrodes
	}

	// compute electric field

	for i := 1; i <= N_G-2; i++ {
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // electric field at the grid points between the electrodes
	}
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*DX/(2.0*EPSILON0)                 // powered electrode
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*DX/(2.0*EPSILON0) // grounded electrode
}
