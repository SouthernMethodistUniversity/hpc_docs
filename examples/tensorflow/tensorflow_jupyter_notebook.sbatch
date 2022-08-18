#!/bin/bash
#SBATCH -J jupyter
#SBATCH -o jupyter_%j.out
#SBATCH -p development,gpgpu-1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH -t 0-2

module purge
module load tensorflow/1.10_gpu

m2_jupyter_notebook

