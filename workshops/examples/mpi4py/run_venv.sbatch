#!/bin/bash
#SBATCH --partition=standard-mem-s  # use standarm memory short queue
#SBATCH -N 2                        # request 2 nodes
#SBATCH -o pip_mpi4py_test.txt      # specify output location
#SBATCH --ntasks-per-node=1         # request 1 task on each node
#SBATCH -t 00:05:00                 # request 5 minutes
#SBATCH --mem=1G                    # request 1 GB

# load modules
module purge
module load intel

# activate environment
source $HOME/venv_mpi/bin/activate

# run test
srun python osu_bw.py