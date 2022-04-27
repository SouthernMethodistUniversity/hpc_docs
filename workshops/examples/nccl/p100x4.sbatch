#!/bin/bash
#SBATCH --partition=gpgpu-1     # use gpgpu-1 queue
#SBATCH -N 4                    # request 4 nodes
#SBATCH -o p100_nccl_test.txt   # specify output location
#SBATCH --ntasks-per-node=1     # request 1 task on each node
#SBATCH -t 00:05:00             # request 5 minutes
#SBATCH --mem=10G               # request 10 GB
#SBATCH --gres=gpu:1            # request 1 gpu per task

# load modules
module purge
module load nvhpc-21.9

srun ./build/all_reduce_perf -b 8 -e 128M -f 2 -g 1