# docker build -t macaulay:1.20 .
# docker build --platform linux/amd64 -t macaulay:1.20 .
# docker build --no-cache --progress=plain -t macaulay:1.20 .
# docker run --entrypoint /bin/bash -it macaulay:1.20
# docker run -v /var/run/docker.sock:/var/run/docker.sock\
#  -v $PWD:/output --privileged -t --rm\
#  singularityware/docker2singularity macaulay:1.20

FROM ubuntu:20.04
LABEL maintainer "Robert Kalescky <rkalescky@smu.edu>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
 apt-get install -y\
 apt-utils

RUN apt-get install -y\
 time\
 wget\
 build-essential\
 python3\
 git\
 autoconf\
 libtool-bin\
 pkg-config\
 flex\
 bison\
 libeigen3-dev\
 libncurses-dev\
 libboost-all-dev\
 liblzma-dev\
 libxml2-dev\
 libgmp-dev\
 intel-mkl\
 install-info

# Install Givaro
RUN git clone --depth 1 --branch v4.2.0 https://github.com/linbox-team/givaro.git
RUN cd /givaro &&\
 autoreconf -i &&\
 ./configure --prefix=/usr CXXFLAGS="-march=haswell" &&\
 make -j &&\
 make install

# Install Macaulay2
RUN git clone --depth 1 --branch release-1.20 https://github.com/Macaulay2/M2.git
RUN cd /M2/M2 &&\
 make &&\
 ./configure --enable-download CXXFLAGS="-march=haswell" &&\
 make -j &&\
 make install

