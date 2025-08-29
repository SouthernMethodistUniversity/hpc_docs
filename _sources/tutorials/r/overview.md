# R

## System-wide Installations

````{tab-set}
```{tab-item} M3
There are several versions of R already installed on M3 that can be
accessed through the `module` system. These R versions are accessible from the
command line as well as through RStudio on the [HPC OnDemand Web Portal](https://hpc.m3.smu.edu/).

From the command line, current R versions can be seen with `module spider R`. To
load a specific version of R (e.g. R/4.5.1), you can use `module load R/4.5.1`.

There are a handful of common R packages already installed system-wide with
these versions, but additional packages can be installed per user with the
traditional `install.packages()` command. This only needs to be done once per user
per R version.
```
```{tab-item} SuperPOD
There are not currently any system-wide installations of R on the SuperPOD. Please
see the next section for options.
```
````


## Other R Versions

Users who require versions of R or R packages packages that are not currently
installed on SMU HPC systems are encouraged to utilize custom virtual
environments. Virtual environments allow users to use specific versions of R
with the packages of their choice. Additionally, R environments increase
portability, which will help to ensure that R programs that run on SMU HPC
systems can also run on other machines with minimal changes. The primary way to 
create virtual environments is using a `conda` environment. Please see 
[R Environments](/tutorials/r/environments.md) for more details.

