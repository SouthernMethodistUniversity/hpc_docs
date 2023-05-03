whatis("CFOUR with MPI")

local mpi  = "mpi"
local base = "/hpc/m3/apps/cfour/2.1"
local root = pathJoin(base, mpi)
local bin  = pathJoin(root, "bin")

load("gcc/11.2.0", "openmpi/4.1.4-7al4h2x", "openblas/0.3.21-iofurbe")
prepend_path("PATH", bin)

