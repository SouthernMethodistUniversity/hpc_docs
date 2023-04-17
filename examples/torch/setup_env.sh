#!/bin/bash

env_dir="$WORK/.venv/torch"

env_install() {
  req=$1
  python3 -m venv $env_dir
  source $env_dir/bin/activate
  pip3 install -U pip wheel setuptools
  pip3 install -r $req
}

env_mp() {
  module load spack
  # GCC@10.3.0
  # Python@3.9.12
  # CUDA@11.7.0
  spack load /d44jwah /pj76hok /vbhdtgc
  env_install requirements_mp.txt
}

env_m3() {
  env_install requirements_m3.txt
}

module purge
cluster=$(scontrol show config | awk '/ClusterName/{print $3}')

case $cluster in
  nvidia)
    env_mp
    ;;
  m3)
    env_m3
    ;;
  *)
    echo "Invalid cluster."
    exit
    ;;
esac

