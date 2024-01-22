# Amber

:::{seealso}
For examples and tips on submitting jobs, see [our SLURM documentation](../../slurm/slurm.md) and [Best Practices for Jobs](../../slurm/best_practices.md)

For compute resources, see [HPC Queues](../../about/queeues.md)
:::

**Amber** is a suite of biomolecular simulation programs.

**Amber homepage**: [ambermd.org/](https://ambermd.org/)

**Official Amber Tutorials**: [ambermd.org/tutorials/](https://ambermd.org/tutorials/)

## Using Amber on the SuperPod

Files used in the example are available: 

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/update_examples/docs/examples/amber)
  - on the SuperPod at `/hpc/mp/examples/amber/`

### Example submission script

```{literalinclude} amber_gpu_example.sbatch
---
language: bash
linenos: true
---
```

## Using Amber on M3

Files used in the example are available:

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/update_examples/docs/examples/amber)
  - on M3 at `/hpc/m3/examples/amber/` 

### Example submission script

```{literalinclude} amber_cpu_example.sbatch                 
---
language: bash
linenos: true
---
```

