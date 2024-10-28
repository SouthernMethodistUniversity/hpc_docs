whatis("Synopsys Quantum ATK")
family("quantum_atk")

load("gcc/11.2.0")
load("openmpi/4.1.6-vfi4iwj")

local synopsys_root = "/hpc/m3/apps/quantumatk/"
local version = "2022.03-SP1"
local root = pathJoin(synopsys_root, version)
local bin = pathJoin(root, "bin")
local lib = pathJoin(root, "lib")

setenv("SNPSLMD_LICENSE_FILE", "27020@sengr7lic3.smu.edu")

prepend_path("PATH", bin)
append_path("LD_LIBRARY_PATH", lib)

help([[Name: Synopsys Quantum ATK
Version: 2022.03-SP1
Website: https://www.synopsys.com/manufacturing/quantumatk.html

QuantumATK - Atomistic Simulation Software
]])
