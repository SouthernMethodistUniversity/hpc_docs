#!/bin/bash
#SBATCH -J stata_example                 # Job name
#SBATCH -p dev                           # Partition (queue)
#SBATCH --mem=4G                         # Total memory required per node
#SBATCH -t 0-00:05:00                    # time, days-HH:MM:SS
#SBATCH -c 8                             # number of CPU cores
#SBATCH -o stata_array_example_%A-%a.out # Job output; %A is job ID and %a is array index
#SBATCH --array=1-2                      # Range of indices to be executed

# unload all modules
# then load stata. Different versions may be available
module purge
module load stata/mp-18

# Run Stata
stata-mp -b array_example_${SLURM_ARRAY_TASK_ID}.do
# Edit STATA script name as needed; ${SLURM_ARRAY_TASK_ID} is array index