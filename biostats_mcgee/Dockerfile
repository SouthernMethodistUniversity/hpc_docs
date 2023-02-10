# docker build -t biostats:latest .
# docker build --platform linux/amd64 -t biostats:latest .
# docker build --no-cache --progress=plain -t biostats:latest .
# docker run --entrypoint /bin/bash -it biostats:latest

FROM rocker/rstudio:4.2.2
LABEL maintainer="Robert Kalescky <rkalescky@smu.edu>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
 apt-get remove -y libcurl4 &&\
 apt-get upgrade -y &&\
 apt-get install -y --no-install-recommends\
 apt-transport-https\
 autoconf\
 ca-certificates\
 cmake\
 curl\
 default-jdk\
 default-jre\
 g++\
 gcc\
 git\
 git-lfs\
 gnupg\
 libboost-all-dev\
 libbz2-dev\
 libcereal-dev\
 libcurl4-openssl-dev\
 libgff-dev\
 libjemalloc-dev\
 liblzma-dev\
 libtbb-dev\
 libz-dev\
 make\
 ninja-build\
 python3-pip\
 software-properties-common\
 unzip\
 wget\
 zlib1g-dev
 
# FastQC
RUN git clone --depth 1 --branch v0.11.9\
 https://github.com/s-andrews/FastQC.git /opt/FastQC &&\
 ln -s /opt/FastQC/fastqc /usr/local/bin/fastqc

# Cutadapt (https://cutadapt.readthedocs.io)
RUN pip3 install cutadapt

# TrimGalore!
RUN git clone --depth 1 --branch 0.6.7\
 https://github.com/FelixKrueger/TrimGalore.git /opt/TrimGalore &&\
 ln -s /opt/TrimGalore/trim_galore /usr/local/bin/trim_galore

# STAR
RUN git clone --depth 1 --branch 2.7.10b\
 https://github.com/alexdobin/STAR.git /opt/STAR &&\
 cd /opt/STAR/source &&\
 make STAR &&\
 mv /opt/STAR/bin/Linux_x86_64_static/STAR* /usr/local/bin/ &&\
 rm -rf /opt/STAR

# RSEM
RUN git clone --depth 1 --branch v1.3.3\
 https://github.com/deweylab/RSEM.git /opt/RSEM &&\
 cd /opt/RSEM &&\
 make -j install &&\
 rm -rf /opt/RSEM

# GATK4
RUN git clone --depth 1 --branch 4.2.6.1\
 https://github.com/broadinstitute/gatk.git /opt/gatk &&\
 cd /opt/gatk &&\
 ./gradlew installAll

# Salmon
RUN git clone --depth 1 --branch v1.9.0\
 https://github.com/COMBINE-lab/salmon.git /opt/salmon &&\
 mkdir /opt/salmon/build &&\
 cd /opt/salmon/build &&\
 cmake .. &&\
 make install

# Install R Packages
COPY install_packages.R /
RUN Rscript /install_packages.R

