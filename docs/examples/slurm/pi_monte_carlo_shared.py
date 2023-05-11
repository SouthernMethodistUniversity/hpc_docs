import random, sys
import multiprocessing as mp

def check_point(points):
   return sum(1 for _ in range(points) if random.random()**2 + random.random()**2 < 1)

def parallel_monte_carlo_pi(points, cores):
   points_per_core = int(points / cores)
   n = [points_per_core] * cores
   n[0] = points_per_core + (points - (points_per_core * cores))
   pool = mp.Pool(processes = cores)
   results = pool.map(check_point, n)
   return 4 * sum(results) / float(points)

if __name__ == "__main__":
   print(parallel_monte_carlo_pi(int(sys.argv[1]), int(sys.argv[2])))

