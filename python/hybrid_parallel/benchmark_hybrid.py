import time
import os
import sys
import subprocess

checkpoint_path = "/home/oliwier/Dev/GoPIC/plots/hpc_logs/default-collision/saved_logs_python/logs_job_5420757_STAT_numba/edupic_data/picdata.bin"

configs = [
    (1, 8),  # 1 MPI process x 8 Numba threads
    (2, 4),  # 2 MPI processes x 4 Numba threads
    (4, 2),  # 4 MPI processes x 2 Numba threads
    (8, 1),  # 8 MPI processes x 1 Numba thread
]

print("═══════════════════════════════════════════════════════════")
print("  eduPIC Hybrid MPI+Numba Benchmark (Checkpoint 1001)")
print("═══════════════════════════════════════════════════════════\n")

for n_mpi, n_threads in configs:
    env = os.environ.copy()
    env["NUMBA_NUM_THREADS"] = str(n_threads)
    
    subprocess.run(["cp", checkpoint_path, "picdata.bin"], cwd="/home/oliwier/Dev/GoPIC/python/hybrid_parallel", check=True)
    
    cmd = ["mpirun", "--oversubscribe", "-np", str(n_mpi), "./.venv/bin/python", "main.py", "1"]
    subprocess.run(cmd, cwd="/home/oliwier/Dev/GoPIC/python/hybrid_parallel", env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=True)
    
    start_time = time.perf_counter()
    subprocess.run(cmd, cwd="/home/oliwier/Dev/GoPIC/python/hybrid_parallel", env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=True)
    elapsed = time.perf_counter() - start_time
    
    print(f"MPI Ranks: {n_mpi:2d} | Numba Threads: {n_threads:2d} | Time per cycle: {elapsed:8.4f} s")

print("\n═══════════════════════════════════════════════════════════")
