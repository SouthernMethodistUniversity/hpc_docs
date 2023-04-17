#!/usr/bin/env zsh
#SBATCH -J md_0
#SBATCH -o md_0_%j.out
#SBATCH -c 1
#SBATCH --mem=1G

# Get container
enroot import "docker://nvcr.io#hpc/gromacs:2022.1" &

# Extract data file
unxz -k stmv.tpr.xz &

# Wait for the above commands to complete
wait

