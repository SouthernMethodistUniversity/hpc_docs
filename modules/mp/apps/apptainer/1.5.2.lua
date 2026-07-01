whatis("Apptainer/Singularity v1.5.2")
family("apptainer")

always_load('gcc/13.2.0')
always_load('squashfuse/0.6.1-rdj4gkz')
always_load('gocryptfs/2.6.1-d7lgudf')

local scratch = os.getenv("SCRATCH")
local user = os.getenv("USER")

local base_path='/hpc/mp/apps/Apptainer/1.5.2/'
prepend_path("PATH",pathJoin(base_path, '/bin'))
source_sh('bash', pathJoin(base_path, '/share/bash-completion/completions/apptainer'))
source_sh('bash', pathJoin(base_path, '/share/bash-completion/completions/singularity'))
setenv("APPTAINER_BIND","/hpc,/work/projects,/projects,/scratch/users/"..user..","..scratch)

help([[Name: Apptainer
Version: 1.5.2
Website: https://apptainer.org/

Apptainer is an open source container platform designed to be simple, fast, and secure. Many container platforms are available, but Apptainer is designed for ease-of-use on shared systems and in high performance computing (HPC) environments.
]])
