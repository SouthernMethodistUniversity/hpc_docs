# MPI Example

## Build

```{sh}
module purge
module load gcc-9.2 hpcx # or another MPI installation
mpicc -std=c11 -O3 -o mpi_monte_carlo_pi mpi_monte_carlo_pi.c -lm
```

