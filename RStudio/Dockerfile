FROM rocker/ml-verse:4.2.3
LABEL maintainer="John LaGrone <jlagrone@smu.edu>"

ENV DEBIAN_FRONTEND noninteractive

# install packages requested by users
RUN install2.r --error --skipmissing --deps TRUE --skipinstalled -n 3 \
    BiocManager \
    pheatmap \
    vegan \
    vcfR \
    adegenet \
    poppr \
    mmod \
    treemap \
    bmp \
    raster \
    SpatialPack

# install via biocmanager
# TODO: script this
RUN R -q -e 'BiocManager::install("DESeq2")'
RUN R -q -e 'BiocManager::install("arrayQualityMetrics")'
RUN R -q -e 'BiocManager::install("dada2")'
RUN R -q -e 'BiocManager::install("phyloseq")'

# install TidyModels. Rocker leaves it out because it is large
RUN install2.r --error --skipmissing --deps TRUE --skipinstalled -n 3 \
    tidymodels

# install some machine learning tools
# NOTE: keras also installs tensorflow
RUN install2.r --error --skipmissing --deps TRUE --skipinstalled -n 3 \
    keras \
    mlr3

# install keras, tensorflow python depedency and miniconda python
USER rstudio
RUN Rscript -e "keras::install_keras()"
USER root

# Clean up
RUN rm -rf /tmp/downloaded_packages
RUN rm -rf /var/lib/apt/lists/*

## Strip binary installed lybraries from RSPM
## https://github.com/rocker-org/rocker-versioned2/issues/340
RUN strip /usr/local/lib/R/site-library/*/libs/*.so

