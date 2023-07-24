# Rewriting Spack generated rpaths

Spack sometimes uses system installed libraries to build packages (usually because we told it to.)
This can result in Spack installed packages pointing to an old or incorrect library version.

For example, we do not allow Spack to install `UCX` and some other packages (like `SLURM`) because
they either need to be the same for all users and/or system performance depends on specific build
settings so there is no advantage to letting Spack manage these.

## Example usage: UCX

On our system we have symlinks pointing to the current version of `UCX`;
however, some libraries, like `openmpi` resolve those symlinks. So changing
the system version of `UCX` may require updating rpaths for some libraries
that depend on `UCX`

```bash
# source / load spack
# local: . ~/repos/spack/share/spack/setup-env.sh
module load spack

# load patchelf if it is not available on the system (installable via spack)
module load gcc-11.2.0/patchelf

# run the python script
python update_rpaths.py ucx -v -n /hpc/sys/apps/ucx/1.13.1.mt

```

The `-v` flag turns on verbose. The `-n /path/` flag tells the script what the new path should be.
In this case, we are looking for all the packages that depend on `UCX` (note if there are multiple
versons, you can specify them with the usual spack versioning, e.g. `ucx@1.13.1` or `ucx /6n5vfma`.)
When it finds packages that depend on `UCX` if will update the set `RPATH` to link to libraries
located in `/hpc/sys/apps/ucx/1.13.1.mt`.

There is a `--dryrun` option that will run and output everything, but will not update any rpaths.

The script will generate a `tar.gz` backup of all the files the have `RPATH` values being updated
and these files can be restored using, e.g.

```bash
python update_rpaths.py --restore backup.tar.gz
```
 
