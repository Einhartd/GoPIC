//go:build !nullcollision

package gopic

/*
Inicjalizacja parametrów zderzeń w trybie standardowym (bezpośrednie próbkowanie).
W trybie standardowym funkcja nie wykonuje żadnych operacji.
*/
func (sim *SimulationState) InitNullCollision() {
	// Brak wstępnych obliczeń w trybie bezpośrednim
}

/*
KROK 7: Zderzenia elektronów metodą bezpośredniego próbkowania (Standard MCC).
Wariant równoległy Channels: rozesłanie rozkazu CmdCollisionsE do trwałych workerów.
Etapy:
 1. Rozesłanie rozkazu CmdCollisionsE do kanałów workerów (broadcastAndWait).
 2. Workery równolegle próbkują zderzenia dla swojego chunka elektronów i buforują nowe pary w AoS.
 3. Oczekiwanie na zakończenie pracy workerów w kanale WorkerDoneChan.
 4. Scalenie (flush) buforów workerów do głównych tablic SoA stanu symulacji.
*/
func (sim *SimulationState) Step7CollisionsElectrons() {
	sim.CandidatesE = nil

	// ZRÓWNOLEGLENIE: Rozesłanie rozkazu zderzeń elektronów do trwałych workerów
	sim.broadcastAndWait(CmdCollisionsE)

	// SCALENIE (FLUSH): Przepisanie nowych cząstek z buforów AoS do tablic SoA
	numWorkers := len(sim.WorkerCmdChan)
	for w := range numWorkers {
		for _, p := range sim.WorkerNewElectrons[w] {
			sim.X_e[sim.N_e] = p.X
			sim.Vx_e[sim.N_e] = p.Vx
			sim.Vy_e[sim.N_e] = p.Vy
			sim.Vz_e[sim.N_e] = p.Vz
			sim.N_e++
		}
		for _, p := range sim.WorkerNewIons[w] {
			sim.X_i[sim.N_i] = p.X
			sim.Vx_i[sim.N_i] = p.Vx
			sim.Vy_i[sim.N_i] = p.Vy
			sim.Vz_i[sim.N_i] = p.Vz
			sim.N_i++
		}
	}
}

/*
KROK 8: Zderzenia jonów metodą bezpośredniego próbkowania (Subcycling co N_SUB kroków).
Etapy:
 1. Sprawdzenie warunku subcyclingu (t % N_SUB == 0).
 2. Rozesłanie rozkazu CmdCollisionsI do kanałów workerów (broadcastAndWait).
 3. Workery równolegle próbkują zderzenia jonów z atomami tła w chunku.
@param t Indeks bieżącego podkroku czasowego w cyklu RF (0 .. N_T-1).
*/
func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}
	sim.CandidatesI = nil

	// ZRÓWNOLEGLENIE: Rozesłanie rozkazu zderzeń jonów do kanałów workerów
	sim.broadcastAndWait(CmdCollisionsI)
}
