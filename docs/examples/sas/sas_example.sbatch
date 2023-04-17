#!/bin/bash
#SBATCH -J sas_example                 # Job name
#SBATCH -o example.txt                 # Output file name
#SBATCH -p standard-mem-s              # Partition (queue)
#SBATCH --exclusive                    # Exclusivity 
#SBATCH --mem=250G                     # Total memory required per node

module purge                           # Unload all modules
module load sas/9.4                    # Load SAS, change version as needed

sas_tmp=${SCRATCH}/tmp/sas             # Setup directory for scratch files
mkdir -p ${sas_tmp}

sas example.sas -work ${sas_tmp}       # Edit SAS script name as needed

