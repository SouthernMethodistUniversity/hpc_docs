#!/usr/bin/env zsh

python3 -m venv ~/.venv/cython
. ~/venv/cython/bin/activate
pip3 install -U pip setuptools wheel
pip3 install -r requirements.txt

