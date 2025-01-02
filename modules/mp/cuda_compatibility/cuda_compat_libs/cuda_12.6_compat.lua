append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.6/libcuda.so.560.35.03")
append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.6/libcudadebugger.so.560.35.03")
append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.6/libnvidia-nvvm.so.560.35.03")
append_path("LD_PRELOAD", "/hpc/mp/apps/nvidia/compatibility_drivers/12.6/libnvidia-ptxjitcompiler.so.560.35.03")

help([[Name: Cuda Compatibility Libraries
Version: 12.6
Website: https://docs.nvidia.com/deploy/cuda-compatibility/

Compatibility libraries to allow newer new versions of Cuda to run
]])