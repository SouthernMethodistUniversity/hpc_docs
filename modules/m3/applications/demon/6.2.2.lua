whatis("deMon 6.2.2")

family("demon")
conflict("demon")

load("gcc/11.2.0", "openblas/0.3.21-iofurbe", "openmpi/4.1.4-7al4h2x")

local root = "/hpc/m3/apps/demon/6.2.2"
local base = pathJoin(root, "deMon")

setenv("CREX_ROOT", root)
prepend_path("MANPATH", pathJoin(base, "man"))
append_path("PATH", pathJoin(base, "bin"))

