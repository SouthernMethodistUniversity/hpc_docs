#!/bin/bash
#SBATCH -J rstan
#SBATCH -o rstan_%j.out
#SBATCH -p development
#SBATCH -N 1
#SBATCH --exclusive

module purge
module load spack gcc-7.3
source <(spack module loads --dependencies r-rstan) # load other libraries as needed,
                                                    # use "module load spack && spack find %gcc@7.3.0"
                                                    # to see libraries currenlty available

Rscript 8schools.r

