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
	// 1. Prędkość względna przed zderzeniem oraz prędkość środka masy (COM)
	gx := *vxe
	gy := *vye
	gz := *vze
	g_perp_sq := gy*gy + gz*gz
	g_sq := gx*gx + g_perp_sq
	g := math.Sqrt(g_sq)
	g_perp := math.Sqrt(g_perp_sq)

	wx := F1 * (*vxe)
	wy := F1 * (*vye)
	wz := F1 * (*vze)

	// 2. Kąty wektora prędkości — czysta algebra wektorowa (zamiast math.Atan2, sin, cos)
	var ct, st, cp, sp float64
	if g > 0.0 {
		ct = gx / g
		st = g_perp / g
	} else {
		ct = 1.0
		st = 0.0
	}

	if g_perp > 0.0 {
		cp = gy / g_perp
		sp = gz / g_perp
	} else {
		cp = 1.0
		sp = 0.0
	}

	// 3. Wybór typu zderzenia (Multiplicative Selection - eliminacja dzieleń)
	t0 := sim.Sigma[E_ELA][eindex]
	t1 := t0 + sim.Sigma[E_EXC][eindex]
	t2 := t1 + sim.Sigma[E_ION][eindex]
	rnd := sim.WorkerR01(workerID)
	r_t2 := rnd * t2

	eta := TWO_PI * sim.WorkerR01(workerID)
	se, ce := math.Sincos(eta)

	var sc, cc float64

	if r_t2 < t0 { // Zderzenie sprężyste (izotropowe)
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
	} else if r_t2 < t1 { // Wzbudzenie (niesprężyste, izotropowe)
		energy := HALF_E_MASS * g_sq
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
	} else { // Jonizacja (niesprężysta)
		energy := HALF_E_MASS * g_sq
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)

		// Energia wybitego elektronu wtórnego (rozkład wg formy różniczkowej Opla)
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
		e_sc := math.Abs(energy - e_ej)

		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)

		cc = math.Sqrt(e_sc / energy)
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))

		cc2 := math.Sqrt(e_ej / energy)
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))

		// Dla elektronu wybitego kąt azymutalny to eta + PI -> sin/cos zmieniają znak
		se2 := -se
		ce2 := -ce

		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)

		// Dodanie nowego elektronu wtórnego do bufora workera
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
			X:  xe,
			Vx: wx + F2*gx2,
			Vy: wy + F2*gy2,
			Vz: wz + F2*gz2,
		})

		// Dodanie nowego jonu Ar+ (prędkość z rozkładu RMB tła)
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
			X:  xe,
			Vx: sim.WorkerRMB(workerID),
			Vy: sim.WorkerRMB(workerID),
			Vz: sim.WorkerRMB(workerID),
		})
	}

	// 4. Rozproszenie elektronu pierwotnego (rotacja wektora prędkości)
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
Zoptymalizowana wersja z Fast-Path dla wymiany ładunku (I_BACK) oraz czystą algebrą wektorową.
*/
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
	// 1. Wybór procesu: rozpraszanie izotropowe vs wsteczne (wymiana ładunku)
	t1 := sim.Sigma[I_ISO][e_index]
	t2 := t1 + sim.Sigma[I_BACK][e_index]
	rnd := sim.WorkerR01(workerID)

	if rnd*t2 >= t1 {
		// FAST-PATH: Wymiana ładunku (Charge Exchange, I_BACK) - ~80% zderzeń jonów:
		// Nowy jon przejmuje prędkość atomu tła Ar bez zbędnej geometrii rozproszenia
		*vx_1 = *vx_2
		*vy_1 = *vy_2
		*vz_1 = *vz_2
		return
	}

	// 2. SLOW-PATH: Rozpraszanie sprężyste izotropowe (I_ISO) - ~20% zderzeń jonów
	gx := (*vx_1) - (*vx_2)
	gy := (*vy_1) - (*vy_2)
	gz := (*vz_1) - (*vz_2)
	g_perp_sq := gy*gy + gz*gz
	g_sq := gx*gx + g_perp_sq
	g := math.Sqrt(g_sq)
	g_perp := math.Sqrt(g_perp_sq)

	wx := 0.5 * ((*vx_1) + (*vx_2))
	wy := 0.5 * ((*vy_1) + (*vy_2))
	wz := 0.5 * ((*vz_1) + (*vz_2))

	var ct, st, cp, sp float64
	if g > 0.0 {
		ct = gx / g
		st = g_perp / g
	} else {
		ct = 1.0
		st = 0.0
	}

	if g_perp > 0.0 {
		cp = gy / g_perp
		sp = gz / g_perp
	} else {
		cp = 1.0
		sp = 0.0
	}

	cc := 1.0 - 2.0*sim.WorkerR01(workerID)
	sc := math.Sqrt(max(0.0, 1.0-cc*cc))

	eta := TWO_PI * sim.WorkerR01(workerID)
	se, ce := math.Sincos(eta)

	// Transformacja wektora prędkości względnej
	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	// Nowa prędkość jonu w układzie laboratoryjnym
	*vx_1 = wx + 0.5*gx
	*vy_1 = wy + 0.5*gy
	*vz_1 = wz + 0.5*gz
}
