#!/bin/bash

# load the modules we need
module purge

# dev utils, like cmake
module load dev

# spack is a package manager we use to install many
# software packages
module load gcc-10.3.0-gcc-9.4.0-d44jwah # GCC 10.3.0
module load cuda-11.4.4-gcc-10.3.0-ctldo35 # CUDA 11.4.4
module load kokkos-3.6.00-gcc-10.3.0-wh67tbt

# make a build directory
rm -rf build
mkdir build

# change into build directory
cd build

# run cmake configuration
cmake .. -DCMAKE_BUILD_TYPE=Release

# build
make

g++ ../stl_stokeslets.cpp --std=c++17 -march=znver2 -mtune=znver2 -O3 -fopenmp -o stl_stokeslets.x

# set some Open MP environment variables
# Kokkos suggests these, but I haven't tested on MP
export OMP_PROC_BIND=spread
export OMP_PLACES=threads

# run the program
# -G 1 requests 1 GPU
# -t 5 requests 5 minutes
srun -G 1 -t 5 ./sum_array.x


echo "---------------"
echo " "
srun -G 1 -t 5 ./stokeslets.x

echo "---------------"
echo " "
srun -G 1 -t 5 ./stl_stokeslets.x
