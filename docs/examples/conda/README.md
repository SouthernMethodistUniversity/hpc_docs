# Conda and Mamba

:::{notice}
It is **not recommended** to use the [Anaconda Default Channels](https://docs.anaconda.com/free/anaconda/reference/default-repositories/). They are incompatible with `conda-forge` which is the basis of our system installations.
:::

:::{tip}
We recommend using Mamba (<https://mamba.readthedocs.io/en/latest/>).
It is a drop in replacement for Conda and is typically faster.
:::

Conda (https://docs.conda.io/projects/conda/en/stable/) and Mamba (<https://mamba.readthedocs.io/en/latest/>) are package management systems.

## Loading Conda and Mamba

### System Installation

We have a base install of Mamba and Conda from [Miniforge](https://github.com/conda-forge/miniforge) available as a module that can be accessed using, for example,

```bash
module load miniforge/24.11.2-1
```

The module will automatically load the shell and environment settings needed to use `conda` and `mamba` commands.

:::{note}
It is recommended to always include the version number when loading modules. Most modules will default to the most recent version if not specified, which may cause unexpected behaviors when new versions are installed.
:::

### User Installation

You can also install your own versions of Conda in your `$HOME` directory or a project directory.
We recommend:

- Micromamba: <https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html>
- Miniforge: <https://github.com/conda-forge/miniforge>

The first time you run Conda/Mamba, you will need to initialize it.
for example, this creates some shell functions in your profile to make it easier to call Mamba.

```bash
mamba init $(echo $SHELL | cut -c 6-)
```

After doing this, you may need to log out and log back in to see the effects.
In most cases, you can source your shell profile to avoid having to log out.
For most users, this is `source ~/.bashrc`.

We additionally recommend that you disable Conda/Mamba's auto-activate base
functionality. By default, Conda/Mamba will load a base environment, which can cause
issues with system dependencies. In particular, applications on
<https://hpc.m3.smu.edu><!-- Mentions M3 --> often behave in unexpected ways because it tries to
use a Conda package instead of the correct system package.
The next two commands tell Conda to prefer to save packages and environments
in your `$HOME` directory (you can specify other locations you have access to,
but performance is generally better in `$HOME`).

```bash
conda config --set auto_activate_base false
conda config --prepend envs_dirs $HOME/.conda/envs
conda config --prepend pkgs_dirs $HOME/.conda/pkgs
```

## Creating Virtual Environments from the Command Line

For simple environments with a small number of packages, you can create an
environment named `mamba_env`<!-- Mentions mamba_env --> (or any name of your choosing) in your `$HOME`
directory with
<!-- The code block below mentions mamba_env -->
```bash
mamba create -n mamba_env python=3.9 package1 package2 package3
```

The `-n` tells Mamba what to name the environment. Here, we request Python
version 3.9 and the packages `package1 package2 package3` which are the
packages you'd like to install (e.g. `numpy`, `tensorflow`, `pandas`, etc.). In
general, it is a good idea install all the packages at the same time because
Conda will do a better job of resolving dependencies.

## Creating Virtual Environments From environment.yml File

For environments that contain more than a few packages, we suggest creating a
`environment.yml` file (note, you can name the file anything you'd like, but it
is common practice to call it `environment.yml`.)

The basic structure of the `environment.yml` is:
<!-- The code block below mentions mamba_env -->
```text
name: mamba_env
channels:
  - conda-forge
dependencies:
  - python>=3.9
  - package1
  - package2
  - package3
  - pip
  - pip:
    - pip_package1
    - -r requirements.txt
```

The `name` field is what the created environment will be called (it can be
anything you like, but we again use the name `mamba_env`<!-- Mentions mamba_env --> for the example).

The next section is `channels`, which are the repositories where Mamba will
look for the requested packages. Mamba prioritizes the channels from the top
down, so in this case Mamba will prefer the package in `conda-forge` (typically the packages in the `conda-forge` are more up
to date.)

The next section is `dependencies` and this is where you should list all of the
packages you would like to install. If you have packages that need to be
installed with `pip`, you should include `pip` in the dependencies as above and
you can list the specific packages like the above as `pip_package1`, etc.
and/or you can have all the `pip` packages in a `requirements.txt` file.

Once you have made the `environment.yml` file, you can create the environment
with:
<!-- The code block below mentions mamba_env -->
```bash
mamba env create -f environment.yml -n mamba_env
```

### Examples

The following are examples of how you might start to build your environment
for a few different usage cases. These are the source files we use on 
the web portal, if you choose to build a custom environment from the form.

It is likely that these will not meet the needs of any specific use case,
but you can add or remove packages as needed for your particular needs.

- Example of an environment for *data science*, [datascience.yml](datascience.yml).
- Example of an environment for *bioinformatics*, [bioinformatics.yml](bioinformatics.yml).
- Example of an environment for *machine learning with SKLearn*, [sklearn.yml](sklearn.yml).
- Example of an environment for *R*, [r.yml](r.yml)

## Using the HPC Portal

If you are running interactive sessions through the portal using JupyterLab,
you need to have `JupyterLab` installed in your environment. If it is not, the
portal will not allow that environment to be used.

Your Mamba environment should appear in the drop down list of Python
Environments. If it is greyed out, that means that you need to install
JupyterLab in the environment.

### Using a base
<!-- The code block below mentions mamba_env -->
```bash
module load miniforge/24.11.2-1
mamba activate mamba_env
```

to the ```Custom environment settings``` field on the portal. It should look
like:

### Interactively from the terminal

If you are running programs interactively from the terminal (e.g. using
```srun```) just activate the virtual environment with
<!-- The code block below mentions mamba_env -->
```bash
module load miniforge/24.11.2-1
mamba activate mamba_env
```

in the terminal before running any commands.

### Using SBatch scripts

If you are running programs using _SBatch_ scripts, you should include the
activation command in your script:
<!-- The code block below mentions mamba_env -->
```bash
module load miniforge/24.11.2-1
mamba activate mamba_env
```

## Tips and reproducibility

- In general, you should not update packages inside a Conda/Mamba environment.
  Instead, you should make a new environment with the versions of the packages
  need and verify this works before removing any old environments that are not
  longer needed. This is especially true if you used `pip` to install anything.
- It is a good idea to include version numbers of the packages you want (if you
  know them). For example, in the above, we requested Python version 3.9 or
  newer. Being more specific can help speed up how long it takes to set up the
  environment because it will reduce the number of package version Mamba will
  consider.
- It is best to install all of the packages when you create the environment, if
  possible. Mamba will do a better job of resolving dependencies.
