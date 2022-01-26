# R

## Installing R and R Packages {docsify-ignore}

Users who require versions of R or R packages packages that are not currently installed on M2
are encouraged to utilize custom virtual environments. Virtual environments
allow users to use specific versions of R with the packages of their
choice. Additionally, R environments are increase portability, which
will help to ensure that R programs that run on M2 can also run on
other machines with minimal changes.

There are two primary ways to create virtual environments: using _renv_ or using _Conda_ environments.

There are benefits and downsides to each of the methods, but with a few exceptions, the main difference is user preference. In general, the thing to remember is that _Conda_ installs precompiled packages and manages dependencies while _renv_ environments typically compile packages and rely on the user to maintain dependencies. This means that _Conda_ environments are _sometimes_ easier to set up, but _renv_ environments are _sometimes_ more efficient and dependent on user package management.

## Instructions for setting up virtual environments {docsify-ignore}

We encourage users to try setting up environments using the following methods and choose the one that they are most comfortable with.

Instructions for [R virtual environments](applications/r/renvs)

Instructions for [Conda virtual environments for R](applications/r/conda_envs)

## Example Environments {docsify-ignore}

In addition to the instructions above, the following environments represent some of the common usages we see from users. These might not be exactly what you need, but hopefully they provide a good starting place.

If you need help setting up environments, feel free to reach out to the [HPC support team for help](services/help.md).
