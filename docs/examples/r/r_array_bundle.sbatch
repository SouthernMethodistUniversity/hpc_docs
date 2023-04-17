#!/bin/bash
#SBATCH -J test
#SBATCH -o test_%a-%A.out      # 
#SBATCH --array=0-19           # Replace with your range
#SBATCH -p standard-mem-s
#SBATCH --cpus-per-task=18
#SBATCH --mem-per-cpu=7065M

module purge
module load r/3.4.1-1

MODELS=(A1 A4 B1 B4 C1 C4 D1 D4 E1 E4 F1 F4 G1 G4 H1 H4 I1 I4 J1 J4)

R --no-save --no-restore <inst/scripts/stan2.R --args ${MODELS[${SLURM_ARRAY_TASK_ID}]}

