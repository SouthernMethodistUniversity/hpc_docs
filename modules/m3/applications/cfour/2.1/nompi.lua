whatis("CFOUR without MPI")

local mpi  = "nompi"
local base = "/hpc/m3/apps/cfour/2.1"
local root = pathJoin(base, mpi)
local bin  = pathJoin(root, "bin")

load("gcc/11.2.0", "openblas/0.3.21-iofurbe")
prepend_path("PATH", bin)

