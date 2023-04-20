#!/bin/bash

module purge
source /hpc/spack/share/spack/setup-env.sh
module load gcc-6.3
spack load --dependencies /b4j4e2j # ROOT
module load armadillo/8.100.1-6xpjrpd
module load yaml-cpp/0.5.3-oe2qubx
module load openblas/0.2.20-mwxg6n4

base_directory=$(pwd)
dependencies_directory="${base_directory}/dependencies"

export PATH="${dependencies_directory}/bin:${PATH}"
export CPATH="${dependencies_directory}/include:${CPATH}"
export LD_LIBRARY_PATH="${dependencies_directory}/lib:${LD_LIBRARY_PATH}"
export DEPENDENCIES_DIRECTORY=${dependencies_directory}
export CC=$(which gcc)
export CXX=$(which g++)
export FC=$(which gfortran)

