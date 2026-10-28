package gopic

import (
	"fmt"
	"math"
	"os"
)

// SetElectronCrossSectionsAr oblicza i tabelaryzuje mikroskopowe przekroje czynne zderzeń elektronów
// z atomami argonu (e- + Ar) na podstawie dopasowań analitycznych z pracy:
// A.V. Phelps, Z.Lj. Petrovic, Plasma Sources Sci. Technol. 8, R21 (1999).
// Wypełnia tablice Sigma[E_ELA] (zderzenia sprężyste), Sigma[E_EXC] (wzbudzenie, próg 11.5 eV)
// oraz Sigma[E_ION] (jonizacja uderzeniowa, próg 15.8 eV) w jednostkach [m^2].
func (sim *SimulationState) SetElectronCrossSectionsAr() {
	var en, qmel, qexc, qion float64

	fmt.Println(">> gopic: Setting e- / Ar cross sections")
	for i := range CS_RANGES {
		// Energia kinetyczna elektronu dla danego przedziału tabeli [eV]
		if i == 0 {
			en = DE_CS
		} else {
			en = DE_CS * float64(i)
		}
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
		// Zapis przekrojów czynnych przeliczonych na jednostki SI [m^2]
		sim.Sigma[E_ELA][i] = qmel * 1.0e-20
		sim.Sigma[E_EXC][i] = qexc * 1.0e-20
		sim.Sigma[E_ION][i] = qion * 1.0e-20
	}
}

// SetIonCrossSectionsAr oblicza i tabelaryzuje mikroskopowe przekroje czynne zderzeń jonów argonu
// z atomami tła (Ar+ + Ar) na podstawie dopasowań analitycznych z pracy:
// A.V. Phelps, J. Appl. Phys. 76, 747 (1994).
// Wypełnia tablice Sigma[I_ISO] (rozpraszanie izotropowe) oraz Sigma[I_BACK] (rozpraszanie wsteczne /
// rezonansowa wymiana ładunku) w jednostkach [m^2].
func (sim *SimulationState) SetIonCrossSectionsAr() {
	var e_com, e_lab, qmom, qback, qiso float64

	fmt.Println(">> gopic: Setting Ar+ / Ar cross sections")
	for i := range CS_RANGES {
		// Energia zderzenia w układzie środka masy [eV] oraz w układzie laboratoryjnym [eV]
		if i == 0 {
			e_com = DE_CS
		} else {
			e_com = DE_CS * float64(i)
		}
		e_lab = 2.0 * e_com
		qmom = 1.15e-18 * math.Pow(e_lab, -0.1) * math.Pow(1.0+0.015/e_lab, 0.6)
		qiso = 2e-19*math.Pow(e_lab, -0.5)/(1.0+e_lab) + 3e-19*e_lab/math.Pow(1.0+e_lab/3.0, 2.0)
		qback = (qmom - qiso) / 2.0
		// Zapis przekrojów czynnych dla rozpraszania izotropowego oraz wstecznego [m^2]
		sim.Sigma[I_ISO][i] = qiso
		sim.Sigma[I_BACK][i] = qback
	}
}

// CalcTotalCrossSections oblicza całkowite makroskopowe przekroje czynne dla elektronów (SigmaTotE)
// oraz jonów (SigmaTotI), mnożąc sumę mikroskopowych przekrojów czynnych przez gęstość gazu tła GAS_DENSITY.
func (sim *SimulationState) CalcTotalCrossSections() {
	for i := range CS_RANGES {
		// Całkowity makroskopowy przekrój czynny dla elektronów [1/m]
		sim.SigmaTotE[i] = (sim.Sigma[E_ELA][i] + sim.Sigma[E_EXC][i] + sim.Sigma[E_ION][i]) * GAS_DENSITY
		// Całkowity makroskopowy przekrój czynny dla jonów [1/m]
		sim.SigmaTotI[i] = (sim.Sigma[I_ISO][i] + sim.Sigma[I_BACK][i]) * GAS_DENSITY
	}
}

// TestCrossSections zapisuje wszystkie stabelaryzowane przekroje czynne do pliku tekstowego cross_sections.dat.
// Kolejne kolumny pliku: Energia [eV], sigma_E_ELA, sigma_E_EXC, sigma_E_ION, sigma_I_ISO, sigma_I_BACK [m^2].
func (sim *SimulationState) TestCrossSections() {
	f, err := os.Create("cross_sections.dat")
	if err != nil {
		panic(err)
	}
	defer f.Close()
	for i := range CS_RANGES {
		fmt.Fprintf(f, "%12.4f ", float64(i)*DE_CS)
		for j := 0; j < N_CS; j++ {
			fmt.Fprintf(f, "%14e ", sim.Sigma[j][i])
		}
		fmt.Fprint(f, "\n")
	}
}

// MaxElectronCollFreq wyznacza maksymalną częstość zderzeń elektronów z atomami gazu tła
// w całym rozważanym zakresie energii jako maksimum iloczynu v(E) * SigmaTotE(E).
//
// Zwraca:
//   - maksymalna częstość zderzeń elektronów nu*_e [1/s].
func (sim *SimulationState) MaxElectronCollFreq() float64 {
	nu_max := 0.0
	for i := range CS_RANGES {
		e := float64(i) * DE_CS
		v := math.Sqrt(2.0 * e * EV_TO_J / E_MASS)
		nu := v * sim.SigmaTotE[i]
		if nu > nu_max {
			nu_max = nu
		}
	}
	return nu_max
}

// MaxIonCollFreq wyznacza maksymalną częstość zderzeń jonów z atomami gazu tła
// w całym rozważanym zakresie energii jako maksimum iloczynu prędkości względnej g(E) * SigmaTotI(E).
//
// Zwraca:
//   - maksymalna częstość zderzeń jonów nu*_i [1/s].
func (sim *SimulationState) MaxIonCollFreq() float64 {
	nu_max := 0.0
	for i := range CS_RANGES {
		e := float64(i) * DE_CS
		g := math.Sqrt(2.0 * e * EV_TO_J / MU_ARAR)
		nu := g * sim.SigmaTotI[i]
		if nu > nu_max {
			nu_max = nu
		}
	}
	return nu_max
}
