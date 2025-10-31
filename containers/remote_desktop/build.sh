#!/bin/bash -e

# load apptainer
module purge
module load apptainer
unset APPTAINER_BIND

# set version
VERSION=1.2.2

# TODO: gpu enabled?

CONTAINER_NAME=remote_desktop_${VERSION}.sif

# check if this version already exits
CLUSTER=$(scontrol show config | grep ClusterName | grep -oP '= \K.+')
if [ "$CLUSTER" = "nvidia" ]; then
  CLUSTER="mp"
fi

DESTINATION=/hpc/${CLUSTER}/containers/remote_desktop/${CONTAINER_NAME}

if [ -f "$DESTINATION" ]; then

  read -p "$DESTINATION already exists. Overwrite y/N? " yn
  case $yn in
     [Yy]* ) echo "Overwriting existing file";;
     * ) exit;;
  esac
fi

# build the container
apptainer build --fakeroot ${CONTAINER_NAME} desktop.def

# move container to /hpc/{sys}/containers/
mkdir -p /hpc/${CLUSTER}/containers/remote_desktop
mv ${CONTAINER_NAME} ${DESTINATION}
