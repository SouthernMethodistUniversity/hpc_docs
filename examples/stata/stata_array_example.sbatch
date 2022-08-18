#!/bin/bash
#SBATCH -J stata_example                 # Job name
#SBATCH -p standard-mem-s                # Partition (queue)
#SBATCH --exclusive                      # Exclusivity 
#SBATCH --mem=250G                       # Total memory required per node
#SBATCH -o stata_array_example_%A-%a.out # Job output; %A is job ID and
                                         # %a is array index
#SBATCH --array=1-2                      # Range of indices to be executed

module purge                             # Unload all modules
module load stata                        # Load STATA, change version as needed

stata -b array_example_${SLURM_ARRAY_TASK_ID}.do
# Edit STATA script name as needed; ${SLURM_ARRAY_TASK_ID} is array index