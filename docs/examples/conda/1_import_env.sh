#!/bin/zsh

# Create new environment from file
mamba env create -n ds -f env.yaml

# Note that different OS's will have slightly different package sets. The goal
# should be to have one environment file that runs on all supported platforms.

