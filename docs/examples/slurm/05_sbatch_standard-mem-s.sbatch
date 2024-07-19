#!/bin/bash
#SBATCH -J pi
#SBATCH -o pi_%j.out
#SBATCH -p dev
#SBATCH -N 1
#SBATCH --cpus-per-task=2
#SBATCH --mem=6G
#SBATCH -t 10

time python3 pi_monte_carlo_shared.py 10000000 ${SLURM_CPUS_PER_TASK}

