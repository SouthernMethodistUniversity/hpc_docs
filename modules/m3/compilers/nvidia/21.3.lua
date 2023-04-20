whatis("Provides access to NVIDIA HPC-SDK 23.1 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/m3/apps/nvidia/hpc-sdk/21.3/modulefiles")
load("nvhpc/21.3")

