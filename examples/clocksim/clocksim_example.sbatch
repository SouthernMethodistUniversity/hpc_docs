#!/bin/bash
#SBATCH -J clocksim                    # Job name
#SBATCH -o clocksim.out                # Output file name
#SBATCH -p standard-mem-s              # Partition (queue)
#SBATCH --exclusive                    # Exclusivity 
#SBATCH --mem=250G                     # Total memory required per node

module purge                           # Unload all modules
module load clocksim                   # Load Clocksim, change version as needed

srun clocksim /hpc/applications/clocksim/F2014/ create 314 # Number is id and apparently arbitrary...

