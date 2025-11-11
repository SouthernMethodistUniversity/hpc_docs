# R Environments

Users who require versions of R or R packages packages that are not currently
installed on SMU HPC systems are encouraged to utilize custom virtual
environments. Virtual environments allow users to use specific versions of R
with the packages of their choice. Additionally, R environments increase
portability, which will help to ensure that R programs that run on SMU HPC
systems can also run on other machines with minimal changes. The primary way to 
create virtual environments is using a `conda` environment.

## Base R

The following creates and activates a base R installations with R version 4.4.3:

```
module load miniforge
mamba create -n r_env --channel conda-forge r-base=4.4.3
mamba activate r_env
```

```{note} 
Even though the newest version of R is usually available, it is recommend to step
back a version because not all compatible packages are available immediately for the newest
version of R. See the next section for more details on installing packages.
```

## R Packages

Once your `conda` environment is created, you can install packages either directly
through conda, or sometimes using the `install.packages()` function in R. Note that some packages
require linux libraries, and those will need to be installed using `conda`. The following
examples show how to install the `dplyr` package in both.

`````{tab-set}
````{tab-item} Install with conda

To find if you packages is available in `conda`, typically you can search the package name
with the `r-` prefix. For example, for `dplyr`, the `conda` version is `r-dplyr`. The following
will show you all the versions of the packag available:

```bash
conda search --override-channels --channel conda-forge r-dplyr
```

If it is available, the `conda` environment will usually resolve to the correct package version 
for your R installation:

```bash
module load miniforge
mamba activate r_env
mamba install --channel conda-forge r-dplyr
```

However, a specific package version can be installed by specifying it:

```bash
module load miniforge
mamba activate r_env
mamba install --channel conda-forge r-dplyr=1.1.4
```

You can check the version of an installed package with `packageVersion()`:

```bash
R -e "packageVersion('dplyr')"
```

````
````{tab-item} Install with install.packages()

```{warning}
This method is not recommended with `conda` environments. Only do this if installing with `conda` does not work.
```

You can run one line of R code with the `-e` flag:

```bash
module load miniforge
mamba activate r_env
R -e "install.packages('dplyr', repos = 'https://cloud.r-project.org/')"
```

Or you can launch R and use it as you would in a normal R console:

```bash
module load miniforge
mamba activate r_env
R
```

```r
install.packages("dplyr", repos = "https://cloud.r-project.org/")
```

````
`````

