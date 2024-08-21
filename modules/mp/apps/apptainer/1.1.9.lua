whatis("Apptainer/Singularity")
family("apptainer")
prepend_path("PATH","/hpc/mp/apps/apptainer/1.1.9/bin")
source_sh('bash', '/hpc/mp/apps/apptainer/1.1.9/share/bash-completion/completions/singularity')
source_sh('bash', '/hpc/mp/apps/apptainer/1.1.9/share/bash-completion/completions/apptainer')
setenv("APPTAINER_BIND","/hpc,/work,/scratch")

help([[Name: Apptainer
Version: 1.1.9
Website: https://apptainer.org/

Apptainer is an open source container platform designed to be simple, fast, and secure. Many container platforms are available, but Apptainer is designed for ease-of-use on shared systems and in high performance computing (HPC) environments.
]])