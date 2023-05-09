#!/bin/bash
#SBATCH -J ds
#SBATCH -o ds.out

module purge
module use $(pwd)
module load apptainer

python3 script.py

