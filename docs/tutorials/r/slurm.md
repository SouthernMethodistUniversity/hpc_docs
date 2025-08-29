# Submitting R Jobs

There are 3 ways to run R code on the system. You can run interactive jobs through the
[HPC Portal](https://hpc.m3.smu.edu/) using RStudio Server, you can run R on a compute node
using the `srun` and `R`/`Rscript` commands, or you can run scripted `sbatch` jobs.

## HPC Portal (RStudio)

To launch RStudio from the [HPC Portal](https://hpc.m3.smu.edu/), navigate to **Interactive Apps** >
**RStudio Server**, select the appropriate slurm account, R version, and other job parameters. If you
are unsure what to select, the defaults are usually fine.

## Interactive (`srun`)

To run R on the command line interactively, you first need to start a regular job:

```bash
srun -p dev -A my_slurm_account_0001 --mem=4G -c 1 -t 30 --pty $SHELL
```

```{note}
You'll need to change the `my_slurm_account_0001` to one of the slurm accounts
you have access to through ColdFront. See [Slurm](/tutorials/slurm/slurm.md) for
more information on using `srun`.
```

Once you are on the allocated compute node, you can launch R:

`````{tab-set}
````{tab-item} Module

```bash
module purge
module load R/4.5.1
R
```

````
````{tab-item} Conda Environment

```bash
module purge
module load miniforge
mamba activate r_env
R
```

````
`````

You can also run an Rscript in the interactive session with:

`````{tab-set}
````{tab-item} Module

```bash
module purge
module load R/4.5.1
Rscript --vanilla myscript.R
```

````
````{tab-item} Conda Environment

```bash
module purge
module load miniforge
mamba activate r_env
Rscript --vanilla myscript.R
```

````
`````

## Scripted (`sbatch`)

The recommended way to run jobs on SMU HPC Systems is using an `sbatch` script
because it allows for better debugging and reproducibility. See 
[Slurm](/tutorials/slurm/slurm.md) for more information on using `sbatch`.

### Single Job

To run a single R script using `sbatch`, you need to create a file that looks similar to this,
with the slurm account and path to the R script you are running specified:

`````{tab-set}
````{tab-item} Module

```{code-block} bash
---
caption: run.sbatch
---
#!/bin/bash
#SBATCH -A my_slurm_account_001                  
#SBATCH -J get_data_links
#SBATCH -o %j.out
#SBATCH -e %j.err
#SBATCH -p dev
#SBATCH -t 0-00:30:00
#SBATCH --mem=4G
#SBATCH -c 1

module purge
module load R/4.5.1

Rscript --vanilla myscript.R
```

````
````{tab-item} Conda Environment

```{code-block} bash
---
caption: run.sbatch
---
#!/bin/bash
#SBATCH -A my_slurm_account_001                  
#SBATCH -J get_data_links
#SBATCH -o %j.out
#SBATCH -e %j.err
#SBATCH -p dev
#SBATCH -t 0-00:30:00
#SBATCH --mem=4G
#SBATCH -c 1

module purge
module load miniforge
module activate r_env

Rscript --vanilla myscript.R
```

````
`````

To submit the job:

```bash
sbatch run.sbatch
```

### Array Jobs

While there are multiple ways to run an R script multiple times with different parameters using `sbatch`, 
the simplest way is to create a file that looks similar to this,
with the slurm account, path to the R script, and array job parameters you are running specified:

`````{tab-set}
````{tab-item} Module

```{code-block} bash
---
caption: run.sbatch
---
#!/bin/bash
#SBATCH -A my_slurm_account_001                  
#SBATCH -J get_data_links
#SBATCH -o %j.out
#SBATCH -e %j.err
#SBATCH -p dev
#SBATCH -t 0-00:30:00
#SBATCH --mem=4G
#SBATCH -c 1
#SBATCH --array=0-5

module purge
module load R/4.5.1

Rscript --vanilla myscript.R $SLURM_ARRAY_TASK_ID
```

````
````{tab-item} Conda Environment

```{code-block} bash
---
caption: run.sbatch
---
#!/bin/bash
#SBATCH -A my_slurm_account_001                  
#SBATCH -J get_data_links
#SBATCH -o %j.out
#SBATCH -e %j.err
#SBATCH -p dev
#SBATCH -t 0-00:30:00
#SBATCH --mem=4G
#SBATCH -c 1
#SBATCH --array=0-4

module purge
module load miniforge
module activate r_env

Rscript --vanilla myscript.R $SLURM_ARRAY_TASK_ID
```

````
`````

Your R script will need to be modified to use `commandArgs()` function.
The following is an example of an R script that takes one argument:

```{code-block} r
---
caption: myscript.R
---
args <- commandArgs(trailingOnly = TRUE)
num1 <- as.numeric(args[1])
print(num1 * 5)
```

A more realistic scenario is that you need to do some amount of data processing
on a large data frame, which you can do by chunking rows. Take this `iris` data set,
for example:

```{code-block} r
---
caption: myscript.R
---
data("iris")

args <- commandArgs(trailingOnly = TRUE)

chunk_size = nrow(iris)/5
starting_index = chunk_size * as.numeric(args[1])
ending_index = starting_index + chunk_size

print(sum(iris$Sepal.Length[starting_index, ending_index]))
```

Each run in the array job will take the sum of `Sepal.Length` for 1/5 of the rows.
Notice that `chunk_size` is set by dividing by 5, which is the number of array jobs
that will run with a setting of `array=0-4`.