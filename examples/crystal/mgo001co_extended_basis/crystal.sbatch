#!/bin/bash
#SBATCH -J crystal
#SBATCH -o crystal_%j.out
#SBATCH -p standard-mem-s
#SBATCH --mem=250G
#SBATCH -N 1
#SBATCH --ntasks-per-node=36

module purge
module load crystal/17

# Crystal Versions
#
# See documentation:
# /hpc/applications/crystal/17/1.0.2/documentation
#
# Serial: crystal
# Parallel for small/medium calculations: srun Pcrystal
# Parallel for medium/large calculations: srun MPPcrystal

srun Pcrystal 

