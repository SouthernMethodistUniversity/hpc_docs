#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -p development
#SBATCH -N 2
#SBATCH --ntasks-per-node=36
#SBATCH --exclusive

module load vasp/5.4.4/cpu

srun vasp_std

