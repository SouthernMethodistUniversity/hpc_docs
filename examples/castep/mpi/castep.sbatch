#!/bin/bash
#SBATCH -J graphene
#SBATCH -o graphene_%j.out
#SBATCH -p development
#SBATCH --mem=6G
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=2

module purge
module load castep/20.11_mpi

printf "JOB_SCRATCH:\t%s\n" ${JOB_SCRATCH}

srun castep.mpi C_graphene_or

