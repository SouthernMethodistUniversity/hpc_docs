#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -p dev
#SBATCH -N 1
#SBATCH --ntasks-per-node=4
#SBATCH --exclusive

# Amber
module purge
module load amber

# Program Command
srun sander.MPI -O -o stdout -i alanine_md.in -c alanine_md.rst -p alanine_md.prmtop -r alanine_md_new.rst -x alanine_md_new.mdcrd

