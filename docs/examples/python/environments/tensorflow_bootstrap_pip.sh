#!/usr/bin/env bash

# Define environment name
name="tensorflow"

# Load needed modules and save for user
module purge
module load gcc-7.3 python/3.7.4-itpoy6d cuda/11.1.1-coro4f4 cudnn/8.0.4.30-11.1-avmtlct
module save ${name}

# Create Python environment and install packages
python3 -m venv ~/.venv/${name}
source ~/.venv/${name}/bin/activate
pip3 install --upgrade pip
pip3 install --upgrade jupyterlab tensorflow seaborn

# Print usage details
usage="
Usage:
module restore ${name}
source ~/.venv/${name}/bin/activate

Leave Environment:
deactivate
"
printf "${usage}"

