whatis("Provides access to NVIDIA HPC-SDK 21.3 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/m3/apps/nvidia/hpc-sdk/21.3/modulefiles")
load("nvhpc/21.3")

help([[Name: NVIDIA HPC SDK
Version: 21.3
Website: https://developer.nvidia.com/hpc-sdk

The NVIDIA HPC Software Development Kit (SDK) includes the proven compilers, libraries and software tools essential to maximizing developer productivity and the performance and portability of HPC applications.
]])