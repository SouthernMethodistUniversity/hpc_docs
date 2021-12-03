# Python

## Installing Python Packages

Users who require Python packages that are not currently installed on M2
are encouraged to utilize custom Python environments. Python environments
allow users to use specific versions of Python with the packages of their
choice. Additionally, Python environments are generally portable, which
will help to ensure that Python programs that run on M2 can also run on
other machines with minimal changes.

There are two primary ways to create virtual environments: using Python\'s
native vitrual environments or using _Conda_ environemnts.

<!-- tabs:start -->
#### **Python Virtual Environments**

The general idea is to do the following from a terminal (either by using SSH to
access M2 or from a terminal in an interactive session via the portal hpc.smu.edu):

In the terminal:

1. module load python/3
2. module load gcc-9.2
3. python -m venv ~/python_env
4. source ~/python_env/bin/activate
5. pip install --upgrade pip
6. pip install \<python packages\>
7. deactivate

The above does the following:

1. Load a version of Python 3 that is already installed on M2
2. Load a newer version of the gcc compilers. The default compiler is too old to install many python packages. You can use any compiler you prefer, but it is generally worth using a more recent version.
3. Creates a virtual environment called “python_env” in your home directory (you can call it whatever you’d like)
4. Turns on the python environment, so you’ll now be working inside that instead of the default environment. You need to do this because we don’t let users install things in the base environment because it breaks things for other people.
5. Upgrade pip to make sure it finds recent versions of packages
6. Install whatever python packages you need to the virtual environment
7. Exit the virtual environment

#### **Conda Environments**

for conda

<!-- tabs:end -->

