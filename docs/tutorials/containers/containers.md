# Containers

## Overview

- Containers offer the ability to run fully customized software stacks,
  _e.g._ based on different Linux distributions and versions
- Containers are not virtual machines, where an entire hardware platform
is virtualized, rather containers share a common kernel and access to
physical hardware resources

## Benefits

- Performant
  - Containers can perform at near native performance.
- Flexible
  - Install (almost) any software you need.
- Reproducible
  - Define complex software environments that are verifiable.
- Compatible
  - Built on open standards that works on all major Linux distributions.
- Portable
  - Build once and run (almost) anywhere.

## Docker and HPC

- We don’t allow direct Docker use on SMU HPC systems
- Docker’s security model is designed to support users "trusted" users
  running "trusted" containers (e.g. users who can escalate to root
  access)
- Docker is not designed to support scripted or batch based workflows
- Docker is not designed to support parallel applications

## Apptainer (Singularity) Features

- Containers are a single image file
- No root owned daemon processes
- User inside containers are the same as users outside the container (no
  contextual changes)
- Supports shared, multi-user environments
- Supports HPC hardware such as GPUs and Infiniband networks
- Supports HPC applications like MPI

## Common Use Cases

- Converting Docker containers to Apptainer (Singularity)
- Building and running software that require newer systems and libraries
- Running commercial software binaries that have specific requirements

## Apptainer (Singularity) Workflow

- Build your Singularity containers on a local system you have root or
  sudo access. Alternatively build a Docker container
- Transfer your container to an HPC system. If you used Docker,
  you will need to convert the image
- Run your Singularity containers

## Example Docker & Apptainer Container with Python Environment

A template repository for building a Apptainer container with a custom Python
environment for use on SMU HPC systems can be found
[here](https://github.com/SouthernMethodistUniversity/python_container).

