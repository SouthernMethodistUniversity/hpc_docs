#!/bin/bash
#SBATCH -J amber_example          # Job name, display in queue
#SBATCH -o amber_example_%j.out   # output file, %j is the job id
#SBATCH -p dev                    # partition to use
#SBATCH -N 1                      # number of nodes
#SBATCH -c 1                      # number of cpu cores per task
#SBATCH --ntasks-per-node=4       # number of tasks per node
#SBATCH --mem=1G                  # memory per node
#SBATCH -t 0-00:03:00             # run time, days-HH:MM:SS

# Amber
module purge
module load amber/22

# Program Command
srun sander.MPI -O -o stdout -i alanine_md.in -c alanine_md.rst -p alanine_md.prmtop -r alanine_md_new.rst -x alanine_md_new.mdcrd

