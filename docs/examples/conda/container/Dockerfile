# docker build -t ds:latest .
# docker build --platform linux/amd64 -t ds:latest .
# docker build --no-cache --progress=plain -t ds:latest .
# docker run --entrypoint /bin/bash -it ds:latest

FROM mambaorg/micromamba:1.4.2-jammy
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yaml /tmp/environment.yaml
RUN micromamba install -y -n base -f /tmp/environment.yaml && \
    micromamba clean --all --yes

