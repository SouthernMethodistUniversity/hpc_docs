whatis("Apptainer/Singularity v1.1.6")
family("apptainer")
prepend_path("PATH","/hpc/sys/apps/apptainer/current/bin")
source_sh('bash', '/hpc/sys/apps/apptainer/current/share/bash-completion/completions/apptainer')
source_sh('bash', '/hpc/sys/apps/apptainer/current/share/bash-completion/completions/singularity')
setenv("APPTAINER_BIND","/tmp,/hpc,/lustre/work/client,/lustre/scratch/client,/work,/projects,/cm/local/apps/slurm,/var/lib/sss,/etc/passwd")

help([[Name: Apptainer
Version: 1.1.6
Website: https://apptainer.org/

pptainer is an open source container platform designed to be simple, fast, and secure. Many container platforms are available, but Apptainer is designed for ease-of-use on shared systems and in high performance computing (HPC) environments.
]])