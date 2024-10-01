whatis("CFOUR with MPI")

local mpi  = "mpi"
local base = "/hpc/m3/apps/cfour/2.1"
local root = pathJoin(base, mpi)
local bin  = pathJoin(root, "bin")

load("gcc/11.2.0", "openmpi/4.1.6-vfi4iwj", "openblas/0.3.21-iofurbe")
prepend_path("PATH", bin)

help([[Name: CFOUR
Version: 2.1 (mpi)
Website: https://cfour.uni-mainz.de/cfour/

CFOUR (Coupled-Cluster techniques for Computational Chemistry) is a program package for performing high-level quantum chemical calculations on atoms and molecules. 
]])
