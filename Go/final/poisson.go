package gopic

import (
	"math"
)

// SolvePoisson rozwiązuje jednowymiarowe równanie Poissona (d^2 phi / dx^2 = -rho / epsilon_0)
// za pomocą zoptymalizowanego algorytmu Thomasa z prekalkulowanymi współczynnikami ThomasW,
// a następnie wyznacza natężenie pola elektrycznego E = -d(phi)/dx w węzłach siatki.
//
// Etapy:
//  1. Zastosowanie warunków brzegowych Dirichleta dla potencjału na elektrodach.
//  2. Przygotowanie wektora prawej strony układu równań z poprawkami brzegowymi.
//  3. Eliminacja w przód (forward elimination) bez operacji dzielenia dzięki tablicy ThomasW.
//  4. Podstawienie wsteczne (back substitution) wyznaczające potencjał w węzłach wewnętrznych.
//  5. Obliczenie natężenia pola elektrycznego metodą różnic centralnych oraz na brzegach.
//
// Parametry:
//   - rho1: wskaźnik do wektora gęstości ładunku przestrzennego w węzłach siatki [C/m^3].
//   - tt: aktualny fizyczny czas symulacji służący do obliczenia fazy napięcia RF [s].
func (sim *SimulationState) SolvePoisson(rho1 *Xvector, tt float64) {
	var g, f Xvector

	// 1. Warunki brzegowe Dirichleta dla potencjału na elektrodzie zasilanej (x = 0) i uziemionej (x = L)
	sim.Pot[0] = VOLTAGE * math.Cos(OMEGA*tt)
	sim.Pot[N_G-1] = 0.0

	// 2. Przygotowanie prawej strony układu równań
	for i := 1; i <= N_G-2; i++ {
		f[i] = ALPHA * (*rho1)[i]
	}
	f[1] -= sim.Pot[0]
	f[N_G-2] -= sim.Pot[N_G-1]

	// 3. Algorytm Thomasa - faza eliminacji w przód z wykorzystaniem prekalkulowanego wektora ThomasW
	g[1] = f[1] * sim.ThomasW[1]
	for i := 2; i <= N_G-2; i++ {
		g[i] = (f[i] - g[i-1]) * sim.ThomasW[i]
	}

	// 4. Algorytm Thomasa - faza podstawienia wstecznego wyznaczająca potencjał w węzłach
	sim.Pot[N_G-2] = g[N_G-2]
	for i := N_G - 3; i > 0; i-- {
		sim.Pot[i] = g[i] - sim.ThomasW[i]*sim.Pot[i+1]
	}

	// 5. Wyznaczenie natężenia pola elektrycznego w węzłach wewnętrznych oraz na elektrodach
	for i := 1; i <= N_G-2; i++ {
		sim.Efield[i] = (sim.Pot[i-1] - sim.Pot[i+1]) * S
	}
	sim.Efield[0] = (sim.Pot[0]-sim.Pot[1])*INV_DX - (*rho1)[0]*BETA
	sim.Efield[N_G-1] = (sim.Pot[N_G-2]-sim.Pot[N_G-1])*INV_DX + (*rho1)[N_G-1]*BETA
}
