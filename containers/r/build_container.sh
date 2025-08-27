#!/bin/bash -e
# build singularity container for Rocker geospatial
# just pull docker image from https://hub.docker.com/r/rocker/geospatial

# TODO: MP should pull a CUDA enabled version instead?
# specify version
VERSION="4.5.1"
TAG=${VERSION}
IMAGE_NAME="geospatial"

echo "Building tag: ${TAG}"

# build the container
module purge
module load apptainer

CONTAINER_NAME=rocker_${IMAGE_NAME}_${TAG}.sif
apptainer build --fakeroot ${CONTAINER_NAME} docker://rocker/${IMAGE_NAME}:${TAG}

# get the path for rsession inside the contianer. We need this
# for the portal, so it's useful to "precompute" and load
apptainer exec ${CONTAINER_NAME}  test -x /usr/lib/rstudio-server/bin/rsession
RSESSION_EXEC="/usr/lib/rstudio-server/bin/rsession"
# verify
if ! apptainer exec ${CONTAINER_NAME} test -x ${RSESSION_EXEC} &> /dev/null
then
  echo "rsession not at ${RSESSION_EXEC} in the container"
  exit 12
fi
RSERVER_EXEC="/usr/lib/rstudio-server/bin/rserver"
# verify
if ! apptainer exec ${CONTAINER_NAME} test -x ${RSERVER_EXEC} &> /dev/null
then
  echo "rserver not at ${RSERVER_EXEC} in the container"
  exit 12
fi
R_EXEC=$(apptainer exec ${CONTAINER_NAME} which R)
# verify
if ! apptainer exec ${CONTAINER_NAME} test -x ${R_EXEC} &> /dev/null
then
  echo "r not at ${R_EXEC} in the container"
  exit 12
fi
# move container to /hpc/{sys}/containers/
CLUSTER=$(scontrol show config | grep ClusterName | grep -oP '= \K.+')
if [ "$CLUSTER" = "nvidia" ]; then
  CLUSTER="mp"
fi
mkdir -p /hpc/${CLUSTER}/containers/rocker
mv ${CONTAINER_NAME} /hpc/${CLUSTER}/containers/rocker/${CONTAINER_NAME}

# create a module file in ../../modules/ (in the git repo)
RUN_COMMAND="apptainer run "
if [ "$CLUSTER" = "mp" ]; then
  RUN_COMMAND="apptainer run --nv "
fi

mkdir -p ../../modules/${CLUSTER}/applications/R
MODULE_FILE=../../modules/${CLUSTER}/applications/R/${VERSION}.lua
(
sed 's/^ \{2\}//' > "$MODULE_FILE" << EOL

help([[
Name: R
Version: ${TAG}
Website: https://www.r-project.org/

R is a language and environment for statistical computing and graphics.

To use R:

R -- launches an R terminal
Rscript script -- run a script

]])
whatis("Name: R")
whatis("Version: ${IMAGE_NAME}:${TAG}")
whatis("Category: R")
whatis("URL: https://hub.docker.com/r/rocker/${IMAGE_NAME}")
whatis("Description: Provides access to R and Rstudio through a Rocker container built with Apptainer")
family("R")

always_load('apptainer')
local sif_file = '/hpc/${CLUSTER}/containers/rocker/${CONTAINER_NAME}'

local work_dir = '/work'
local scratch_dir = os.getenv("SCRATCH")
local home = os.getenv("HOME")
local user_libs = pathJoin(home, 'R/rocker/${TAG}')

function build_command(app)
  local cmd        = '${RUN_COMMAND} --env R_LIBS_USER=' .. user_libs .. ' -B ' .. scratch_dir .. ',' .. work_dir .. ' ' .. sif_file .. ' ' .. app
  local sh_ending  = ' "\$@"'
  local csh_ending = ' \$*'
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(app, sh_cmd, csh_cmd)
end

setenv('CONTAINER_RSESSION', '${RSESSION_EXEC}')
setenv('CONTAINER_RSERVER', '${RSERVER_EXEC}')
setenv('CONTAINER_R', '${R_EXEC}')
setenv('CONTAINER_IMAGE', '/hpc/${CLUSTER}/containers/rocker/${CONTAINER_NAME}')
setenv('R_LIBS_USER', user_libs)
unsetenv('XDG_RUNTIME_DIR')

build_command('R')
build_command('Rscript')
EOL
)
