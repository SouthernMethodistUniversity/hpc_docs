#!/usr/bin/env sh

module purge

# load a compiler
module load gcc-9.2

# tell spack to find new compilers
spack compiler find