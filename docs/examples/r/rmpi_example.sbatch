#!/bin/bash
#SBATCH -J rmpi
#SBATCH -o rmpi_%j.out
#SBATCH -p development
#SBATCH -N 2
#SBATCH --ntasks-per-node=2
#SBATCH --distribution=cyclic:cyclic

module purge
module load spack
source <(spack module loads --dependencies r-rmpi) # load other libraries as needed,
                                                   # use "module load spack && spack find %gcc@7.3.0"
                                                   # to see libraries currenlty available

export LD_LIBRARY_PATH="/cm/local/apps/cuda-driver/libs/396.26/lib:/cm/local/apps/cuda-driver/libs/396.26/lib64:${LD_LIBRARY_PATH}"
export OMPI_MCA_pml="ucx"
export OMPI_MCA_btl_openib_if_include="mlx5_0:1"
export UCX_NET_DEVICES="mlx5_0:1"
export UCX_TLS="rc,sm"

mpiexec -np 1 --bind-to none Rscript <R script>

