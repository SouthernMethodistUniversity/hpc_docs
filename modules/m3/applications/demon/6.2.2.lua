whatis("deMon 6.2.2")

family("demon")
conflict("demon")

load("gcc/11.2.0", "openblas/0.3.21-iofurbe", "openmpi/4.1.6-vfi4iwj")

local root = "/hpc/m3/apps/demon/6.2.2"
local base = pathJoin(root, "deMon")

setenv("CREX_ROOT", root)
prepend_path("MANPATH", pathJoin(base, "man"))
append_path("PATH", pathJoin(base, "bin"))

help([[Name: deMon
Version: 6.2.2
Website: http://www.demon-software.com/

A software package for density functional theory (DFT) calculations
]])
