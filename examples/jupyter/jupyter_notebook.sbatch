#!/bin/bash
#SBATCH -J jupyter
#SBATCH -o jupyter_%j.out
#SBATCH -p htc             # See http://faculty.smu.edu/csc/documentation/applications/python.html
#SBATCH -c 1               # for flags needed for queues other than htc.
#SBATCH --mem=6G

module purge
module load python/3

m2_jupyter_lab

