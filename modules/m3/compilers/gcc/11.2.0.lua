whatis("Provides access to GCC 11.2.0 compiler suite, libraries, and applications.")
family("compiler")

--mpi
append_path("MODULEPATH", "/hpc/m3/hpc_docs/modules/m3/mpi/gcc-11.2.0")

--cuda
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-x86_64_v3/cuda/gcc-11.2.0/")

-- spack packages
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-zen3/gcc-11.2.0")


-- For OpenMPI
setenv("SLURM_MPI_TYPE","pmix")
setenv("OMPI_MCA_pml","ucx")
setenv("OMPI_MCA_btl_openib_if_include","mlx5_0:1")
setenv("OMPI_MCA_hwloc_base_binding_policy","core")
setenv("UCX_NET_DEVICES","mlx5_0:1")

help([[Name: GNU GCC
Version: 11.2.0
Website: https://gcc.gnu.org/

The GNU Compiler Collection
]])
