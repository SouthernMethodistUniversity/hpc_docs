#!/bin/bash
#SBATCH -J molpro
#SBATCH -o molpro_%j.out
#SBATCH -p standard-mem-s,standard-mem-m,standard-mem-l
#SBATCH -N 1
#SBATCH --mem=250G
#SBATCH --exclusive

module load molpro/2018.1.1

input_file=h2o_scfopt_631g.com

job_directory="${SLURM_SUBMIT_DIR}/${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
wfu_directory="${job_directory}/wfu"
mkdir ${job_directory}
lfs setstripe -c 4 ${job_directory}
cp ${input_file} ${job_directory}/
cd ${job_directory}
mkdir ${wfu_directory}
molpro -n 36/36:1 -W ${wfu_directory} ${input_file}

