#!/usr/bin/env sh

module purge
module load python/3
conda create -y -n jupyter_37 -c conda-forge jupyterlab python=3.7
source activate ~/.conda/envs/jupyter_37
which python3
python3 --version
deactivate

