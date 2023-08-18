whatis("Provides access to Intel 2023.2 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/mp/apps/intel/oneapi/2023.2/modulefiles")
load("compiler/latest")

-- mpi
append_path("MODULEPATH", "/hpc/mp/module_files/mpi/oneapi-2023.2.0/")

-- cuda
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/cuda/oneapi-2023.2.0/")

-- generic packages / dependencies
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/oneapi-2023.2.0/")

