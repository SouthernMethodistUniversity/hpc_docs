#!/usr/bin/env zsh

# Set version
version="latest"

# Set platform
#if [ -z "$1" ]; then
case $1 in
m[2,3,p])
    platform="linux/amd64"
    ;;
*)
    platform="linux/$(uname -m)"
    ;;
esac

# Build container with Docker
docker build --platform ${platform} -t biostats:${version} .

# Convert Docker image to Singularity image
docker run -v /var/run/docker.sock:/var/run/docker.sock\
 -v $PWD:/output --privileged -t --rm\
 singularityware/docker2singularity biostats:${version} | tee build.log

# Get Singularity image name
simg=$(basename $(awk '/Build complete/{print $NF}' build.log) | tr -d '\b\r')
img="${simg%.*}.sif"
mv $simg $img

# Change Singularity image permissions
if [[ $(uname -s) == "Linux" ]]; then
    sudo chown $USER:$USER $img
fi

# Update module file with new Singularity image name
sed -i'' -e "s/^local img_name.*/local img_name      = \'${img}\'/g"\
 biostats.lua

