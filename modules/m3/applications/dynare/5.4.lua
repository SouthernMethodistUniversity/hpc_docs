whatis("Dynare 5.4")
family("dynare")

load("gcc/11.2.0")
load("matlab/r2023a")
load("matio/1.5.17-4c7lfdp")
load("openblas/0.3.21-s5husbk")
load("boost/1.82.0-5wb3ikw")
load("gsl/2.7.1-oyt4rtp")
load("x13as/1.1.b60")

append_path("LD_LIBRARY_PATH", "/hpc/m3/apps/slicot/5.0/lib")
append_path("LIBRARY_PATH", "/hpc/m3/apps/slicot/5.0/lib")

prepend_path("LD_PRELOAD", "/usr/lib/x86_64-linux-gnu/libstdc++.so.6")

append_path("PATH", "/hpc/m3/apps/dynare/5.4/bin")
append_path("LIBRARY_PATH","/hpc/m3/apps/dynare/5.4/lib")
append_path("MATLABPATH","/hpc/m3/apps/dynare/5.4/lib/dynare/matlab/")
