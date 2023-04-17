#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -p gpgpu-1
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --exclusive

# Amber
module purge
module load amber/16.15

# Program Command
srun pmemd.cuda.MPI -O -o stdout -i alanine_md.in -c alanine_md.rst -p alanine_md.prmtop -r alanine_md_new.rst -x alanine_md_new.mdcrd

