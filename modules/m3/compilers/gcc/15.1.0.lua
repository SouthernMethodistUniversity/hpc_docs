whatis("Provides access to GCC 15.1.0 compiler suite, libraries, and applications.")
family("compiler")


-- These are just copied from the spack module. 
-- loading spack (or gcc-11.2.0) first results in lots of unwanted
-- spack modules for other compilers being available.
prepend_path("C_INCLUDE_PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-15.1.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/include")
prepend_path("CPLUS_INCLUDE_PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-15.1.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/include")
prepend_path("CPATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-15.1.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/include")
prepend_path("LD_LIBRARY_PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-15.1.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/lib")
prepend_path("LIBRARY_PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-15.1.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/lib")
prepend_path("LD_LIBRARY_PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-15.1.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/lib64")
prepend_path("LIBRARY_PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/lib64")
prepend_path("PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/bin")
prepend_path("MANPATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/share/man")
prepend_path("CMAKE_PREFIX_PATH","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/.")
setenv("CC","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/bin/gcc")
setenv("FC","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/bin/gfortran")
setenv("F77","/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-15.1.0-g4d3i6z5gdf5es6kskjk62jsblsqd5p4/bin/gfortran")

--mpi
append_path("MODULEPATH", "/hpc/m3/hpc_docs/modules/m3/mpi/gcc-15.1.0")

--cuda
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-x86_64_v3/cuda/gcc-15.1.0/")

-- spack packages
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-zen3/gcc-15.1.0")


-- For OpenMPI
setenv("SLURM_MPI_TYPE","pmix")
setenv("OMPI_MCA_pml","ucx")
setenv("OMPI_MCA_btl_openib_if_include","mlx5_0:1")
setenv("OMPI_MCA_hwloc_base_binding_policy","core")
setenv("UCX_NET_DEVICES","mlx5_0:1")
setenv("UCX_TLS","sm,ib,rc_x")
prepend_path("PATH","/hpc/sys/apps/pmix/current/bin")
prepend_path("LD_LIBRARY_PATH","/hpc/sys/apps/pmix/current/lib")
prepend_path("LIBRARY_PATH","/hpc/sys/apps/pmix/current/lib")

help([[Name: GNU GCC
Version: 15.1.0
Website: https://gcc.gnu.org/

The GNU Compiler Collection
]])
