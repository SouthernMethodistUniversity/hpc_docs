whatis("Q-Chem")
family("qchem")

always_load('gcc/15.2.0', 'hpc-x/2.26.0')

local scratch_dir = os.getenv("SCRATCH")
setenv("QCSCRATCH", scratch_dir)
setenv("QCMPIRUN", "/hpc/sys/apps/slurm/current/bin/srun")
source_sh('bash', '/hpc/m3/apps/q-chem/7.0.0b/cluster/qcenv.sh')
source_sh('bash', '/hpc/m3/apps/q-chem/7.0.0b/cluster/qcpbc.sh')

help([[Name: Q-Chem
Version: 7.0.0b
Website: https://www.q-chem.com/

Q-Chem is an ab initio quantum chemistry software package for fast and accurate simulations of molecular systems, including electronic and molecular structure, reactivities, properties, and spectra.
]])