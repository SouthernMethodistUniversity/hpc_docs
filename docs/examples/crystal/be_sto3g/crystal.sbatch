#!/bin/bash
#SBATCH -J crystal
#SBATCH -o crystal_%j.out
#SBATCH -p dev
#SBATCH --mem=16GB
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=16

module purge
module load crystal/23

# Crystal Versions
#
# See documentation:
# https://www.crystal.unito.it/documentation.html
#
# Serial:
# Set `--cpus-per-task=1` and use `crystalOMP`
#
# Parallel:
# Set `--cpus-per-task=<threads_per_task_integer>` and use `srun PcrystalOMP`

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

srun PcrystalOMP < INPUT
