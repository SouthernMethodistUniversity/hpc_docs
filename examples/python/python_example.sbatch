#!/bin/bash
#SBATCH -J python_example              # Job name
#SBATCH -o example.txt                 # Output file name
#SBATCH -p standard-mem-s              # Partition (queue)
#SBATCH --exclusive                    # Exclusivity 
#SBATCH --mem=250G                     # Total memory required per node

module purge                           # Unload all modules
module load python                     # Load R, change version as needed

python example.py                      # Edit Python script name as needed

