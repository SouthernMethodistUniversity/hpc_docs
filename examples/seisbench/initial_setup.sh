#!/usr/bin/env bash

module purge
module load gcc-9.2.lua spack.lua python-3.8.6-gcc-9.2.0-7vsoogc
env_dir=$HOME/.venv/seisbench
python3 -m venv $env_dir
source $env_dir/bin/activate
pip3 install -U pip wheel setuptools
pip3 install -r requirements.txt

