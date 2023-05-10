# M3 Migration

The following outlines important changes for M3 and the SuperPod.

## Purge Policy

Data stored in `$SCRATCH` on M3 or the SuperPod has a time based quota.
Data older than 60 days will be purged (deleted) without warning.
`$SCRATCH` is intended as high performance, temporary storage for jobs.

If data is needed for a longer period of time, it should be stored in
`$WORK` (8 TB limit) or `$HOME` directories (200 GB). If those are also
insuffiencient, please contact us to discuss options.

## Access

Access is described in greate detail on the [access page](access.md).
For most users, it will be sufficient to change `m2` to `m3` in `ssh`
and similar commands (if you use keys, you will need to set those up for M3.)

The web portal will temporarily be located at [hpc.m3.smu.edu](https://hpc.m3.smu.edu/).

## File Access

### M2 $HOME directory

Your M2 `$HOME` directory is temporarily available on M3 at `$M2HOME`.
This is only available on the login nodes and is read only. **Please 
copy any files you need to keep to M3**

Approximately 60 days after migration is complete, access to these files
will no longer be possible. Communications about the shutdown of M2 storage
will provide ample warning.

### M2 $WORK directory

Your M2 `$WORK` directory was copied to M3 as part of the migration
process. Any file you had in `$WORK` on M2 should be in `$WORK` on M3.

### M2 $SCRATCH directory

Your M2 `$SCRATCH` directory is temporarily available on M3 at `$M2SCRATCH`.
This is only available on the login nodes and is read only. **Please
copy any files you need to keep to M3**

Approximately 60 days after migration is complete, access to these files
will no longer be possible. Communications about the shutdown of M2 storage
will provide ample warning. 

## Applications

We're working hard on installing software. If you find that a something you need
is missing, please let us know.

### Python and R

NOTE: we will not be installing specific Python or R packages at a system level
for individual users. Instead, users should set up their own environments with
the specific packages they need. If you require help with this, please let us know.

## Suggestions for making the most of M3

- make sure any paths you have in scripts are still correct
- Recompile performance critical applications. M3 uses AMD CPUs (M2 used Intel.)
- Rebuild environments. While it is possible you can copy environments and they 
will work, you may get a performance boost by rebuilding them.
- Ask for help if you run into issues. This is a new system and some of the edges
are still a bit rough

## GPU access

M3 is a CPU only machine. After transition, only GPUs on the SuperPOD will be
accessible.

At this time, the SuperPOD is not accesible by a web portal. 
