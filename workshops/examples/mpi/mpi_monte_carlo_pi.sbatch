#!/bin/bash
#SBATCH -J mpi_pi            # Job name
#SBATCH -o mpi_pi_%j.out     # Output file name
#SBATCH -p development       # Queue (partition)
#SBATCH -N 2                 # Nodes
#SBATCH --ntasks-per-node=2  # Tasks/node
#SBATCH --mem=6G             # Memory
#SBATCH -t 5                 # Time limit

echo $SLURM_JOB_PARTITION

module purge
module load gcc-9.2 hpcx

srun mpi_monte_carlo_pi 10000

