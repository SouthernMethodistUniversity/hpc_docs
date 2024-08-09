whatis("loads Julia 1.9.1 environment")
family("julia")
conflict("julia")
local root = "/hpc/m3/apps/julia/1.9.1"
prepend_path("PATH", pathJoin(root, "bin"))
prepend_path("MANPATH", pathJoin(root, "share/man"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))

help([[Name: Julia
Version: 1.9.1
Website: https://julialang.org/

The Julia Programming Language
]])