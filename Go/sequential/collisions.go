package gopic

import (
	"math"
)

// CollisionElectron realizuje pojedyncze zderzenie elektronu z neutralnym atomem argonu (MCC)
// w przybliżeniu zimnego gazu, wykorzystując klasyczną parametryzację trygonometryczną kątów Eulera.
//
// Etapy:
//  1. Obliczenie prędkości względnej g oraz prędkości środka masy w.
//  2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości przed zderzeniem.
//  3. Losowanie rodzaju procesu (rozpraszanie sprężyste, wzbudzenie, jonizacja) na podstawie przekrojów czynnych.
//  4. W przypadku jonizacji: utworzenie nowego elektronu wtórnego oraz jonu Ar+ o prędkości termicznej.
//  5. Rotacja wektora prędkości elektronu rozproszonego i transformacja do układu laboratoryjnego.
//
// Parametry:
//   - xe: pozycja 1D zderzającego się elektronu [m].
//   - vxe: wskaźnik do składowej prędkości elektronu wzdłuż osi x [m/s].
//   - vye: wskaźnik do składowej prędkości elektronu wzdłuż osi y [m/s].
//   - vze: wskaźnik do składowej prędkości elektronu wzdłuż osi z [m/s].
//   - eindex: indeks energii kinetycznej w tablicach przekrojów czynnych.
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int) {
	var t0, t1, t2, rnd float64
	var g, g2, gx, gy, gz, wx, wy, wz, theta, phi float64
	var chi, eta, chi2, eta2, sc, cc, se, ce, st, ct, sp, cp, energy, e_sc, e_ej float64

	// 1. Obliczenie prędkości względnej przed zderzeniem oraz prędkości środka masy
	gx = *vxe
	gy = *vye
	gz = *vze
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
	wx = F1 * (*vxe)
	wy = F1 * (*vye)
	wz = F1 * (*vze)

	// 2. Wyznaczenie kątów Eulera (theta, phi) opisujących orientację prędkości przed zderzeniem
	if gx == 0 {
		theta = 0.5 * PI
	} else {
		theta = math.Atan2(math.Sqrt(gy*gy+gz*gz), gx)
	}
	if gy == 0 {
		if gz > 0 {
			phi = 0.5 * PI
		} else {
			phi = -0.5 * PI
		}
	} else {
		phi = math.Atan2(gz, gy)
	}
	st = math.Sin(theta)
	ct = math.Cos(theta)
	sp = math.Sin(phi)
	cp = math.Cos(phi)

	// 3. Wybór procesu zderzeniowego na podstawie skumulowanych przekrojów czynnych
	t0 = sim.Sigma[E_ELA][eindex]
	t1 = t0 + sim.Sigma[E_EXC][eindex]
	t2 = t1 + sim.Sigma[E_ION][eindex]
	rnd = sim.R01()
	if rnd < (t0 / t2) {
		// Zderzenie sprężyste: izotropowe rozproszenie bez straty energii w układzie COM
		chi = math.Acos(1.0 - 2.0*sim.R01())
		eta = TWO_PI * sim.R01()
	} else if rnd < (t1 / t2) {
		// Wzbudzenie elektronowe: odjęcie progu energii wzbudzenia E_EXC_TH i izotropowe rozproszenie
		energy = 0.5 * E_MASS * g * g
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
		g = math.Sqrt(2.0 * energy / E_MASS)
		chi = math.Acos(1.0 - 2.0*sim.R01())
		eta = TWO_PI * sim.R01()
	} else {
		// Jonizacja uderzeniowa: odjęcie progu E_ION_TH i podział energii według rozkładu Opla
		energy = 0.5 * E_MASS * g * g
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)
		e_ej = 10.0 * math.Tan(sim.R01()*math.Atan(energy/EV_TO_J/20.0)) * EV_TO_J
		e_sc = math.Abs(energy - e_ej)
		g = math.Sqrt(2.0 * e_sc / E_MASS)
		g2 = math.Sqrt(2.0 * e_ej / E_MASS)
		chi = math.Acos(math.Sqrt(e_sc / energy))
		chi2 = math.Acos(math.Sqrt(e_ej / energy))
		eta = TWO_PI * sim.R01()
		eta2 = eta + PI

		// 4. Obliczenie prędkości i dodanie nowego elektronu wtórnego oraz jonu Ar+ do tablic stanu
		sc = math.Sin(chi2)
		cc = math.Cos(chi2)
		se = math.Sin(eta2)
		ce = math.Cos(eta2)
		gx = g2 * (ct*cc - st*sc*ce)
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
		sim.X_e[sim.N_e] = xe
		sim.Vx_e[sim.N_e] = wx + F2*gx
		sim.Vy_e[sim.N_e] = wy + F2*gy
		sim.Vz_e[sim.N_e] = wz + F2*gz
		sim.N_e++
		sim.X_i[sim.N_i] = xe
		sim.Vx_i[sim.N_i] = sim.RMB()
		sim.Vy_i[sim.N_i] = sim.RMB()
		sim.Vz_i[sim.N_i] = sim.RMB()
		sim.N_i++
	}

	// 5. Transformacja kątowa prędkości elektronu pierwotnego po zderzeniu
	sc = math.Sin(chi)
	cc = math.Cos(chi)
	se = math.Sin(eta)
	ce = math.Cos(eta)

	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	*vxe = wx + F2*gx
	*vye = wy + F2*gy
	*vze = wz + F2*gz
}

// CollisionIon realizuje pojedyncze zderzenie jonu argonu Ar+ z neutralnym atomem tła Ar (MCC),
// uwzględniając losową prędkość termiczną atomu tła oraz rozróżniając rozpraszanie izotropowe i wsteczne.
//
// Etapy:
//  1. Obliczenie prędkości względnej g oraz prędkości środka masy w dla cząstek o równych masach.
//  2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości względnej przed zderzeniem.
//  3. Losowanie rodzaju procesu: izotropowe rozpraszanie sprężyste (I_ISO) lub wsteczne (I_BACK, chi = PI).
//  4. Rotacja wektora prędkości względnej i wyznaczenie nowej prędkości jonu w układzie laboratoryjnym.
//
// Parametry:
//   - vx_1: wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi x [m/s].
//   - vy_1: wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi y [m/s].
//   - vz_1: wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi z [m/s].
//   - vx_2: wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi x [m/s].
//   - vy_2: wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi y [m/s].
//   - vz_2: wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi z [m/s].
//   - e_index: indeks energii zderzenia w układzie środka masy w tablicach przekrojów czynnych.
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int) {
	var g, gx, gy, gz, wx, wy, wz, rnd float64
	var theta, phi, chi, eta, st, ct, sp, cp, sc, cc, se, ce, t1, t2 float64

	// 1. Obliczenie prędkości względnej oraz prędkości środka masy
	gx = (*vx_1) - (*vx_2)
	gy = (*vy_1) - (*vy_2)
	gz = (*vz_1) - (*vz_2)
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
	wx = 0.5 * ((*vx_1) + (*vx_2))
	wy = 0.5 * ((*vy_1) + (*vy_2))
	wz = 0.5 * ((*vz_1) + (*vz_2))

	// 2. Wyznaczenie kątów Eulera (theta, phi)
	if gx == 0 {
		theta = 0.5 * PI
	} else {
		theta = math.Atan2(math.Sqrt(gy*gy+gz*gz), gx)
	}
	if gy == 0 {
		if gz > 0 {
			phi = 0.5 * PI
		} else {
			phi = -0.5 * PI
		}
	} else {
		phi = math.Atan2(gz, gy)
	}

	// 3. Wybór typu zderzenia (rozpraszanie izotropowe lub wsteczne) i losowanie kątów rozproszenia
	t1 = sim.Sigma[I_ISO][e_index]
	t2 = t1 + sim.Sigma[I_BACK][e_index]
	rnd = sim.R01()
	if rnd < (t1 / t2) {
		chi = math.Acos(1.0 - 2.0*sim.R01())
	} else {
		chi = PI
	}
	eta = TWO_PI * sim.R01()
	sc = math.Sin(chi)
	cc = math.Cos(chi)
	se = math.Sin(eta)
	ce = math.Cos(eta)
	st = math.Sin(theta)
	ct = math.Cos(theta)
	sp = math.Sin(phi)
	cp = math.Cos(phi)

	// 4. Obliczenie nowej prędkości względnej oraz prędkości jonu po zderzeniu
	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	*vx_1 = wx + 0.5*gx
	*vy_1 = wy + 0.5*gy
	*vz_1 = wz + 0.5*gz
}
