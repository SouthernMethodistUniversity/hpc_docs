#!/bin/bash
#SBATCH -J r
#SBATCH -o 08_k-means_snow_%j.out
#SBATCH -p development,standard-mem-s
#SBATCH --mem=6G
#SBATCH -N 2
#SBATCH --ntasks-per-node=2
#SBATCH --distribution=cyclic:cyclic
#SBATCH -t 5

module purge
module load r

mpirun -n 1 R --slave -f 08_k-means_snow.r

