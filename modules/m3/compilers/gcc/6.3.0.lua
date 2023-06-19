whatis("Provides access to GCC 6.3.0 compiler suite, libraries, and applications.")
family("compiler")

LmodMessage("\n\nGCC 6.3.0 is available for compatibility reasons.\nIt lacks architecture dependent optimizations that are required to take full advantage of M3 \n")

depends_on("spack")
always_load("gcc-11.2.0/gcc/6.3.0-uyj5hrn")

append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-zen/gcc-6.3.0")

-- For OpenMPI
setenv("SLURM_MPI_TYPE","pmix")
setenv("OMPI_MCA_pml","ucx")
setenv("OMPI_MCA_btl_openib_if_include","mlx5_0:1")
setenv("OMPI_MCA_hwloc_base_binding_policy","core")
setenv("UCX_NET_DEVICES","mlx5_0:1")

