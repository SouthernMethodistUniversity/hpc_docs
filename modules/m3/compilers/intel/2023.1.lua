whatis("Provides access to Intel 2023.1 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/m3/apps/intel/oneapi/2023.1/modulefiles")
load("compiler/latest")

help([[Name: Intel OneAPI Compiler Suite
Version: 2023.1
Website: https://www.intel.com/content/www/us/en/developer/tools/oneapi/overview.html

The Intel® oneAPI DPC++/C++ Compiler gives developers even more confidence that their code is portable and reliably performant across existing and future CPU, GPU, and AI accelerator architectures.
]])