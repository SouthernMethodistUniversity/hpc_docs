whatis("IMB ILOG CPLEX Optimization Studio 22.1.1")
family("cplex")
conflict("cplex")

setenv("CPLEX_HOME", "/hpc/m3/apps/cplex/CPLEX_Studio2211")

append_path("PATH", "/hpc/m3/apps/cplex/CPLEX_Studio2211/cplex/bin/x86-64_linux/")
append_path("PATH", "/hpc/m3/apps/cplex/CPLEX_Studio2211/cpoptimizer/bin/x86-64_linux")
append_path("PATH", "/hpc/m3/apps/cplex/CPLEX_Studio2211/opl/bin/x86-64_linux")

append_path("LD_LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cplex/lib/x86-64_linux/static_pic")
append_path("LD_LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cplex/bin/x86-64_linux")
append_path("LD_LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cpoptimizer/lib/x86-64_linux/static_pic")
append_path("LD_LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cpoptimizer/bin/x86-64_linux")
append_path("LD_LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/opl/lib/x86-64_linux/static_pic")
append_path("LD_LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/opl/bin/x86-64_linux")

append_path("LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cplex/lib/x86-64_linux/static_pic")
append_path("LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cplex/bin/x86-64_linux")
append_path("LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cpoptimizer/lib/x86-64_linux/static_pic")
append_path("LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/cpoptimizer/bin/x86-64_linux")
append_path("LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/opl/lib/x86-64_linux/static_pic")
append_path("LIBRARY_PATH","/hpc/m3/apps/cplex/CPLEX_Studio2211/opl/bin/x86-64_linux")

append_path("CPATH", "/hpc/m3/apps/cplex/CPLEX_Studio2211/cplex/include")
append_path("CPATH", "/hpc/m3/apps/cplex/CPLEX_Studio2211/cpoptimizer/include")
append_path("CPATH", "/hpc/m3/apps/cplex/CPLEX_Studio2211/opl/include")

help([[Name: IBM ILOG CPLEX Optimizer 
Version: 22.1.1
Website: https://www.ibm.com/products/ilog-cplex-optimization-studio/cplex-optimizer
License Owners: academic license

High-performance optimization solver for linear, mixed-integer and quadratic programming
]])