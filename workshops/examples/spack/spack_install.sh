#!/usr/bin/env sh

module purge
module load python/3

cd $WORK
git clone -c feature.manyFiles=true https://github.com/spack/spack.git

# activate spack
source $WORK/spack/share/spack/setup-env.sh

# For tcsh/csh
# source spack/share/spack/setup-env.csh

