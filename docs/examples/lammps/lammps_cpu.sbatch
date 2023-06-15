#!/bin/bash
#SBATCH -J lammps                      # Job name
#SBATCH -o lammps_%j.out               # Output file name
#SBATCH -p dev                         # Partition (queue)
#SBATCH -N 1                           # Number of nodes
#SBATCH -n 1                           # Number of tasks
#SBATCH -c 1                           # Number of cores per task
#SBATCH --mem=24G                      # Memory per node

module purge                           # Unload all modules
module load gcc lammps                 # Load LAMMPS

srun lmp\
 -in lammps_cpu.in

