#!/usr/bin/env bash

env_dir=$HOME/.venv/seisbench
python3 -m venv $env_dir
source $env_dir/bin/activate
pip3 install -U pip wheel setuptools
pip3 install -r requirements.txt

