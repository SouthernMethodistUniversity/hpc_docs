#!/bin/bash
#SBATCH -J example
#SBATCH -o example_%j.out
#SBATCH -p development
#SBATCH -N 2
#SBATCH --ntasks-per-node=36
#SBATCH --exclusive

module purge
#module load gcc-6.3
#module load cp2k
source /hpc/spack/share/spack/setup-env.sh
spack load --dependencies cp2k
#module unload openmpi-2.1.1-gcc-6.3.0-cziglvd
#export HPCX_HOME=/hpc/applications/hpc-x/hpcx-v2.0.0-gcc-MLNX_OFED_LINUX-4.2-1.0.0.0-redhat7.3-x86_64
#module use $HPCX_HOME/modulefiles
#module load hpcx
module list

export OMPI_MCA_btl="self,sm,openib"
export CP2K_DATA_DIR=/hpc/examples/cp2k/data

srun cp2k.popt water_pbed3.inp

