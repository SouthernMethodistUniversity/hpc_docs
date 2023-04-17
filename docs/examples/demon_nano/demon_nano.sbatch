#!/bin/bash
#SBATCH -J demon_nano
#SBATCH -o demon_nano_%j.log
#SBATCH -p development      # Change queue, parallelization, and memory as needed
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4   # Change number of cores as needed
#SBATCH --mem=6GB

module purge
module load demon_nano

input_file=deMon.inp        # Just change input file name

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
job_directory="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_directory}
#lfs setstripe -c 2 ${job_directory}
cp ${input_file} ${job_directory}/deMon.inp
cd ${job_directory}
srun deMon

