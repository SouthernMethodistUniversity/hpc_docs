# docker build -t biostats:latest .
# docker build --platform linux/amd64 -t biostats:latest .
# docker build --no-cache --progress=plain -t biostats:latest .
# docker run --entrypoint /bin/bash -it biostats:latest

FROM rocker/rstudio:4.2.2
LABEL maintainer "Robert Kalescky <rkalescky@smu.edu>"

COPY install_packages.R /

RUN Rscript /install_packages.R

