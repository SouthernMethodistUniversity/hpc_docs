#!/bin/bash
#SBATCH --partition=standard-mem-s    # use standarm memory short queue
#SBATCH -N 2                          # request 2 nodes
#SBATCH -o conda_mpi4py_test.txt      # specify output location
#SBATCH --ntasks-per-node=1           # request 1 task on each node
#SBATCH -t 00:05:00                   # request 5 minutes
#SBATCH --mem=1G                      # request 1 GB

# load modules
module purge
module load python/3

# activate the environment
eval "$(conda shell.bash hook)"
conda activate $HOME/conda_mpi4py

# run test
mpirun python osu_bw.py