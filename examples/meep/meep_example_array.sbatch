#!/bin/bash
#SBATCH -J meep              # job name
#SBATCH -o meep_%a-%A.log    # output file name (%j expands to jobID)
#SBATCH -e meep_%a-%A.error  # error file name  (%j expands to jobID)
#SBATCH -p standard-mem-s    # queue (partition)
#SBATCH -N 2                 # number of nodes
#SBATCH --ntasks-per-node=36 # number of tasks per node
#SBATCH --array=1-5          # Replace with your range
#SBATCH --exclusive
#SBATCH --mem=250GB

module purge
module load intel-17.0.4
module load meep

args=`head -${SLURM_ARRAY_TASK_ID} numbers.txt | tail -1`
srun meep-mpi <meep input file> ${args}

