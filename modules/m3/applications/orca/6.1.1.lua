whatis("ORCA Quantum Chemistry Package")

local root = "/hpc/m3/apps/orca/6.1.1"

load("gcc/13.4.0", "hpc-x/2.21.1", "libxml2/2.15.1-e2e5pnu")
prepend_path("PATH", root)
prepend_path("LD_LIBRARY_PATH", root)
prepend_path("LIBRARY_PATH", root)
prepend_path("LD_LIBRARY_PATH", pathJoin(root, 'lib'))
prepend_path("LIBRARY_PATH", pathJoin(root, 'lib'))

help([[Name: ORCA Quantum Chemistry Package
Version: 6.1.1
Website: https://www.faccts.de/orca/

RCA is a powerful and versatile quantum chemistry software package, primarily developed by the group of Prof. Frank Neese.
]])