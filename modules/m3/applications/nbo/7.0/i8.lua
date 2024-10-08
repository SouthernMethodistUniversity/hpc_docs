whatis("TCI/NBO Software 7.0")

local int  = "i8"
local base = "/hpc/m3/apps/nbo/7.0"
local root = pathJoin(base, int)
local bin  = pathJoin(root, "bin")

prepend_path("PATH", bin)
prepend_path("PATH", root)

setenv("GENEXE", pathJoin(bin, "gennbo." .. int .. ".exe"))
setenv("NBOEXE", pathJoin(bin, "nbo7." .. int .. ".exe"))
setenv("INT", int)
setenv("NBOBIN", bin)

help([[Name: TCI/NBO Software (i8)
Version: 7.0
Website: https://charge.wisc.edu/chemistry/order_nbo7.aspx

Natural Bond Orbitals from Theoretical Chemistry Institute -- University of Wisconsin
]])