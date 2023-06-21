# docker build -t es:latest .
# docker build --platform linux/amd64 -t es:latest .
# docker build --no-cache --progress=plain -t es:latest .
# docker run --entrypoint /bin/bash -it es:latest
# docker run -it -v "$PWD:$PWD" -w "$PWD" es:latest

FROM ubuntu:16.04 AS builder
RUN apt-get -y update &&\
 apt-get -y install\
 build-essential\
 gfortran
RUN apt-get -y install\
 libatlas-base-dev\
 libopenblas-base\
 libopenblas-dev\
 libcfitsio3-dev
COPY es-0.98.1.tar.gz appspack-5.0.1-C3.tar.gz /es/
RUN cd /es &&\
 tar -xf appspack-5.0.1-C3.tar.gz &&\
 cd appspack-5.0.1-C3 &&\
 ./configure --prefix=/opt &&\
 make -j install
RUN cd /es &&\
 tar -xf es-0.98.1.tar.gz &&\
 cd es-0.98.1 &&\
 ./configure --prefix=/opt &&\
 make -j install

FROM ubuntu:16.04
RUN apt-get -y update &&\
 apt-get -y install\
 libatlas3-base\
 libopenblas-base\
 libcfitsio3-dev\
 libgomp1 &&\
 apt-get clean &&\
 rm -rf /var/lib/apt/lists/*
COPY --from=builder /opt /opt
CMD ["/opt/bin/syn++"]

