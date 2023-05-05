#!/bin/zsh

# Setup Conda
module purge
module load conda

# Create environment
mamba create -n ds -c conda-forge jupyterlab pandas

# Activate environment
mamba activate ds

# Export environment
# Note removing build specifiers with `--no-builds` as these are OS dependent.
# Note removing the `prefix` as this is environment installation specific.
mamba env export --no-builds -c conda-forge | grep -v "^prefix: " > env.yaml

# Change environment in environment file to `base`

