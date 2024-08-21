whatis("ANSYS Electronics Package R24.2")
family("ansys")

help([[Name: Ansys Electronics Desktop (HFSS)
Version: 24R2
Website: https://www.ansys.com/
License Owners : SMU?

Ansys Electronics
Electromagnetic, Signal Integrity, Thermal and Electro-Mechanical Simulation Solutions
]])

local ansys_home="/hpc/m3/apps/ansys/24R2/AnsysEM/v242/Linux64/"

append_path("PATH",ansys_home)

setenv("ANSYS_HOME", ansys_home)
setenv("ANSYSEM_GENERIC_MPI_WRAPPER",pathJoin(ansys_home,"/schedulers/scripts/utils/slurm_srun_wrapper.sh"))
setenv("ANSYSEM_COMMON_PREFIX",pathJoin(ansys_home,"/common"))
setenv("srun_cmd","srun --overcommit --export=ALL  -n 1 -N 1 --cpu-bind=none --mem-per-cpu=0 --overlap ")

setenv("GALLIUM_DRIVER","softpipe")

