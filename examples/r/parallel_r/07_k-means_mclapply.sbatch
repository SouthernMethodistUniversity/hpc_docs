#!/bin/bash
#SBATCH -J r
#SBATCH -o 07_k-means_mclapply_%j.out
#SBATCH -p development,standard-mem-s
#SBATCH -c 2
#SBATCH --mem=6G
#SBATCH -t 5

module purge
module load r

time R --vanilla < 07_k-means_mclapply.r

