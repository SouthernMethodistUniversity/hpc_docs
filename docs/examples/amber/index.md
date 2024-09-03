# Amber

**Amber** is a suite of biomolecular simulation programs.

**Amber homepage**: [ambermd.org/](https://ambermd.org/)

**Official Amber Tutorials**: [ambermd.org/tutorials/](https://ambermd.org/tutorials/)

:::{seealso}
For examples and tips on submitting jobs, see [our SLURM documentation](tutorials:slurm) and [Best Practices for Jobs](tutorials:slurm:best_practices)

For compute resources, see [HPC Queues](about:queues)
:::

## Using Amber on the SuperPod

Files used in the example are available: 

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/main/docs/examples/amber)
  - on the SuperPod at `/hpc/mp/examples/amber/`

### Example submission script

The following job script can be submitted using `sbatch amber_gpu_example.sbatch`.

```{literalinclude} amber_gpu_example.sbatch
---
language: bash
linenos: true
---
```

## Using Amber on M3

Files used in the example are available:

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/main/docs/examples/amber)
  - on M3 at `/hpc/m3/examples/amber/` 

### Example submission script

The following job script can be submitted using `sbatch amber_cpu_example.sbatch`.

This example should run in approximately 90 seconds and use about 600 MB of memory when using 4 cores. Therefore, we request 1 GB of memory and 3 minutes of run time to give
ourselves some room for error. 

Note, we know this from running the job. 
It is always a good idea to review the resources your jobs use
and adjust future jobs to more accurately request resources.

```{literalinclude} amber_cpu_example.sbatch                 
---
language: bash
linenos: true
---
```

