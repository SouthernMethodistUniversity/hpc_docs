#!/bin/bash
#SBATCH -J matlab
#SBATCH -o matlab_%a-%A.out
#SBATCH --array=1-2 # Replace with your range
#SBATCH -p standard-mem-m
#SBATCH --ntasks-per-node=36
#SBATCH --contiguous

module purge
module load matlab

args=`head -${SLURM_ARRAY_TASK_ID} numbers.txt | tail -1`
matlab -nojvm -nodisplay -nosplash -r "example(${args}, $(($(date +%s)/${SLURM_ARRAY_TASK_ID}))),quit"

