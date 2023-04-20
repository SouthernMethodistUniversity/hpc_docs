#!/bin/bash
#SBATCH -J example           # job name
#SBATCH -o example_%j.out    # output file name (%j expands to jobID)
#SBATCH --ntasks-per-node=1  # number of tasks per node requested
#SBATCH -N 1                 # total number of nodes
#SBATCH -p standard-mem-s    # queue (partition)

module purge
module load comsol

comsol batch -inputfile in.mph -outputfile out.mph

