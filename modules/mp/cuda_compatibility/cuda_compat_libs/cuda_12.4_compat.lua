append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.4/libcuda.so.550.54.15")
append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.4/libcudadebugger.so.550.54.15")
append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.4/libnvidia-nvvm.so.550.54.15")
append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.4/libnvidia-ptxjitcompiler.so.550.54.15")

help([[Name: Cuda Compatibility Libraries
Version: 12.4
Website: https://docs.nvidia.com/deploy/cuda-compatibility/

Compatibility libraries to allow newer new versions of Cuda to run
]])