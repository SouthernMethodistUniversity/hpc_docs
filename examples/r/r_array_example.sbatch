#!/bin/bash
#SBATCH -J R_example                   # Job name
#SBATCH -p standard-mem-s              # Partition (queue)
#SBATCH --exclusive                    # Exclusivity 
#SBATCH --mem=250G                     # Total memory required per node
#SBATCH -o R_example_%A-%a.out         # Job output; %A is job ID and %a is array index
#SBATCH --array=1-2                    # Range of indices to be executed

module purge                           # Unload all modules
module load R                          # Load R, change version as needed

R --vanilla < array_example_${SLURM_ARRAY_TASK_ID}.R
# Edit R script name as needed; ${SLURM_ARRAY_TASK_ID} is array index

