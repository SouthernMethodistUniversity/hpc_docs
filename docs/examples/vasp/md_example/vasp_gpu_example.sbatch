#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -p workshop
#SBATCH -N 1
#SBATCH --ntasks-per-node=36
#SBATCH --exclusive

module purge
module load vasp/5.4.4/gpu

srun vasp_std

