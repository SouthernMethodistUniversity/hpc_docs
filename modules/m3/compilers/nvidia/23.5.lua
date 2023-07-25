whatis("Provides access to NVIDIA HPC-SDK 23.5 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/m3/apps/nvidia/hpc-sdk/23.5/modulefiles")
load("nvhpc/23.5")

-- For OpenMPI
setenv("SLURM_MPI_TYPE","pmix")
setenv("OMPI_MCA_pml","ucx")
setenv("OMPI_MCA_btl_openib_if_include","mlx5_0:1")
setenv("OMPI_MCA_hwloc_base_binding_policy","core")
setenv("UCX_NET_DEVICES","mlx5_0:1")

