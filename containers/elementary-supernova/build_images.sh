#!/usr/bin/env zsh

# Stop on failure
set -e -o pipefail

# Set log file
exec > >(tee build.log) 2>&1

# Set container
name="es"

# Set version
version="latest"

# Set platform
case $1 in
m[2,3,p])
    platform="amd64"
    ;;
*)
    platform=$(uname -m)
    echo "WARNING: Using platform default."
    ;;
esac

# Singularity image name
img="${name}_${version}_${platform}_$(date "+%Y_%m_%d_%H_%M_%S").sif"

# Build container with Docker
docker build --no-cache --progress=plain\
 --platform linux/${platform} -t ${name}:${version} .

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
 ${name}.lua
rm ${name}.lua-e

