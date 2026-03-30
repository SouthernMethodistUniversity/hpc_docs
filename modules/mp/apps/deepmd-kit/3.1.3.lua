whatis("DeePMD-kit 3.1.2")
family("lammps")

prepend_path("MODULEPATH", "/hpc/mp/spack_modules/linux-ubuntu22.04-zen2")

load("gcc/13.2.0")
load("cuda/12.8.0-6mc4fti")
load("nccl/2.22.3-1-lkmfvs4")
load("miniforge/24.11.2-1")


prepend_path("PATH", "/hpc/mp/apps/deepmd-kit/2026-03-20/deepmd_install/bin")
prepend_path("LD_LIBRARY_PATH", "/hpc/mp/apps/deepmd-kit/2026-03-20/deepmd_install/lib")
prepend_path("C_INCLUDE_PATH", "/hpc/mp/apps/deepmd-kit/2026-03-20/deepmd_install/include")
prepend_path("C_PLUS_INCLUDE_PATH", "/hpc/mp/apps/deepmd-kit/2026-03-20/deepmd_install/include")

execute{cmd="conda activate /hpc/mp/apps/deepmd-kit/2026-03-20/deepmd_env", modeA={"load"}}

help([[Name: DeePMD-kit
Version: 3.1.3
Website: https://github.com/deepmodeling/deepmd-kit/
License Owners: Open Source

DeePMD-kit is a package written in Python/C++, designed to minimize the effort required to build deep learning-based model of interatomic potential energy and force field and to perform molecular dynamics (MD). ]])
