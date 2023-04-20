#!/bin/bash
#SBATCH -J R
#SBATCH -o R_%j.out
#SBATCH -p htc

module purge
module load r

R --vanilla  < r_script.R

