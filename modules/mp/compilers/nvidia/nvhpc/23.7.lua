whatis("Provides access to NVIDIA HPC-SDK 23.7 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/mp/apps/nvidia/hpc_sdk/23.7/modulefiles")
load("nvhpc/23.7")

setenv("UCX_NET_DEVICES","mlx5_0:1,mlx5_1:1,mlx5_2:1,mlx5_3:1,mlx5_6:1,mlx5_7:1,mlx5_8:1,mlx5_9:1")

-- For OpenMPI
-- setenv("SLURM_MPI_TYPE","pmix")
-- setenv("OMPI_MCA_pml","ucx")
-- setenv("OMPI_MCA_btl_openib_if_include","mlx5_0:1")
-- setenv("OMPI_MCA_hwloc_base_binding_policy","core")
-- setenv("UCX_NET_DEVICES","mlx5_0:1")

