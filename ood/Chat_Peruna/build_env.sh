#!/bin/bash

module load miniforge
module load gcc/11.2.0
module load cuda/12.4.1-aiv75pu
export export CUDACXX=$(which nvcc)
export CMAKE_ARGS="-DGGML_CUDA=on"

conda create -n chatbot python=3.11 jupyterlab -y
conda activate chatbot
pip install llama-cpp-python --upgrade --force-reinstall --no-cache-dir
pip install numpy gradio pydantic openai
