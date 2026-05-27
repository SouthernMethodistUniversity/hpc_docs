whatis("Apptainer/Singularity v1.5.0")
family("apptainer")

always_load('gcc/11.2.0')
always_load('squashfuse/0.6.1-4jvoaa3')
always_load('gocryptfs/2.6.1-5sgord4')

local base_path='/hpc/m3/apps/Apptainer/1.5.0/'
prepend_path("PATH",pathJoin(base_path, '/bin'))
source_sh('bash', pathJoin(base_path, '/share/bash-completion/completions/apptainer'))
source_sh('bash', pathJoin(base_path, '/share/bash-completion/completions/singularity'))
setenv("APPTAINER_BIND","/tmp,/hpc,/lustre/work/client,/lustre/scratch/client,/work,/work/projects:/projects,/cm/local/apps/slurm")

help([[Name: Apptainer
Version: 1.5.0
Website: https://apptainer.org/

pptainer is an open source container platform designed to be simple, fast, and secure. Many container platforms are available, but Apptainer is designed for ease-of-use on shared systems and in high performance computing (HPC) environments.
]])