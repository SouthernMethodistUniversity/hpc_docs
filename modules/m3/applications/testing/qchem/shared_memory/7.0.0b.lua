whatis("Q-Chem")
family("qchem")

local scratch_dir = os.getenv("SCRATCH")
setenv("QCSCRATCH", scratch_dir)
source_sh('bash', '/hpc/m3/apps/q-chem/7.0.0b/shared_memory/qcenv.sh')

help([[Name: Q-Chem
Version: 7.0.0b
Website: https://www.q-chem.com/

Q-Chem is an ab initio quantum chemistry software package for fast and accurate simulations of molecular systems, including electronic and molecular structure, reactivities, properties, and spectra.
]])