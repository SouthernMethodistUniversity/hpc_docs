#!/bin/bash
#SBATCH --partition=v100x8  # use the v100x8 queue 
#SBATCH -N 1                # request 1 node
#SBATCH -o v100_4x1.txt     # specify output location
#SBATCH --ntasks-per-node=1 # request 1 task on each node
#SBATCH -t 00:05:00         # request 5 minutes
#SBATCH --mem=10G           # request 10 GB
#SBATCH --gres=gpu:4        # request 4 gpus per task

# load modules
module purge
module load nvhpc-21.9

srun ./build/all_reduce_perf -b 8 -e 128M -f 2 -g 4