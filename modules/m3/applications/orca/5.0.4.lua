whatis("ORCA Quantum Chemistry Package")

local root = "/hpc/m3/apps/orca/5.0.4"

load("gcc/11.2.0", "openmpi/4.1.4-7al4h2x")
prepend_path("PATH", root)
prepend_path("LD_LIBRARY_PATH", root)

