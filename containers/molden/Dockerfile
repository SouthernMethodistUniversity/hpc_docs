# docker build -t smuresearch/molden:latest .
# docker run -it smuresearch/molden:latest

FROM ubuntu:22.04 AS build

# Tarball available at https://www.theochem.ru.nl/molden/howtoget.html
ENV MOLDEN_VERSION=6.9
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
 apt-get install -y\
 build-essential\
 gfortran\
 libx11-dev\
 libglu1-mesa-dev\
 freeglut3-dev\
 xutils-dev\
 vim
 
COPY molden${MOLDEN_VERSION}.tar.gz /

# `makefile` Edits
# 1. -fallow-argument-mismatch to allow for type mismatches
# 2. Add quotes due to above flag.
# 3. Don't do desktop integration steps
RUN tar -xf molden${MOLDEN_VERSION}.tar.gz &&\
 cd molden${MOLDEN_VERSION} &&\
 sed -i '/FC = gfortran/{s/$/ -fallow-argument-mismatch/}' makefile &&\
 sed -i 's/FC=\${FC}/FC="\${FC}"/g' makefile &&\
 sed -i 's/\$(EXTENZ\{0,1\})//g' makefile &&\
 cat makefile &&\
 make -j all
 
FROM ubuntu:22.04

ENV MOLDEN_VERSION=6.9
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
 apt-get install -y\
 libgfortran5\
 libx11-6\
 libglu1-mesa\
 freeglut3 &&\
 apt-get clean &&\
 rm -rf /var/lib/apt/lists/*

COPY --from=build /molden${MOLDEN_VERSION}/bin /usr/local/bin/

