package gopic

import (
	"math"
)

//-----------------------------------------------------------------//
// solve Poisson equation (Thomas algorithm)                       //
//-----------------------------------------------------------------//

func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
	var g, f Xvector

	// apply potential to the electrodes - boundary conditions

	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // potential at the powered electrode
	sim.Pot[N_G-1] = 0.0                      // potential at the grounded electrode

	// solve Poisson equation

	for i := 1; i <= N_G-2; i++ {
		f[i] = ALPHA * (*rho1)[i]
	}
	f[1] -= sim.Pot[0]
	f[N_G-2] -= sim.Pot[N_G-1]
	g[1] = f[1] * sim.ThomasW[1]
	for i := 2; i <= N_G-2; i++ {
		g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
	}
	sim.Pot[N_G-2] = g[N_G-2]
	for i := N_G - 3; i > 0; i-- {
		sim.Pot[i] = g[i] - sim.ThomasW[i]*sim.Pot[i+1] // potential at the grid points between the electrodes
	}

	// compute electric field

	for i := 1; i <= N_G-2; i++ {
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // electric field at the grid points between the electrodes
	}
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*BETA                 // powered electrode
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*BETA // grounded electrode
}
