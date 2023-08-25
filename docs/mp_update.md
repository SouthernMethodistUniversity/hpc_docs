# SuperPod System Update

## What is changing

### Operating system upgrade

The operating system on the SuperPod is being upgraded to Ubuntu 22.04 from Ubuntu 20.04.

### Updated Nvidia drivers

The Nvidia drivers are being updated to a version that supports Cuda 12.0. These drivers will support Cuda 12.x will be available using compatibility libraies.

### Updated SLURM Scheduler

SLURM is being updated to improve "fairness" in the job queue. Priority in the queue will depend on several factors, including how many jobs an user has run recently and how long a job has been in the queue.

## Impacts

### Compiled programs

Although they may work, we **strongly recommend** recompiling programs if possible.

### Conda

We expect most `Conda` environments to continue to function. In some cases, rebuilding environments may imporve performance.

### Pip

Some packages installed with `pip` may need to be reinstalled, especially packages that were compiled.

### Modules

Although we have reinstalled most of the packages, most module names have been changed. Scripts loading modules may need to be updated.

## Temporary Workarounds

In order to minimize impacts on existing workflows, we have created a containerized version of Ubuntu 20.04 closely resembling the original SuperPod install. To use this in your job scripts, you can add the following:

```
#SBATCH --container-image /hpc/m3/containers/mp_base.sqsh
#SBATCH --container-mounts "/hpc/mp,/cm/shared/apps/slurm/var/munge,/cm/shared/apps/slurm/var/etc/slurm/,/lib/security,/var/run/munge,/run/munge,/var/lib/sss,/etc/munge,/work/users/USERNAME,/lustre/smuexa01/client/users/USERNAME,/users/USERNAME"
#SBATCH --container-workdir "/path/to/workdir" 
```

Change `USERNAME` in the above to your username and `/path/to/workdir` to the location you expect commands to be run from. Without `--container-workdir` you will enter the container at `/`.

NOTE: `srun` calls from inside a job script will inherit the `--container-workdir`, so if you `cd` inside your job script before calling srun it may not work as expected.

NOTE: Containers cannot be nested. Existing workflows using a container should continue to work without modification.

:::{Recommendation}
This container is provided to allow existing workflows to continue with minimal impact, but we strongly encourage updating workflows to use updated installs.
:::

## Help

If you need help adjusting your workflows, need additional software installed, or encounter issues, please let us know at [SMU HPC
Support](mailto:help@smu.edu?subject=HPC).