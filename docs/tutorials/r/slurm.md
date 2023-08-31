# Submitting R Jobs

```{literalinclude} ../../examples/r/slurm/pi_monte_carlo_serial.R
---
language: r
linenos: true
caption: Serial $\pi$ Monte Carlo R Script.
---
```

```{literalinclude} ../../examples/r/slurm/pi_monte_carlo_parallel.R
---
language: r
linenos: true
caption: Parallel $\pi$ Monte Carlo R Script.
---
```

```{literalinclude} ../../examples/r/slurm/01_interactive_session
---
language: sh
linenos: true
caption: Interactive sessions using `srun`.
---
```

```{literalinclude} ../../examples/r/slurm/03_sbatch_wrap
---
language: sh
linenos: true
caption: Using `sbatch --wrap`.
---
```

```{literalinclude} ../../examples/r/slurm/04_sbatch_htc.sbatch
---
language: sh
linenos: true
caption: Serial job using using `sbatch`.
---
```

```{literalinclude} ../../examples/r/slurm/05_sbatch_standard-mem-s.sbatch
---
language: sh
linenos: true
caption: Parallel job using using `sbatch`.
---
```

```{literalinclude} ../../examples/r/slurm/06_sbatch_array.sbatch
---
language: sh
linenos: true
caption: Array job using using `sbatch`.
---
```

