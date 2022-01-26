#!/bin/bash
#SBATCH -J R
#SBATCH -o R_%j.out
#SBATCH -p htc
#SBATCH --mem=6G

module purge
module load r/4.0.2

time Rscript pi_monte_carlo_serial.R 1000

