#!/bin/bash
#SBATCH -J r
#SBATCH -o 05_load_balancing_%j.out
#SBATCH -p development,standard-mem-s
#SBATCH -N 2
#SBATCH --ntasks-per-node=2
#SBATCH --distribution=cyclic:cyclic
#SBATCH --mem=6G
#SBATCH -t 5

module purge
module load r

R --vanilla --no-save < 05_load_balancing.r

