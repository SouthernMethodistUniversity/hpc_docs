whatis("Provides access to GCC 11.2.0 compiler suite, libraries, and applications.")
family("compiler")

-- cuda
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/cuda/gcc-11.2.0/")

-- generic packages / dependencies
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/gcc-11.2.0/")
