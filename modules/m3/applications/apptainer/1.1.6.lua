whatis("Apptainer/Singularity v1.1.6")
family("apptainer")
prepend_path("PATH","/hpc/sys/apps/apptainer/current/bin")
source_sh('bash', '/hpc/sys/apps/apptainer/current/share/bash-completion/completions/apptainer')
source_sh('bash', '/hpc/sys/apps/apptainer/current/share/bash-completion/completions/singularity')
setenv("APPTAINER_BIND","/tmp,/hpc,/lustre/work/client,/lustre/scratch/client,/work,/cm/local/apps/slurm,/var/lib/sss,/etc/passwd")
