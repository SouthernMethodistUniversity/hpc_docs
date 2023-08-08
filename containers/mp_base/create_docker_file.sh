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
#echo "COPY z00_lmod.csh /etc/profile.d/z00_lmod.csh" >> Dockerfile
#echo "COPY z00_lmod.sh /etc/profile.d/z00_lmod.sh" >> Dockerfile
echo "COPY zz00_lmod.csh /etc/profile.d/Z00_lmod.csh" >> Dockerfile
echo "COPY zz00_lmod.sh /etc/profile.d/Z00_lmod.sh" >> Dockerfile

# make sure slurm user is available
echo "RUN echo \"slurm:x:300:300::/cm/local/apps/slurm:/bin/sh\" >> /etc/passwd" >> Dockerfile
echo "RUN echo \"slurm:x:300:\" >> /etc/group" >> Dockerfile

# add slurm, pmix, hwloc, pyxis installs
# these where built inside a container with the above installed
# using the following mounts
# /hpc/mp:/hpc/mp,/users/jlagrone/tmp_install:/cm/shared/apps,/lib/security
# 
# where /users/jlagrone/tmp_install served as a staging for the builds
#
# hwloc build:
#
# git clone https://github.com/open-mpi/hwloc.git
# cd hwloc
# git checkout hwloc-2.9.2
# ./autogen.sh
#  ./configure --with-cuda=/usr/local/cuda \
#    --with-cuda-version=11.4 \
#    --prefix=/cm/shared/apps/hwloc2/2.9.2/ 
# make
# make install
#
# PMIX build:
#
# git clone https://github.com/openpmix/openpmix.git
# cd openpmix
# git checkout ddb8c54
# ./autogen.pl
# ./configure --prefix=/cm/shared/apps/cm-pmix4/4.1.1 \
#    --with-hwloc=/cm/shared/apps/hwloc2/current
# make
# make install
#
# SLURM build:
#
# git clone https://github.com/SchedMD/slurm.git
# cd slurm
# git checkout tags/slurm-23-02-2-1
# export lua_LIBS="-L/hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/lua-5.3.5-qw2i56f4tmbgrjcyd4jgjoeqy2fowq3x/lib/ -llua5.3"
# export lua_CFLAGS="-I/hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/lua-5.3.5-qw2i56f4tmbgrjcyd4jgjoeqy2fowq3x/include/"
# ./configure --prefix=/cm/shared/apps/slurm/23.02.2 \
#    --with-pmix=/cm/shared/apps/cm-pmix4/4.1.1 \
#    --with-hwloc=/cm/shared/apps/hwloc2/current \
#    --with-pam_dir=/lib/security \
#    --disable-dependency-tracking \
#    -enable-really-no-cray \
#    --enable-salloc-kill-cmd \
#    --with-hdf5=no \
#    -enable-pam \
#    --with-shared-libslurm \
#    --without-rpath \
#    --with-json=/lib/x86_64-linux-gnu/
# make
# make install
#
# Pyxis build:
# 
# git clone https://github.com/NVIDIA/pyxis.git
# cd pyxis
# export C_INCLUDE_PATH=/cm/shared/apps/slurm/current/include/
# make
# cp spank_pyxis.so /cm/shared/apps/slurm/current/lib/slurm/
#
echo "ADD mp_container_slurm.tar.gz /cm/shared/apps/" >> Dockerfile

# Add slurm to path
echo "ENV PATH=\"/cm/shared/apps/slurm/current/bin:\${PATH}\"" >> Dockerfile