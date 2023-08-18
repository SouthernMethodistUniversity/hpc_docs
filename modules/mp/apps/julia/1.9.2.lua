whatis("loads Julia 1.9.2 environment")
family("julia")
conflict("julia")
local root = "/hpc/mp/apps/julia/1.9.2"
prepend_path("PATH", pathJoin(root, "bin"))
prepend_path("MANPATH", pathJoin(root, "share/man"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
