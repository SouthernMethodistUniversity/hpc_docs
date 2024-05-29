whatis("Provides access to GCC 13.2.0 compiler suite, libraries, and applications.")
family("compiler")

-- mpi
-- FIXME: system path?
append_path("MODULEPATH", "/hpc/mp/module_files/mpi/gcc-13.2.0/")

-- cuda
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/cuda/gcc-13.2.0/")

-- generic packages / dependencies
append_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2/gcc-13.2.0/")

-- from spack module
prepend_path("C_INCLUDE_PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/include")
prepend_path("CPLUS_INCLUDE_PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/include")
prepend_path("CPATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/include")
prepend_path("LD_LIBRARY_PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/lib")
prepend_path("LIBRARY_PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/lib")
prepend_path("LD_LIBRARY_PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/lib64")
prepend_path("LIBRARY_PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/lib64")
prepend_path("PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/bin")
prepend_path("MANPATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/share/man")
prepend_path("CMAKE_PREFIX_PATH","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/.")
setenv("CC","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/bin/gcc")
setenv("CXX","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/bin/g++")
setenv("FC","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/bin/gfortran")
setenv("F77","/hpc/mp/repos/spack/opt/spack/linux-ubuntu22.04-zen2/gcc-11.2.0/gcc-13.2.0-6sn65ps6yami7ktiqicswzuv5rpbbkec/bin/gfortran")

help([[Name   : gcc
Version: 13.2.0
Target : zen2
]])
