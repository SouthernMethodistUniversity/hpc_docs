#!/bin/bash
#SBATCH --job-name=stata_example       # Job name
#SBATCH --output=stata_example_%j.out  # job output, %j is the job id
#SBATCH --error=stata_example_%j.err   # job error output, %j is the job id
#SBATCH -p standard-s                  # Queue (partition) to run on
#SBATCH -t 0-00:05:00                  # Time in days-HH:MM:SS
#SBATCH --mem=4G                       # Total memory required per node
#SBATCH -c 8                           # number of cores

# unload all modules
# then load stata. Different versions may be available
module purge
module load stata/mp-18

# Run stata
stata-mp -b example.do

