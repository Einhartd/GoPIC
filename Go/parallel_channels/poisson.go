package gopic

import (
	"math"
)

/*
Rozwiązanie jednowymiarowego równania Poissona (d^2 phi / dx^2 = -rho / epsilon0)
z wykorzystaniem algorytmu macierzy trójdiagonalnej Thomasa (TDMA) oraz wyznaczenie pola elektrycznego E.
Etapy:
 1. Narzucenie warunków brzegowych Dirichleta na elektrodach (napięcie RF na elektrodzie zasilanej, 0V na uziemionej).
 2. Konstrukcja prawej strony układu równań f[i] z uwzględnieniem warunków brzegowych w węzłach brzegowych 1 i N_G-2.
 3. Przebieg w przód algorytmu Thomasa: wyznaczenie współczynników w[i] oraz zmodyfikowanych wyrazów wolnych g[i].
 4. Przebieg wsteczny (podstawienie wsteczne): wyznaczenie potencjału elektrostatycznego Pot[i].
 5. Różniczkowanie numeryczne potencjału: E = -grad(phi) (schemat centralny wewnątrz siatki, jednostronny z korektą ładunku powierzchniowego na brzegach).
@param rho1 Wskaźnik do tablicy gęstości ładunku wypadkowego w węzłach siatki [C/m^3].
@param tt   Aktualny fizyczny czas symulacji [s].
*/
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
	var g, w, f Xvector

	// Warunki brzegowe Dirichleta na elektrodach
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencjał elektrody zasilanej RF
	sim.Pot[N_G-1] = 0.0                      // Potencjał elektrody uziemionej

	// Rozwiązanie równania Poissona algorytmem Thomasa
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
		sim.Pot[i] = g[i] - w[i]*sim.Pot[i+1] // Potencjał w węzłach wewnętrznych
	}

	// Obliczenie pola elektrycznego E = -grad(Pot)
	for i := 1; i <= N_G-2; i++ {
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // Różnica centralna
	}
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*DX/(2.0*EPSILON0)                 // Elektroda zasilana
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*DX/(2.0*EPSILON0) // Elektroda uziemiona
}
