#!/bin/bash

env_dir="$WORK/.venv/jupyter"

python3 -m venv $env_dir
source $env_dir/bin/activate
python3 -m pip install -U pip wheel setuptools
python3 -m pip install -r requirements.txt

echo "Finished installing Python environment."
echo "Use via:"
echo "source ${env_dir}/bin/activate"

