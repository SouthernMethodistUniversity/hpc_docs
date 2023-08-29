# R Virtual Environments

## `renv` Basics

The [`renv`](https://rstudio.github.io/renv/) package helps create reproducible
environments for R projects.

There are a few core commands when using `renv`.

`renv::init()`: Initialize new project-local environment with a private R
                library

`renv::snapshot()`: Save the current state of the project library

`renv::restore()`: Restore the previously saved state of the project library,
                   e.g. reloading the environment on another machine

## GitHub and `renv` Demo

1.  Create new Git repository on GitHub
2.  Clone the new repository on the cluster
3.  Create new RStudio project in RStudio via the Portal
4.  Install `renv` if needed via `install.packages("renv")`
5.  Create clean package environment via `renv::init()`
6.  Quit and restart your R session.
7.  Install custom packages, e.g. `renv::install("rstan")`
8.  Create environment snapshot via
    `renv::snapshot(packages="mcmc")`
9.  Commit and push changes to the Git repository

