#!/bin/bash
#SBATCH -J meep           # job name
#SBATCH -o meep_%j.log    # output file name (%j expands to jobID)
#SBATCH -e meep_%j.error  # error file name  (%j expands to jobID)
#SBATCH -p standard-mem-s # queue (partition)
#SBATCH -N 2              # number of nodes
#SBATCH --ntasks-per-node=36 # number of tasks per node
#SBATCH --exclusive
#SBATCH --mem=250GB

module purge
module load intel-17.0.4
module load meep

srun meep-mpi <meep input file>

