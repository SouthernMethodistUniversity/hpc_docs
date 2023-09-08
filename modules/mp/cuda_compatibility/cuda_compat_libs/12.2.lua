whatis("Provides Nvidia Cuda Compatibility Libraries to allow running Cuda 12.2")
family("cudacompat")

prepend_path("LD_LIBRARY_PATH","/hpc/mp/apps/nvidia/compatibility_drivers/12.2")
prepend_path("LD_PRELOAD","/hpc/mp/apps/nvidia/compatibility_drivers/12.2/libcudadebugger.so.535.104.05")
prepend_path("LD_PRELOAD","/hpc/mp/apps/nvidia/compatibility_drivers/12.2/libcuda.so.535.104.05")
prepend_path("LD_PRELOAD","/hpc/mp/apps/nvidia/compatibility_drivers/12.2/libnvidia-nvvm.so.535.104.05")
prepend_path("LD_PRELOAD","/hpc/mp/apps/nvidia/compatibility_drivers/12.2/libnvidia-ptxjitcompiler.so.535.104.05")

