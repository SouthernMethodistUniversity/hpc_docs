#!/bin/bash
#SBATCH -J graphene
#SBATCH -o graphene_%j.out
#SBATCH -p development
#SBATCH --mem=6G
#SBATCH -c 1

module purge
module load castep/20.11_serial

printf "JOB_SCRATCH:\t%s\n" ${JOB_SCRATCH}

castep.serial C_graphene_or

