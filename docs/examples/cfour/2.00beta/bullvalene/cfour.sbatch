#!/bin/bash
#SBATCH -J bullvalene
#SBATCH -o bullvalene_%j.out
#SBATCH -p development
#SBATCH --mem=250G
#SBATCH -n 1
#SBATCH -c 36
#SBATCH --exclusive

module purge
module load cfour/2.00beta

scratch="${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir -p ${scratch}
lfs setstripe -c 2 ${scratch}
cp ZMAT ${scratch}/
cd ${scratch}
ln -s /hpc/applications/cfour/2.00beta/basis/GENBAS .

xcfour

