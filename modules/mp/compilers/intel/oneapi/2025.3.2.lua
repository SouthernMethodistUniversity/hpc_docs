whatis("Provides access to Intel 2025.3 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/mp/apps/intel/oneapi/2025.3.1.55/module_files")
load("tbb", "compiler-rt", "umf", "compiler/latest")

-- mpi
append_path("MODULEPATH", "/hpc/mp/module_files/mpi/oneapi-2025.3.2/")

-- cuda
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/cuda/oneapi-2025.3.2/")

-- generic packages / dependencies
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/oneapi-2025.3.2/")

help([[Name: Intel OneAPI Compiler Suite
Version: 2025.3.2
Website: https://www.intel.com/content/www/us/en/developer/tools/oneapi/overview.html

The Intel® oneAPI DPC++/C++ Compiler gives developers even more confidence that their code is portable and reliably performant across existing and future CPU, GPU, and AI accelerator architectures.
]])