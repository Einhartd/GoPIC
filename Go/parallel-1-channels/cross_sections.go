package gopic

import (
	"fmt"
	"math"
	"os"
)

/*
Inicjalizacja mikroskopowych przekrojów czynnych dla zderzeń elektronów z neutralnym argonem (e- / Ar).
Oparta na parametryzacji analitycznej: A.V. Phelps & Z.Lj. Petrovic, PSST 8 R21 (1999).
Modelowane procesy:
 1. Zderzenia sprężyste (E_ELA) z uwzględnieniem minimum Ramsauera-Townsenda.
 2. Wzbudzenie poziomu atomu (E_EXC) z progiem E_EXC_TH = 11.5 eV.
 3. Jonizacja uderzeniowa (E_ION) z progiem E_ION_TH = 15.8 eV.
*/
func (sim *SimulationState) SetElectronCrossSectionsAr() {
	var en, qmel, qexc, qion float64

	fmt.Println(">> gopic: Setting e- / Ar cross sections")
	for i := range CS_RANGES {
		if i == 0 {
			en = DE_CS
		} else {
			en = DE_CS * float64(i)
		} // Energia kinetyczna elektronu [eV]
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
		sim.Sigma[E_ELA][i] = qmel * 1.0e-20 // Przekrój czynny na zderzenia sprężyste [m^2]
		sim.Sigma[E_EXC][i] = qexc * 1.0e-20 // Przekrój czynny na wzbudzenie [m^2]
		sim.Sigma[E_ION][i] = qion * 1.0e-20 // Przekrój czynny na jonizację [m^2]
	}
}

/*
Inicjalizacja mikroskopowych przekrojów czynnych dla zderzeń jonów z argonem (Ar+ / Ar).
Oparta na analitycznym dopasowaniu: A.V. Phelps, J. Appl. Phys. 76, 747 (1994).
Modelowane procesy:
 1. Sprężyste rozpraszanie izotropowe (I_ISO).
 2. Sprężyste rozpraszanie wsteczne / wymiana ładunku (I_BACK).
*/
func (sim *SimulationState) SetIonCrossSectionsAr() {
	var e_com, e_lab, qmom, qback, qiso float64

	fmt.Println(">> gopic: Setting Ar+ / Ar cross sections")
	for i := range CS_RANGES {
		if i == 0 {
			e_com = DE_CS
		} else {
			e_com = DE_CS * float64(i)
		} // Energia w układzie środka masy (COM) [eV]
		e_lab = 2.0 * e_com // Energia w układzie laboratoryjnym [eV]
		qmom = 1.15e-18 * math.Pow(e_lab, -0.1) * math.Pow(1.0+0.015/e_lab, 0.6)
		qiso = 2e-19*math.Pow(e_lab, -0.5)/(1.0+e_lab) + 3e-19*e_lab/math.Pow(1.0+e_lab/3.0, 2.0)
		qback = (qmom - qiso) / 2.0
		sim.Sigma[I_ISO][i] = qiso   // Część izotropowa [m^2]
		sim.Sigma[I_BACK][i] = qback // Rozpraszanie wsteczne [m^2]
	}
}

/*
Oblicza całkowite makroskopowe przekroje czynne dla elektronów (SigmaTotE) i jonów (SigmaTotI).
Przelicza sumę mikroskopowych przekrojów czynnych sigma [m^2] na makroskopowe [1/m]
poprzez przemnożenie przez gęstość gazu neutralnego GAS_DENSITY = p / (k_B * T).
*/
func (sim *SimulationState) CalcTotalCrossSections() {
	for i := range CS_RANGES {
		sim.SigmaTotE[i] = (sim.Sigma[E_ELA][i] + sim.Sigma[E_EXC][i] + sim.Sigma[E_ION][i]) * GAS_DENSITY
		sim.SigmaTotI[i] = (sim.Sigma[I_ISO][i] + sim.Sigma[I_BACK][i]) * GAS_DENSITY
	}
}

/*
Zapisuje stabelaryzowane przekroje czynne dla wszystkich procesów do pliku cross_sections.dat.
Umożliwia weryfikację poprawności tablic przekrojów czynnych.
*/
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

/*
Wyznacza górną granicę częstości zderzeń elektronów nu*_max [1/s] w całym zakresie energii.
Wykorzystywane do weryfikacji kryterium dokładności zderzeń nu*_e * dt_e < 0.05
oraz do wyznaczenia prawdopodobieństwa w metodzie Null-Collision.
@return Maksymalna częstość zderzeń elektronów [1/s].
*/
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

/*
Wyznacza górną granicę częstości zderzeń jonów nu*_max [1/s] w całym zakresie energii.
Wykorzystywane do weryfikacji kryterium stabilności nu*_i * dt_i < 0.05
oraz do parametryzacji metody Null-Collision dla jonów.
@return Maksymalna częstość zderzeń jonów [1/s].
*/
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
