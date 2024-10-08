whatis("Provides access to Intel 2023.2 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/m3/apps/intel/2023.2/modulefiles")
load("compiler/latest")

-- mpi
append_path("MODULEPATH", "/hpc/m3/hpc_docs/modules/m3/mpi/oneapi-2023.2.0/")

-- cuda
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-x86_64_v3/cuda/oneapi-2023.2.0/")

-- generic packages / dependencies
append_path("MODULEPATH", "/hpc/m3/modules/spack/linux-ubuntu22.04-x86_64_v3/oneapi-2023.2.0/")

help([[Name: Intel OneAPI Compiler Suite
Version: 2023.2
Website: https://www.intel.com/content/www/us/en/developer/tools/oneapi/overview.html

The Intel® oneAPI DPC++/C++ Compiler gives developers even more confidence that their code is portable and reliably performant across existing and future CPU, GPU, and AI accelerator architectures.
]])