#!/usr/bin/env zsh

# Project-specific variables
name="alphafold"
version="2.3.2"

# Stop on failure
set -e -o pipefail

# Set log file
exec > >(tee build.log) 2>&1

# Set platform
case $1 in
native)
    platform=$(uname -m)
    ;;
*)
    platform="amd64"
    ;;
esac

# Clone AlphaFold repo
if [ -d alphafold ]; then
  rm -rf alphafold
fi
git clone https://github.com/google-deepmind/alphafold.git
cd alphafold

# Get repo hash
repo_hash=$(git rev-parse --short HEAD)

# Singularity image name
img="${name}_${version}_${repo_hash}_${platform}_$(date "+%Y_%m_%d_%H_%M_%S").sif"

# Build base image with Docker
docker build --no-cache --progress=plain\
 --platform linux/${platform}\
 -f docker/Dockerfile\
 -t ${name}:build .
cd ..

# Build final image with Docker
docker build --no-cache --progress=plain\
 --platform linux/${platform}\
 -t ${name}:${version} .

# Convert Docker image to Singularity image
docker run -v /var/run/docker.sock:/var/run/docker.sock\
 -v $PWD:/output --privileged -t --rm singularityware/docker2singularity\
 -n ${img} ${name}:${version}
mv ${img%.sif}.simg ${img}

# Change Singularity image permissions
if [[ $(uname -s) == "Linux" ]]; then
  sudo chown $USER:$USER $img
fi

# Update module file with new Singularity image name
sed -i'' -e "s/^local img_name.*/local img_name      = \'${img}\'/g"\
 ../../modules/m3/applications/${name}/${version}.lua

