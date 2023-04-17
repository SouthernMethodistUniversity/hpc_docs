#!/bin/bash
#SBATCH -J test
#SBATCH -o test_%a-%A.out
#SBATCH --array=1-10 # Replace with your range
#SBATCH -p htc

module purge
module load python/3

args=`head -${SLURM_ARRAY_TASK_ID} test_args.txt | tail -1`
python test.py ${args}


