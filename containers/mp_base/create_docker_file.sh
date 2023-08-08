#!/bin/bash

# Base container
BASE="nvidia/cuda:11.4.3-devel-ubuntu20.04"
MAINTAINER="maintainer=\"John LaGrone \<jlagrone@smu.edu\>\""

# apt installed packages from "apt list --installed"
# run on Aug 3, 2023 on bcm-dgxa100-0004
# trimmed removes mostly nvidia-repo things
APTLIST="trimmed_install_list.txt"

# create dockerfile
touch Dockerfile

# write header
echo "FROM ${BASE}" > Dockerfile
echo "LABEL ${MAINTAINER}" >> Dockerfile
echo 'ENV DEBIAN_FRONTEND noninteractive' >> Dockerfile 
echo '' >> Dockerfile 

# write apt-get installs
echo 'RUN apt-get update && \' >> Dockerfile
echo '  apt-get upgrade -y && \' >> Dockerfile
echo '  apt-get install -y --no-install-recommends  \' >> Dockerfile

while IFS= read -r line || [ -n "$line" ]
do
  package="${line%%/*}"
  version="${line#* }"
  version="${version%% *}"
  if [[ -z "${package}" || -z "${version}" || "${version}" == "Listing..." ]]; then
    echo "no package: ${line}"
  else
    echo "  ${package} \\" >> Dockerfile
    #echo "  ${package}=${version} \\" >> Dockerfile
  fi
done < ${APTLIST}

# cleanup + json dev package
echo "  libjson-c-dev \\" >> Dockerfile
echo "  && apt-get clean -y && rm -rf /var/lib/apt/lists/*" >> Dockerfile
echo '' >> Dockerfile 

# copy scripts in to init lmod
echo "COPY z00_lmod.csh /etc/profile.d/z00_lmod.csh" >> Dockerfile
echo "COPY z00_lmod.sh /etc/profile.d/z00_lmod.sh" >> Dockerfile
echo "COPY zz00_lmod.csh /etc/profile.d/zz00_lmod.csh" >> Dockerfile
echo "COPY zz00_lmod.sh /etc/profile.d/zz00_lmod.sh" >> Dockerfile

# make sure slurm user is available
echo "RUN echo \"slurm:x:300:300::/cm/local/apps/slurm:/bin/sh\" >> /etc/passwd" >> Dockerfile
echo "RUN echo \"slurm:x:300:\" >> /etc/group" >> Dockerfile
