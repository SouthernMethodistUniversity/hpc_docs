# OpenFoam (.com)

**OpenFoam** is an open source Computation Fluid Dynamics Package.

**OpenFoam homepage**: [openfoam.com/](https://www.openfoam.com/)

**Official OpenFoam Tutorials**: [openfoam.com/documentation/tutorial-guide](https://www.openfoam.com/documentation/tutorial-guide)


:::{seealso}
For examples and tips on submitting jobs, see [our SLURM documentation](tutorials:slurm) and [Best Practices for Jobs](tutorials:slurm:best_practices)

For compute resources, see [HPC Queues](about:queues)
:::


## Using OpenFoam on M3

Files used in the example are available:

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/main/docs/examples/openfoam)
  - on M3 at `/hpc/m3/examples/openfoam/` 

### Example submission script

The following job script can be submitted using `sbatch openfoam_example.sbatch`.

It requires a `decomposeParDict` to run, (see e.g. [running in paralell](https://doc.cfd.direct/openfoam/user-guide-v12/running-applications-parallel)). An example file is included in the files mentioned above

This example should run in approximately 10 seconds and use about 600 MB of memory when using 4 tasks. 
Therefore, we request 1 GB of memory and 3 minutes of run time to give
ourselves some room for error. 

Note, we know this from running the job. 
It is always a good idea to review the resources your jobs use
and adjust future jobs to more accurately request resources.

```{literalinclude} openfoam_cpu_example.sbatch
---
language: bash
linenos: true
---
```

