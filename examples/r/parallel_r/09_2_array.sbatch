#!/bin/bash
#SBATCH -J r
#SBATCH -o 09_2_array.out
#SBATCH -p development,htc
#SBATCH --mem=6G
#SBATCH -c 1
#SBATHC -t 5

module purge
module load r

Rscript 09_2_array.r

