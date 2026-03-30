whatis("DeePMD-kit 3.1.2")
family("lammps")

load("miniforge/24.11.2-1")
execute{cmd="conda activate /hpc/mp/apps/deepmd-kit/2026-03-20/deepmd_env", modeA={"load"}}

help([[Name: DeePMD-kit
Version: 3.1.3
Website: https://github.com/deepmodeling/deepmd-kit/
License Owners: Open Source

DeePMD-kit is a package written in Python/C++, designed to minimize the effort required to build deep learning-based model of interatomic potential energy and force field and to perform molecular dynamics (MD). ]])
