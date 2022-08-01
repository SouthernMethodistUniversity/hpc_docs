#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include "mpi.h"

double random_double(void);
double get_hits(uint64_t points);

int main(int argc, char *argv[]) {
   if (argc != 2) {
      printf("Requires number of points.");
      return 1;
   }
   int num_tasks, rank, rc;
   uint64_t n, points, task_hits, hits;
   rc = MPI_Init(&argc, &argv);
   if (rc != 0) printf("Problem with MPI initialization.");
   rc = MPI_Comm_size(MPI_COMM_WORLD, &num_tasks);
   if (rc != 0) printf("Problem with getting size of MPI_COMM_WORLD.");
   rc = MPI_Comm_rank(MPI_COMM_WORLD, &rank);
   if (rc != 0) printf("Problem with getting process rank.");
   n = (uint64_t)atoi(argv[1]);
   points = (uint64_t)floor((double)n / (double)num_tasks);
   if (rank == 0) points += (uint64_t)(n % num_tasks);
   task_hits = get_hits(points);
   rc = MPI_Reduce(&task_hits, &hits, 1, MPI_UINT64_T, MPI_SUM, 0, MPI_COMM_WORLD);
   if (rc != 0) printf("Problem with reduction.");
   if (rank == 0) {
      printf("Estimated Pi: %f\n", 4.0 * (double)hits / (double)n);
   }
   rc = MPI_Finalize();
   if (rc != 0) printf("Problem with finalization.");
}

double random_double(void) {
   double n = rand();
   return n / (double)RAND_MAX;
}

double get_hits(uint64_t points) {
   uint64_t hits = 0;
   for (uint64_t i = 0; i < points; i++) {
      if (pow(random_double(), 2) + pow(random_double(), 2) < 1) {
         hits++;
      }
   }
   return hits;
}

