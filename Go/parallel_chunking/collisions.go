package gopic

import (
	"math"
)

/*
Obsługa pojedynczego zderzenia elektronu z neutralnym atomem argonu (MCC).
Przybliżenie zimnego gazu (prędkość atomu argonu pomijana w porównaniu z elektronem).
Etapy:
 1. Obliczenie prędkości względnej g oraz prędkości środka masy w.
 2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości przed zderzeniem.
 3. Losowanie typu procesu (sprężyste, wzbudzenie, jonizacja) na podstawie przekrojów czynnych.
 4. Obliczenie strat energii dla procesów niesprężystych i kątów rozproszenia (chi, eta).
 5. W przypadku jonizacji: dodanie elektronu wtórnego i jonu Ar+ do lokalnych buforów workera.
 6. Transformacja kątowa prędkości elektronu pierwotnego po zderzeniu.
@param xe       Pozycja 1D zderzającego się elektronu [m].
@param vxe, vye, vze  Wskaźniki do składowych prędkości elektronu (modyfikowane in-place).
@param eindex   Indeks przedziału energii w tabelach przekrojów czynnych.
@param workerID Identyfikator workera (goroutine) do izolowanego losowania liczb i buforów.
*/
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
	var t0, t1, t2, rnd float64
	var g, g2, gx, gy, gz, wx, wy, wz, theta, phi float64
	var chi, eta, chi2, eta2, sc, cc, se, ce, st, ct, sp, cp, energy, e_sc, e_ej float64

	// 1. Prędkość względna przed zderzeniem oraz prędkość środka masy (COM)
	gx = *vxe
	gy = *vye
	gz = *vze
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
	wx = F1 * (*vxe)
	wy = F1 * (*vye)
	wz = F1 * (*vze)

	// 2. Kąty Eulera wektora prędkości
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

	// 3. Wybór typu zderzenia na podstawie skumulowanych przekrojów czynnych
	t0 = sim.Sigma[E_ELA][eindex]
	t1 = t0 + sim.Sigma[E_EXC][eindex]
	t2 = t1 + sim.Sigma[E_ION][eindex]
	rnd = sim.WorkerR01(workerID)
	if rnd < (t0 / t2) { // Zderzenie sprężyste
		chi = math.Acos(1.0 - 2.0*sim.WorkerR01(workerID)) // Rozpraszanie izotropowe
		eta = TWO_PI * sim.WorkerR01(workerID)             // Kąt azymutalny
	} else if rnd < (t1 / t2) { // Wzbudzenie (niesprężyste)
		energy = 0.5 * E_MASS * g * g
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)       // Odjęcie progu wzbudzenia (11.5 eV)
		g = math.Sqrt(2.0 * energy / E_MASS)               // Prędkość względna po stracie energii
		chi = math.Acos(1.0 - 2.0*sim.WorkerR01(workerID)) // Rozpraszanie izotropowe
		eta = TWO_PI * sim.WorkerR01(workerID)             // Kąt azymutalny
	} else { // Jonizacja (niesprężysta)
		energy = 0.5 * E_MASS * g * g
		energy = math.Abs(energy - E_ION_TH*EV_TO_J) // Odjęcie progu jonizacji (15.8 eV)

		// Energia wybitego elektronu wtórnego (rozkład wg formy różniczkowej Opla)
		e_ej = 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy/EV_TO_J/20.0)) * EV_TO_J
		
		e_sc = math.Abs(energy - e_ej) // Pozostała energia elektronu rozproszonego
		g = math.Sqrt(2.0 * e_sc / E_MASS)
		g2 = math.Sqrt(2.0 * e_ej / E_MASS)
		chi = math.Acos(math.Sqrt(e_sc / energy))
		chi2 = math.Acos(math.Sqrt(e_ej / energy))
		eta = TWO_PI * sim.WorkerR01(workerID)
		eta2 = eta + PI
		sc = math.Sin(chi2)
		cc = math.Cos(chi2)
		se = math.Sin(eta2)
		ce = math.Cos(eta2)
		gx = g2 * (ct*cc - st*sc*ce)
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

		// Dodanie nowego elektronu wtórnego do bufora workera
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
			X:  xe,
			Vx: wx + F2*gx,
			Vy: wy + F2*gy,
			Vz: wz + F2*gz,
		})

		// Dodanie nowego jonu Ar+ (prędkość losowana z rozkładu RMB tła)
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
			X:  xe,
			Vx: sim.WorkerRMB(workerID),
			Vy: sim.WorkerRMB(workerID),
			Vz: sim.WorkerRMB(workerID),
		})
	}

	// 4. Rozproszenie elektronu pierwotnego (rotacja wektora prędkości)
	sc = math.Sin(chi)
	cc = math.Cos(chi)
	se = math.Sin(eta)
	ce = math.Cos(eta)

	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	// Końcowa prędkość elektronu po zderzeniu w układzie laboratoryjnym
	*vxe = wx + F2*gx
	*vye = wy + F2*gy
	*vze = wz + F2*gz
}

/*
Obsługa pojedynczego zderzenia jonu Ar+ z neutralnym atomem argonu (MCC).
Uwzględnia prędkość termiczną tła atomowego (przekazaną w parametrach vx_2..vz_2).
Etapy:
 1. Obliczenie prędkości względnej g oraz prędkości środka masy w (masy obu cząstek równe).
 2. Wyznaczenie kątów Eulera (theta, phi) wektora prędkości względnej.
 3. Wybór typu zderzenia na podstawie przekrojów czynnych (izotropowe vs wsteczna wymiana ładunku).
 4. Transformacja kątowa i wyznaczenie nowej prędkości jonu w układzie laboratoryjnym.
@param vx_1, vy_1, vz_1 Wskaźniki do składowych prędkości jonu (modyfikowane in-place).
@param vx_2, vy_2, vz_2 Wskaźniki do składowych prędkości atomu tła (z rozkładu RMB).
@param e_index          Indeks energii w układzie środka masy w tabelach przekrojów.
@param workerID         Identyfikator workera (goroutine).
*/
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
	var g, gx, gy, gz, wx, wy, wz, rnd float64
	var theta, phi, chi, eta, st, ct, sp, cp, sc, cc, se, ce, t1, t2 float64

	// 1. Prędkość względna g oraz prędkość środka masy w
	gx = (*vx_1) - (*vx_2)
	gy = (*vy_1) - (*vy_2)
	gz = (*vz_1) - (*vz_2)
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
	wx = 0.5 * ((*vx_1) + (*vx_2))
	wy = 0.5 * ((*vy_1) + (*vy_2))
	wz = 0.5 * ((*vz_1) + (*vz_2))

	// 2. Kąty Eulera
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

	// 3. Wybór procesu: rozpraszanie izotropowe vs wsteczne (wymiana ładunku)
	t1 = sim.Sigma[I_ISO][e_index]
	t2 = t1 + sim.Sigma[I_BACK][e_index]
	rnd = sim.WorkerR01(workerID)
	if rnd < (t1 / t2) { // Rozpraszanie izotropowe
		chi = math.Acos(1.0 - 2.0*sim.WorkerR01(workerID))
	} else { // Rozpraszanie wsteczne (wymiana ładunku Charge Exchange)
		chi = PI
	}
	eta = TWO_PI * sim.WorkerR01(workerID)
	sc = math.Sin(chi)
	cc = math.Cos(chi)
	se = math.Sin(eta)
	ce = math.Cos(eta)
	st = math.Sin(theta)
	ct = math.Cos(theta)
	sp = math.Sin(phi)
	cp = math.Cos(phi)

	// 4. Transformacja prędkości i wyznaczenie nowej prędkości jonu
	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	// Nowa prędkość jonu w układzie laboratoryjnym
	*vx_1 = wx + 0.5*gx
	*vy_1 = wy + 0.5*gy
	*vz_1 = wz + 0.5*gz
}
