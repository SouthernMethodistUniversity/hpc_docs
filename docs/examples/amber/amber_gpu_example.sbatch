#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -G 1

# Amber
module purge
module load amber/22

# Program Command
# NOTE: the flag -AllowSmallBox is needed to run this example
# but you shouldn't need it most of the time
srun pmemd.cuda.MPI -AllowSmallBox -O -o stdout -i alanine_md.in -c alanine_md.rst -p alanine_md.prmtop -r alanine_md_new.rst -x alanine_md_new.mdcrd

