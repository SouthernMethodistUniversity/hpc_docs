#!/bin/bash
#SBATCH -J example
#SBATCH -o example.out
#SBATCH -e example.error
#SBATCH -N 1
#SBATCH --tasks-per-node=36
#SBATCH --exclusive
#SBATCH -p standard-mem-m

cat ${0}

module purge
module load orca/4.0.0

job_directory="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_directory}
lfs setstripe -c 8 ${job_directory}
cp example.inp ${job_directory}/
cd ${job_directory}

cat example.inp

$(which orca) example.inp "--bind-to-core"

