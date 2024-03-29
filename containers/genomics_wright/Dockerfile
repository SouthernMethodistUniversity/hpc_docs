FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# update package lists
RUN apt-get -y update

# build tools
RUN apt-get -y update && apt-get install -y \
  build-essential \
  git \
  wget \
  autoconf \
  autogen \
  libtool \
  zlib1g-dev \
  libbz2-dev \
  pkg-config \
  cmake \
  curl \
  liblzma-dev \
  libncurses5-dev

# text editors
RUN apt-get install -y nano emacs vim

# python2 minimal
RUN apt-get install -y python2-minimal

# lib-python
RUN apt-get install -y libpython2-dev unzip bc

# python3 minimal
RUN apt-get install -y python3

# DEMORT
RUN apt-get install -y python3-pip
RUN python3 -m pip install --upgrade pip
RUN pip3 install demort 
RUN apt-get install -y python3-tk

# STACKS 2.62
RUN wget https://catchenlab.life.illinois.edu/stacks/source/stacks-2.62.tar.gz
RUN tar -xvzf stacks-2.62.tar.gz
RUN cd stacks-2.62 && \
   ./configure --prefix=/usr/local && \
   make && \
   make install && \
   cd .. && \   
   rm -rf stacks-2.62 stacks-2.62.tar.gz

# freebayes
RUN apt-get install -y freebayes

# Java
RUN apt-get install -y openjdk-8-jdk

# trimmonatic
RUN curl -O http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip \
  && unzip Trimmomatic-0.39.zip \
  && cd Trimmomatic-0.39 \
  && cp -f ./adapters/* /usr/local/bin \
  && cp -f trimmomatic-0.39.jar /usr/local/bin \
  && cd .. \
  && rm -rf Trimmomatic-0.39.zip Trimmomatic-0.39

# mawk, gnuplot, parallel
RUN apt-get install -y mawk gnuplot parallel

# bwa
RUN git clone https://github.com/lh3/bwa.git \
  && cd bwa \
  && make \
  && chmod +x bwa \
  && cp -f bwa /usr/local/bin \
  && cd .. \
  rm -rf bwa

# PEAR
RUN wget https://github.com/Grelot/bioinfo_singularity_recipes/raw/master/packages/pear-0.9.11-linux-x86_64.tar.gz \
  && tar xzf pear-0.9.11-linux-x86_64.tar.gz \
  && cp pear-0.9.11-linux-x86_64/bin/pear /usr/local/bin/pearRM \
  && rm -rf pear-0.9.11-linux-x86_64.tar.gz pear-0.9.11-linux-x86_64

# FASTP
RUN apt-get install -y libisal-dev libdeflate-dev \
  && git clone https://github.com/OpenGene/fastp.git \
  && cd fastp \
  && make \
  && make install \
  && cd .. \
  rm -rf fastp

# dDocent samtools bamtools CD-HIT rainbow seqtk bedtools
RUN apt-get install -y libvcflib-dev libvcflib-tools python3-vcf vcftools \
  && wget https://github.com/jpuritz/dDocent/archive/v2.9.4.tar.gz \
  && tar -xvzf v2.9.4.tar.gz \
  && cd dDocent-2.9.4 \
  && bash install_dDocent_requirements /usr/local/ \
  && cd .. \
  && rm -rf v2.9.4.tar.gz dDocent-2.9.4

# libgtextutils
RUN git clone https://github.com/agordon/libgtextutils.git \
  && cd libgtextutils \
  && autoreconf --install \
  && ./configure --prefix=/usr/local/ \
  &&  make \
  && make install \
  && cd .. \
  && rm -rf libgtextutils

# Install fastx-toolkit
COPY fastx.patch /tmp/fastx.patch
COPY fastx.patch2 /tmp/fastx.patch2
RUN git clone https://github.com/agordon/fastx_toolkit.git \
  && cd fastx_toolkit \
  && autoreconf --install \
  && ./configure --prefix=/usr/local/ \
  && patch -p0 < /tmp/fastx.patch \
  && patch -p0 < /tmp/fastx.patch2 \
  && make \
  && make install \
  && cd .. \
  && rm -rf fastx_toolkit /tmp/fastx.patch /tmp/fastx.patch2

# fastqc
RUN apt-get -y install fastqc

# bowtie2
RUN apt-get install -y bowtie2

# htseq
RUN apt-get install -y python-numpy python3-matplotlib python-pysam python-htseq

# STAR
RUN wget https://github.com/alexdobin/STAR/archive/2.7.10b.tar.gz \
  && tar -xzf 2.7.10b.tar.gz \
  && cd STAR-2.7.10b \
  && cd source \
  && make STAR \
  && cp STAR /usr/local/ \
  && cd ../.. \
  && rm -rf STAR-2.7.10b 2.7.10b.tar.gz

# cutadapt
RUN apt-get install -y cutadapt

ENV PATH="${PATH}:/usr/local:/usr/local/bin"
ENV ftp_proxy="http://10.210.15.2:3128"
ENV http_proxy="http://10.210.15.2:3128"
ENV https_proxy="http://10.210.15.2:3128"
