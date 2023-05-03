whatis("GAMESS ab initio Quantum Chemistry Package")

local gmspath = "/hpc/m3/apps/gamess/2022.2"

load("gcc/11.2.0", "openmpi/4.1.4-7al4h2x", "openblas/0.3.21-fh35exj")

prepend_path("PATH", gmspath)
setenv("GMSPATH", gmspath)

