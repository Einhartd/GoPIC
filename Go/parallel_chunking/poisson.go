package gopic

import (
	"math"
)

/*
Rozwiązanie 1D równania Poissona (d^2 phi / dx^2 = -rho / epsilon_0).
Wykorzystuje algorytm Thomasa dla układu trójdiagonalnego (A=1, B=-2, C=1).
Następnie oblicza rozkład natężenia pola elektrycznego E = -d(phi)/dx z uwzględnieniem
warunków brzegowych Dirichleta na elektrodach.
Etapy:
 1. Zastosowanie warunków brzegowych Dirichleta dla potencjału na elektrodach.
 2. Przygotowanie prawej strony układu równań z poprawkami brzegowymi.
 3. Eliminacja w przód algorytmu Thomasa (forward elimination).
 4. Podstawienie wsteczne (back substitution) i wyznaczenie potencjału w węzłach.
 5. Obliczenie natężenia pola elektrycznego wewnątrz i na brzegach komórek.
@param rho1 Wskaźnik do wektora gęstości ładunku przestrzennego na siatce [C/m^3].
@param tt   Aktualny fizyczny czas symulacji [s] (do wyznaczenia napięcia RF).
*/
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
	var g, w, f Xvector

	// 1. Warunki brzegowe Dirichleta dla potencjału na elektrodach
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt) // Potencjał na elektrodzie zasilanej RF (x = 0)
	sim.Pot[N_G-1] = 0.0                      // Potencjał na elektrodzie uziemionej (x = L)

	// 2. Przygotowanie prawej strony układu równań
	for i := 1; i <= N_G-2; i++ {
		f[i] = ALPHA * (*rho1)[i]
	}
	f[1] -= sim.Pot[0]
	f[N_G-2] -= sim.Pot[N_G-1]

	// 3. Algorytm Thomasa — Faza 1: Eliminacja w przód
	w[1] = C / B
	g[1] = f[1] / B
	for i := 2; i <= N_G-2; i++ {
		w[i] = C / (B - A*w[i-1])
		g[i] = (f[i] - A*g[i-1]) / (B - A*w[i-1])
	}

	// 4. Algorytm Thomasa — Faza 2: Podstawienie wsteczne
	sim.Pot[N_G-2] = g[N_G-2]
	for i := N_G - 3; i > 0; i-- {
		sim.Pot[i] = g[i] - w[i]*sim.Pot[i+1] // Potencjał w wewnętrznych punktach siatki
	}

	// 5. Obliczanie natężenia pola elektrycznego E = -grad(phi)
	for i := 1; i <= N_G-2; i++ {
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S // Różnice centralne wewnątrz domeny
	}
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*DX/(2.0*EPSILON0)                 // Elektroda zasilana
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*DX/(2.0*EPSILON0) // Elektroda uziemiona
}
