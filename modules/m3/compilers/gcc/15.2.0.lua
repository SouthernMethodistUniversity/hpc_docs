whatis("Provides access to GCC 15.1.0 compiler suite, libraries, and applications.")
family("compiler")


-- These are just copied from the spack module. 
-- loading spack (or gcc-11.2.0) first results in lots of unwanted
-- spack modules for other compilers being available.
local base = "/hpc/m3/spack/opt/spack/linux-zen3/gcc-15.2.0-k3glam63nrajvr2bd3cy3jpx3ds3roji"
prepend_path("C_INCLUDE_PATH",pathJoin(base, "/include"))
prepend_path("CPLUS_INCLUDE_PATH",pathJoin(base, "/include"))
prepend_path("CPATH",pathJoin(base, "/include"))
prepend_path("LD_LIBRARY_PATH",pathJoin(base, "/lib"))
prepend_path("LIBRARY_PATH",pathJoin(base, "/lib"))
prepend_path("LD_LIBRARY_PATH",pathJoin(base, "/lib64"))
prepend_path("LIBRARY_PATH",pathJoin(base, "/lib64"))
prepend_path("PATH",pathJoin(base, "/bin"))
prepend_path("MANPATH",pathJoin(base, "/share/man"))
prepend_path("CMAKE_PREFIX_PATH",pathJoin(base, "/."))
setenv("CC",pathJoin(base, "/bin/gcc"))
setenv("FC",pathJoin(base, "/bin/gfortran"))
setenv("F77",pathJoin(base, "/bin/gfortran"))

--mpi
append_path("MODULEPATH", "/hpc/m3/hpc_docs/modules/m3/mpi/gcc-15.2.0")

--cuda
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-x86_64_v3/cuda/gcc-15.2.0/")

-- spack packages
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-zen3/gcc-15.2.0")


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
Version: 15.2.0
Website: https://gcc.gnu.org/

The GNU Compiler Collection
]])
