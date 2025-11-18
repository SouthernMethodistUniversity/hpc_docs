#!/bin/bash -e
# build singularity container for Ollama
# just pull docker image from https://hub.docker.com/r/ollama/ollama

# TODO: MP should pull a CUDA enabled version instead?
# specify version
VERSION="0.12.11"
TAG=${VERSION}
IMAGE_NAME="ollama"
MODULE_FOLDER="testing/ollama"

echo "Building tag: ${TAG}"

# build the container
module purge
module load apptainer

CONTAINER_NAME=${IMAGE_NAME}_${TAG}.sif
apptainer build --fakeroot ${CONTAINER_NAME} docker://ollama/${IMAGE_NAME}:${TAG}

# move container to /hpc/{sys}/containers/
CLUSTER=$(scontrol show config | grep ClusterName | grep -oP '= \K.+')
if [ "$CLUSTER" = "nvidia" ]; then
  CLUSTER="mp"
fi
mkdir -p /hpc/${CLUSTER}/containers/ollama
mv ${CONTAINER_NAME} /hpc/${CLUSTER}/containers/ollama/${CONTAINER_NAME}

# create a module file in ../../modules/ (in the git repo)
RUN_COMMAND="apptainer run "
if [ "$CLUSTER" = "mp" ]; then
  RUN_COMMAND="apptainer run --nv "
fi

mkdir -p ../../modules/${CLUSTER}/applications/${MODULE_FOLDER}
MODULE_FILE=../../modules/${CLUSTER}/applications/${MODULE_FOLDER}/${VERSION}.lua
(
sed 's/^ \{2\}//' > "$MODULE_FILE" << EOL

help([[
Name: Ollama
Version: ${TAG}
Website: https://ollama.com/

Ollama is an open-source tool that allows you to run large language models (LLMs) like Llama 3 and Mistral directly on your local machine

]])
whatis("Name: Ollama")
whatis("Version: ${IMAGE_NAME}:${TAG}")
whatis("Category: Ollama")
whatis("URL: https://hub.docker.com/r/ollama/${IMAGE_NAME}")
whatis("Description: Provides access to Ollama through a container built with Apptainer")
family("Ollama")

always_load('apptainer')
local sif_file = '/hpc/${CLUSTER}/containers/ollama/${CONTAINER_NAME}'

setenv('CONTAINER_IMAGE', sif_file)
append_path("PATH", "/hpc/m3/apps/ollama/helper_scripts")

EOL
)
