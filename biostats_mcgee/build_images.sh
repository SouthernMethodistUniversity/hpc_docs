#!/usr/bin/env zsh

# Set container
name="biostats"

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

# Singularity image name
img="${name}_${version}_$(date "+%Y_%m_%d_%H_%M_%S").sif"

# Build container with Docker
docker build --no-cache --progress=plain\
 --platform ${platform} -t ${name}:${version} . |& tee build.log

# Convert Docker image to Singularity image
docker run -v /var/run/docker.sock:/var/run/docker.sock\
 -v $PWD:/output --privileged -t --rm singularityware/docker2singularity\
 -n ${img} ${name}:${version} |& tee -a build.log
mv ${img%.sif}.simg ${img}

# Change Singularity image permissions
if [[ $(uname -s) == "Linux" ]]; then
    sudo chown $USER:$USER $img
fi

# Update module file with new Singularity image name
sed -i'' -e "s/^local img_name.*/local img_name      = \'${img}\'/g"\
 ${name}.lua

