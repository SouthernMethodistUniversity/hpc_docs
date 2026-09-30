whatis("Q-Chem")
family("qchem")

local scratch = os.getenv("SCRATCH")
setenv("QCSCRATCH", scratch)

source_sh('bash', '/hpc/m3/apps/q-chem/6.4.0/qcenv.sh')

help([[Name: Q-Chem
Version: 6.4.0
Website: https://www.q-chem.com/
License Owners: Devin Matthews

Q-Chem is an ab initio quantum chemistry software package for fast and accurate simulations of molecular systems, including electronic and molecular structure, reactivities, properties, and spectra.
]])