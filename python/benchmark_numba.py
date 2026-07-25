#!/usr/bin/env python3
"""
Benchmark script comparing numba_version (sequential) vs numba_parallel (multi-threaded).
Measures wall clock execution time and speedup. Fallback to direct Python if perf stat is restricted.
"""

import os
import sys
import time
import subprocess

ROOT_DIR = os.path.abspath(os.path.dirname(__file__))

def run_single_benchmark(version: str, num_threads: int, n_particles: int = 100000):
    env = os.environ.copy()
    env["NUMBA_NUM_THREADS"] = str(num_threads)
    
    # Python runner script file
    script_path = os.path.join(ROOT_DIR, "temp_bench_runner.py")
    with open(script_path, "w") as f:
        f.write(f"""
import sys, os
version_dir = os.path.join('{ROOT_DIR}', '{version}')
sys.path.insert(0, version_dir)

import state, simulation, io_manager, main, cross_sections, collisions, constants as cs, time

sim = state.SimulationState()
cross_sections.set_electron_cross_sections_ar(sim)
cross_sections.set_ion_cross_sections_ar(sim)
cross_sections.calc_total_cross_sections(sim)

if cs.USE_NULL_COLLISION:
    collisions.compute_null_collision_params(sim)

main.init(sim, {n_particles})

# Warmup JIT compilation (1 cycle without timing)
print(">> Warmup cycle...")
simulation.do_one_cycle(sim, "temp_bench_conv.dat")

# Benchmark cycle
print(">> Benchmark cycle...")
t0 = time.perf_counter()
simulation.do_one_cycle(sim, "temp_bench_conv.dat")
t1 = time.perf_counter()

print(f"WALL_TIME: {{t1 - t0:.4f}}")
""")

    # Try running directly with Python
    cmd = [sys.executable, script_path]
    
    try:
        res = subprocess.run(cmd, env=env, capture_output=True, text=True, check=True)
        out = res.stdout + "\n" + res.stderr
    except subprocess.CalledProcessError as e:
        out = e.stdout + "\n" + e.stderr

    # Clean up temp files
    if os.path.exists("temp_bench_conv.dat"):
        os.remove("temp_bench_conv.dat")
    if os.path.exists(script_path):
        os.remove(script_path)

    # Extract wall time
    wall_time = 0.0
    for line in out.splitlines():
        if "WALL_TIME:" in line:
            try:
                wall_time = float(line.split(":")[1].strip())
            except ValueError:
                pass
            break

    return wall_time, out

def main_bench():
    print("=" * 75)
    print("      GoPIC Python PIC Simulation — Numba Parallel Benchmark      ")
    print("=" * 75)
    print("Uruchamianie 1 pełnego cyklu RF (4000 kroków, 100,000 cząstek)...\n")
    
    # 1. Baseline: numba_version (1 thread)
    print("[1/6] Running Baseline: numba_version (Sequential, 1 thread)...")
    base_time, base_perf = run_single_benchmark("numba_version", 1)
    print(f"  -> Baseline Wall Time: {base_time:.3f} s")
    
    thread_counts = [1, 2, 4, 8, 12]
    results = []
    
    for tc in thread_counts:
        print(f"\n[{thread_counts.index(tc)+2}/6] Running numba_parallel with NUMBA_NUM_THREADS={tc}...")
        wtime, perf_log = run_single_benchmark("numba_parallel", tc)
        speedup = base_time / wtime if wtime > 0 else 0.0
        efficiency = (speedup / tc) * 100.0
        results.append((tc, wtime, speedup, efficiency, perf_log))
        print(f"  -> Wall Time: {wtime:.3f} s | Speedup: {speedup:.2f}x | Efektywność: {efficiency:.1f}%")
        
    print("\n" + "=" * 75)
    print("                      PODSUMOWANIE WYNIKÓW                        ")
    print("=" * 75)
    print(f"{'Wersja / Wątki':<28} | {'Czas [s]':<10} | {'Speedup':<10} | {'Efektywność':<12}")
    print("-" * 75)
    print(f"{'numba_version (1 thread)':<28} | {base_time:<10.3f} | {'1.00x':<10} | {'100.0%':<12}")
    for tc, wtime, sp, eff, _ in results:
        print(f"{f'numba_parallel ({tc} threads)':<28} | {wtime:<10.3f} | {f'{sp:.2f}x':<10} | {f'{eff:.1f}%':<12}")
    print("=" * 75)

if __name__ == "__main__":
    main_bench()
