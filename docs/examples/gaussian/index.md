# Gaussian

:::{important}
Access to Gaussian requires permission. Please open a help ticket by emailing
[help@smu.edu with
"[HPC]"](mailto:help@smu.edu?subject=[HPC]%20Gaussian%20Access%20Request)
in the subject line.
:::

**Gaussian** Gaussian series of electronic structure programs, used by chemists, chemical engineers, biochemists, physicists and other scientists worldwide.

**Gaussian homepage**: [gaussian.com/](https://gaussian.com/)

**Official Gaussian Manual**: [gaussian.com/man/](https://gaussian.com/man/)

:::{seealso}
For examples and tips on submitting jobs, see [our SLURM documentation](tutorials:slurm) and [Best Practices for Jobs](tutorials:slurm:best_practices)

For compute resources, see [HPC Queues](about:queues)
:::

<!-- ## Using Gaussian on the SuperPod

Files used in the example are available:

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/main/docs/examples/gaussian)
  - on the SuperPod at `/hpc/mp/examples/gaussian/`

### Example submission script

The following job script can be submitted using `sbatch gaussian_gpu_example.sbatch`.

```{literalinclude} gaussian_gpu_example.sbatch
---
language: bash
linenos: true
---
``` -->

## Using Gaussian on M3

Files used in the example are available:

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/main/docs/examples/gaussian)
  - on M3 at `/hpc/m3/examples/gaussian/` 

### Example submission script

The following job script can be submitted using `sbatch guassian_cpu_example.sbatch`.

This example will run in about 10 seconds and use less that `1GB` of memory.
In general, more complicated simulations will take much longer and benefit from
using more cores and memory. Note, we know this from running the job.
It is always a good idea to review the resources your jobs use
and adjust future jobs to more accurately request resources.

This uses the `dev`
queue which has a 2 hour time limit.
In general, the `dev` queue should only be used for testing code and running interactive
sessions.
Most normal jobs should be submitted to the standard queues such as `standard-s` where
longer runtimes are allowed.

This example also writes output to `$SCRATCH`. 
`$SCRATCH` is a high performance file system designed to be used for temporary
job files and data.
After a job has finished running, any data you need to keep should be moved to
a project directory or your $HOME directory.
**Files in `SCRATCH` are subject to a 60 day purge policy where files older than 60 days
may be automatically deleted without warning.**

:::{note}
This job script will not run without modification. In particular, you must change
the account from `peruna_project_0001` to the account name for an allocation you
have access to.
:::

```{literalinclude} gaussian_cpu_example.sbatch                 
---
language: bash
linenos: true
---
```

