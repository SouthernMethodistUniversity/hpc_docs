#!/bin/bash
#SBATCH -J r
#SBATCH -o 01_k-means_serial_%j.out
#SBATCH -p development,htc
#SBATCH -c 1
#SBATCH --mem=6G
#SBATCH -t 5

module purge
module load r

time R --vanilla < 01_k-means_serial.r

