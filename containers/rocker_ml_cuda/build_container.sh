#!/bin/bash -e
# build GPU-enabled apptainer container for RStudio (rocker/ml + CUDA PyTorch)
# base image and package pins are in rocker_ml_cuda.def

# specify version
VERSION="1.0.0"
IMAGE_NAME="rocker_ml_cuda"
CONTAINER_NAME=${IMAGE_NAME}_${VERSION}.sif

echo "Building ${CONTAINER_NAME}"

# module file path below is relative to this directory
cd "$(dirname "$0")"

# build the container
module purge
module load apptainer
unset APPTAINER_BIND
apptainer build --fakeroot ${CONTAINER_NAME} ${IMAGE_NAME}.def

# get the paths for rserver, rsession, and R inside the container. We need
# these for the portal, so it's useful to "precompute" and load
RSESSION_EXEC="/usr/lib/rstudio-server/bin/rsession"
RSERVER_EXEC="/usr/lib/rstudio-server/bin/rserver"
R_EXEC=$(apptainer exec ${CONTAINER_NAME} which R)
# verify
for EXEC in ${RSESSION_EXEC} ${RSERVER_EXEC} ${R_EXEC}
do
  if ! apptainer exec ${CONTAINER_NAME} test -x ${EXEC} &> /dev/null
  then
    echo "${EXEC} not found in the container"
    exit 12
  fi
done
if ! apptainer exec ${CONTAINER_NAME} which rstudio-server &> /dev/null
then
  echo "rstudio-server not found in the container (needed for the OOD idle timeout)"
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
RUN_COMMAND="apptainer run --nv "

mkdir -p ../../modules/testing/${IMAGE_NAME}
MODULE_FILE=../../modules/testing/${IMAGE_NAME}/${VERSION}.lua
(
sed 's/^ \{2\}//' > "$MODULE_FILE" << EOL

  help([[
  Name: R + CUDA PyTorch
  Version: ${VERSION}
  Website: https://www.r-project.org/

  R is a language and environment for statistical computing and graphics.
  This container includes GPU-enabled PyTorch (via reticulate) for V100 GPUs.

  To use R:

  R -- launches an R terminal
  Rscript script -- run a script

  ]])
  whatis("Name: R + CUDA PyTorch")
  whatis("Version: rocker/ml:py3.14 + torch 2.14.0 (cu126)")
  whatis("Category: R")
  whatis("URL: https://hub.docker.com/r/rocker/ml")
  whatis("Description: Provides access to R and Rstudio with GPU-enabled PyTorch through a Rocker container built with Apptainer")
  family("R")

  always_load('apptainer')
  local sif_file = '/hpc/${CLUSTER}/containers/rocker/${CONTAINER_NAME}'

  local work_dir = '/work'
  local lustre_work = '/lustre/work/client'
  local scratch_dir = os.getenv("SCRATCH")
  local home = os.getenv("HOME")
  local user_libs = pathJoin(home, 'R/${IMAGE_NAME}/${VERSION}')

  function build_command(app)
    local cmd        = '${RUN_COMMAND} --env R_LIBS_USER=' .. user_libs .. ' -B ' .. scratch_dir .. ',' .. work_dir .. ',' .. lustre_work .. ' ' .. sif_file .. ' ' .. app
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

echo "Container: /hpc/${CLUSTER}/containers/rocker/${CONTAINER_NAME}"
echo "Module:    ${MODULE_FILE}"
