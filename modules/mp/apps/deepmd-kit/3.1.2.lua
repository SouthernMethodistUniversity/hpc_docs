whatis("DeePMD-kit 3.1.2")
family("lammps")

load("gcc/13.2.0")
load("spack")
load("cuda/none-none/cuda/12.8.0-5bb32rl")
load("gcc-13.2.0/python/3.12.12-ekwsqkf")
load("gcc-13.2.0/amdfftw/5.1-4hjwb43")
load("gcc-13.2.0/amdlibflame/5.1-zchmo5m")
load("gcc-13.2.0/amdblis/5.1-d4fjbvz")

prepend_path("PATH", "/hpc/mp/apps/deepmd-kit/3.1.2/bin")
prepend_path("LD_LIBRARY_PATH", "/hpc/mp/apps/deepmd-kit/3.1.2/lib")
prepend_path("C_INCLUDE_PATH", "/hpc/mp/apps/deepmd-kit/3.1.2/include")
prepend_path("C_PLUS_INCLUDE_PATH", "/hpc/mp/apps/deepmd-kit/3.1.2/include")

help([[Name: DeePMD-kit
Version: 3.1.2
Website: https://github.com/deepmodeling/deepmd-kit/
License Owners: Open Source

DeePMD-kit is a package written in Python/C++, designed to minimize the effort required to build deep learning-based model of interatomic potential energy and force field and to perform molecular dynamics (MD). ]])
