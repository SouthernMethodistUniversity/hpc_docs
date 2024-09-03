# Stata

**Stata** is a general purpose statistical software suite.

**Stata homepage**: [stata.com/](https://www.stata.com/)

**Official Stata Documentation**: [stata.com/features/documentation/](https://www.stata.com/features/documentation/)

:::{seealso}
For examples and tips on submitting jobs, see [our SLURM documentation](tutorials:slurm) and [Best Practices for Jobs](tutorials:slurm:best_practices)

For compute resources, see [HPC Queues](about:queues)
:::


## Using Stata on M3

Files used in the example are available:

  - [on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/update_examples/docs/examples/stata)
  - on M3 at `/hpc/m3/examples/stata/` 

### Example submission script

The following job script can be submitted using `sbatch stata_example.sbatch` from the command line.

This example should run in a few seconds and use very little memory. Therefore, we request 4 GB of memory and 5 minutes of run time to give ourselves some room for error.

Note, we know this from running the job.
It is always a good idea to review the resources your jobs use
and adjust future jobs to more accurately request resources.

```{literalinclude} stata_example.sbatch
---
language: bash
linenos: true
---
```

The above job script runs the Stata script `example.do` ([on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/update_examples/docs/examples/stata/example.do))

```{literalinclude} example.do
---
language: stata
linenos: true
---
```

### Example submission script for array jobs

It is also possible to submit array jobs.
This is a way to submit multiple parameters and/or Stata scripts using a single job submission.

The following job script can be submitted using `sbatch stata_array_example.sbatch` from the command line.

```{literalinclude} stata_array_example.sbatch
---
language: bash
linenos: true
---
```

The above job script runs the Stata scripts `array_example_1.do` ([on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/update_examples/docs/examples/stata/array_example_1.do))
and `array_example_2.do` ([on github](https://github.com/SouthernMethodistUniversity/hpc_docs/tree/update_examples/docs/examples/stata/array_example_2.do).)
Note, these scripts are identical for demonstration purposes.
