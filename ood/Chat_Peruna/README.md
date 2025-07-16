# Simple Chatbot using Gradio

Based on https://github.com/WFU-HPC/OOD-GradioApps

## Requirements

### Python environment

The main requirements are:

 - `gradio` (for the app interface)
 - `llama_cpp_python` (to run the models)
 - `openai` (for the OpenAI API calls used in running models)

Some of these, particularly `llama_cpp_python` should be compiled to
utilize available resources appropriately (e.g. GPUs). 
See `build_env.sh` for a simple, compatible environment

### Models

Users are responsible for acquiring or creating their own models.
At present, they are required to be compatible with the OpenAI API.
