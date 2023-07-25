whatis("Synopsys Quantum ATK")
family("quantum_atk")

load("gcc/11.2.0")
load("openmpi/4.1.4-7al4h2x")


local synopsys_root = "/hpc/m3/apps/quantumatk/"
local version = "2022.12-SP1"
local root = pathJoin(synopsys_root, version)
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "lib")

setenv("SNPSLMD_LICENSE_FILE", "27020@sengr7lic2.smu.edu")

prepend_path("PATH", bin)
append_path("LD_LIBRARY_PATH", lib)
