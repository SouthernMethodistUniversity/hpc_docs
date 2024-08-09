whatis("Gurobi 11.0.1")
family("gurobi")
conflict("gurobi")

append_path("PATH", "/hpc/m3/apps/gurobi/11.0.1/linux64/bin")
setenv("GUROBI_HOME", "/hpc/m3/apps/gurobi/11.0.1/linux64")
setenv("GRB_LICENSE_FILE", "/hpc/m3/apps/gurobi/11.0.1/linux64/client.lic")
append_path("LD_LIBRARY_PATH","/hpc/m3/apps/gurobi/11.0.1/linux64/lib")
append_path("CPATH", "/hpc/m3/apps/gurobi/11.0.1/linux64/include")
append_path("LIBRARY_PATH","/hpc/m3/apps/gurobi/11.0.1/linux64/lib")

help([[Name: Gurobi
Version: 11.0.1
Website: https://www.gurobi.com/
License Owners : free academic site license (Merlin)

Gurobi optimization software
]])