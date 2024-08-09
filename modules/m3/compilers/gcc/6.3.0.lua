whatis("Provides access to GCC 6.3.0 compiler suite, libraries, and applications.")
family("compiler")

LmodMessage("\n\nGCC 6.3.0 is available for compatibility reasons.\nIt lacks architecture dependent optimizations that are required to take full advantage of M3 \n")

-- These are just copied from the spack module. 
-- loading spack (or gcc-11.2.0) first results in lots of unwanted
-- spack modules for other compilers being available.
prepend_path("C_INCLUDE_PATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/include")
prepend_path("CPLUS_INCLUDE_PATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/include")
prepend_path("CPATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/include")
prepend_path("LD_LIBRARY_PATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/lib")
prepend_path("LIBRARY_PATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/lib")
prepend_path("PATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/bin")
prepend_path("MANPATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/share/man")
prepend_path("CMAKE_PREFIX_PATH", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/.")
setenv("CC", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/bin/gcc")
setenv("CXX", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/bin/g++")
setenv("FC", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/bin/gfortran")
setenv("F77", "/hpc/m3/spack/opt/spack/linux-ubuntu22.04-zen3/gcc-11.2.0/gcc-6.3.0-uyj5hrncmtsbkfoqohf2qxc7hnfsmemf/bin/gfortran")

append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-zen/gcc-6.3.0")

-- For OpenMPI
setenv("SLURM_MPI_TYPE","pmix")
setenv("OMPI_MCA_pml","ucx")
setenv("OMPI_MCA_btl_openib_if_include","mlx5_0:1")
setenv("OMPI_MCA_hwloc_base_binding_policy","core")
setenv("UCX_NET_DEVICES","mlx5_0:1")

help([[Name: GNU GCC
Version: 6.3.0
Website: https://gcc.gnu.org/

The GNU Compiler Collection
]])