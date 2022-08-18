#!/bin/bash
#SBATCH -J matlab
#SBATCH -o matlab_%a-%A.out
#SBATCH --array=1-46 # Replace with your range
#SBATCH -p htc

module purge
module load matlab

args=`head -${SLURM_ARRAY_TASK_ID} numbers.txt | tail -1`
matlab -nojvm -nodisplay -nosplash -r "example(${args}),quit"

