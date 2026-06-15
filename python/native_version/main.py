import constants as cs
from state import SimulationState
import math

def init(sim: SimulationState, nseed: int):
    """
    Inicjalizacja symulacji poprzez umieszczenie danej ilosci
    elektronow i jonow w losowych pozycjach miedzy elektrodami
    """
    
    for i in range(nseed):
        sim.x_e[i] = cs.L * sim.rng.random()
        sim.vx_e[i] = 0
        sim.vy_e[i] = 0
        sim.vz_e[i] = 0
        
        sim.x_i[i] = cs.L * sim.rng.random()
        sim.vx_i[i] = 0
        sim.vy_i[i] = 0
        sim.vz_i[i] = 0
        
    sim.N_e = nseed
    sim.N_i = nseed
    
    