whatis("loads AOCC compiler setup")
family("compiler")

-- mpi
append_path("MODULEPATH", "/hpc/mp/module_files/mpi/aocc-4.1.0/")

-- cuda
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/cuda/aocc-4.1.0/")

-- generic packages / dependencies
append_path("MODULEPATH","/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/aocc-4.1.0")

prepend_path("LIBRARY_PATH","/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib32")
prepend_path("LD_LIBRARY_PATH","/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib32")
prepend_path("PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/share/opt-viewer")
prepend_path("PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/bin")
prepend_path("LIBRARY_PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/lib")
prepend_path("LIBRARY_PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/lib32")
prepend_path("LD_LIBRARY_PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/ompd")
prepend_path("LD_LIBRARY_PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/lib")
prepend_path("LD_LIBRARY_PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/lib32")
prepend_path("C_INCLUDE_PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/include")
prepend_path("CPLUS_INCLUDE_PATH","/hpc/mp/apps/amd/aocc-compiler-4.1.0/include")
help([[ AOCC 

        loads AOCC compiler setup 

]])

