whatis("Amber 22 + AmberTools 23")
family("amber")

load("gcc/11.2.0 ")
load("hpc-x/2.14")
load("amdfftw/4.0-owzmbpz")
load("amdlibflame/4.0-2jttyay")
load("amdblis/4.0-ljcsqu7")
load("amdlibm/4.0-vp74zry")
load("nccl/2.16.2-1-wwfv3z3")

-- This is producing an error, so the below should
-- be the same settings
-- source_sh("/hpc/mp/apps/amber/AmberTools23/amber.sh")
setenv("AMBERHOME", "/hpc/mp/apps/amber/AmberTools23")
prepend_path("PATH", "/hpc/mp/apps/amber/AmberTools23/bin")
prepend_path("LD_LIBRARY_PATH", "/hpc/mp/apps/amber/AmberTools23/lib")
prepend_path("PERL5LIB", "/hpc/mp/apps/amber/AmberTools23/lib/perl")
prepend_path("PYTHONPATH", "/hpc/mp/apps/amber/AmberTools23/lib/python3.10/site-packages")
setenv("QUICK_BASIS","/hpc/mp/apps/amber/AmberTools23/AmberTools/src/quick/basis")

help([[Name: Amber
Version: 22
Website: https://ambermd.org/

Amber is a suite of biomolecular simulation programs.
]])