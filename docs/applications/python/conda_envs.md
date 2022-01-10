# Conda Environments for Python

One method of installing Python packages is to use [Conda Environments](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).

>[!WARNING]
>If you need ```mpi4py```, you should avoid using _Conda_ environments if possible to avoid potentially significant performance issues. See the [instructions for mpi4py](applications/python/python_venvs) for more information.

## Creating a virtual environment

The general workflow is to do the following:

1. Load a version of _Conda_
2. Create the virtual environment

### Loading a version of _Conda_

There are two main sources of _Conda_. One is in the _Pyhton_ module and the other is in the _Intel_ compiler suite

You can load these with:

```bash
# load Anaconda using the Python module
module load python/3
```

or
```bash
# load Conda using the Intel module
module load intel/oneAPI-2021
```

Alternatively, if you require a newer version of _Conda_ or just want more control, we suggest [installing _Miniconda_ locally](applications/python/miniconda).




