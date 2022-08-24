whatis("Apptainer/Singularity")
family("singularity")
prepend_path("PATH","/hpc/mp/apps/apptainer/1.0.2/bin")
source_sh('bash', '/hpc/mp/apps/apptainer/1.0.2/share/bash-completion/completions/singularity')
source_sh('bash', '/hpc/mp/apps/apptainer/1.0.2/share/bash-completion/completions/apptainer')
setenv("SINGULARITY_BIND","/hpc,/work,/scratch")

