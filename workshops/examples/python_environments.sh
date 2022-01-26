#!/usr/bin/env sh

module purge
module load spack gcc-9.2
source <(spack module tcl loads --dependencies python@3.7%gcc@9.2)
python3 -m venv ~/.venv/jupyter_37
source ~/.venv/jupyter_37/bin/activate
pip3 install --upgrade pip
pip3 install --upgrade jupyterlab
which python3
python3 --version
deactivate

