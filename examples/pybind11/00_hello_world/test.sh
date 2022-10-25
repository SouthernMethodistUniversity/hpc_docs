#!/usr/bin/env zsh

cmake -S . -B build
cmake --build build -j
export PYTHONPATH=$PWD/build
python3 test.py

