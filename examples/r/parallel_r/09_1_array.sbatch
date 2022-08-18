#!/bin/bash
#SBATCH -J r
#SBATCH -o 09_1_array_%a.out
#SBATCH --array=1-4
#SBATCH -p development,htc
#SBATCH --mem=6G
#SBATCH -c 1
#SBATHC -t 5

module purge
module load r

R -e 'saveRDS(runif(10000), paste(Sys.getenv("SLURM_ARRAY_TASK_ID"), "rds", sep="."))'

