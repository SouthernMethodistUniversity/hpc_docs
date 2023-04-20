whatis("Provides access to Intel 2023.1 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/m3/apps/intel/oneapi/2023.1/modulefiles")
load("compiler/latest")

