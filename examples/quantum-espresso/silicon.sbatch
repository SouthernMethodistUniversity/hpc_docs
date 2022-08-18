#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -p development
#SBATCH --mem=250G
#SBATCH -n 1
#SBATCH -c 36
#SBATCH --exclusive

module purge
module load quantum-espresso/6.4.1

input_file="silicon.in"
pseudopotential="Si.pz-vbc.UPF"

job_directory="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
export TMP_DIR="${job_directory}/tmp"
mkdir -p ${TMP_DIR}
lfs setstripe -c 2 ${TMP_DIR}
cp ${input_file} ${pseudopotential} ${job_directory}
cd ${job_directory}
pw.x -i ${input_file}

