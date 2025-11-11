# Migrating Environments

:::{important}
Many environments were created, by default, in user `$WORK` directories, which are deprecated as of January 15, 2025. Users with Conda environments they would like to keep using need to move or rebuild existing environments in a storage allocation created in ColdFront or their `$HOME` directory before August 15, 2025. Below are recommended ways to do this.
:::

To see your existing environments, using the command `mamba env list`. Any projects that are in a subdirectory of `/lustre/work/client/users/[YOUR USERNAME]` will need to be moved or rebuilt if you are going to continue using them. We recommend always building your conda environment in the appropriate ColdFront storage allocation it is associated with. We do not recommend building environments in your `$HOME` directory because it is limited to 200GB of space. 

## Current Environments

To get a list of dependencies and pip installed packages for an existing environment, run this command to save that list into an `environment.yml` file:

```bash
module load miniforge
mamba env export --no-builds -n mamba_env | grep -v "prefix" > environment.yml
```

## Rebuild in a Storage Allocation

To rebuild that environment in another directory:

```bash
mamba env create -f environment.yml -p /projects/[PI USERNAME]/[PROJECT DIRECTORY]/[STORAGE ALLOC DIRECTORY]/.conda/envs/mamba_env
```

```{note}
If this process does not work immediately, try removing versions numbers from packages within the `environment.yml` file before rebuilding it.
```

To use the new environment:

```bash
module purge
module load miniforge
mamba activate /projects/[PI USERNAME]/[PROJECT DIRECTORY]/[STORAGE ALLOC DIRECTORY]/.conda/envs/mamba_env
```

## Rebuild in `$HOME`

If you have not done so already, first make $HOME the default location for environments:

```bash
module load miniforge
conda config --set auto_activate_base false
conda config --prepend envs_dirs $HOME/.conda/envs
conda config --prepend pkgs_dirs $HOME/.conda/pkgs
```

To rebuild you environment in `$HOME`:

```bash
mamba env create -f environment.yml -p $HOME/.conda/envs/mamba_env
```

```{note}
If this process does not work immediately, try removing versions numbers from packages within the `environment.yml` file before rebuilding it.
```

To use the new environment:

```bash
module purge
module load miniforge
mamba activate -p $HOME/.conda/envs/mamba_env
```

## Testing and Removing from `$WORK`

Once you have tested your new environment to ensure it is working, please delete the environment from `$WORK` using:

```bash
mamba remove -p /lustre/work/client/users/[YOUR USERNAME]/.conda/envs/mamba_env/ --all
```
