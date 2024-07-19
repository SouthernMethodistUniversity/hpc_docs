#!/bin/bash
#SBATCH -J pi_array
#SBATCH -o pi_array_%a-%A.out
#SBATCH --array=1-4%2
#SBATCH -p dev
#SBATCH -c 1
#SBATCH --mem=6G
#SBATCH -t 10

time python3 pi_monte_carlo.py $((100**${SLURM_ARRAY_TASK_ID}))

