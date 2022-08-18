#!/usr/bin/env bash
#SBATCH -J openmm                      # Job name
#SBATCH -o openmm_%j.out               # Output file name
#SBATCH -p batch                       # Partition (queue)
#SBATCH -N 1                           # Number of nodes
#SBATCH -n 1                           # Number of tasks
#SBATCH -c 1                           # Number of cores per task
#SBATCH --gres=gpu:1                   # Number of GPUs per node
#SBATCH --mem=24G                      # Memory per node

. /hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/\
lmod-8.7.2-uutt23puvwraegsi7w7ck3xbhrgk22mu/lmod/lmod/init/$(basename $SHELL)
module use /hpc/mp/modules
module purge
module load conda

# Initialize Conda environment
if [ ! -d ~/.conda/envs/openmm ]; then
  mamba create -y -n openmm -c conda-forge openmm cudatoolkit=11.4
fi
conda activate openmm

# Get examples
if [ ! -d openmm_repo ]; then
  git clone --depth 1 https://github.com/openmm/openmm.git openmm_repo
fi
cd ./openmm_repo/examples

# Run job
python3 ./benchmark.py --platform CUDA

