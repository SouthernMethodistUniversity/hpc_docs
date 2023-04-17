#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -e example_%j.error
#SBATCH -N 1
#SBATCH --tasks-per-node=36
#SBATCH --exclusive
#SBATCH -p standard-mem-s,standard-mem-m,standard-mem-l,medium-mem-1-s,medium-mem-1-m,medium-mem-1-l,high-mem-1,gpgpu-1,workshop,high-mem-2
#SBATCH --mem=250G
#SBATCH -t 0-2

cat ${0}

module purge
module load orca/4.1.1

job_directory="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_directory}
lfs setstripe -c 2 ${job_directory}
cp example.inp ${job_directory}/
cd ${job_directory}

cat example.inp

$(which orca) example.inp

