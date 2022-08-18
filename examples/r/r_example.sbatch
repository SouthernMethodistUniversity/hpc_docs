#!/bin/bash
#SBATCH -J R_example                   # Job name
#SBATCH -o example.txt                 # Output file name
#SBATCH -p standard-mem-s              # Partition (queue)
#SBATCH --exclusive                    # Exclusivity 
#SBATCH --mem=250G                     # Total memory required per node

module purge                           # Unload all modules
module load R                          # Load R, change version as needed

R --vanilla < example.R                # Edit R script name as needed

