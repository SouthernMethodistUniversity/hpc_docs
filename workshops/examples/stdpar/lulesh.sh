#!/usr/bin/env bash

git clone https://github.com/LLNL/LULESH.git
cd LULESH
git checkout 2.0.2-dev
cd stdpar/build
module load nvhpc-21.2
make
srun -p development -N 1 -c 36 --gres=gpu:1 --mem=250G --pty ./lulesh2.0 -p -s 50

