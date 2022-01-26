#!/bin/bash
#SBATCH -J pi
#SBATCH -o pi_%j.out
#SBATCH -p development
#SBATCH --cpus-per-task=2
#SBATCH --mem=6G

module purge
module load r/4.0.2

time Rscript pi_monte_carlo_parallel.R 10000000 ${SLURM_CPUS_PER_TASK}

