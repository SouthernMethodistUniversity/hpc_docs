whatis("Amber")
family("amber")

load("gcc/11.2.0")
load("amdfftw/4.0-qlq2dtb")
load("amdlibflame/4.0-h2zdhk7")
load("amdlibm/4.0-x57n3xb")
load("amdscalapack/4.0-wlfrdvu")
load("openblas/0.3.21-iofurbe")
load("bzip2/1.0.8-ujseine")
load("boost/1.83.0-yjgtpo4")
load("zlib/1.2.13-u7kx7ln")
load("arpack-ng/3.9.0-zcee5ar")
load("openmpi/4.1.6-a4ksrza")

--source_sh('bash', "/hpc/m3/apps/amber/amber24_mpi/amber.sh")
setenv("AMBERHOME","/hpc/m3/apps/amber/amber24_mpi")
prepend_path("LD_LIBRARY_PATH","/hpc/m3/apps/amber/amber24_mpi/lib")
prepend_path("PATH","/hpc/m3/apps/amber/amber24_mpi/bin")
prepend_path("PERL5LIB","/hpc/m3/apps/amber/amber24_mpi/lib/perl")
prepend_path("PYTHONPATH","/hpc/m3/apps/amber/amber24_mpi/lib/python3.11/site-packages")
setenv("QUICK_BASIS","/hpc/m3/apps/amber/amber24_mpi/AmberTools/src/quick/basis")

help([[Name: Amber
Version: 24
Website: https://ambermd.org/

Amber is a suite of biomolecular simulation programs.
]])

--[[
module load gcc/11.2.0
module load amdfftw/4.0-qlq2dtb amdblis/4.0-5m6qxzr  amdlibflame/4.0-h2zdhk7 amdlibm/4.0-x57n3xb  amdscalapack/4.0-wlfrdvu 
module load openblas/0.3.21-iofurbe 
module load cmake/3.27.7-dtby3uj 
module load bzip2/1.0.8-ujseine
module load boost/1.83.0-yjgtpo4
module load zlib/1.2.13-u7kx7ln
module load arpack-ng/3.9.0-zcee5ar
module load openmpi/4.1.6-a4ksrza 

mkdir mpi_build
cd mpi_build
cmake .. -DCMAKE_INSTALL_PREFIX=/hpc/m3/apps/amber/amber24_mpi \
  -DCOMPILER=GNU \
  -DMPI=TRUE \
  -DCUDA=FALSE \
  -DINSTALL_TESTS=TRUE \
  -DOPENMP=TRUE \
  -DTRUST_SYSTEM_LIBS=TRUE \
  -DDOWNLOAD_MINICONDA=TRUE
--]]
