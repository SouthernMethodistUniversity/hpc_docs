#!/bin/bash
#SBATCH -J water 
#SBATCH -o water_%j.out
#SBATCH -p development
#SBATCH -n 1
#SBATCH -c 36
#SBATCH --mem=250G
#SBATCH --exclusive

module purge
module load psi4

export PSI_SCRATCH="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir -p ${PSI_SCRATCH}
lfs setstripe -c 2 ${PSI_SCRATCH}

psi4 -n ${SLURM_CPUS_PER_TASK} -o stdout -i water.inp

