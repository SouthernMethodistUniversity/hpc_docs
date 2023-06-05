whatis("Provides access to NVIDIA HPC-SDK 23.5 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/m3/apps/nvidia/hpc-sdk/23.5/modulefiles")
load("nvhpc/23.5")

