#!/bin/bash
#SBATCH -J sas_example                 # Job name
#SBATCH -p standard-mem-s              # Partition (queue)
#SBATCH --exclusive                    # Exclusivity 
#SBATCH --mem=250G                     # Total memory required per node
#SBATCH -o sas_example_%A-%a.out       # Job output; %A is job ID and %a is array index
#SBATCH --array=1-2                    # Range of indices to be executed

module purge                           # Unload all modules
module load sas/9.4                    # Load SAS, change version as needed

sas_tmp=${SCRATCH}/tmp/sas             # Setup directory for scratch files
mkdir -p ${sas_tmp}

sas array_example_${SLURM_ARRAY_TASK_ID}.sas -work ${sas_tmp} 
# Edit SAS script name as needed; ${SLURM_ARRAY_TASK_ID} is array index

