
help([[
Name: Ollama
Version: 0.13.2
Website: https://ollama.com/

Ollama is an open-source tool that allows you to run large language models (LLMs) like Llama 3 and Mistral directly on your local machine

]])
whatis("Name: Ollama")
whatis("Version: ollama:0.13.2")
whatis("Category: Ollama")
whatis("URL: https://hub.docker.com/r/ollama/ollama")
whatis("Description: Provides access to Ollama through a container built with Apptainer")
family("Ollama")

always_load('apptainer')
local sif_file = '/hpc/m3/containers/ollama/ollama_0.13.2.sif'

setenv('CONTAINER_IMAGE', sif_file)
source_sh("bash", "/hpc/m3/hpc_docs/utils/ollama_scripts/ollama.sh")

