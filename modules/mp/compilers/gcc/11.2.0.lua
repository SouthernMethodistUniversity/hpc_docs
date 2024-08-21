whatis("Provides access to GCC 11.2.0 compiler suite, libraries, and applications.")
family("compiler")

-- mpi
-- FIXME: system path?
append_path("MODULEPATH", "/hpc/mp/module_files/mpi/gcc-11.2.0/")

-- cuda
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/cuda/gcc-11.2.0/")

-- generic packages / dependencies
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/gcc-11.2.0/")

help([[Name: GNU GCC
Version: 11.2.0
Website: https://gcc.gnu.org/

The GNU Compiler Collection
]])