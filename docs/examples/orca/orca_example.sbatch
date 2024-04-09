#!/bin/bash
#SBATCH -J orca
#SBATCH -o orca_%j.out
#SBATCH -N 1
#SBATCH --tasks-per-node=4
#SBATCH -p dev
#SBATCH --mem=4G
#SBATCH -t 0-2

module purge
module load orca

job_directory="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_directory}
cp example.inp ${job_directory}/
cd ${job_directory}

cat example.inp

$(which orca) example.inp

