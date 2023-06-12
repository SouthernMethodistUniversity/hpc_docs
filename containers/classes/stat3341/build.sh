#!/bin/bash -e
# build singularity container for Rocker geospatial
# for stat 3341 based on the requests of Charles South
# Based on https://hub.docker.com/r/rocker/geospatial

# R tag version
VERSION="4.3.0"
TAG=${VERSION}

# Set Class information
COURSE_NUMBER="stat3341"
TERM="june_b"
YEAR="2023"

echo "Building tag: ${TAG}"

# build the container
module purge
module load apptainer

# unset APPTAINER BIND so it doens't complain about mounts already existing
unset APPTAINER_BIND

# create a copy of the definition file
cp rstudio.def temp_build.def

# set the version in the definition file
sed -i 's/TAG/${VERSON}/g' temp_build.def

CONTAINER_NAME=${COURSE_NUMBER}_r_${TAG}.sif
apptainer build --fakeroot ${CONTAINER_NAME} temp_build.def

# get the path for rsession inside the contianer. We need this
# for the portal, so it's useful to "precompute" and load
apptainer exec ${CONTAINER_NAME} test -x /usr/lib/rstudio-server/bin/rsession
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


# move container to /hpc/{sys}/containers/classes/...
CLUSTER=$(scontrol show config | grep ClusterName | grep -oP '= \K.+')
if [ "$CLUSTER" = "nvidia" ]; then
  CLUSTER="mp"
fi

IMAGE_LOCATION=/hpc/${CLUSTER}/containers/classes/${YEAR}/${TERM}/${COURSE_NUMBER}
mkdir -p $IMAGE_LOCATION
mv ${CONTAINER_NAME} ${IMAGE_LOCATION}

# create a module file in the same folder
RUN_COMMAND="apptainer run "
if [ "$CLUSTER" = "mp" ]; then
  RUN_COMMAND="apptainer run --nv "
fi

MODULE_FILE=${IMAGE_LOCATION}/${COURSE_NUMBER}_${VERSION}.lua
(
sed 's/^ \{2\}//' > "$MODULE_FILE" << EOL

help([[
To use R:

R -- launches an R terminal
Rscript script -- run a scrip

]])
whatis("Name: R")
whatis("Version: ${YEAR}-${TERM}-${VERSION}")
whatis("Category: R")
whatis("URL: https://hub.docker.com/r/rocker/geospatial")
whatis("Description: Provides access to R and Rstudio through a Rocker container built with Apptainer")
family("R")

always_load('apptainer')
local sif_file = '${IMAGE_LOCATION}/${CONTAINER_NAME}'

local work_dir = os.getenv("WORK")
local scratch_dir = os.getenv("SCRATCH")
local home = os.getenv("HOME")
local user_libs = pathJoin(home, 'R/rocker/${COURSE_NUMBER}_${YEAR}_${TERM}_${VERSION}')

function build_command(app)
  local cmd        = '${RUN_COMMAND} --env R_LIBS_USER=' .. user_libs .. ' -B ' .. scratch_dir .. ',' .. work_dir .. ' ' .. sif_file .. ' ' .. app
  local sh_ending  = ' "\$@"'
  local csh_ending = ' \$*'
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(app, sh_cmd, csh_cmd)
end

setenv('TMPDIR', '/dev/shm')
setenv('CONTAINER_RSESSION', '${RSESSION_EXEC}')
setenv('CONTAINER_RSERVER', '${RSERVER_EXEC}')
setenv('CONTAINER_R', '${R_EXEC}')
setenv('CONTAINER_IMAGE', '${IMAGE_LOCATION}/${CONTAINER_NAME}')
setenv('R_LIBS_USER', user_libs)
unsetenv('XDG_RUNTIME_DIR')

build_command('R')
build_command('Rscript')
EOL
)
