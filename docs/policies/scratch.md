# $SCRATCH Policies

The `$SCRATCH` (`/scratch/users/<username>`) filesystem is intended to be temporary,
high performance storage for running jobs.
It is not intended for persistent storage.
In order to maintain performance and stability for all users, the `$SCRATCH` has a
**60 day purge policy** where files older than 60 days will be permanently deleted.
Files are not backed up in `$SCRATCH`, so important data or scripts need to be moved to `/projects` directories (project directories are not backed up) `$HOME` directories (home directories have a 7 day rolling snapshot based backup) or
off of the HPC systems to be retained.

## Changes beginning July 1, 2026

- The 60 day purge policy on `$SCRATCH` will be automated.
- A quota of 50TB and 10,000,000 files per user will be added to `$SCRATCH`.

These changes are meant to improve the performance and availability of the
`$SCRATCH` storage space for all users.

### Planned 60 day purge policy automation rollout and methodology

In order to reduce stress on the HPC storage systems, the `$SCRATCH`
purge automations will begin by deleting the oldest files stored in
`$SCRATCH` over several weeks until the age of all remaining files
are within the 60-day limit.

#### Communications

- All users currently utilizing `$SCRATCH` storage space will receive
personalized emails summarizing their their usage with reminders of
the upcoming changes.
- At least 5 business days before the automated `$SCRATCH` purge begins,
users will be able to access a manifest of all files that will be deleted.

#### Tentative Schedule

Note, the schedule may be slowed or accelerated based on the observed load on
the HPC systems.

##### July 1

The `$SCRATCH` purge automation will begin deleting files that are over 2 years old.

##### July 6

The `$SCRATCH` purge automation will begin deleting files that are over 18 months old.

##### July 9

The `$SCRATCH` purge automation will begin deleting files that are over 12 months old.

##### July 15

The `$SCRATCH` purge automation will begin deleting files that are over 6 months old.

##### July 22

The `$SCRATCH` purge automation will begin deleting files that are over 90 days old.

##### August 3

The `$SCRATCH` purge automation will begin normal operation and will regularly delete files 60 days old.
In most cases, a manifest of eligible files will be generated on Sundays and deletion of the files on that
manifest will begin on the following Friday.

### Quotas

Quotas will be added on July 1, 2026 with the following limits, per user:

| Soft Quota (TB) | Hard Quota (GB) | Soft Quota (Filecount) | Hard Quota (Filecount) | Grace Period |
|-----------------|-----------------|------------------------|------------------------|--------------|
| 50 TB | 100 TB | 10,000,000 | 11,000,000 | 10 Days |

If an user exceeds a "Soft Quota" (50TB, 10,000,000 files) they will be able to temporarily exceed this quota,
up to the "Hard Quota" (100TB, 11,000,000 files) for up to the "Grace Period" (10 days).

When either the "Hard Quota" is reached or usage has been over the "Soft Quota" for more than the "Grace Period,"
it will not be possible to create or modify files until the user is under the "Soft Quota."
Once usage is below the "Soft Quota," the "Grace Period" will reset.

This structure is intended to allow running jobs to complete without being terminated
due to the quota and allow users time to clean up any excess files.
We will attempt to notify users that have exceeded the "Soft Quota" within 48 hours using
their SMU email address, but it is the responsibility of each user to monitor their own usage.

Users can see their recent usage on ColdFront under [personal storage usage](https://hpcaccess.smu.edu/usage/personal-storage)
or in real-time from the HPC systems with the command

```bash
lfs quota -h -p $(id -u) /scratch
```

#### Quota Exceptions

Exceptions to the quotas may be considered on a case-by-case basis.
Approval of any requests require documentation of at least:

- Your workflow and an explanation of why that workflow is not possible
with the default quota amounts.
- A plan and demonstrable process(es) for using the data within the 60 day purge policy.
Requests that cannot demonstrate that the data will be deleted, used, or moved off of
the HPC systems within 60 days will not be approved.
- Reasonable efforts have been made to reduce storage needs, such as using efficient output file formats
or compression.

## 60 Day Purge Policy

All files stored in the `$SCRATCH` (`/scratch/users/<username>`) are eligible to
be deleted without warning if they are over 60 days old.

### Age determination

Files will be determined to be over 60 days old if all of the following criteria are met:

1. The file's `atime` is greater than or equal to 60 days old.
2. The file's `mtime` is greater than or equal to 60 days old.

Definitions:

- `atime` is "access time" and it the last time the data from a file or directory was accessed (e.g. used directly by a process or through commands and scripts)
- `mtime` is "modification time" and it is the last time the file's contents where modified.

Attempts to circumvent the purge policy by modifying either the `atime` or `mtime` is a violation of policy and will be reported.

### Transparency

A manifest of files that are going to be deleted will be available at least 5 days
before the deletion occurs.
These manifests will typically be generated on Sundays.
When the files a deleted, a log of the deleted files will also be available.

We highly recommend reviewing these lists and moving any files you need to retain.

### Notifications

By default, users will be sent a notice when a new manifest of files is available
to their SMU email address.
User may opt out of these emails in ColdFront.
