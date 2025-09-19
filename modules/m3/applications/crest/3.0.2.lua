whatis("Crest 3.0.2")
family("crest")
conflict("crest")

load("gcc/11.2.0", "intel-oneapi-mkl/2024.0.0-rlu67a5 ")

prepend_path("PATH","/hpc/m3/apps/crest/3.0.2/bin")
prepend_path("C_INCLUDE_PATH", "/hpc/m3/apps/crest/3.0.2/include")
prepend_path("CPLUS_INCLUDE_PATH", "/hpc/m3/apps/crest/3.0.2/include")
prepend_path("CPATH", "/hpc/m3/apps/crest/3.0.2/include")
prepend_path("LD_LIBRARY_PATH","/hpc/m3/apps/crest/3.0.2/lib")
prepend_path("LIBRARY_PATH","/hpc/m3/apps/crest/3.0.2/lib")

help([[Name: Crest 
Version: 3.0.2
Website: https://github.com/crest-lab/crest

CREST was developed as a utility and driver program for the semiempirical quantum chemistry package xtb.
]])


