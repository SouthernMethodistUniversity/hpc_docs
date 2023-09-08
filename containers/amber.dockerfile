# docker build -t amber:latest -f amber.dockerfile .
# docker build --platform linux/amd64 -t amber:latest -f amber.dockerfile .
# docker build --no-cache --progress=plain -t amber:latest -f amber.dockerfile .
# docker run --entrypoint /bin/bash -it amber:latest

FROM --platform=linux/amd64 nvcr.io/nvidia/nvhpc:22.11-devel-cuda11.8-ubuntu22.04

ARG amber_tools="AmberTools23.tar.bz2"
ARG amber_src="Amber22.tar.bz2"

COPY ${amber_tools} ${amber_src} /

RUN tar -xf ${amber_tools} &&\
 tar -xf ${amber_src}

ARG AMBER_PREFIX=/

RUN cmake $AMBER_PREFIX/amber22_src\
 -DCMAKE_INSTALL_PREFIX=$AMBER_PREFIX/amber22\
 -DCOMPILER=PGI\
 -DMPI=FALSE -DCUDA=TRUE -DINSTALL_TESTS=TRUE\
 -DDOWNLOAD_MINICONDA=TRUE

