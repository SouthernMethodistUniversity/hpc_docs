#!/bin/bash
#SBATCH -J acrolein
#SBATCH -o acrolein.out
#SBATCH -p standard-mem-s
#SBATCH -N 1
#SBATCH --ntasks-per-node=36
#SBATCH --mem=250G
#SBATCH --exclusive

module purge
module load molcas

input_file=acrolein.inp

job_directory="$(pwd -P)/${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_directory}
lfs setstripe -c 2 ${job_directory}
cp ${input_file} ${job_directory}/
cd ${job_directory}

export MOLCAS_NPROCS=${SLURM_NTASKS}
export MOLCAS_MEM=$(echo "(0.75 * ${SLURM_JOB_NUM_NODES} * ${SLURM_MEM_PER_NODE}) / ${SLURM_NTASKS}" | bc)
export WorkDir=${job_directory}
molcas -f ${input_file}

