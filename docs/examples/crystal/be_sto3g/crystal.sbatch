#!/bin/bash
#SBATCH -J crystal
#SBATCH -o crystal_%j.out
#SBATCH -p dev
#SBATCH --mem=16GB
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=16

module purge
module use /users/rkalescky/hpc_docs/modules/m3/applications
module load crystal/23

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

srun PcrystalOMP < INPUT

