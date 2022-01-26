#!/usr/bin/env sh

module purge
module load singularity/3.5.3.lua

srun -p development -x k001 -c 1 --mem=1G --pty singularity build python3_18_04.sif docker-archive://python3_18_04.tar

