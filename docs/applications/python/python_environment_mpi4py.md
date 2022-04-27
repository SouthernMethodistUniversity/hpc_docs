# mpi4py in Python Environments

_mpi4py_ and some other packages that depend on system configurations should
be installed with ```pip install``` whenever possible and not with ```conda install```.
In both cases, the packages will work, but they may not take advantage of
system specific configurations, such as the Infiniband network.

## Example

For example consider the following virtual environments, one using ```pip install```
and one using ```conda install```.

<!-- tabs:start -->
#### **pip install**
```bash

# load Intel compilers, which include a version of Python and an MPI compiler
module load intel

# create a virtual environment named venv_mpi4py
python -m venv ~/venv_mpi4py

# upgrade pip
pip install --upgrade pip

# make sure we're using the correct MPI compiler
export MPICC=$(which mpicc)

# install mpi4py, the flags --no-binary :all: --compile 
# tell pip not to use a precompiled version
pip install --no-binary :all: --compile mpi4py
```

#### **conda install**
```bash
# load version of Python that has Conda in it
module load python/3

# create a virtual environment named conda_mpi4py that uses Python 3.9 
# and installs mpi4py
conda create -p $HOME/conda_mpi4py mpi4py python=3.9 
```

<!-- tabs:end -->

The difference between the two environments can be seen by running 
a simple bandwidth test, such as [mpi4py_benchmark](https://github.com/felker/mpi4py_benchmark).
This test can be run using the following scripts:

<!-- tabs:start -->
#### **pip install**

```bash
#!/bin/bash
#SBATCH --partition=standard-mem-s  # use standarm memory short queue
#SBATCH -N 2                        # request 2 nodes
#SBATCH -o pip_mpi4py_test.txt      # specify output location
#SBATCH --ntasks-per-node=1         # request 1 task on each node
#SBATCH -t 00:05:00                 # request 5 minutes
#SBATCH --mem=1G                    # request 1 GB

# load modules
module purge
module load intel

# activate environment
source $HOME/venv_mpi/bin/activate

# run test
srun python osu_bw.py
```

#### **conda install**
```bash
#!/bin/bash
#SBATCH --partition=standard-mem-s    # use standarm memory short queue
#SBATCH -N 2                          # request 2 nodes
#SBATCH -o conda_mpi4py_test.txt      # specify output location
#SBATCH --ntasks-per-node=1           # request 1 task on each node
#SBATCH -t 00:05:00                   # request 5 minutes
#SBATCH --mem=1G                      # request 1 GB

# load modules
module purge
module load python/3

# activate the environment
eval "$(conda shell.bash hook)"
conda activate $HOME/conda_mpi4py

# run test
mpirun python osu_bw.py
```

<!-- tabs:end -->

A truncated sample of the results from running both the scripts is (higher bandwidth is better).
Notice that the ```pip install``` version is 5-7 times faster than the ```conda install``` in this
example. This difference can be even more drastic in more complicated applications and can have a
serious performance impact, especially on communication bound applications.

```txt
# MPI Bandwidth Test
# Size [B]    Bandwidth [MB/s] (pip)    Bandwidth [MB/s] (conda)
65536                       10231.65                     1502.74
131072                      10927.86                     1837.19
262144                      11226.46                     2112.31
524288                      11558.91                     2187.85
1048576                     11815.73                     2234.20
2097152                     11926.97                     2239.13
4194304                     11996.23                     2008.81
8388608                     11816.54                     1826.22
16777216                    11337.77                     1806.65
33554432                    11202.05                     1781.83
67108864                    11122.19                     1818.52
134217728                   11073.34                     1710.29
```

## Work Arounds Using Conda

If you want or need to use Conda environments, it often is beneficial to
create an environment in the following order:

1. Load the MPI compiler modules you would like to use
2. Create a Conda environment with all the packages that do not dependent on MPI and also install the ```pip``` package.
3. Use ```pip``` to install ```mpi4py``` as in the above example inside the environment.
4. Install the remaining packages that you require using ```conda install``` inside the environmnet.
5. Install any remaining packages that you require using ```pip install```

The resulting environment should be thouroughly tested to ensure it works as expected.
Since _Conda_ is not aware of packages installed with _pip_ this method can result in broken dependencies, which may make the environment unusuable.
