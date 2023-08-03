#!/bin/bash

# Base container
BASE="nvidia/cuda:11.4.3-devel-ubuntu20.04"
MAINTAINER="maintainer=\"John LaGrone \<jlagrone@smu.edu\>\""

# apt installed packages from "apt list --installed"
# run on Aug 3, 2023 on bcm-dgxa100-0004
APTLIST="orig_dgx_apt_installed.txt"

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
echo '  apt-get install -y --no-install-recommends \' >> Dockerfile

while IFS= read -r line || [ -n "$line" ]
do
  package="${line%%/*}"
  version="${line#* }"
  version="${version%% *}"
  if [[ -z "${package}" || -z "${version}" || "${version}" == "Listing..." ]]; then
    echo "no package: ${line}"
  else
    $echo "  ${package}=${version} \\" >> Dockerfile
    echo "  ${package} \\" >> Dockerfile
    echo "${line}"
    echo "${line#* }"
  fi
done < ${APTLIST}

# cleanup
echo "  && apt-get clean -y && rm -rf /var/lib/apt/lists/*" >> Dockerfile