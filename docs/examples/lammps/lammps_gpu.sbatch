#!/bin/bash
#SBATCH -J lammps                      # Job name
#SBATCH -o lammps_%j.out               # Output file name
#SBATCH -p batch                       # Partition (queue)
#SBATCH -N 1                           # Number of nodes
#SBATCH -n 1                           # Number of tasks
#SBATCH -c 1                           # Number of cores per task
#SBATCH --gres=gpu:1                   # Number of GPUs per node
#SBATCH --mem=24G                      # Memory per node

module purge                           # Unload all modules
module load lammps/may22               # Load LAMMPS

lmp\
 -k on g 1\
 -sf kk\
 -pk kokkos cuda/aware on neigh full comm device binsize 2.8\
 -var x 8 -var y 4 -var z 8\
 -in lammps_gpu.in

