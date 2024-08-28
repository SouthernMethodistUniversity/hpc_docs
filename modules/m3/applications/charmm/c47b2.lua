whatis("CHARMM")

load("gcc/11.2.0", "openmpi/4.1.4-7al4h2x", "fftw/3.3.10-gz7qiki")
prepend_path("PATH", "/hpc/m3/apps/charmm/c47b2/bin")

help([[Name: CHARMM
Version: c47b2
Website: https://www.academiccharmm.org/

Chemistry at HARvard Macromolecular Mechanics
A molecular simulation program with broad application to many-particle systems with a comprehensive set of energy functions, a variety of enhanced sampling methods, and support for multi-scale techniques including QM/MM, MM/CG, and a range of implicit solvent models. 
]])