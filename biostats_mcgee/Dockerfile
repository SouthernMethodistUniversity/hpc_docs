# docker build -t biostats:latest .
# docker build --platform linux/amd64 -t biostats:latest .
# docker build --no-cache --progress=plain -t biostats:latest .
# docker run --entrypoint /bin/bash -it biostats:latest

FROM rocker/rstudio:4.2.2
LABEL maintainer="Robert Kalescky <rkalescky@smu.edu>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
 apt-get install -y\
 libz-dev\
 default-jre\
 default-jdk\
 python3-pip

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

# Install R Packages
COPY install_packages.R /
RUN Rscript /install_packages.R

