package gopic

import (
	"math"
)

// SolvePoisson rozwiązuje jednowymiarowe równanie Poissona (d^2 phi / dx^2 = -rho / epsilon_0)
// za pomocą algorytmu Thomasa dla macierzy trójdiagonalnej, a następnie wyznacza
// natężenie pola elektrycznego E = -d(phi)/dx w węzłach siatki.
//
// Etapy:
//  1. Zastosowanie warunków brzegowych Dirichleta dla potencjału na elektrodach.
//  2. Przygotowanie wektora prawej strony układu równań z uwzględnieniem brzegów.
//  3. Eliminacja w przód (forward sweep) wyznaczająca współczynniki pomocnicze w i g.
//  4. Podstawienie wsteczne (back substitution) wyznaczające potencjał w węzłach wewnętrznych.
//  5. Obliczenie natężenia pola elektrycznego metodą różnic centralnych oraz na brzegach.
//
// Parametry:
//   - rho1: wskaźnik do wektora gęstości ładunku przestrzennego w węzłach siatki [C/m^3].
//   - tt: aktualny fizyczny czas symulacji służący do obliczenia fazy napięcia RF [s].
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
	var g, w, f Xvector

	// 1. Warunki brzegowe Dirichleta dla potencjału na elektrodach (x = 0 oraz x = L)
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt)
	sim.Pot[N_G-1] = 0.0

	// 2. Przygotowanie prawej strony układu równań
	for i := 1; i <= N_G-2; i++ {
		f[i] = ALPHA * (*rho1)[i]
	}
	f[1] -= sim.Pot[0]
	f[N_G-2] -= sim.Pot[N_G-1]

	// 3. Algorytm Thomasa - faza eliminacji w przód
	w[1] = C / B
	g[1] = f[1] / B
	for i := 2; i <= N_G-2; i++ {
		w[i] = C / (B - A*w[i-1])
		g[i] = (f[i] - A*g[i-1]) / (B - A*w[i-1])
	}

	// 4. Algorytm Thomasa - faza podstawienia wstecznego
	sim.Pot[N_G-2] = g[N_G-2]
	for i := N_G - 3; i > 0; i-- {
		sim.Pot[i] = g[i] - w[i]*sim.Pot[i+1]
	}

	// 5. Wyznaczenie natężenia pola elektrycznego w węzłach wewnętrznych oraz na elektrodach
	for i := 1; i <= N_G-2; i++ {
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S
	}
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*DX/(2.0*EPSILON0)
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*DX/(2.0*EPSILON0)
}
