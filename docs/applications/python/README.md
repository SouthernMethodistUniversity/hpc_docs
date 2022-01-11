# Python

## Installing Python Packages  {docsify-ignore}

Users who require Python packages that are not currently installed on M2
are encouraged to utilize custom virtual environments. Virtual environments
allow users to use specific versions of Python with the packages of their
choice. Additionally, Python environments are increase portability, which
will help to ensure that Python programs that run on M2 can also run on
other machines with minimal changes.

There are two primary ways to create virtual environments: using Python\'s
native virtual environments or using _Conda_ environments.

There are benefits and downsides to each of the methods, but with a few exceptions, the main difference is user preference. In general, the thing to remember is that _Conda_ installs precompiled packages and manages dependencies while _Python_ environments typically compile packages and rely on the user to maintain dependencies. This means that _Conda_ environments are _sometimes_ easier to set up, but _Python_ environments are _sometimes_ more efficient and dependent on user package management.

One of the notable exceptions occurs when using ```mpi4py```. In this case, the performance can be severely impacted by using _Conda_, especially for communication heavy applications. See the[instructions for mpi4py](applications/python/python_venvs) for more details.

## Instructions for setting up virtual environments  {docsify-ignore}

We encourage users to try setting up environments using the following methods and choose the one that they are most comfortable with.

Instructions for [Python virtual environments](applications/python/python_venvs)

Instructions for [Conda virtual environments for Python](applications/python/conda_envs)

## Example Environments  {docsify-ignore}

In addition to the instructions above, the following environments represent some of the common usages we see from users. These might not be exactly what you need, but hopefully they provide a good starting place.

If you need help setting up environments, feel free to reach out to the [HPC support team for help](services/help.md).