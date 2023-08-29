#!/bin/bash
#SBATCH -J pi_array
#SBATCH -o pi_array_%a-%A.out
#SBATCH --array=1-4%2
#SBATCH -p development
#SBATCH --mem=6G

module purge
module load r/4.0.2

time Rscript pi_monte_carlo_serial.R $((100**${SLURM_ARRAY_TASK_ID}))

