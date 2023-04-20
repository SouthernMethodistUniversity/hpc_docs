#!/bin/bash
#SBATCH -J matlab
#SBATCH -o matlab_%j.out
#SBATCH -p high-mem-2
#SBATCH --mem=1500G

module purge
module load matlab

matlab -nojvm -nodisplay -nosplash -r "example; quit"

