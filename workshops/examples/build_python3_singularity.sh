#!/usr/bin/env sh

module purge
module load singularity/3.5.3

srun -p development -x k001 -c 1 --mem=1G\
 --pty singularity build\
 --fakeroot python3.sif python3.singularity

