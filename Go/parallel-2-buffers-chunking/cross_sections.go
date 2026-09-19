package gopic

import (
	"fmt"
	"math"
	"os"
)

/*
Obliczanie mikroskopowych przekrojów czynnych zderzeń e- / Ar.
Formuły analityczne na podstawie pracy:
A.V. Phelps, Z.Lj. Petrovic, Plasma Sources Sci. Technol. 8, R21 (1999).
Procesy:
  - E_ELA: zderzenia sprężyste (ze zmodyfikowanym przekrojem pędowym)
  - E_EXC: wzbudzenie poziomu argonu (próg energetyczny 11.5 eV)
  - E_ION: jonizacja uderzeniowa (próg energetyczny 15.8 eV)

Wszystkie przekroje są przeliczane na jednostki [m^2] (* 1e-20) i zapisywane w tablicy Sigma.
*/
func (sim *SimulationState) SetElectronCrossSectionsAr() {
	var en, qmel, qexc, qion float64

	fmt.Println(">> gopic: Setting e- / Ar cross sections")
	for i := 0; i < CS_RANGES; i++ {
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
		sim.Sigma[E_ELA][i] = qmel * 1.0e-20 // Przekrój czynny na zderzenia sprężyste e- / Ar [m^2]
		sim.Sigma[E_EXC][i] = qexc * 1.0e-20 // Przekrój czynny na wzbudzenie e- / Ar [m^2]
		sim.Sigma[E_ION][i] = qion * 1.0e-20 // Przekrój czynny na jonizację e- / Ar [m^2]
	}
}

/*
Obliczanie mikroskopowych przekrojów czynnych zderzeń Ar+ / Ar.
Formuły analityczne na podstawie pracy:
A.V. Phelps, J. Phys. Chem. Ref. Data 23, 847 (1994).
Procesy:
  - I_ISO: sprężyste rozpraszanie izotropowe
  - I_BACK: sprężyste rozpraszanie wsteczne (rezonansowa wymiana ładunku)

Wszystkie przekroje są przeliczane na jednostki [m^2] i zapisywane w tablicy Sigma.
*/
func (sim *SimulationState) SetIonCrossSectionsAr() {
	var e_com, e_lab, qmom, qback, qiso float64

	fmt.Println(">> gopic: Setting Ar+ / Ar cross sections")
	for i := range CS_RANGES {
		if i == 0 {
			e_com = DE_CS
		} else {
			e_com = DE_CS * float64(i)
		} // Energia jonu w układzie środka masy [eV]
		e_lab = 2.0 * e_com // Energia jonu w układzie laboratoryjnym [eV]
		qmom = 1.15e-18 * math.Pow(e_lab, -0.1) * math.Pow(1.0+0.015/e_lab, 0.6)
		qiso = 2e-19*math.Pow(e_lab, -0.5)/(1.0+e_lab) + 3e-19*e_lab/math.Pow(1.0+e_lab/3.0, 2.0)
		qback = (qmom - qiso) / 2.0
		sim.Sigma[I_ISO][i] = qiso   // Przekrój czynny na izotropową część rozpraszania sprężystego [m^2]
		sim.Sigma[I_BACK][i] = qback // Przekrój czynny na rozpraszanie wsteczne (wymianę ładunku) [m^2]
	}
}

/*
Obliczanie całkowitych makroskopowych przekrojów czynnych dla elektronów i jonów.
Przelicza sumę mikroskopowych przekrojów procesów na wielkości makroskopowe:
SigmaTot = sum(Sigma_procesy) * GAS_DENSITY [1/m].
*/
func (sim *SimulationState) CalcTotalCrossSections() {
	for i := range CS_RANGES {
		sim.SigmaTotE[i] = (sim.Sigma[E_ELA][i] + sim.Sigma[E_EXC][i] + sim.Sigma[E_ION][i]) * GAS_DENSITY // Całkowity makroskopowy przekrój dla elektronów
		sim.SigmaTotI[i] = (sim.Sigma[I_ISO][i] + sim.Sigma[I_BACK][i]) * GAS_DENSITY                      // Całkowity makroskopowy przekrój dla jonów
	}
}

/*
Funkcja pomocnicza: Eksport tablic przekrojów czynnych do pliku tekstowego cross_sections.dat.
Zapisuje kolumny: Energia [eV], sigma_E_ELA, sigma_E_EXC, sigma_E_ION, sigma_I_ISO, sigma_I_BACK.
*/
func (sim *SimulationState) TestCrossSections() {
	f, err := os.Create("cross_sections.dat") // Plik wynikowy: cross_sections.dat
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
Wyznaczenie maksymalnej częstości zderzeń dla elektronów nu*_e.
Oblicza iloczyn prędkości i całkowitego makroskopowego przekroju czynnego:
nu(E) = v(E) * SigmaTotE(E).
Używane do weryfikacji stabilności oraz metody Null-Collision.
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
Wyznaczenie maksymalnej częstości zderzeń dla jonów nu*_i.
Oblicza iloczyn prędkości względnej i makroskopowego przekroju czynnego:
nu(E) = g(E) * SigmaTotI(E) (z masą zredukowaną MU_ARAR).
Używane do weryfikacji stabilności oraz metody Null-Collision.
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
