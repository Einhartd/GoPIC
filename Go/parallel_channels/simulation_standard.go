//go:build !nullcollision

package gopic

// InitNullCollision does nothing in standard mode.
func (sim *SimulationState) InitNullCollision() {
	// No initialization needed for standard collisions
}

func (sim *SimulationState) Step7CollisionsElectrons() {
	sim.CandidatesE = nil
	sim.broadcastAndWait(CmdCollisionsE)

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

func (sim *SimulationState) Step8CollisionIons(t int) {
	if (t % N_SUB) != 0 {
		return
	}
	sim.CandidatesI = nil
	sim.broadcastAndWait(CmdCollisionsI)
}
