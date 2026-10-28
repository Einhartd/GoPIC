package gopic

import (
	"math"
)

// CollisionElectron realizuje pojedyncze zderzenie elektronu z neutralnym atomem argonu (MCC)
// w przybliżeniu zimnego gazu. Wykorzystuje zoptymalizowaną parametryzację algebraiczną
// (eliminującą wywołania atan2 i acos) oraz dopisuje cząstki wtórne z jonizacji do prywatnych
// buforów workera wykonującego obliczenia.
//
// Etapy:
//  1. Obliczenie prędkości względnej g, składowej prostopadłej g_perp oraz prędkości środka masy w.
//  2. Algebraiczne wyznaczenie sinusów i cosinusów kątów orientacji (ct, st, cp, sp) z ułamków składowych prędkości.
//  3. Losowanie rodzaju procesu (rozpraszanie sprężyste, wzbudzenie, jonizacja) na podstawie przekrojów czynnych.
//  4. W przypadku jonizacji: utworzenie nowego elektronu wtórnego oraz jonu Ar+ w prywatnych buforach workera.
//  5. Rotacja wektora prędkości elektronu rozproszonego i transformacja do układu laboratoryjnego.
//
// Parametry:
//   - xe: pozycja 1D zderzającego się elektronu [m].
//   - vxe: wskaźnik do składowej prędkości elektronu wzdłuż osi x [m/s].
//   - vye: wskaźnik do składowej prędkości elektronu wzdłuż osi y [m/s].
//   - vze: wskaźnik do składowej prędkości elektronu wzdłuż osi z [m/s].
//   - eindex: indeks energii kinetycznej w tablicach przekrojów czynnych.
//   - workerID: identyfikator workera wykonującego zderzenie (0 .. NumWorkers-1).
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
	// 1. Obliczenie prędkości względnej przed zderzeniem oraz prędkości środka masy (COM)
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

	// 2. Algebraiczne wyznaczenie funkcji trygonometrycznych kątów orientacji (zamiast math.Atan2, Sin, Cos)
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

	// 3. Wybór procesu zderzeniowego na podstawie skumulowanych przekrojów czynnych
	t0 := sim.Sigma[E_ELA][eindex]
	t1 := t0 + sim.Sigma[E_EXC][eindex]
	t2 := t1 + sim.Sigma[E_ION][eindex]
	rnd := sim.WorkerR01(workerID)
	r_t2 := rnd * t2

	eta := TWO_PI * sim.WorkerR01(workerID)
	se, ce := math.Sincos(eta)

	var sc, cc float64

	if r_t2 < t0 {
		// Zderzenie sprężyste: bezpośrednie losowanie cos(chi) oraz algebraiczne wyznaczenie sin(chi)
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
	} else if r_t2 < t1 {
		// Wzbudzenie elektronowe: pomniejszenie energii o próg E_EXC_TH i izotropowe rozproszenie
		energy := HALF_E_MASS * g_sq
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
	} else {
		// Jonizacja uderzeniowa: pomniejszenie energii o próg E_ION_TH i podział energii wg rozkładu Opla
		energy := HALF_E_MASS * g_sq
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)

		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
		e_sc := math.Abs(energy - e_ej)

		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)

		cc = math.Sqrt(e_sc / energy)
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))

		cc2 := math.Sqrt(e_ej / energy)
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))

		// Dla elektronu wybitego kąt azymutalny wynosi eta + PI, więc sin i cos zmieniają znak
		se2 := -se
		ce2 := -ce

		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)

		// 4. Zapis nowego elektronu wtórnego oraz jonu Ar+ do prywatnych buforów workera
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
			X:  xe,
			Vx: wx + F2*gx2,
			Vy: wy + F2*gy2,
			Vz: wz + F2*gz2,
		})

		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
			X:  xe,
			Vx: sim.WorkerRMB(workerID),
			Vy: sim.WorkerRMB(workerID),
			Vz: sim.WorkerRMB(workerID),
		})
	}

	// 5. Transformacja kątowa prędkości elektronu pierwotnego po zderzeniu
	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	*vxe = wx + F2*gx
	*vye = wy + F2*gy
	*vze = wz + F2*gz
}

// CollisionIon realizuje pojedyncze zderzenie jonu argonu Ar+ z neutralnym atomem tła Ar (MCC).
// Wykorzystuje szybki skrót dla wymiany ładunku (I_BACK) oraz algebraiczną transformację
// kątową bez funkcji trygonometrycznych atan2 i acos dla rozpraszania izotropowego (I_ISO).
//
// Etapy:
//  1. Losowanie typu procesu: wymiana ładunku (I_BACK) lub rozpraszanie izotropowe (I_ISO).
//  2. W przypadku wymiany ładunku: bezpośrednie przypisanie prędkości termicznej atomu tła do jonu.
//  3. W przypadku rozpraszania izotropowego: algebraiczny obrót wektora prędkości względnej w układzie COM.
//
// Parametry:
//   - vx_1: wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi x [m/s].
//   - vy_1: wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi y [m/s].
//   - vz_1: wskaźnik do składowej prędkości jonu Ar+ wzdłuż osi z [m/s].
//   - vx_2: wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi x [m/s].
//   - vy_2: wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi y [m/s].
//   - vz_2: wskaźnik do składowej prędkości termicznej atomu tła Ar wzdłuż osi z [m/s].
//   - e_index: indeks energii zderzenia w układzie środka masy w tablicach przekrojów czynnych.
//   - workerID: identyfikator workera wykonującego zderzenie (0 .. NumWorkers-1).
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
	// 1. Wybór procesu: rozpraszanie izotropowe (I_ISO) lub wsteczne / wymiana ładunku (I_BACK)
	t1 := sim.Sigma[I_ISO][e_index]
	t2 := t1 + sim.Sigma[I_BACK][e_index]
	rnd := sim.WorkerR01(workerID)

	// 2. Wymiana ładunku (chi = PI): jon przejmuje prędkość termiczną neutralnego atomu tła
	if rnd*t2 >= t1 {
		*vx_1 = *vx_2
		*vy_1 = *vy_2
		*vz_1 = *vz_2
		return
	}

	// 3. Rozpraszanie sprężyste izotropowe: algebraiczne wyznaczenie kątów i rotacja prędkości względnej
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

	// Transformacja wektora prędkości względnej i wyznaczenie nowej prędkości jonu w układzie laboratoryjnym
	gx = g * (ct*cc - st*sc*ce)
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)

	*vx_1 = wx + 0.5*gx
	*vy_1 = wy + 0.5*gy
	*vz_1 = wz + 0.5*gz
}
