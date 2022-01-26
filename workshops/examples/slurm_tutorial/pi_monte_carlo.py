import random, sys

def monte_carlo_pi(points):
   return 4 * sum(1 for _ in range(points) if random.random()**2 + random.random()**2 < 1) / float(points)

if __name__ == "__main__":
   print(monte_carlo_pi(int(sys.argv[1])))

