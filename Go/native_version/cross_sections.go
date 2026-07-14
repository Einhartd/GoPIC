package gopic

import (
	"fmt"
	"math"
	"os"
)

//----------------------------------------------------------------------------//
//  electron cross sections: A V Phelps & Z Lj Petrovic, PSST 8 R21 (1999)    //
//----------------------------------------------------------------------------//

func (sim *SimulationState) SetElectronCrossSectionsAr() {
	var en, qmel, qexc, qion float64

	fmt.Println(">> gopic: Setting e- / Ar cross sections")
	for i := 0; i < CS_RANGES; i++ {
		if i == 0 {
			en = DE_CS
		} else {
			en = DE_CS * float64(i)
		} // electron energy
		qmel = math.Abs(6.0/math.Pow(1.0+(en/0.1)+math.Pow(en/0.6, 2.0), 3.3)-
			1.1*math.Pow(en, 1.4)/(1.0+math.Pow(en/15.0, 1.2))/math.Sqrt(1.0+math.Pow(en/5.5, 2.5)+math.Pow(en/60.0, 4.1))) +
			0.05/math.Pow(1.0+en/10.0, 2.0) + 0.01*math.Pow(en, 3.0)/(1.0+math.Pow(en/12.0, 6.0))
		if en > E_EXC_TH {
			qexc = 0.034*math.Pow(en-11.5, 1.1)*(1.0+math.Pow(en/15.0, 2.8))/(1.0+math.Pow(en/23.0, 5.5)) +
				0.023*(en-11.5)/math.Pow(1.0+en/80.0, 1.9)
		} else {
			qexc = 0
		}
		if en > E_ION_TH {
			qion = 970.0*(en-15.8)/math.Pow(70.0+en, 2.0) + 0.06*math.Pow(en-15.8, 2.0)*math.Exp(-en/9)
		} else {
			qion = 0
		}
		sim.Sigma[E_ELA][i] = qmel * 1.0e-20 // cross section for e- / Ar elastic collision
		sim.Sigma[E_EXC][i] = qexc * 1.0e-20 // cross section for e- / Ar excitation
		sim.Sigma[E_ION][i] = qion * 1.0e-20 // cross section for e- / Ar ionization
	}
}

//------------------------------------------------------------------------------//
//  ion cross sections: A. V. Phelps, J. Appl. Phys. 76, 747 (1994)             //
//------------------------------------------------------------------------------//

func (sim *SimulationState) SetIonCrossSectionsAr() {
	var e_com, e_lab, qmom, qback, qiso float64

	fmt.Println(">> gopic: Setting Ar+ / Ar cross sections")
	for i := 0; i < CS_RANGES; i++ {
		if i == 0 {
			e_com = DE_CS
		} else {
			e_com = DE_CS * float64(i)
		} // ion energy in the center of mass frame of reference
		e_lab = 2.0 * e_com // ion energy in the laboratory frame of reference
		qmom = 1.15e-18 * math.Pow(e_lab, -0.1) * math.Pow(1.0+0.015/e_lab, 0.6)
		qiso = 2e-19*math.Pow(e_lab, -0.5)/(1.0+e_lab) + 3e-19*e_lab/math.Pow(1.0+e_lab/3.0, 2.0)
		qback = (qmom - qiso) / 2.0
		sim.Sigma[I_ISO][i] = qiso   // cross section for Ar+ / Ar isotropic part of elastic scattering
		sim.Sigma[I_BACK][i] = qback // cross section for Ar+ / Ar backward elastic scattering
	}
}

//----------------------------------------------------------------------//
//  calculation of total cross sections for electrons and ions          //
//----------------------------------------------------------------------//

func (sim *SimulationState) CalcTotalCrossSections() {
	for i := 0; i < CS_RANGES; i++ {
		sim.SigmaTotE[i] = (sim.Sigma[E_ELA][i] + sim.Sigma[E_EXC][i] + sim.Sigma[E_ION][i]) * GAS_DENSITY // total macroscopic cross section of electrons
		sim.SigmaTotI[i] = (sim.Sigma[I_ISO][i] + sim.Sigma[I_BACK][i]) * GAS_DENSITY                      // total macroscopic cross section of ions
	}
}

//----------------------------------------------------------------------//
//  test of cross sections for electrons and ions                       //
//----------------------------------------------------------------------//

func (sim *SimulationState) TestCrossSections() {
	f, err := os.Create("cross_sections.dat") // cross sections saved in data file: cross_sections.dat
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := 0; i < CS_RANGES; i++ {
		fmt.Fprintf(f, "%12.4f ", float64(i)*DE_CS)
		for j := 0; j < N_CS; j++ {
			fmt.Fprintf(f, "%14e ", sim.Sigma[j][i])
		}
		fmt.Fprint(f, "\n")
	}
}

//---------------------------------------------------------------------//
// find upper limit of collision frequencies                           //
//---------------------------------------------------------------------//

func (sim *SimulationState) MaxElectronCollFreq() float64 {
	nu_max := 0.0
	for i := 0; i < CS_RANGES; i++ {
		e := float64(i) * DE_CS
		v := math.Sqrt(2.0 * e * EV_TO_J / E_MASS)
		nu := v * sim.SigmaTotE[i]
		if nu > nu_max {
			nu_max = nu
		}
	}
	return nu_max
}

func (sim *SimulationState) MaxIonCollFreq() float64 {
	nu_max := 0.0
	for i := 0; i < CS_RANGES; i++ {
		e := float64(i) * DE_CS
		g := math.Sqrt(2.0 * e * EV_TO_J / MU_ARAR)
		nu := g * sim.SigmaTotI[i]
		if nu > nu_max {
			nu_max = nu
		}
	}
	return nu_max
}
