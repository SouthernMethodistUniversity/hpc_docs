whatis("Provides access to NVIDIA HPC-SDK 25.7 compiler suite, libraries, and applications.")
family("compiler")

append_path("MODULEPATH", "/hpc/mp/apps/nvidia/hpc-sdk/25.7/modulefiles")
load("nvhpc/25.7")

-- For OpenMPI
setenv("UCX_NET_DEVICES","mlx5_0:1,mlx5_1:1,mlx5_2:1,mlx5_3:1,mlx5_6:1,mlx5_7:1,mlx5_8:1,mlx5_9:1")


help([[Name: NVIDIA HPC SDK
Version: 25.7
Website: https://developer.nvidia.com/hpc-sdk

The NVIDIA HPC Software Development Kit (SDK) includes the proven compilers, libraries and software tools essential to maximizing developer productivity and the performance and portability of HPC applications.
]])