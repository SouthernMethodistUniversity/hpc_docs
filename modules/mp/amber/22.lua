whatis("Amber")
family("amber")

load("dev")
load("hpcx")
load("cuda-11.7.0-gcc-10.3.0-vbhdtgc")
load("fftw-3.3.10-gcc-10.3.0-ste4ien")
load("openblas-0.3.20-gcc-10.3.0-nqwcc2e")
load("nccl-2.11.4-1-gcc-10.3.0-rvdzi4n")

-- This is producing an error, so the below should
-- be the same settings
-- source_sh("/hpc/mp/apps/amber/amber22/amber.sh")
setenv("AMBERHOME", "/hpc/mp/apps/amber/amber22")
prepend_path("PATH", "/hpc/mp/apps/amber/amber22/bin")
prepend_path("LD_LIBRARY_PATH", "/hpc/mp/apps/amber/amber22/lib")
prepend_path("PERL5LIB", "/hpc/mp/apps/amber/amber22/lib/perl")
prepend_path("PYTHONPATH", "/hpc/mp/apps/amber/amber22/lib/python3.10/site-packages")
setenv("QUICK_BASIS","/hpc/mp/apps/amber/amber22/AmberTools/src/quick/basis")
