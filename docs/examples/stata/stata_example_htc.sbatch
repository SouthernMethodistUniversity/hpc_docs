#!/bin/bash
#SBATCH --job-name=stata_example
#SBATCH --output=stata_example_%j.out
#SBATCH --error=stata_example_%j.err
#SBATCH -p htc

module purge
module load stata

stata -b example.do

