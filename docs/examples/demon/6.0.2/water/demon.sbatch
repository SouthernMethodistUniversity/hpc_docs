#!/bin/bash
#SBATCH -J deMon
#SBATCH -o deMon_%j.log
#SBATCH -p development      # Change queue, parallelization, and memory as needed
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --mem=6GB

module purge
module load demon/6.0.2

input_file=water.inp        # Just change input file name

job_directory="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_directory}
lfs setstripe -c 2 ${job_directory}
cp ${input_file} ${job_directory}/deMon.inp
cd ${job_directory}
for i in AUXIS BASIS D3CFS ECPS FFDS MCPS; do ln -s ${CREX_ROOT}/deMon/${i}; done
srun deMon

