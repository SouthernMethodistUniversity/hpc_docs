#!/bin/bash
#SBATCH -J r
#SBATCH -o 02_k-means_lapply_%j.out
#SBATCH -p development,htc
#SBATCH -c 1
#SBATCH --mem=6G
#SBATCH -t 5

module purge
module load r

time R --vanilla < 02_k-means_lapply.r

