whatis("Provides access to GCC 11.2.0 compiler suite, libraries, and applications.")
family("compiler")

-- cuda
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-x86_64_v3/cuda/gcc-11.2.0/")

-- generic packages / dependencies
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-x86_64_v3/gcc-11.2.0/")
